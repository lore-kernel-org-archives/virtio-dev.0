Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v2 20/20] virtio-pmem: Maintain pmem device spec in separate directory
Date: Mon, 9 Jan 2023 18:28:49 +0200
Message-ID: <20230109162849.463101-21-parav@nvidia.com>
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
 conformance.tex                               | 20 ++-----------------
 content.tex                                   |  2 +-
 .../virtio-pmem/device-conformance.tex        |  9 +++++++++
 .../virtio-pmem/device.tex                    |  0
 .../virtio-pmem/driver-conformance.tex        |  7 +++++++
 5 files changed, 19 insertions(+), 19 deletions(-)
 create mode 100644 device-types/virtio-pmem/device-conformance.tex
 rename virtio-pmem.tex =3D> device-types/virtio-pmem/device.tex (100%)
 create mode 100644 device-types/virtio-pmem/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 34d72e5..57194b2 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -151,14 +151,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-i2c/}{driver-conformance}
 \import{device-types/virtio-scmi/}{driver-conformance}
 \import{device-types/virtio-gpio/}{driver-conformance}
-
-\conformance{\subsection}{PMEM Driver Conformance}\label{sec:Conformance /=
 Driver Conformance / PMEM Driver Conformance}
-
-A PMEM driver MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{drivernormative:Device Types / PMEM Device / Device Initializat=
ion}
-\end{itemize}
+\import{device-types/virtio-pmem/}{driver-conformance}
=20
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device =
Conformance}
=20
@@ -244,16 +237,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-i2c/}{device-conformance}
 \import{device-types/virtio-scmi/}{device-conformance}
 \import{device-types/virtio-gpio/}{device-conformance}
-
-\conformance{\subsection}{PMEM Device Conformance}\label{sec:Conformance /=
 Device Conformance / PMEM Device Conformance}
-
-A PMEM device MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / PMEM Device / Device Initializat=
ion}
-\item \ref{devicenormative:Device Types / PMEM Device / Device Operation /=
 Virtqueue flush}
-\item \ref{devicenormative:Device Types / PMEM Device / Device Operation /=
 Virtqueue return}
-\end{itemize}
+\import{device-types/virtio-pmem/}{device-conformance}
=20
 \conformance{\section}{Legacy Interface: Transitional Device and Transitio=
nal Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitio=
nal Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
diff --git a/content.tex b/content.tex
index dc0943c..e1f8450 100644
--- a/content.tex
+++ b/content.tex
@@ -3021,7 +3021,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \import{device-types/virtio-i2c/}{device}
 \import{device-types/virtio-scmi/}{device}
 \import{device-types/virtio-gpio/}{device}
-\input{virtio-pmem.tex}
+\import{device-types/virtio-pmem/}{device}
=20
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
=20
diff --git a/device-types/virtio-pmem/device-conformance.tex b/device-types=
/virtio-pmem/device-conformance.tex
new file mode 100644
index 0000000..e06862c
--- /dev/null
+++ b/device-types/virtio-pmem/device-conformance.tex
@@ -0,0 +1,9 @@
+\conformance{\subsection}{PMEM Device Conformance}\label{sec:Conformance /=
 Device Conformance / PMEM Device Conformance}
+
+A PMEM device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / PMEM Device / Device Initializat=
ion}
+\item \ref{devicenormative:Device Types / PMEM Device / Device Operation /=
 Virtqueue flush}
+\item \ref{devicenormative:Device Types / PMEM Device / Device Operation /=
 Virtqueue return}
+\end{itemize}
diff --git a/virtio-pmem.tex b/device-types/virtio-pmem/device.tex
similarity index 100%
rename from virtio-pmem.tex
rename to device-types/virtio-pmem/device.tex
diff --git a/device-types/virtio-pmem/driver-conformance.tex b/device-types=
/virtio-pmem/driver-conformance.tex
new file mode 100644
index 0000000..620804c
--- /dev/null
+++ b/device-types/virtio-pmem/driver-conformance.tex
@@ -0,0 +1,7 @@
+\conformance{\subsection}{PMEM Driver Conformance}\label{sec:Conformance /=
 Driver Conformance / PMEM Driver Conformance}
+
+A PMEM driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / PMEM Device / Device Initializat=
ion}
+\end{itemize}
--=20
2.26.2

