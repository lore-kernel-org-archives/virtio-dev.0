Return-Path: <virtio-dev-return-10191-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E35E0986350
	for <virtio-dev@lists.oasis-open.org>; Mon, 21 Nov 2022 16:30:34 +0000 (UTC)
Date: Mon, 21 Nov 2022 11:30:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20221121162756.350032-4-mst@redhat.com>
References: <20221121162756.350032-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221121162756.350032-1-mst@redhat.com>
Subject: [virtio-dev] [PATCH RFC 3/3] rng: leak detection support
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Cali, Marco" <xmarcalx@amazon.co.uk>, "Graf (AWS), Alexander" <graf@amazon.de>, "Chalios, Babis" <bchalios@amazon.es>, "Jason A. Donenfeld" <Jason@zx2c4.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Add virtqueues to support reporting entropy leaks (similar to virtio based vmgenid).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 virtio-rng.tex | 61 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/virtio-rng.tex b/virtio-rng.tex
index 1ec7164..4760dfa 100644
--- a/virtio-rng.tex
+++ b/virtio-rng.tex
@@ -9,10 +9,14 @@ \subsection{Device ID}\label{sec:Device Types / Entropy Device / Device ID}
 \subsection{Virtqueues}\label{sec:Device Types / Entropy Device / Virtqueues}
 \begin{description}
 \item[0] requestq
+\item[1] leakq1 (only if VIRTIO_RNG_F_LEAK is offered)
+\item[2] leakq2 (only if VIRTIO_RNG_F_LEAK is offered)
 \end{description}
 
 \subsection{Feature bits}\label{sec:Device Types / Entropy Device / Feature bits}
-  None currently defined
+\begin{description}
+\item[VIRTIO_RNG_F_LEAK (0)] Device can report and handle information leaks.
+\end{description}
 
 \subsection{Device configuration layout}\label{sec:Device Types / Entropy Device / Device configuration layout}
   None currently defined.
@@ -21,6 +25,7 @@ \subsection{Device Initialization}\label{sec:Device Types / Entropy Device / Dev
 
 \begin{enumerate}
 \item The \field{requestq} virtqueue is initialized
+\item If VIRTIO_RNG_F_LEAK has been negotiated, \field{leakq1} and \field{leakq2} are initialized
 \end{enumerate}
 
 \subsection{Device Operation}\label{sec:Device Types / Entropy Device / Device Operation}
@@ -41,3 +46,57 @@ \subsection{Device Operation}\label{sec:Device Types / Entropy Device / Device O
 The device MUST place one or more random bytes into the buffer
 made available to it through \field{requestq}, but it
 MAY use less than the entire buffer length.
+
+\subsubsection{Reporting Information Leaks}{Device Types / Entropy Device / Device Operation / Reporting Information Leaks}
+
+The device might, after the fact, detect that some of the entropy
+it supplied to the driver has after the fact degraded in quality
+or leaked to the outside world.  One example is when the device
+is part of the virtual machine undergoing a restore from snapshot
+operation. Another example is when the information leaks from the
+host system through a side-channel.
+
+The driver would typically react by causing regeneration of any
+information that might have leaked and that has to be secret or
+unique.  It is understood that when an information leak has been
+detected it is likely not limited to the entropy received through
+the specific device. In particular, this is the case for
+snapshoting It is thus suggested that the system fully
+regenerate any unique/secret information in this scenario.
+
+If VIRTIO_RNG_F_LEAK has been negotiated the device can report
+such leaks to the driver through a set of dedicated leak
+queues: \field{leakq1} and \field{leakq2}.
+
+Buffers added to the leak queues can have one of two forms:
+\begin{enumerate}
+\item A write-only buffer. It will be completely filled by random data by the device.
+\item A buffer consisting of read-only section followed by a
+write-only section, both of identical size. The
+device will copy data from the read-only section to the write-only
+section.
+\end{enumerate}
+
+The steps for operating the virtqueue are:
+
+\begin{enumerate}
+\item At each time, only one of \field{leakq1}, \field{leakq2} is active
+      (has buffers added/used).
+\item After initialization, \field{leakq1} is active.
+\item Driver adds multiple buffers to the active leak queue.
+\item The buffers are not used until an information leak is
+      detected, as long as that is the case driver can
+      add more buffers to the active queue.
+\item Upon detecting an information leak, device starts
+      using buffers in the active leak queue.
+\item Upon detecting that buffers have been used, driver
+      switches to another leak queue making it active
+      (e.g. from \field{leakq1} to \field{leakq2} or vice versa).
+      It then starts adding buffers to the new leak queue.
+\item Device will keep using buffers in the active leak queue
+      until it detects that both the current leak queue is empty and another
+      leak queue has buffers. At that point device switches to
+      another leak queue, making it active.
+\item After the switch, buffers from the new leak queue are not
+      used until an information leak is detected.
+\end{enumerate}
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

