Return-Path: <virtio-comment-return-3641-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sun, 1 Jan 2023 20:08:23 +0200
Message-ID: <20230101180824.325172-20-parav@nvidia.com>
In-Reply-To: <20230101180824.325172-1-parav@nvidia.com>
References: <20230101180824.325172-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v1 19/20] virtio-gpio: Maintain gpio device spec in separate directory
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
 conformance.tex                               | 21 +------------------
 content.tex                                   |  2 +-
 .../virtio-gpio/device-conformance.tex        |  9 ++++++++
 .../virtio-gpio/device.tex                    |  0
 .../virtio-gpio/driver-conformance.tex        |  9 ++++++++
 5 files changed, 20 insertions(+), 21 deletions(-)
 create mode 100644 device-types/virtio-gpio/device-conformance.tex
 rename virtio-gpio.tex =3D> device-types/virtio-gpio/device.tex (100%)
 create mode 100644 device-types/virtio-gpio/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 66ebff1..01c5782 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -150,16 +150,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-mem/}{driver-conformance}
 \import{device-types/virtio-i2c/}{driver-conformance}
 \import{device-types/virtio-scmi/}{driver-conformance}
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
+\import{device-types/virtio-gpio/}{driver-conformance}
=20
 \conformance{\subsection}{PMEM Driver Conformance}\label{sec:Conformance /=
 Driver Conformance / PMEM Driver Conformance}
=20
@@ -251,16 +242,6 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-mem/}{device-conformance}
 \import{device-types/virtio-scmi/}{device-conformance}
=20
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
-
 \conformance{\subsection}{PMEM Device Conformance}\label{sec:Conformance /=
 Device Conformance / PMEM Device Conformance}
=20
 A PMEM device MUST conform to the following normative statements:
diff --git a/content.tex b/content.tex
index b646a43..fd4890b 100644
--- a/content.tex
+++ b/content.tex
@@ -3019,7 +3019,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \import{device-types/virtio-mem/}{device}
 \import{device-types/virtio-i2c/}{device}
 \import{device-types/virtio-scmi/}{device}
-\input{virtio-gpio.tex}
+\import{device-types/virtio-gpio/}{device}
 \input{virtio-pmem.tex}
=20
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
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
diff --git a/virtio-gpio.tex b/device-types/virtio-gpio/device.tex
similarity index 100%
rename from virtio-gpio.tex
rename to device-types/virtio-gpio/device.tex
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

