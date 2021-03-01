Return-Path: virtio-dev-return-8074-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDD3B986307
	for <virtio-dev@lists.oasis-open.org>; Mon,  1 Mar 2021 17:18:38 +0000 (UTC)
Date: Mon, 1 Mar 2021 12:18:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20210301121623-mutt-send-email-mst@kernel.org>
References: <20210226111619.21178-1-alex.bennee@linaro.org>
 <YDzKhnQa+LS01yTN@stefanha-x1.localdomain>
 <87czwjjdf7.fsf@linaro.org>
 <YD0X58hj+al5uPWk@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <YD0X58hj+al5uPWk@stefanha-x1.localdomain>
Subject: Re: [virtio-dev] [VHOST USER SPEC PATCH] vhost-user.rst: add
 clarifying language about protocol negotiation
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, rust-vmm@lists.opendev.org, stratos-dev@op-lists.linaro.org, virtio-dev@lists.oasis-open.org, viresh.kumar@linaro.org, Jiang Liu <gerry@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Mar 01, 2021 at 04:35:51PM +0000, Stefan Hajnoczi wrote:
> On Mon, Mar 01, 2021 at 11:38:47AM +0000, Alex Benn=E9e wrote:
> > Stefan Hajnoczi <stefanha@redhat.com> writes:
> > > On Fri, Feb 26, 2021 at 11:16:19AM +0000, Alex Benn=E9e wrote:
> > >> +However as the protocol negotiation something that only occurs betw=
een
> > >
> > > Missing "is". Shortening the sentence fixes that without losing clari=
ty:
> > > s/something that/negotiation/
> > >
> > >> +parts of the backend implementation it is permissible to for the ma=
ster
> > >
> > > "vhost-user device backend" is often used to refer to the slave (to
> > > avoid saying the word "slave") but "backend" is being used in a
> > > different sense here. That is confusing.
> > >
> > >> +to mask the feature bit from the guest.
> > >
> > > I think this sentence effectively says "the master MAY mask the
> > > VHOST_USER_F_PROTOCOL_FEATURES bit from the VIRTIO feature bits". Tha=
t
> > > is not really accurate since VIRTIO devices do not advertise this
> > > feature bit and so it can never be negotiated through the VIRTIO feat=
ure
> > > negotiation process.
> > >
> > > How about referring to the details from the VIRTIO 1.1 specification
> > > instead. Something like this:
> > >
> > >   Note that VHOST_USER_F_PROTOCOL_FEATURES is the UNUSED (30) feature
> > >   bit defined in `VIRTIO 1.1 6.3 Legacy Interface: Reserved Feature B=
its
> > >   <https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs=
01.html#x1-4130003>`_.
> > >   VIRTIO devices do not advertise this feature bit and therefore VIRT=
IO
> > >   drivers cannot negotiate it.
> > >
> > >   This reserved feature bit was reused by the vhost-user protocol to =
add
> > >   vhost-user protocol feature negotiation in a backwards compatible
> > >   fashion. Old vhost-user master and slave implementations continue t=
o
> > >   work even though they are not aware of vhost-user protocol feature
> > >   negotiation.
> >=20
> > OK - so does that mean that feature bit will remain UNUSED for ever
> > more?
>=20
> It's unlikely to be repurposed in VIRTIO. It can never be used by VIRTIO
> in a situation that overlaps with vhost-user. That leaves cases that
> don't overlap with vhost-user but that is unlikely too since the bit had
> a previous meaning (before vhost-user) and repurposing it would cause
> confusion for very old drivers or devices.

Yes, it's easier to just use higher bits.
If it ever is reused we will just send that bit separately.

> > What about other feature bits? Is it permissible for the
> > master/requester/vhost-user front-end/QEMU to filter any other feature
> > bits the slave/vhost-user backend/daemon may offer from being read by
> > the guest driver when it reads the feature bits?
>=20
> Yes, the vhost-user frontend can decide how it wants to expose
> VHOST_USER_GET_FEATURES feature bits on the VIRTIO device:
>=20
> 1. Pass-through. Allow the vhost-user device backend to control the
>    feature bit.
> 2. Disabling. Clear a feature bit because it cannot be supported for
>    some reason (e.g. VIRTIO 1.1 packed vrings are not implemented and
>    therefore enabling them would prevent live migration).
> 3. Enabling. Enable a feature bit that does not rely on vhost-user
>    device backend support. For example, message-signalled interrupts
>    for virtio-mmio.
>=20
> >=20
> > >
> > >> As noted for the
> > >> +``VHOST_USER_GET_PROTOCOL_FEATURES`` and
> > >> +``VHOST_USER_SET_PROTOCOL_FEATURES`` messages this occurs before a
> > >> +final ``VHOST_USER_SET_FEATURES`` comes from the guest.
> > >
> > > I couldn't find any place where vhost-user.rst states that
> > > VHOST_USER_SET_PROTOCOL_FEATURES has to come before
> > > VHOST_USER_SET_FEATURES?
> > >
> > > The only order I found was:
> > >
> > > 1. VHOST_USER_GET_FEATURES to determine whether protocol features are
> > >    supported.
> > > 2. VHOST_USER_GET_PROTOCOL_FEATURES to fetch available protocol featu=
re bits.
> > > 3. VHOST_USER_SET_PROTOCOL_FEATURES to set protocol feature bits.
> > > 4. Using functionality that depends on enabled protocol feature bits.
> > >
> > > Is the purpose of this sentence to add a new requirement to the spec
> > > that "VHOST_USER_SET_PROTOCOL_FEATURES MUST be sent before
> > > VHOST_USER_SET_FEATURES"?
> >=20
> > No I don't want to add a new sequence requirement. But if SET_FEATURES
> > doesn't acknowledge the VHOST_USER_F_PROTOCOL_FEATURES bit should that
> > stop the processing of
> > VHOST_USER_GET_PROTOCOL_FEATURES/VHOST_USER_SET_PROTOCOL_FEATURES
> > messages? AFAICT SET_FEATURES should be irrelevant to the negotiation o=
f
> > the PROTOCOL_FEATURES right?
>=20
> I agree, the value of VHOST_USER_F_PROTOCOL_FEATURES in
> VHOST_USER_SET_FEATURES does not matter according to the spec:
>=20
>   Only legal if feature bit ``VHOST_USER_F_PROTOCOL_FEATURES`` is
>   present in ``VHOST_USER_GET_FEATURES``.
>=20
> Since it does not mention "set in VHOST_USER_SET_FEATURES" we have to
> assume existing vhost-user device backends do not care whether the
> vhost-user frontend includes the bit in VHOST_USER_SET_FEATURES or not.
>=20
> Stefan



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

