Return-Path: <virtio-comment-return-3980-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Heng Qi <hengqi@linux.alibaba.com>
Date: Tue,  7 Feb 2023 19:16:34 +0800
Message-Id: <20230207111634.75542-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH] virtio-net: support per-queue coalescing moderation
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Currently, the coalescing profile is directly applied to all queues.
This patch supports configuring the parameters for a specified queue.

When the traffic between queues is unbalanced, for example, one queue
is busy and another queue is idle, then it will be very useful to
control coalescing parameters at the queue granularity.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 content.tex | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/content.tex b/content.tex
index e863709..049c0e4 100644
--- a/content.tex
+++ b/content.tex
@@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
=20
+\item[VIRTIO_NET_F_PERQUEUE_NOTF_COAL(52)] Device supports per-queue
+=09notifications coalescing.
+
 \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing=
.
=20
 \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
@@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label{sec:De=
vice Types / Network Device
 \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_=
F_HOST_TSO6.
 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
+\item[VIRTIO_NET_F_PERQUEUE_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ and V=
IRTIO_NET_F_NOTF_COAL.
 \end{description}
=20
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits / Legacy Interface: Feature bits}
@@ -4488,16 +4492,21 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
=20
 If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
 send control commands for dynamically changing the coalescing parameters.
+If additionally VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, the driver
+can send control commands to configure the coalescing parameters of a
+specified receiveq or transmitq.
=20
 \begin{lstlisting}
 struct virtio_net_ctrl_coal_rx {
     le32 rx_max_packets;
     le32 rx_usecs;
+    le16 rx_qid;  (Only if VIRTIO_NET_F_PERQUEUE_NOTF_COAL negotiated)
 };
=20
 struct virtio_net_ctrl_coal_tx {
     le32 tx_max_packets;
     le32 tx_usecs;
+    le16 tx_qid;  (Only if VIRTIO_NET_F_PERQUEUE_NOTF_COAL negotiated)
 };
=20
 #define VIRTIO_NET_CTRL_NOTF_COAL 6
@@ -4507,17 +4516,34 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
=20
 Coalescing parameters:
 \begin{itemize}
-\item \field{rx_usecs}: Maximum number of usecs to delay a RX notification=
.
-\item \field{tx_usecs}: Maximum number of usecs to delay a TX notification=
.
+\item \field{rx_qid}: Index of which receiveq to change the coalescing par=
ameters.
+=09If the value is between 0 and 0x7FFF, it represents the index of the sp=
ecified
+=09receiveq. Otherwise, if the value is 0xFFFF, it indicates to change the
+=09coalescing parameters for all receiveqs.
+\item \field{tx_qid}: Index of which transmitq to change the coalescing pa=
rameters.
+=09If the value is between 0 and 0x7FFF, it represents the index of the sp=
ecified
+=09transmitq. Otherwise, if the value is 0xFFFF, it indicates to change th=
e
+=09coalescing parameters for all transmitqs.
+\item \field{rx_usecs}: Maximum number of usecs to delay a RX notification=
. If additionally
+=09VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, it works for the specifi=
ed recieveq
+=09or all receieveqs.
+\item \field{tx_usecs}: Maximum number of usecs to delay a TX notification=
. If additionally
+=09VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, it works for the specifi=
ed transmitq
+=09or all transmitqs.
 \item \field{rx_max_packets}: Maximum number of packets to receive before =
a RX notification.
+=09If additionally VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, it works=
 for the
+=09specified receiveq or all receiveqs.
 \item \field{tx_max_packets}: Maximum number of packets to send before a T=
X notification.
+=09If additionally VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, it works=
 for the
+=09specified transmitq or all transmitqs.
 \end{itemize}
=20
-
 The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
 \begin{enumerate}
-\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and \fiel=
d{tx_max_packets} parameters.
-\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \fiel=
d{rx_max_packets} parameters.
+\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and \fiel=
d{tx_max_packets} parameters,
+=09and set the \field{tx_qid} if VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negoti=
ated.
+\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \fiel=
d{rx_max_packets} parameters,
+=09and set the \field{rx_qid} if VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negoti=
ated.
 \end{enumerate}
=20
 \subparagraph{RX Notifications}\label{sec:Device Types / Network Device / =
Device Operation / Control Virtqueue / Notifications Coalescing / RX Notifi=
cations}
@@ -4531,7 +4557,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
 The device will operate as follows:
=20
 \begin{itemize}
-\item The device will count received packets until it accumulates 15, or u=
ntil 10 usecs elapsed since the first one was received.
+\item The device will count received packets until it accumulates 15, or u=
ntil
+=0910 usecs elapsed since the first one was received. If additionally
+=09VIRTIO_NET_F_PERQUEUE_NOTF_COAL=09is negotiated: when \field{rx_qid} is=
 set
+=09to 0, the accumulation was only from the receiveq1; when \field{rx_qid}=
 is
+=09set to 0xFFFF, the accumulation was from all receiveqs.
 \item If the notifications are not suppressed by the driver, the device wi=
ll send an used buffer notification, otherwise, the device will not send an=
 used buffer notification as long as the notifications are suppressed.
 \end{itemize}
=20
@@ -4546,7 +4576,12 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
 The device will operate as follows:
=20
 \begin{itemize}
-\item The device will count sent packets until it accumulates 15, or until=
 10 usecs elapsed since the first one was sent.
+\item The device will count sent packets on the transmitq1 until it accumu=
lates 15,
+=09or until 10 usecs elapsed since the first one was sent. If additionally
+=09VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated: when \field{tx_qid} is s=
et
+=09to 0, the accumulation was only from the transmitq1; when \field{tx_qid=
} is
+=09set to 0xFFFF, the accumulation was from all transmitqs.
+
 \item If the notifications are not suppressed by the driver, the device wi=
ll send an used buffer notification, otherwise, the device will not send an=
 used buffer notification as long as the notifications are suppressed.
 \end{itemize}
=20
--=20
2.19.1.6.gb485710b


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

