Return-Path: <virtio-comment-return-3607-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sat, 24 Dec 2022 20:06:16 +0200
Message-ID: <20221224180619.73959-4-parav@nvidia.com>
In-Reply-To: <20221224180619.73959-1-parav@nvidia.com>
References: <20221224180619.73959-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH 3/6] virtio-entropy: Maintain entropy device spec in separate file
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Move virtio entropy device specification to its own file similar to
recent virtio devices.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 content.tex        | 44 +-------------------------------------------
 virtio-entropy.tex | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 43 deletions(-)
 create mode 100644 virtio-entropy.tex

diff --git a/content.tex b/content.tex
index 10ec15f..f0e5fe0 100644
--- a/content.tex
+++ b/content.tex
@@ -6144,49 +6144,7 @@ \subsubsection{Legacy Interface: Framing Requirement=
s}\label{sec:Device
 negotiated VIRTIO_F_ANY_LAYOUT MUST use only a single
 descriptor for all buffers in the control receiveq and control transmitq.
=20
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
-
+\input{virtio-entropy.tex}
 \input{virtio-mem-balloon.tex}
 \input{virtio-scsi.tex}
 \input{virtio-gpu.tex}
diff --git a/virtio-entropy.tex b/virtio-entropy.tex
new file mode 100644
index 0000000..c26f589
--- /dev/null
+++ b/virtio-entropy.tex
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

