Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v4 19/20] virtio-gpio: Maintain gpio device spec in separate directory
Date: Thu, 12 Jan 2023 23:22:53 +0200
Message-ID: <20230112212254.763783-20-parav@nvidia.com>
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
- rename device-types/virtio-gpio to device-types/gpio
- moved pmem entry to pmem specific patch
v2->v3:
- file name changed from device.tex to description.tex
- use input instead of import to insert a file
v1->v2:
- added missing device conformance reference
v0->v1:
- new patch
---
 conformance.tex                               | 22 ++-----------------
 content.tex                                   |  3 +--
 .../gpio/description.tex                      |  0
 device-types/gpio/device-conformance.tex      |  9 ++++++++
 device-types/gpio/driver-conformance.tex      |  9 ++++++++
 5 files changed, 21 insertions(+), 22 deletions(-)
 rename virtio-gpio.tex =3D> device-types/gpio/description.tex (100%)
 create mode 100644 device-types/gpio/device-conformance.tex
 create mode 100644 device-types/gpio/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 64217ac..b7171a6 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -150,16 +150,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/mem/driver-conformance.tex}
 \input{device-types/i2c/driver-conformance.tex}
 \input{device-types/scmi/driver-conformance.tex}
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
+\input{device-types/gpio/driver-conformance.tex}
=20
 \conformance{\subsection}{PMEM Driver Conformance}\label{sec:Conformance /=
 Driver Conformance / PMEM Driver Conformance}
=20
@@ -252,16 +243,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/mem/device-conformance.tex}
 \input{device-types/i2c/device-conformance.tex}
 \input{device-types/scmi/device-conformance.tex}
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
+\input{device-types/gpio/device-conformance.tex}
=20
 \conformance{\subsection}{PMEM Device Conformance}\label{sec:Conformance /=
 Device Conformance / PMEM Device Conformance}
=20
diff --git a/content.tex b/content.tex
index 430037d..5a77eb7 100644
--- a/content.tex
+++ b/content.tex
@@ -3020,8 +3020,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/mem/description.tex}
 \input{device-types/i2c/description.tex}
 \input{device-types/scmi/description.tex}
-\input{virtio-gpio.tex}
-\input{virtio-pmem.tex}
+\input{device-types/gpio/description.tex}
=20
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
=20
diff --git a/virtio-gpio.tex b/device-types/gpio/description.tex
similarity index 100%
rename from virtio-gpio.tex
rename to device-types/gpio/description.tex
diff --git a/device-types/gpio/device-conformance.tex b/device-types/gpio/d=
evice-conformance.tex
new file mode 100644
index 0000000..87806d0
--- /dev/null
+++ b/device-types/gpio/device-conformance.tex
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
diff --git a/device-types/gpio/driver-conformance.tex b/device-types/gpio/d=
river-conformance.tex
new file mode 100644
index 0000000..b778c2b
--- /dev/null
+++ b/device-types/gpio/driver-conformance.tex
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

