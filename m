Return-Path: virtio-dev-return-6876-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2B32985F09
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Mar 2020 11:28:37 +0000 (UTC)
References: <20200302152429.1666557-1-Anton.Yakovlev@opensynergy.com>
 <20200303112053.xuskcdi4747rnzcd@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <54b98087-36c8-b595-49f9-26cb6fdbd9bb@opensynergy.com>
Date: Tue, 3 Mar 2020 12:28:32 +0100
MIME-Version: 1.0
In-Reply-To: <20200303112053.xuskcdi4747rnzcd@sirius.home.kraxel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v6] virtio-snd: add virtio sound device
 specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

On 03.03.2020 12:20, Gerd Hoffmann wrote:
>    Hi,
>=20
>> 4. Introduce the polling mode feature for a message-based transport.
>=20
> BTW: is that driver -> device or device -> driver or both?
> In case both: should we have two separate feature flags maybe?

It's driver -> device direction. The driver needs notifications from the=20
device in any case, so it makes no sense to suppress notifications in this=
=20
direction (device -> driver).


>=20
> Otherwise this looks good to me.
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

