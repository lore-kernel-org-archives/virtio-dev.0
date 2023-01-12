Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v4 15/20] virtio-sound: Maintain sound device spec in separate directory
Date: Thu, 12 Jan 2023 23:22:49 +0200
Message-ID: <20230112212254.763783-16-parav@nvidia.com>
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
- rename device-types/virtio-sound to device-types/sound
v2->v3:
- file name changed from device.tex to description.tex
- use input instead of import to insert a file
v1->v2:
- added missing device conformance reference
v0->v1:
- new patch
---
 conformance.tex                               | 33 ++-----------------
 content.tex                                   |  2 +-
 .../sound/description.tex                     |  0
 device-types/sound/device-conformance.tex     | 16 +++++++++
 device-types/sound/driver-conformance.tex     | 13 ++++++++
 5 files changed, 32 insertions(+), 32 deletions(-)
 rename virtio-sound.tex =3D> device-types/sound/description.tex (100%)
 create mode 100644 device-types/sound/device-conformance.tex
 create mode 100644 device-types/sound/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 24f67ca..5f3a769 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -146,20 +146,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/fs/driver-conformance.tex}
 \input{device-types/rpmb/driver-conformance.tex}
 \input{device-types/iommu/driver-conformance.tex}
-
-\conformance{\subsection}{Sound Driver Conformance}\label{sec:Conformance =
/ Driver Conformance / Sound Driver Conformance}
-
-A sound driver MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{drivernormative:Device Types / Sound Device / Device Initializa=
tion}
-\item \ref{drivernormative:Device Types / Sound Device / Item Information =
Request}
-\item \ref{drivernormative:Device Types / Sound Device / Device Operation =
/ PCM Stream Parameters}
-\item \ref{drivernormative:Device Types / Sound Device / Device Operation =
/ PCM Output Stream}
-\item \ref{drivernormative:Device Types / Sound Device / Device Operation =
/ PCM Input Stream}
-\item \ref{drivernormative:Device Types / Sound Device / Device Operation =
/ Control Element Value}
-\item \ref{drivernormative:Device Types / Sound Device / Device Operation =
/ Control Element Metadata}
-\end{itemize}
+\input{device-types/sound/driver-conformance.tex}
=20
 \conformance{\subsection}{Memory Driver Conformance}\label{sec:Conformance=
 / Driver Conformance / Memory Driver Conformance}
=20
@@ -289,23 +276,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/fs/device-conformance.tex}
 \input{device-types/rpmb/device-conformance.tex}
 \input{device-types/iommu/device-conformance.tex}
-
-\conformance{\subsection}{Sound Device Conformance}\label{sec:Conformance =
/ Device Conformance / Sound Device Conformance}
-
-A sound device MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ Jack Information}
-\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ PCM Stream Information}
-\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ PCM Stream Parameters}
-\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ PCM Stream Release}
-\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ PCM Output Stream}
-\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ PCM Input Stream}
-\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ Channel Map Information}
-\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ Control Element Information}
-\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ Control Element Metadata}
-\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ Control Element Notifications}
-\end{itemize}
+\input{device-types/sound/device-conformance.tex}
=20
 \conformance{\subsection}{Memory Device Conformance}\label{sec:Conformance=
 / Device Conformance / Memory Device Conformance}
=20
diff --git a/content.tex b/content.tex
index 1de5b06..7a41b54 100644
--- a/content.tex
+++ b/content.tex
@@ -3016,7 +3016,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/fs/description.tex}
 \input{device-types/rpmb/description.tex}
 \input{device-types/iommu/description.tex}
-\input{virtio-sound.tex}
+\input{device-types/sound/description.tex}
 \input{virtio-mem.tex}
 \input{virtio-i2c.tex}
 \input{virtio-scmi.tex}
diff --git a/virtio-sound.tex b/device-types/sound/description.tex
similarity index 100%
rename from virtio-sound.tex
rename to device-types/sound/description.tex
diff --git a/device-types/sound/device-conformance.tex b/device-types/sound=
/device-conformance.tex
new file mode 100644
index 0000000..7b900c2
--- /dev/null
+++ b/device-types/sound/device-conformance.tex
@@ -0,0 +1,16 @@
+\conformance{\subsection}{Sound Device Conformance}\label{sec:Conformance =
/ Device Conformance / Sound Device Conformance}
+
+A sound device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ Jack Information}
+\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ PCM Stream Information}
+\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ PCM Stream Parameters}
+\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ PCM Stream Release}
+\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ PCM Output Stream}
+\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ PCM Input Stream}
+\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ Channel Map Information}
+\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ Control Element Information}
+\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ Control Element Metadata}
+\item \ref{devicenormative:Device Types / Sound Device / Device Operation =
/ Control Element Notifications}
+\end{itemize}
diff --git a/device-types/sound/driver-conformance.tex b/device-types/sound=
/driver-conformance.tex
new file mode 100644
index 0000000..9a910cd
--- /dev/null
+++ b/device-types/sound/driver-conformance.tex
@@ -0,0 +1,13 @@
+\conformance{\subsection}{Sound Driver Conformance}\label{sec:Conformance =
/ Driver Conformance / Sound Driver Conformance}
+
+A sound driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Sound Device / Device Initializa=
tion}
+\item \ref{drivernormative:Device Types / Sound Device / Item Information =
Request}
+\item \ref{drivernormative:Device Types / Sound Device / Device Operation =
/ PCM Stream Parameters}
+\item \ref{drivernormative:Device Types / Sound Device / Device Operation =
/ PCM Output Stream}
+\item \ref{drivernormative:Device Types / Sound Device / Device Operation =
/ PCM Input Stream}
+\item \ref{drivernormative:Device Types / Sound Device / Device Operation =
/ Control Element Value}
+\item \ref{drivernormative:Device Types / Sound Device / Device Operation =
/ Control Element Metadata}
+\end{itemize}
--=20
2.26.2

