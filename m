Return-Path: <virtio-comment-return-3634-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sun, 1 Jan 2023 20:08:14 +0200
Message-ID: <20230101180824.325172-11-parav@nvidia.com>
In-Reply-To: <20230101180824.325172-1-parav@nvidia.com>
References: <20230101180824.325172-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v1 10/20] virtio-crypto: Maintain crypto device spec in separate directory
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Move virtio crypto device specification to its own file similar to
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
 conformance.tex                               | 31 ++-----------------
 content.tex                                   |  2 +-
 .../virtio-crypto/device-conformance.tex      | 13 ++++++++
 .../virtio-crypto/device.tex                  |  0
 .../virtio-crypto/driver-conformance.tex      | 14 +++++++++
 5 files changed, 30 insertions(+), 30 deletions(-)
 create mode 100644 device-types/virtio-crypto/device-conformance.tex
 rename virtio-crypto.tex =3D> device-types/virtio-crypto/device.tex (100%)
 create mode 100644 device-types/virtio-crypto/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 8470e52..67b7523 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -141,21 +141,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-mem-balloon/}{driver-conformance}
 \import{device-types/virtio-scsi/}{driver-conformance}
 \import{device-types/virtio-input/}{driver-conformance}
-
-\conformance{\subsection}{Crypto Driver Conformance}\label{sec:Conformance=
 / Driver Conformance / Crypto Driver Conformance}
-
-A Crypto driver MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{drivernormative:Device Types / Crypto Device / Device configura=
tion layout}
-\item \ref{drivernormative:Device Types / Crypto Device / Device Initializ=
ation}
-\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / Control Virtqueue / Session operation / Session operation: create sessio=
n}
-\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / Control Virtqueue / Session operation / Session operation: destroy sessi=
on}
-\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / HASH Service Operation}
-\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / MAC Service Operation}
-\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / Symmetric algorithms Operation}
-\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / AEAD Service Operation}
-\end{itemize}
+\import{device-types/virtio-crypto/}{driver-conformance}
=20
 \conformance{\subsection}{Socket Driver Conformance}\label{sec:Conformance=
 / Driver Conformance / Socket Driver Conformance}
=20
@@ -341,20 +327,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-scsi/}{device-conformance}
 \import{device-types/virtio-gpu/}{device-conformance}
 \import{device-types/virtio-input/}{device-conformance}
-
-\conformance{\subsection}{Crypto Device Conformance}\label{sec:Conformance=
 / Device Conformance / Crypto Device Conformance}
-
-A Crypto device MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / Crypto Device / Device configura=
tion layout}
-\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / Control Virtqueue / Session operation / Session operation: create sessio=
n}
-\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / Control Virtqueue / Session operation / Session operation: destroy sessi=
on}
-\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / HASH Service Operation}
-\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / MAC Service Operation}
-\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / Symmetric algorithms Operation}
-\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / AEAD Service Operation}
-\end{itemize}
+\import{device-types/virtio-crypto/}{device-conformance}
=20
 \conformance{\subsection}{Socket Device Conformance}\label{sec:Conformance=
 / Device Conformance / Socket Device Conformance}
=20
diff --git a/content.tex b/content.tex
index b1d8474..3d0cba0 100644
--- a/content.tex
+++ b/content.tex
@@ -3011,7 +3011,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \import{device-types/virtio-scsi/}{device}
 \import{device-types/virtio-gpu/}{device}
 \import{device-types/virtio-input/}{device}
-\input{virtio-crypto.tex}
+\import{device-types/virtio-crypto/}{device}
 \input{virtio-vsock.tex}
 \input{virtio-fs.tex}
 \input{virtio-rpmb.tex}
diff --git a/device-types/virtio-crypto/device-conformance.tex b/device-typ=
es/virtio-crypto/device-conformance.tex
new file mode 100644
index 0000000..1667120
--- /dev/null
+++ b/device-types/virtio-crypto/device-conformance.tex
@@ -0,0 +1,13 @@
+\conformance{\subsection}{Crypto Device Conformance}\label{sec:Conformance=
 / Device Conformance / Crypto Device Conformance}
+
+A Crypto device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / Crypto Device / Device configura=
tion layout}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / Control Virtqueue / Session operation / Session operation: create sessio=
n}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / Control Virtqueue / Session operation / Session operation: destroy sessi=
on}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / HASH Service Operation}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / MAC Service Operation}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / Symmetric algorithms Operation}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / AEAD Service Operation}
+\end{itemize}
diff --git a/virtio-crypto.tex b/device-types/virtio-crypto/device.tex
similarity index 100%
rename from virtio-crypto.tex
rename to device-types/virtio-crypto/device.tex
diff --git a/device-types/virtio-crypto/driver-conformance.tex b/device-typ=
es/virtio-crypto/driver-conformance.tex
new file mode 100644
index 0000000..672d0f6
--- /dev/null
+++ b/device-types/virtio-crypto/driver-conformance.tex
@@ -0,0 +1,14 @@
+\conformance{\subsection}{Crypto Driver Conformance}\label{sec:Conformance=
 / Driver Conformance / Crypto Driver Conformance}
+
+A Crypto driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Crypto Device / Device configura=
tion layout}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Initializ=
ation}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / Control Virtqueue / Session operation / Session operation: create sessio=
n}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / Control Virtqueue / Session operation / Session operation: destroy sessi=
on}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / HASH Service Operation}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / MAC Service Operation}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / Symmetric algorithms Operation}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / AEAD Service Operation}
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

