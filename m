Return-Path: <virtio-comment-return-4313-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Fri, 17 Feb 2023 14:14:48 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
Message-ID: <20230217061448.GB114259@h68b04307.sqa.eu95>
References: <20230216144301.57728-1-hengqi@linux.alibaba.com>
 <bc5776d7-dda2-0e5f-be75-8ee044d93cb7@linux.alibaba.com>
 <20230216105600-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230216105600-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-comment] Re: [virtio-dev] [PATCH v3] virtio-net: support
 the virtqueue coalescing moderation
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 16, 2023 at 11:08:54AM -0500, Michael S. Tsirkin wrote:
> On Thu, Feb 16, 2023 at 10:49:25PM +0800, Heng Qi wrote:
> >=20
> >=20
> > =E5=9C=A8 2023/2/16 =E4=B8=8B=E5=8D=8810:43, Heng Qi =E5=86=99=E9=81=93=
:
> > > Currently coalescing parameters are grouped for all transmit and rece=
ive
> > > virtqueues. This patch supports setting or getting the parameters for=
 a
> > > specified virtqueue, and a typical application of this function is ne=
tdim[1].
> > >=20
> > > When the traffic between virtqueues is unbalanced, for example, one v=
irtqueue
> > > is busy and another virtqueue is idle, then it will be very useful to
> > > control coalescing parameters at the virtqueue granularity.
> > >=20
> > > [1] https://docs.kernel.org/networking/net_dim.html
> > >=20
> > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > > v2->v3:
> > >      1. Add the netdim link. @Parav Pandit
> > >      2. VIRTIO_NET_F_VQ_NOTF_COAL no longer depends on VIRTIO_NET_F_N=
OTF_COAL. @Michael S. Tsirkin, @Alvaro Karsz
> > >      3. _VQ_GET is explained more. @Michael S. Tsirkin
> > >      4. Add more examples to avoid misunderstandings. @Michael S. Tsi=
rkin
> > >      5. Clarify some statements. @Michael S. Tsirkin, @Parav Pandit, =
@Alvaro Karsz
> > >      6. Adjust the virtio_net_ctrl_coal_vq structure. @Michael S. Tsi=
rkin
> > >      7. Fix some typos. @Michael S. Tsirkin
> >=20
> > Hi Michael.
> >=20
> > I know you suggested in v2 that I split the virtqueue SET and GET comma=
nds
> > in series,
> > but I have a bit of a problem trying to split because there are some
> > statements where SET and GET are glued together.
> > Please see the following places.
> >=20
> > If you think the split is better, I'll split it again and send it right
> > away.
> >=20
> > Thanks.
>=20
>=20
> I don't mind that much. Lots of tiny patches are annoying too. Parav
> seems to want this though.
>=20
> > >=20
> > > v1->v2:
> > >      1. Rename VIRTIO_NET_F_PERQUEUE_NOTF_COAL to VIRTIO_NET_F_VQ_NOT=
F_COAL. @Michael S. Tsirkin
> > >      2. Use the \field{vqn} instead of the qid. @Michael S. Tsirkin
> > >      3. Unify tx and rx control structres into one structure virtio_n=
et_ctrl_coal_vq. @Michael S. Tsirkin
> > >      4. Add a new control command VIRTIO_NET_CTRL_NOTF_COAL_VQ. @Mich=
ael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
> > >      5. The special value 0xFFF is removed because VIRTIO_NET_CTRL_NO=
TF_COAL can be used. @Alvaro Karsz
> > >      6. Clarify some special scenarios. @Michael S. Tsirkin, @Parav P=
andit, @Alvaro Karsz
> > >=20
> > >   content.tex | 130 +++++++++++++++++++++++++++++++++++++++++++++++++=
+--
> > >   1 file changed, 126 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/content.tex b/content.tex
> > > index e863709..7f99503 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Type=
s / Network Device / Feature bits
> > >   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through contr=
ol
> > >       channel.
> > > +\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports the virtqueue
> > > +    notifications coalescing.
> > > +
> > >   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coa=
lescing.
> > >   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packet=
s.
> > > @@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label{=
sec:Device Types / Network Device
> > >   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> > >   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRT=
IO_NET_F_HOST_TSO6.
> > >   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > > +\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> > >   \end{description}
> > >   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Typ=
es / Network Device / Feature bits / Legacy Interface: Feature bits}
> > > @@ -4501,8 +4505,11 @@ \subsubsection{Control Virtqueue}\label{sec:De=
vice Types / Network Device / Devi
> > >   };
> > >   #define VIRTIO_NET_CTRL_NOTF_COAL 6
> > > - #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
> > > + #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET 0
> > >    #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> > > + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
> > > + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
> >=20
> > here
> >=20
> > > +
> > >   \end{lstlisting}
> > >   Coalescing parameters:
> > > @@ -4514,12 +4521,67 @@ \subsubsection{Control Virtqueue}\label{sec:D=
evice Types / Network Device / Devi
> > >   \end{itemize}
> > > -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
> > > +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
> >=20
> > here
> >=20
> > >   \begin{enumerate}
> > >   \item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} an=
d \field{tx_max_packets} parameters.
> > >   \item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} an=
d \field{rx_max_packets} parameters.
> > > +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_packets} =
and \field{max_usecs} parameters for a enabled
> > > +                                        transmit/receive virtqueue w=
hose number is \field{vqn}.
> > > +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device gets the \field{m=
ax_packets} and \field{max_usecs} parameters of
> > > +                                        a enabled transmit/receive v=
irtqueue whose number is \field{vqn}, and then
> > > +                                        responds them to the driver.
> > >   \end{enumerate}
> > > +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated:
> > > +1. a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command to s=
et the coalescing
> > > +   parameters of a enabled transmit/receive virtqueue.
>=20
> an enabled
>=20

Will fix.

> > > +2. a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command to a=
 device, and the device
> > > +   responds to the driver with the coalescing parameters of a enable=
d transmit/receive virtqueue.
>=20
> an enabled

Will fix.

>=20
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_net_ctrl_coal_vq {
> > > +    le16 vqn;
> > > +    le16 reserved;
> > > +    le32 max_packets;
> > > +    le32 max_usecs;
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +Virtqueue coalescing parameters:
> > > +\begin{itemize}
> > > +\item \field{vqn}: The virtqueue number of the enabled transmit or r=
eceive virtqueue, excluding the control virtqueue.
> > > +\item \field{max_packets}: The maximum number of packets sent/receiv=
ed by the specified virtqueue before a TX/RX notification.
> > > +\item \field{max_usecs}: The maximum number of TX/RX usecs that the =
specified virtqueue delays a TX/RX notification.
> > > +\end{itemize}
> > > +
> > > +\field{reserved} is reserved and it is ignored by the device.
> > > +
> > > +THe value of \field{vqn} satisfies $ 0 \leq vqn < max_virtqueue_pair=
s \ast 2 $.
> > > +The conversion between \field{vqn} and transmitq/receiveq index:
> > > +\begin{itemize}
> > > +$ \lfloor vqn / 2 \rfloor $ is the index of the corresponding receiv=
eq.
> > > +$ \lfloor (vqn / 2) + 1 \rfloor $ is the index of the corresponding =
tranmitq.
> > > +\end{itemize}
> > > +
> > > +The VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command is the same as the VIRT=
IO_NET_CTRL_NOTF_COAL_VQ_SET
>=20
> has the same effect

Ok.

>=20
> > > +command repeated for each virtqueue of receiveq1\ldots receiveqN.
> > > +
> > > +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command is the same as the VIRT=
IO_NET_CTRL_NOTF_COAL_VQ_SET
>=20
>=20
> has the same effect

Ok.

>=20
> > > +command repeated for each virtqueue of transmitq1\ldots transmitqN.
> > > +
> > > +If coalescing parameters are being set, the device applies the last =
coalescing parameters received for a
> > > +virtqueue, regardless of the command used to deliver the parameters.=
 For example:
> > > +# Command sequence 1:
> > > +1. VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command with $ \field{max_packet=
s} =3D 15 $ and $ \field{max_usecs} =3D 10 $
> > > +2. VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with $ \field{vqn} =3D 0=
 $, $ \field{max_packets} =3D 12 $ and $ \field{max_usecs} =3D 8 $
> > > +After #2 command is applied by the device, the coalescing parameters=
 of receiveq1 are $ \field{max_packets} =3D 12 $ and $ \field{max_usecs} =
=3D 8 $,
> > > +and the coalescing parameters of receiveq2\ldots receiveqN are $ \fi=
eld{max_packets} =3D 15 $ and $ \field{max_usecs} =3D 10 $.
> > > +
> > > +# Command sequence 2:
> > > +1. VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with $ \field{vqn} =3D 0=
 $, $ \field{max_packets} =3D 12 $ and $ \field{max_usecs} =3D 8 $
> > > +2. VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command with $ \field{max_packet=
s} =3D 15 $ and $ \field{max_usecs} =3D 10 $
> > > +After #2 command is applied by the device, the coalescing parameters=
 of receiveq1\ldots receiveqN are $ \field{max_packets} =3D 15 $ and $ \fie=
ld{max_usecs} =3D 10 $.
> > > +
> > >   \subparagraph{RX Notifications}\label{sec:Device Types / Network De=
vice / Device Operation / Control Virtqueue / Notifications Coalescing / RX=
 Notifications}
> > >   If, for example:
> > > @@ -4532,9 +4594,33 @@ \subsubsection{Control Virtqueue}\label{sec:De=
vice Types / Network Device / Devi
> > >   \begin{itemize}
> > >   \item The device will count received packets until it accumulates 1=
5, or until 10 usecs elapsed since the first one was received.
> > > -\item If the notifications are not suppressed by the driver, the dev=
ice will send an used buffer notification, otherwise, the device will not s=
end an used buffer notification as long as the notifications are suppressed=
.
> > > +\item If the notifications are not suppressed by the driver, the dev=
ice will send an used buffer notification, otherwise,
> > > +      the device will not send an used buffer notification as long a=
s the notifications are suppressed.
> > > +\end{itemize}
> > > +
> > > +Example of setting coalescing parameters for a receive virtqueue:
> > > +\begin{itemize}
> > > +\item \field{max_packets} =3D 15
> > > +\item \field{max_usecs} =3D 10
> > > +\item \field{vqn} =3D 0
> > > +\end{itemize}
> > > +
> > > +The device will operate as follows:
> > > +\begin{itemize}
> > > +\item The device applies the coalescing parameters to receiveq1 beca=
use its virtqueue number is 0.
> > > +\item The device will count received packets on receiveq1 until it a=
ccumulates 15, or until 10 usecs elapsed since the first one was received.
>=20
> use tense consistently:
> elapsed -> elapse,
> was -> is
>=20
> one refers to packets I guess but technically could refer to usecs.
>=20
> one -> packet
>=20
> usecs -> microsecons , eschew abbreviation

Thanks for pointing this out, I think this is more clear.

>=20
>=20
> > > +\item If the notifications are not suppressed by the driver, the dev=
ice will send an used buffer notification, otherwise,
> > > +      the device will not send an used buffer notification as long a=
s the notifications are suppressed.
> > > +\end{itemize}
> > > +
> > > +Example of getting coalescing parameters from a receive virtqueue:
> > > +\begin{itemize}
> > > +\item \field{vqn} =3D 0.
> > >   \end{itemize}
> > > +The device gets the values of the \field{max_packets} and \field{max=
_usecs} parameters from the receiveq1 whose virtqueue number is 0,
> > > +and then responds them to the driver.
>=20
> respond is not a transitive verb
> responds -> reports?

Ahh, will fix. But how about "returns" ?

>=20
> > > +
> > >   \subparagraph{TX Notifications}\label{sec:Device Types / Network De=
vice / Device Operation / Control Virtqueue / Notifications Coalescing / TX=
 Notifications}
> > >   If, for example:
> > > @@ -4550,14 +4636,50 @@ \subsubsection{Control Virtqueue}\label{sec:D=
evice Types / Network Device / Devi
> > >   \item If the notifications are not suppressed by the driver, the de=
vice will send an used buffer notification, otherwise, the device will not =
send an used buffer notification as long as the notifications are suppresse=
d.
> > >   \end{itemize}
> > > +Example of setting coalescing parameters for a transmit virtqueue:
> > > +\begin{itemize}
> > > +\item \field{max_packets} =3D 15
> > > +\item \field{max_usecs} =3D 10
> > > +\item \field{vqn} =3D 1
> > > +\end{itemize}
> > > +
> > > +The device will operate as follows:
> > > +
> > > +\begin{itemize}
> > > +\item The device applies the coalescing parameters to transmitq1 bec=
ause its virtqueue number is 1.
> > > +\item The device will count sent packets on transmitq1 until it accu=
mulates 15, or until 10 usecs elapsed since the first one was sent.
> > > +\item If the notifications are not suppressed by the driver, the dev=
ice will send an used buffer notification, otherwise,
> > > +      the device will not send an used buffer notification as long a=
s the notifications are suppressed.
> > > +\end{itemize}
> > > +
> > > +Example of getting coalescing parameters from a transmit virtqueue:
> > > +\begin{itemize}
> > > +\item \field{vqn} =3D 1.
> > > +\end{itemize}
> > > +
> > > +The device gets the values of the \field{max_packets} and \field{max=
_usecs} parameters from the transmitq1 whose virtqueue number is 1,
> > > +and then responds them to the driver.
>=20
> same
>=20
> > > +
> > >   \drivernormative{\subparagraph}{Notifications Coalescing}{Device Ty=
pes / Network Device / Device Operation / Control Virtqueue / Notifications=
 Coalescing}
> > > -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the d=
river MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> > > +If neither the VIRTIO_NET_F_NOTF_COAL nor the VIRTIO_NET_F_VQ_NOTF_C=
OAL feature
> > > +has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_N=
OTF_COAL commands.
> > > +
> > > +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated, the driver M=
UST set \field{vqn}
> > > +to a legal value, that is, \field{vqn} points to an enabled transmit=
/receive virtqueue.
>=20
> either all perfect or all in simple tense
> and maybe just put the formula here.

Sure.

>=20
>=20
> > > +
> > > +A driver MAY NOT get exactly the same value as the coalescing
> > > parameter it was set to,
>=20
>=20
>=20
> This is really a device conformance statement not a driver one.
> And MAY NOT means it is not allowed.
> just drop this here. or write that driver MUST NOT rely on getting same
> # back.

OK, I've covered this in device conformance, and it seems better to drop th=
is here.

>=20
> > for example it MAY get a value that is a
> > > power of 2.
>=20
> this confuses more than it clarifies.
>=20
> > >   \devicenormative{\subparagraph}{Notifications Coalescing}{Device Ty=
pes / Network Device / Device Operation / Control Virtqueue / Notifications=
 Coalescing}
> > >   A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands w=
ith VIRTIO_NET_ERR if it was not able to change the parameters.
> > > +When a device receives a virtqueue command to set/get coalescing par=
ameters for a virtqueue with number \field{vqn},
>=20
> virtqueue number, not virtqueue with number.

Ok.

>=20
> > > +if the virtqueue is not enabled, the device SHOULD respond to the co=
mmand with VIRTIO_NET_ERR.
> >=20
> > here
> >=20
> > > +
> > > +A device MAY NOT set the coalescing parameter to the exact same valu=
e as the one passed in by a driver. For example,
> > > +the value of \field{max_packets} set by the driver is 15, but the de=
vice MAY store a value that is a power of 2, that is, 16.
> > > +
>=20
> same as driver. MAY NOT means not allowed. should be MAY.
> going overvoard with examples. keep them out of conformance sections
> these must be clear by themselves.

I see. Thanks a lot for your suggestion!

>=20
> > >   A device SHOULD NOT send used buffer notifications to the driver, i=
f the notifications are suppressed as explained in \ref{sec:Basic Facilitie=
s of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}, =
even if the coalescing counters expired.
> > >   Upon reset, a device MUST initialize all coalescing parameters to 0=
.
>=20
>=20
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>=20
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>=20
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/

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

