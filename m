Return-Path: <virtio-dev-return-12679-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976BAC7EE24
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 07:13:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D5B89C624C
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 07:13:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C37F2986511
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 07:13:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B6DEB986348; Mon, 15 May 2023 07:13:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A3C2D98636A
	for <virtio-dev@lists.oasis-open.org>; Mon, 15 May 2023 07:13:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: qtpkEQDKOGu7k9rk3t0xxQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684134810; x=1686726810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLETnC/SDkvbm3TD93APrMhXuCURCpBqP3MGBL26f8g=;
        b=NdgXYfq/gNHMIDNyzQ5z2NUXkJtTNPd8NNoIbR5hXsbvdmj78Xl/hd3M7UrrJ0n9Ln
         st4Xm+LaLrXGRwDxegkSjO/MAqzsuYEu2N8JFjWhTJITraVikXqS8NZQcvhUGIDWJUqw
         UepHza/D/3/D8aE6fUhctt1gw6FIpaguHcLuD9jbQDGqiLSqswQzB+sGRKiMivWIte6d
         lKxUlrQPDqDQqu/j+noFWEnSKJtMrVCNiEtZWyHDAghgH7tePnlBk4KyKNwxtNIDW7TC
         XKzMuVfxEAfcSMvgng/N/I8cGlKK2u31UVnbEXiwf79qXS21pXKFC/ooQHKNtvry3VSo
         SEEw==
X-Gm-Message-State: AC+VfDzg4ZfGfnFMkzFpKP8rG6rTpi9B3XUmUO+D5EMHykY3IdhU50l1
	9v4paAyFnZqw+/ytIOQo1xqf1FAbKzwIm4QFhQo0r0VJ86GuOyfAVkrll8kxTpdGcZzKfKTaXao
	K7nP9/Aaz0uC8ONHaS6oW8O4D3kFd
X-Received: by 2002:a05:6a00:2346:b0:63f:2f00:c6d with SMTP id j6-20020a056a00234600b0063f2f000c6dmr43896152pfj.2.1684134810528;
        Mon, 15 May 2023 00:13:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7CXlsXytTrSpu08N4Kq7vdEaVM38mm+lnLnEK/9m3eVDv4vK2/l0tXUsy8PMlkX7iETH5ubQ==
X-Received: by 2002:a05:6a00:2346:b0:63f:2f00:c6d with SMTP id j6-20020a056a00234600b0063f2f000c6dmr43896135pfj.2.1684134810168;
        Mon, 15 May 2023 00:13:30 -0700 (PDT)
Message-ID: <4f7ad7f3-64bd-cd77-1a8a-30e93947ea30@redhat.com>
Date: Mon, 15 May 2023 15:13:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
 cohuck@redhat.com, david.edmondson@oracle.com, sburla@marvell.com,
 yishaih@nvidia.com, maorg@nvidia.com, virtio-comment@lists.oasis-open.org,
 shahafs@nvidia.com
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
 <20230510033812-mutt-send-email-mst@kernel.org>
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
 <20230511085205-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230511085205-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ


在 2023/5/11 20:54, Michael S. Tsirkin 写道:
> On Thu, May 11, 2023 at 03:04:40PM +0800, Jason Wang wrote:
>> On Wed, May 10, 2023 at 3:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>> On Wed, May 10, 2023 at 03:01:25PM +0800, Jason Wang wrote:
>>>> On Wed, May 10, 2023 at 2:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>> On Mon, May 08, 2023 at 10:23:39AM +0800, Jason Wang wrote:
>>>>>>> I thought so too originally. Unfortunately I now think that no, legacy is not
>>>>>>> going to be a byproduct of transport virtqueue for modern -
>>>>>>> it is different enough that it needs dedicated commands.
>>>>>> If you mean the transport virtqueue, I think some dedicated commands
>>>>>> for legacy are needed. Then it would be a transport that supports
>>>>>> transitional devices. It would be much better than having commands for
>>>>>> a partial transport like this patch did.
>>>>> OK I am beginning to get what you are saying.  So your criticism is
>>>>> this: what if device supports vq transport for modern, and we want to
>>>>> build a transitional device on top.  how will that look. yes?
>>>> Yes. I think it needs to be done through the transport virtqueue
>>>> otherwise the transport is not self-contained.
>>> I mean, any feature can be done over transport vq.
>>>
>>> But there is value in adding legacy commands to an otherwise
>>> modern device without reworking it completely to
>>> switch to a different transport.
>> There's probably no need for a rework since legacy is not complicated.
>> More below.
>>
>>>
>>>>> A reasonable thing to include at least in the commit log. Parav?
>>>>>
>>>>> You are also asking what if the device uses transport vq,
>>>>> and we want transitional on top of that.
>>>>> It's a fair question but I don't exactly get why would
>>>>> this legacy support feature be wanted for the vq transport
>>>>> and not for other transports.
>>>> Not sure I get the question, but all the existing transport support
>>>> legacy, if we want to have another, should the legacy support be a
>>>> must or not?
>>> This specific proposal is for tunneling legacy over admin vq.
>>> It can live alongside a normal modern VF, with hypervisor
>>> combining these to create a transitional device.
>> Exactly, but what I meant here is
>>
>> If we decide to use the admin vq, is there any good reason to tie it
>> to PCI if we don't want to tunneling PCI over adminq?
>>
>> Why not simply invent individual commands to access legacy facilities
>> like commands to access like what transport virtqueue did for modern
>> device?:
>>
>> 1) device features
>> 2) driver features
>> 3) queue address
>> 4) queue size
>> 5) queue select
>> 6) queue notify
>> 7) device status
>> 8) ISR status
>> 9) config msix
>> 10) queue msix
>> 11) device configuration space
>>
>> It focuses on the facilities instead of transport specific details
>> like registers (we don't even need legacy registers in this case), I
>> gives more deterministic behavior so we don't need to care about the
>> cross registers read/write.
> This needs thought, it is definitely more work.  Effort that could be
> maybe spent on new features.  What is the motivation
> here? supporting legacy mmio guests?


Probably. It tries to make legacy transport independent, and it's the 
way that how transport virtqueue want to be.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

