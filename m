Return-Path: <mst@redhat.com>
Date: Fri, 12 Aug 2022 13:19:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v7 5/8] MMIO: disallow using admin vq bit
Message-ID: <20220812171841.12183-6-mst@redhat.com>
References: <20220812171841.12183-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220812171841.12183-1-mst@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, eperezma@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 conformance.tex | 1 +
 content.tex     | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/conformance.tex b/conformance.tex
index c3c1d3e..161b5e0 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -383,6 +383,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 An MMIO device MUST conform to the following normative statements:
 
 \begin{itemize}
+\item \ref{devicenormative:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Device Initialization}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout}
 \end{itemize}
 
diff --git a/content.tex b/content.tex
index 297cb4a..76b5a28 100644
--- a/content.tex
+++ b/content.tex
@@ -2079,6 +2079,11 @@ \subsection{MMIO-specific Initialization And Device Operation}\label{sec:Virtio
 
 \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Device Initialization}
 
+\devicenormative{\paragraph}{Device Initialization}{Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Device Initialization}
+
+Device MUST NOT set bit VIRTIO_F_ADMIN_VQ (bit 41) in
+DeviceFeatures.
+
 \drivernormative{\paragraph}{Device Initialization}{Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Device Initialization}
 
 The driver MUST start the device initialization by reading and
@@ -2093,6 +2098,9 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 Further initialization MUST follow the procedure described in
 \ref{sec:General Initialization And Device Operation / Device Initialization}~\nameref{sec:General Initialization And Device Operation / Device Initialization}.
 
+Driver MUST NOT set bit VIRTIO_F_ADMIN_VQ (bit 41) in
+DriverFeatures even if offered by the device.
+
 \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Virtqueue Configuration}
 
 The driver will typically initialize the virtual queue in the following way:
-- 
MST

