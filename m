Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v4 11/20] virtio-vsock: Maintain socket device spec in separate directory
Date: Thu, 12 Jan 2023 23:22:45 +0200
Message-ID: <20230112212254.763783-12-parav@nvidia.com>
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
- rename device-types/virtio-vsock to device-types/vsock
v2->v3:
- file name changed from device.tex to description.tex
- use input instead of import to insert a file
v0->v1:
- new patch
---
 conformance.tex                               | 23 ++-----------------
 content.tex                                   |  2 +-
 .../vsock/description.tex                     |  0
 device-types/vsock/device-conformance.tex     |  9 ++++++++
 device-types/vsock/driver-conformance.tex     | 10 ++++++++
 5 files changed, 22 insertions(+), 22 deletions(-)
 rename virtio-vsock.tex =3D> device-types/vsock/description.tex (100%)
 create mode 100644 device-types/vsock/device-conformance.tex
 create mode 100644 device-types/vsock/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 970ef12..527949c 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -142,17 +142,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/scsi/driver-conformance.tex}
 \input{device-types/input/driver-conformance.tex}
 \input{device-types/crypto/driver-conformance.tex}
-
-\conformance{\subsection}{Socket Driver Conformance}\label{sec:Conformance=
 / Driver Conformance / Socket Driver Conformance}
-
-A socket driver MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{drivernormative:Device Types / Socket Device / Feature bits}
-\item \ref{drivernormative:Device Types / Socket Device / Device Operation=
 / Buffer Space Management}
-\item \ref{drivernormative:Device Types / Socket Device / Device Operation=
 / Receive and Transmit}
-\item \ref{drivernormative:Device Types / Socket Device / Device Operation=
 / Device Events}
-\end{itemize}
+\input{device-types/vsock/driver-conformance.tex}
=20
 \conformance{\subsection}{File System Driver Conformance}\label{sec:Confor=
mance / Driver Conformance / File System Driver Conformance}
=20
@@ -328,16 +318,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/gpu/device-conformance.tex}
 \input{device-types/input/device-conformance.tex}
 \input{device-types/crypto/device-conformance.tex}
-
-\conformance{\subsection}{Socket Device Conformance}\label{sec:Conformance=
 / Device Conformance / Socket Device Conformance}
-
-A socket device MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / Socket Device / Feature bits}
-\item \ref{devicenormative:Device Types / Socket Device / Device Operation=
 / Buffer Space Management}
-\item \ref{devicenormative:Device Types / Socket Device / Device Operation=
 / Receive and Transmit}
-\end{itemize}
+\input{device-types/vsock/device-conformance.tex}
=20
 \conformance{\subsection}{File System Device Conformance}\label{sec:Confor=
mance / Device Conformance / File System Device Conformance}
=20
diff --git a/content.tex b/content.tex
index 2ee50d3..a154822 100644
--- a/content.tex
+++ b/content.tex
@@ -3012,7 +3012,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/gpu/description.tex}
 \input{device-types/input/description.tex}
 \input{device-types/crypto/description.tex}
-\input{virtio-vsock.tex}
+\input{device-types/vsock/description.tex}
 \input{virtio-fs.tex}
 \input{virtio-rpmb.tex}
 \input{virtio-iommu.tex}
diff --git a/virtio-vsock.tex b/device-types/vsock/description.tex
similarity index 100%
rename from virtio-vsock.tex
rename to device-types/vsock/description.tex
diff --git a/device-types/vsock/device-conformance.tex b/device-types/vsock=
/device-conformance.tex
new file mode 100644
index 0000000..93b0c4d
--- /dev/null
+++ b/device-types/vsock/device-conformance.tex
@@ -0,0 +1,9 @@
+\conformance{\subsection}{Socket Device Conformance}\label{sec:Conformance=
 / Device Conformance / Socket Device Conformance}
+
+A socket device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / Socket Device / Feature bits}
+\item \ref{devicenormative:Device Types / Socket Device / Device Operation=
 / Buffer Space Management}
+\item \ref{devicenormative:Device Types / Socket Device / Device Operation=
 / Receive and Transmit}
+\end{itemize}
diff --git a/device-types/vsock/driver-conformance.tex b/device-types/vsock=
/driver-conformance.tex
new file mode 100644
index 0000000..988b0c3
--- /dev/null
+++ b/device-types/vsock/driver-conformance.tex
@@ -0,0 +1,10 @@
+\conformance{\subsection}{Socket Driver Conformance}\label{sec:Conformance=
 / Driver Conformance / Socket Driver Conformance}
+
+A socket driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Socket Device / Feature bits}
+\item \ref{drivernormative:Device Types / Socket Device / Device Operation=
 / Buffer Space Management}
+\item \ref{drivernormative:Device Types / Socket Device / Device Operation=
 / Receive and Transmit}
+\item \ref{drivernormative:Device Types / Socket Device / Device Operation=
 / Device Events}
+\end{itemize}
--=20
2.26.2

