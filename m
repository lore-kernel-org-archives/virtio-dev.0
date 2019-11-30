Return-Path: virtio-dev-return-6430-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 864BB986015
	for <virtio-dev@lists.oasis-open.org>; Sat, 30 Nov 2019 17:07:02 +0000 (UTC)
References: <20170421111259.4b900b6b.cornelia.huck@de.ibm.com>
 <20170428124909.GH7270@stefanha-x1.localdomain>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a056497e-dbd6-749c-fa1a-c3d48edcbafa@siemens.com>
Date: Sat, 30 Nov 2019 18:06:48 +0100
MIME-Version: 1.0
In-Reply-To: <20170428124909.GH7270@stefanha-x1.localdomain>
Content-Language: en-US
Subject: Re: [virtio-dev] virtio-blk: What's up with VIRTIO_BLK_T_GET_ID (8)?
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 28.04.17 14:49, Stefan Hajnoczi wrote:
> On Fri, Apr 21, 2017 at 11:12:59AM +0200, Cornelia Huck wrote:
>> I see the request type in $SUBJECT implemented in both Linux and QEMU,
>> but I can't find it in the standard.
>>
>> If we believe that getting a s/n is useful, we should spec it;
>> otherwise, if we consider it just a legacy request type, it wouldn't
>> hurt to mention it in the legacy section.
>=20
> It's not a legacy request type.
>=20
> Alexey Zaytev documented it in 2012:
>=20
> https://lists.linuxfoundation.org/pipermail/virtualization/2012-December/=
022313.html
>=20
> It was in the VIRTIO <1.0 spec:
>=20
> https://github.com/rustyrussell/virtio-spec/blob/master/virtio-spec.lyx
>=20
> I don't understand why it wasn't part of VIRTIO 1.0... :/
>=20
> It's worth sending a patch to add the request type to the spec again.
>=20

What happened with this? I was already searching for weired queue=20
corruptions in my implementation when I suddenly got this unspecified=20
request type.

How should this be added? With a feature bit? Or just document the given=20
reality (mandatory)?

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

