Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v2 18/20] virtio-scmi: Maintain scmi device spec in separate directory
Date: Mon, 9 Jan 2023 18:28:47 +0200
Message-ID: <20230109162849.463101-19-parav@nvidia.com>
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
- rebased
v0->v1:
- new patch
---
 conformance.tex                               | 22 ++-----------------
 content.tex                                   |  2 +-
 .../virtio-scmi/device-conformance.tex        | 10 +++++++++
 .../virtio-scmi/device.tex                    |  0
 .../virtio-scmi/driver-conformance.tex        |  8 +++++++
 5 files changed, 21 insertions(+), 21 deletions(-)
 create mode 100644 device-types/virtio-scmi/device-conformance.tex
 rename virtio-scmi.tex =3D> device-types/virtio-scmi/device.tex (100%)
 create mode 100644 device-types/virtio-scmi/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index eb656f6..70fdcc0 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -149,15 +149,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-sound/}{driver-conformance}
 \import{device-types/virtio-mem/}{driver-conformance}
 \import{device-types/virtio-i2c/}{driver-conformance}
-
-\conformance{\subsection}{SCMI Driver Conformance}\label{sec:Conformance /=
 Driver Conformance / SCMI Driver Conformance}
-
-An SCMI driver MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{drivernormative:Device Types / SCMI Device / Device Operation /=
 cmdq Operation}
-\item \ref{drivernormative:Device Types / SCMI Device / Device Operation /=
 Setting Up eventq Buffers}
-\end{itemize}
+\import{device-types/virtio-scmi/}{driver-conformance}
=20
 \conformance{\subsection}{GPIO Driver Conformance}\label{sec:Conformance /=
 Driver Conformance / GPIO Driver Conformance}
=20
@@ -259,17 +251,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-sound/}{device-conformance}
 \import{device-types/virtio-mem/}{device-conformance}
 \import{device-types/virtio-i2c/}{device-conformance}
-
-\conformance{\subsection}{SCMI Device Conformance}\label{sec:Conformance /=
 Device Conformance / SCMI Device Conformance}
-
-An SCMI device MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / SCMI Device / Feature bits}
-\item \ref{devicenormative:Device Types / SCMI Device / Device Operation /=
 cmdq Operation}
-\item \ref{devicenormative:Device Types / SCMI Device / Device Operation /=
 eventq Operation}
-\item \ref{devicenormative:Device Types / SCMI Device / Device Operation /=
 Shared Memory Operation}
-\end{itemize}
+\import{device-types/virtio-scmi/}{device-conformance}
=20
 \conformance{\subsection}{GPIO Device Conformance}\label{sec:Conformance /=
 Device Conformance / GPIO Device Conformance}
=20
diff --git a/content.tex b/content.tex
index e2ede6c..5bddc9e 100644
--- a/content.tex
+++ b/content.tex
@@ -3019,7 +3019,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \import{device-types/virtio-sound/}{device}
 \import{device-types/virtio-mem/}{device}
 \import{device-types/virtio-i2c/}{device}
-\input{virtio-scmi.tex}
+\import{device-types/virtio-scmi/}{device}
 \input{virtio-gpio.tex}
 \input{virtio-pmem.tex}
=20
diff --git a/device-types/virtio-scmi/device-conformance.tex b/device-types=
/virtio-scmi/device-conformance.tex
new file mode 100644
index 0000000..570438f
--- /dev/null
+++ b/device-types/virtio-scmi/device-conformance.tex
@@ -0,0 +1,10 @@
+\conformance{\subsection}{SCMI Device Conformance}\label{sec:Conformance /=
 Device Conformance / SCMI Device Conformance}
+
+An SCMI device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / SCMI Device / Feature bits}
+\item \ref{devicenormative:Device Types / SCMI Device / Device Operation /=
 cmdq Operation}
+\item \ref{devicenormative:Device Types / SCMI Device / Device Operation /=
 eventq Operation}
+\item \ref{devicenormative:Device Types / SCMI Device / Device Operation /=
 Shared Memory Operation}
+\end{itemize}
diff --git a/virtio-scmi.tex b/device-types/virtio-scmi/device.tex
similarity index 100%
rename from virtio-scmi.tex
rename to device-types/virtio-scmi/device.tex
diff --git a/device-types/virtio-scmi/driver-conformance.tex b/device-types=
/virtio-scmi/driver-conformance.tex
new file mode 100644
index 0000000..ef163bd
--- /dev/null
+++ b/device-types/virtio-scmi/driver-conformance.tex
@@ -0,0 +1,8 @@
+\conformance{\subsection}{SCMI Driver Conformance}\label{sec:Conformance /=
 Driver Conformance / SCMI Driver Conformance}
+
+An SCMI driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / SCMI Device / Device Operation /=
 cmdq Operation}
+\item \ref{drivernormative:Device Types / SCMI Device / Device Operation /=
 Setting Up eventq Buffers}
+\end{itemize}
--=20
2.26.2

