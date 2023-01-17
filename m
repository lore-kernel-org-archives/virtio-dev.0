Return-Path: <virtio-comment-return-3850-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 17 Jan 2023 03:49:46 +0000
Message-ID: <PH0PR12MB548144EAE1AC19EEA7B7A28DDCC69@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230111152123.148889-1-alvaro.karsz@solid-run.com>
 <PH0PR12MB5481A88FBABF45BC2736AC56DCC19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230116152504-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548176D1EC760DB15826B08DDCC19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230116160634-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A96FAA7E7C032363D944DCC69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230116191559-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230116191559-mutt-send-email-mst@kernel.org>
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
> Sent: Monday, January 16, 2023 7:28 PM
>=20
> On Tue, Jan 17, 2023 at 12:07:59AM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Monday, January 16, 2023 4:30 PM
> >
> > > > > > So, can you please describe the motivation, what problem does
> > > > > > the new
> > > > > command solve?
> > > > > > It is likely that control entity which want to set different
> > > > > > coalescing
> > > > > parameters likely wants to more than just two values.
> > > > > > This is something already supported today.
> > > > >
> > > > > Interesting. Parav can you give some examples?
> > > >
> > > > In a Linux OS based system, following drivers [1] uses the
> > > > interrupt coalescing
> > > parameters by using net dim [2].
> > > >
> > > > Net dim is the control entity which enables to use more than 2
> > > > moderation
> > > parameters based on the workload instead of two low and high static
> values.
> > > >
> > > > [1] list of drivers
> > > > a. drivers/net/ethernet/amazon/ena/ena_netdev.c
> > > > b. drivers/net/ethernet/broadcom/bcmsysport.c
> > > > c. drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > > d. drivers/net/ethernet/broadcom/genet/bcmgenet.c
> > > > e. drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> > > > f. drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > g. drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
> > > > and more...
> > > >
> > > > [2] https://docs.kernel.org/networking/net_dim.html
> > >
> > > But this is net-dim. IIUC it's a software mechanism which tweaks
> > > coalescing parameters depending on traffic, right?
> > >
> > It is more than tweak.
> > It adjusts the parameters to avoid system oscillate and constant manual
> tuning.
> >
> > > Consider for example bnxt_dim_work: all this does is set a single
> > > set of usecs/packets parameters.
> > > IOW it's need already seem to be addressed in the spec.
> > >
> > > By comparison this patch is an attempt to offload ethtool's
> > > --coalesce parameters to the card. IMO what it misses is
> > > completeness, e.g. sample- interval is not specified.
> > Yes. fallback rate above low and below high are also missing.
>=20
> I think what author meant is just mirroring ethtool here.
>=20
> > > Also, introspection is missing and it's useful to avoid keeping all
> > > state in the driver.
> > >
> > > Now clearly net dim has potential to make more clever decisions, but
> > > OTOH it's clearly heavier weight.
> > >
> > Its heavy weight that already exists in one OS.
> > OTOH constantly invoking ethtool from user space for a admin/sw is heav=
y
> weight too.
> >
> > > So I personally see potential for both to be useful.
> > > If no why not?
> > >
> > Lets describe the problem, value and its usefulness to begin.
> > I am not against it. I just fail to find its good use with the existenc=
e of net dim.
> > So lets explain how it is better.
>=20
> If all you want is what ethtool provides the new interface will do exactl=
y that
> completely on the card without involving scheduler.
> That seems pretty clear.
>
What is clear from the commit message.
The motivation was not clear to me, with the advent of net dim support.
Proposed ethtool matching parameters exists for more than decade in ethtool=
.

> Which bits? For high and low? Maybe. It's really a single feature just fo=
r 2
> thresholds. Which looks like a trivial generalization of one.
They are not as general the existing one.
It has specific meaning to support two different thresholds that a device n=
eeds to monitor for.

> But I wonder whether any devices have more than 2 thresholds, or just one=
.
> Do we want N thresholds? How about taking a look at some other OS-es? I
> never looked at net dim internal logic to see whether it can reasonably b=
e
> offloaded to a card.
>=20
> All these are valid concerns that need research to address. Any input her=
e?
> Feature bits, use of cvq are all cosmetic issues by comparison.
>=20
The proposed ethtool counter part is implemented by only handful of devices=
.
Almost all those vendors have superseded those devices.
And those modern devices which superseded are not supporting them.
I am part of at least two device history as benet and mlx.
Both of them have not carried forward these parameters.

Compare to that net dim logic introduced in 2018 has found more than 10 act=
ive devices.
And it even extended to non nic device too.
This statistic clearly shows the value of it.

A next step would be as you suggest offloading this as well to the device.
However, this proposal is not addressing to offload it. This patch relies o=
n sw entity to configure some static values for two range.
So, it may be addressing some specific use case or OS scenario.

I like to see this motivation described in the commit log of v3, which help=
s to dial in the spec faster.

All I am asking is plan motivation on how it helps, instead of saying hey i=
t exists in ethtool a decade ago, lets do it...

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

