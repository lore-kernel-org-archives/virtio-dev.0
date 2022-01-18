Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Date: Tue, 18 Jan 2022 07:07:03 +0000
Message-ID: <PH0PR12MB5481B99E351B624A27378BC5DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-3-mgurtovoy@nvidia.com>
 <20220113102218-mutt-send-email-mst@kernel.org>
 <eaf88f9c-8b51-7758-90c0-c1a92df35061@nvidia.com>
 <20220113121203-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B90FF747D56377A0A850DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220117170442-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818033A0BD96EA9493C51ADC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118011731-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816DB30F23511266B8F35EDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118014737-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220118014737-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, January 18, 2022 12:25 PM
>=20
> On Tue, Jan 18, 2022 at 06:32:50AM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, January 18, 2022 11:54 AM
> > >
> > > On Tue, Jan 18, 2022 at 04:44:36AM +0000, Parav Pandit wrote:
> > > >
> > > >
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Tuesday, January 18, 2022 3:44 AM
> > > >
> > > > > > > It's a control queue. Why do we worry?
> > > > > > It is used to control/manage the resource of a VF which is
> > > > > > deployed usually
> > > > > to a VM.
> > > > > > So higher the latency, higher the time it takes to deploy start=
 the VM.
> > > > >
> > > > > What are the savings here, in real terms? Boot times for
> > > > > smallest VMs are in 10s of milliseconds. Is reordering of a
> > > > > queue somehow going to save more than microseconds?
> > > > >
> > > > It is probably better not to pick on a specific vendor implementati=
on.
> > > > But for real numbers, I see that an implementation takes 54usec to
> > > > 500 usec
> > > range for simple configuration.
> > > >
> > > > It is better to not small VM 4 vector configuration to take longer
> > > > because
> > > there was previous AQ command for 64 vectors.
> > >
> > > So virtio discovery on boot includes multiple of vmexits, each costs
> > > ~1000 cycles.  And people do not seem to worry about it.
> > It is not the vector configuration by guest VM.
> > It is the AQ command that provisions number of msix vectors for the VF =
that
> takes tens to hundreds of usecs.
> > These are the command in patch-5 in this proposal.
>=20
> Hundreds of usecs is negligeable compared to VM boot time.
> Sorry I don't really see why we worry about indirect in that case.
>=20
>=20
Ok. we will do incremental proposal after this for wider use case.

> > > You want a compelling argument for working on performance of config.
> > > I frankly think it's not really useful but I especially think you
> > > should cut this out of the current proposal, it's too big as it is.
> > >
> > Ok. We can do follow on proposal after AQ.
> > We already see need of out of order AQ in internal performance tests we=
 are
> running.
>=20
> OK so first of all you can avoid declaring IN_ORDER. =20
This will force non IN_ORDER on other txq and rxq too that causes higher la=
tency.
But fine, initial implementation can start without it.

> If you see that IN_ORDER
> improves performance for you so you need it, then look at PARTIAL_ORDER
> pls.=20
Ok. will consider PARTIAL_ORDER more in future proposal.

> And if that does not address your needs then let's discuss, I'd rather ha=
ve a
> generic solution since the requirement does not seem to be specific to AQ=
.
>=20
> > But fine, we can differ.

So far I gather below summary that needs to be addressed in v2.

1. Use AQ for msix query and config
2. AQ to follows IN_ORDER and INDIRECT_DESC negotiation like rest of the qu=
eues
3. Update commit log to describe why config space is not chosen (scale, on-=
die registers, uniform way to handle all aq cmds)
4. Improve documentation around msix config to link to sriov section of vir=
tio spec
5. Describe error that if VF is bound to the device, admin commands targeti=
ng VF can fail, describe this error code

Did I miss anything?

Yet to receive your feedback on group, if/why is it needed and, why/if it m=
ust be in this proposal, what pieces prevents it do as follow-on.

Cornelia, Jason,
Can you please review current proposal as well before we revise v2?

