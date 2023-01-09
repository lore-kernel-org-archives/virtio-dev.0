Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v2 16/20] virtio-mem: Maintain memory device spec in separate directory
Date: Mon, 9 Jan 2023 18:28:45 +0200
Message-ID: <20230109162849.463101-17-parav@nvidia.com>
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
 conformance.tex                               | 30 ++-----------------
 content.tex                                   |  2 +-
 .../virtio-mem/device-conformance.tex         | 13 ++++++++
 .../virtio-mem/device.tex                     |  0
 .../virtio-mem/driver-conformance.tex         | 13 ++++++++
 5 files changed, 29 insertions(+), 29 deletions(-)
 create mode 100644 device-types/virtio-mem/device-conformance.tex
 rename virtio-mem.tex =3D> device-types/virtio-mem/device.tex (100%)
 create mode 100644 device-types/virtio-mem/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 6f465a3..c43e8db 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -147,20 +147,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-rpmb/}{driver-conformance}
 \import{device-types/virtio-iommu/}{driver-conformance}
 \import{device-types/virtio-sound/}{driver-conformance}
-
-\conformance{\subsection}{Memory Driver Conformance}\label{sec:Conformance=
 / Driver Conformance / Memory Driver Conformance}
-
-A memory driver MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{drivernormative:Device Types / Memory Device / Device configura=
tion layout}
-\item \ref{drivernormative:Device Types / Memory Device / Device Initializ=
ation}
-\item \ref{drivernormative:Device Types / Memory Device / Device Operation=
}
-\item \ref{drivernormative:Device Types / Memory Device / Device Operation=
 / PLUG request}
-\item \ref{drivernormative:Device Types / Memory Device / Device Operation=
 / UNPLUG request}
-\item \ref{drivernormative:Device Types / Memory Device / Device Operation=
 / UNPLUG ALL request}
-\item \ref{drivernormative:Device Types / Memory Device / Device Operation=
 / STATE request}
-\end{itemize}
+\import{device-types/virtio-mem/}{driver-conformance}
=20
 \conformance{\subsection}{I2C Adapter Driver Conformance}\label{sec:Confor=
mance / Driver Conformance / I2C Adapter Driver Conformance}
=20
@@ -277,20 +264,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-rpmb/}{device-conformance}
 \import{device-types/virtio-iommu/}{device-conformance}
 \import{device-types/virtio-sound/}{device-conformance}
-
-\conformance{\subsection}{Memory Device Conformance}\label{sec:Conformance=
 / Device Conformance / Memory Device Conformance}
-
-A memory device MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / Memory Device / Device configura=
tion layout}
-\item \ref{devicenormative:Device Types / Memory Device / Device Initializ=
ation}
-\item \ref{devicenormative:Device Types / Memory Device / Device Operation=
}
-\item \ref{devicenormative:Device Types / Memory Device / Device Operation=
 / PLUG request}
-\item \ref{devicenormative:Device Types / Memory Device / Device Operation=
 / UNPLUG request}
-\item \ref{devicenormative:Device Types / Memory Device / Device Operation=
 / UNPLUG ALL request}
-\item \ref{devicenormative:Device Types / Memory Device / Device Operation=
 / STATE request}
-\end{itemize}
+\import{device-types/virtio-mem/}{device-conformance}
=20
 \conformance{\subsection}{I2C Adapter Device Conformance}\label{sec:Confor=
mance / Device Conformance / I2C Adapter Device Conformance}
=20
diff --git a/content.tex b/content.tex
index 65d8532..6466209 100644
--- a/content.tex
+++ b/content.tex
@@ -3017,7 +3017,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \import{device-types/virtio-rpmb/}{device}
 \import{device-types/virtio-iommu/}{device}
 \import{device-types/virtio-sound/}{device}
-\input{virtio-mem.tex}
+\import{device-types/virtio-mem/}{device}
 \input{virtio-i2c.tex}
 \input{virtio-scmi.tex}
 \input{virtio-gpio.tex}
diff --git a/device-types/virtio-mem/device-conformance.tex b/device-types/=
virtio-mem/device-conformance.tex
new file mode 100644
index 0000000..562d00b
--- /dev/null
+++ b/device-types/virtio-mem/device-conformance.tex
@@ -0,0 +1,13 @@
+\conformance{\subsection}{Memory Device Conformance}\label{sec:Conformance=
 / Device Conformance / Memory Device Conformance}
+
+A memory device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / Memory Device / Device configura=
tion layout}
+\item \ref{devicenormative:Device Types / Memory Device / Device Initializ=
ation}
+\item \ref{devicenormative:Device Types / Memory Device / Device Operation=
}
+\item \ref{devicenormative:Device Types / Memory Device / Device Operation=
 / PLUG request}
+\item \ref{devicenormative:Device Types / Memory Device / Device Operation=
 / UNPLUG request}
+\item \ref{devicenormative:Device Types / Memory Device / Device Operation=
 / UNPLUG ALL request}
+\item \ref{devicenormative:Device Types / Memory Device / Device Operation=
 / STATE request}
+\end{itemize}
diff --git a/virtio-mem.tex b/device-types/virtio-mem/device.tex
similarity index 100%
rename from virtio-mem.tex
rename to device-types/virtio-mem/device.tex
diff --git a/device-types/virtio-mem/driver-conformance.tex b/device-types/=
virtio-mem/driver-conformance.tex
new file mode 100644
index 0000000..553dd57
--- /dev/null
+++ b/device-types/virtio-mem/driver-conformance.tex
@@ -0,0 +1,13 @@
+\conformance{\subsection}{Memory Driver Conformance}\label{sec:Conformance=
 / Driver Conformance / Memory Driver Conformance}
+
+A memory driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Memory Device / Device configura=
tion layout}
+\item \ref{drivernormative:Device Types / Memory Device / Device Initializ=
ation}
+\item \ref{drivernormative:Device Types / Memory Device / Device Operation=
}
+\item \ref{drivernormative:Device Types / Memory Device / Device Operation=
 / PLUG request}
+\item \ref{drivernormative:Device Types / Memory Device / Device Operation=
 / UNPLUG request}
+\item \ref{drivernormative:Device Types / Memory Device / Device Operation=
 / UNPLUG ALL request}
+\item \ref{drivernormative:Device Types / Memory Device / Device Operation=
 / STATE request}
+\end{itemize}
--=20
2.26.2

