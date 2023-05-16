Return-Path: <virtio-dev-return-12705-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B48C7EE23
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 03:28:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D4C01139614
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 03:28:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C652A9865B6
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 03:28:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B4C52983DA0; Tue, 16 May 2023 03:28:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2200986511
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 03:28:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 1WKL2WQ8OOOO4A_sdadUfw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684207690; x=1686799690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCRT/DN4Jciv38zyYVyz7kaBCI9/FhdDi+9NaGy9Cws=;
        b=VTI+G04pcKn0YNgBZmUhiBkmywWN71Y+Ns7kqkVr0JY4jzz7MMUqybvQZqrqyOYBU2
         GlruCB65L/vmMDulq4JvwOzt2hLtK3lHlzp717/WlJYAu/oI+3erq3HYKwCrNooxgXu3
         W6Tl67WU4i/jbuu4RK0yMs5Ju6pHDtESW7qtjUy+TobWNbp/rs1ucOHUpqn5/ZY0lIkF
         8rNp2aAMYRe8dAtSwXgbO5gZiks8w20gvDJYtNPjQyWoK//rV6NV4ZgVCEBn+uGVzsea
         y8JRb6Le9WKidac1HOwb/q5fL5VMU4oqNpwr0n8yWH8aFv5JXiqBnBqU3Jm4NBYCKPL7
         klNg==
X-Gm-Message-State: AC+VfDz5VUNFmnGiaUPQG+A3FA0uuIoBBgGbL7mS2/S1x3W0PRn/eDqP
	Zi2QR/9byuHwt99/RAJeYeOrPpNZ5K3oGdh1r4Yr7tP/vvVmv+03T9uHc8n5KF8RU3blJ6SEDjo
	Q7OUizdzxkOCmzYCqXlACasVYUlzq
X-Received: by 2002:a17:903:41c3:b0:1a9:6b57:f400 with SMTP id u3-20020a17090341c300b001a96b57f400mr47438292ple.16.1684207689973;
        Mon, 15 May 2023 20:28:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7FwLW3vYm8xfCzsTQ+/UB4sQYsGnex5EfzN80A0GCz4HmwlYgjrWASsEoAzzN8ikoeBAs6HA==
X-Received: by 2002:a17:903:41c3:b0:1a9:6b57:f400 with SMTP id u3-20020a17090341c300b001a96b57f400mr47438272ple.16.1684207689521;
        Mon, 15 May 2023 20:28:09 -0700 (PDT)
Message-ID: <078af8e2-fb10-b33a-6751-374c4fbd09a9@redhat.com>
Date: Tue, 16 May 2023 11:28:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "david.edmondson@oracle.com" <david.edmondson@oracle.com>,
 "sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas
 <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Shahaf Shuler <shahafs@nvidia.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <893b6ec0-a74f-69b7-95a3-988f0f9382a8@redhat.com>
 <PH0PR12MB5481CF52380D414AFFBA6A9FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <PH0PR12MB5481CF52380D414AFFBA6A9FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

Hi Parav:

在 2023/5/15 23:49, Parav Pandit 写道:
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Monday, May 15, 2023 3:11 AM
>>> It is just bunch of admin commands in the new SIOV or virtual virtio device
>> chapter.
>>> It is not a transport chapter.
>>
>> Provisioning could be a part of the transport. For example SR-IOV allows static
>> and dynamic provisioning. If a virtio device needs to be implemented in VF, it
>> needs to be provisioned first.
>>
> Provisioning a device by admin != transport guest driver <-> device communication.
>
> Two very different things.


When developing a new transport, we need to consider at least how to 
probe the device. Before probe the device, it needs to be provisioned. 
If we want a new transport, it could implement the provisioning 
especially if it want the design to be bus independent. For the proposal 
like transport virtqueue, it's also fine to use bus specific facility to 
provision and probe the device.


That is what I want to say.


>
>>>>> And the motivation is also clear is to provide composing a virtio
>>>>> device for the
>>>> guest VM for the backward compatibility for 1.x part of the specification.
>>>>> It seems fine and indeed orthogonal to me that: it is for backward
>>>> compatibility for already defined config fields for existing guest VM driver.
>>>>> It does not conflict with the cfgq/cmdq idea whose main purpose is
>>>>> for the
>>>> new config fields, new use cases that doesn't require any mediation.
>>>>> Such cfgq works across PF, VF, SF/SIOV devices in uniform way
>>>>> without
>>>> mediation.
>>>>
>>>> My understanding is that the cfgq/cmdq could be done on top, since
>>>> the commands are part of transport unless I miss something.
>>>>
>>> On top of what?
>>> cfgq/cmdq is just another queue like any other VQ.
>>> it is orthogonal to accessing 1.x registers using group owner's queue.
>>
>> I think there hasn't been any proposal that call any virtqueue like cfgq/cmdq. So
>> using that may cause a lot of misunderstanding. I think the context here is to
>> provide or extend transport facilities via a virtqueue not something like the
>> control virtqueue.
> The context is to compose a PCI device for a guest which for the currently defined features.
> Once a new attribute is done using cfgq/cmdq there is no problem of transporting it via its group member.
>
> And therefore, saying any new attribute also to ride on same tranportq/aq via is not appropriate.


The point is to try to find if there's a better way, more below.


>
>> Admin virtqueue doesn't preventing anything from letting IMS go directly to the
>> device.
> But there is no aq/cfgq/cmdq defined for the guest, so with current proposal it is prevented.


It's a choice of the implementation but not spec. Spec doesn't say 
adminq can't be used for guest.


>
>>
>>>    Long discussion with Thomas on IMS topic.
>>> I will avoid diverting to unrelated discussion for now.
>>>
>>>>> Or proposed command in [1] should be tagged as siov_r1, then things will
>> be
>>>> cleaner.
>>>>
>>>> Maybe we can say, one of the implementations is siov_r1, since it can be
>> used
>>>> to implement devices in other transport. One of the main motivations for
>>>> transport virtqueue is to reduce the transport specific resources to ease the
>>>> virtio device implementation.
>>>>
>>> Yes, the main motivation as for backward compatibility for the currently
>> defined features.
>>>>> With that I don't see legacy 3 commands anyway conflict with [1].
>>>> It doesn't, but it's not elegant since:
>>>>
>>> I don’t see how making 3 commands to 9 commands makes it elegant by
>> doing bisecting of registers offset in hypervisor.
>>
>>
>> Or it needs to be done by the hardware and cross register write/read
>> needs to be handled there as well.
>>
> That is the limitation of legacy and device can always _decide_ when to apply the parameter later when enough bits are written.
> Given its control path, it is not an overhead.


I think we've discussed many times that legacy is tricky for hardware. 
And your proposal proves this further by introducing modern alike 
notification areas. We probably need to deal with others like endianess.

For any case, having a simple and deterministic device design is always 
better assuming we've agreed that mediation is a must for legacy 
drivers. Using dedicated commands can make sure the implementation won't 
need to go with corner cases of legacy.


>
>>> Its same thing using more opcodes.
>>
>> Do we really care about the number of opcodes? I think we've reserved
>> sufficient spaces.
>>
> I don’t see opcode as problem, we have plenty.
> And hence, when there is a device that _does not implement config space for SIOV/SF, it should be introduced.
> It is the introduction and bisection at the hypervisor level unnecessary.
>
> And I don’t have object to it either, the main reason is: I don’t see it being useful for 1.x access going forward.


As you said for future SIOV/SF? For example, it can have better 
scalability in IMS since it doesn't require any real capabilities or 
registers.


>
>>>> 1) Modern transport, admin virtqueue with well defined transport
>> commands
>>>> 2) Legacy transport, works moe like a PCI transport on top of the admin
>>>> virtqueue
>>>>
>>>> Transport virtqueue tend to be transport independent, but 2) tie it somehow
>> to
>>>> the PCI. That's why I suggest to
>>>>
>>> The 4 patches are not transporting all the PCI things over transport VQ. it is
>> not a transport.
>>
>>
>> It really depends on the different viewpoint.
> You wrote/asked for "PCI transport over admin q".
> That means PCI capabilities, PCI config registers and all things defined in the PCI transport section to go over the AQ.
> This is clearly not the objective of these 2 patches.


It's not but it can achieve the same function as this series with much 
broader use cases.


> Nor it is your proposal of transport VQ.


Same as the above.

I think we know your proposal might but it's worthwhile to figure out 
whether or not there could be other better ways to achieve the same 
thing. That's why the discussion happens on the cover letter.

Both transport virtqueue and "PCI over adminq" can support legacy guest 
with a lot of other use cases.


>
> You only want to exchange currently defined config registers, interrupts and notification configuration using AQ.
>
> Transport VQ is NOT transporting actual data, it is not transporting notifications etc.
> It is just a config channel.
> Hence, they are just commands not a "full transport".


For any case, a virtqueue could not be a full transport. It needs bus 
facilities to do bootstrap/DMA/notifications at least. The idea is to 
save for transport specific resources and use a more scalable way to 
config devices.


>
>> To me, adminq is not
>> specific to PCI, so this proposal looks more like a partial transport
>> for legacy.
> It is not a partial transport for legacy.
> A future transport may be able to do for SIOV/MMIO by adding those group member identifier.
>
> Hence, I agreed that commands in the tranportvq proposal is fine, as commands, not as new transport.
>
>> So we have
>>
>> 1) all commands via PCI
>> 2) all commands via adminq
>> 3) part of the commands via PCI and the rest via adminq
>>
>> This proposal goes to for 3 with transport specific commands while I
>> think we need to try 1 and 2 then it is more general and it helps to
>> avoid duplication with future features.
>>
> All legacy interface via AQ.


That's pretty fine. So we have already had modern transport via a 
virtqueue, why not unify the design to avoid duplication? Otherwise we 
may end up with

1) legacy PCI alike commands via admin virtqueue with modern alike 
notification areas
2) modern device commands via admin virtqueue


> All modern interface access via PCI or its own transport between driver and device.


Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

