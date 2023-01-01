Return-Path: <virtio-comment-return-3639-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sun, 1 Jan 2023 20:08:13 +0200
Message-ID: <20230101180824.325172-10-parav@nvidia.com>
In-Reply-To: <20230101180824.325172-1-parav@nvidia.com>
References: <20230101180824.325172-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v1 09/20] virtio-input: Maintain input device spec in separate directory
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Move virtio input device specification to its own file similar to
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
 conformance.tex                               | 20 ++-----------------
 content.tex                                   |  2 +-
 .../virtio-input/device-conformance.tex       |  8 ++++++++
 .../virtio-input/device.tex                   |  0
 .../virtio-input/driver-conformance.tex       |  8 ++++++++
 5 files changed, 19 insertions(+), 19 deletions(-)
 create mode 100644 device-types/virtio-input/device-conformance.tex
 rename virtio-input.tex =3D> device-types/virtio-input/device.tex (100%)
 create mode 100644 device-types/virtio-input/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 432b03c..8470e52 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -140,15 +140,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-entropy/}{driver-conformance}
 \import{device-types/virtio-mem-balloon/}{driver-conformance}
 \import{device-types/virtio-scsi/}{driver-conformance}
-
-\conformance{\subsection}{Input Driver Conformance}\label{sec:Conformance =
/ Driver Conformance / Input Driver Conformance}
-
-An input driver MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{drivernormative:Device Types / Input Device / Device Initializa=
tion}
-\item \ref{drivernormative:Device Types / Input Device / Device Operation}
-\end{itemize}
+\import{device-types/virtio-input/}{driver-conformance}
=20
 \conformance{\subsection}{Crypto Driver Conformance}\label{sec:Conformance=
 / Driver Conformance / Crypto Driver Conformance}
=20
@@ -348,15 +340,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-mem-balloon/}{device-conformance}
 \import{device-types/virtio-scsi/}{device-conformance}
 \import{device-types/virtio-gpu/}{device-conformance}
-
-\conformance{\subsection}{Input Device Conformance}\label{sec:Conformance =
/ Device Conformance / Input Device Conformance}
-
-An input device MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / Input Device / Device Initializa=
tion}
-\item \ref{devicenormative:Device Types / Input Device / Device Operation}
-\end{itemize}
+\import{device-types/virtio-input/}{device-conformance}
=20
 \conformance{\subsection}{Crypto Device Conformance}\label{sec:Conformance=
 / Device Conformance / Crypto Device Conformance}
=20
diff --git a/content.tex b/content.tex
index 4f16ad8..b1d8474 100644
--- a/content.tex
+++ b/content.tex
@@ -3010,7 +3010,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \import{device-types/virtio-mem-balloon/}{device}
 \import{device-types/virtio-scsi/}{device}
 \import{device-types/virtio-gpu/}{device}
-\input{virtio-input.tex}
+\import{device-types/virtio-input/}{device}
 \input{virtio-crypto.tex}
 \input{virtio-vsock.tex}
 \input{virtio-fs.tex}
diff --git a/device-types/virtio-input/device-conformance.tex b/device-type=
s/virtio-input/device-conformance.tex
new file mode 100644
index 0000000..173cdd6
--- /dev/null
+++ b/device-types/virtio-input/device-conformance.tex
@@ -0,0 +1,8 @@
+\conformance{\subsection}{Input Device Conformance}\label{sec:Conformance =
/ Device Conformance / Input Device Conformance}
+
+An input device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / Input Device / Device Initializa=
tion}
+\item \ref{devicenormative:Device Types / Input Device / Device Operation}
+\end{itemize}
diff --git a/virtio-input.tex b/device-types/virtio-input/device.tex
similarity index 100%
rename from virtio-input.tex
rename to device-types/virtio-input/device.tex
diff --git a/device-types/virtio-input/driver-conformance.tex b/device-type=
s/virtio-input/driver-conformance.tex
new file mode 100644
index 0000000..5eb9dac
--- /dev/null
+++ b/device-types/virtio-input/driver-conformance.tex
@@ -0,0 +1,8 @@
+\conformance{\subsection}{Input Driver Conformance}\label{sec:Conformance =
/ Driver Conformance / Input Driver Conformance}
+
+An input driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Input Device / Device Initializa=
tion}
+\item \ref{drivernormative:Device Types / Input Device / Device Operation}
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

