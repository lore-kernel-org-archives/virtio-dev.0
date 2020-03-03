Return-Path: virtio-dev-return-6878-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9ED09985F09
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Mar 2020 12:27:43 +0000 (UTC)
References: <20200302152429.1666557-1-Anton.Yakovlev@opensynergy.com>
 <20200303112053.xuskcdi4747rnzcd@sirius.home.kraxel.org>
 <54b98087-36c8-b595-49f9-26cb6fdbd9bb@opensynergy.com>
 <20200303121005.mmcjlwuu7v7vvyqm@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <abfad80f-4e7d-bb58-1fbd-513f30ca3c2a@opensynergy.com>
Date: Tue, 3 Mar 2020 13:27:38 +0100
MIME-Version: 1.0
In-Reply-To: <20200303121005.mmcjlwuu7v7vvyqm@sirius.home.kraxel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v6] virtio-snd: add virtio sound device
 specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 03.03.2020 13:10, Gerd Hoffmann wrote:
> On Tue, Mar 03, 2020 at 12:28:32PM +0100, Anton Yakovlev wrote:
>> Hi,
>>
>> On 03.03.2020 12:20, Gerd Hoffmann wrote:
>>>     Hi,
>>>
>>>> 4. Introduce the polling mode feature for a message-based transport.
>>>
>>> BTW: is that driver -> device or device -> driver or both?
>>> In case both: should we have two separate feature flags maybe?
>>
>> It's driver -> device direction. The driver needs notifications from the
>> device in any case, so it makes no sense to suppress notifications in th=
is
>> direction (device -> driver).
>=20
> Hmm, unless I missed something it doesn't matter whenever the guest
> kernel checks virtqueues from irq handler or timer ...

Because in the general case, it is impossible to predict when a notificatio=
n
will come from the device. Even if we are talking about a period time, this
does not mean that the device will send notifications precisely at these
intervals. And this means that the driver must do a tricky poll, trying
to guess when the notification will arrive, i.e. just waste CPU resources.


>=20
> cheers,
>    Gerd
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

