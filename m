Return-Path: <virtio-comment-return-4541-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Heng Qi <hengqi@linux.alibaba.com>
Date: Sun, 26 Feb 2023 17:37:24 +0800
Message-Id: <20230226093724.44717-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v9] virtio-net: support the virtqueue coalescing moderation
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>, David Edmondson <david.edmondson@oracle.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Currently, coalescing parameters are grouped for all transmit and receive
virtqueues. This patch supports setting or getting the parameters for a
specified virtqueue, and a typical application of this function is netdim[1=
].

When the traffic between virtqueues is unbalanced, for example, one virtque=
ue
is busy and another virtqueue is idle, then it will be very useful to
control coalescing parameters at the virtqueue granularity.

[1] https://docs.kernel.org/networking/net_dim.html

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
This patch is on top of Alvaro's latest v7 patch: https://lists.oasis-open.=
org/archives/virtio-dev/202302/msg00431.html .

v8->v9:
       1. Declare the commands that can be sent for each feature. @Alvaro K=
arsz
       2. Add information about "global values" in the command's explanatio=
n. @Alvaro Karsz

v7->v8:
       1. Use "best-effort" in Alvaro's patch instead of "the device may se=
t the parameter to a value close to 2". @Michael S . Tsirkin, @David Edmond=
son

v6->v7:
       1. Clarify the relationship of VIRTIO_NET_CTRL_NOTF_COAL_TX/RX_SET a=
nd VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET. @Alvaro Karsz, @Michael S. Tsirkin
       2. Remove the formula for vqn range. @Parav Pandit
       3. Some expressions are clearer. @Parav Pandit, @Michael S. Tsirkin

v5->v6:
       1. Explain that the device may set a different value than the one pa=
ssed in by the driver. @David Edmondson

v4->v5:
       1. Add the correspondence between virtio_net_ctrl_coal and virtio_ne=
t_ctrl_coal_vq and control commands. @Michael S. Tsirkin
       2. Add read and write attributes for each field. @Michael S. Tsirkin
       3. A clearer description of how to set coalescing parameters for vq =
reset. @Michael S. Tsirkin
       4. Fix some syntax errors. @Michael S. Tsirkin, @David Edmondson

v3->v4:
       1. Include virtio_net_ctrl_coal in the virtio_net_ctrl_coal_vq struc=
ture. @Alvaro Karsz
       2. Add consideration of vq reset. @Michael S. Tsirkin, @Parav Pandit=
, @Alvaro Karsz
       3. Avoid too many examples by giving a comprehensive example. @Micha=
el S. Tsirkin
       4. Fix typos and streamline clarifications. @Michael S. Tsirkin, @Pa=
rav Pandit, @Alvaro Karsz

v2->v3:
       1. Add the netdim link. @Parav Pandit
       2. VIRTIO_NET_F_VQ_NOTF_COAL no longer depends on VIRTIO_NET_F_NOTF_=
COAL. @Michael S. Tsirkin, @Alvaro Karsz
       3. _VQ_GET is explained more. @Michael S. Tsirkin
       4. Add more examples to avoid misunderstandings. @Michael S. Tsirkin
       5. Clarify some statements. @Michael S. Tsirkin, @Parav Pandit, @Alv=
aro Karsz
       6. Adjust the virtio_net_ctrl_coal_vq structure. @Michael S. Tsirkin
       7. Fix some typos. @Michael S. Tsirkin

v1->v2:
       1. Rename VIRTIO_NET_F_PERQUEUE_NOTF_COAL to VIRTIO_NET_F_VQ_NOTF_CO=
AL. @Michael S. Tsirkin
       2. Use the \field{vqn} instead of the qid. @Michael S. Tsirkin
       3. Unify tx and rx control structures into one structure virtio_net_=
ctrl_coal_vq. @Michael S. Tsirkin
       4. Add a new control command VIRTIO_NET_CTRL_NOTF_COAL_VQ. @Michael =
S. Tsirkin, @Parav Pandit, @Alvaro Karsz
       5. The special value 0xFFF is removed because VIRTIO_NET_CTRL_NOTF_C=
OAL can be used. @Alvaro Karsz
       6. Clarify some special scenarios. @Michael S. Tsirkin, @Parav Pandi=
t, @Alvaro Karsz

 device-types/net/description.tex | 95 +++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 8 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/descriptio=
n.tex
index e71e33b..71f6827 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -83,6 +83,8 @@ \subsection{Feature bits}\label{sec:Device Types / Networ=
k Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
=20
+\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notificatio=
n coalescing.
+
 \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing=
.
=20
 \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
@@ -139,6 +141,7 @@ \subsubsection{Feature bit requirements}\label{sec:Devi=
ce Types / Network Device
 \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_=
F_HOST_TSO6.
 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
+\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
 \end{description}
=20
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits / Legacy Interface: Feature bits}
@@ -1505,8 +1508,17 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
=20
 \paragraph{Notifications Coalescing}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue / Notifications Coalescing}
=20
-If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
-send control commands for dynamically changing the coalescing parameters.
+If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can send t=
he VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
+and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands to dynamically change the co=
alescing parameters for all transmit
+and receive virtqueues, respectively.
+
+If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated:
+\begin{itemize}
+\item a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command to set =
coalescing parameters of a given
+      enabled transmit/receive virtqueue.
+\item a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command to a de=
vice, and the device responds with
+      coalescing parameters of a given enabled transmit/receive virtqueue.
+\end{itemize}
=20
 \begin{note}
 The behavior of the device in response to these commands is best-effort:
@@ -1519,25 +1531,76 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
     le32 max_usecs;
 };
=20
+struct virtio_net_ctrl_coal_vq {
+    le16 vqn;
+    le16 reserved;
+    struct virtio_net_ctrl_coal coal;
+};
+
 #define VIRTIO_NET_CTRL_NOTF_COAL 6
  #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
  #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
+ #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
+ #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
 \end{lstlisting}
=20
+The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET =
commands use the
+virtio_net_ctrl_coal structure to set \field{max_usecs} and \field{max_pac=
kets} for all
+transmit/receive virtqueues.
+
+The VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command uses the virtio_net_ctrl_coal=
_vq structure
+to set \field{max_usecs} and \field{max_packets} for the supplied virtqueu=
e number \field{vqn}.
+
+The VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command gets the values of \field{max=
_usecs} and
+\field{max_packets} of the specified virtqueue from the device by setting =
\field{vqn}
+in the virtio_net_ctrl_coal_vq structure.
+
+# Read/Write attributes for coalescing parameters
+\begin{itemize}
+\item For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NO=
TF_COAL_RX_SET, \field{max_usecs}
+      and \field{max_packets} are write-only for a driver.
+\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, \field{vqn}, \fiel=
d{reserved}, \field{max_usecs}
+      and \field{max_packets} are write-only for a driver.
+\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn} and \f=
ield{reserved} are write-only
+      for a driver, and, \field{max_usecs} and \field{max_packets} are rea=
d-only for the driver.
+\end{itemize}
+
 Coalescing parameters:
 \begin{itemize}
+\item \field{vqn}: The virtqueue number of an enabled transmit or receive =
virtqueue.
 \item \field{max_usecs} for RX: Maximum number of microseconds to delay a =
RX notification.
 \item \field{max_usecs} for TX: Maximum number of microseconds to delay a =
TX notification.
 \item \field{max_packets} for RX: Maximum number of packets to receive bef=
ore a RX notification.
 \item \field{max_packets} for TX: Maximum number of packets to send before=
 a TX notification.
 \end{itemize}
=20
-The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
+\field{reserved} is reserved and it is ignored by a device.
+
+The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
 \begin{enumerate}
-\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and \fie=
ld{max_packets} parameters for all transmit virtqueues.
-\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and \fie=
ld{max_packets} parameters for all receive virtqueues.
+\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and \fie=
ld{max_packets} parameters for all transmit virtqueues, and values of
+                                        coalescing parameters are recorded=
 as TX global values by a device.
+\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and \fie=
ld{max_packets} parameters for all receive virtqueues, and values of
+                                        coalescing parameters are recorded=
 as RX global values by a device.
+\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_usecs} and \fie=
ld{max_packets} parameters for an enabled transmit/receive
+                                        virtqueue whose number is \field{v=
qn}, and do not change the TX/RX global values.
+\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device returns the \field{max_=
usecs} and \field{max_packets} parameters for an enabled
+                                        transmit/receive virtqueue whose n=
umber is \field{vqn}.
 \end{enumerate}
=20
+If coalescing parameters are being set, the device applies the last coales=
cing parameters received for a
+virtqueue, regardless of the command used to set the parameters. For examp=
le with 2 pairs of virtqueues:
+# Command sequence
+Each of the following commands sets \field{max_usecs} and \field{max_packe=
ts} parameters for virtqueues.
+\begin{itemize}
+\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing parameter=
s for virtqueue0 and virtqueue2, and, virtqueue1 and virtqueue3 retain thei=
r previous parameter values.
+\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =3D 0 se=
ts coalescing parameters for virtqueue0, and virtqueue2 retains the values =
from command1.
+\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} =3D 0, t=
he device responds with coalescing parameters of virtqueue0 set by command2=
.
+\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =3D 1 se=
ts coalescing parameters for virtqueue1, and virtqueue3 retains its previou=
s values.
+\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing parameter=
s for virtqueue1 and virtqueue3, and overrides the values set by command4.
+\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} =3D 1, t=
he device responds with coalescing parameters of virtqueue1 set by command5=
.
+\end{itemize}
+
 \subparagraph{Operation}\label{sec:Device Types / Network Device / Device =
Operation / Control Virtqueue / Notifications Coalescing / Operation}
=20
 The device sends a used buffer notification once the notification conditio=
ns are met and if the notifications are not suppressed as explained in \ref=
{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notific=
ation Suppression}.
@@ -1549,6 +1612,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
=20
 When the device has \field{max_usecs} =3D 0 or \field{max_packets} =3D 0, =
the notification conditions are met after every packet received/sent.
=20
+When the device receives the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_N=
ET_CTRL_NOTF_COAL_RX_SET commands,
+it saves the values of coalescing parameters as global values, and the VIR=
TIO_NET_CTRL_NOTF_COAL_VQ_SET command
+does not change the global values. If the device is reset, the global valu=
es will be set to 0.
+When a virtqueue is enabled after virtqueue reset, its coalescing paramete=
rs are set to global values.
+
 \subparagraph{RX Example}\label{sec:Device Types / Network Device / Device=
 Operation / Control Virtqueue / Notifications Coalescing / RX Example}
=20
 If, for example:
@@ -1585,15 +1653,26 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
=20
 \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / N=
etwork Device / Device Operation / Control Virtqueue / Notifications Coales=
cing}
=20
-If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver =
MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
+If neither the VIRTIO_NET_F_NOTF_COAL nor the VIRTIO_NET_F_VQ_NOTF_COAL fe=
ature
+has been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL c=
ommands.
+
+A driver MUST ignore the values of coalescing parameters received from the=
 VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if a device responds with VIRTIO_=
NET_ERR.
=20
 \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types / N=
etwork Device / Device Operation / Control Virtqueue / Notifications Coales=
cing}
=20
-A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIR=
TIO_NET_ERR if it was not able to change the parameters.
+A device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET=
_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it was not able to c=
hange the parameters.
+
+A device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with=
 VIRTIO_NET_ERR if it was not able to change the parameters.
+
+A device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NET_C=
TRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if the given virtqueue is=
 disabled.
+
+A device MUST ignore \field{reserved}.
=20
 A device SHOULD NOT send used buffer notifications to the driver if the no=
tifications are suppressed, even if the notification conditions are met.
=20
-Upon reset, a device MUST initialize all coalescing parameters to 0.
+After disabling and re-enabling a virtqueue, the device MUST revert coales=
cing parameters of the virtqueue to the global values.
+
+Upon reset, a device MUST initialize all coalescing parameters to 0 and MU=
ST set the global values to 0.
=20
 \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 Types / Network Device / Legacy Interface: Framing Requirements}
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

