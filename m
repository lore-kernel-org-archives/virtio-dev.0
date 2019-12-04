Return-Path: virtio-dev-return-6458-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 12E2298603B
	for <virtio-dev@lists.oasis-open.org>; Wed,  4 Dec 2019 08:04:07 +0000 (UTC)
References: <ee52234e-6b53-1f2a-563f-c3dd50dd1764@opensynergy.com>
 <21039a042ad38302e9dc9010014223d915704b91.camel@linux.intel.com>
 <07b9804d-2c20-9ff4-a375-2c65f1d27f63@opensynergy.com>
 <20191121090403.6vjnovlru4zrmzzs@sirius.home.kraxel.org>
 <84fb109c-1d1e-a52c-8efa-8dcd00b864b3@opensynergy.com>
 <20191122123521.GB6849@sirena.org.uk>
 <4db86201-ea0b-80e0-5714-ffa598bee34f@opensynergy.com>
 <D68AC0D0-851B-4F87-BE0E-F49527B83E24@redhat.com>
 <20191128121920.GB4210@sirena.org.uk>
 <6fc1a8cb-32aa-938a-f1b3-f11a9273ca6b@opensynergy.com>
 <20191202135519.GF1998@sirena.org.uk>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <dbe491e0-3eda-e204-7ce3-3b602f2efd3c@opensynergy.com>
Date: Wed, 4 Dec 2019 09:04:02 +0100
MIME-Version: 1.0
In-Reply-To: <20191202135519.GF1998@sirena.org.uk>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Mark Brown <broonie@kernel.org>
Cc: Christophe de Dinechin <cdupontd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On 02.12.2019 14:55, Mark Brown wrote:
> On Mon, Dec 02, 2019 at 02:30:44PM +0100, Anton Yakovlev wrote:
>> On 28.11.2019 13:19, Mark Brown wrote:
>=20
>>> If you're talking about compressed as opposed to PCM audio here (you sa=
y
>>> decompression) I think you probably want a different spec there, the
>>> flow control stuff is quite different and you often need a lot more
>>> configuration for compressed formats.
>=20
>> Usually all such kind of things are tight together in one audio subsyste=
m and
>> in one audio driver. I don't think it has a sense to separate all kind o=
f
>> streams into different specs.
>=20
> All the Linux based systems split the data paths, and at the
> hardware level unless you're using a message based system (which
> is basically just software anyway) you need a different interface
> as you can't push data through the system at a constant rate
> which is a central assumption for PCM audio.

Are we going to design separated specs for different audio features? It see=
ms
a little bit of overkill.


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

