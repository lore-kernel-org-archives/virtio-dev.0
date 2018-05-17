Return-Path: virtio-dev-return-4089-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 685E75819177
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 May 2018 06:06:24 -0700 (PDT)
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Thu, 17 May 2018 09:06:04 -0400
Message-Id: <20180517130604.9036-2-venu.busireddy@oracle.com>
In-Reply-To: <20180517130604.9036-1-venu.busireddy@oracle.com>
References: <20180517130604.9036-1-venu.busireddy@oracle.com>
Subject: [virtio-dev] [PATCH 1/1] Allow "Vendor Specific" extension to virtio PCI capabilities.
To: venu.busireddy@oracle.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Add VIRTIO_PCI_CAP_VENDOR_EXT_CFG to the virtio PCI capabilities to
allow vendors to define vendor specific extension.

Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
---
 content.tex | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/content.tex b/content.tex
index 7a92cb1..406bfe6 100644
--- a/content.tex
+++ b/content.tex
@@ -599,6 +599,8 @@ The fields are interpreted as follows:
 #define VIRTIO_PCI_CAP_DEVICE_CFG        4
 /* PCI configuration access */
 #define VIRTIO_PCI_CAP_PCI_CFG           5
+/* Vendor Specific Extension */
+#define VIRTIO_PCI_CAP_VENDOR_EXT_CFG    6
 \end{lstlisting}
 
         Any other value is reserved for future use.
@@ -997,6 +999,47 @@ address \field{cap.length} bytes within a BAR range
 specified by some other Virtio Structure PCI Capability
 of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
 
+\subsubsection{Vendor Specific Extension capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Vendor Specific Extension capability}
+
+The VIRTIO_PCI_CAP_VENDOR_EXT_CFG capability
+provides means for vendors to define any vendor specific extension to the virtio specification.
+
+The capability is immediately followed by an arbitrary amount of data as below:
+
+\begin{lstlisting}
+struct virtio_pci_vendor_ext_cap {
+        struct virtio_pci_cap cap;
+        u8 vendor_specific_data[]; /* Vendor specific data. */
+};
+\end{lstlisting}
+
+The fields \field{cap.bar}, \field{cap.length}, \field{cap.offset} and
+\field{vendor_specific_data} are read-only for the driver.
+
+The specification does not impose any restrictions on the size or
+structure of vendor_specific_data[]. Vendors are free to declare this
+array as large as needed, as long as the combined size of all capabilities
+can be accommodated within the PCI configuration space.
+
+If there is enough room in the PCI configuration space to accommodate
+the vendor specific data, the fields \field{cap.bar}, \field{cap.offset}
+and \field{cap.length} should be set to 0.
+
+If there isn't enough room, some or all of the data can be presented
+in the BAR region, in which case the fields \field{cap.bar},
+\field{cap.offset} and \field{cap.length} should be set appropriately.
+
+In either case, the field \field{cap.cap_len} indicates the length of
+the data present in the configuration space itself.
+
+\devicenormative{\paragraph}{Vendor Specific Extension capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Vendor Specific Extension capability}
+
+The device may or may not present the VIRTIO_PCI_CAP_VENDOR_EXT_CFG capability.
+
+\drivernormative{\paragraph}{Vendor Specific Extension capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Vendor Specific Extension capability}
+
+The driver MUST NOT write to vendor_specific_data[] area or the BAR region.
+
 \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
 
 Transitional devices MUST present part of configuration

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

