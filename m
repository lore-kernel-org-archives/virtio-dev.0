Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v3 19/20] virtio-gpio: Maintain gpio device spec in separate directory
Date: Wed, 11 Jan 2023 01:03:57 +0200
Message-ID: <20230110230358.528098-20-parav@nvidia.com>
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
 conformance.tex                               | 22 ++-----------------
 content.tex                                   |  4 ++--
 .../virtio-gpio/description.tex               |  0
 .../virtio-gpio/device-conformance.tex        |  9 ++++++++
 .../virtio-gpio/driver-conformance.tex        |  9 ++++++++
 5 files changed, 22 insertions(+), 22 deletions(-)
 rename virtio-gpio.tex =3D> device-types/virtio-gpio/description.tex (100%=
)
 create mode 100644 device-types/virtio-gpio/device-conformance.tex
 create mode 100644 device-types/virtio-gpio/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index ac8981c..1cf2d81 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -150,16 +150,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/virtio-mem/driver-conformance.tex}
 \input{device-types/virtio-i2c/driver-conformance.tex}
 \input{device-types/virtio-scmi/driver-conformance.tex}
-
-\conformance{\subsection}{GPIO Driver Conformance}\label{sec:Conformance /=
 Driver Conformance / GPIO Driver Conformance}
-
-A General Purpose Input/Output (GPIO) driver MUST conform to the following
-normative statements:
-
-\begin{itemize}
-\item \ref{drivernormative:Device Types / GPIO Device / requestq Operation=
}
-\item \ref{drivernormative:Device Types / GPIO Device / eventq Operation}
-\end{itemize}
+\input{device-types/virtio-gpio/driver-conformance.tex}
=20
 \conformance{\subsection}{PMEM Driver Conformance}\label{sec:Conformance /=
 Driver Conformance / PMEM Driver Conformance}
=20
@@ -252,16 +243,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/virtio-mem/device-conformance.tex}
 \input{device-types/virtio-i2c/device-conformance.tex}
 \input{device-types/virtio-scmi/device-conformance.tex}
-
-\conformance{\subsection}{GPIO Device Conformance}\label{sec:Conformance /=
 Device Conformance / GPIO Device Conformance}
-
-A General Purpose Input/Output (GPIO) device MUST conform to the following
-normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / GPIO Device / requestq Operation=
}
-\item \ref{devicenormative:Device Types / GPIO Device / eventq Operation}
-\end{itemize}
+\input{device-types/virtio-gpio/device-conformance.tex}
=20
 \conformance{\subsection}{PMEM Device Conformance}\label{sec:Conformance /=
 Device Conformance / PMEM Device Conformance}
=20
diff --git a/content.tex b/content.tex
index 977a2cd..bc67e63 100644
--- a/content.tex
+++ b/content.tex
@@ -3020,8 +3020,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/virtio-mem/description.tex}
 \input{device-types/virtio-i2c/description.tex}
 \input{device-types/virtio-scmi/description.tex}
-\input{virtio-gpio.tex}
-\input{virtio-pmem.tex}
+\input{device-types/virtio-gpio/description.tex}
+\input{device-types/virtio-pmem/description.tex}
=20
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
=20
diff --git a/virtio-gpio.tex b/device-types/virtio-gpio/description.tex
similarity index 100%
rename from virtio-gpio.tex
rename to device-types/virtio-gpio/description.tex
diff --git a/device-types/virtio-gpio/device-conformance.tex b/device-types=
/virtio-gpio/device-conformance.tex
new file mode 100644
index 0000000..87806d0
--- /dev/null
+++ b/device-types/virtio-gpio/device-conformance.tex
@@ -0,0 +1,9 @@
+\conformance{\subsection}{GPIO Device Conformance}\label{sec:Conformance /=
 Device Conformance / GPIO Device Conformance}
+
+A General Purpose Input/Output (GPIO) device MUST conform to the following
+normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / GPIO Device / requestq Operation=
}
+\item \ref{devicenormative:Device Types / GPIO Device / eventq Operation}
+\end{itemize}
diff --git a/device-types/virtio-gpio/driver-conformance.tex b/device-types=
/virtio-gpio/driver-conformance.tex
new file mode 100644
index 0000000..b778c2b
--- /dev/null
+++ b/device-types/virtio-gpio/driver-conformance.tex
@@ -0,0 +1,9 @@
+\conformance{\subsection}{GPIO Driver Conformance}\label{sec:Conformance /=
 Driver Conformance / GPIO Driver Conformance}
+
+A General Purpose Input/Output (GPIO) driver MUST conform to the following
+normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / GPIO Device / requestq Operation=
}
+\item \ref{drivernormative:Device Types / GPIO Device / eventq Operation}
+\end{itemize}
--=20
2.26.2

