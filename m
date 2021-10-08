Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] Add device reset timeout field
Date: Fri, 8 Oct 2021 12:12:35 +0000
Message-ID: <PH0PR12MB5481270F843DEC30A49972F3DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211006141033.612283-1-parav@nvidia.com>
 <20211006111143-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008063303-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481378DF0CE74777A5BEC90DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008071903-mutt-send-email-mst@kernel.org> <87lf33ybz7.fsf@redhat.com>
In-Reply-To: <87lf33ybz7.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Friday, October 8, 2021 5:18 PM
>=20
> On Fri, Oct 08 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > On Fri, Oct 08, 2021 at 10:59:02AM +0000, Parav Pandit wrote:
> >> It may be even a pre-boot environment where 100msec or 10msec may be
> too short interval as other extreme of VM boot time example.
> >
> > I don't really know what this means. We are talking about how long it
> > takes device to calm down and stop poking at the host after it's told
> > to reset. 10ms worst case not enough for this?
>=20
> To me, that sounded more like a physical device that needs to do somethin=
g
> like boot its firmware before it can perform an actual virtio operation (=
and
> reset simply happens to be the first one.)
>=20
> So, I'm getting more confused about the scope of this timeout. If it's mo=
re a
> "device might not be ready yet" issue, I don't think we need a timeout fo=
r reset
> specifically. Same for races with hotplugging. If it's about "reset may t=
ake some
> time, because it will take some time before all operations have quiesced"=
, I
> don't see how the device can come up with a value that isn't anything oth=
er
> than a wild guess, and the driver could do wild guessing equally well.

Device implementation has good knowledge of how a given virtio device is im=
plemented to not do wild guess.
I will take real world examples.
1. A physical virtio device backed by a firmware will take more than 10msec=
 of boot time to respond to the reset operation.

2. A sriov VF virtio device for our case takes a lot lesser than this, but =
may take anywhere between 10 msec to 250msec.
This can happen on a firmware where user enabled 500 SR-IOV VFs.
Pci spec indicates that all VFs to initialize within 100msec. This translat=
es to 0.2msec for one VF.
In some scenario this can be a hard to initialize a VF in 0.2 msec dependin=
g on what else a firmware is doing at that time.

3. A system has one or more virtio boot devices.
One of them happens to be faulty after a firmware upgrade.
Pre-boot env is infinitely waiting. Michael suggest to do disable such PCI =
slot by means of abstract Ctrl+C.
If PCI slot is disabled, that device must be physically taken out for recov=
ery.
In an alternative, if device advertised a finite timeout, that device didn'=
t boot, system gave up after finite timeout and server picked second boot o=
ption, and booted.
Now a system admin can repair the faulty device without physically taking i=
t out.
Will infinite timeout help here? Or a device advertising finite timeout and=
 recovering the system more useful?

4. device was hotplug in system and before it is fully probed, a hot unplug=
 is triggered.
Device cannot respond to reset, because its hot unplugged.
OS waits infinitely for reset to complete.
And system component is stuck just because of one device.
Would a finite timeout help to abort this operation? Yes.

So is wild guess of 10msec for all devices or an infinite time most efficie=
nt way to handle above scenarios?

