Return-Path: virtio-dev-return-7942-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6666A9843E0
	for <virtio-dev@lists.oasis-open.org>; Sun, 24 Jan 2021 16:53:55 +0000 (UTC)
References: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
 <3ac230040630c3b6695f8a091e000f5b4f90b3ce.camel@intel.com>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <52efab17-d6e2-c3f4-c3de-73338b811534@opensynergy.com>
Date: Sun, 24 Jan 2021 17:53:52 +0100
MIME-Version: 1.0
In-Reply-To: <3ac230040630c3b6695f8a091e000f5b4f90b3ce.camel@intel.com>
Subject: [virtio-dev] Re: [PATCH 0/7] ALSA: add virtio sound driver
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.com" <tiwai@suse.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi, Liam!


On 20.01.2021 11:10, Girdwood, Liam R wrote:
> CAUTION: This email originated from outside of the organization.
> Do not click links or open attachments unless you recognize the sender an=
d know the content is safe.
>=20
>=20
> Hi Anton,
>=20
> On Wed, 2021-01-20 at 01:36 +0100, Anton Yakovlev wrote:
>> This series implements a driver part of the virtio sound device
>> specification v8 [1].
>>
>> The driver supports PCM playback and capture substreams, jack and
>> channel map controls. A message-based transport is used to write/read
>> PCM frames to/from a device.
>>
>> The series is based (and was actually tested) on Linus's master
>> branch [2], on top of
>>
>> commit 1e2a199f6ccd ("Merge tag 'spi-fix-v5.11-rc4' of ...")
>>
>> As a device part was used OpenSynergy proprietary implementation.
>>
>> Any comments are very welcome.
>>
>=20
> This just looks like the guest front end here, do you have a follow up
> series for the host backend ?

As I mentioned in the cover message, as a device part was used our own
proprietary implementation. And there are no plans to upstream that
part.


> Thanks
>=20
> Liam
> ---------------------------------------------------------------------
> Intel Corporation (UK) Limited
> Registered No. 1134945 (England)
> Registered Office: Pipers Way, Swindon SN3 1RJ
> VAT No: 860 2173 47
>=20
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
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

