Return-Path: virtio-dev-return-6437-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0B836985A88
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Dec 2019 13:28:07 +0000 (UTC)
References: <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
 <20191112110937.GA4187507@lophozonia>
 <0c5939ad0b330bc4f42d63536340293745dce728.camel@linux.intel.com>
 <20191112160554.GA16008@lophozonia>
 <4ca16fb1d412bc92a2a65104680282b80742f6b1.camel@linux.intel.com>
 <ee52234e-6b53-1f2a-563f-c3dd50dd1764@opensynergy.com>
 <21039a042ad38302e9dc9010014223d915704b91.camel@linux.intel.com>
 <07b9804d-2c20-9ff4-a375-2c65f1d27f63@opensynergy.com>
 <20191121090403.6vjnovlru4zrmzzs@sirius.home.kraxel.org>
 <84fb109c-1d1e-a52c-8efa-8dcd00b864b3@opensynergy.com>
 <20191122123521.GB6849@sirena.org.uk>
 <4db86201-ea0b-80e0-5714-ffa598bee34f@opensynergy.com>
 <D68AC0D0-851B-4F87-BE0E-F49527B83E24@redhat.com>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <754ec8f2-755c-d577-bb5b-4acb2001f799@opensynergy.com>
Date: Mon, 2 Dec 2019 14:28:01 +0100
MIME-Version: 1.0
In-Reply-To: <D68AC0D0-851B-4F87-BE0E-F49527B83E24@redhat.com>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Christophe de Dinechin <cdupontd@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Liam
 Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Christophe,


On 28.11.2019 10:37, Christophe de Dinechin wrote:
>=20
>=20
>> On 22 Nov 2019, at 15:06, Anton Yakovlev <anton.yakovlev@opensynergy.com=
> wrote:
>>
>> On 22.11.2019 13:35, Mark Brown wrote:
>>> On Thu, Nov 21, 2019 at 01:57:51PM +0100, Anton Yakovlev wrote:
>>>> SNDRV_PCM_FORMAT_MPEG
>>>> SNDRV_PCM_FORMAT_GSM
>>>> SNDRV_PCM_FORMAT_G723_24
>>>> SNDRV_PCM_FORMAT_G723_24_1B
>>>> SNDRV_PCM_FORMAT_G723_40
>>>> SNDRV_PCM_FORMAT_G723_40_1B
>>>> Do we really need all of them? And I skipped endianess, but should we =
care
>>>> about it as well?
>>> The compressed audio formats I quoted above (and possibly some others)
>>> are mostly redundant and better handled through something like the ALSA
>>> compressed audio interface but that's definitely a separate thing with
>>> different requirements.
>>
>> Then let's include all except these.
>=20
> Is the intent that any virtio device has to support all the same formats?
>=20
> If I=E2=80=99m talking to a hardware decoder, then a compressed format ma=
kes sense
> (there is no point in decompressing in software if the device=E2=80=99s v=
ery purpose
> is to do it in hardware). But then, maybe it supports one format but not =
another.
>=20
> So it looks to me like all the formats should be part of the spec, and so=
me
> device capabilities should indicate which ones the device accepts.

We discussed only PCM-related things. Compressed offload could be as a feat=
ure
with its own configuration layout, format definitions, request types, maybe
virtqueue(s) and so on.


>=20
>=20
> Thanks
> Christophe
>=20
>>
>>
>> --=20
>> Anton Yakovlev
>> Senior Software Engineer
>>
>> OpenSynergy GmbH
>> Rotherstr. 20, 10245 Berlin
>>
>> Phone: +49 30 60 98 54 0
>> E-Mail: anton.yakovlev@opensynergy.com
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>
>=20
>=20

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

