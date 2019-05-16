Return-Path: virtio-dev-return-5751-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B3B20985E94
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 May 2019 10:24:52 +0000 (UTC)
Date: Thu, 16 May 2019 11:24:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190516102446.GU29507@stefanha-x1.localdomain>
References: <20190509122710.rfhfnhqez2u7inju@sirius.home.kraxel.org>
 <5d316321-2c48-342b-f2ce-359e3596dae0@opensynergy.com>
 <20190510121656.3ab7w5xef6io764o@sirius.home.kraxel.org>
 <76D732A88286A1478FFA94B453B715C1EEA25DD4@MXS02.open-synergy.com>
 <20190510154824.GJ22311@stefanha-x1.localdomain>
 <76D732A88286A1478FFA94B453B715C1EEA25EB1@MXS02.open-synergy.com>
 <20190514134448.GB6555@stefanha-x1.localdomain>
 <76D732A88286A1478FFA94B453B715C1EEA27A2B@MXS02.open-synergy.com>
 <20190515160339.GN29507@stefanha-x1.localdomain>
 <76D732A88286A1478FFA94B453B715C1EEA27CD5@MXS02.open-synergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uUozbLrG2OP+gMtx"
Content-Disposition: inline
In-Reply-To: <76D732A88286A1478FFA94B453B715C1EEA27CD5@MXS02.open-synergy.com>
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, Marco Martinelli - 13Byte srl <marco@13byte.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, =?utf-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--uUozbLrG2OP+gMtx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2019 at 04:33:23PM +0000, Anton Yakovlev wrote:
>=20
> >> After careful consideration, I think polling mode should make it possi=
ble. Like, using dedicated "data" queue per stream in polling mode (multipl=
exing is not an option, since it reduces queue throughput in proportion to =
the number of multiplexed streams). How to describe it in specification?
> >
> > Polling is an implementation detail for both drivers and devices.
> > Therefore it's not described explicitly in the specification.
>=20
> And the only source of information in such case is to take a look into al=
ready existed implementations?

Yes.  The spec focusses on the hardware interface and the semantics but
not on how to implement it.

> > By the way, virtqueue buffers can be completed out-of-order by the
> > device.  This means sharing a virtqueue between multiple streams does
> > not necessarily introduce any kind of waiting.
> >
> > The only issue is the virtqueue size (e.g. 128 buffers) determines how
> > many buffers can be made available from the driver to the device at any
> > given time.  Some device implementations uses virtqueue sizes like 1024
> > so that this does not become a practical concern.  Does this change your
> > view on multiplexing streams?
>=20
> Personally, I'm not a big fan of, because:
>=20
> 1. It makes overall logic more complex: you need to serialize access to t=
he queue on driver side and dispatch messages (find out recepient, serializ=
e access etc) on device side. With separated queues you have only one produ=
cer and consumer, and they both knows ahead how to handle buffers.
> 2. It requires to define message header for buffer transfers. With separa=
ted queues you just put into descriptors a pointer to the buffer and its le=
ngth.
>=20
> The simpler the better. And with multiplexing basically you have no pros =
except having one queue. Why separated queues are undesirable?

I'm not sure which approach is best either.  In the real-time audio
programming I've done there was a function like this:

  process(const float **in_frames, int in_channels,
          float **out_frames, int out_channels,
	  int nframes);

This function processes audio frames periodically and is a callback from
the real-time audio API.

If the device multiplexes streams on a single virtqueue and uses the
batched request layout that I previously described, then the driver
implementation is very simple.  There is no need to bring together audio
data supplied through multiple virtqueues because it all comes in a
single buffer on a single virtqueue.  You mentioned that separate queues
avoid synchronization but in this case it seems to actually introduce a
synchronization requirement.

Having a single virtqueue where all audio data flows between the
process() function and the device is simple and minimizes per-virtqueue
overhead.  In an interrupt-driven implementation there are per-virtqueue
virtio-pci Queue Notify register writes and per-virtqueue interrupt
handlers, so this can generate a lot of vmexits and interrupts compared
to the multiplexed batched approach.

If your application processes audio streams in different threads and
without inter-stream synchronization, then I agree that multiple
virtqueues is the way to go.

I don't have a strong opinion on the optimal approach, just wanted to
explain why I had this idea.  Please choose as you wish.

Stefan

--uUozbLrG2OP+gMtx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzdOm4ACgkQnKSrs4Gr
c8h5lQf/S9kugJ04h9lKj1qoUb0F9Xa3v7De4F17bqEuWNwBs+aHZw3Gsc7Dr/wn
LmVaJiNvN1uummkq4Mfk/8tcrR7wGUDgPrInpkbzlpSF8FVPDbp7IOFzSXbB+JUc
Zvr6nDQf5kOxjDnMxsKeSaVfQ+9wO+NpHsJsROK3kCu/n0YkeQ2O7fVUsyTDZABj
+9Hl9tMI5mRRukQMa8djrHcWFjbaDcX2H4knlzxaFM6sgW5CsO/JpZuHKbIbemWR
P5QViRsRuQAFkoo49afSnnbifoiTFwCb4eiTAZm6iS6YAhO0p7WR6A1bCFreSUf4
IM5rvakIvCebOoNz7wqaMJ4K8VW07w==
=3S2n
-----END PGP SIGNATURE-----

--uUozbLrG2OP+gMtx--
