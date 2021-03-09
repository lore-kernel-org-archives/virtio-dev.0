Return-Path: virtio-dev-return-8106-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6B034986515
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Mar 2021 21:20:27 +0000 (UTC)
MIME-Version: 1.0
From: Enrico Granata <egranata@google.com>
Date: Tue, 9 Mar 2021 14:20:14 -0700
Message-ID: <CAPR809sesHT9M+5jmQho-4m1L1QufPgE6A_RGWmYqbnM52qSkQ@mail.gmail.com>
Subject: [virtio-dev] [PATCH v5] Add lifetime metrics to virtio-blk
Content-Type: text/plain; charset="UTF-8"
To: virtio-dev@lists.oasis-open.org
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
Fixes: https://github.org/oasis-tcs/virtio-spec/issues/97
---
 content.tex | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index b72bad0..75631ba 100644
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
@@ -4601,14 +4604,16 @@ \subsection{Device Operation}\label{sec:Device
Types / Block Device / Device Ope

 The type of the request is either a read (VIRTIO_BLK_T_IN), a write
 (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
-(VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), or a get device ID
-string command (VIRTIO_BLK_T_GET_ID).
+(VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get device ID
+string command (VIRTIO_BLK_T_GET_ID), or a get device lifetime command
+(VIRTIO_BLK_T_GET_LIFETIME).

 \begin{lstlisting}
 #define VIRTIO_BLK_T_IN           0
 #define VIRTIO_BLK_T_OUT          1
 #define VIRTIO_BLK_T_FLUSH        4
 #define VIRTIO_BLK_T_GET_ID       8
+#define VIRTIO_BLK_T_GET_LIFETIME 10
 #define VIRTIO_BLK_T_DISCARD      11
 #define VIRTIO_BLK_T_WRITE_ZEROES 13
 \end{lstlisting}
@@ -4648,6 +4653,26 @@ \subsection{Device Operation}\label{sec:Device
Types / Block Device / Device Ope
 \field{data}.  The device ID string is a NUL-padded ASCII string up to 20 bytes
 long.  If the string is 20 bytes long then there is no NUL terminator.

+The \field{data} used for VIRTIO_BLK_T_GET_LIFETIME requests is populated
+by the device, and is of the form
+
+\begin{lstlisting}
+struct virtio_blk_lifetime {
+  le16 pre_eol_info;
+  le16 device_lifetime_est_typ_a;
+  le16 device_lifetime_est_typ_b;
+};
+\end{lstlisting}
+
+The device lifetime metrics \field{pre_eol_info}, \field{device_lifetime_est_a}
+and \field{device_lifetime_est_b} have the semantics described by the
JESD84-B50
+specification for the extended CSD register fields \field{PRE_EOL_INFO}
+\field{DEVICE_LIFETIME_EST_TYP_A} and \field{DEVICE_LIFETIME_EST_TYP_B}
+respectively.
+
+JESD84-B50 is available at the JEDEC website (https://www.jedec.org)
+pursuant to JEDEC's licensing terms and conditions.
+
 The final \field{status} byte is written by the device: either
 VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
 error or VIRTIO_BLK_S_UNSUPP for a request unsupported by device:
@@ -4779,6 +4804,12 @@ \subsection{Device Operation}\label{sec:Device
Types / Block Device / Device Ope
   for implementations that do not wish to be safe against such data losses.
 \end{note}

+If the device is backed by storage providing lifetime metrics (such as eMMC
+or UFS persistent storage), the device SHOULD offer the VIRTIO_BLK_F_LIFETIME
+flag. The flag MUST NOT be offered if the device is backed by storage for which
+the lifetime metrics described in this document cannot be obtained or for which
+such metrics have no useful meaning.
+
 \subsubsection{Legacy Interface: Device Operation}\label{sec:Device
Types / Block Device / Device Operation / Legacy Interface: Device
Operation}
 When using the legacy interface, transitional devices and drivers
 MUST format the fields in struct virtio_blk_req
--
2.30.1.766.gb4fecdf3b7-goog

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

