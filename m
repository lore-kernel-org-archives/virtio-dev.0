Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] Add device reset timeout field
Date: Tue, 12 Oct 2021 10:35:45 +0000
Message-ID: <PH0PR12MB5481D32984226A4363F19F86DCB69@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008063303-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481378DF0CE74777A5BEC90DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008071903-mutt-send-email-mst@kernel.org> <87lf33ybz7.fsf@redhat.com>
 <PH0PR12MB5481270F843DEC30A49972F3DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008085134-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816AD1011E3806A4A26B27DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008185926-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814DF6BE5016FB4D941847DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <871r4ry5do.fsf@redhat.com>
 <PH0PR12MB5481502C480B6A7C1B61DFD6DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87y26zwmyw.fsf@redhat.com>
In-Reply-To: <87y26zwmyw.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Monday, October 11, 2021 9:52 PM
>=20
> On Mon, Oct 11 2021, Parav Pandit <parav@nvidia.com> wrote:
>=20
> >> From: Cornelia Huck <cohuck@redhat.com>
> >> Sent: Monday, October 11, 2021 8:29 PM
> >>
> >> On Mon, Oct 11 2021, Parav Pandit <parav@nvidia.com> wrote:
>=20
> >> > I think read only device reset timeout is most elegant option
> >> > during device
> >> initialization phase that eliminates infinite loop of today.
> >>
> >> Why can't a driver just go ahead and do a timeout regardless?
> > o.k. lets consider this thought exercise. What is the timeout value tha=
t driver
> will choose if device doesn't specify one?
> > I explained in previous thread and you acked that actual fw based devic=
e
> may take longer to initialize than pure sw implementation backend.
> > In second example a pre-boot device can take even longer initialization=
 time.
> > Sriov VF device may initialize lot faster.
> > Instead of driver having such transport, and device specific checks, (o=
r some
> very short or very long timeout), we propose, that let device mention suc=
h
> timeout value.
>=20
> But does the driver really care in all cases?=20
Idea is that driver shouldn't care based on device type; rather just care w=
hat device provided.

> Say, I'm a virtio-blk driver, and I
> drive all kinds of virtio-blk devices. If I choose a timeout value that
> accommodates hardware devices, software devices will just always breeze
> past, and nothing bad happens.=20
I had hard time defining a universal timeout that fits all device types of =
hw and sw.
We have 3 variants of the hw based devices and they have range from millise=
conds to ten of seconds (in worst case).
Hence, the request is to let device feed the value based on the internal lo=
gic.

> If I know that I'm in a pre-boot environment,
> I'll just add on a value that allows devices to warm up. I'd say reasonab=
le
> values depend way more on the driver implementation and the environment
> it is running in than on the device.
>=20
It will be usually min_of (env.max_timeout, device.reset_timeout) if env wa=
nts to enforce its upper limit.

> >
> >> This seems
> >> pretty much to depend on the implementation. Nothing in the virtio
> >> spec forces the driver to reset all devices serially and wait
> >> potentially forever. (If you deal with a large amount of subdevices
> >> you cannot access concurrently, you likely already have problems.)
> > Sure, nothing in driver forces serial initialization.
> > However in reality, PCI device scanning on the bus in hotplug driver, p=
reboot
> env, sriov vf initialization is serial.
>=20
> So, can't pci scan asynchronously? Is that a limitation in the pci spec?
There isn't limitation from pci spec to my knowledge.
Linux device discovery to my knowledge is not parallel across or within a s=
ubsystem.

> The Linux ccw bus switched to asynchronous processing precisely because o=
f
> slow devices years ago, FWIW, so that may be why I don't really understan=
d
> the issue.
>=20
> > In preboot case, even the order is defined, so it is sort of serial.
>=20
> Again, is that somewhere in the hardware spec, and can it be fixed?
It is not in the hardware spec.
Preboot env usually runs with limited text and data memory without the OS.
User defined the boot order at the BIOS level. It is the way some systems w=
ork.
virtio device is fitting in the existing eco-system of physical servers.

> Serializing something that might take some time just seems troublesome.
>=20
True, which is why as Michael mentioned, device resetting within short inte=
rval is better.
I cannot promise, but yes, with newer generation usually such timing and fu=
nctionality should improves.
There is still finite timeout though.

> > In other uses, concurrent access is fine and host does that today when =
it
> disables autoprobe on the PCI Bus and probes them in parallel after enabl=
ing
> sriov.
> > I hope you understand that there are both use-cases exists which scan
> parallel and some serial.
>=20
> Can at least some processing be made asynchronous? Like, you discover the
> device, but then do the virtio setup out of band.
Do you mean differ virtio device setup in a workqueue context or similar?

This may be possible, but when user does sysfs operations, it adds uncertai=
nly to when the device's netdevice will actually appear even though sysfs o=
peration completed for probe.
It requires users to listen to udev events to know that for a given PCI vir=
tio pci device, now a net/block device is available.
This makes the whole flow complex to use.
May be certain device omit exposing device reset timeout, and workqueue/dif=
fered context can be avoided, but again now the user sw is unaware when to =
use udev to discover vs inline.

