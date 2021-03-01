Return-Path: virtio-dev-return-8073-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 07018986307
	for <virtio-dev@lists.oasis-open.org>; Mon,  1 Mar 2021 16:37:17 +0000 (UTC)
Date: Mon, 1 Mar 2021 16:35:51 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YD0X58hj+al5uPWk@stefanha-x1.localdomain>
References: <20210226111619.21178-1-alex.bennee@linaro.org>
 <YDzKhnQa+LS01yTN@stefanha-x1.localdomain>
 <87czwjjdf7.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87czwjjdf7.fsf@linaro.org>
Subject: Re: [virtio-dev] [VHOST USER SPEC PATCH] vhost-user.rst: add
 clarifying language about protocol negotiation
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D2Xdtwn802IZRoFf"
Content-Disposition: inline
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, rust-vmm@lists.opendev.org, stratos-dev@op-lists.linaro.org, virtio-dev@lists.oasis-open.org, viresh.kumar@linaro.org, Jiang Liu <gerry@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--D2Xdtwn802IZRoFf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 01, 2021 at 11:38:47AM +0000, Alex Benn=E9e wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
> > On Fri, Feb 26, 2021 at 11:16:19AM +0000, Alex Benn=E9e wrote:
> >> +However as the protocol negotiation something that only occurs betwee=
n
> >
> > Missing "is". Shortening the sentence fixes that without losing clarity=
:
> > s/something that/negotiation/
> >
> >> +parts of the backend implementation it is permissible to for the mast=
er
> >
> > "vhost-user device backend" is often used to refer to the slave (to
> > avoid saying the word "slave") but "backend" is being used in a
> > different sense here. That is confusing.
> >
> >> +to mask the feature bit from the guest.
> >
> > I think this sentence effectively says "the master MAY mask the
> > VHOST_USER_F_PROTOCOL_FEATURES bit from the VIRTIO feature bits". That
> > is not really accurate since VIRTIO devices do not advertise this
> > feature bit and so it can never be negotiated through the VIRTIO featur=
e
> > negotiation process.
> >
> > How about referring to the details from the VIRTIO 1.1 specification
> > instead. Something like this:
> >
> >   Note that VHOST_USER_F_PROTOCOL_FEATURES is the UNUSED (30) feature
> >   bit defined in `VIRTIO 1.1 6.3 Legacy Interface: Reserved Feature Bit=
s
> >   <https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01=
.html#x1-4130003>`_.
> >   VIRTIO devices do not advertise this feature bit and therefore VIRTIO
> >   drivers cannot negotiate it.
> >
> >   This reserved feature bit was reused by the vhost-user protocol to ad=
d
> >   vhost-user protocol feature negotiation in a backwards compatible
> >   fashion. Old vhost-user master and slave implementations continue to
> >   work even though they are not aware of vhost-user protocol feature
> >   negotiation.
>=20
> OK - so does that mean that feature bit will remain UNUSED for ever
> more?

It's unlikely to be repurposed in VIRTIO. It can never be used by VIRTIO
in a situation that overlaps with vhost-user. That leaves cases that
don't overlap with vhost-user but that is unlikely too since the bit had
a previous meaning (before vhost-user) and repurposing it would cause
confusion for very old drivers or devices.

> What about other feature bits? Is it permissible for the
> master/requester/vhost-user front-end/QEMU to filter any other feature
> bits the slave/vhost-user backend/daemon may offer from being read by
> the guest driver when it reads the feature bits?

Yes, the vhost-user frontend can decide how it wants to expose
VHOST_USER_GET_FEATURES feature bits on the VIRTIO device:

1. Pass-through. Allow the vhost-user device backend to control the
   feature bit.
2. Disabling. Clear a feature bit because it cannot be supported for
   some reason (e.g. VIRTIO 1.1 packed vrings are not implemented and
   therefore enabling them would prevent live migration).
3. Enabling. Enable a feature bit that does not rely on vhost-user
   device backend support. For example, message-signalled interrupts
   for virtio-mmio.

>=20
> >
> >> As noted for the
> >> +``VHOST_USER_GET_PROTOCOL_FEATURES`` and
> >> +``VHOST_USER_SET_PROTOCOL_FEATURES`` messages this occurs before a
> >> +final ``VHOST_USER_SET_FEATURES`` comes from the guest.
> >
> > I couldn't find any place where vhost-user.rst states that
> > VHOST_USER_SET_PROTOCOL_FEATURES has to come before
> > VHOST_USER_SET_FEATURES?
> >
> > The only order I found was:
> >
> > 1. VHOST_USER_GET_FEATURES to determine whether protocol features are
> >    supported.
> > 2. VHOST_USER_GET_PROTOCOL_FEATURES to fetch available protocol feature=
 bits.
> > 3. VHOST_USER_SET_PROTOCOL_FEATURES to set protocol feature bits.
> > 4. Using functionality that depends on enabled protocol feature bits.
> >
> > Is the purpose of this sentence to add a new requirement to the spec
> > that "VHOST_USER_SET_PROTOCOL_FEATURES MUST be sent before
> > VHOST_USER_SET_FEATURES"?
>=20
> No I don't want to add a new sequence requirement. But if SET_FEATURES
> doesn't acknowledge the VHOST_USER_F_PROTOCOL_FEATURES bit should that
> stop the processing of
> VHOST_USER_GET_PROTOCOL_FEATURES/VHOST_USER_SET_PROTOCOL_FEATURES
> messages? AFAICT SET_FEATURES should be irrelevant to the negotiation of
> the PROTOCOL_FEATURES right?

I agree, the value of VHOST_USER_F_PROTOCOL_FEATURES in
VHOST_USER_SET_FEATURES does not matter according to the spec:

  Only legal if feature bit ``VHOST_USER_F_PROTOCOL_FEATURES`` is
  present in ``VHOST_USER_GET_FEATURES``.

Since it does not mention "set in VHOST_USER_SET_FEATURES" we have to
assume existing vhost-user device backends do not care whether the
vhost-user frontend includes the bit in VHOST_USER_SET_FEATURES or not.

Stefan

--D2Xdtwn802IZRoFf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmA9F+cACgkQnKSrs4Gr
c8jULAgAwuoXO5cJKYhZt3lXcomHaV5YtpMM8U67j1f3zepdDk4dYMIKrUAZtWsb
rHrHr7XXKOE3NpfnIx7BGwIL+GJyNrF9+SZHoL9vN/qaehCmQRhCkRYmAgtNuKH1
INZqtiUZDwNrrNGBtXrBT8I8YwSzBN+pXhsogqoLLx4QWvIqhmGxQqhCFLkM2zwQ
ko7ZTDhAfsNvI+XkiLb3tHP10aLCudKMyikRsJZGw6KPqb2lYhss0JSihRYMepdq
WxzEj/ghXYltND/Ab6z1/e1s2BdT++t/xkvbGEGXyo6qjWxkHVu8HSPUXuYsvDJU
gA0NbYvqWpvYAKZVwbQn7gINI39PIA==
=cKWu
-----END PGP SIGNATURE-----

--D2Xdtwn802IZRoFf--

