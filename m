Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v2 08/20] virtio-gpu: Maintain gpu device spec in separate directory
Date: Mon, 9 Jan 2023 18:28:37 +0200
Message-ID: <20230109162849.463101-9-parav@nvidia.com>
In-Reply-To: <20230109162849.463101-1-parav@nvidia.com>
References: <20230109162849.463101-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Move virtio gpu device specification to its own file similar to
recent virtio devices.
While at it, place device specification, its driver and device
conformance into its own directory to have self contained device
specification.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v0->v1:
- moved to device specific directory
---
 conformance.tex                                      | 10 +---------
 content.tex                                          |  2 +-
 device-types/virtio-gpu/device-conformance.tex       |  8 ++++++++
 virtio-gpu.tex =3D> device-types/virtio-gpu/device.tex |  0
 4 files changed, 10 insertions(+), 10 deletions(-)
 create mode 100644 device-types/virtio-gpu/device-conformance.tex
 rename virtio-gpu.tex =3D> device-types/virtio-gpu/device.tex (100%)

diff --git a/conformance.tex b/conformance.tex
index 10a5af3..432b03c 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -347,15 +347,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-entropy/}{device-conformance}
 \import{device-types/virtio-mem-balloon/}{device-conformance}
 \import{device-types/virtio-scsi/}{device-conformance}
-
-\conformance{\subsection}{GPU Device Conformance}\label{sec:Conformance / =
Device Conformance / GPU Device Conformance}
-
-A GPU device MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / GPU Device / Device Initializati=
on}
-\item \ref{devicenormative:Device Types / GPU Device / Device Operation / =
Device Operation: Command lifecycle and fencing}
-\end{itemize}
+\import{device-types/virtio-gpu/}{device-conformance}
=20
 \conformance{\subsection}{Input Device Conformance}\label{sec:Conformance =
/ Device Conformance / Input Device Conformance}
=20
diff --git a/content.tex b/content.tex
index 05d2f9c..4f16ad8 100644
--- a/content.tex
+++ b/content.tex
@@ -3009,7 +3009,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \import{device-types/virtio-entropy/}{device}
 \import{device-types/virtio-mem-balloon/}{device}
 \import{device-types/virtio-scsi/}{device}
-\input{virtio-gpu.tex}
+\import{device-types/virtio-gpu/}{device}
 \input{virtio-input.tex}
 \input{virtio-crypto.tex}
 \input{virtio-vsock.tex}
diff --git a/device-types/virtio-gpu/device-conformance.tex b/device-types/=
virtio-gpu/device-conformance.tex
new file mode 100644
index 0000000..782ef81
--- /dev/null
+++ b/device-types/virtio-gpu/device-conformance.tex
@@ -0,0 +1,8 @@
+\conformance{\subsection}{GPU Device Conformance}\label{sec:Conformance / =
Device Conformance / GPU Device Conformance}
+
+A GPU device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / GPU Device / Device Initializati=
on}
+\item \ref{devicenormative:Device Types / GPU Device / Device Operation / =
Device Operation: Command lifecycle and fencing}
+\end{itemize}
diff --git a/virtio-gpu.tex b/device-types/virtio-gpu/device.tex
similarity index 100%
rename from virtio-gpu.tex
rename to device-types/virtio-gpu/device.tex
--=20
2.26.2

