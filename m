Return-Path: <virtio-comment-return-3638-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sun, 1 Jan 2023 20:08:21 +0200
Message-ID: <20230101180824.325172-18-parav@nvidia.com>
In-Reply-To: <20230101180824.325172-1-parav@nvidia.com>
References: <20230101180824.325172-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v1 17/20] virtio-i2c: Maintain i2c device spec in separate directory
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
 conformance.tex                                 | 17 +----------------
 content.tex                                     |  2 +-
 device-types/virtio-i2c/device-conformance.tex  |  7 +++++++
 .../virtio-i2c/device.tex                       |  0
 device-types/virtio-i2c/driver-conformance.tex  |  7 +++++++
 5 files changed, 16 insertions(+), 17 deletions(-)
 create mode 100644 device-types/virtio-i2c/device-conformance.tex
 rename virtio-i2c.tex =3D> device-types/virtio-i2c/device.tex (100%)
 create mode 100644 device-types/virtio-i2c/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 836fb6b..df73ea2 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -148,14 +148,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-iommu/}{driver-conformance}
 \import{device-types/virtio-sound/}{driver-conformance}
 \import{device-types/virtio-mem/}{driver-conformance}
-
-\conformance{\subsection}{I2C Adapter Driver Conformance}\label{sec:Confor=
mance / Driver Conformance / I2C Adapter Driver Conformance}
-
-An I2C Adapter driver MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{drivernormative:Device Types / I2C Adapter Device / Device Oper=
ation}
-\end{itemize}
+\import{device-types/virtio-i2c/}{driver-conformance}
=20
 \conformance{\subsection}{SCMI Driver Conformance}\label{sec:Conformance /=
 Driver Conformance / SCMI Driver Conformance}
=20
@@ -265,14 +258,6 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-iommu/}{device-conformance}
 \import{device-types/virtio-mem/}{device-conformance}
=20
-\conformance{\subsection}{I2C Adapter Device Conformance}\label{sec:Confor=
mance / Device Conformance / I2C Adapter Device Conformance}
-
-An I2C Adapter device MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / I2C Adapter Device / Device Oper=
ation}
-\end{itemize}
-
 \conformance{\subsection}{SCMI Device Conformance}\label{sec:Conformance /=
 Device Conformance / SCMI Device Conformance}
=20
 An SCMI device MUST conform to the following normative statements:
diff --git a/content.tex b/content.tex
index 1336c19..aeba6ce 100644
--- a/content.tex
+++ b/content.tex
@@ -3017,7 +3017,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \import{device-types/virtio-iommu/}{device}
 \import{device-types/virtio-sound/}{device}
 \import{device-types/virtio-mem/}{device}
-\input{virtio-i2c.tex}
+\import{device-types/virtio-i2c/}{device}
 \input{virtio-scmi.tex}
 \input{virtio-gpio.tex}
 \input{virtio-pmem.tex}
diff --git a/device-types/virtio-i2c/device-conformance.tex b/device-types/=
virtio-i2c/device-conformance.tex
new file mode 100644
index 0000000..a060b2f
--- /dev/null
+++ b/device-types/virtio-i2c/device-conformance.tex
@@ -0,0 +1,7 @@
+\conformance{\subsection}{I2C Adapter Device Conformance}\label{sec:Confor=
mance / Device Conformance / I2C Adapter Device Conformance}
+
+An I2C Adapter device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / I2C Adapter Device / Device Oper=
ation}
+\end{itemize}
diff --git a/virtio-i2c.tex b/device-types/virtio-i2c/device.tex
similarity index 100%
rename from virtio-i2c.tex
rename to device-types/virtio-i2c/device.tex
diff --git a/device-types/virtio-i2c/driver-conformance.tex b/device-types/=
virtio-i2c/driver-conformance.tex
new file mode 100644
index 0000000..405714c
--- /dev/null
+++ b/device-types/virtio-i2c/driver-conformance.tex
@@ -0,0 +1,7 @@
+\conformance{\subsection}{I2C Adapter Driver Conformance}\label{sec:Confor=
mance / Driver Conformance / I2C Adapter Driver Conformance}
+
+An I2C Adapter driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / I2C Adapter Device / Device Oper=
ation}
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

