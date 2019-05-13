Return-Path: virtio-dev-return-5741-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 69F90984AB0
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 May 2019 09:32:24 +0000 (UTC)
Date: Mon, 13 May 2019 11:32:17 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190513093217.dpcixnntqev5r5lz@sirius.home.kraxel.org>
References: <20190501170525.GB22391@stefanha-x1.localdomain>
 <c74aebe9-5db4-902f-ef0b-f0a786806acd@13byte.com>
 <20190503164501.GB8373@stefanha-x1.localdomain>
 <863e1be1-11cc-816b-896d-3954427e98f3@13byte.com>
 <20190506052715.vkdopunuauyhl22m@sirius.home.kraxel.org>
 <7ac2ae97-bcb7-22cc-272a-723e7209910c@13byte.com>
 <20190509122710.rfhfnhqez2u7inju@sirius.home.kraxel.org>
 <5d316321-2c48-342b-f2ce-359e3596dae0@opensynergy.com>
 <20190510121656.3ab7w5xef6io764o@sirius.home.kraxel.org>
 <76D732A88286A1478FFA94B453B715C1EEA25DD4@MXS02.open-synergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76D732A88286A1478FFA94B453B715C1EEA25DD4@MXS02.open-synergy.com>
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Cc: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, Marco Martinelli - 13Byte srl <marco@13byte.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, May 10, 2019 at 02:15:00PM +0000, Anton Yakovlev wrote:
> Hi Gerd! My name is Anton and I'm the original author of this draft. Thanks for comments!
> 
> >> Configuration space provides a maximum amount of available virtual queues. The
> >> nqueues value MUST be at least one.
> >>
> >> ```
> >> struct virtio_snd_config
> >> {
> >>     le32 nqueues;
> >> };
> >> ```
> 
> > Including or excluding the control queue?
> 
> Including the control queue.

Ok.  Please say so explicitly in the specs.

> >> Each request begins with a 2-byte field that identifies a recipient function
> >> followed by a 2-byte field that identifies a function-specific request type.
> >>
> >> Each response begins with a 4-byte field that contains a status code. The values
> >> 0-31 are reserved for common status codes, a function can define function-specific
> >> status codes starting from 32.
> 
> > I'd suggest to use a common scheme with a single le32 field for both
> > requests and responses.
> > ...
> > (maybe just drop the single-element structs and use the enums directly).
> 
> IMO, both options are quite fine. We decided to choose separate
> namespaces because it's more flexible approach.

I fail to see why it is more flexible.  If you want go with the separate
function/request fields I'd suggest to do the same for responses.

> >> ### Device Configuration
> >> ...
> >> struct virtio_snd_generic_desc
> >> {
> >>     u8 length;
> >>     u8 type;
> >>     u16 padding;
> >
> > I'd make length and type u16 and drop the padding.
> 
> Well, it's a possible option. We just didn't want to waste additional space here.

Ok, saw later in the patch that other descriptors _replace_ padding
instead of _appending_ to the struct.  So padding isn't there to align
fields appended, but round up the descriptor size for descriptor
alignment, correct?

I think it's fine then.

> >> With the exception of the base function, all implemented functions MUST define
> >> its own descriptor(s) format (either presented in this specification or
> >> vendor-specific) and MUST includes these in configuration only if a particular
> >> function (or part of its functionality) is enabled in the device.
> >
> > I don't think it is a good idea to allow vendor-specific descriptors
> > here.  It should all be in the virtio spec.  We might want reserve a
> > sub-range of "type" for experimental/development purposes though.
> 
> Yeah, an ability to define some experimental extensions was one of the
> targets here (like adding sound controls, non-PCM streams, MIDI and so
> on). Also, this spec targeted the widest possible range of cases.
> Like, some hardware has very tricky features which can not be (or just
> has no point to be) defined in common specification. One example is to
> allow switching between speaker and bluetooth output. Ususally you
> don't need it, but if you want to provide such feature to the guest,
> it's better to implement this as a custom extension.

Why?  I think it makes perfect sense to have a standard function for
stream routing.

Even when allowing vendor specific descriptors/functions a sub-range of
"type" must be reserved for that and a way to identify the vendor is
needed.


> >> ### Function Operation
> >>
> >> #### Get Device Configuration
> >>
> >> The driver sends the VIRTIO_SND_BASE_R_GET_CFG generic request, the device
> >> answers with a response containing device configuration.
> >
> > Which is a list of descriptors I assume?
> 
> You are right.

Good.  Please clarify the specs.

> >> #### Suspend
> >> #### Resume
> >
> > Why these two are needed?
> 
> I would say, that some virtualization platforms either do not notify
> your backend about guest suspend/resume or it's very tricky to
> distinguish such conditions from other shutdown/initialization types.
> According to my practice, it's always better to notify device side in
> explicit way, because the driver always know what is going now.

So the idea is the driver doesn't stop streams on suspend, but sends a
suspend notification to the device and expects the device stop the
streams?

> > Also restoring state as optional device feature doesn't look useful to
> > me.
> 
> Well, restoring active playback or capturing is not impossible thing
> at all. From other side, maybe some device implementors might not
> want/need such functionality. So I'm not sure, what is better here.

I think we should have *one* way to handle suspend/resume.  So either
make suspend/resume commands mandatory, or expect the driver to
stop/restart streams on suspend/resume.

I think the latter is the better way.  If you want know on the device
side why a stream was stopped (why do you need to know btw?) you can add
a "reason" field to the stop command.

> >> - *Automatic mode*: the driver allocates and shares with the device a pseudophysically
> >> continuous memory area containing runtime control registers and data buffer itself.
> >
> > What is "pseudophysically continuous memory"?
> 
> This memory is physically continuous from the driver's point of view.

So continuous in guest physical memory.

> > Why do you think this is needed?
> 
> When you implement an audio device, you usually start with what we
> call "manual mode". It works, but only for simple use cases. There're
> two major challenges here.
> 
> Thus, no requests/traps/hypercalls to the device while a stream is
> running - no problems here.

As already mentioned by Stefan you can run the virtqueue in polling mode
to avoid trapping into the hypervisor.

> 2) Everybody wants to reduce a latency as much as possible. One of the
> most logical way is to allow to mmap data buffer into the user space
> memory.

mmap() doesn't conflict with virtqueues.  Userspace must notify the
kernel driver about buffer updates though.

> (Actually, in some cases you even have no choice here, like in
> case of the WaveRT interface in Windows.) But memory mapped buffer
> means, that you either have a very little or have not at all an idea
> what is going on with buffer content.

So how do you maintain virtio_snd_pcm_hw_regs.dma_position?  Do you
allow userspace mmap the whole virtio_snd_pcm_shmem struct and update
it directly, without calling into the kernel driver?

> > Why both microseconds and bytes?  Isn't that redundant?
> 
> Just to be sure that both ends have exactly the same ideas.

I don't think this is needed.  If one end gets the microseconds <=>
bytes transformation wrong you'll have bigger problems anyway ...

> > Are 8-bit formats are still used in practice?
> 
> Actually, yeah. I saw quite recent chipsets with the U8 format
> support. Anyway, is it a big issue? It costs zero to support
> additional formats, so why not?

Well, the cost is not zero.  Some more code (not that much indeed).
More testing (more significant cost).  So I would try to avoid carrying
forward old stuff which is not used in practice any more just because
you can.

> > What are VIRTIO_SND_PCM_FMT_{S,U}20_LE ?
> >
> > What are VIRTIO_SND_PCM_FMT_*_3BE ?
> >
> > Which of these formats are actually implemented in your prototype?
> 
> Some format's physical width is not multiple of 8. Such samples are
> kept in "a storage" which width is multiple of 8 (like 20-bit samples
> are kept either in 24-bit or in 32-bit storage).

So VIRTIO_SND_PCM_FMT_U20_LE == VIRTIO_SND_PCM_FMT_U32_LE, except that
with U20 the sound hardware doesn't use the 12 least significant bits?

> Both Linux (ALSA) and Windows (WaveXXX interfaces) just expect from
> you to report support of these formats. You don't need to do anything
> special in order to implemented them. So, yes, we can support them in
> the prototype.

I guess I would have used the storage format and the number of
significant bits instead, but if sound APIs use different format
constants for these being consistent makes sense to me.

> > Same question: Do we actually need all those?  My impression is that
> > these days 48000 is pretty much standard.  96000 + 192000 for higher
> > quality.  44100 sometimes still because it happens to be the CD sample
> > rate.  Maybe 32000/16000/8000 for low bandwidth codecs.
> >
> > But 5512, 11025 & friends?
> 
> Same answer: why not? :)

Same reply as above ;)

> >> /* a PCM channel map definitions */
> >>
> >> /* All channels have fixed channel positions */
> >> #define VIRTIO_SND_PCM_CHMAP_FIXED      0
> >> /* All channels are swappable (e.g. {FL/FR/RL/RR} -> {RR/RL/FR/FL}) */
> >> #define VIRTIO_SND_PCM_CHMAP_VARIABLE   1
> >> /* Only pair-wise channels are swappable (e.g. {FL/FR/RL/RR} -> {RL/RR/FL/FR}) */
> >> #define VIRTIO_SND_PCM_CHMAP_PAIRED     2
> >
> > What this is good for?  How would a driver ask the device to actually
> > swap the channels?  And isn't it easier to have the device provide a
> > complete list of possible channel maps and let the driver simply pick
> > one?
> 
> Basically, we were inspired how ALSA handles these and reused the same
> approach here. How: a hardware can have internal router/mixer to allow
> flexible configuration, there's nothing special.

I mean in the virtio api.  Devices can report the mapping capability but
the driver can't pick one.  Or did I miss something (if so then this is
an indication that the spec should be more clear on how channel mapping
is supposed to work ...) ?

> >> #### Prepare ...  #### Start ...
> >
> > So I guess the way to start a stream is (a) prepare, (b) queue some
> > buffers, (c) start.  Correct?
> 
> Yeap!

Doesn't hurt to explicitly say so in the specs ;)

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

