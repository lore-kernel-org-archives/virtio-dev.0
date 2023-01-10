Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v3 08/20] virtio-gpu: Maintain gpu device spec in separate directory
Date: Wed, 11 Jan 2023 01:03:46 +0200
Message-ID: <20230110230358.528098-9-parav@nvidia.com>
In-Reply-To: <20230110230358.528098-1-parav@nvidia.com>
References: <20230110230358.528098-1-parav@nvidia.com>
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
v2->v3:
- file name changed from device.tex to description.tex
- use input instead of import to insert a file
v0->v1:
- moved to device specific directory
---
 conformance.tex                                        | 10 +---------
 content.tex                                            |  2 +-
 .../virtio-gpu/description.tex                         |  0
 device-types/virtio-gpu/device-conformance.tex         |  8 ++++++++
 4 files changed, 10 insertions(+), 10 deletions(-)
 rename virtio-gpu.tex =3D> device-types/virtio-gpu/description.tex (100%)
 create mode 100644 device-types/virtio-gpu/device-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index f3439c5..7a4f63f 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -347,15 +347,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/virtio-entropy/device-conformance.tex}
 \input{device-types/virtio-mem-balloon/device-conformance.tex}
 \input{device-types/virtio-scsi/device-conformance.tex}
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
+\input{device-types/virtio-gpu/device-conformance.tex}
=20
 \conformance{\subsection}{Input Device Conformance}\label{sec:Conformance =
/ Device Conformance / Input Device Conformance}
=20
diff --git a/content.tex b/content.tex
index 3d05cc0..3675aca 100644
--- a/content.tex
+++ b/content.tex
@@ -3009,7 +3009,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/virtio-entropy/description.tex}
 \input{device-types/virtio-mem-balloon/description.tex}
 \input{device-types/virtio-scsi/description.tex}
-\input{virtio-gpu.tex}
+\input{device-types/virtio-gpu/description.tex}
 \input{virtio-input.tex}
 \input{virtio-crypto.tex}
 \input{virtio-vsock.tex}
diff --git a/virtio-gpu.tex b/device-types/virtio-gpu/description.tex
similarity index 100%
rename from virtio-gpu.tex
rename to device-types/virtio-gpu/description.tex
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
--=20
2.26.2

