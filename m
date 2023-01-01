Return-Path: <virtio-comment-return-3643-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sun, 1 Jan 2023 20:08:19 +0200
Message-ID: <20230101180824.325172-16-parav@nvidia.com>
In-Reply-To: <20230101180824.325172-1-parav@nvidia.com>
References: <20230101180824.325172-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v1 15/20] virtio-sound: Maintain sound device spec in separate directory
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, virtio-dev@lists.oasis-open.org
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
 conformance.tex                               | 32 +------------------
 content.tex                                   |  2 +-
 .../virtio-sound/device-conformance.tex       | 16 ++++++++++
 .../virtio-sound/device.tex                   |  0
 .../virtio-sound/driver-conformance.tex       | 13 ++++++++
 5 files changed, 31 insertions(+), 32 deletions(-)
 create mode 100644 device-types/virtio-sound/device-conformance.tex
 rename virtio-sound.tex =3D> device-types/virtio-sound/device.tex (100%)
 create mode 100644 device-types/virtio-sound/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 88ae166..3535065 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -146,20 +146,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-fs/}{driver-conformance}
 \import{device-types/virtio-rpmb/}{driver-conformance}
 \import{device-types/virtio-iommu/}{driver-conformance}
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
+\import{device-types/virtio-sound/}{driver-conformance}
=20
 \conformance{\subsection}{Memory Driver Conformance}\label{sec:Conformance=
 / Driver Conformance / Memory Driver Conformance}
=20
@@ -290,23 +277,6 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-rpmb/}{device-conformance}
 \import{device-types/virtio-iommu/}{device-conformance}
=20
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
-
 \conformance{\subsection}{Memory Device Conformance}\label{sec:Conformance=
 / Device Conformance / Memory Device Conformance}
=20
 A memory device MUST conform to the following normative statements:
diff --git a/content.tex b/content.tex
index 49f3edc..e42a8a9 100644
--- a/content.tex
+++ b/content.tex
@@ -3015,7 +3015,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \import{device-types/virtio-vsock/}{device}
 \import{device-types/virtio-fs/}{device}
 \import{device-types/virtio-iommu/}{device}
-\input{virtio-sound.tex}
+\import{device-types/virtio-sound/}{device}
 \input{virtio-mem.tex}
 \input{virtio-i2c.tex}
 \input{virtio-scmi.tex}
diff --git a/device-types/virtio-sound/device-conformance.tex b/device-type=
s/virtio-sound/device-conformance.tex
new file mode 100644
index 0000000..7b900c2
--- /dev/null
+++ b/device-types/virtio-sound/device-conformance.tex
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
diff --git a/virtio-sound.tex b/device-types/virtio-sound/device.tex
similarity index 100%
rename from virtio-sound.tex
rename to device-types/virtio-sound/device.tex
diff --git a/device-types/virtio-sound/driver-conformance.tex b/device-type=
s/virtio-sound/driver-conformance.tex
new file mode 100644
index 0000000..9a910cd
--- /dev/null
+++ b/device-types/virtio-sound/driver-conformance.tex
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


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

