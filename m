Return-Path: virtio-dev-return-5744-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CEE10985E3D
	for <virtio-dev@lists.oasis-open.org>; Tue, 14 May 2019 19:14:37 +0000 (UTC)
From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Date: Tue, 14 May 2019 19:14:25 +0000
Message-ID: <76D732A88286A1478FFA94B453B715C1EEA277CA@MXS02.open-synergy.com>
References: <20190501170525.GB22391@stefanha-x1.localdomain>
 <c74aebe9-5db4-902f-ef0b-f0a786806acd@13byte.com>
 <20190503164501.GB8373@stefanha-x1.localdomain>
 <863e1be1-11cc-816b-896d-3954427e98f3@13byte.com>
 <20190506052715.vkdopunuauyhl22m@sirius.home.kraxel.org>
 <7ac2ae97-bcb7-22cc-272a-723e7209910c@13byte.com>
 <20190509122710.rfhfnhqez2u7inju@sirius.home.kraxel.org>
 <5d316321-2c48-342b-f2ce-359e3596dae0@opensynergy.com>
 <20190510121656.3ab7w5xef6io764o@sirius.home.kraxel.org>
 <76D732A88286A1478FFA94B453B715C1EEA25DD4@MXS02.open-synergy.com>,<20190513093217.dpcixnntqev5r5lz@sirius.home.kraxel.org>
In-Reply-To: <20190513093217.dpcixnntqev5r5lz@sirius.home.kraxel.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, Marco Martinelli -
 13Byte srl <marco@13byte.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?iso-8859-2?Q?K=F5v=E1g=F3_Zolt=E1n?= <dirty.ice.hu@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

>>>> Each request begins with a 2-byte field that identifies a recipient fu=
nction
>>>> followed by a 2-byte field that identifies a function-specific request=
 type.
>>>>
>>>> Each response begins with a 4-byte field that contains a status code. =
The values
>>>> 0-31 are reserved for common status codes, a function can define funct=
ion-specific
>>>> status codes starting from 32.
>>
>>> I'd suggest to use a common scheme with a single le32 field for both
>>> requests and responses.
>>> ...
>>> (maybe just drop the single-element structs and use the enums directly)=
.
>>
>> IMO, both options are quite fine. We decided to choose separate
>> namespaces because it's more flexible approach.
>
> I fail to see why it is more flexible.  If you want go with the separate
> function/request fields I'd suggest to do the same for responses.

It's not like we definitely want to, it just was a design choice at the mom=
ent. As I mentioned, the both options look fine. If it's more reasonable to=
 have single enum, let it be.


>> >> ### Device Configuration
>> >> ...
>> >> struct virtio_snd_generic_desc
>> >> {
>> >>     u8 length;
>> >>     u8 type;
>> >>     u16 padding;
>> >
>> > I'd make length and type u16 and drop the padding.
>>
>> Well, it's a possible option. We just didn't want to waste additional sp=
ace here.
>
> Ok, saw later in the patch that other descriptors _replace_ padding
> instead of _appending_ to the struct.  So padding isn't there to align
> fields appended, but round up the descriptor size for descriptor
> alignment, correct?

> I think it's fine then.

Yes, this definition was done just for convenience.


>> >> With the exception of the base function, all implemented functions MU=
ST define
>> >> its own descriptor(s) format (either presented in this specification =
or
>> >> vendor-specific) and MUST includes these in configuration only if a p=
articular
>> >> function (or part of its functionality) is enabled in the device.
>> >
>> > I don't think it is a good idea to allow vendor-specific descriptors
>> > here.  It should all be in the virtio spec.  We might want reserve a
>> > sub-range of "type" for experimental/development purposes though.
>>
>> Yeah, an ability to define some experimental extensions was one of the
>> targets here (like adding sound controls, non-PCM streams, MIDI and so
>> on). Also, this spec targeted the widest possible range of cases.
>> Like, some hardware has very tricky features which can not be (or just
>> has no point to be) defined in common specification. One example is to
>> allow switching between speaker and bluetooth output. Ususally you
>> don't need it, but if you want to provide such feature to the guest,
>> it's better to implement this as a custom extension.
>
> Why?  I think it makes perfect sense to have a standard function for
> stream routing.
>
> Even when allowing vendor specific descriptors/functions a sub-range of
> "type" must be reserved for that and a way to identify the vendor is
> needed.

Okey, what is your proposal? Should specification define driver behavior fo=
r configuration parsing?


>> >> #### Suspend
>> >> #### Resume
>> >
>> > Why these two are needed?
>>
>> I would say, that some virtualization platforms either do not notify
>> your backend about guest suspend/resume or it's very tricky to
>> distinguish such conditions from other shutdown/initialization types.
>> According to my practice, it's always better to notify device side in
>> explicit way, because the driver always know what is going now.
>
> So the idea is the driver doesn't stop streams on suspend, but sends a
> suspend notification to the device and expects the device stop the
> streams?

Yes, that was the original idea.


>> > Also restoring state as optional device feature doesn't look useful to
>> > me.
>>
>> Well, restoring active playback or capturing is not impossible thing
>> at all. From other side, maybe some device implementors might not
>> want/need such functionality. So I'm not sure, what is better here.
>
> I think we should have *one* way to handle suspend/resume.  So either
> make suspend/resume commands mandatory, or expect the driver to
> stop/restart streams on suspend/resume.
>
> I think the latter is the better way.  If you want know on the device
> side why a stream was stopped (why do you need to know btw?) you can add
> a "reason" field to the stop command.

We want to know the reason for supporting running stream suspend/resume. If=
 the driver was shutdown, the device does not need to do anything special. =
If it was suspended while running stream, the device must be ready to resta=
rt stream on resume (since from the driver's point of view nothing happened=
 in between suspend/resume).

But I rethought this part and realized that it would not help. There're two=
 types of suspends: when a guest enters low power state (like s3/s4) and wh=
en, for example, QEmu was suspended. In second case the driver will send no=
thing. Thus, there's no point having these special request types in specifi=
cation.


>> 2) Everybody wants to reduce a latency as much as possible. One of the
>> most logical way is to allow to mmap data buffer into the user space
>> memory.
>
> mmap() doesn't conflict with virtqueues.  Userspace must notify the
> kernel driver about buffer updates though.

Userspace must notify the kernel, not the kernel driver itself. There's a h=
uge difference. On Linux, ALSA design allows device driver to have informat=
ion about buffer updates. But it's just a special case. In general, this in=
formation is required only by upper layer, not by the driver. And, for exam=
ple, recent Windows versions do not notify the driver at all.


>> (Actually, in some cases you even have no choice here, like in
>> case of the WaveRT interface in Windows.) But memory mapped buffer
>> means, that you either have a very little or have not at all an idea
>> what is going on with buffer content.
>
> So how do you maintain virtio_snd_pcm_hw_regs.dma_position?  Do you
> allow userspace mmap the whole virtio_snd_pcm_shmem struct and update
> it directly, without calling into the kernel driver?

It's supposed to mmap only buffer part (without control registers).


>> > Why both microseconds and bytes?  Isn't that redundant?
>>
>> Just to be sure that both ends have exactly the same ideas.
>
> I don't think this is needed.  If one end gets the microseconds <=3D>
> bytes transformation wrong you'll have bigger problems anyway ...

I think we could do without these at all. I want to discuss it in my reply =
to Stefan.


>> > Are 8-bit formats are still used in practice?
>>
>> Actually, yeah. I saw quite recent chipsets with the U8 format
>> support. Anyway, is it a big issue? It costs zero to support
>> additional formats, so why not?
>
> Well, the cost is not zero.  Some more code (not that much indeed).
> More testing (more significant cost).  So I would try to avoid carrying
> forward old stuff which is not used in practice any more just because
> you can.

It seems reasonable to remove A_LAW/MU_LAW formats and endianness.

But regarding other formats you are not quite right. They are still being u=
sed, even S8/U8. Let's take a broader look. There's the Android and it has =
hardware compatibility requirements. According to PCM playback/capture requ=
irements, Android wants to have 8-bit and 16-bit sample formats. I saw rece=
nt boards support for both types, and these boards were supposed to run the=
 Android. If your goal is to run virtualized Android there, you definetly w=
ant to provide the same audio capabilities to the guest.

The same regarding sample rates. Android requires sample rate from 8 kHz to=
 48 kHz, and Android-compatible hardware does provide it.

I want to say these formats and rates are still alive in modern hardware.


>> > What are VIRTIO_SND_PCM_FMT_{S,U}20_LE ?
>> >
>> > What are VIRTIO_SND_PCM_FMT_*_3BE ?
>> >
>> > Which of these formats are actually implemented in your prototype?
>>
>> Some format's physical width is not multiple of 8. Such samples are
>> kept in "a storage" which width is multiple of 8 (like 20-bit samples
>> are kept either in 24-bit or in 32-bit storage).
>
> So VIRTIO_SND_PCM_FMT_U20_LE =3D=3D VIRTIO_SND_PCM_FMT_U32_LE, except tha=
t
> with U20 the sound hardware doesn't use the 12 least significant bits?

Yes, correct.


>> Both Linux (ALSA) and Windows (WaveXXX interfaces) just expect from
>> you to report support of these formats. You don't need to do anything
>> special in order to implemented them. So, yes, we can support them in
>> the prototype.
>
> I guess I would have used the storage format and the number of
> significant bits instead, but if sound APIs use different format
> constants for these being consistent makes sense to me.

Yes, it's much easier to derive such information from defined format types =
than vice versa. Also, when you have defined types for supported formats, y=
ou automatically cut out all unsupported/invalid [storage bits, significant=
 bits] combinations.


>> >> /* a PCM channel map definitions */
>> >>
>> >> /* All channels have fixed channel positions */
>> >> #define VIRTIO_SND_PCM_CHMAP_FIXED      0
>> >> /* All channels are swappable (e.g. {FL/FR/RL/RR} -> {RR/RL/FR/FL}) *=
/
>> >> #define VIRTIO_SND_PCM_CHMAP_VARIABLE   1
>> >> /* Only pair-wise channels are swappable (e.g. {FL/FR/RL/RR} -> {RL/R=
R/FL/FR}) */
>> >> #define VIRTIO_SND_PCM_CHMAP_PAIRED     2
>> >
>> > What this is good for?  How would a driver ask the device to actually
>> > swap the channels?  And isn't it easier to have the device provide a
>> > complete list of possible channel maps and let the driver simply pick
>> > one?
>>
>> Basically, we were inspired how ALSA handles these and reused the same
>> approach here. How: a hardware can have internal router/mixer to allow
>> flexible configuration, there's nothing special.
>
> I mean in the virtio api.  Devices can report the mapping capability but
> the driver can't pick one.  Or did I miss something (if so then this is
> an indication that the spec should be more clear on how channel mapping
> is supposed to work ...) ?

1. If the device can provide information about channel map(s), it sets the =
CHANNEL_MAP feature bit and # of supported channel maps in a PCM stream con=
figuration descriptor.
2. The driver can enumerate channel maps using the GET_FEATURE(CHANNEL_MAP)=
 request containing a channel map index (from 0 to desc::nchmaps - 1).
3. If a channel map type allows to swap channel positions, the driver can s=
end the SET_FEATURE(CHANNEL_MAP) request containing updated channel positio=
ns.

That's the idea.


>> >> #### Prepare ...  #### Start ...
>> >
>> > So I guess the way to start a stream is (a) prepare, (b) queue some
>> > buffers, (c) start.  Correct?
>>
>> Yeap!
>
> Doesn't hurt to explicitly say so in the specs ;)

Will be done!


--
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

www.opensynergy.com

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org



Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>
COQOS Hypervisor certified by T=DCV S=DCD
                [COQOS Hypervisor certified by T=DCV S=DCD]

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

