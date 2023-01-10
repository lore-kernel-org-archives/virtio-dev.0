Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v3 17/20] virtio-i2c: Maintain i2c device spec in separate directory
Date: Wed, 11 Jan 2023 01:03:55 +0200
Message-ID: <20230110230358.528098-18-parav@nvidia.com>
In-Reply-To: <20230110230358.528098-1-parav@nvidia.com>
References: <20230110230358.528098-1-parav@nvidia.com>
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
v2->v3:
- file name changed from device.tex to description.tex
- use input instead of import to insert a file
v1->v2:
- added missing device conformance reference
v0->v1:
- new patch
---
 conformance.tex                                | 18 ++----------------
 content.tex                                    |  2 +-
 .../virtio-i2c/description.tex                 |  0
 device-types/virtio-i2c/device-conformance.tex |  7 +++++++
 device-types/virtio-i2c/driver-conformance.tex |  7 +++++++
 5 files changed, 17 insertions(+), 17 deletions(-)
 rename virtio-i2c.tex =3D> device-types/virtio-i2c/description.tex (100%)
 create mode 100644 device-types/virtio-i2c/device-conformance.tex
 create mode 100644 device-types/virtio-i2c/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 8185cc3..a420249 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -148,14 +148,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/virtio-iommu/driver-conformance.tex}
 \input{device-types/virtio-sound/driver-conformance.tex}
 \input{device-types/virtio-mem/driver-conformance.tex}
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
+\input{device-types/virtio-i2c/driver-conformance.tex}
=20
 \conformance{\subsection}{SCMI Driver Conformance}\label{sec:Conformance /=
 Driver Conformance / SCMI Driver Conformance}
=20
@@ -265,14 +258,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/virtio-iommu/device-conformance.tex}
 \input{device-types/virtio-sound/device-conformance.tex}
 \input{device-types/virtio-mem/device-conformance.tex}
-
-\conformance{\subsection}{I2C Adapter Device Conformance}\label{sec:Confor=
mance / Device Conformance / I2C Adapter Device Conformance}
-
-An I2C Adapter device MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / I2C Adapter Device / Device Oper=
ation}
-\end{itemize}
+\input{device-types/virtio-i2c/device-conformance.tex}
=20
 \conformance{\subsection}{SCMI Device Conformance}\label{sec:Conformance /=
 Device Conformance / SCMI Device Conformance}
=20
diff --git a/content.tex b/content.tex
index 3082b80..db3946a 100644
--- a/content.tex
+++ b/content.tex
@@ -3018,7 +3018,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/virtio-iommu/description.tex}
 \input{device-types/virtio-sound/description.tex}
 \input{device-types/virtio-mem/description.tex}
-\input{virtio-i2c.tex}
+\input{device-types/virtio-i2c/description.tex}
 \input{virtio-scmi.tex}
 \input{virtio-gpio.tex}
 \input{virtio-pmem.tex}
diff --git a/virtio-i2c.tex b/device-types/virtio-i2c/description.tex
similarity index 100%
rename from virtio-i2c.tex
rename to device-types/virtio-i2c/description.tex
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

