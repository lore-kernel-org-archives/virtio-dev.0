Return-Path: <virtio-dev-return-13509-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680AEC0015E
	for <virtio-dev@archiver.kernel.org>; Sat, 12 Aug 2023 06:25:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9FA6E2B00E
	for <virtio-dev@archiver.kernel.org>; Sat, 12 Aug 2023 06:25:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 82C39986633
	for <virtio-dev@archiver.kernel.org>; Sat, 12 Aug 2023 06:25:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 676BC983EB5; Sat, 12 Aug 2023 06:25:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 51B089865D5
	for <virtio-dev@lists.oasis-open.org>; Sat, 12 Aug 2023 06:25:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691821513; x=1692426313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5hr6+/iogw6MwRexbJF3oZdSuwXIQ/YT5eDR+Zy51Y=;
        b=dBkPBPBIBjx1lqbvrQDo91moWFqkC2iFL9kHUb0DYFpoY/EjJhNc3Kfzv6KAQhrPYx
         VT9RPMlTSb1VbG/kWavpkp1GSUoXlnUScwkmiEGcOfIQWGINmpTxty/9X76C849i3mz2
         NYTLBrBlxtl7PvzuyuQxFydPcC/6bn+MnG2C0395i5nrlbk4NKLwHDU5CJPRMlGQLF7+
         LkL5ai6DWOV5MxD1GMI4iZFqUdJ5lEN4s5TxSkJkdF85e4RF79I9wTVwy5urPk8JbcRm
         rmDf1IKnwA5V5VmxeksbzkhSp6MU+6/vy8s1ruImGnm8EwHTCO56WKoPpRQ87acidLVg
         diIw==
X-Gm-Message-State: AOJu0YzySaFM6OTGl4cBpNPKMMLWq6g/UQGvGTo8XCXrxdS/Yu+ApG3L
	WtlWvRCEQSjnbrbvxuisiayAJg==
X-Google-Smtp-Source: AGHT+IGaCeGY4Kh4WDj122ekz0AvQfAZhH0toFamkHQIw7qIiiTtxDvnq5k7DT789792TgzUs0k1Sg==
X-Received: by 2002:a17:90a:248:b0:268:b7a2:62e8 with SMTP id t8-20020a17090a024800b00268b7a262e8mr3264717pje.7.1691821513483;
        Fri, 11 Aug 2023 23:25:13 -0700 (PDT)
Message-ID: <b7b62822-4371-4a47-bc28-25a0b0ef92c5@daynix.com>
Date: Sat, 12 Aug 2023 15:25:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtio-comment@lists.oasis-open.org, eric.auger@redhat.com,
 virtio-dev@lists.oasis-open.org,
 Zide Chen <zide.chen@intel.corp-partner.google.com>, crosvm-dev@chromium.org
References: <20230803153238.541803-1-jean-philippe@linaro.org>
 <20230803153238.541803-5-jean-philippe@linaro.org>
 <ca33f633-26ea-b254-a75d-3bbf86d15d24@daynix.com>
 <20230810151036.GA1901900@myrica>
 <96d8b628-3f21-40de-ab2e-20e6043dc937@daynix.com>
 <20230811142039.GA2189828@myrica>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230811142039.GA2189828@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH 4/4] virtio-iommu: Clarify hot-unplug behavior

On 2023/08/11 23:20, Jean-Philippe Brucker wrote:
> On Fri, Aug 11, 2023 at 07:21:29AM +0900, Akihiko Odaki wrote:
>> On 2023/08/11 0:10, Jean-Philippe Brucker wrote:
>>> On Fri, Aug 04, 2023 at 03:19:27PM +0900, Akihiko Odaki wrote:
>>>> On 2023/08/04 0:32, Jean-Philippe Brucker wrote:
>>>>> Since it is not obvious what the virtio-iommu device or driver should do
>>>>> when an endpoint is removed [1], add some guidance in the specification.
>>>>> Follow the same principle as other (hardware) IOMMU devices: clearing
>>>>> endpoint ID state on endpoint removal is the responsibility of the
>>>>> driver, not the IOMMU device.
>>>>>
>>>>> On most hardware IOMMU devices, the endpoint ID state is kept in tables
>>>>> managed by the driver, so intuitively the driver should be updating the
>>>>> tables on hot-unplug, so that a new endpoint plugged later with the same
>>>>> ID does not inherit stale translations. Besides, hardware IOMMUs have no
>>>>> knowledge of endpoint removal. It is less obvious for virtio-iommu
>>>>> because endpoint states are managed with ATTACH/DETACH requests, and a
>>>>> virtual platform could in theory update the endpoint state when it is
>>>>> removed. Existing VMMs like QEMU don't do it, and rightly expect the
>>>>> driver to manage endpoint ID state like with other IOMMUs. It is not
>>>>> invalid for a VMM to clean up state on endpoint removal, but a driver
>>>>> shouldn't count on it.
>>>>
>>>> I think it's better to say it's invalid to detach on endpoint removal.
>>>
>>> It's certainly not a clear cut choice and I'm still hesitating whether we
>>> should allow, deny or let the VMM choose what to do.
>>>
>>> However, it looks like crosvm already detaches the domain when an endpoint
>>> is unplugged:
>>>
>>> https://github.com/google/crosvm/blob/e8b2cd080e8174948563567d395c2a42416f2807/devices/src/virtio/iommu/sys/unix.rs#L68
>>>
>>> If I understood correctly, this function is called on PCIe hot-unplug, and
>>> endpoint_map represents the domain attached to an endpoint ID. So the
>>> domain is detached on endpoint removal. If a DETACH request is sent
>>> afterwards, it will still succeed (detach_endpoint() in
>>> devices/src/virtio/iommu.rs returns detached=true, which causes DETACH to
>>> succeed, even if the endpoint is not in endpoint_map). But I could be
>>> wrong as I'm not familiar with crosvm or rust.
>>>
>>> That does make the decision a little easier, because if we did
>>> retroactively specify that detaching on removal is invalid, this code
>>> would become a bug. But in my opinion crosvm isn't doing anything wrong
>>> here. It feels valid and even good practice to clean up all state
>>> associated to an endpoint when it is removed, to avoid leaks and stale
>>> objects.
>>
>> In this case I think it's creating use-after-free hazard. The guest believes
>> it is managing domains and assume a domain is available until it makes a
>> DETACH request for the last endpoint attached to the domain.
>>
>> However, if the host automatically detaches an endpoint from a domain and if
>> the domain has no other endpoints, the domain will be gone and the domain ID
>> may be reused for another domain. If the guest makes a request with the
>> stale domain ID before it becomes aware that the device is unplugged, the
>> request will be performed on some arbitrary domain and may break things.
> 
> That's an excellent point, there is a race:
> 
>          VMM                        GUEST
>       Remove ep 1
>         detach domain 1
>         destroy domain 1
>                                  ATTACH ep 2 to domain 1
>       Handle ATTACH
>         create domain 1
> 
>       Notify that ep 1 is gone
>                                  Handle notification, DETACH ep 1
> 
> The guest tries to attach ep 2 to domain 1, which succeeds. So the
> guest expects that ep 2 is now able to access the mappings that were on
> domain 1. But instead it's a new empty domain.
> 
> I think that's a good justification for adding a device normative
> statement, something like:
> 
>    The device SHOULD only detach endpoints from domains when requested by
>    the driver; either when handling ATTACH and DETACH requests or when
>    performing a device reset.
> 
>>
>> By the way, crosvm's logic to detach endpoint on removal looks incorrect for
>> me. A domain may have several endpoints attached, but the code looks like
>> it's always destroying a domain whether there are other endpoints attached
>> to the domain. I'm adding Zide Chen, who wrote the code according to git
>> blame, and crosvm-dev@chromium.org to CC.
> 
> Link to this thread for more context:
> https://lore.kernel.org/virtio-dev/20230803153238.541803-5-jean-philippe@linaro.org/
> 
> I thought crosvm rejected attaching multiple endpoints to one domain but I
> think I misread. Rejecting multiple attach would be a straightforward fix
> (it's allowed by the spec), though it would prevent assigning endpoints
> that cannot be isolated from each others by the hardware (the driver won't
> attach those to different domains, if it's made aware that they should be
> in the same IOMMU group, for example if they are on a conventional PCI
> bus).

Now we figured out an endpoint should not be detached from a domain 
without a request from the driver anyway so the code to detach an 
endpoint can be simply removed.

Regards,
Akihiko Odaki

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

