Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v2 17/20] virtio-i2c: Maintain i2c device spec in separate directory
Date: Mon, 9 Jan 2023 18:28:46 +0200
Message-ID: <20230109162849.463101-18-parav@nvidia.com>
In-Reply-To: <20230109162849.463101-1-parav@nvidia.com>
References: <20230109162849.463101-1-parav@nvidia.com>
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
v1->v2:
- added missing device conformance reference
v0->v1:
- new patch
---
 conformance.tex                                | 18 ++----------------
 content.tex                                    |  2 +-
 device-types/virtio-i2c/device-conformance.tex |  7 +++++++
 .../virtio-i2c/device.tex                      |  0
 device-types/virtio-i2c/driver-conformance.tex |  7 +++++++
 5 files changed, 17 insertions(+), 17 deletions(-)
 create mode 100644 device-types/virtio-i2c/device-conformance.tex
 rename virtio-i2c.tex =3D> device-types/virtio-i2c/device.tex (100%)
 create mode 100644 device-types/virtio-i2c/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index c43e8db..eb656f6 100644
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
@@ -265,14 +258,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-iommu/}{device-conformance}
 \import{device-types/virtio-sound/}{device-conformance}
 \import{device-types/virtio-mem/}{device-conformance}
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
+\import{device-types/virtio-i2c/}{device-conformance}
=20
 \conformance{\subsection}{SCMI Device Conformance}\label{sec:Conformance /=
 Device Conformance / SCMI Device Conformance}
=20
diff --git a/content.tex b/content.tex
index 6466209..e2ede6c 100644
--- a/content.tex
+++ b/content.tex
@@ -3018,7 +3018,7 @@ \chapter{Device Types}\label{sec:Device Types}
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

