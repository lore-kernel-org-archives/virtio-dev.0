Return-Path: virtio-dev-return-6397-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 467FB985CAF
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Nov 2019 09:31:18 +0000 (UTC)
Date: Mon, 25 Nov 2019 10:31:10 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191125093110.vixnxeasmpdfbcxs@sirius.home.kraxel.org>
References: <0c5939ad0b330bc4f42d63536340293745dce728.camel@linux.intel.com>
 <20191112160554.GA16008@lophozonia>
 <4ca16fb1d412bc92a2a65104680282b80742f6b1.camel@linux.intel.com>
 <ee52234e-6b53-1f2a-563f-c3dd50dd1764@opensynergy.com>
 <21039a042ad38302e9dc9010014223d915704b91.camel@linux.intel.com>
 <07b9804d-2c20-9ff4-a375-2c65f1d27f63@opensynergy.com>
 <20191121090403.6vjnovlru4zrmzzs@sirius.home.kraxel.org>
 <84fb109c-1d1e-a52c-8efa-8dcd00b864b3@opensynergy.com>
 <20191122071954.2ar6u3jwwn7yutjt@sirius.home.kraxel.org>
 <770a5ce0-ba97-df47-5d65-67404b7e1bf6@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <770a5ce0-ba97-df47-5d65-67404b7e1bf6@opensynergy.com>
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > Instead of PCM_OUTPUT and PCM_INPUT I would put the number of input and
> > output streams into the device config space (and explicitly allow count
> > being zero).
>=20
> There are several options for the number of streams:
>=20
> 1. The device can provide one input and/or output stream.
> 2. The device can provide several input and/or output streams, and all of=
 them
> share the same capabilities.
> 3. The device can provide several input and/or output streams, and they c=
an
> have different set of capabilities.
>=20
> Overall design depends on chosen option. Current draft is based on p.1. B=
ut we
> have never discussed what is the best solution here.

(3) looks most useful to me.

> > PCM_MSG -- I would drop the feature bit and make that mandatory, so we
> > have a common baseline on which all drivers and devices can agree on.
>=20
> Then we need to inform device what "transport" will be in use (I assumed =
it
> would be feature negotiation).

Whenever other transports (i.e. via shared memory) are supported: yes,
that should be a feature bit.

Not sure about choosing the transport.  If both msg (i.e. via virtqueue)
and shared memory are available, does it make sense to allow the driver
choose the transport each time it starts a stream?

> > Right now this is defined for the pci transport only.
>=20
> And now we only declare a feature bit, right?

Not fully sure what you mean here.

Having the first revision define only the virtqueue transport, reserve a
feature bit for the shared memory transport and hash out the details of
that later is possible.

> > > Configuration space
> > > -------------------
> > >=20
> > > We talked about PCM formats defined in ALSA. In Linux kernel v5.4-rc8=
 we have
> > >=20
> > > Do we really need all of them? And I skipped endianess, but should we=
 care
> > > about it as well?
> >=20
> > I'd keep the list as short as possible.  The formats listed in the patc=
h
> > looked like a good start.
>=20
> It was proposed to have all non-compressed formats.
>=20
> And... do we care about cross-endian cases?

I'd start with little endian formats only.  virtio byte order is little
endian, and the world is moving to little endian anyway.  We can add big
endian formats later should this turn out to be needed, but I don't
expect that to be the case.


> > I'd suggest bytes (and rename the field to period_bytes).

> > > struct virtio_snd_pcm_status {
> > >      le32 status;
> > >      le32 actual_length;
> > > };
> >=20
> > Hmm.  Why actual_length?  Do we want allow short transfers?  Why?
> > Wouldn't it be more useful to just fill the buffer completely?
>=20
> In current design we have no buffer size requirements. It means, that in
> theory the device and the driver could have buffers with different sizes.

Should we define that the (virtio) buffer size must be period_bytes then?

> Also, the capture stream is a special case. Now we don't state explicitly
> whether read request is blockable or not.

The concept of "blockable" doesn't exist at that level.  The driver
submits buffers to the device, the device fills them and notifies the
driver when the buffer is full.  It simply doesn't work like a read(2)
syscall.

Buffers not being filled completely could possibly happen when stopping
a stream with a half-filled buffer, if we want allow that in the spec.

Another possible case would be compressed streams with variable bitrate,
where the number of bytes needed for a millisecond of sound data isn't
fixed.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

