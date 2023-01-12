Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v4 09/20] virtio-input: Maintain input device spec in separate directory
Date: Thu, 12 Jan 2023 23:22:43 +0200
Message-ID: <20230112212254.763783-10-parav@nvidia.com>
In-Reply-To: <20230112212254.763783-1-parav@nvidia.com>
References: <20230112212254.763783-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, david@redhat.com, Parav Pandit <parav@nvidia.com>
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
v3->v4:
- rename device-types/virtio-input to device-types/input
v2->v3:
- use input instead of import to insert a file
v0->v1:
- moved to device specific directory
---
 conformance.tex                               | 20 ++-----------------
 content.tex                                   |  2 +-
 .../input/description.tex                     |  0
 device-types/input/device-conformance.tex     |  8 ++++++++
 device-types/input/driver-conformance.tex     |  8 ++++++++
 5 files changed, 19 insertions(+), 19 deletions(-)
 rename virtio-input.tex =3D> device-types/input/description.tex (100%)
 create mode 100644 device-types/input/device-conformance.tex
 create mode 100644 device-types/input/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index d5356f1..0bf96b1 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -140,15 +140,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/entropy/driver-conformance.tex}
 \input{device-types/balloon/driver-conformance.tex}
 \input{device-types/scsi/driver-conformance.tex}
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
+\input{device-types/input/driver-conformance.tex}
=20
 \conformance{\subsection}{Crypto Driver Conformance}\label{sec:Conformance=
 / Driver Conformance / Crypto Driver Conformance}
=20
@@ -348,15 +340,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/balloon/device-conformance.tex}
 \input{device-types/scsi/device-conformance.tex}
 \input{device-types/gpu/device-conformance.tex}
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
+\input{device-types/input/device-conformance.tex}
=20
 \conformance{\subsection}{Crypto Device Conformance}\label{sec:Conformance=
 / Device Conformance / Crypto Device Conformance}
=20
diff --git a/content.tex b/content.tex
index ca55bae..c1a97ad 100644
--- a/content.tex
+++ b/content.tex
@@ -3010,7 +3010,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/balloon/description.tex}
 \input{device-types/scsi/description.tex}
 \input{device-types/gpu/description.tex}
-\input{virtio-input.tex}
+\input{device-types/input/description.tex}
 \input{virtio-crypto.tex}
 \input{virtio-vsock.tex}
 \input{virtio-fs.tex}
diff --git a/virtio-input.tex b/device-types/input/description.tex
similarity index 100%
rename from virtio-input.tex
rename to device-types/input/description.tex
diff --git a/device-types/input/device-conformance.tex b/device-types/input=
/device-conformance.tex
new file mode 100644
index 0000000..173cdd6
--- /dev/null
+++ b/device-types/input/device-conformance.tex
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
diff --git a/device-types/input/driver-conformance.tex b/device-types/input=
/driver-conformance.tex
new file mode 100644
index 0000000..5eb9dac
--- /dev/null
+++ b/device-types/input/driver-conformance.tex
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

