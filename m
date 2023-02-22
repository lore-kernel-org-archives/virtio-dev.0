Return-Path: <virtio-dev-return-11204-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Heng Qi <hengqi@linux.alibaba.com>
Date: Wed, 22 Feb 2023 22:06:32 +0800
Message-Id: <20230222140632.10253-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v7] virtio-net: support the virtqueue coalescing moderation
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, David Edmondson <david.edmondson@oracle.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
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

v6->v7:
       1. Clarify the relationship of VIRTIO_NET_CTRL_NOTF_COAL_TX/RX_SET a=
nd VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET. @Alvaro Karsz, @Michael S. Tsirkin
       2. Remove formula for vqn range. @Parav Pandit
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
       3. Unify tx and rx control structres into one structure virtio_net_c=
trl_coal_vq. @Michael S. Tsirkin
       4. Add a new control command VIRTIO_NET_CTRL_NOTF_COAL_VQ. @Michael =
S. Tsirkin, @Parav Pandit, @Alvaro Karsz
       5. The special value 0xFFF is removed because VIRTIO_NET_CTRL_NOTF_C=
OAL can be used. @Alvaro Karsz
       6. Clarify some special scenarios. @Michael S. Tsirkin, @Parav Pandi=
t, @Alvaro Karsz

 device-types/net/description.tex | 99 ++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 5 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/descriptio=
n.tex
index e71e33b..745e4d9 100644
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
@@ -1508,6 +1511,14 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
 If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
 send control commands for dynamically changing the coalescing parameters.
=20
+If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated:
+\begin{itemize}
+\item a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command to set =
coalescing parameters of a given
+      enabled transmit/receive virtqueue.
+\item a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command to a de=
vice, and the device responds with
+      coalescing parameters of a given enabled transmit/receive virtqueue.
+\end{itemize}
+
 \begin{note}
 The behavior of the device in response to these commands is best-effort:
 the device may generate notifications more or less frequently than specifi=
ed.
@@ -1519,25 +1530,76 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
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
+\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_usecs} and \fie=
ld{max_packets} parameters for an enabled transmit/receive
+                                        virtqueue whose number is \field{v=
qn}.
+\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device returns the \field{max_=
usecs} and \field{max_packets} parameters for an enabled
+                                        transmit/receive virtqueue whose n=
umber is \field{vqn}.
+\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: have the same effect of setting co=
alescing parameters as the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command repeate=
d for
+                                        each virtqueue of transmitq1\ldots=
 transmitqN.
+\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: have the same effect of setting co=
alescing parameters as the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command repeate=
d for
+                                        each virtqueue of receiveq1\ldots =
receiveqN.
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
@@ -1549,6 +1611,15 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
=20
 When the device has \field{max_usecs} =3D 0 or \field{max_packets} =3D 0, =
the notification conditions are met after every packet received/sent.
=20
+When a device receives a command of the VIRTIO_NET_CTRL_NOTF_COAL class to=
 set a coalescing parameter,
+it may set the parameter to a value close to a power of 2. For example:
+If the device receives \field{max_usecs} =3D 7 from the VIRTIO_NET_CTRL_NO=
TF_COAL_VQ_SET command, it may set \field{max_usecs} =3D 8 for a given enab=
led virtqueue.
+
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
@@ -1585,11 +1656,29 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
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
+The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET =
commands set coalescing parameters for all transmit/receive
+virtqueues respectively and values of coalescing parameters are recorded a=
s global values by a device.
+The device MUST set the global values of coalescing parameters to 0 after =
being reset.
+The VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command sets the coalescing parameter=
s for a given enabled virtqueue without changing the global values.
+
+After disabling and re-enabling a virtqueue, the device MUST revert coales=
cing parameters of the virtqueue to the global values.
+
+A device MAY set the coalescing parameter to a value close to a power of 2=
 value.
+
+A device MUST ignore \field{reserved}.
=20
 A device SHOULD NOT send used buffer notifications to the driver if the no=
tifications are suppressed, even if the notification conditions are met.
=20
--=20
2.19.1.6.gb485710b


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

