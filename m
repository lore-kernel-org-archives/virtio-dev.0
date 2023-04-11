Return-Path: <virtio-dev-return-12120-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC81C76196
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 11:03:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5D0EF4290A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 11:03:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FC309863D8
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 11:03:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 28910983DFF; Tue, 11 Apr 2023 11:03:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1739D98636D
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Apr 2023 11:03:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681211007; x=1683803007;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSx8TH7IbRlKaB82xi2U1aT2IJbagTs7ZPWNVaaePbM=;
        b=zZdpy9hoUQ9iwZn5dY+udHLqKJbSZMIoIbIz8gt7rbw4lNlFh7l9p9bLLPsxBYDrrl
         0h9UkK1h4dDr040ztLlPAVrGrnCfBAoJ+ne4ju+QUTli49zCextDzCBspd9SUU34uxsx
         XHobWIt/QEkjKAL4WQuRSoDJgNHWJunw1/qxQJZdTYwTuVVobyKro2FW2bAB38xjIRf5
         C64wTkamxlGduNFALOjj1Ib+SqLK21Sn1EecO6nJiD4x4HvWJ55OcuP4W1tw3Y8ExzKR
         SNpPdcCONXhwS2vGgmJJ1Moox2CbQ3f/1okanq4dsg25BOZJC0vvGqQwhuYEhqSSODE3
         PkTw==
X-Gm-Message-State: AAQBX9d5ruXq5YNk001eK211Xk1PouJYQIEXOu3iB7ttYUo6a0lhkeGe
	Fk8o5M45fikWo5polAaRKcyTGQ==
X-Google-Smtp-Source: AKy350ZADtVnKPw2acAMWXgPa0XV3C6lcj+ihRrIBuhKIIrE7TnPGpT1qf6uEkOC7h0Fc7o5HfNl0w==
X-Received: by 2002:adf:f2cc:0:b0:2e4:eebe:aee3 with SMTP id d12-20020adff2cc000000b002e4eebeaee3mr1987671wrp.60.1681211007010;
        Tue, 11 Apr 2023 04:03:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Yan Vugenfirer <yan@daynix.com>
Mime-Version: 1.0 (1.0)
Date: Tue, 11 Apr 2023 14:03:15 +0300
Message-Id: <4D5FDB4C-D907-4C59-92A2-422A22FA2479@daynix.com>
References: <20230411063746-mutt-send-email-mst@kernel.org>
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
 cohuck@redhat.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
 Satananda Burla <sburla@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20230411063746-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: iPhone Mail (20C65)
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI MMR dev config registers



Sent from my iPhone

> On 11 Apr 2023, at 13:39, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> =EF=BB=BFOn Tue, Apr 11, 2023 at 12:19:14PM +0300, Yan Vugenfirer wrote:
>>> On Tue, Apr 11, 2023 at 12:02=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
>>>=20
>>> On Tue, Apr 11, 2023 at 3:04=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
>>>>=20
>>>> On Tue, Apr 11, 2023 at 10:13:40AM +0800, Jason Wang wrote:
>>>>> On Mon, Apr 10, 2023 at 6:06=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
>>>>>>=20
>>>>>> On Mon, Apr 10, 2023 at 03:20:52PM +0800, Jason Wang wrote:
>>>>>>> On Mon, Apr 10, 2023 at 2:40=E2=80=AFPM Michael S. Tsirkin <mst@redh=
at.com> wrote:
>>>>>>>>=20
>>>>>>>> On Mon, Apr 10, 2023 at 02:20:16PM +0800, Jason Wang wrote:
>>>>>>>>> On Mon, Apr 10, 2023 at 2:15=E2=80=AFPM Michael S. Tsirkin <mst@re=
dhat.com> wrote:
>>>>>>>>>>=20
>>>>>>>>>> On Mon, Apr 10, 2023 at 09:33:32AM +0800, Jason Wang wrote:
>>>>>>>>>>> This is fine for vDPA but not for virtio if the design can only w=
ork
>>>>>>>>>>> for some specific setups (OSes/archs).
>>>>>>>>>>>=20
>>>>>>>>>>> Thanks
>>>>>>>>>>=20
>>>>>>>>>> Well virtio legacy has a long history of documenting existing hac=
ks :)
>>>>>>>>>=20
>>>>>>>>> Exactly, so the legacy behaviour is not (or can't be) defined by t=
he
>>>>>>>>> spec but the codes.
>>>>>>>>=20
>>>>>>>> I mean driver behaviour derives from the code but we do document it=
 in
>>>>>>>> the spec to help people build devices.
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>>> But yes, VIRTIO_F_ORDER_PLATFORM has to be documented.
>>>>>>>>>> And we have to decide what to do about ACCESS_PLATFORM since
>>>>>>>>>> there's a security problem if device allows not acking it.
>>>>>>>>>> Two options:
>>>>>>>>>> - relax the rules a bit and say device will assume ACCESS_PLATFOR=
M
>>>>>>>>>>  is acked anyway
>>>>>>>>>=20
>>>>>>>>> This will break legacy drivers which assume physical addresses.
>>>>>>>>=20
>>>>>>>> not that they are not already broken.
>>>>>>>=20
>>>>>>> I may miss something, the whole point is to allow legacy drivers to
>>>>>>> run otherwise a modern device is sufficient?
>>>>>>=20
>>>>>> yes and if legacy drivers don't work in a given setup then we
>>>>>> should not worry.
>>>>>>=20
>>>>>>>>=20
>>>>>>>>>> - a new flag that is insecure (so useful for sec but useless for d=
pdk) but optional
>>>>>>>>>=20
>>>>>>>>> This looks like a new "hack" for the legacy hacks.
>>>>>>>>=20
>>>>>>>> it's not just for legacy.
>>>>>>>=20
>>>>>>> We have the ACCESS_PLATFORM feature bit, what is the useage for this=
 new flag?
>>>>>>=20
>>>>>>=20
>>>>>> ACCESS_PLATFORM is also a security boundary. so devices must fail
>>>>>> negotiation if it's not there. this new one won't be.
>>>>>>=20
>>>>>>=20
>>>>>>>>=20
>>>>>>>>> And what about ORDER_PLATFORM, I don't think we can modify legacy d=
rivers...
>>>>>>>>>=20
>>>>>>>>> Thanks
>>>>>>>>=20
>>>>>>>> You play some tricks with shadow VQ I guess.
>>>>>>>=20
>>>>>>> Do we really want to add a new feature in the virtio spec that can
>>>>>>> only work with the datapath mediation?
>>>>>>>=20
>>>>>>> Thanks
>>>>>>=20
>>>>>> As long as a feature is useful and can't be supported otherwise
>>>>>> we are out of options.
>>>>>=20
>>>>> Probably not? Is it as simple as relaxing this:
>>>>>=20
>>>>> "Transitional devices MUST expose the Legacy Interface in I/O space in=
 BAR0."
>>>>>=20
>>>>> To allow memory space.
>>>>>=20
>>>>> This works for both software and hardware devices (I had a handy
>>>>> hardware that supports legacy virtio drivers in this way).
>>>>>=20
>>>>> Thanks
>>>>=20
>>>> Yes it is certainly simpler.
>>>>=20
>>>> Question: what happens if you try to run existing windows guests or dpd=
k
>>>> on these? Do they crash horribly or exit gracefully?
>>>=20
>>> Haven't tried DPDK and windows. But I remember DPDK supported legacy
>>> MMIO bars for a while.
>>=20
>> Regarding Windows drivers:
>> 1. We are acking VIRTIO_F_ACCESS_PLATFORM in the driver. But, if you
>> remember the "ATS" issue (Windows is either not detecting it or, even
>> if detected, not using it) - then actually, we are not forcing Windows
>> to remap the memory because Window fails to work with it correctly.
>> 2. Current Windows drivers implementation doesn't support MMIO bars.
>> We can enable the support if needed.
>>=20
>> Best regards,
>> Yan.
>=20
> The question was about old legacy drivers, not modern ones.
> What if they attach to a device and BAR0
> is a memory not an IO bar?
> Will they fail gracefully or crash?
The drivers should fail to load gracefully. There will be no crash, except i=
n the case of the virtio-blk or virtio-scsi as a boot device.

>=20
>=20
>>=20
>>>=20
>>> Adding Maxime and Yan for comments here.
>>>=20
>>>>=20
>>>> The point of the capability is to allow using modern device ID so such
>>>> guests will not even try to bind.
>>>=20
>>> It means a mediation layer is required to use. Then it's not an issue
>>> for this simple relaxing any more?
>>>=20
>>> An advantage of such relaxing is that, for the legacy drivers like an
>>> ancient Linux version that can already do MMIO access to legacy BAR it
>>> can work without any mediation.
>>>=20
>>> At least, if ID can help, it can be used with this as well.
>>>=20
>>> Thanks
>>>=20
>>>=20
>>>=20
>>>>=20
>>>>=20
>>>>>> Keeping field practice things out of the
>>>>>> spec helps no one.
>>>>>>=20
>>>>>>>>=20
>>>>>>>> --
>>>>>>>> MST
>>>>>>>>=20
>>>>>>=20
>>>>=20
>>>=20
>=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

