Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v4 12/20] virtio-fs: Maintain file system device spec in separate directory
Date: Thu, 12 Jan 2023 23:22:46 +0200
Message-ID: <20230112212254.763783-13-parav@nvidia.com>
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
- rename device-types/virtio-fs to device-types/fs
v2->v3:
- file name changed from device.tex to description.tex
- use input instead of import to insert a file
v0->v1:
- new patch
---
 conformance.tex                               | 23 ++-----------------
 content.tex                                   |  2 +-
 .../fs/description.tex                        |  0
 device-types/fs/device-conformance.tex        |  9 ++++++++
 device-types/fs/driver-conformance.tex        | 10 ++++++++
 5 files changed, 22 insertions(+), 22 deletions(-)
 rename virtio-fs.tex =3D> device-types/fs/description.tex (100%)
 create mode 100644 device-types/fs/device-conformance.tex
 create mode 100644 device-types/fs/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 527949c..41685d4 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -143,17 +143,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/input/driver-conformance.tex}
 \input{device-types/crypto/driver-conformance.tex}
 \input{device-types/vsock/driver-conformance.tex}
-
-\conformance{\subsection}{File System Driver Conformance}\label{sec:Confor=
mance / Driver Conformance / File System Driver Conformance}
-
-A file system driver MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{drivernormative:Device Types / File System Device / Device conf=
iguration layout}
-\item \ref{drivernormative:Device Types / File System Device / Device Oper=
ation / Device Operation: High Priority Queue}
-\item \ref{drivernormative:Device Types / File System Device / Device Oper=
ation / Device Operation: Notification Queue}
-\item \ref{drivernormative:Device Types / File System Device / Device Oper=
ation / Device Operation: DAX Window}
-\end{itemize}
+\input{device-types/fs/driver-conformance.tex}
=20
 \conformance{\subsection}{RPMB Driver Conformance}\label{sec:Conformance /=
 Driver Conformance / RPMB Driver Conformance}
=20
@@ -319,16 +309,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/input/device-conformance.tex}
 \input{device-types/crypto/device-conformance.tex}
 \input{device-types/vsock/device-conformance.tex}
-
-\conformance{\subsection}{File System Device Conformance}\label{sec:Confor=
mance / Device Conformance / File System Device Conformance}
-
-A file system device MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / File System Device / Device conf=
iguration layout}
-\item \ref{devicenormative:Device Types / File System Device / Device Oper=
ation / Device Operation: High Priority Queue}
-\item \ref{devicenormative:Device Types / File System Device / Device Oper=
ation / Device Operation: DAX Window}
-\end{itemize}
+\input{device-types/fs/device-conformance.tex}
=20
 \conformance{\subsection}{RPMB Device Conformance}\label{sec:Conformance /=
 Device Conformance / RPMB Device Conformance}
=20
diff --git a/content.tex b/content.tex
index a154822..962c250 100644
--- a/content.tex
+++ b/content.tex
@@ -3013,7 +3013,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/input/description.tex}
 \input{device-types/crypto/description.tex}
 \input{device-types/vsock/description.tex}
-\input{virtio-fs.tex}
+\input{device-types/fs/description.tex}
 \input{virtio-rpmb.tex}
 \input{virtio-iommu.tex}
 \input{virtio-sound.tex}
diff --git a/virtio-fs.tex b/device-types/fs/description.tex
similarity index 100%
rename from virtio-fs.tex
rename to device-types/fs/description.tex
diff --git a/device-types/fs/device-conformance.tex b/device-types/fs/devic=
e-conformance.tex
new file mode 100644
index 0000000..a86245e
--- /dev/null
+++ b/device-types/fs/device-conformance.tex
@@ -0,0 +1,9 @@
+\conformance{\subsection}{File System Device Conformance}\label{sec:Confor=
mance / Device Conformance / File System Device Conformance}
+
+A file system device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / File System Device / Device conf=
iguration layout}
+\item \ref{devicenormative:Device Types / File System Device / Device Oper=
ation / Device Operation: High Priority Queue}
+\item \ref{devicenormative:Device Types / File System Device / Device Oper=
ation / Device Operation: DAX Window}
+\end{itemize}
diff --git a/device-types/fs/driver-conformance.tex b/device-types/fs/drive=
r-conformance.tex
new file mode 100644
index 0000000..5a762ec
--- /dev/null
+++ b/device-types/fs/driver-conformance.tex
@@ -0,0 +1,10 @@
+\conformance{\subsection}{File System Driver Conformance}\label{sec:Confor=
mance / Driver Conformance / File System Driver Conformance}
+
+A file system driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / File System Device / Device conf=
iguration layout}
+\item \ref{drivernormative:Device Types / File System Device / Device Oper=
ation / Device Operation: High Priority Queue}
+\item \ref{drivernormative:Device Types / File System Device / Device Oper=
ation / Device Operation: Notification Queue}
+\item \ref{drivernormative:Device Types / File System Device / Device Oper=
ation / Device Operation: DAX Window}
+\end{itemize}
--=20
2.26.2

