Return-Path: virtio-dev-return-5719-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 46914985B98
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 May 2019 05:27:21 +0000 (UTC)
Date: Mon, 6 May 2019 07:27:15 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190506052715.vkdopunuauyhl22m@sirius.home.kraxel.org>
References: <abe4bd97-8010-8fd0-8ded-f9e847a4fdb3@13byte.com>
 <20190429134754.GI7587@stefanha-x1.localdomain>
 <4fcd7456-de22-7f6d-d5ef-939cd3d7cf95@13byte.com>
 <20190501170525.GB22391@stefanha-x1.localdomain>
 <c74aebe9-5db4-902f-ef0b-f0a786806acd@13byte.com>
 <20190503164501.GB8373@stefanha-x1.localdomain>
 <863e1be1-11cc-816b-896d-3954427e98f3@13byte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <863e1be1-11cc-816b-896d-3954427e98f3@13byte.com>
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Marco Martinelli - 13Byte srl <marco@13byte.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, =?utf-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> It's possible to enquiry the virtio-audio device about the host capabilities
> at this time but I'm not sure how to implement this in every audio backend
> of qemu (alsa, pulse, oss, coreaudio, dsound, ...)

It is probably a good idea to coordinate this with Kővágó Zoltán (Cc'ed)
who has a stack of patches to rework the qemu audio configuration.  The
first batch (adding -audiodev command line switch) has been merged in
4.1, the remaining bits will hopefully follow in 4.2.  The not-yet
merged patches include:

  (1) linking guest sound cards to host backends.
  (2) 5.1 support (IIRC: usb-audio and pa + alsa backends).

In general looking: following current qemu capabilities too closely when
designing a virtio spec is a bad idea, we don't want have qemu
implementation details baked in there ...

> Another thing to consider is that the host may have multiple sound cards.
> For example I have three sound cards at the moment, an integrated one with
> stereo at max 96kHZ, a dedicated one with 7.1 surround up to 192kHz and my
> video card has HDMI audio out (not sure of the specs).
> 
> What can be considered a valid configuration in this scenario?

If you want allow your guest use all three sound cards, then you
probably want create three sound cards in the guest too, each with
different capabilities and linked to one of the host devices.

> Another possibility is that the user can configure the virtio-audio device
> with the capabilities that he want to expose to the guest, regardless if the
> host really support them or not. What do you think?

Not a good idea.  We don't want qemu do audio processing.  It already
does to (it can resample audio data in case there is a sample rate
mismatch between guest and host), but we certainly don't want extend
that.

> Another idea is that the user may want to record the stream to process it
> later. It doesn't matter if the host audio card is not capable of
> reproducing it. The host may not even have a sound card in this case.

There already is a backend writing the guest audio stream to a wav file.

> I guess the simple answer is that users can attach as many virtio-audio
> devices as they want with different configurations but I'll look around to
> see if there is any benefit in having multiple input or output in the same
> device.

One advantage I see with multiple inputs/outputs on a single device is
that synchronization will probably easier that way.

On the other hand supporting multiple outputs doesn't seem to be a
feature people want use, I can't remember any requests for that.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

