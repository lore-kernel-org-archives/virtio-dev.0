Return-Path: <jean-philippe@linaro.org>
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] virtio-iommu: Rework the bypass feature
Date: Thu, 30 Sep 2021 17:35:04 +0100
Message-Id: <20210930163503.51200-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: virtio-dev@lists.oasis-open.org, eric.auger@redhat.com
Cc: sebastien.boeuf@intel.com, kevin.tian@intel.com, cohuck@redhat.com, mst@redhat.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

The VIRTIO_IOMMU_F_BYPASS feature is awkward to use and incomplete.
Although it is implemented by QEMU, it is not supported by any driver as
far as I know. Replace it with a new VIRTIO_IOMMU_F_BYPASS_CONFIG
feature. The old feature bit is deprecated and will be recycled once
versions of QEMU that implement it are not distributed anymore.

Two features are missing from virtio-iommu:

* The ability for an hypervisor to start the device in bypass mode. The
  wording for VIRTIO_IOMMU_F_BYPASS is not clear enough to allow it at
  the moment.

* The ability for a guest to set individual endpoints in bypass mode
  when bypass is globally disabled. An OS should have the ability to
  allow only endpoints it trusts to bypass the IOMMU, while keeping DMA
  disabled for endpoints it isn't even aware of. At the moment this can
  only be emulated by creating identity mappings.

The VIRTIO_IOMMU_F_BYPASS_CONFIG feature adds a 'bypass' config field
that allows to enable and disable bypass globally. It also adds a new
flag for the ATTACH request.

* The hypervisor can start the VM with bypass enabled or, if it knows
  that the software stack supports it, disabled. The 'bypass' config
  fields resets to 0 or 1.

* Generally the firmware won't have an IOMMU driver and will need to be
  started in bypass mode, so the bootloader and kernel can be loaded
  from storage endpoint.

  For more security, the firmware could implement a minimal virtio-iommu
  driver that reuses existing virtio support and only touches the config
  space. It could enable PCI bus mastering in bridges only for the
  endpoints that need it, enable global IOMMU bypass by flipping a bit,
  then tear everything down before handing control over to the OS. This
  prevents vulnerability windows where a malicious endpoint reprograms
  the IOMMU while the OS is configuring it [1].

  The isolation provided by vIOMMUs has mainly been used for securely
  assigning endpoints to untrusted applications so far, while kernel DMA
  bypasses the IOMMU. But we can expect boot security to become as
  important in virtualization as it presently is on bare-metal systems,
  where some devices are untrusted and must never be able to access
  memory that wasn't assigned to them.

* The OS can enable and disable bypass globally. It can then enable
  bypass for individual endpoints by attaching them to bypass domains,
  using the new VIRTIO_IOMMU_ATTACH_F_BYPASS flag. It can disable bypass
  by attaching them to normal domains.

[1] IOMMU protection against I/O attacks: a vulnerability and a proof of concept
    Morgan, B., Alata, É., Nicomette, V. et al.
    https://link.springer.com/article/10.1186/s13173-017-0066-7

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
The virtio-iommu spec with colored diff is available at
https://jpbrucker.net/virtio-iommu/spec-bypass/virtio-iommu-f-bypass-config-v1-diff.pdf

Apologies for the poorly thought out VIRTIO_IOMMU_F_BYPASS. I didn't
spend enough time on it and ignored valuable suggestions.
---
 virtio-iommu.tex | 69 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 16 deletions(-)

diff --git a/virtio-iommu.tex b/virtio-iommu.tex
index efa735b..a2c90ea 100644
--- a/virtio-iommu.tex
+++ b/virtio-iommu.tex
@@ -59,14 +59,19 @@ \subsection{Feature bits}\label{sec:Device Types / IOMMU Device / Feature bits}
   VIRTIO_IOMMU_F_MAP_UNMAP is supported.}
 
 \item[VIRTIO_IOMMU_F_BYPASS (3)]
-  When not attached to a domain, endpoints downstream of the IOMMU
-  can access the guest-physical address space.
+  This feature is deprecated.
 
 \item[VIRTIO_IOMMU_F_PROBE (4)]
   The PROBE request is available.
 
 \item[VIRTIO_IOMMU_F_MMIO (5)]
   The VIRTIO_IOMMU_MAP_F_MMIO flag is available.
+
+\item[VIRTIO_IOMMU_F_BYPASS_CONFIG (6)]
+  The global bypass state is described in \field{bypass} of
+  struct virtio_iommu_config. The domain bypass state is
+  described by VIRTIO_IOMMU_ATTACH_F_BYPASS.
+
 \end{description}
 
 \drivernormative{\subsubsection}{Feature bits}{Device Types / IOMMU Device / Feature bits}
@@ -97,12 +102,19 @@ \subsection{Device configuration layout}\label{sec:Device Types / IOMMU Device /
     le32 end;
   } domain_range;
   le32 probe_size;
+  u8 bypass;
+  u8 reserved[3];
 };
 \end{lstlisting}
 
 \drivernormative{\subsubsection}{Device configuration layout}{Device Types / IOMMU Device / Device configuration layout}
 
-The driver MUST NOT write to device configuration fields.
+When the VIRTIO_IOMMU_F_BYPASS_CONFIG feature is negotiated, the
+driver MAY write to \field{bypass}. The driver MUST NOT write to
+any other device configuration field.
+
+If field \field{bypass} contains a value different than 0 or 1,
+the driver SHOULD treat it as 0.
 
 \devicenormative{\subsubsection}{Device configuration layout}{Device Types / IOMMU Device / Device configuration layout}
 
@@ -110,16 +122,24 @@ \subsection{Device configuration layout}\label{sec:Device Types / IOMMU Device /
 the page granularity. The device MAY set more than one bit in
 \field{page_size_mask}.
 
+If the driver writes a value different than 0 or 1 in
+\field{bypass}, the device SHOULD treat it as 0.
+
 \subsection{Device initialization}\label{sec:Device Types / IOMMU Device / Device initialization}
 
 When the device is reset, endpoints are not attached to any domain.
 
-If the VIRTIO_IOMMU_F_BYPASS feature is negotiated, all accesses from
-unattached endpoints are allowed and translated by the IOMMU using the
-identity function. If the feature is not negotiated, any memory access
-from an unattached endpoint fails. Upon attaching an endpoint in
-bypass mode to a new domain, any memory access from the endpoint fails,
-since the domain does not contain any mapping.
+An endpoint is in bypass mode if the VIRTIO_IOMMU_F_BYPASS_CONFIG
+feature is offered and:
+\begin{itemize}
+  \item config field \field{bypass} is 1 and the endpoint is not
+    attached to a domain, or
+  \item the endpoint is attached to a domain with
+    VIRTIO_IOMMU_ATTACH_F_BYPASS.
+\end{itemize}
+
+All accesses from an endpoint in bypass mode are allowed and
+translated by the IOMMU using the identity function.
 
 Future devices might support more modes of operation besides MAP/UNMAP.
 Drivers verify that devices set VIRTIO_IOMMU_F_MAP_UNMAP and fail
@@ -136,8 +156,8 @@ \subsection{Device initialization}\label{sec:Device Types / IOMMU Device / Devic
 
 \devicenormative{\subsubsection}{Device Initialization}{Device Types / IOMMU Device / Device Initialization}
 
-If the driver does not accept the VIRTIO_IOMMU_F_BYPASS feature, the
-device SHOULD NOT let endpoints access the guest-physical address space.
+The device SHOULD NOT let unattached endpoints that are not in
+bypass mode access the guest-physical address space.
 
 \subsection{Device operations}\label{sec:Device Types / IOMMU Device / Device operations}
 
@@ -266,9 +286,12 @@ \subsubsection{ATTACH request}\label{sec:Device Types / IOMMU Device / Device op
   struct virtio_iommu_req_head head;
   le32 domain;
   le32 endpoint;
-  u8   reserved[8];
+  le32 flags;
+  u8   reserved[4];
   struct virtio_iommu_req_tail tail;
 };
+
+#define VIRTIO_IOMMU_ATTACH_F_BYPASS  (1 << 0)
 \end{lstlisting}
 
 Attach an endpoint to a domain. \field{domain} uniquely identifies a
@@ -294,6 +317,10 @@ \subsubsection{ATTACH request}\label{sec:Device Types / IOMMU Device / Device op
 attached to a single domain at a time. Endpoints attached to different
 domains are isolated from each other.
 
+When the VIRTIO_IOMMU_F_BYPASS_CONFIG is negotiated, the driver
+can set the VIRTIO_IOMMU_ATTACH_F_BYPASS flag to create a bypass
+domain. Endpoints attached to this domain are in bypass mode.
+
 \drivernormative{\paragraph}{ATTACH request}{Device Types / IOMMU Device / Device operations / ATTACH request}
 
 The driver SHOULD set \field{reserved} to zero.
@@ -301,11 +328,20 @@ \subsubsection{ATTACH request}\label{sec:Device Types / IOMMU Device / Device op
 The driver SHOULD ensure that endpoints that cannot be isolated from each
 other are attached to the same domain.
 
+If the domain already exists and is a bypass domain, the driver
+SHOULD set the VIRTIO_IOMMU_ATTACH_F_BYPASS flag. If the domain
+exists and is not a bypass domain, the driver SHOULD NOT set the
+VIRTIO_IOMMU_ATTACH_F_BYPASS flag.
+
 \devicenormative{\paragraph}{ATTACH request}{Device Types / IOMMU Device / Device operations / ATTACH request}
 
 If the \field{reserved} field of an ATTACH request is not zero, the device
 MUST reject the request and set \field{status} to VIRTIO_IOMMU_S_INVAL.
 
+If the device does not recognize a \field{flags} bit, it MUST
+reject the request and set \field{status} to
+VIRTIO_IOMMU_S_INVAL.
+
 If the endpoint identified by \field{endpoint} doesn't exist, the device
 MUST reject the request and set \field{status} to VIRTIO_IOMMU_S_NOENT.
 
@@ -343,10 +379,7 @@ \subsubsection{DETACH request}
 \end{lstlisting}
 
 Detach an endpoint from a domain. When this request completes, the
-endpoint cannot access any mapping from that domain anymore. If feature
-VIRTIO_IOMMU_F_BYPASS has been negotiated, then once this request
-completes all accesses from the endpoint are allowed and translated by the
-IOMMU using the identity function.
+endpoint cannot access any mapping from that domain anymore.
 
 After all endpoints have been successfully detached from a domain, it
 ceases to exist and its ID can be reused by the driver for another domain.
@@ -433,6 +466,8 @@ \subsubsection{MAP request}\label{sec:Device Types / IOMMU Device / Device opera
 
 The driver SHOULD set undefined \field{flags} bits to zero.
 
+The driver SHOULD NOT send MAP requests on a bypass domain.
+
 \field{virt_end} MUST be strictly greater than \field{virt_start}.
 
 The driver SHOULD set the VIRTIO_IOMMU_MAP_F_MMIO flag when the physical
@@ -538,6 +573,8 @@ \subsubsection{UNMAP request}\label{sec:Device Types / IOMMU Device / Device ope
 or be outside any mapping. The last address of a range MUST either be the
 last address of a mapping or be outside any mapping.
 
+The driver SHOULD NOT send UNMAP requests on a bypass domain.
+
 \devicenormative{\paragraph}{UNMAP request}{Device Types / IOMMU Device / Device operations / UNMAP request}
 
 If the \field{reserved} field of an UNMAP request is not zero, the device
-- 
2.33.0

