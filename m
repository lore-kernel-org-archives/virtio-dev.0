Return-Path: <virtio-dev-return-10337-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C532F9863D8
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Dec 2022 10:17:38 +0000 (UTC)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 21 Dec 2022 12:17:29 +0200
Message-Id: <20221221101729.648097-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] virtio_net: support low and high rate of notification coalescing sets
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, mst@redhat.com, Alvaro Karsz <alvaro.karsz@solid-run.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This patch adds a new feature VIRTIO_NET_F_NOTF_COAL_LOW_HIGH,
and adds 2 new commands to VIRTIO_NET_CTRL_NOTF_COAL class:
=09* VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET - create a low-rate set of
=09  coalescing parameters. the device should switch to this set when
=09  the packet rate (packets per second) reaches the pkt_rate_low threshol=
d.

=09* VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET - create a high-rate set of
          coalescing parameters. the device should switch to this set when
          the packet rate (packets per second) reaches the pkt_rate_high th=
reshold.

A device may have up to 3 sets, and should switch between them based on
the packet rate.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 content.tex | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 96f4723..969f945 100644
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
@@ -4504,9 +4507,25 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
     le32 tx_usecs;
 };
=20
+//Only if VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated
+struct virtio_net_ctrl_coal_low {
+        le32 pkt_rate_low;
+        struct virtio_net_ctrl_coal_tx tx;
+        struct virtio_net_ctrl_coal_rx rx;
+};
+
+//Only if VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated
+struct virtio_net_ctrl_coal_high {
+        le32 pkt_rate_high;
+        struct virtio_net_ctrl_coal_tx tx;
+        struct virtio_net_ctrl_coal_rx rx;
+};
+
 #define VIRTIO_NET_CTRL_NOTF_COAL 6
  #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
  #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
+ #define VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET 2 //Only if VIRTIO_NET_F_NOTF_C=
OAL_LOW_HIGH negotiated
+ #define VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET 3 //Only if VIRTIO_NET_F_NOTF_=
COAL_LOW_HIGH negotiated
 \end{lstlisting}
=20
 Coalescing parameters:
@@ -4515,13 +4534,17 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
 \item \field{tx_usecs}: Maximum number of usecs to delay a TX notification=
.
 \item \field{rx_max_packets}: Maximum number of packets to receive before =
a RX notification.
 \item \field{tx_max_packets}: Maximum number of packets to send before a T=
X notification.
+\item \field{pkt_rate_low}: Threshold for low packet rate set (packets per=
 second).
+\item \field{pkt_rate_high}: Threshold for high packet rate set (packets p=
er second).
 \end{itemize}
=20
=20
-The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
+The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
 \begin{enumerate}
 \item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and \fiel=
d{tx_max_packets} parameters.
 \item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \fiel=
d{rx_max_packets} parameters.
+\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET: set the \field{rx_usecs}, \field{=
rx_max_packets}, \field{tx_usecs} and \field{tx_max_packets} set for a rate=
 of \field{pkt_rate_low} or less packets per second.
+\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET: set the \field{rx_usecs}, \field=
{rx_max_packets}, \field{tx_usecs} and \field{tx_max_packets} set for a rat=
e of \field{pkt_rate_high} or more packets per second.
 \end{enumerate}
=20
 \subparagraph{RX Notifications}\label{sec:Device Types / Network Device / =
Device Operation / Control Virtqueue / Notifications Coalescing / RX Notifi=
cations}
@@ -4554,18 +4577,54 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
 \item If the notifications are not suppressed by the driver, the device wi=
ll send an used buffer notification, otherwise, the device will not send an=
 used buffer notification as long as the notifications are suppressed.
 \end{itemize}
=20
+\subparagraph{Low/High Rate Notifications Sets}\label{sec:Device Types / N=
etwork Device / Device Operation / Control Virtqueue / Notifications Coales=
cing / Low/High Rate Notifications Sets}
+
+If the VIRTIO_NET_F_NOTF_COAL_LOW_HIGH feature is negotiated, the driver m=
ay send VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET/VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SE=
T commands to the device.
+
+The virtio_net_ctrl_coal_low struct defines a set of coalescing parameters=
 (\field{rx_usecs}, \field{tx_usecs}, \field{rx_max_packets} and \field{tx_=
max_packets}) that should be used when the packets rate is equal or lower t=
han \field{pkt_rate_low} packets per second.
+
+The virtio_net_ctrl_coal_high struct defines a set of coalescing parameter=
s (\field{rx_usecs}, \field{tx_usecs}, \field{rx_max_packets} and \field{tx=
_max_packets}) that should be used when the packets rate is equal or higher=
 than \field{pkt_rate_high} packets per second.
+
+A device may have up to 3 sets of coalescing parameters, and should switch=
 between the sets based on the packet rate.
+
+A device may have only a low rate set, in this case, it should coalesce no=
tifications only when the packet rate crosses down the \field{pkt_rate_low}=
 threshold.
+
+A device may have only a high rate set, in this case, it should coalesce n=
otifications only when the packet rate crosses up the \field{pkt_rate_high}=
 threshold.
+
+A device may have only a high rate set and a low rate set, in this case, i=
t should coalesce notifications only when the packet rate crosses up the \f=
ield{pkt_rate_high} threshold, or crosses down the \field{pkt_rate_low} thr=
eshold.
+
 \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / N=
etwork Device / Device Operation / Control Virtqueue / Notifications Coales=
cing}
=20
 If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver =
MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
=20
+If the VIRTIO_NET_F_NOTF_COAL_LOW_HIGH feature has not been negotiated, th=
e driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET/VIRTIO_NET_CTRL_N=
OTF_COAL_HIGH_SET commands.
+
+The driver SHOULD issue a VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET command with \=
field{pkt_rate_low} 0 in order to remove the low rate set.
+
+The driver SHOULD issue a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET command with =
\field{pkt_rate_high} 0 in order to remove the high rate set.
+
+The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET command with=
 \field{pkt_rate_low} equal or higher than \field{pkt_rate_high}, if VIRTIO=
_NET_CTRL_NOTF_COAL_HIGH_SET was issued.
+
+The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET command wit=
h \field{pkt_rate_high} equal or lower than \field{pkt_rate_low}, if VIRTIO=
_NET_CTRL_NOTF_COAL_LOW_SET was issued.
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
+The device MUST remove the low rate set if a VIRTIO_NET_CTRL_NOTF_COAL_LOW=
_SET command with \field{pkt_rate_low} 0 is received.
+
+The device MUST remove the high rate set if a VIRTIO_NET_CTRL_NOTF_COAL_HI=
GH_SET command with \field{pkt_rate_high} 0 is received.
+
+The device MUST respond with VIRTIO_NET_ERR to a VIRTIO_NET_CTRL_NOTF_COAL=
_LOW_SET command with \field{pkt_rate_low} equal or higher than \field{pkt_=
rate_high}, if a high rate set is being used.
+
+The device MUST respond with VIRTIO_NET_ERR to a VIRTIO_NET_CTRL_NOTF_COAL=
_HIGH_SET command with \field{pkt_rate_high} equal or lower than \field{pkt=
_rate_low}, if a low rate set is being used.
+
 Upon reset, a device MUST initialize all coalescing parameters to 0.
=20
+Upon reset, a device MUST not have a low rate and high rate sets.
+
 \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 Types / Network Device / Legacy Interface: Framing Requirements}
=20
--=20
2.32.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

