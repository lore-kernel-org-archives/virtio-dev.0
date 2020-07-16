Return-Path: virtio-dev-return-7571-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EAB9E98607B
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Jul 2020 10:06:39 +0000 (UTC)
Date: Thu, 16 Jul 2020 11:00:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200716100051.GC85868@stefanha-x1.localdomain>
References: <87r1tdydpz.fsf@linaro.org>
 <20200715114855.GF18817@stefanha-x1.localdomain>
 <877dv4ykin.fsf@linaro.org>
 <20200715154732.GC47883@stefanha-x1.localdomain>
 <871rlcybni.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <871rlcybni.fsf@linaro.org>
Subject: Re: [virtio-dev] On doorbells (queue notifications)
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>, Jing Liu <jing2.liu@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, cohuck@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 05:40:33PM +0100, Alex Benn=E9e wrote:
>=20
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > On Wed, Jul 15, 2020 at 02:29:04PM +0100, Alex Benn=E9e wrote:
> >> Stefan Hajnoczi <stefanha@redhat.com> writes:
> >> > On Tue, Jul 14, 2020 at 10:43:36PM +0100, Alex Benn=E9e wrote:
> >> >> Finally I'm curious if this is just a problem avoided by the s390
> >> >> channel approach? Does the use of messages over a channel just avoi=
d the
> >> >> sort of bouncing back and forth that other hypervisors have to do w=
hen
> >> >> emulating a device?
> >> >
> >> > What does "bouncing back and forth" mean exactly?
> >>=20
> >> Context switching between guest and hypervisor.
> >
> > I have CCed Cornelia Huck, who can explain the lifecycle of an I/O
> > request on s390 channel I/O.
>=20
> Thanks.
>=20
> I was also wondering about the efficiency of doorbells/notifications the
> other way. AFAIUI for both PCI and MMIO only a single write is required
> to the notify flag which causes a trap to the hypervisor and the rest of
> the processing. The hypervisor doesn't have the cost multiple exits to
> read the guest state although it obviously wants to be as efficient as
> possible passing the data back up to what ever is handling the backend
> of the device so it doesn't need to do multiple context switches.
>=20
> Has there been any investigation into other mechanisms for notifying the
> hypervisor of an event - for example using a HYP call or similar
> mechanism?
>=20
> My gut tells me this probably doesn't make any difference as a trap to
> the hypervisor is likely to cost the same either way because you still
> need to save the guest context before actioning something but it would
> be interesting to know if anyone has looked at it. Perhaps there is a
> benefit in partitioned systems where core running the guest can return
> straight away after initiating what it needs to internally in the
> hypervisor to pass the notification to something that can deal with it?

It's very architecture-specific. This is something Michael Tsirkin
looked in in the past. He found that MMIO and PIO perform differently on
x86. VIRTIO supports both so the device can be configured optimally.
There was an old discussion from 2013 here:
https://lkml.org/lkml/2013/4/4/299

Without nested page tables MMIO was slower than PIO. But with nested
page tables it was faster.

Another option on x86 is using Model-Specific Registers (for hypercalls)
but this doesn't fit into the PCI device model.

A bigger issue than vmexit latency is device emulation thread wakeup
latency. There is a thread (QEMU, vhost-user, vhost, etc) monitoring the
ioeventfd but it may be descheduled. Its physical CPU may be in a low
power state. I ran a benchmark late last year with QEMU's AioContext
adaptive polling disabled so we can measure the wakeup latency:

       CPU 0/KVM 26102 [000] 85626.737072:       kvm:kvm_fast_mmio:
fast mmio at gpa 0xfde03000
    IO iothread1 26099 [001] 85626.737076: syscalls:sys_exit_ppoll: 0x1
                   4 microseconds ------^

(I did not manually configure physical CPU power states or use the
idle=3Dpoll host kernel parameter.)

Each virtqueue kick had 4 microseconds of latency before the device
emulation thread had a chance to process the virtqueue. This means the
maximum I/O Operations Per Second (IOPS) is capped at 250k before
virtqueue processing has even begun!

QEMU AioContext adaptive polling helps here because we skip the vmexit
entirely while the IOThread is polling the vring (for up to 32
microseconds by default).

It would be great if more people dig into this and optimize
notifications further.

Stefan

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8QJVMACgkQnKSrs4Gr
c8gNgwf/bsRZw+ZsFOW61Jt2KCqkLLXfd9NX3CZkWO+g6JDJwoUBYi1a3NaB4OcO
1ipSAZHE5W3bLd2M5k4AtnO8nKkD/tlM03IT8L/2Sc6QX05QouIjBy/O+MWAnrrN
3n3zEBLLNda4kSrqyVhPk6KYpO9WZiUu+ed4sv/ByVdcVL8XD5YIXRgdU2dHyfBU
n+onAsd6p5qJ6at4lOz+n+ErXlFtrBb/1PMHHW6rL/ttWX8rHZ27lXHa928++477
47kIJ9sJfgI4L1PIrWHItITZ0RW7kcvo56ZZVNpvOpm70YkHXlt8Wx5IK0qzo9cH
RbFSt3V8DU7rhkIdMIzft8q94ns1aw==
=RdFP
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--

