Return-Path: virtio-dev-return-6438-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DFDFB985A8B
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Dec 2019 13:31:02 +0000 (UTC)
References: <20191112160554.GA16008@lophozonia>
 <4ca16fb1d412bc92a2a65104680282b80742f6b1.camel@linux.intel.com>
 <ee52234e-6b53-1f2a-563f-c3dd50dd1764@opensynergy.com>
 <21039a042ad38302e9dc9010014223d915704b91.camel@linux.intel.com>
 <07b9804d-2c20-9ff4-a375-2c65f1d27f63@opensynergy.com>
 <20191121090403.6vjnovlru4zrmzzs@sirius.home.kraxel.org>
 <84fb109c-1d1e-a52c-8efa-8dcd00b864b3@opensynergy.com>
 <20191122123521.GB6849@sirena.org.uk>
 <4db86201-ea0b-80e0-5714-ffa598bee34f@opensynergy.com>
 <D68AC0D0-851B-4F87-BE0E-F49527B83E24@redhat.com>
 <20191128121920.GB4210@sirena.org.uk>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <6fc1a8cb-32aa-938a-f1b3-f11a9273ca6b@opensynergy.com>
Date: Mon, 2 Dec 2019 14:30:44 +0100
MIME-Version: 1.0
In-Reply-To: <20191128121920.GB4210@sirena.org.uk>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Mark Brown <broonie@kernel.org>, Christophe de Dinechin <cdupontd@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>
List-ID: <virtio-dev.lists.oasis-open.org>



On 28.11.2019 13:19, Mark Brown wrote:
> On Thu, Nov 28, 2019 at 10:37:17AM +0100, Christophe de Dinechin wrote:
>=20
>> If I=E2=80=99m talking to a hardware decoder, then a compressed format m=
akes sense
>> (there is no point in decompressing in software if the device=E2=80=99s =
very purpose
>> is to do it in hardware). But then, maybe it supports one format but not=
 another.
>=20
> If you're talking about compressed as opposed to PCM audio here (you say
> decompression) I think you probably want a different spec there, the
> flow control stuff is quite different and you often need a lot more
> configuration for compressed formats.

Usually all such kind of things are tight together in one audio subsystem a=
nd
in one audio driver. I don't think it has a sense to separate all kind of=
=20
streams into different specs.


--=20
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0
E-Mail: anton.yakovlev@opensynergy.com

www.opensynergy.com

Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616=
B
Gesch=C3=A4ftsf=C3=BChrer/Managing Director: Regis Adjamah

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

