Return-Path: <virtio-comment-return-3847-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 17 Jan 2023 00:07:59 +0000
Message-ID: <PH0PR12MB5481A96FAA7E7C032363D944DCC69@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230111152123.148889-1-alvaro.karsz@solid-run.com>
 <PH0PR12MB5481A88FBABF45BC2736AC56DCC19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230116152504-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548176D1EC760DB15826B08DDCC19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230116160634-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230116160634-mutt-send-email-mst@kernel.org>
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
> Sent: Monday, January 16, 2023 4:30 PM

> > > > So, can you please describe the motivation, what problem does the
> > > > new
> > > command solve?
> > > > It is likely that control entity which want to set different
> > > > coalescing
> > > parameters likely wants to more than just two values.
> > > > This is something already supported today.
> > >
> > > Interesting. Parav can you give some examples?
> >
> > In a Linux OS based system, following drivers [1] uses the interrupt co=
alescing
> parameters by using net dim [2].
> >
> > Net dim is the control entity which enables to use more than 2 moderati=
on
> parameters based on the workload instead of two low and high static value=
s.
> >
> > [1] list of drivers
> > a. drivers/net/ethernet/amazon/ena/ena_netdev.c
> > b. drivers/net/ethernet/broadcom/bcmsysport.c
> > c. drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > d. drivers/net/ethernet/broadcom/genet/bcmgenet.c
> > e. drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> > f. drivers/net/ethernet/intel/ice/ice_txrx.c
> > g. drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
> > and more...
> >
> > [2] https://docs.kernel.org/networking/net_dim.html
>=20
> But this is net-dim. IIUC it's a software mechanism which tweaks coalesci=
ng
> parameters depending on traffic, right?
>
It is more than tweak.
It adjusts the parameters to avoid system oscillate and constant manual tun=
ing.
=20
> Consider for example bnxt_dim_work: all this does is set a single set of
> usecs/packets parameters.
> IOW it's need already seem to be addressed in the spec.
>=20
> By comparison this patch is an attempt to offload ethtool's --coalesce
> parameters to the card. IMO what it misses is completeness, e.g. sample-
> interval is not specified.
Yes. fallback rate above low and below high are also missing.

> Also, introspection is missing and it's useful to avoid keeping all state=
 in the
> driver.
>=20
> Now clearly net dim has potential to make more clever decisions, but OTOH=
 it's
> clearly heavier weight.
>=20
Its heavy weight that already exists in one OS.
OTOH constantly invoking ethtool from user space for a admin/sw is heavy we=
ight too.

> So I personally see potential for both to be useful.
> If no why not?
>
Lets describe the problem, value and its usefulness to begin.
I am not against it. I just fail to find its good use with the existence of=
 net dim.
So lets explain how it is better.
=20
> > > > They are best to be handled a pre-patch to this one.
> > > > Please split them so that spec improvement work can progress while
> > > > new
> > > features are under review.
> > >
> > > Yea it's not a bad idea. I figured it out but
> > >
> > > > >
> > > > > +\item[VIRTIO_NET_F_NOTF_COAL_LOW_HIGH(50)] Device supports
> > > > > notifications coalescing low rate and high rate sets.
> > > > > +
> > > > Even though historically, many feature bits exists, adding more
> > > > feature bits is
> > > not scalable.
> > >
> > > I disagree here. We have unlimited feature bits and I see no problem
> > > with their scalability. Devices (such as SIOV as opposed to SRIOV)
> > > which have very limited memory need to use the proposed vq transport
> > > that intel's working on, pci transport is wasting too much memory
> > > anyway. I hope we are not going to repeat this discussion for each
> > > and every new feature :)
> > >
> > Pci transport of the virtio in current form asks to put things in devic=
e memory.
> > And it doesn't need to continue this way regardless of SIOV.
> > It doesn't have any relation to SR-IOV either.
> >
> > There are even PF devices too.
> >
> > And putting things in feature bit limits the way these devices are comp=
osed.
> > So lets discuss to use control vq for get and set both.
> >
> > Feature bit doesn't even cut what is needed. Software doesn't even know
> what the valid range is.
> > It needs to be discovered through cvq.
>=20
>=20
> All well and good but let's not have this discussion in the thread please=
.
>
Ok. This feature bit trying to do multiple features under single bit and al=
l commands are not always useful.
It needs two feature bits.
And things start not to scale.
But fine.=20
=20
>=20
>=20
> > > > It is also limits to enable such functionality at very early stage
> > > > in the device
> > > configuration.
> > >
> > > Not really, it just handles compatibility and enables the commands.
> > >
> > Command is nothing but a functionality.
>=20
> No, during init time it is useful to know whether to hook up to OS mechan=
isms
> dealing with specific offloads.
>=20
It doesn't make sense to register a net device and set its feature bits wit=
hout really enumerating it fully.
And if that requires CVQ, it is more efficient anyway.

> > > > So, if at all this proceeds, we want the new admin q to discover
> > > > and negotiate
> > > the new features.
> > > > (Instead of features bits).
> > >
> > > Sounds like a new transport. I wouldn't make it gate this proposal.
> > >
> > I am not gating the proposal.
>=20
> what you are however doing is bringing issues unrealted to the patch in
> question. Let's focus on discussing coalescing here please.
>
It is proposing and even modifying the existing feature bit without describ=
ing how better it is.
If one feature requires to extend cvq, it is not a problem. We can surely e=
xtend it.
=20
>=20
> > Ctrl vq only does set.
> > Control VQ needs the ability to do get also on deciding what to control=
.
> > Hence, new things like this can be discovered by net specific ctrol vq.
> > No need for involving generic device feature bits framework here.
>=20
> I see even less value in moving compatibility machinery over to a device =
specific
> mechanism such as cvq.

There is lot more to discuss, but I am avoid here in this thread.
we need to first establish a generic mechanism for discovering net specific=
 features and its value (more than Boolean) in generic cvq way.
This pave the way forward for more complex things to come in including this=
.

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

