Return-Path: <virtio-comment-return-3480-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 21 Nov 2022 11:30:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20221121162756.350032-2-mst@redhat.com>
References: <20221121162756.350032-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221121162756.350032-1-mst@redhat.com>
Subject: [virtio-comment] [PATCH RFC 1/3] rng: move to a file of its own
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Cali, Marco" <xmarcalx@amazon.co.uk>, "Graf (AWS), Alexander" <graf@amazon.de>, "Chalios, Babis" <bchalios@amazon.es>, "Jason A. Donenfeld" <Jason@zx2c4.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Will make it easier to edit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex    | 43 +------------------------------------------
 virtio-rng.tex | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 42 deletions(-)
 create mode 100644 virtio-rng.tex

diff --git a/content.tex b/content.tex
index 7111929..332c257 100644
--- a/content.tex
+++ b/content.tex
@@ -5540,48 +5540,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 negotiated VIRTIO_F_ANY_LAYOUT MUST use only a single
 descriptor for all buffers in the control receiveq and control transmitq.
 
-\section{Entropy Device}\label{sec:Device Types / Entropy Device}
-
-The virtio entropy device supplies high-quality randomness for
-guest use.
-
-\subsection{Device ID}\label{sec:Device Types / Entropy Device / Device ID}
-  4
-
-\subsection{Virtqueues}\label{sec:Device Types / Entropy Device / Virtqueues}
-\begin{description}
-\item[0] requestq
-\end{description}
-
-\subsection{Feature bits}\label{sec:Device Types / Entropy Device / Feature bits}
-  None currently defined
-
-\subsection{Device configuration layout}\label{sec:Device Types / Entropy Device / Device configuration layout}
-  None currently defined.
-
-\subsection{Device Initialization}\label{sec:Device Types / Entropy Device / Device Initialization}
-
-\begin{enumerate}
-\item The virtqueue is initialized
-\end{enumerate}
-
-\subsection{Device Operation}\label{sec:Device Types / Entropy Device / Device Operation}
-
-When the driver requires random bytes, it places the descriptor
-of one or more buffers in the queue. It will be completely filled
-by random data by the device.
-
-\drivernormative{\subsubsection}{Device Operation}{Device Types / Entropy Device / Device Operation}
-
-The driver MUST NOT place device-readable buffers into the queue.
-
-The driver MUST examine the length written by the device to determine
-how many random bytes were received.
-
-\devicenormative{\subsubsection}{Device Operation}{Device Types / Entropy Device / Device Operation}
-
-The device MUST place one or more random bytes into the buffer, but it
-MAY use less than the entire buffer length.
+\input{virtio-rng.tex}
 
 \section{Traditional Memory Balloon Device}\label{sec:Device Types / Memory Balloon Device}
 
diff --git a/virtio-rng.tex b/virtio-rng.tex
new file mode 100644
index 0000000..c26f589
--- /dev/null
+++ b/virtio-rng.tex
@@ -0,0 +1,42 @@
+\section{Entropy Device}\label{sec:Device Types / Entropy Device}
+
+The virtio entropy device supplies high-quality randomness for
+guest use.
+
+\subsection{Device ID}\label{sec:Device Types / Entropy Device / Device ID}
+  4
+
+\subsection{Virtqueues}\label{sec:Device Types / Entropy Device / Virtqueues}
+\begin{description}
+\item[0] requestq
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / Entropy Device / Feature bits}
+  None currently defined
+
+\subsection{Device configuration layout}\label{sec:Device Types / Entropy Device / Device configuration layout}
+  None currently defined.
+
+\subsection{Device Initialization}\label{sec:Device Types / Entropy Device / Device Initialization}
+
+\begin{enumerate}
+\item The virtqueue is initialized
+\end{enumerate}
+
+\subsection{Device Operation}\label{sec:Device Types / Entropy Device / Device Operation}
+
+When the driver requires random bytes, it places the descriptor
+of one or more buffers in the queue. It will be completely filled
+by random data by the device.
+
+\drivernormative{\subsubsection}{Device Operation}{Device Types / Entropy Device / Device Operation}
+
+The driver MUST NOT place device-readable buffers into the queue.
+
+The driver MUST examine the length written by the device to determine
+how many random bytes were received.
+
+\devicenormative{\subsubsection}{Device Operation}{Device Types / Entropy Device / Device Operation}
+
+The device MUST place one or more random bytes into the buffer, but it
+MAY use less than the entire buffer length.
-- 
MST


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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

