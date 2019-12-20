Return-Path: virtio-dev-return-6556-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E4EC7985F57
	for <virtio-dev@lists.oasis-open.org>; Fri, 20 Dec 2019 13:14:57 +0000 (UTC)
References: <20191216130031.21912-1-Anton.Yakovlev@opensynergy.com>
 <20191217144542.5kptswa2ew4f6umi@sirius.home.kraxel.org>
 <3cb7b655-857c-d787-57fa-befd35a3fc46@opensynergy.com>
 <20191218115259.23s5ogtfi6yh4zw5@sirius.home.kraxel.org>
 <02b0c91b-6c05-7acc-dd8a-aa20953f020c@opensynergy.com>
 <20191219071740.xsjnsqrslrwkstkq@sirius.home.kraxel.org>
 <26ac6029-73d8-d2d3-1001-534901973059@opensynergy.com>
 <20191220075315.sdnbat3hgiffwnny@sirius.home.kraxel.org>
 <e3164aba-ceee-cb52-c580-6c0bb9bd28fa@opensynergy.com>
 <20191220124129.rjninyestrfj5bzk@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <a805d0f0-9194-3ab6-41c9-b10336c77de1@opensynergy.com>
Date: Fri, 20 Dec 2019 14:14:46 +0100
MIME-Version: 1.0
In-Reply-To: <20191220124129.rjninyestrfj5bzk@sirius.home.kraxel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v3] virtio-snd: add virtio sound device
 specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 20.12.2019 13:41, Gerd Hoffmann wrote:
>    Hi,
>=20
>>> Period notification would be implicit (playback buffer completion) or
>>> explicit event queue message?
>>
>> Good question. I think, for message-base transport they would be implici=
t,
>> since we will require to enqueue period_size length buffers. The only
>> exception here will be the end of the stream for playback.
>=20
> Why is the end-of-stream different?

Since, as in the case of the input stream, the last buffer may contain less
than period_bytes of data.


>>> Not sure if we want add more properties.  hda codecs can also specify
>>> the color coding of physical jacks (line-in is red, ...) for example.
>>> Probably not useful for most use cases (i.e. when sound data lands @
>>> pulseaudio where the user can re-route things as he wants), but it migh=
t
>>> be useful when a fixed physical host output is assigned to the guest.
>>
>> Well, if we are gonna introduce jacks colors, then we should introduce a=
 jack
>> entity itself. Like, define some kind of jack descriptor, enumerate all
>> available jacks for the stream, putting into the descriptor its color an=
d
>> other properties, maybe allow jack hotplug/unplug, etc.
>=20
> We also need routing then (enable/disable jacks per stream), and link
> detection (is something plugged into the jack?) could be useful too.
>=20
> Should we make that an optional extension (and possibly hash out these
> details later)?  If you assign host machine jacks to your guest all this
> is useful.  If your guests's sound is routed to pulseaudio for playback
> not so much.

Yeah, we can put it off for later. In addition, in the case of PA, sinks an=
d
sources can be moved, added and removed dynamically, so some logic with jac=
ks
might be useful there as well.


> Note: I'll be offline for xmas and new year until january.

Happy holidays!


--=20
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0
E-Mail: anton.yakovlev@opensynergy.com


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

