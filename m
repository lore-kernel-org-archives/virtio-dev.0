Return-Path: virtio-dev-return-7554-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6078B98605B
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Jul 2020 17:02:10 +0000 (UTC)
Date: Wed, 15 Jul 2020 19:01:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20200715190147.05e71272.cohuck@redhat.com>
In-Reply-To: <20200715154732.GC47883@stefanha-x1.localdomain>
References: <87r1tdydpz.fsf@linaro.org>
	<20200715114855.GF18817@stefanha-x1.localdomain>
	<877dv4ykin.fsf@linaro.org>
	<20200715154732.GC47883@stefanha-x1.localdomain>
MIME-Version: 1.0
Subject: Re: [virtio-dev] On doorbells (queue notifications)
Content-Type: multipart/signed; boundary="Sig_/tt88aDv7HgX61sMainep_3J";
 protocol="application/pgp-signature"; micalg=pgp-sha256
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>, Jing Liu <jing2.liu@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--Sig_/tt88aDv7HgX61sMainep_3J
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jul 2020 16:47:32 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Wed, Jul 15, 2020 at 02:29:04PM +0100, Alex Benn=C3=A9e wrote:
> > Stefan Hajnoczi <stefanha@redhat.com> writes: =20
> > > On Tue, Jul 14, 2020 at 10:43:36PM +0100, Alex Benn=C3=A9e wrote: =20
> > >> Finally I'm curious if this is just a problem avoided by the s390
> > >> channel approach? Does the use of messages over a channel just avoid=
 the
> > >> sort of bouncing back and forth that other hypervisors have to do wh=
en
> > >> emulating a device? =20
> > >
> > > What does "bouncing back and forth" mean exactly? =20
> >=20
> > Context switching between guest and hypervisor. =20
>=20
> I have CCed Cornelia Huck, who can explain the lifecycle of an I/O
> request on s390 channel I/O.

Having read through this thread, I think this is mostly about
notifications? These are not using channel programs (which are only
used for things like feature negotiation, or emulating reading/writing
a config space, which does not really exist for channel devices.)

First, I/O and interrupts are highly abstracted on s390; much of the
register accesses or writes done on other architectures is just not
seen on s390.

Traditionally, I/O interrupts on s390 are tied to a subchannel; you
have a rather heavyweight process for that:

guest=09=09=09=09=09=09=09=09host

=09=09=09=09=09put status into subchannel
=09=09=09=09=09queue interrupt
open up for I/O interrupt
=09=09=09=09=09store some data into lowcore
=09=09=09=09=09do PSW swap
interrupt handler called
read from lowcore
call tsch for subchannel
=09=09=09=09=09store subchannel status into
=09=09=09=09=09control block
process control block
look at subchannel indicators
virtio queue processing

This is only used for configuration change notifications, or for very
old legacy virtio implementations.

There's an alternative mechanism not tied to a subchannel, called
'adapter interrupts'. (It is even used to implement MSI-X on s390x,
which is why only virtio-pci devices using MSI-X are supported on
s390x.) It uses two-staged indicators: a global indicator to show
whether any secondary indicator is set, and secondary indicators (which
are per virtqueue in the virtio case.)

guest=09=09=09=09=09=09=09=09host

=09=09=09=09=09set queue indicator(s)
=09=09=09=09=09set global indicator
=09=09=09=09=09queue interrupt iff global
=09=09=09=09=09indicator had not been set
open up for I/O interrupt
=09=09=09=09=09store some data into lowcore
=09=09=09=09=09do PSW swap
interrupt handler called
read from lowcore
look at indicators
virtio queue processing

This has less context switches than traditional I/O interrupts; but I
think the main benefit comes from the ability to batch notifications:
as long as the guest is still processing indicators, the host does not
need to notify again, it can just set indicators (which is why the
guest always needs to do two passes at processing.) We can already
batch per-device indicators with the classic approach, but adapter
interrupts allow to batch even across many devices.

--Sig_/tt88aDv7HgX61sMainep_3J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl8PNnsACgkQ3s9rk8bw
L6+8IA//dIsu37pfn3cg30toNu4aLawSY4IYrQTC3/dtgicbE4GuZ31w71Yen377
sRstNdukqz82yZa/1qlATLSrSAPWXEePDEc5OHNeco3Nf/mvktIxMIDf6Gxhbji/
nPmrCK6h1rQWwQZREWGnkX97XvnQKBfytTd802VAfIReKJmMI069Wm8m7ohn3Fje
PIzTZgDe6uX54dhhD91tzs7IoDGRYWsXE8OWfLD7E+/dUbPgkIsNJFrFMp53Tikd
rdSz/jJGh2JxjE2l8rsT5IhjEzdmIjIhMFNcyLb7VRG/wD1NWtAIIodjQsa/GvJn
XJCDgPVFLVUZQ1gXSRLFElNW56NbXGDZkJRvTTkb3BKr9PmKsHQFlMqkITGYw8GE
6JPKAZpheFjB7Ydg1sm9CLjV8JIRWR4V8b3S9H5GQPqPzimwwjJylKVXQbK2NWS3
LgKKi+8F/ykmc5HaDlBqZXZJBoURxl8eOpOaa8DpCQx13TRBN7jXPcq2Gs8u4Fxc
iEennAT0VIxy7veq7mqweHdQs6vjed9hYwSFpMUNfiFqXQkTaXnL/Qw5ci0hNqOV
6+q0N1OoBkyxAryNcuVo/D4RHgXxNQANsDHbl/+8z8ljpjSYSPB5R11J3Mv6ttsD
WJnYwHpqJb34vopg8Q/Ap+zviDFtqkzqFungMCp3aPGyojfKxCk=
=/EUj
-----END PGP SIGNATURE-----

--Sig_/tt88aDv7HgX61sMainep_3J--

