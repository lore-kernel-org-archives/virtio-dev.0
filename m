Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v3 18/20] virtio-scmi: Maintain scmi device spec in separate directory
Date: Wed, 11 Jan 2023 01:03:56 +0200
Message-ID: <20230110230358.528098-19-parav@nvidia.com>
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
- rebased
v0->v1:
- new patch
---
 conformance.tex                               | 22 ++-----------------
 content.tex                                   |  2 +-
 .../virtio-scmi/description.tex               |  0
 .../virtio-scmi/device-conformance.tex        | 10 +++++++++
 .../virtio-scmi/driver-conformance.tex        |  8 +++++++
 5 files changed, 21 insertions(+), 21 deletions(-)
 rename virtio-scmi.tex =3D> device-types/virtio-scmi/description.tex (100%=
)
 create mode 100644 device-types/virtio-scmi/device-conformance.tex
 create mode 100644 device-types/virtio-scmi/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index a420249..ac8981c 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -149,15 +149,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/virtio-sound/driver-conformance.tex}
 \input{device-types/virtio-mem/driver-conformance.tex}
 \input{device-types/virtio-i2c/driver-conformance.tex}
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
+\input{device-types/virtio-scmi/driver-conformance.tex}
=20
 \conformance{\subsection}{GPIO Driver Conformance}\label{sec:Conformance /=
 Driver Conformance / GPIO Driver Conformance}
=20
@@ -259,17 +251,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/virtio-sound/device-conformance.tex}
 \input{device-types/virtio-mem/device-conformance.tex}
 \input{device-types/virtio-i2c/device-conformance.tex}
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
+\input{device-types/virtio-scmi/device-conformance.tex}
=20
 \conformance{\subsection}{GPIO Device Conformance}\label{sec:Conformance /=
 Device Conformance / GPIO Device Conformance}
=20
diff --git a/content.tex b/content.tex
index db3946a..977a2cd 100644
--- a/content.tex
+++ b/content.tex
@@ -3019,7 +3019,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/virtio-sound/description.tex}
 \input{device-types/virtio-mem/description.tex}
 \input{device-types/virtio-i2c/description.tex}
-\input{virtio-scmi.tex}
+\input{device-types/virtio-scmi/description.tex}
 \input{virtio-gpio.tex}
 \input{virtio-pmem.tex}
=20
diff --git a/virtio-scmi.tex b/device-types/virtio-scmi/description.tex
similarity index 100%
rename from virtio-scmi.tex
rename to device-types/virtio-scmi/description.tex
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

