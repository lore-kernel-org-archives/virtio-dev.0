Return-Path: virtio-dev-return-6530-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 66601985EFE
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Dec 2019 11:53:07 +0000 (UTC)
Date: Wed, 18 Dec 2019 12:52:59 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191218115259.23s5ogtfi6yh4zw5@sirius.home.kraxel.org>
References: <20191216130031.21912-1-Anton.Yakovlev@opensynergy.com>
 <20191217144542.5kptswa2ew4f6umi@sirius.home.kraxel.org>
 <3cb7b655-857c-d787-57fa-befd35a3fc46@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <3cb7b655-857c-d787-57fa-befd35a3fc46@opensynergy.com>
Subject: [virtio-dev] Re: [PATCH v3] virtio-snd: add virtio sound device specification
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

> > > +/* supported PCM stream features */
> > > +enum {
> > > +    VIRTIO_SND_PCM_F_HOST_MEM =3D 0,
> > > +    VIRTIO_SND_PCM_F_GUEST_MEM,
> >=20
> > Is this useful as stream property?  I would expect when supported by a
> > device it would work for all streams.
>=20
> Since we allowed different capabilities for different streams, now it's
> possible to have different backends for them. I=E2=80=99m not sure how mu=
ch this can
> be a real scenario, but it is theoretically possible to have one backend =
that
> is able to work with shared memory, and the other is not. The same can be=
 said
> for other stream feature bits.

Hmm, ok.  Point.

Independant from that they should either be a note that these two are
nor (yet) specified and are just placeholders.  Or simply be deleted and
re-added with the actual specification for guestmem + hostmem.

> > > +    VIRTIO_SND_PCM_F_EVT_PERIOD,
> >=20
> > I think this is only useful for hostmem/guestmem.
>=20
> Using message-based transport, an application can send the entire playbac=
k
> buffer at the beginning, and then send period-sized parts on each period
> notification.

The driver can still split the data from the application into a set of
smaller virtio buffers.  And this is how I would write a driver.  Create
a bunch of buffers, period_bytes each, enough to cover buffer_bytes.
Then go submit them, re-use them robin-round (each time the device
completes a buffer re-fill and re-submit it), without a special case
with one big buffer for the (playback) stream start.

I still think this is not needed for message-based transport.

Maybe this is not needed for hostmem/guestmem either.  The point of
using shared memory is to avoid system calls and vmexits for buffer
management, so VIRTIO_SND_PCM_F_EVT_PERIOD doesn't look that useful
here too.  But maybe it is nice to have that as option.

> > > +\subsubsection{PCM I/O Messages}\label{sec:Device Types / Sound Devi=
ce / Device Operation / PCM IO Messages}
> > > +
> > > +An I/O message consists of the header part, followed by the buffer, =
and then
> > > +the status part.
> >=20
> > Each buffer MUST (or SHOULD?) be period_bytes in size.
> >=20
> > The driver SHOULD queue (buffer_bytes / period_bytes) virtio buffers, s=
o
> > the device has buffer_bytes total buffer space available.
>=20
> I think, it's better not to set queued buffer size restrictions.

Lets make it SHOULD then.

> Periods are an optional feature. If the driver is not interested in
> period notifications, it's unclear what period_bytes means here.

Well, the driver has to manage buffers, so I can't see how a driver is
not interested in completion notifications.  If the driver isn't
interested in keeping the latency low by using lots of small buffers it
still needs to queue at least two (larger) buffers, so the device still
has data to continue playback when it completed a buffer.  And the
driver needs to know when the device is done with a buffer so it can
either recycle the buffer or free the pages.

> Although, for the input stream we could say, that the total size of
> buffers in the rx queue should be buffer_bytes.

Yes.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

