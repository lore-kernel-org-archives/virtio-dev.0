Return-Path: <virtio-comment-return-3974-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Mon, 6 Feb 2023 23:08:47 +0000
Message-ID: <DM8PR12MB54806C5AF84EB7974D80FE0EDCDA9@DM8PR12MB5480.namprd12.prod.outlook.com>
References: <20230206084746.40536-1-alvaro.karsz@solid-run.com>
 <PH0PR12MB54817FE12FD77CC74B36D136DCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230206160206-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818A5BD25527FEAEAFF6CCDCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230206171410-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230206171410-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [virtio-dev] [PATCH] virtio-net: Fix and update
 VIRTIO_NET_F_NOTF_COAL feature
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, February 6, 2023 5:27 PM

[..]
> > So, both can handle/generate spurious notifications, but it shouldn't b=
e best
> line guidance.
>=20
> Don't really see why not. Lots of spurious interrupts would defeat the pu=
rpose
> of the feature clearly. But it might be handy e.g. for migration purposes=
.
Why migration generate too many spurious interrupts?
May be one or two per vector at destination..

> Overall it's tough to document in detail but if there are too many interr=
upts
> then surely it's a quality of implementation issue.
> I feel trying to go into too much detail here will just pointlessly make =
it verbose
> without making it clearer.
A generic note that device can generate any number of spurious interrupts i=
s not a spec material...

> > > what are packet counters though? they aren't defined anywhere.
> > >
> > Notification coalescing is counting packets in current text as " The de=
vice will
> count sent packets until it accumulates 15 ..."
>=20
> so it says counts packets but it does not mean there's a counter.
Counting packet without a counter... interesting. :)
I see your point to better word it without "counter".

> And "meet" does not really work with "parameters"...
>=20
A better wording is necessary.

> > > > For example, current \field{max_packets} is 15 for transmit
> > > > virtqueue, and
> > > device already sent 10 packets.
> > >
> > > I assume it is all per virtqueue? Makes sense but it does not
> > > actually say anywhere.
> > >
> > Yes, it is per virtqueue because the coalescing commands are per virtqu=
eue.
>=20
> in what sense? there's a single set of parameters per device.
> \begin{lstlisting}
> struct virtio_net_ctrl_coal_rx {
>     le32 rx_max_packets;
>     le32 rx_usecs;
> };
>=20
> struct virtio_net_ctrl_coal_tx {
>     le32 tx_max_packets;
>     le32 tx_usecs;
> };
>=20
> #define VIRTIO_NET_CTRL_NOTF_COAL 6
>  #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0  #define
> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1 \end{lstlisting}
>=20
> does not specify to which vq this applies, I think the implication is it =
applies to
> all of them.
>=20
Sadly yes.
I missed this basic thing missing in spec.
Even 5 years old algorithm like net dim may not work effectively with devic=
e global coalescing parameters.
Since 1.3 is not released, lets please fix it now to have it per VQ to avoi=
d having yet another command.
A tool that relies on global device level will still work with per VQ level=
 too.

>=20
>=20
> > Not sure explicitly keep adding per virtqueue in every line improves th=
e
> readability.
>=20
> well we have to say this somewhere at least and AFAIK we don't.
>=20
> > > > When device receives a VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
> command,
> > > the device SHOULD immediately send a TX notification.
> > >
> > > always? why?
> > Ah no. not always. It was in the context of the example continuation.
> >
> > May be better to rewrite as,
> >
> > For example, current \field{max_packets} is 15 for the transmit virtque=
ue,
> and device already sent 10 packets; in such case when device receives a
> VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, the device SHOULD
> immediately send a TX notification.
>=20
>=20
> Parav this is not the best way to give comments I feel. Either just send =
a
> competing patch or (preferably) explain what is wrong with this one.
> Piecemeal "Its better written as" without anything in the way of explanat=
ion is
> not helpful. I for one don't have the time to review and reply to not jus=
t patches
> but also all the random suggestions you are throwing around.

It is not random and not "all".
The part I missed is current command limits to per device.
I didn't expect VQN to be missing. :(

Please don't attribute suggestion of "avoid device is good to generate spur=
ious interrupt" as random..

I understood your suggestion that when suggesting, describe the problem and=
 the solution both.
I will improve this area going forward. Thanks for the inputs.

This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

