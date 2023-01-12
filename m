Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v4 13/20] virtio-rpmb: Maintain rpmb device spec in separate directory
Date: Thu, 12 Jan 2023 23:22:47 +0200
Message-ID: <20230112212254.763783-14-parav@nvidia.com>
In-Reply-To: <20230112212254.763783-1-parav@nvidia.com>
References: <20230112212254.763783-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, david@redhat.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Place device specification, its driver and device
conformance into its own directory to have self contained device
specification.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v3->v4:
- rename device-types/virtio-rpmb to device-types/rpmb
v2->v3:
- file name changed from device.tex to description.tex
- use input instead of import to insert a file
v1->v2:
- added missing device conformance reference entry
v0->v1:
- new patch
---
 conformance.tex                               | 23 ++-----------------
 content.tex                                   |  2 +-
 .../rpmb/description.tex                      |  0
 device-types/rpmb/device-conformance.tex      | 13 +++++++++++
 device-types/rpmb/driver-conformance.tex      |  7 ++++++
 5 files changed, 23 insertions(+), 22 deletions(-)
 rename virtio-rpmb.tex =3D> device-types/rpmb/description.tex (100%)
 create mode 100644 device-types/rpmb/device-conformance.tex
 create mode 100644 device-types/rpmb/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 41685d4..4c5d601 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -144,14 +144,8 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/crypto/driver-conformance.tex}
 \input{device-types/vsock/driver-conformance.tex}
 \input{device-types/fs/driver-conformance.tex}
+\input{device-types/rpmb/driver-conformance.tex}
=20
-\conformance{\subsection}{RPMB Driver Conformance}\label{sec:Conformance /=
 Driver Conformance / RPMB Driver Conformance}
-
-A RPMB driver MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{drivernormative:Device Types / RPMB Device / Device Operation}
-\end{itemize}
 \conformance{\subsection}{IOMMU Driver Conformance}\label{sec:Conformance =
/ Driver Conformance / IOMMU Driver Conformance}
=20
 An IOMMU driver MUST conform to the following normative statements:
@@ -310,20 +304,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/crypto/device-conformance.tex}
 \input{device-types/vsock/device-conformance.tex}
 \input{device-types/fs/device-conformance.tex}
-
-\conformance{\subsection}{RPMB Device Conformance}\label{sec:Conformance /=
 Device Conformance / RPMB Device Conformance}
-
-An RPMB device MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / RPMB Device / Device Initializat=
ion}
-\item \ref{devicenormative:Device Types / RPMB Device / Device Operation /=
 Device Operation: Program Key}
-\item \ref{devicenormative:Device Types / RPMB Device / Device Operation /=
 Device Operation: Get Write Counter}
-\item \ref{devicenormative:Device Types / RPMB Device / Device Operation /=
 Device Operation: Data Write}
-\item \ref{devicenormative:Device Types / RPMB Device / Device Operation /=
 Device Operation: Data Read}
-\item \ref{devicenormative:Device Types / RPMB Device / Device Operation /=
 Device Operation: Result Read}
-\item \ref{devicenormative:Device Types / RPMB Device / Device Operation}
-\end{itemize}
+\input{device-types/rpmb/device-conformance.tex}
=20
 \conformance{\subsection}{IOMMU Device Conformance}\label{sec:Conformance =
/ Device Conformance / IOMMU Device Conformance}
=20
diff --git a/content.tex b/content.tex
index 962c250..4d3e830 100644
--- a/content.tex
+++ b/content.tex
@@ -3014,7 +3014,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/crypto/description.tex}
 \input{device-types/vsock/description.tex}
 \input{device-types/fs/description.tex}
-\input{virtio-rpmb.tex}
+\input{device-types/rpmb/description.tex}
 \input{virtio-iommu.tex}
 \input{virtio-sound.tex}
 \input{virtio-mem.tex}
diff --git a/virtio-rpmb.tex b/device-types/rpmb/description.tex
similarity index 100%
rename from virtio-rpmb.tex
rename to device-types/rpmb/description.tex
diff --git a/device-types/rpmb/device-conformance.tex b/device-types/rpmb/d=
evice-conformance.tex
new file mode 100644
index 0000000..4a01e5a
--- /dev/null
+++ b/device-types/rpmb/device-conformance.tex
@@ -0,0 +1,13 @@
+\conformance{\subsection}{RPMB Device Conformance}\label{sec:Conformance /=
 Device Conformance / RPMB Device Conformance}
+
+An RPMB device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / RPMB Device / Device Initializat=
ion}
+\item \ref{devicenormative:Device Types / RPMB Device / Device Operation /=
 Device Operation: Program Key}
+\item \ref{devicenormative:Device Types / RPMB Device / Device Operation /=
 Device Operation: Get Write Counter}
+\item \ref{devicenormative:Device Types / RPMB Device / Device Operation /=
 Device Operation: Data Write}
+\item \ref{devicenormative:Device Types / RPMB Device / Device Operation /=
 Device Operation: Data Read}
+\item \ref{devicenormative:Device Types / RPMB Device / Device Operation /=
 Device Operation: Result Read}
+\item \ref{devicenormative:Device Types / RPMB Device / Device Operation}
+\end{itemize}
diff --git a/device-types/rpmb/driver-conformance.tex b/device-types/rpmb/d=
river-conformance.tex
new file mode 100644
index 0000000..0cdddac
--- /dev/null
+++ b/device-types/rpmb/driver-conformance.tex
@@ -0,0 +1,7 @@
+\conformance{\subsection}{RPMB Driver Conformance}\label{sec:Conformance /=
 Driver Conformance / RPMB Driver Conformance}
+
+A RPMB driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / RPMB Device / Device Operation}
+\end{itemize}
--=20
2.26.2

