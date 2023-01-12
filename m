Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v4 05/20] virtio-entropy: Maintain entropy device spec in separate directory
Date: Thu, 12 Jan 2023 23:22:39 +0200
Message-ID: <20230112212254.763783-6-parav@nvidia.com>
In-Reply-To: <20230112212254.763783-1-parav@nvidia.com>
References: <20230112212254.763783-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, david@redhat.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Move virtio entropy device specification to its own file similar to
recent virtio devices.
While at it, place device specification, its driver and device
conformance into its own directory to have self contained device
specification.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v3->v4:
- rename device-types/virtio-entropy/ to device-types/entropy/
v2->v3:
- file name changed from device.tex to description.tex
- use input instead of import to insert a file
v0->v1:
- moved to device specific directory
---
 conformance.tex                             | 18 +--------
 content.tex                                 | 44 +--------------------
 device-types/entropy/description.tex        | 42 ++++++++++++++++++++
 device-types/entropy/device-conformance.tex |  7 ++++
 device-types/entropy/driver-conformance.tex |  7 ++++
 5 files changed, 59 insertions(+), 59 deletions(-)
 create mode 100644 device-types/entropy/description.tex
 create mode 100644 device-types/entropy/device-conformance.tex
 create mode 100644 device-types/entropy/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index cbd559b..d8efa53 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -137,14 +137,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/net/driver-conformance.tex}
 \input{device-types/blk/driver-conformance.tex}
 \input{device-types/console/driver-conformance.tex}
-
-\conformance{\subsection}{Entropy Driver Conformance}\label{sec:Conformanc=
e / Driver Conformance / Entropy Driver Conformance}
-
-An entropy driver MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{drivernormative:Device Types / Entropy Device / Device Operatio=
n}
-\end{itemize}
+\input{device-types/entropy/driver-conformance.tex}
=20
 \conformance{\subsection}{Traditional Memory Balloon Driver Conformance}\l=
abel{sec:Conformance / Driver Conformance / Traditional Memory Balloon Driv=
er Conformance}
=20
@@ -372,14 +365,7 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \input{device-types/net/device-conformance.tex}
 \input{device-types/blk/device-conformance.tex}
 \input{device-types/console/device-conformance.tex}
-
-\conformance{\subsection}{Entropy Device Conformance}\label{sec:Conformanc=
e / Device Conformance / Entropy Device Conformance}
-
-An entropy device MUST conform to the following normative statements:
-
-\begin{itemize}
-\item \ref{devicenormative:Device Types / Entropy Device / Device Operatio=
n}
-\end{itemize}
+\input{device-types/entropy/device-conformance.tex}
=20
 \conformance{\subsection}{Traditional Memory Balloon Device Conformance}\l=
abel{sec:Conformance / Device Conformance / Traditional Memory Balloon Devi=
ce Conformance}
=20
diff --git a/content.tex b/content.tex
index 1b6788d..b77d6a2 100644
--- a/content.tex
+++ b/content.tex
@@ -3006,49 +3006,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/net/description.tex}
 \input{device-types/blk/description.tex}
 \input{device-types/console/description.tex}
-
-\section{Entropy Device}\label{sec:Device Types / Entropy Device}
-
-The virtio entropy device supplies high-quality randomness for
-guest use.
-
-\subsection{Device ID}\label{sec:Device Types / Entropy Device / Device ID=
}
-  4
-
-\subsection{Virtqueues}\label{sec:Device Types / Entropy Device / Virtqueu=
es}
-\begin{description}
-\item[0] requestq
-\end{description}
-
-\subsection{Feature bits}\label{sec:Device Types / Entropy Device / Featur=
e bits}
-  None currently defined
-
-\subsection{Device configuration layout}\label{sec:Device Types / Entropy =
Device / Device configuration layout}
-  None currently defined.
-
-\subsection{Device Initialization}\label{sec:Device Types / Entropy Device=
 / Device Initialization}
-
-\begin{enumerate}
-\item The virtqueue is initialized
-\end{enumerate}
-
-\subsection{Device Operation}\label{sec:Device Types / Entropy Device / De=
vice Operation}
-
-When the driver requires random bytes, it places the descriptor
-of one or more buffers in the queue. It will be completely filled
-by random data by the device.
-
-\drivernormative{\subsubsection}{Device Operation}{Device Types / Entropy =
Device / Device Operation}
-
-The driver MUST NOT place device-readable buffers into the queue.
-
-The driver MUST examine the length written by the device to determine
-how many random bytes were received.
-
-\devicenormative{\subsubsection}{Device Operation}{Device Types / Entropy =
Device / Device Operation}
-
-The device MUST place one or more random bytes into the buffer, but it
-MAY use less than the entire buffer length.
+\input{device-types/entropy/description.tex}
=20
 \section{Traditional Memory Balloon Device}\label{sec:Device Types / Memor=
y Balloon Device}
=20
diff --git a/device-types/entropy/description.tex b/device-types/entropy/de=
scription.tex
new file mode 100644
index 0000000..c26f589
--- /dev/null
+++ b/device-types/entropy/description.tex
@@ -0,0 +1,42 @@
+\section{Entropy Device}\label{sec:Device Types / Entropy Device}
+
+The virtio entropy device supplies high-quality randomness for
+guest use.
+
+\subsection{Device ID}\label{sec:Device Types / Entropy Device / Device ID=
}
+  4
+
+\subsection{Virtqueues}\label{sec:Device Types / Entropy Device / Virtqueu=
es}
+\begin{description}
+\item[0] requestq
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / Entropy Device / Featur=
e bits}
+  None currently defined
+
+\subsection{Device configuration layout}\label{sec:Device Types / Entropy =
Device / Device configuration layout}
+  None currently defined.
+
+\subsection{Device Initialization}\label{sec:Device Types / Entropy Device=
 / Device Initialization}
+
+\begin{enumerate}
+\item The virtqueue is initialized
+\end{enumerate}
+
+\subsection{Device Operation}\label{sec:Device Types / Entropy Device / De=
vice Operation}
+
+When the driver requires random bytes, it places the descriptor
+of one or more buffers in the queue. It will be completely filled
+by random data by the device.
+
+\drivernormative{\subsubsection}{Device Operation}{Device Types / Entropy =
Device / Device Operation}
+
+The driver MUST NOT place device-readable buffers into the queue.
+
+The driver MUST examine the length written by the device to determine
+how many random bytes were received.
+
+\devicenormative{\subsubsection}{Device Operation}{Device Types / Entropy =
Device / Device Operation}
+
+The device MUST place one or more random bytes into the buffer, but it
+MAY use less than the entire buffer length.
diff --git a/device-types/entropy/device-conformance.tex b/device-types/ent=
ropy/device-conformance.tex
new file mode 100644
index 0000000..2789fda
--- /dev/null
+++ b/device-types/entropy/device-conformance.tex
@@ -0,0 +1,7 @@
+\conformance{\subsection}{Entropy Device Conformance}\label{sec:Conformanc=
e / Device Conformance / Entropy Device Conformance}
+
+An entropy device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / Entropy Device / Device Operatio=
n}
+\end{itemize}
diff --git a/device-types/entropy/driver-conformance.tex b/device-types/ent=
ropy/driver-conformance.tex
new file mode 100644
index 0000000..175c453
--- /dev/null
+++ b/device-types/entropy/driver-conformance.tex
@@ -0,0 +1,7 @@
+\conformance{\subsection}{Entropy Driver Conformance}\label{sec:Conformanc=
e / Driver Conformance / Entropy Driver Conformance}
+
+An entropy driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Entropy Device / Device Operatio=
n}
+\end{itemize}
--=20
2.26.2

