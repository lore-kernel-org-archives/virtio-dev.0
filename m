Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v2 14/20] virtio-iommu: Maintain iommu device spec in separate directory
Date: Mon, 9 Jan 2023 18:28:43 +0200
Message-ID: <20230109162849.463101-15-parav@nvidia.com>
In-Reply-To: <20230109162849.463101-1-parav@nvidia.com>
References: <20230109162849.463101-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Place device specification, its driver and device
conformance into its own directory to have self contained device
specification.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v1->v2:
- rebased
v0->v1:
- new patch
---
 conformance.tex                               | 37 +------------------
 content.tex                                   |  2 +-
 .../virtio-iommu/device-conformance.tex       | 16 ++++++++
 .../virtio-iommu/device.tex                   |  0
 .../virtio-iommu/driver-conformance.tex       | 17 +++++++++
 5 files changed, 36 insertions(+), 36 deletions(-)
 create mode 100644 device-types/virtio-iommu/device-conformance.tex
 rename virtio-iommu.tex =3D> device-types/virtio-iommu/device.tex (100%)
 create mode 100644 device-types/virtio-iommu/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index c109fbd..88ae166 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -145,24 +145,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-vsock/}{driver-conformance}
 \import{device-types/virtio-fs/}{driver-conformance}
 \import{device-types/virtio-rpmb/}{driver-conformance}
-
-\conformance{\subsection}{IOMMU Driver Conformance}\label{sec:Conformance =
/ Driver Conformance / IOMMU Driver Conformance}
-
-An IOMMU driver MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{drivernormative:Device Types / IOMMU Device / Feature bits}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device configurat=
ion layout}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device Initializa=
tion}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / ATTACH request}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / DETACH request}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / MAP request}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / UNMAP request}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / PROBE request}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / PROBE properties / RESVMEM}
-\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / Fault reporting}
-\end{itemize}
+\import{device-types/virtio-iommu/}{driver-conformance}
=20
 \conformance{\subsection}{Sound Driver Conformance}\label{sec:Conformance =
/ Driver Conformance / Sound Driver Conformance}
=20
@@ -305,23 +288,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-vsock/}{device-conformance}
 \import{device-types/virtio-fs/}{device-conformance}
 \import{device-types/virtio-rpmb/}{device-conformance}
-
-\conformance{\subsection}{IOMMU Device Conformance}\label{sec:Conformance =
/ Device Conformance / IOMMU Device Conformance}
-
-An IOMMU device MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / IOMMU Device / Feature bits}
-\item \ref{devicenormative:Device Types / IOMMU Device / Device configurat=
ion layout}
-\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
}
-\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / ATTACH request}
-\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / DETACH request}
-\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / MAP request}
-\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / UNMAP request}
-\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / PROBE request}
-\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / PROBE properties / RESVMEM}
-\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / Fault reporting}
-\end{itemize}
+\import{device-types/virtio-iommu/}{device-conformance}
=20
 \conformance{\subsection}{Sound Device Conformance}\label{sec:Conformance =
/ Device Conformance / Sound Device Conformance}
=20
diff --git a/content.tex b/content.tex
index 0150e3f..dfc8967 100644
--- a/content.tex
+++ b/content.tex
@@ -3015,7 +3015,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \import{device-types/virtio-vsock/}{device}
 \import{device-types/virtio-fs/}{device}
 \import{device-types/virtio-rpmb/}{device}
-\input{virtio-iommu.tex}
+\import{device-types/virtio-iommu/}{device}
 \input{virtio-sound.tex}
 \input{virtio-mem.tex}
 \input{virtio-i2c.tex}
diff --git a/device-types/virtio-iommu/device-conformance.tex b/device-type=
s/virtio-iommu/device-conformance.tex
new file mode 100644
index 0000000..bc5b3b8
--- /dev/null
+++ b/device-types/virtio-iommu/device-conformance.tex
@@ -0,0 +1,16 @@
+\conformance{\subsection}{IOMMU Device Conformance}\label{sec:Conformance =
/ Device Conformance / IOMMU Device Conformance}
+
+An IOMMU device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / IOMMU Device / Feature bits}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device configurat=
ion layout}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / ATTACH request}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / DETACH request}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / MAP request}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / UNMAP request}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / PROBE request}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / PROBE properties / RESVMEM}
+\item \ref{devicenormative:Device Types / IOMMU Device / Device operations=
 / Fault reporting}
+\end{itemize}
diff --git a/virtio-iommu.tex b/device-types/virtio-iommu/device.tex
similarity index 100%
rename from virtio-iommu.tex
rename to device-types/virtio-iommu/device.tex
diff --git a/device-types/virtio-iommu/driver-conformance.tex b/device-type=
s/virtio-iommu/driver-conformance.tex
new file mode 100644
index 0000000..0c7bf91
--- /dev/null
+++ b/device-types/virtio-iommu/driver-conformance.tex
@@ -0,0 +1,17 @@
+\conformance{\subsection}{IOMMU Driver Conformance}\label{sec:Conformance =
/ Driver Conformance / IOMMU Driver Conformance}
+
+An IOMMU driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / IOMMU Device / Feature bits}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device configurat=
ion layout}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device Initializa=
tion}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / ATTACH request}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / DETACH request}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / MAP request}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / UNMAP request}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / PROBE request}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / PROBE properties / RESVMEM}
+\item \ref{drivernormative:Device Types / IOMMU Device / Device operations=
 / Fault reporting}
+\end{itemize}
--=20
2.26.2

