Return-Path: <virtio-dev-return-10548-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DBEC09863B3
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Jan 2023 15:21:29 +0000 (UTC)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 11 Jan 2023 17:21:23 +0200
Message-Id: <20230111152123.148889-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2] virtio_net: support low and high rate of notification coalescing
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, mst@redhat.com, Alvaro Karsz <alvaro.karsz@solid-run.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This patch adds a new feature, VIRTIO_NET_F_NOTF_COAL_LOW_HIGH, while
clarifying/fixing existing coalescing concepts.

The new feature adds 4 new commands to VIRTIO_NET_CTRL_NOTF_COAL class:
=09- VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET - coalescing parameters
=09  to use when the packet rate is equal or lower then the low
=09  threshold for TX.
        - VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET - coalescing parameters
          to use when the packet rate is equal or lower then the low
          threshold for RX.
        - VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET - coalescing parameters
          to use when the packet rate is equal or higher then the high
          threshold for TX.
        - VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET - coalescing parameters
          to use when the packet rate is equal or higher then the high
          threshold for RX.

On top of the new feature, this patch:
=09- Unifies the virtio_net_ctrl_coal structs, since the one for tx
=09  and the one for rx are identical.
=09- Clarifies that the coalescing commands are best-effort.
=09- Specifies coalescing in respect to delivering interrupts when config
          changes.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
v2:
=09- Remove the "set of coalescing parameters" concept, use
=09  "coalescing parameters" instead.
=09- Unify struct virtio_net_ctrl_coal_rx and strcut virtio_net_ctrl_coal_t=
x
=09  to struct virtio_net_ctrl_coal.
=09- Separate the commands to tx and rx, so devices could have
=09  different low/high rate coalescing parameters for tx and rx.
=09- Unify struct virtio_net_ctrl_coal_high and struct
=09  virtio_net_ctrl_coal_low to struct virtio_net_ctrl_coal_threshold.
=09- Clarify that the packet rate is in packet per second units.
=09- Clarify that any notification coalescing command is best-effort.
=09- Specify coalescing in respect to delivering interrupts when config
=09  changes.
---
 content.tex | 105 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 87 insertions(+), 18 deletions(-)

diff --git a/content.tex b/content.tex
index 96f4723..82b2597 100644
--- a/content.tex
+++ b/content.tex
@@ -3088,6 +3088,8 @@ \subsection{Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
=20
+\item[VIRTIO_NET_F_NOTF_COAL_LOW_HIGH(50)] Device supports notifications c=
oalescing low rate and high rate sets.
+
 \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing=
.
=20
 \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
@@ -3142,6 +3144,7 @@ \subsubsection{Feature bit requirements}\label{sec:De=
vice Types / Network Device
 \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
+\item[VIRTIO_NET_F_NOTF_COAL_LOW_HIGH] Requires VIRTIO_NET_F_NOTF_COAL.
 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_=
F_HOST_TSO6.
 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
 \end{description}
@@ -4493,43 +4496,62 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
 If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
 send control commands for dynamically changing the coalescing parameters.
=20
+Note: In general, these commands are best-effort: A device could send a no=
tification even if it is not supposed to.
+
 \begin{lstlisting}
-struct virtio_net_ctrl_coal_rx {
-    le32 rx_max_packets;
-    le32 rx_usecs;
+struct virtio_net_ctrl_coal {
+    le32 max_packets;
+    le32 usecs;
 };
=20
-struct virtio_net_ctrl_coal_tx {
-    le32 tx_max_packets;
-    le32 tx_usecs;
+struct virtio_net_ctrl_coal_threshold {
+    le32 pkt_rate;
+    struct virtio_net_ctrl_coal params;
 };
=20
 #define VIRTIO_NET_CTRL_NOTF_COAL 6
  #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
  #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
+ #define VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET 2 //Only if VIRTIO_NET_F_NOT=
F_COAL_LOW_HIGH negotiated
+ #define VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET 3 //Only if VIRTIO_NET_F_NOT=
F_COAL_LOW_HIGH negotiated
+ #define VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET 4 //Only if VIRTIO_NET_F_NO=
TF_COAL_LOW_HIGH negotiated
+ #define VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET 5 //Only if VIRTIO_NET_F_NO=
TF_COAL_LOW_HIGH negotiated
 \end{lstlisting}
=20
-Coalescing parameters:
+TX Coalescing parameters:
+\begin{itemize}
+\item \field{usecs}: Maximum number of usecs to delay a TX notification.
+\item \field{max_packets}: Maximum number of packets to send before a TX n=
otification.
+\end{itemize}
+
+RX Coalescing parameters:
+\begin{itemize}
+\item \field{usecs}: Maximum number of usecs to delay a RX notification.
+\item \field{max_packets}: Maximum number of packets to receive before a R=
X notification.
+\end{itemize}
+
+General Coalescing parameters:
 \begin{itemize}
-\item \field{rx_usecs}: Maximum number of usecs to delay a RX notification=
.
-\item \field{tx_usecs}: Maximum number of usecs to delay a TX notification=
.
-\item \field{rx_max_packets}: Maximum number of packets to receive before =
a RX notification.
-\item \field{tx_max_packets}: Maximum number of packets to send before a T=
X notification.
+\item \field{pkt_rate}: Threshold for low/high packet rate coalescing para=
meters, in units of packets per second.
 \end{itemize}
=20
=20
-The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
+The class VIRTIO_NET_CTRL_NOTF_COAL has 6 commands:
 \begin{enumerate}
-\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and \fiel=
d{tx_max_packets} parameters.
-\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \fiel=
d{rx_max_packets} parameters.
+\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{usecs} and \field{m=
ax_packets} coalescing parameters for TX.
+\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{usecs} and \field{m=
ax_packets} coalescing parameters for RX.
+\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET: set the \field{usecs} and \fie=
ld{max_packets} coalescing parameters for packet rate of \field{pkt_rate} o=
r lower, for TX.
+\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET: set the \field{usecs} and \fie=
ld{max_packets} coalescing parameters for packet rate of \field{pkt_rate} o=
r lower, for RX.
+\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET: set the \field{usecs} and \fi=
eld{max_packets} coalescing parameters for packet rate of \field{pkt_rate} =
or higher, for TX.
+\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET: set the \field{usecs} and \fi=
eld{max_packets} coalescing parameters for packet rate of \field{pkt_rate} =
or higher, for RX.
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
@@ -4543,8 +4565,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Ty=
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
@@ -4554,18 +4576,65 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
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
+
+If the device sends 10 packets, then it receives a VIRTIO_NET_CTRL_NOTF_CO=
AL_TX_SET command with \field{max_packets} =3D 8, the device needs to immed=
iately send a TX notification, if the notifications are not suppressed by t=
he driver.
+
+\subparagraph{Low/High Rate Notifications}\label{sec:Device Types / Networ=
k Device / Device Operation / Control Virtqueue / Notifications Coalescing =
/ Low/High Rate Notifications}
+
+If the VIRTIO_NET_F_NOTF_COAL_LOW_HIGH feature is negotiated, the driver c=
an send the following low/high rate coalescing commands to the device:
+
+\begin{itemize}
+\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET.
+\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET.
+\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET.
+\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET.
+\end{itemize}
+
+For VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_LOW=
_RX_SET, struct virtio_net_ctrl_coal_threshold specifies the coalescing par=
ameters to use when the packet rate is \field{pkt_rate} or lower.
+
+For VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_HI=
GH_RX_SET, struct virtio_net_ctrl_coal_threshold specifies the coalescing p=
arameters to use when the packet rate is \field{pkt_rate} or higher.
+
 \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / N=
etwork Device / Device Operation / Control Virtqueue / Notifications Coales=
cing}
=20
 If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver =
MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
=20
+If the VIRTIO_NET_F_NOTF_COAL_LOW_HIGH feature has not been negotiated, th=
e driver MUST NOT issue low/high rate coalescing commands.
+
+The driver SHOULD issue a low/high rate coalescing command with \field{pkt=
_rate} 0 in order to remove the low/high rate coalescing parameters.
+
+The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET command w=
ith \field{pkt_rate} equal or higher than a \field{pkt_rate} previously sen=
t with a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET command.
+
+The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET command w=
ith \field{pkt_rate} equal or higher than a \field{pkt_rate} previously sen=
t with a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET command.
+
+The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET command =
with \field{pkt_rate} equal or lower than a \field{pkt_rate} previously sen=
t with a VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET command.
+
+The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET command =
with \field{pkt_rate} equal or lower than a \field{pkt_rate} previously sen=
t with a VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET command.
+
 \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types / N=
etwork Device / Device Operation / Control Virtqueue / Notifications Coales=
cing}
=20
 A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIR=
TIO_NET_ERR if it was not able to change the parameters.
=20
 A device SHOULD NOT send used buffer notifications to the driver, if the n=
otifications are suppressed as explained in \ref{sec:Basic Facilities of a =
Virtio Device / Virtqueues / Used Buffer Notification Suppression}, even if=
 the coalescing counters expired.
=20
+A device MUST remove the low/high rate coalescing parameters, if a low/hig=
h rate coalescing command is received with \field{pkt_rate} 0.
+
+A device MUST respond with VIRTIO_NET_ERR to a VIRTIO_NET_CTRL_NOTF_COAL_L=
OW_TX_SET command with \field{pkt_rate} equal or higher than a \field{pkt_r=
ate} previously received with a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET comma=
nd.
+
+A device MUST respond with VIRTIO_NET_ERR to a VIRTIO_NET_CTRL_NOTF_COAL_L=
OW_RX_SET command with \field{pkt_rate} equal or higher than a \field{pkt_r=
ate} previously received with a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET comma=
nd.
+
+A device MUST respond with VIRTIO_NET_ERR to a VIRTIO_NET_CTRL_NOTF_COAL_H=
IGH_TX_SET command with \field{pkt_rate} equal or lower than a \field{pkt_r=
ate} previously received with a VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET comman=
d.
+
+A device MUST respond with VIRTIO_NET_ERR to a VIRTIO_NET_CTRL_NOTF_COAL_H=
IGH_RX_SET command with \field{pkt_rate} equal or lower than a \field{pkt_r=
ate} previously received with a VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET comman=
d.
+
 Upon reset, a device MUST initialize all coalescing parameters to 0.
=20
+Upon reset, a device MUST not have a low/high rate coalescing parameters.
+
 \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 Types / Network Device / Legacy Interface: Framing Requirements}
=20
--=20
2.32.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

