Return-Path: <virtio-dev-return-10793-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B0B579860CC
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Feb 2023 13:39:30 +0000 (UTC)
Date: Wed, 8 Feb 2023 08:39:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230208083247-mutt-send-email-mst@kernel.org>
References: <20230207111634.75542-1-hengqi@linux.alibaba.com>
 <20230207090019-mutt-send-email-mst@kernel.org>
 <98c2cd3f-2f59-74e1-0b37-cbf2a9180bd4@linux.alibaba.com>
 <20230208045634-mutt-send-email-mst@kernel.org>
 <8008f51b-e7b7-b5c4-5e4b-2298acabe636@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <8008f51b-e7b7-b5c4-5e4b-2298acabe636@linux.alibaba.com>
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [PATCH]
 virtio-net: support per-queue coalescing moderation
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 08, 2023 at 07:23:10PM +0800, Heng Qi wrote:
>=20
>=20
> =E5=9C=A8 2023/2/8 =E4=B8=8B=E5=8D=886:04, Michael S. Tsirkin =E5=86=99=
=E9=81=93:
> > On Wed, Feb 08, 2023 at 09:57:54AM +0800, Heng Qi wrote:
> > >=20
> > > =E5=9C=A8 2023/2/7 =E4=B8=8B=E5=8D=8810:06, Michael S. Tsirkin =E5=86=
=99=E9=81=93:
> > > > On Tue, Feb 07, 2023 at 07:16:34PM +0800, Heng Qi wrote:
> > > > > Currently, the coalescing profile is directly applied to all queu=
es.
> > > > > This patch supports configuring the parameters for a specified qu=
eue.
> > > > >=20
> > > > > When the traffic between queues is unbalanced, for example, one q=
ueue
> > > > > is busy and another queue is idle, then it will be very useful to
> > > > > control coalescing parameters at the queue granularity.
> > > > ethtool does not support this though, does it? what's the plan?
> > > Yes, ethtool does not support this function yet, and this function wi=
ll not
> > > conflict with ethool.
> > > Our current goal is to let virtio-net support netdim first.
> > >=20
> > > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > What I dislike about this interface is that if
> > > > VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, then
> > > > in the common case of same parameters for all queues
> > > > driver has to issue multiple commands.
> > > > I can see either a special vq index (0xffff ?) or a special
> > > > command used to set it for all queues.
> > > >=20
> > > >=20
> > > > > ---
> > > > >    content.tex | 49 ++++++++++++++++++++++++++++++++++++++++++---=
----
> > > > >    1 file changed, 42 insertions(+), 7 deletions(-)
> > > > >=20
> > > > > diff --git a/content.tex b/content.tex
> > > > > index e863709..049c0e4 100644
> > > > > --- a/content.tex
> > > > > +++ b/content.tex
> > > > > @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device =
Types / Network Device / Feature bits
> > > > >    \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through =
control
> > > > >        channel.
> > > > > +\item[VIRTIO_NET_F_PERQUEUE_NOTF_COAL(52)] Device supports per-q=
ueue
> > > > > +=09notifications coalescing.
> > > > > +
> > > > >    \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notification=
s coalescing.
> > > > >    \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 p=
ackets.
> > > > > @@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\la=
bel{sec:Device Types / Network Device
> > > > >    \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> > > > >    \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or=
 VIRTIO_NET_F_HOST_TSO6.
> > > > >    \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > > > > +\item[VIRTIO_NET_F_PERQUEUE_NOTF_COAL] Requires VIRTIO_NET_F_CTR=
L_VQ and VIRTIO_NET_F_NOTF_COAL.
> > > > >    \end{description}
> > > > >    \subsubsection{Legacy Interface: Feature bits}\label{sec:Devic=
e Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> > > > > @@ -4488,16 +4492,21 @@ \subsubsection{Control Virtqueue}\label{s=
ec:Device Types / Network Device / Devi
> > > > >    If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the drive=
r can
> > > > >    send control commands for dynamically changing the coalescing =
parameters.
> > > > > +If additionally VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, t=
he driver
> > > > > +can send control commands to configure the coalescing parameters=
 of a
> > > > > +specified receiveq or transmitq.
> > > > >    \begin{lstlisting}
> > > > >    struct virtio_net_ctrl_coal_rx {
> > > > >        le32 rx_max_packets;
> > > > >        le32 rx_usecs;
> > > > > +    le16 rx_qid;  (Only if VIRTIO_NET_F_PERQUEUE_NOTF_COAL negot=
iated)
> > > > >    };
> > > > >    struct virtio_net_ctrl_coal_tx {
> > > > >        le32 tx_max_packets;
> > > > >        le32 tx_usecs;
> > > > > +    le16 tx_qid;  (Only if VIRTIO_NET_F_PERQUEUE_NOTF_COAL negot=
iated)
> > > > >    };
> > > > >    #define VIRTIO_NET_CTRL_NOTF_COAL 6
> > > > I think it's a good idea to do this on top of Alvaro's patch
> > > > unifying these two structures.
> > > I saw Alvaro's patch, but it doesn't seem to be stable yet, is there =
a good
> > > way for me to
> > > unify the two structures, since a patch should only do one thing.
> > >=20
> > > > > @@ -4507,17 +4516,34 @@ \subsubsection{Control Virtqueue}\label{s=
ec:Device Types / Network Device / Devi
> > > > >    Coalescing parameters:
> > > > >    \begin{itemize}
> > > > > -\item \field{rx_usecs}: Maximum number of usecs to delay a RX no=
tification.
> > > > > -\item \field{tx_usecs}: Maximum number of usecs to delay a TX no=
tification.
> > > > > +\item \field{rx_qid}: Index of which receiveq to change the coal=
escing parameters.
> > > > > +=09If the value is between 0 and 0x7FFF, it represents the index=
 of the specified
> > > > > +=09receiveq. Otherwise, if the value is 0xFFFF, it indicates to =
change the
> > > > > +=09coalescing parameters for all receiveqs.
> > > > what if the index does not map to a receive queue?
> > > The spec mentioned
> > > "A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands wi=
th
> > > VIRTIO_NET_ERR if it was not able to change the parameters.",
> > > I think this belongs to this situation.
> > >=20
> > > Thanks.
> > Maybe but it's worth calling out. Because another interpretation
> > is that if qid matches rx queue we change rx parameters and
> > if it matches tx queue we change tx parameters.
> > There's a redundancy here I don't like different devices
> > might handle the error differently.
>=20
> Ok, I'll clarify here.
>=20
> > Maybe a new command is better?
>=20
> I agree, but there is one thing to confirm below.
>=20
> >=20
> > VIRTIO_NET_CTRL_NOTF_COAL_QUEUE_SET ?
> >=20
> > qid selects whether it's rx or tx.
>=20
> I think the qid you expressed here should refer to the virtqueue id?
> If qid represents the index of recieveq or transmitq, we can use
> VIRTIO_NET_CTRL_NOTF_COAL_RX_QUEUE_SET and
> VIRTIO_NET_CTRL_NOTF_COAL_TX_QUEUE_SET.
>=20
> Which do you think is more suitable? I think the latter (qid means the id=
 of
> receiveq or transmitq) seems to be more aligned with the current spec?


We do in fact have both. Calling vq number an index is well established
in the spec. index in the sense of  "floor(vq index / 2)" is only used
once where we document the RSS indirection table, so only for receive.

I would be inclined to talk about vq numbers and change RSS to do that
too.

Saying somewhere in
\section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqu=
eues}
that each virtqueue is associated with a 16 bit virtqueue index
can be a good idea, too.

--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

