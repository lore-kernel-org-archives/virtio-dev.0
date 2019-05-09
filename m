Return-Path: virtio-dev-return-5721-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F31FC985DAB
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 May 2019 10:10:11 +0000 (UTC)
References: <abe4bd97-8010-8fd0-8ded-f9e847a4fdb3@13byte.com>
 <20190429134754.GI7587@stefanha-x1.localdomain>
 <4fcd7456-de22-7f6d-d5ef-939cd3d7cf95@13byte.com>
 <20190501170525.GB22391@stefanha-x1.localdomain>
 <c74aebe9-5db4-902f-ef0b-f0a786806acd@13byte.com>
 <20190503164501.GB8373@stefanha-x1.localdomain>
 <863e1be1-11cc-816b-896d-3954427e98f3@13byte.com>
 <20190506052715.vkdopunuauyhl22m@sirius.home.kraxel.org>
From: Marco Martinelli - 13Byte srl <marco@13byte.com>
Message-ID: <7ac2ae97-bcb7-22cc-272a-723e7209910c@13byte.com>
Date: Thu, 9 May 2019 12:10:07 +0200
MIME-Version: 1.0
In-Reply-To: <20190506052715.vkdopunuauyhl22m@sirius.home.kraxel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Gerd Hoffmann <kraxel@redhat.com>, virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Gerd,

thank you for your feedback and sorry for the late reply.

>    Hi,
>
>> It's possible to enquiry the virtio-audio device about the host capabilities
>> at this time but I'm not sure how to implement this in every audio backend
>> of qemu (alsa, pulse, oss, coreaudio, dsound, ...)
> It is probably a good idea to coordinate this with Kővágó Zoltán (Cc'ed)
> who has a stack of patches to rework the qemu audio configuration.  The
> first batch (adding -audiodev command line switch) has been merged in
> 4.1, the remaining bits will hopefully follow in 4.2.  The not-yet
> merged patches include:
>
>    (1) linking guest sound cards to host backends.
>    (2) 5.1 support (IIRC: usb-audio and pa + alsa backends).
Interesting, I wasn't aware of that. I'll make sure to look at his work.
> In general looking: following current qemu capabilities too closely when
> designing a virtio spec is a bad idea, we don't want have qemu
> implementation details baked in there ...
I absolutely agree. While my desire is to work on qemu the 
specifications must be agnostic.
>> Another thing to consider is that the host may have multiple sound cards.
>> For example I have three sound cards at the moment, an integrated one with
>> stereo at max 96kHZ, a dedicated one with 7.1 surround up to 192kHz and my
>> video card has HDMI audio out (not sure of the specs).
>>
>> What can be considered a valid configuration in this scenario?
> If you want allow your guest use all three sound cards, then you
> probably want create three sound cards in the guest too, each with
> different capabilities and linked to one of the host devices.

I don't really agree here, I don't see why I have to tie a virtual 
soundcard 1-to-1 to a real soundcard.

While the guest will support multiple virtio-audio cards what I imagine 
as a common scenario is something like the following.

The guest see one virtio-audio card.

On the host I open pavucontrol  (just an example) and set the default 
output to my internal sound card, where I have my headset attached.

On the guest I open my browser and listen to some music in stereo.

After a while I want to see a movie, I launch my movie player and in 
pavucontrol I switch the output to my external 7.1 amplifier.

Then I have to call a friend on skype, again I switch to my headset and 
as an input I select an usb microphone I just connected to my linux box.

All of this without touching the VM configuration.

This exact scenario is possible. It is what I have already done in 
Scream and it's working very well.


Having a 1-to-1 map between host sound cards  and virtio-audio sound 
cards just seems inconvenient. You attached a plug and play soundcard? 
Too bad. Stop your VM, add a new device, restart.. No, I don't really 
want that.

>> Another possibility is that the user can configure the virtio-audio device
>> with the capabilities that he want to expose to the guest, regardless if the
>> host really support them or not. What do you think?
> Not a good idea.  We don't want qemu do audio processing.

I don't want qemu to do audio processing either. It's not its job.

Having virtio-audio support configuration that the host sound card 
doesn't support doesn't mean that qemu have to do the audio processing.

Imagine this scenario. In a windows VM I can run some professional 
digital audio workstation software that currently don't support linux.

I can set these software to work with whatever settings I want (say, 
192kHz, floating point, 8 channels).

Virtio-audio will be able to transport the resulting PCM stream from the 
VM to the host unaltered, where for example JACK will take it and route 
them to, say, Ardour.

I don't need the host sound card support here. I really don't care if it 
can't play this stream directly.

As another example, I can have a virtio-audio with 10 input channels, 
and with JACK I can map different sources from the host to different 
channels to work on my audio workstation in the windows VM.

This will open the door to professional uses that are currently not 
possible.

Yes, in the end something will have to do the resampling, but that can 
be my linux DAW (eg. Ardour), or JACK, or Pulseaudio or anything. It 
will be up to the user to route the stream where he wants.

>   It already
> does to (it can resample audio data in case there is a sample rate
> mismatch between guest and host), but we certainly don't want extend
> that.
Agree.
>> Another idea is that the user may want to record the stream to process it
>> later. It doesn't matter if the host audio card is not capable of
>> reproducing it. The host may not even have a sound card in this case.
> There already is a backend writing the guest audio stream to a wav file.
Yes, I didn't explain it very well, sorry. I wasn't really thinking of 
writing this to a wav file but routing to professional audio tools like 
in the example above.
>> I guess the simple answer is that users can attach as many virtio-audio
>> devices as they want with different configurations but I'll look around to
>> see if there is any benefit in having multiple input or output in the same
>> device.
> One advantage I see with multiple inputs/outputs on a single device is
> that synchronization will probably easier that way.
>
> On the other hand supporting multiple outputs doesn't seem to be a
> feature people want use, I can't remember any requests for that.
Yeah, I thought about it and I don't think it's a common use case. That 
said I can see a few uses for it.
For example, I can set a virtio-audio card with 2 outputs and 1 input 
and set in my VM, say, spotify to output 2 and skype on output 1 and 
input 1.
On the host I can set the output of spotify to one soundcard, say, a 
bluetooth speaker in the room next door while I can skype chat with a 
friend on the headset.

Nowdays most softwares can remember the assigned input/output devices, 
so I can set this once and forget about it.


As a general note, I see virtio-audio as a generic interface to transfer 
PCM streams in and out of the VM.
I don't want to limit it or tying it too much to a particular system or 
backend.
I want it to be simple and flexible.
I'm sure the end users will imagine use cases that I can't even think 
about now. Maybe they'll be bizarre configurations, who knows, but I 
certainly don't want to limit them.

I think we agree that the specification should be independent of the end 
system.

The qemu device that will implement this specification is a specific 
implementation but now we don't really have to care what it will do with 
the streams it will receive from the guest. It can send them to 
/dev/null for all I care.
For the sake of the specification I think we need to focus on is how to 
transport these streams and how to share a configuration for each one.

How the stream will be handled by the host it's a matter of 
implementation in the qemu device (or whatever other software will 
implement this spec) and that's out of the scope of the specification.

Or at least this is how I think a specification should work, but please 
correct me if I'm wrong, I'm new to all of this.


> cheers,
>    Gerd
>

Regards,
Marco


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

