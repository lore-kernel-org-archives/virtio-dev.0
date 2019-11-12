Return-Path: virtio-dev-return-6324-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A1812985E61
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Nov 2019 15:16:35 +0000 (UTC)
Message-ID: <394b40a75959454bc634636d9c99bf9bca98454d.camel@linux.intel.com>
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Tue, 12 Nov 2019 15:16:28 +0000
In-Reply-To: <050946d2-e55e-1104-96ff-a63862c154ab@opensynergy.com>
References: <20190924144323.4590-1-Mikhail.Golubev@opensynergy.com>
	 <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
	 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
	 <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
	 <050946d2-e55e-1104-96ff-a63862c154ab@opensynergy.com>
Mime-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 2019-11-12 at 13:45 +0100, Anton Yakovlev wrote:
> On 11.11.2019 16:20, Liam Girdwood wrote:
> > On Tue, 2019-10-29 at 10:42 +0100, Anton Yakovlev wrote:
> > > Hi Liam,
> > >=20
> > > Thank you for comments! Please, take a look at our answers below.
> >=20
> > Apologies, been travelling. More comments below.
> >=20
> > >=20
> > >=20
> > > On 28.10.2019 17:05, Liam Girdwood wrote:
> > > > On Tue, 2019-09-24 at 15:43 +0100, Mikhail Golubev wrote:
> > > > > From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> > > > >=20
> > > > >=20

snip

> > > > > diff --git a/virtio-sound.tex b/virtio-sound.tex
> > > > > new file mode 100644
> > > > > index 0000000..68a606e
> > > > > --- /dev/null
> > > > > +++ b/virtio-sound.tex
> > > > > @@ -0,0 +1,405 @@
> > > > > +\section{Sound Device}\label{sec:Device Types / Sound
> > > > > Device}
> > > > > +
> > > > > +The virtio sound card is a virtual audio device supporting
> > > > > output
> > > > > and input PCM
> > > > > +streams. All device control requests are placed into the
> > > > > control
> > > > > virtqueue, all
> > > > > +I/O requests are placed into the PCM virtqueue.
> > > >=20
> > > > Where are stream position updates placed ? These are usually
> > > > synchronous from the driver and enable the player application
> > > > to
> > > > render
> > > > or read data from the correct locations in the buffers. This is
> > > > latency
> > > > sensitive data.
> > >=20
> > > It happens in an interrupt handler. Since PCM frame transfer is
> > > message based,
> > > the only possible way to figure out consumed or captured amount
> > > of
> > > frames is
> > > to take a look into a message response.
> > >=20
> >=20
> > Ok, this is what I thought. This wont work for low latency audio
> > use
> > cases since the buffers and position responses are queued (voice
> > calls,
> > some gaming, some system notifications like keypress or volume
> > change).
>=20
> But it's not different from typical HW. A driver receives an
> interrupt once=20
> DMA transaction is finished (i.e. some part of data was copied
> to/from host).=20
> And hardware pointer value usually is extrapolated based on some
> internal=20
> device state.=20

Modern HW can usually provide the HW position to the nearest word. Some
older/bad HW provides to the nearest period though and this is when we
have to estimate.

Native (non virtual) audio device drivers typically have no latency
reading the stream position and it's read at the same time as the
system clock. Reading the same clocks together is important as it means
the relationship between the two is deterministic and not subject to
any jitter (which can be introduced by reading stream position over
virtio). =20

> A virtio driver could do something similar: it could either=20
> return "real" pointer value (i.e. what it internally uses) or could
> show fake=20
> "extrapolated" value (like frame_rate * elappsed_time). Although,
> it's a=20
> different story.
>=20
>=20

Virtio driver should return real stream position alongside real common
system time (of when stream position was read).=20

> > However, it's probably tolerable for most other use cases. What use
> > cases have you tried in your testing ?
>=20
> All typical cases: multimedia (video + audio or audio only), network=20
> streaming, video calls, system events, volume changing and so on.
>=20
> By the way, could you define the "low latency" term that we are
> talking about?=20
> Just to be on the same wave.
>=20

Low latency audio is when any application or processing can render data
very close to the HW stream R/W position (typically low or sub
millisecond). This needs zero copy buffering to HW on host/VM/user side
and also timely and accurate stream positions.=20

> es
> > > > > /
> > > > > Sound Device / Device configuration layout}
> > > > > +
> > > > > +\begin{lstlisting}
> > > > > +/* supported PCM sample formats */
> > > > > +enum {
> > > > > +    VIRTIO_SND_PCM_FMT_S8 =3D 0,
> > > > > +    VIRTIO_SND_PCM_FMT_U8,
> > > > > +    VIRTIO_SND_PCM_FMT_S16,
> > > > > +    VIRTIO_SND_PCM_FMT_U16,
> >=20
> > 24 bit.
>=20
> These kinds of sample (18/20/24-bit) were discussed here earlier and
> caused=20
> some concerns (regarding supporting in a guest, testing and so on),
> so they=20
> were removed for simplicity.
>=20
>  From other side, if we are up to add these, maybe it's better not to
> hardcode=20
> format names and use some kind of generic description instead?
> Something like
>=20
> struct {
>    kind; /* S/U/F */
>    significant_bits;
>    storage_bits;
> }
>=20
> It allows to describe formats like 24 and 24_3 in unified way and to
> add=20
> future formats without changing the protocol. What do you think?
>=20

I would recommend copying the exact formats used by ALSA, these formats
are industry standard (although naming will be different on other
OSes).

>=20
> > > > > +    VIRTIO_SND_PCM_FMT_S32,
> > > > > +    VIRTIO_SND_PCM_FMT_U32,
> > > > > +    VIRTIO_SND_PCM_FMT_FLOAT,
> > > > > +    VIRTIO_SND_PCM_FMT_FLOAT64
> > > > > +};
> > > > > +
> > > > > +/* supported PCM frame rates */
> > > > > +enum {
> > > > > +    VIRTIO_SND_PCM_RATE_8000 =3D 0,
> > > > > +    VIRTIO_SND_PCM_RATE_11025,
> > > > > +    VIRTIO_SND_PCM_RATE_16000,
> > > > > +    VIRTIO_SND_PCM_RATE_22050,
> > > > > +    VIRTIO_SND_PCM_RATE_32000,
> > > > > +    VIRTIO_SND_PCM_RATE_44100,
> > > > > +    VIRTIO_SND_PCM_RATE_48000,
> > > > > +    VIRTIO_SND_PCM_RATE_64000,
> > > > > +    VIRTIO_SND_PCM_RATE_88200,
> > > > > +    VIRTIO_SND_PCM_RATE_96000,
> > > > > +    VIRTIO_SND_PCM_RATE_176400,
> > > > > +    VIRTIO_SND_PCM_RATE_192000
> > > >=20
> > > > It may be best to use the same rates and format from the ALSA
> > > > spec,
> > > > this covers any holes (like rates that are not in the above
> > > > list).
> > >=20
> > > These rates are from ALSA definitions. And what formats should be
> > > added?
> > >=20
> >=20
> > Rate, Knot - I would copy ALSA supported rates and formats just
> > like
> > with the channel maps.
>=20
> See a comment above.
>=20

See comment above :)
>=20
> > > >=20
> > > > > +
> > > > > +/* a device configuration space */
> > > > > +struct virtio_snd_config {
> > > > > +    struct virtio_pcm_config {
> > > > > +        struct virtio_pcm_stream_config output;
> > > > > +        struct virtio_pcm_stream_config input;
> > > > > +    } pcm;
> > > > > +};
> > > > > +\end{lstlisting}
> > > >=20
> > > > I assuming this is sent to configure PCM capabilities ?
> > >=20
> > > Yes, minimum amount of information required to setup a PCM stream
> > > in
> > > any kind
> > > of guest.
> > >=20
> > >=20
> > > > What about buffer and period size capabilities ?
> > >=20
> > > In this specification we assume that buffer size is up to guest
> > > decision.
> > > Also, period size is ALSA-only conception and should not be
> > > mentioned
> > > here at
> > > all (we are not stick only to ALSA).
> > >=20
> > >=20
> >=20
> > Period size =3D=3D fragment size =3D=3D block size (probably a few othe=
r
> > naming
> > conventions too), we should be able to tell the device VM our
> > period/block/fragment size so we can configure the HW
> > appropriately.
> > This can also be used to make our stream copying more efficient
> > too.
>=20
> Then let's talk about playback. As I can understand, you are
> describing a=20
> case, when
> 1. ALSA application sets some period size
> 2. fills the whole buffer with non-silence frames
> 3. upon every period notification, provides next period-sized part of
> data
>=20
> It's one of use cases, but quite rare.=20

Ehm, it's bog standard file R/W (non mmap()) audio and extremely common
on Linux and derivatives.

Step 4 is

4) Unblock and wake userspace R/W for next period/block/fragment.

> More often (especially if we are=20
> talking about latency control and low latency audio) things will be
> 1. an application fills the whole buffer with silence
> 2. suppresses period notifications
> 3. starts stream and almost immediatly seeks to near hw position
> 4. puts non-silence frames there (size is set according to desired
> latency)
> 5. provides new frames at some interval (usually in 5-10ms)

So this describes mmap() audio where we block by poll()ing, read HW
ptr, and the write new frames.=20

This proposal needs to support both operating modes and there is
nothing I can see with virtio and some minor changes to this proposal
that would prevent that ?

>=20
> It's how software mixers usually work: PulseAudio, Windows in-kernel
> mixer,=20
> new Android system mixer and so on. Also, you can find such approach
> in low=20
> latency player applications (when they work directly with device).
>=20
> The point is they do not rely on notifications from the driver and
> use their=20
> own timers. The only thing they querying is current hw position.
>=20
> The point is we could have period notifications from the device. But
> it seems=20
> they will be useful only in minority of cases. Also, for example,
> Windows=20
> audio driver has no such concept at all.

Windows does not need to use periodic mode, but a lot of Linux
userspace will use it and this will currently will break those
applications.=20

> > >=20
> > > Since xrun conditions are higher level conceptions, we decided to
> > > delegate
> > > such issues to guest application itself. It helps to make overall
> > > design
> > > simpler. And it seems there's not so much we can do if xrun
> > > condition
> > > is
> > > happened on the device side.
> >=20
> > We can inform the guest. The guest userspace can then take any
> > remedial
> > action if needed.
>=20
> Then, we need the third queue for notifications.

Why, this should go in the queue that's used for stream position ?

>=20
>=20
> > >=20
> > >=20
> > > > 2) Zero copy of audio data and stream positions. Essential for
> > > > any
> > > > low
> > > > latency audio use cases (if supported by HW, hypervisor, VM
> > > > framework).
> > >=20
> > > What do you mean by zero-copy? Shared memory between device and
> > > driver sides?
> >=20
> > Yes, but I see this is now a separate thread as it used by others
> > too.
>=20
> Shared memory based approach was proposed in the very first version
> of the=20
> spec (and we are rooting for this). Then there was discussion and it
> was=20
> postponed for some future virtio device. One of the reason - it's not
> suitable=20
> for arch with non-coherent memory between host and guest.

I'm rooting for this too. I do think we need to be a bit more flexible
so we can deal with non coherent architectures via a SW virtio copy and
support coherent architectures via zero copy.=20

We should be good as long as we can leave some configuration
space/types in the stream config to allow mapping of operating modes
(zero copy, periodic, mmap etc). The device driver should also send
it's capabilities during init so that guests will know what use cases
and modes are supported.

Btw, please don't take my comments as trying to block your proposal. I
am behind this work, I'll likely be one of the first users. My
intention is to help provide something that is both flexible enough to
cater for all current OS users/use cases on HDA like hardware and has
scope for future enhancements.

Thanks

Liam


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

