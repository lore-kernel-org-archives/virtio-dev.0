Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v3 14/20] virtio-iommu: Maintain iommu device spec in separate directory
Date: Wed, 11 Jan 2023 01:03:52 +0200
Message-ID: <20230110230358.528098-15-parav@nvidia.com>
In-Reply-To: <20230110230358.528098-1-parav@nvidia.com>
References: <20230110230358.528098-1-parav@nvidia.com>
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
v2->v3:
- file name changed from device.tex to description.tex
- use input instead of import to insert a file
v1->v2:
- rebased
v0->v1:
- new patch
---
 conformance.tex                               | 37 +------------------
 content.tex                                   |  2 +-
 .../virtio-iommu/description.tex              |  0
 .../virtio-iommu/device-conformance.tex       | 16 ++++++++
 .../virtio-iommu/driver-conformance.tex       | 17 +++++++++
 5 files changed, 36 insertions(+), 36 deletions(-)
 rename virtio-iommu.tex =3D> device-types/virtio-iommu/description.tex (10=
0%)
 create mode 100644 device-types/virtio-iommu/device-conformance.tex
 create mode 100644 device-types/virtio-iommu/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index fb95c4a..7a64606 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -145,24 +145,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/virtio-vsock/driver-conformance.tex}
 \input{device-types/virtio-fs/driver-conformance.tex}
 \input{device-types/virtio-rpmb/driver-conformance.tex}
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
+\input{device-types/virtio-iommu/driver-conformance.tex}
=20
 \conformance{\subsection}{Sound Driver Conformance}\label{sec:Conformance =
/ Driver Conformance / Sound Driver Conformance}
=20
@@ -305,23 +288,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/virtio-vsock/device-conformance.tex}
 \input{device-types/virtio-fs/device-conformance.tex}
 \input{device-types/virtio-rpmb/device-conformance.tex}
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
+\input{device-types/virtio-iommu/device-conformance.tex}
=20
 \conformance{\subsection}{Sound Device Conformance}\label{sec:Conformance =
/ Device Conformance / Sound Device Conformance}
=20
diff --git a/content.tex b/content.tex
index 434d131..b9a4ce7 100644
--- a/content.tex
+++ b/content.tex
@@ -3015,7 +3015,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/virtio-vsock/description.tex}
 \input{device-types/virtio-fs/description.tex}
 \input{device-types/virtio-rpmb/description.tex}
-\input{virtio-iommu.tex}
+\input{device-types/virtio-iommu/description.tex}
 \input{virtio-sound.tex}
 \input{virtio-mem.tex}
 \input{virtio-i2c.tex}
diff --git a/virtio-iommu.tex b/device-types/virtio-iommu/description.tex
similarity index 100%
rename from virtio-iommu.tex
rename to device-types/virtio-iommu/description.tex
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

