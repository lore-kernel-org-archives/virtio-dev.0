Return-Path: <virtio-dev-return-10719-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D33EE986360
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Feb 2023 08:47:51 +0000 (UTC)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon,  6 Feb 2023 10:47:46 +0200
Message-Id: <20230206084746.40536-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] virtio-net: Fix and update VIRTIO_NET_F_NOTF_COAL feature
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, mst@redhat.com, Alvaro Karsz <alvaro.karsz@solid-run.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This patch makes several improvements to the notification coalescing
feature, including:

- Consolidating virtio_net_ctrl_coal_tx and virtio_net_ctrl_coal_rx
  into a single struct, virtio_net_ctrl_coal, as they are identical.
- Emphasizing that the coalescing commands are best-effort.
- Defining the behavior of coalescing with regards to delivering
  notifications when a change occur.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 device-types/net/description.tex | 40 ++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/descriptio=
n.tex
index 1741c79..2a98411 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1514,15 +1514,12 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
 If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
 send control commands for dynamically changing the coalescing parameters.
=20
-\begin{lstlisting}
-struct virtio_net_ctrl_coal_rx {
-    le32 rx_max_packets;
-    le32 rx_usecs;
-};
+Note: In general, these commands are best-effort: A device could send a no=
tification even if it is not supposed to.
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
@@ -1532,25 +1529,25 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
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
=20
 The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
 \begin{enumerate}
-\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and \fiel=
d{tx_max_packets} parameters.
-\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \fiel=
d{rx_max_packets} parameters.
+\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{usecs} and \field{m=
ax_packets} parameters for TX.
+\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{usecs} and \field{m=
ax_packets} parameters for RX.
 \end{enumerate}
=20
 \subparagraph{RX Notifications}\label{sec:Device Types / Network Device / =
Device Operation / Control Virtqueue / Notifications Coalescing / RX Notifi=
cations}
=20
 If, for example:
 \begin{itemize}
-\item \field{rx_usecs} =3D 10.
-\item \field{rx_max_packets} =3D 15.
+\item \field{usecs} =3D 10.
+\item \field{max_packets} =3D 15.
 \end{itemize}
=20
 The device will operate as follows:
@@ -1564,8 +1561,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Ty=
pes / Network Device / Devi
=20
 If, for example:
 \begin{itemize}
-\item \field{tx_usecs} =3D 10.
-\item \field{tx_max_packets} =3D 15.
+\item \field{usecs} =3D 10.
+\item \field{max_packets} =3D 15.
 \end{itemize}
=20
 The device will operate as follows:
@@ -1575,6 +1572,13 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
 \item If the notifications are not suppressed by the driver, the device wi=
ll send an used buffer notification, otherwise, the device will not send an=
 used buffer notification as long as the notifications are suppressed.
 \end{itemize}
=20
+\subparagraph{Notifications When Coalescing Parameters Change}\label{sec:D=
evice Types / Network Device / Device Operation / Control Virtqueue / Notif=
ications Coalescing / Notifications When Coalescing Parameters Change}
+
+When a device changes the coalescing parameters, the device needs to check=
 if the new parameters are met and issue a notification if so.
+
+For example, \field{max_packets} =3D 15 for TX.
+If the device sends 10 packets, then it receives a VIRTIO_NET_CTRL_NOTF_CO=
AL_TX_SET command with \field{max_packets} =3D 8, the device needs to immed=
iately send a TX notification, if the notifications are not suppressed by t=
he driver.
+
 \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / N=
etwork Device / Device Operation / Control Virtqueue / Notifications Coales=
cing}
=20
 If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver =
MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
--=20
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

