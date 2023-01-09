Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v2 11/20] virtio-vsock: Maintain socket device spec in separate directory
Date: Mon, 9 Jan 2023 18:28:40 +0200
Message-ID: <20230109162849.463101-12-parav@nvidia.com>
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
v0->v1:
- new patch
---
 conformance.tex                               | 23 ++-----------------
 content.tex                                   |  2 +-
 .../virtio-vsock/device-conformance.tex       |  9 ++++++++
 .../virtio-vsock/device.tex                   |  0
 .../virtio-vsock/driver-conformance.tex       | 10 ++++++++
 5 files changed, 22 insertions(+), 22 deletions(-)
 create mode 100644 device-types/virtio-vsock/device-conformance.tex
 rename virtio-vsock.tex =3D> device-types/virtio-vsock/device.tex (100%)
 create mode 100644 device-types/virtio-vsock/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 67b7523..5f63bfb 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -142,17 +142,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-scsi/}{driver-conformance}
 \import{device-types/virtio-input/}{driver-conformance}
 \import{device-types/virtio-crypto/}{driver-conformance}
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
+\import{device-types/virtio-vsock/}{driver-conformance}
=20
 \conformance{\subsection}{File System Driver Conformance}\label{sec:Confor=
mance / Driver Conformance / File System Driver Conformance}
=20
@@ -328,16 +318,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-gpu/}{device-conformance}
 \import{device-types/virtio-input/}{device-conformance}
 \import{device-types/virtio-crypto/}{device-conformance}
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
+\import{device-types/virtio-vsock/}{device-conformance}
=20
 \conformance{\subsection}{File System Device Conformance}\label{sec:Confor=
mance / Device Conformance / File System Device Conformance}
=20
diff --git a/content.tex b/content.tex
index 3d0cba0..1cee4c4 100644
--- a/content.tex
+++ b/content.tex
@@ -3012,7 +3012,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \import{device-types/virtio-gpu/}{device}
 \import{device-types/virtio-input/}{device}
 \import{device-types/virtio-crypto/}{device}
-\input{virtio-vsock.tex}
+\import{device-types/virtio-vsock/}{device}
 \input{virtio-fs.tex}
 \input{virtio-rpmb.tex}
 \input{virtio-iommu.tex}
diff --git a/device-types/virtio-vsock/device-conformance.tex b/device-type=
s/virtio-vsock/device-conformance.tex
new file mode 100644
index 0000000..93b0c4d
--- /dev/null
+++ b/device-types/virtio-vsock/device-conformance.tex
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
diff --git a/virtio-vsock.tex b/device-types/virtio-vsock/device.tex
similarity index 100%
rename from virtio-vsock.tex
rename to device-types/virtio-vsock/device.tex
diff --git a/device-types/virtio-vsock/driver-conformance.tex b/device-type=
s/virtio-vsock/driver-conformance.tex
new file mode 100644
index 0000000..988b0c3
--- /dev/null
+++ b/device-types/virtio-vsock/driver-conformance.tex
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

