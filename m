Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v4 16/20] virtio-mem: Maintain memory device spec in separate directory
Date: Thu, 12 Jan 2023 23:22:50 +0200
Message-ID: <20230112212254.763783-17-parav@nvidia.com>
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
- rename device-types/virtio-mem to device-types/mem
v2->v3:
- file name changed from device.tex to description.tex
- use input instead of import to insert a file
v1->v2:
- rebased
v0->v1:
- new patch
---
 conformance.tex                               | 30 ++-----------------
 content.tex                                   |  2 +-
 .../mem/description.tex                       |  0
 device-types/mem/device-conformance.tex       | 13 ++++++++
 device-types/mem/driver-conformance.tex       | 13 ++++++++
 5 files changed, 29 insertions(+), 29 deletions(-)
 rename virtio-mem.tex =3D> device-types/mem/description.tex (100%)
 create mode 100644 device-types/mem/device-conformance.tex
 create mode 100644 device-types/mem/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 5f3a769..5c01397 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -147,20 +147,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/rpmb/driver-conformance.tex}
 \input{device-types/iommu/driver-conformance.tex}
 \input{device-types/sound/driver-conformance.tex}
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
+\input{device-types/mem/driver-conformance.tex}
=20
 \conformance{\subsection}{I2C Adapter Driver Conformance}\label{sec:Confor=
mance / Driver Conformance / I2C Adapter Driver Conformance}
=20
@@ -277,20 +264,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/rpmb/device-conformance.tex}
 \input{device-types/iommu/device-conformance.tex}
 \input{device-types/sound/device-conformance.tex}
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
+\input{device-types/mem/device-conformance.tex}
=20
 \conformance{\subsection}{I2C Adapter Device Conformance}\label{sec:Confor=
mance / Device Conformance / I2C Adapter Device Conformance}
=20
diff --git a/content.tex b/content.tex
index 7a41b54..7175567 100644
--- a/content.tex
+++ b/content.tex
@@ -3017,7 +3017,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/rpmb/description.tex}
 \input{device-types/iommu/description.tex}
 \input{device-types/sound/description.tex}
-\input{virtio-mem.tex}
+\input{device-types/mem/description.tex}
 \input{virtio-i2c.tex}
 \input{virtio-scmi.tex}
 \input{virtio-gpio.tex}
diff --git a/virtio-mem.tex b/device-types/mem/description.tex
similarity index 100%
rename from virtio-mem.tex
rename to device-types/mem/description.tex
diff --git a/device-types/mem/device-conformance.tex b/device-types/mem/dev=
ice-conformance.tex
new file mode 100644
index 0000000..562d00b
--- /dev/null
+++ b/device-types/mem/device-conformance.tex
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
diff --git a/device-types/mem/driver-conformance.tex b/device-types/mem/dri=
ver-conformance.tex
new file mode 100644
index 0000000..553dd57
--- /dev/null
+++ b/device-types/mem/driver-conformance.tex
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

