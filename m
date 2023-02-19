Return-Path: <virtio-dev-return-11115-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9E9D79862A8
	for <virtio-dev@lists.oasis-open.org>; Sun, 19 Feb 2023 13:11:01 +0000 (UTC)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sun, 19 Feb 2023 15:10:53 +0200
Message-Id: <20230219131053.1541173-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v7] virtio-net: Fix and update VIRTIO_NET_F_NOTF_COAL feature
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, mst@redhat.com, hengqi@linux.alibaba.com, parav@nvidia.com, Alvaro Karsz <alvaro.karsz@solid-run.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This patch makes several improvements to the notification coalescing
feature, including:

- Consolidating virtio_net_ctrl_coal_tx and virtio_net_ctrl_coal_rx
  into a single struct, virtio_net_ctrl_coal, as they are identical.
- Emphasizing that the coalescing commands are best-effort.
- Defining the behavior of coalescing with regards to delivering
  notifications when a change occur.
- Stating that the commands should apply to all the receive/transmit
  virtqueues.
- Stating that every receive/transmit virtqueue should count it's own
  packets.
- A new intro explaining the entire coalescing operation.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/159

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
v2:
=09- Add the last 2 points to the patch.
=09- Rephrase the "commands are best-effort" note.
=09- Replace "notification" with "used buffer notification" to be
=09  more consistent.
v3:
=09- Add an intro explaining the entire coalescing operation.
v4:
=09- Minor wording fixes.
=09- Rephrase the general note.
v5:
=09- Replace virtio_net_ctrl_coal->usecs with
=09  virtio_net_ctrl_coal->max_usecs
v6:
=09- Replace usecs with microseconds.
=09- Make the TX/RX examples relevant for MQ as well.
=09- Explain that upon meeting the notification condition, the
=09  device starts counting packets and microseconds again.
=09- Add Parav's Reviewed-by tag (Thanks!)
v7:
=09- Minor grammar fixes.
=09- Add Michael's Acked-by tag (Thanks!)
=09- Add Fixes tag.

 device-types/net/description.tex | 74 +++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 30 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/descriptio=
n.tex
index 1741c79..8487ccd 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1514,15 +1514,15 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
 If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
 send control commands for dynamically changing the coalescing parameters.
=20
-\begin{lstlisting}
-struct virtio_net_ctrl_coal_rx {
-    le32 rx_max_packets;
-    le32 rx_usecs;
-};
+\begin{note}
+The behavior of the device in response to these commands is best-effort:
+the device may generate notifications more or less frequently than specifi=
ed.
+\end{note}
=20
-struct virtio_net_ctrl_coal_tx {
-    le32 tx_max_packets;
-    le32 tx_usecs;
+\begin{lstlisting}
+struct virtio_net_ctrl_coal {
+    le32 max_packets;
+    le32 max_usecs;
 };
=20
 #define VIRTIO_NET_CTRL_NOTF_COAL 6
@@ -1532,49 +1532,63 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
=20
 Coalescing parameters:
 \begin{itemize}
-\item \field{rx_usecs}: Maximum number of usecs to delay a RX notification=
.
-\item \field{tx_usecs}: Maximum number of usecs to delay a TX notification=
.
-\item \field{rx_max_packets}: Maximum number of packets to receive before =
a RX notification.
-\item \field{tx_max_packets}: Maximum number of packets to send before a T=
X notification.
+\item \field{max_usecs} for RX: Maximum number of microseconds to delay a =
RX notification.
+\item \field{max_usecs} for TX: Maximum number of microseconds to delay a =
TX notification.
+\item \field{max_packets} for RX: Maximum number of packets to receive bef=
ore a RX notification.
+\item \field{max_packets} for TX: Maximum number of packets to send before=
 a TX notification.
 \end{itemize}
=20
-
 The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
 \begin{enumerate}
-\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and \fiel=
d{tx_max_packets} parameters.
-\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \fiel=
d{rx_max_packets} parameters.
+\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and \fie=
ld{max_packets} parameters for all transmit virtqueues.
+\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and \fie=
ld{max_packets} parameters for all receive virtqueues.
 \end{enumerate}
=20
-\subparagraph{RX Notifications}\label{sec:Device Types / Network Device / =
Device Operation / Control Virtqueue / Notifications Coalescing / RX Notifi=
cations}
+\subparagraph{Operation}\label{sec:Device Types / Network Device / Device =
Operation / Control Virtqueue / Notifications Coalescing / Operation}
+
+The device sends a used buffer notification once the notification conditio=
ns are met and if the notifications are not suppressed as explained in \ref=
{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notific=
ation Suppression}.
+
+When the device has non-zero \field{max_usecs} and non-zero \field{max_pac=
kets}, it starts counting microseconds and packets upon receiving/sending a=
 packet.
+The device counts packets and microseconds for each receive virtqueue and =
transmit virtqueue separately.
+In this case, the notification conditions are met when \field{max_usecs} m=
icroseconds elapse, or upon sending/receiving \field{max_packets} packets, =
whichever happens first.
+Afterwards, the device waits for the next packet and starts counting packe=
ts and microseconds again.
+
+When the device has \field{max_usecs} =3D 0 or \field{max_packets} =3D 0, =
the notification conditions are met after every packet received/sent.
+
+\subparagraph{RX Example}\label{sec:Device Types / Network Device / Device=
 Operation / Control Virtqueue / Notifications Coalescing / RX Example}
=20
 If, for example:
 \begin{itemize}
-\item \field{rx_usecs} =3D 10.
-\item \field{rx_max_packets} =3D 15.
+\item \field{max_usecs} =3D 10.
+\item \field{max_packets} =3D 15.
 \end{itemize}
-
-The device will operate as follows:
-
+then each receive virtqueue of a device will operate as follows:
 \begin{itemize}
-\item The device will count received packets until it accumulates 15, or u=
ntil 10 usecs elapsed since the first one was received.
+\item The device will count packets received on each virtqueue until it ac=
cumulates 15, or until 10 microseconds elapsed since the first one was rece=
ived.
 \item If the notifications are not suppressed by the driver, the device wi=
ll send an used buffer notification, otherwise, the device will not send an=
 used buffer notification as long as the notifications are suppressed.
 \end{itemize}
=20
-\subparagraph{TX Notifications}\label{sec:Device Types / Network Device / =
Device Operation / Control Virtqueue / Notifications Coalescing / TX Notifi=
cations}
+\subparagraph{TX Example}\label{sec:Device Types / Network Device / Device=
 Operation / Control Virtqueue / Notifications Coalescing / TX Example}
=20
 If, for example:
 \begin{itemize}
-\item \field{tx_usecs} =3D 10.
-\item \field{tx_max_packets} =3D 15.
+\item \field{max_usecs} =3D 10.
+\item \field{max_packets} =3D 15.
 \end{itemize}
-
-The device will operate as follows:
-
+then each transmit virtqueue of a device will operate as follows:
 \begin{itemize}
-\item The device will count sent packets until it accumulates 15, or until=
 10 usecs elapsed since the first one was sent.
+\item The device will count packets sent on each virtqueue until it accumu=
lates 15, or until 10 microseconds elapsed since the first one was sent.
 \item If the notifications are not suppressed by the driver, the device wi=
ll send an used buffer notification, otherwise, the device will not send an=
 used buffer notification as long as the notifications are suppressed.
 \end{itemize}
=20
+\subparagraph{Notifications When Coalescing Parameters Change}\label{sec:D=
evice Types / Network Device / Device Operation / Control Virtqueue / Notif=
ications Coalescing / Notifications When Coalescing Parameters Change}
+
+When the coalescing parameters of a device change, the device needs to che=
ck if the new notification conditions are met and send a used buffer notifi=
cation if so.
+
+For example, \field{max_packets} =3D 15 for a device with a single transmi=
t virtqueue: if the device sends 10 packets and afterwards receives a
+VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command with \field{max_packets} =3D 8, t=
hen the notification condition is immediately considered to be met;
+the device needs to immediately send a used buffer notification, if the no=
tifications are not suppressed by the driver.
+
 \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / N=
etwork Device / Device Operation / Control Virtqueue / Notifications Coales=
cing}
=20
 If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver =
MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
@@ -1583,7 +1597,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Ty=
pes / Network Device / Devi
=20
 A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIR=
TIO_NET_ERR if it was not able to change the parameters.
=20
-A device SHOULD NOT send used buffer notifications to the driver, if the n=
otifications are suppressed as explained in \ref{sec:Basic Facilities of a =
Virtio Device / Virtqueues / Used Buffer Notification Suppression}, even if=
 the coalescing counters expired.
+A device SHOULD NOT send used buffer notifications to the driver if the no=
tifications are suppressed, even if the notification conditions are met.
=20
 Upon reset, a device MUST initialize all coalescing parameters to 0.
=20
--=20
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

