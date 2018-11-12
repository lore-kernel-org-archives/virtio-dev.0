Return-Path: virtio-dev-return-4952-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 55DC2985351
	for <virtio-dev@lists.oasis-open.org>; Mon, 12 Nov 2018 14:37:32 +0000 (UTC)
Date: Mon, 12 Nov 2018 14:37:28 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181112143728.GF21380@stefanha-x1.localdomain>
References: <0f4e7431-3c87-f783-579a-7e9fe6bc20d2@solarflare.com>
 <20181105085337.GA9934@stefanha-x1.localdomain>
 <6795ebb5-4f21-1274-fa35-b8354bc65049@solarflare.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
Content-Disposition: inline
In-Reply-To: <6795ebb5-4f21-1274-fa35-b8354bc65049@solarflare.com>
Subject: Re: [virtio-dev] Device-to-driver notification management for
 hardware implementations
To: David Riddoch <driddoch@solarflare.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Steve Pope <spope@solarflare.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2018 at 12:16:28PM +0000, David Riddoch wrote:
> On 05/11/18 08:53, Stefan Hajnoczi wrote:
> > On Wed, Sep 12, 2018 at 05:41:07PM +0100, David Riddoch wrote:
> > > The VIRTIO_F_NOTIFICATION_DATA feature helps hardware implementations=
 by
> > > telling them directly how many descriptors are available in the ring,=
 saving
> > > speculative reads.=A0 There is a related issue with interrupts: As th=
ings
> > > stand, after writing 'used' descriptors into the ring (packed or spli=
t) the
> > > device has to read the event idx to determine whether a device-to-dri=
ver
> > > notification (interrupt) is needed.
> > >=20
> > > It would be very helpful to a hardware implementation if the event id=
x could
> > > be written directly to the device.=A0 Has anyone proposed an extensio=
n to
> > > address this already?=A0 (I have some thoughts on how to do this if w=
e don't
> > > have a proposal yet).
> > Hi David,
> > Has there been any further discussion on this topic?  It seems like a
> > useful feature to have in VIRTIO.
> Hi Stefan,
>=20
> Thanks for the nudge, no further discussion.=A0 So here are my thoughts:
>=20
> To provide context here is an outline of how drivers typically process
> completions from a device.=A0 This applies to both para-virtualised and r=
eal
> hardware.=A0 (I think we only need to worry about packed-ring).
>=20
> =A0=A0 disable_cb();
> =A0again:
> =A0=A0 while( budget_left && desc_is_used() )
> =A0=A0 =A0 handle_used();
> =A0=A0 if( budget_left &&enable_cb() )
> =A0=A0=A0=A0 goto again;
>=20
> The budget stuff relates to napi polling, and isn't always there. But if =
it
> is, and budget is exhausted, then an outer loop will invoke this code aga=
in
> and so we don't want an interrupt.
>=20
> In our current packed-ring design enable_cb() does roughly this:
>=20
> =A0=A0 enable_cb_packed() {
> =A0 =A0=A0 guest_mem->event_suppress =3D last_used_idx;
> =A0=A0=A0=A0 virtio_mb();
> =A0=A0=A0=A0 return desc_is_used();
> =A0=A0 }
>=20
> This tells the device to raise an interrupt when moving used_idx over the
> given idx.=A0 (And you can set that idx to a position further in the ring=
 if
> you're not interested in getting woken until a bunch of descriptors have
> been consumed).
>=20
> This design is unpleasant for hardware devices, because it forces them to
> issue a read over the PCIe bus after writing used descriptors, in order to
> determine whether an interrupt is needed. Such a read adds complexity, ad=
ds
> overhead to the PCIe bus and memory system, and adds latency.
>=20
> In hardware devices interrupts are typically enabled like this:
>=20
> =A0=A0 enable_cb_hw() {
> =A0=A0 =A0 writel(last_used_idx, &dev_bar->int_en_doorbell);
> =A0=A0=A0=A0 return 0;
> =A0=A0 }
>=20
> This tells the device to raise an interrupt once the descriptor at the gi=
ven
> index has been used.=A0 If it has already been used, then an interrupt is
> raised immediately, else the interrupt is enabled and raised after the us=
ed
> descriptor has been written.=A0 The race condition is handled without hav=
ing
> to check the ring again.=A0 Note that interrupts are fire-once: For each =
write
> to int_en_doorbell you get a single interrupt, and disable_cb() is theref=
ore
> a no-op.
>=20
> When you emulate a device using this model, you get a vmexit every time
> int_en_doorbell is written, which is expensive.=A0 Therefore this approac=
h is
> not desirable when emulated.
>=20
> So perhaps we should introduce an option to use this hardware-oriented
> model.=A0 The problem is that with vDPA the implementation of a device can
> shift under the feet of a driver between hardware and emulation.=A0 We'd =
like
> to get the best performance we can in both cases.
>=20
> My proposal is that we add an option to use both models at the same time.=
=A0
> enable_cb() would become:
>=20
> 30 =A0 enable_cb_new() {
> 31 =A0 =A0 if( int_en_doorbell_enabled )
> 32 writel(last_used_idx, p_int_en_doorbell);
> 33 guest_mem->event_suppress =3D last_used_idx;
> 34 =A0=A0=A0 virtio_mb();
> 35 =A0=A0=A0 return desc_is_used();
> 36 =A0 }
>=20
> p_int_en_doorbell it notionally a pointer into a memory mapping onto a
> device BAR, and when backed by hardware that is exactly what it is (and t=
he
> information in the event suppression structure is ignored).=A0 But when b=
acked
> by an emulated device the p_int_en_doorbell mapping should just point at
> normal host memory (which is otherwise unused).=A0 This means that we avo=
id
> vmexits in the emulated case.
>=20
> Comments?

Sounds fine to me.

Could you send a VIRTIO spec patch so this can be discussed in detail?

Thanks,
Stefan

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb6ZAoAAoJEJykq7OBq3PIiDYIAIPRbITgekspfaXI7VFgUSio
B8pVs88pViMXgg10YOoVyLwF2bGraSS5xv+EjYTwvNamr1eXQwLMFhDswedEMhKI
DrZJY9tFIs+49t+D7Rsfew2K00xeiAR/LiPP7OBRrl5+zhb8FTGhu83XlwI6zmXK
KDqKpu/Wz7T/WNSMFpS8GI65NBXO2EP2TwzfkLadPuysT83AaWhPom/TxfPvaCMG
LUG5s9JG4clqBenY2MtE1AIMAbHQatSpc6HXbFGEmXtW3LjPY2FRDPxcg7GUBIGR
HPDAYefbw8xPuUgVBaAcapshOycpKlujltj0xQZgcJharJwtVYR7fwgCKP+QfMU=
=SRSh
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--
