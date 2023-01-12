Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v4 20/20] virtio-pmem: Maintain pmem device spec in separate directory
Date: Thu, 12 Jan 2023 23:22:54 +0200
Message-ID: <20230112212254.763783-21-parav@nvidia.com>
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
- added missing pmem entry
- rename device-types/virtio-pmem to device-types/pmem
v2->v3:
- file name changed from device.tex to description.tex
- use input instead of import to insert a file
v1->v2:
- rebased
v0->v1:
- new patch
---
 conformance.tex                               | 20 ++-----------------
 content.tex                                   |  1 +
 .../pmem/description.tex                      |  0
 device-types/pmem/device-conformance.tex      |  9 +++++++++
 device-types/pmem/driver-conformance.tex      |  7 +++++++
 5 files changed, 19 insertions(+), 18 deletions(-)
 rename virtio-pmem.tex =3D> device-types/pmem/description.tex (100%)
 create mode 100644 device-types/pmem/device-conformance.tex
 create mode 100644 device-types/pmem/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index b7171a6..01ccd69 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -151,14 +151,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/i2c/driver-conformance.tex}
 \input{device-types/scmi/driver-conformance.tex}
 \input{device-types/gpio/driver-conformance.tex}
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
+\input{device-types/pmem/driver-conformance.tex}
=20
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device =
Conformance}
=20
@@ -244,16 +237,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/i2c/device-conformance.tex}
 \input{device-types/scmi/device-conformance.tex}
 \input{device-types/gpio/device-conformance.tex}
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
+\input{device-types/pmem/device-conformance.tex}
=20
 \conformance{\section}{Legacy Interface: Transitional Device and Transitio=
nal Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitio=
nal Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
diff --git a/content.tex b/content.tex
index 5a77eb7..0118b8a 100644
--- a/content.tex
+++ b/content.tex
@@ -3021,6 +3021,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/i2c/description.tex}
 \input{device-types/scmi/description.tex}
 \input{device-types/gpio/description.tex}
+\input{device-types/pmem/description.tex}
=20
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
=20
diff --git a/virtio-pmem.tex b/device-types/pmem/description.tex
similarity index 100%
rename from virtio-pmem.tex
rename to device-types/pmem/description.tex
diff --git a/device-types/pmem/device-conformance.tex b/device-types/pmem/d=
evice-conformance.tex
new file mode 100644
index 0000000..e06862c
--- /dev/null
+++ b/device-types/pmem/device-conformance.tex
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
diff --git a/device-types/pmem/driver-conformance.tex b/device-types/pmem/d=
river-conformance.tex
new file mode 100644
index 0000000..620804c
--- /dev/null
+++ b/device-types/pmem/driver-conformance.tex
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

