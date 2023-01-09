Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v2 09/20] virtio-input: Maintain input device spec in separate directory
Date: Mon, 9 Jan 2023 18:28:38 +0200
Message-ID: <20230109162849.463101-10-parav@nvidia.com>
In-Reply-To: <20230109162849.463101-1-parav@nvidia.com>
References: <20230109162849.463101-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Move virtio input device specification to its own file similar to
recent virtio devices.
While at it, place device specification, its driver and device
conformance into its own directory to have self contained device
specification.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v0->v1:
- moved to device specific directory
---
 conformance.tex                               | 20 ++-----------------
 content.tex                                   |  2 +-
 .../virtio-input/device-conformance.tex       |  8 ++++++++
 .../virtio-input/device.tex                   |  0
 .../virtio-input/driver-conformance.tex       |  8 ++++++++
 5 files changed, 19 insertions(+), 19 deletions(-)
 create mode 100644 device-types/virtio-input/device-conformance.tex
 rename virtio-input.tex =3D> device-types/virtio-input/device.tex (100%)
 create mode 100644 device-types/virtio-input/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 432b03c..8470e52 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -140,15 +140,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-entropy/}{driver-conformance}
 \import{device-types/virtio-mem-balloon/}{driver-conformance}
 \import{device-types/virtio-scsi/}{driver-conformance}
-
-\conformance{\subsection}{Input Driver Conformance}\label{sec:Conformance =
/ Driver Conformance / Input Driver Conformance}
-
-An input driver MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{drivernormative:Device Types / Input Device / Device Initializa=
tion}
-\item \ref{drivernormative:Device Types / Input Device / Device Operation}
-\end{itemize}
+\import{device-types/virtio-input/}{driver-conformance}
=20
 \conformance{\subsection}{Crypto Driver Conformance}\label{sec:Conformance=
 / Driver Conformance / Crypto Driver Conformance}
=20
@@ -348,15 +340,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \import{device-types/virtio-mem-balloon/}{device-conformance}
 \import{device-types/virtio-scsi/}{device-conformance}
 \import{device-types/virtio-gpu/}{device-conformance}
-
-\conformance{\subsection}{Input Device Conformance}\label{sec:Conformance =
/ Device Conformance / Input Device Conformance}
-
-An input device MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / Input Device / Device Initializa=
tion}
-\item \ref{devicenormative:Device Types / Input Device / Device Operation}
-\end{itemize}
+\import{device-types/virtio-input/}{device-conformance}
=20
 \conformance{\subsection}{Crypto Device Conformance}\label{sec:Conformance=
 / Device Conformance / Crypto Device Conformance}
=20
diff --git a/content.tex b/content.tex
index 4f16ad8..b1d8474 100644
--- a/content.tex
+++ b/content.tex
@@ -3010,7 +3010,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \import{device-types/virtio-mem-balloon/}{device}
 \import{device-types/virtio-scsi/}{device}
 \import{device-types/virtio-gpu/}{device}
-\input{virtio-input.tex}
+\import{device-types/virtio-input/}{device}
 \input{virtio-crypto.tex}
 \input{virtio-vsock.tex}
 \input{virtio-fs.tex}
diff --git a/device-types/virtio-input/device-conformance.tex b/device-type=
s/virtio-input/device-conformance.tex
new file mode 100644
index 0000000..173cdd6
--- /dev/null
+++ b/device-types/virtio-input/device-conformance.tex
@@ -0,0 +1,8 @@
+\conformance{\subsection}{Input Device Conformance}\label{sec:Conformance =
/ Device Conformance / Input Device Conformance}
+
+An input device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / Input Device / Device Initializa=
tion}
+\item \ref{devicenormative:Device Types / Input Device / Device Operation}
+\end{itemize}
diff --git a/virtio-input.tex b/device-types/virtio-input/device.tex
similarity index 100%
rename from virtio-input.tex
rename to device-types/virtio-input/device.tex
diff --git a/device-types/virtio-input/driver-conformance.tex b/device-type=
s/virtio-input/driver-conformance.tex
new file mode 100644
index 0000000..5eb9dac
--- /dev/null
+++ b/device-types/virtio-input/driver-conformance.tex
@@ -0,0 +1,8 @@
+\conformance{\subsection}{Input Driver Conformance}\label{sec:Conformance =
/ Driver Conformance / Input Driver Conformance}
+
+An input driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Input Device / Device Initializa=
tion}
+\item \ref{drivernormative:Device Types / Input Device / Device Operation}
+\end{itemize}
--=20
2.26.2

