Return-Path: virtio-dev-return-6382-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 10333985EB2
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Nov 2019 14:07:03 +0000 (UTC)
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
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <4db86201-ea0b-80e0-5714-ffa598bee34f@opensynergy.com>
Date: Fri, 22 Nov 2019 15:06:48 +0100
MIME-Version: 1.0
In-Reply-To: <20191122123521.GB6849@sirena.org.uk>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Mark Brown <broonie@kernel.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On 22.11.2019 13:35, Mark Brown wrote:
> On Thu, Nov 21, 2019 at 01:57:51PM +0100, Anton Yakovlev wrote:
>=20
>> SNDRV_PCM_FORMAT_MPEG
>> SNDRV_PCM_FORMAT_GSM
>> SNDRV_PCM_FORMAT_G723_24
>> SNDRV_PCM_FORMAT_G723_24_1B
>> SNDRV_PCM_FORMAT_G723_40
>> SNDRV_PCM_FORMAT_G723_40_1B
>=20
>> Do we really need all of them? And I skipped endianess, but should we ca=
re
>> about it as well?
>=20
> The compressed audio formats I quoted above (and possibly some others)
> are mostly redundant and better handled through something like the ALSA
> compressed audio interface but that's definitely a separate thing with
> different requirements.

Then let's include all except these.


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

