Return-Path: virtio-dev-return-5722-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 53A9D985DB0
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 May 2019 12:27:16 +0000 (UTC)
Date: Thu, 9 May 2019 14:27:10 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190509122710.rfhfnhqez2u7inju@sirius.home.kraxel.org>
References: <abe4bd97-8010-8fd0-8ded-f9e847a4fdb3@13byte.com>
 <20190429134754.GI7587@stefanha-x1.localdomain>
 <4fcd7456-de22-7f6d-d5ef-939cd3d7cf95@13byte.com>
 <20190501170525.GB22391@stefanha-x1.localdomain>
 <c74aebe9-5db4-902f-ef0b-f0a786806acd@13byte.com>
 <20190503164501.GB8373@stefanha-x1.localdomain>
 <863e1be1-11cc-816b-896d-3954427e98f3@13byte.com>
 <20190506052715.vkdopunuauyhl22m@sirius.home.kraxel.org>
 <7ac2ae97-bcb7-22cc-272a-723e7209910c@13byte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7ac2ae97-bcb7-22cc-272a-723e7209910c@13byte.com>
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Marco Martinelli - 13Byte srl <marco@13byte.com>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > If you want allow your guest use all three sound cards, then you
> > probably want create three sound cards in the guest too, each with
> > different capabilities and linked to one of the host devices.
>=20
> I don't really agree here, I don't see why I have to tie a virtual soundc=
ard
> 1-to-1 to a real soundcard.

Yes, but you still have to manage output capabilities somehow.

> While the guest will support multiple virtio-audio cards what I imagine a=
s a
> common scenario is something like the following.
>=20
> The guest see one virtio-audio card.
>=20
> On the host I open pavucontrol=A0 (just an example) and set the default o=
utput
> to my internal sound card, where I have my headset attached.
>=20
> On the guest I open my browser and listen to some music in stereo.
>=20
> After a while I want to see a movie, I launch my movie player and in
> pavucontrol I switch the output to my external 7.1 amplifier.

Ok, so the question is how you present that to the guest.  The guests
sound device suddenly changing capabilities (when you re-route from host
stereo to host 7.1) isn't going to work.

You could present a single output which is able to support both stereo
and 7.1.  You need somehow handle the case that your guest sends 7.1
while the output is routed to stereo on the host (can pulseaudio
resample that for us?)

You could present two outputs to the guest (doesn't matter much whenever
one card with two outputs or two cards with one output each), where one
supports stereo and the other 7.1.  Then allow routing the guests 7.1
output only to 7.1-capable host outputs, likewise for stereo.

Not sure which of the two options will work better in practice.

> Virtio-audio will be able to transport the resulting PCM stream from the =
VM
> to the host unaltered, where for example JACK will take it and route them
> to, say, Ardour.
>=20
> I don't need the host sound card support here. I really don't care if it
> can't play this stream directly.

Yes, sure.  It's not so much about host soundcards, but about host
audio backends.  In some cases the qemu audio backend is linked to a
specific sound card (alsa, oss), but on other cases it isn't (pulseaudio).

With qemu sending the pcm stream to a sound server like pulseaudio (or
jack when someone writes a backend) the sound server can of course
re-route and/or process the stream as it pleases.

> For the sake of the specification I think we need to focus on is how to
> transport these streams and how to share a configuration for each one.

I think we need at least three virt queues.  One control queue for
commands (query capabilities, set configuration, start/stop streams,
volume control, ...).  One queue for input streams.  One queue for
output streams.

If we want allow for multiple inputs/outputs we have basically two
options: (a) one queue per stream, or (b) use a small header for each
data packet, telling what stream it belongs to.

Maybe a small header is a good idea anyway, for timestamps.

> Or at least this is how I think a specification should work, but please
> correct me if I'm wrong, I'm new to all of this.

That is correct.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

