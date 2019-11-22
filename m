Return-Path: virtio-dev-return-6386-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B8B01985F32
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Nov 2019 14:48:41 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Nov 2019 14:48:24 +0000
Message-Id: <20191122144824.483847-3-stefanha@redhat.com>
In-Reply-To: <20191122144824.483847-1-stefanha@redhat.com>
References: <20191122144824.483847-1-stefanha@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 2/2] virtio-fs: add notification queue
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: mszeredi@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, vgoyal@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The FUSE protocol allows the file server (device) to initiate
communication with the client (driver) using FUSE notify messages.
Normally only the client can initiate communication.  This feature is
used to report asynchronous events that are not related to an in-flight
request.

This patch adds a notification queue that works like an rx queue in
other types of device.  The device can emit FUSE notify messages by
using a buffer from this queue.

This mechanism was designed by Vivek Goyal <vgoyal@redhat.com>.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
TODO:
 * Flow control?  What happens when the notification queue is empty when
   the device wants to emit a message.  We cannot assume unlimited
   device resources for holding back pending notifications.  Eventually
   they will have to be dropped and/or the device needs to report an
   error.
---
 conformance.tex |  1 +
 virtio-fs.tex   | 63 +++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index 25d11ec..a43eea3 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -190,6 +190,7 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
 \begin{itemize}
 \item \ref{drivernormative:Device Types / File System Device / Device conf=
iguration layout}
 \item \ref{drivernormative:Device Types / File System Device / Device Oper=
ation / Device Operation: High Priority Queue}
+\item \ref{drivernormative:Device Types / File System Device / Device Oper=
ation / Device Operation: Notification Queue}
 \item \ref{drivernormative:Device Types / File System Device / Device Oper=
ation / Device Operation: DAX Window}
 \end{itemize}
=20
diff --git a/virtio-fs.tex b/virtio-fs.tex
index 158d066..a94a377 100644
--- a/virtio-fs.tex
+++ b/virtio-fs.tex
@@ -25,24 +25,33 @@ \subsection{Virtqueues}\label{sec:Device Types / File S=
ystem Device / Virtqueues
=20
 \begin{description}
 \item[0] hiprio
-\item[1\ldots n] request queues
+\item[1] notification queue
+\item[2\ldots n] request queues
 \end{description}
=20
+The notification queue only exists if VIRTIO_FS_F_NOTIFICATION is set.
+
 \subsection{Feature bits}\label{sec:Device Types / File System Device / Fe=
ature bits}
=20
-There are currently no feature bits defined.
+\begin{description}
+\item[VIRTIO_FS_F_NOTIFICATION (0)] Device has support for FUSE notify
+    messages.  The notification queue is virtqueue 1.
+\end{description}
=20
 \subsection{Device configuration layout}\label{sec:Device Types / File Sys=
tem Device / Device configuration layout}
=20
-All fields of this configuration are always available.
-
 \begin{lstlisting}
 struct virtio_fs_config {
         char tag[36];
         le32 num_request_queues;
+        le32 notify_buf_size;
 };
 \end{lstlisting}
=20
+The \field{tag} and \field{num_request_queues} fields are always available=
.
+The \field{notify_buf_size} field is only available when
+VIRTIO_FS_F_NOTIFICATION is set.
+
 \begin{description}
 \item[\field{tag}] is the name associated with this file system.  The tag =
is
     encoded in UTF-8 and padded with NUL bytes if shorter than the
@@ -53,6 +62,8 @@ \subsection{Device configuration layout}\label{sec:Device=
 Types / File System De
     there are no ordering guarantees between requests made available on
     different queues.  Use of multiple queues is intended to increase
     performance.
+\item[\field{notify_buf_size}] is the minimum number of bytes required for=
 each
+    buffer in the notification queue.
 \end{description}
=20
 \drivernormative{\subsubsection}{Device configuration layout}{Device Types=
 / File System Device / Device configuration layout}
@@ -65,13 +76,20 @@ \subsection{Device configuration layout}\label{sec:Devi=
ce Types / File System De
=20
 The device MUST set \field{num_request_queues} to 1 or greater.
=20
+The device MUST set \field{notify_buf_size} to be large enough to hold any=
 of
+the FUSE notify messages that this device emits.
+
 \subsection{Device Initialization}\label{Device Types / File System Device=
 / Device Initialization}
=20
-On initialization the driver first discovers the device's virtqueues.  The=
 FUSE
-session is started by sending a FUSE\_INIT request as defined by the FUSE
-protocol on one request virtqueue.  All virtqueues provide access to the s=
ame
-FUSE session and therefore only one FUSE\_INIT request is required regardl=
ess
-of the number of available virtqueues.
+On initialization the driver first discovers the device's virtqueues.
+
+The driver populates the notification queue with buffers for receiving FUS=
E
+notify messages if VIRTIO_FS_F_NOTIFICATION is set.
+
+The FUSE session is started by sending a FUSE\_INIT request as defined by =
the
+FUSE protocol on one request virtqueue.  All virtqueues provide access to =
the
+same FUSE session and therefore only one FUSE\_INIT request is required
+regardless of the number of available virtqueues.
=20
 \subsection{Device Operation}\label{sec:Device Types / File System Device =
/ Device Operation}
=20
@@ -88,7 +106,8 @@ \subsection{Device Operation}\label{sec:Device Types / F=
ile System Device / Devi
       full.
 \end{itemize}
=20
-Note that FUSE notification requests are not supported.
+FUSE notify messages are received on the notification queue if
+VIRTIO_FS_F_NOTIFICATION is set.
=20
 \subsubsection{Device Operation: Request Queues}\label{sec:Device Types / =
File System Device / Device Operation / Device Operation: Request Queues}
=20
@@ -179,6 +198,30 @@ \subsubsection{Device Operation: High Priority Queue}\=
label{sec:Device Types / F
=20
 The driver MUST anticipate that request queues are processed concurrently =
with the hiprio queue.
=20
+\subsubsection{Device Operation: Notification Queue}\label{sec:Device Type=
s / File System Device / Device Operation / Device Operation: Notification =
Queue}
+
+The notification queue is populated with buffers by the driver and these
+buffers are used by the device to emit FUSE notify messages.  Notification
+queue buffer layout is as follows:
+
+\begin{lstlisting}
+struct virtio_fs_notify {
+        // Device-writable part
+        struct fuse_out_header out_hdr;
+        char outarg[notify_buf_size - sizeof(struct fuse_out_header)];
+};
+\end{lstlisting}
+
+\field{outarg} contains the FUSE notify message payload that depends on th=
e
+type of notification being emitted.
+
+\drivernormative{\paragraph}{Device Operation: Notification Queue}{Device =
Types / File System Device / Device Operation / Device Operation: Notificat=
ion Queue}
+
+The driver MUST provide buffers of at least \field{notify_buf_size} bytes.
+
+The driver SHOULD replenish notification queue buffers sufficiently quickl=
y so
+that there is always at least one available buffer.
+
 \subsubsection{Device Operation: DAX Window}\label{sec:Device Types / File=
 System Device / Device Operation / Device Operation: DAX Window}
=20
 FUSE\_READ and FUSE\_WRITE requests transfer file contents between the
--=20
2.23.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

