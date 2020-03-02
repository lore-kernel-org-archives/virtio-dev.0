Return-Path: virtio-dev-return-6833-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 55610985B2F
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Mar 2020 10:24:08 +0000 (UTC)
References: <20200109140743.303046-1-Anton.Yakovlev@opensynergy.com>
 <20200114101251.3qdo7w4zfsablo7t@sirius.home.kraxel.org>
 <889de025-edfe-5d31-33b6-6cc842a91aee@opensynergy.com>
 <20200228111430.lyx3cbpxcgzds4lp@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <8c89c93d-e201-f71e-8576-36bf53a3b1d3@opensynergy.com>
Date: Mon, 2 Mar 2020 11:24:02 +0100
MIME-Version: 1.0
In-Reply-To: <20200228111430.lyx3cbpxcgzds4lp@sirius.home.kraxel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v5] virtio-snd: add virtio sound device
 specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 28.02.2020 12:14, Gerd Hoffmann wrote:
> On Thu, Feb 27, 2020 at 03:08:59PM +0100, Anton Yakovlev wrote:
>> Hello all,
>>
>> We have completed the implementation of the PoC specification v5. Below =
are
>> our comments on what might or should be improved in the specification.
>>
>> Initialization:
>>
>> 1. I think we should add the direction of the jack (in/out) to the
>> configuration of the jack. Because some properties (for example, a label=
 for
>> some jack types) are based on this direction. The Linux HDA subsystem ta=
kes
>> this information from a pin/complex configuration. But we don't have (an=
d
>> don't need) such entities.
>=20
> Sounds good.
>=20
>> 2. The stream configuration contains =E2=80=9Cfeatures=E2=80=9D that par=
tially work as normal
>> virtio features, and partially do not. Maybe it is better to rename the =
field
>> to =E2=80=9Cflags=E2=80=9D (as well as in the set_params request) and en=
ter two sets of flags:
>> one is reported in the stream configuration, and the other is used in th=
e
>> set_params request? This should make things less confusing.
>=20
> Maybe have both features and flags fields?

Yes, that's a good idea.


>> 1. In the latest version of the specification, we resized the =E2=80=9Cf=
eatures=E2=80=9D field
>> in the stream configuration (u8->le32), but forgot to do the same in the
>> set_params request. This should be fixed.
>=20
> Sure.
>=20
>> 2. The device may report polling support for message-based transport. In=
 this
>> case, the driver can be optimized so that it does not kick virtqueue for=
 each
>> message.
>=20
> Makes sense too, especially given that the packets should arrive at
> regular intervals and not (unlike for example network packets) at
> unpredictable times.

Then this will be an additional feature.


>> 3. For the input stream (capture), we decided to report the actual fille=
d size
>> using the len field in the virtqueue descriptor. Should the specificatio=
n
>> clearly indicate that the value contains sizeof(struct virtio_snd_pcm_st=
atus)
>> + the size of the recorded frames?
>=20
> Doesn't hurt to explicitly say so even though it should be clear that
> the descriptor size covers the complete payload and not only the
> recorded frames.
>=20
>> 4. We also need to add a device requirement to complete all pending mess=
ages
>> for a stream on a RELEASE request. Otherwise, they may become stuck in t=
he
>> virtqueue.
>=20
> Yes, that makes sense.  Maybe also explicitly say that the RELEASE
> request should be completed last (only after all other pending messages
> are completed).

Makes sense, I will add this as well.


>=20
> cheers,
>    Gerd
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20
>=20

--=20
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

