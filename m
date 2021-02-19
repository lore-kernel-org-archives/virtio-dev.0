Return-Path: virtio-dev-return-7999-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 872839864F4
	for <virtio-dev@lists.oasis-open.org>; Fri, 19 Feb 2021 17:59:40 +0000 (UTC)
MIME-Version: 1.0
From: Enrico Granata <egranata@google.com>
Date: Fri, 19 Feb 2021 10:59:26 -0700
Message-ID: <CAPR809srddYRtoPue9aROJbdeFVxRRSMxzGmP5NnaoxGmJhqoA@mail.gmail.com>
Subject: [virtio-dev] [PATCH] Add lifetime metrics to virtio-blk
Content-Type: text/plain; charset="UTF-8"
To: virtio-dev@lists.oasis-open.org
Cc: Enrico Granata <egranata@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

In many embedded systems, virtio-blk implementations are
backed by eMMC or UFS storage devices, which are subject to
predictable and measurable wear over time due to repeated write
cycles.

For such systems, it can be important to be able to track
accurately the amount of wear imposed on the storage over
time and surface it to applications. In a native deployments
this is generally handled by the physical block device driver
but no such provision is made in virtio-blk to expose these
metrics for devices where it makes sense to do so.

This patch adds support to virtio-blk for lifetime and wear
metrics to be exposed to the guest when a deployment of
virtio-blk is done over compatible eMMC or UFS storage.

Signed-off-by: Enrico Granata <egranata@google.com>
---
 content.tex | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index 835f1ea..d61a587 100644
--- a/content.tex
+++ b/content.tex
@@ -4418,6 +4418,9 @@ \subsection{Feature bits}\label{sec:Device Types
/ Block Device / Feature bits}
 \item[VIRTIO_BLK_F_WRITE_ZEROES (14)] Device can support write zeroes command,
      maximum write zeroes sectors size in \field{max_write_zeroes_sectors} and
      maximum write zeroes segment number in \field{max_write_zeroes_seg}.
+
+\item[VIRTIO_BLK_F_LIFETIME (15)] Device supports providing storage lifetime
+     information.
 \end{description}

 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types
/ Block Device / Feature bits / Legacy Interface: Feature bits}
@@ -4601,8 +4604,9 @@ \subsection{Device Operation}\label{sec:Device
Types / Block Device / Device Ope

 The type of the request is either a read (VIRTIO_BLK_T_IN), a write
 (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
-(VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), or a get device ID
-string command (VIRTIO_BLK_T_GET_ID).
+(VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get device ID
+string command (VIRTIO_BLK_T_GET_ID), or a get device lifetime
+command (VIRTIO_BLK_T_GET_LIFETIME).

 \begin{lstlisting}
 #define VIRTIO_BLK_T_IN           0
@@ -4611,6 +4615,7 @@ \subsection{Device Operation}\label{sec:Device
Types / Block Device / Device Ope
 #define VIRTIO_BLK_T_GET_ID       8
 #define VIRTIO_BLK_T_DISCARD      11
 #define VIRTIO_BLK_T_WRITE_ZEROES 13
+#define VIRTIO_BLK_T_GET_LIFETIME 15
 \end{lstlisting}

 The \field{sector} number indicates the offset (multiplied by 512) where
@@ -4648,6 +4653,20 @@ \subsection{Device Operation}\label{sec:Device
Types / Block Device / Device Ope
 \field{data}.  The device ID string is a NUL-padded ASCII string up to 20 bytes
 long.  If the string is 20 bytes long then there is no NUL terminator.

+The \field{data} used for VIRTIO_BLK_T_GET_LIFETIME requests consists of one
+segment which is populated by the device, and is of the form:
+
+\begin{lstlisting}
+struct virtio_blk_lifetime {
+    le16 eol;
+    le16 lifetimeA;
+    le16 lifetimeB;
+};
+\end{lstlisting}
+
+The device lifetime metrics \field{eol}, \field{lifetimeA} and
\field{lifetimeB}
+have the semantics described by the JEDEC standard No.84-B50.
+
 The final \field{status} byte is written by the device: either
 VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
 error or VIRTIO_BLK_S_UNSUPP for a request unsupported by device:
@@ -4754,6 +4773,11 @@ \subsection{Device Operation}\label{sec:Device
Types / Block Device / Device Ope
 (case~\ref{item:flush3}).  Failure to do so can cause data loss
 in case of a crash.

+If the device is backed by eMMC or UFS persistent storage, the device SHOULD
+offer the VIRTIO_BLK_F_LIFETIME flag. The flag MUST NOT be offered if
the device
+is backed by storage for which the lifetime metrics as described in
this document
+cannot be obtained or have no useful meaning.
+
 If the driver changes \field{writeback} between the submission of the write
 and its completion, the write could be either volatile or stable when
 its completion is reported; in other words, the exact behavior is undefined.
-- 
2.30.0.617.g56c4b15f3c-goog

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

