Return-Path: virtio-dev-return-6555-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E4039985F57
	for <virtio-dev@lists.oasis-open.org>; Fri, 20 Dec 2019 12:41:37 +0000 (UTC)
Date: Fri, 20 Dec 2019 13:41:29 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191220124129.rjninyestrfj5bzk@sirius.home.kraxel.org>
References: <20191216130031.21912-1-Anton.Yakovlev@opensynergy.com>
 <20191217144542.5kptswa2ew4f6umi@sirius.home.kraxel.org>
 <3cb7b655-857c-d787-57fa-befd35a3fc46@opensynergy.com>
 <20191218115259.23s5ogtfi6yh4zw5@sirius.home.kraxel.org>
 <02b0c91b-6c05-7acc-dd8a-aa20953f020c@opensynergy.com>
 <20191219071740.xsjnsqrslrwkstkq@sirius.home.kraxel.org>
 <26ac6029-73d8-d2d3-1001-534901973059@opensynergy.com>
 <20191220075315.sdnbat3hgiffwnny@sirius.home.kraxel.org>
 <e3164aba-ceee-cb52-c580-6c0bb9bd28fa@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <e3164aba-ceee-cb52-c580-6c0bb9bd28fa@opensynergy.com>
Subject: Re: [virtio-dev] Re: [PATCH v3] virtio-snd: add virtio sound device
 specification
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > Period notification would be implicit (playback buffer completion) or
> > explicit event queue message?
>=20
> Good question. I think, for message-base transport they would be implicit=
,
> since we will require to enqueue period_size length buffers. The only
> exception here will be the end of the stream for playback.

Why is the end-of-stream different?

> As for shared memory, I think that they could work as an optional notific=
ation
> (as suggested earlier), and the driver should enable them using the set p=
arams
> request (setting the feature bit).

Sounds good.

> > Yes, a simple enum would do the trick I think.
>=20
> And just reuse existing values from the HDA spec, right?

Looks useful, simplifies things.

> > Not sure if we want add more properties.  hda codecs can also specify
> > the color coding of physical jacks (line-in is red, ...) for example.
> > Probably not useful for most use cases (i.e. when sound data lands @
> > pulseaudio where the user can re-route things as he wants), but it migh=
t
> > be useful when a fixed physical host output is assigned to the guest.
>=20
> Well, if we are gonna introduce jacks colors, then we should introduce a =
jack
> entity itself. Like, define some kind of jack descriptor, enumerate all
> available jacks for the stream, putting into the descriptor its color and
> other properties, maybe allow jack hotplug/unplug, etc.

We also need routing then (enable/disable jacks per stream), and link
detection (is something plugged into the jack?) could be useful too.

Should we make that an optional extension (and possibly hash out these
details later)?  If you assign host machine jacks to your guest all this
is useful.  If your guests's sound is routed to pulseaudio for playback
not so much.

Note: I'll be offline for xmas and new year until january.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

