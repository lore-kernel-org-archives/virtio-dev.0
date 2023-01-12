Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v4 17/20] virtio-i2c: Maintain i2c device spec in separate directory
Date: Thu, 12 Jan 2023 23:22:51 +0200
Message-ID: <20230112212254.763783-18-parav@nvidia.com>
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
- rename device-types/virtio-i2c to device-types/i2c
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
 .../i2c/description.tex                        |  0
 device-types/i2c/device-conformance.tex        |  7 +++++++
 device-types/i2c/driver-conformance.tex        |  7 +++++++
 5 files changed, 17 insertions(+), 17 deletions(-)
 rename virtio-i2c.tex =3D> device-types/i2c/description.tex (100%)
 create mode 100644 device-types/i2c/device-conformance.tex
 create mode 100644 device-types/i2c/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 5c01397..4dde92d 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -148,14 +148,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/iommu/driver-conformance.tex}
 \input{device-types/sound/driver-conformance.tex}
 \input{device-types/mem/driver-conformance.tex}
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
+\input{device-types/i2c/driver-conformance.tex}
=20
 \conformance{\subsection}{SCMI Driver Conformance}\label{sec:Conformance /=
 Driver Conformance / SCMI Driver Conformance}
=20
@@ -265,14 +258,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/iommu/device-conformance.tex}
 \input{device-types/sound/device-conformance.tex}
 \input{device-types/mem/device-conformance.tex}
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
+\input{device-types/i2c/device-conformance.tex}
=20
 \conformance{\subsection}{SCMI Device Conformance}\label{sec:Conformance /=
 Device Conformance / SCMI Device Conformance}
=20
diff --git a/content.tex b/content.tex
index 7175567..a6655e8 100644
--- a/content.tex
+++ b/content.tex
@@ -3018,7 +3018,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/iommu/description.tex}
 \input{device-types/sound/description.tex}
 \input{device-types/mem/description.tex}
-\input{virtio-i2c.tex}
+\input{device-types/i2c/description.tex}
 \input{virtio-scmi.tex}
 \input{virtio-gpio.tex}
 \input{virtio-pmem.tex}
diff --git a/virtio-i2c.tex b/device-types/i2c/description.tex
similarity index 100%
rename from virtio-i2c.tex
rename to device-types/i2c/description.tex
diff --git a/device-types/i2c/device-conformance.tex b/device-types/i2c/dev=
ice-conformance.tex
new file mode 100644
index 0000000..a060b2f
--- /dev/null
+++ b/device-types/i2c/device-conformance.tex
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
diff --git a/device-types/i2c/driver-conformance.tex b/device-types/i2c/dri=
ver-conformance.tex
new file mode 100644
index 0000000..405714c
--- /dev/null
+++ b/device-types/i2c/driver-conformance.tex
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

