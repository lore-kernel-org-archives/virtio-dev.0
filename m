Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v4 10/20] virtio-crypto: Maintain crypto device spec in separate directory
Date: Thu, 12 Jan 2023 23:22:44 +0200
Message-ID: <20230112212254.763783-11-parav@nvidia.com>
In-Reply-To: <20230112212254.763783-1-parav@nvidia.com>
References: <20230112212254.763783-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, david@redhat.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Move virtio crypto device specification to its own file similar to
recent virtio devices.
While at it, place device specification, its driver and device
conformance into its own directory to have self contained device
specification.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v3->v4:
- rename device-types/virtio-crypto to device-types/crypto
v2->v3:
- file name changed from device.tex to description.tex
- use input instead of import to insert a file
v0->v1:
- moved to device specific directory
---
 conformance.tex                               | 31 ++-----------------
 content.tex                                   |  2 +-
 .../crypto/description.tex                    |  0
 device-types/crypto/device-conformance.tex    | 13 ++++++++
 device-types/crypto/driver-conformance.tex    | 14 +++++++++
 5 files changed, 30 insertions(+), 30 deletions(-)
 rename virtio-crypto.tex =3D> device-types/crypto/description.tex (100%)
 create mode 100644 device-types/crypto/device-conformance.tex
 create mode 100644 device-types/crypto/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 0bf96b1..970ef12 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -141,21 +141,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/balloon/driver-conformance.tex}
 \input{device-types/scsi/driver-conformance.tex}
 \input{device-types/input/driver-conformance.tex}
-
-\conformance{\subsection}{Crypto Driver Conformance}\label{sec:Conformance=
 / Driver Conformance / Crypto Driver Conformance}
-
-A Crypto driver MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{drivernormative:Device Types / Crypto Device / Device configura=
tion layout}
-\item \ref{drivernormative:Device Types / Crypto Device / Device Initializ=
ation}
-\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / Control Virtqueue / Session operation / Session operation: create sessio=
n}
-\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / Control Virtqueue / Session operation / Session operation: destroy sessi=
on}
-\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / HASH Service Operation}
-\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / MAC Service Operation}
-\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / Symmetric algorithms Operation}
-\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / AEAD Service Operation}
-\end{itemize}
+\input{device-types/crypto/driver-conformance.tex}
=20
 \conformance{\subsection}{Socket Driver Conformance}\label{sec:Conformance=
 / Driver Conformance / Socket Driver Conformance}
=20
@@ -341,20 +327,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/scsi/device-conformance.tex}
 \input{device-types/gpu/device-conformance.tex}
 \input{device-types/input/device-conformance.tex}
-
-\conformance{\subsection}{Crypto Device Conformance}\label{sec:Conformance=
 / Device Conformance / Crypto Device Conformance}
-
-A Crypto device MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / Crypto Device / Device configura=
tion layout}
-\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / Control Virtqueue / Session operation / Session operation: create sessio=
n}
-\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / Control Virtqueue / Session operation / Session operation: destroy sessi=
on}
-\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / HASH Service Operation}
-\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / MAC Service Operation}
-\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / Symmetric algorithms Operation}
-\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / AEAD Service Operation}
-\end{itemize}
+\input{device-types/crypto/device-conformance.tex}
=20
 \conformance{\subsection}{Socket Device Conformance}\label{sec:Conformance=
 / Device Conformance / Socket Device Conformance}
=20
diff --git a/content.tex b/content.tex
index c1a97ad..2ee50d3 100644
--- a/content.tex
+++ b/content.tex
@@ -3011,7 +3011,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/scsi/description.tex}
 \input{device-types/gpu/description.tex}
 \input{device-types/input/description.tex}
-\input{virtio-crypto.tex}
+\input{device-types/crypto/description.tex}
 \input{virtio-vsock.tex}
 \input{virtio-fs.tex}
 \input{virtio-rpmb.tex}
diff --git a/virtio-crypto.tex b/device-types/crypto/description.tex
similarity index 100%
rename from virtio-crypto.tex
rename to device-types/crypto/description.tex
diff --git a/device-types/crypto/device-conformance.tex b/device-types/cryp=
to/device-conformance.tex
new file mode 100644
index 0000000..1667120
--- /dev/null
+++ b/device-types/crypto/device-conformance.tex
@@ -0,0 +1,13 @@
+\conformance{\subsection}{Crypto Device Conformance}\label{sec:Conformance=
 / Device Conformance / Crypto Device Conformance}
+
+A Crypto device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / Crypto Device / Device configura=
tion layout}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / Control Virtqueue / Session operation / Session operation: create sessio=
n}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / Control Virtqueue / Session operation / Session operation: destroy sessi=
on}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / HASH Service Operation}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / MAC Service Operation}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / Symmetric algorithms Operation}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation=
 / AEAD Service Operation}
+\end{itemize}
diff --git a/device-types/crypto/driver-conformance.tex b/device-types/cryp=
to/driver-conformance.tex
new file mode 100644
index 0000000..672d0f6
--- /dev/null
+++ b/device-types/crypto/driver-conformance.tex
@@ -0,0 +1,14 @@
+\conformance{\subsection}{Crypto Driver Conformance}\label{sec:Conformance=
 / Driver Conformance / Crypto Driver Conformance}
+
+A Crypto driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Crypto Device / Device configura=
tion layout}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Initializ=
ation}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / Control Virtqueue / Session operation / Session operation: create sessio=
n}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / Control Virtqueue / Session operation / Session operation: destroy sessi=
on}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / HASH Service Operation}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / MAC Service Operation}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / Symmetric algorithms Operation}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation=
 / AEAD Service Operation}
+\end{itemize}
--=20
2.26.2

