Return-Path: <virtio-comment-return-3845-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Mon, 16 Jan 2023 20:52:43 +0000
Message-ID: <PH0PR12MB548176D1EC760DB15826B08DDCC19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230111152123.148889-1-alvaro.karsz@solid-run.com>
 <PH0PR12MB5481A88FBABF45BC2736AC56DCC19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230116152504-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230116152504-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [virtio-dev] [PATCH v2] virtio_net: support low and high rate of
 notification coalescing
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, January 16, 2023 3:34 PM
>=20
> On Mon, Jan 16, 2023 at 07:42:01PM +0000, Parav Pandit wrote:
> > Hi Alvaro,
> >
> > > From: virtio-dev@lists.oasis-open.org
> > > <virtio-dev@lists.oasis-open.org> On Behalf Of Alvaro Karsz
> > >
> > > This patch adds a new feature, VIRTIO_NET_F_NOTF_COAL_LOW_HIGH,
> > > while clarifying/fixing existing coalescing concepts.
> > >
> > While its visible in the patch itself, what is being done, its
> > important to mention the problem statement/motivation for the feature a=
t
> start of the commit log as first step.
> >
> > So, can you please describe the motivation, what problem does the new
> command solve?
> > It is likely that control entity which want to set different coalescing
> parameters likely wants to more than just two values.
> > This is something already supported today.
>=20
> Interesting. Parav can you give some examples?

In a Linux OS based system, following drivers [1] uses the interrupt coales=
cing parameters by using net dim [2].

Net dim is the control entity which enables to use more than 2 moderation p=
arameters based on the workload instead of two low and high static values.

[1] list of drivers
a. drivers/net/ethernet/amazon/ena/ena_netdev.c
b. drivers/net/ethernet/broadcom/bcmsysport.c
c. drivers/net/ethernet/broadcom/bnxt/bnxt.c
d. drivers/net/ethernet/broadcom/genet/bcmgenet.c
e. drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
f. drivers/net/ethernet/intel/ice/ice_txrx.c
g. drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
and more...

[2] https://docs.kernel.org/networking/net_dim.html

> > They are best to be handled a pre-patch to this one.
> > Please split them so that spec improvement work can progress while new
> features are under review.
>=20
> Yea it's not a bad idea. I figured it out but
>=20
> > >
> > > +\item[VIRTIO_NET_F_NOTF_COAL_LOW_HIGH(50)] Device supports
> > > notifications coalescing low rate and high rate sets.
> > > +
> > Even though historically, many feature bits exists, adding more feature=
 bits is
> not scalable.
>=20
> I disagree here. We have unlimited feature bits and I see no problem with=
 their
> scalability. Devices (such as SIOV as opposed to SRIOV) which have very l=
imited
> memory need to use the proposed vq transport that intel's working on, pci
> transport is wasting too much memory anyway. I hope we are not going to
> repeat this discussion for each and every new feature :)
>=20
Pci transport of the virtio in current form asks to put things in device me=
mory.
And it doesn't need to continue this way regardless of SIOV.
It doesn't have any relation to SR-IOV either.

There are even PF devices too.

And putting things in feature bit limits the way these devices are composed=
.
So lets discuss to use control vq for get and set both.

Feature bit doesn't even cut what is needed. Software doesn't even know wha=
t the valid range is.
It needs to be discovered through cvq.

> > It is also limits to enable such functionality at very early stage in t=
he device
> configuration.
>=20
> Not really, it just handles compatibility and enables the commands.
>=20
Command is nothing but a functionality.

> > So, if at all this proceeds, we want the new admin q to discover and ne=
gotiate
> the new features.
> > (Instead of features bits).
>=20
> Sounds like a new transport. I wouldn't make it gate this proposal.
>=20
I am not gating the proposal.
Ctrl vq only does set.
Control VQ needs the ability to do get also on deciding what to control.
Hence, new things like this can be discovered by net specific ctrol vq.
No need for involving generic device feature bits framework here.

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

