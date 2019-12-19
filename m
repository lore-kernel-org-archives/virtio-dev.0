Return-Path: virtio-dev-return-6540-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2FB81985F3D
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Dec 2019 09:54:37 +0000 (UTC)
References: <20191216130031.21912-1-Anton.Yakovlev@opensynergy.com>
 <20191217144542.5kptswa2ew4f6umi@sirius.home.kraxel.org>
 <3cb7b655-857c-d787-57fa-befd35a3fc46@opensynergy.com>
 <20191218115259.23s5ogtfi6yh4zw5@sirius.home.kraxel.org>
 <02b0c91b-6c05-7acc-dd8a-aa20953f020c@opensynergy.com>
 <20191218165441.GH3219@sirena.org.uk>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <b5e154f0-1fbb-f022-4d07-1daec8a79aaa@opensynergy.com>
Date: Thu, 19 Dec 2019 10:54:31 +0100
MIME-Version: 1.0
In-Reply-To: <20191218165441.GH3219@sirena.org.uk>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v3] virtio-snd: add virtio sound device specification
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Mark Brown <broonie@kernel.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 18.12.2019 17:54, Mark Brown wrote:
> On Wed, Dec 18, 2019 at 04:34:12PM +0100, Anton Yakovlev wrote:
>> On 18.12.2019 12:52, Gerd Hoffmann wrote:
>=20
>>> Well, the driver has to manage buffers, so I can't see how a driver is
>>> not interested in completion notifications.  If the driver isn't
>>> interested in keeping the latency low by using lots of small buffers it
>>> still needs to queue at least two (larger) buffers, so the device still
>>> has data to continue playback when it completed a buffer.  And the
>>> driver needs to know when the device is done with a buffer so it can
>>> either recycle the buffer or free the pages.
>=20
>> It seems that you have mixed up two different things: sending/completing=
 a
>> request containing a buffer, and period notifications. They are not the =
same.
>=20
> What do you expect a period notification to be?  The default expecation
> would very much be that they're tied to what's going on with the
> buffers.

Elapsed period notification was initially proposed as an optional feature. =
But
then the discussion switched on to define the entire period-based operation=
al
sequence built in protocol. Well, we can go this way and make periods not a=
n
optional notification, but a full optional mode of operation. Then we can a=
dd
all the requirements that Gerd spoke of.


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

