Return-Path: <virtio-comment-return-3637-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sun, 1 Jan 2023 20:08:17 +0200
Message-ID: <20230101180824.325172-14-parav@nvidia.com>
In-Reply-To: <20230101180824.325172-1-parav@nvidia.com>
References: <20230101180824.325172-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v1 13/20] virtio-rpmb: Maintain rpmb device spec in separate directory
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
 conformance.tex                               | 23 ++-----------------
 content.tex                                   |  1 -
 .../virtio-rpmb/device-conformance.tex        | 13 +++++++++++
 .../virtio-rpmb/device.tex                    |  0
 .../virtio-rpmb/driver-conformance.tex        |  7 ++++++
 5 files changed, 22 insertions(+), 22 deletions(-)
 create mode 100644 device-types/virtio-rpmb/device-conformance.tex
 rename virtio-rpmb.tex =3D> device-types/virtio-rpmb/device.tex (100%)
 create mode 100644 device-types/virtio-rpmb/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 56a2c16..c109fbd 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -144,14 +144,8 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-crypto/}{driver-conformance}
 \import{device-types/virtio-vsock/}{driver-conformance}
 \import{device-types/virtio-fs/}{driver-conformance}
+\import{device-types/virtio-rpmb/}{driver-conformance}
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
 \import{device-types/virtio-crypto/}{device-conformance}
 \import{device-types/virtio-vsock/}{device-conformance}
 \import{device-types/virtio-fs/}{device-conformance}
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
+\import{device-types/virtio-rpmb/}{device-conformance}
=20
 \conformance{\subsection}{IOMMU Device Conformance}\label{sec:Conformance =
/ Device Conformance / IOMMU Device Conformance}
=20
diff --git a/content.tex b/content.tex
index a486e36..13a2a94 100644
--- a/content.tex
+++ b/content.tex
@@ -3014,7 +3014,6 @@ \chapter{Device Types}\label{sec:Device Types}
 \import{device-types/virtio-crypto/}{device}
 \import{device-types/virtio-vsock/}{device}
 \import{device-types/virtio-fs/}{device}
-\input{virtio-rpmb.tex}
 \input{virtio-iommu.tex}
 \input{virtio-sound.tex}
 \input{virtio-mem.tex}
diff --git a/device-types/virtio-rpmb/device-conformance.tex b/device-types=
/virtio-rpmb/device-conformance.tex
new file mode 100644
index 0000000..4a01e5a
--- /dev/null
+++ b/device-types/virtio-rpmb/device-conformance.tex
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
diff --git a/virtio-rpmb.tex b/device-types/virtio-rpmb/device.tex
similarity index 100%
rename from virtio-rpmb.tex
rename to device-types/virtio-rpmb/device.tex
diff --git a/device-types/virtio-rpmb/driver-conformance.tex b/device-types=
/virtio-rpmb/driver-conformance.tex
new file mode 100644
index 0000000..0cdddac
--- /dev/null
+++ b/device-types/virtio-rpmb/driver-conformance.tex
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

