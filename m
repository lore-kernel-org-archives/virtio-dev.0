Return-Path: <virtio-comment-return-4251-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 15 Feb 2023 11:54:09 +0200
Message-Id: <20230215095409.1119696-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v3] virtio-net: Fix and update VIRTIO_NET_F_NOTF_COAL feature
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

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
v2:
=09- Add the last 2 points to the patch.
=09- Rephrase the "commands are best-effort" note.
=09- Replace "notification" with "used buffer notification" to be
=09  more consistent.
v3:
=09- Add an intro explaining the entire coalescing operation.

 device-types/net/description.tex | 63 ++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/descriptio=
n.tex
index 1741c79..2f4835e 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1514,15 +1514,14 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
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
+In general, these commands are best-effort: spurious notifications could s=
till arrive.
+\end{note}
=20
-struct virtio_net_ctrl_coal_tx {
-    le32 tx_max_packets;
-    le32 tx_usecs;
+\begin{lstlisting}
+struct virtio_net_ctrl_coal {
+    le32 max_packets;
+    le32 usecs;
 };
=20
 #define VIRTIO_NET_CTRL_NOTF_COAL 6
@@ -1532,49 +1531,65 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
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
+\item \field{usecs} for RX: Maximum number of usecs to delay a RX notifica=
tion.
+\item \field{usecs} for TX: Maximum number of usecs to delay a TX notifica=
tion.
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
+\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{usecs} and \field{m=
ax_packets} parameters for all the transmit virtqueues.
+\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{usecs} and \field{m=
ax_packets} parameters for all the receive virtqueues.
 \end{enumerate}
=20
-\subparagraph{RX Notifications}\label{sec:Device Types / Network Device / =
Device Operation / Control Virtqueue / Notifications Coalescing / RX Notifi=
cations}
+\subparagraph{Operation}\label{sec:Device Types / Network Device / Device =
Operation / Control Virtqueue / Notifications Coalescing / Operation}
+
+The device sends a used buffer notification once the notification conditio=
ns are met, if the notifications are not suppressed as explained in \ref{se=
c:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notificati=
on Suppression}.
+
+When the device has non-zero \field{usecs} and non-zero \field{max_packets=
}, it starts counting usecs and packets upon receiving/sending a packet.
+The device counts packets and usecs for each receive virtqueue and transmi=
t virtqueue separately.
+In this case, the notification conditions are met when \field{usecs} usecs=
 elapses, or upon sending/receiving \field{max_packets} packets, whichever =
happens first.
+
+When the device has \field{usecs} =3D 0 or \field{max_packets} =3D 0, the =
notification conditions are met after every packet received/sent.
+
+\subparagraph{RX Example}\label{sec:Device Types / Network Device / Device=
 Operation / Control Virtqueue / Notifications Coalescing / RX Example}
=20
 If, for example:
 \begin{itemize}
-\item \field{rx_usecs} =3D 10.
-\item \field{rx_max_packets} =3D 15.
+\item \field{usecs} =3D 10.
+\item \field{max_packets} =3D 15.
 \end{itemize}
=20
-The device will operate as follows:
+A device with a single receive virtqueue will operate as follows:
=20
 \begin{itemize}
 \item The device will count received packets until it accumulates 15, or u=
ntil 10 usecs elapsed since the first one was received.
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
+\item \field{usecs} =3D 10.
+\item \field{max_packets} =3D 15.
 \end{itemize}
=20
-The device will operate as follows:
+A device with a single transmit virtqueue will operate as follows:
=20
 \begin{itemize}
 \item The device will count sent packets until it accumulates 15, or until=
 10 usecs elapsed since the first one was sent.
 \item If the notifications are not suppressed by the driver, the device wi=
ll send an used buffer notification, otherwise, the device will not send an=
 used buffer notification as long as the notifications are suppressed.
 \end{itemize}
=20
+\subparagraph{Notifications When Coalescing Parameters Change}\label{sec:D=
evice Types / Network Device / Device Operation / Control Virtqueue / Notif=
ications Coalescing / Notifications When Coalescing Parameters Change}
+
+When a device changes the coalescing parameters, it needs to check if the =
new notification conditions are met and send a used buffer notification if =
so.
+
+For example, \field{max_packets} =3D 15 for a device with a single transmi=
t virtqueue.
+If the device sends 10 packets, then it receives a VIRTIO_NET_CTRL_NOTF_CO=
AL_TX_SET command with \field{max_packets} =3D 8, the device needs to immed=
iately send a used buffer notification, if the notifications are not suppre=
ssed by the driver.
+
 \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / N=
etwork Device / Device Operation / Control Virtqueue / Notifications Coales=
cing}
=20
 If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver =
MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
@@ -1583,7 +1598,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Ty=
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

