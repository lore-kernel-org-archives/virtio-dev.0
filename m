Return-Path: virtio-dev-return-6664-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A46A986021
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Jan 2020 17:51:12 +0000 (UTC)
References: <20200109140743.303046-1-Anton.Yakovlev@opensynergy.com>
 <20200114101251.3qdo7w4zfsablo7t@sirius.home.kraxel.org>
From: Mikhail Golubev <mikhail.golubev@opensynergy.com>
Message-ID: <d0e2b656-55e2-dfd3-5c4b-808edbde95ca@opensynergy.com>
Date: Fri, 17 Jan 2020 18:51:02 +0100
MIME-Version: 1.0
In-Reply-To: <20200114101251.3qdo7w4zfsablo7t@sirius.home.kraxel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v5] virtio-snd: add virtio sound device
 specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>, Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Gert!

Great news.
We are in the process of the implementation process now. Will upstream ASAP=
.

BR,
Mikhail.

On 1/14/20 11:12 AM, Gerd Hoffmann wrote:
> On Thu, Jan 09, 2020 at 03:07:43PM +0100, Anton Yakovlev wrote:
>> This patch proposes virtio specification for a new virtio sound device,
>> that may be useful in case when having audio is required but a device
>> passthrough or emulation is not an option.
>=20
> Looks good to me.  Where do we stand in terms of device/driver
> implementations?  Trying to actually implement things sometimes
> finds problems in the specification ...
>=20
> cheers,
>    Gerd
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

