Return-Path: <virtio-dev-return-12208-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5697DC77B61
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 13:39:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7E1203309E
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 13:39:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 66AD29865FA
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 13:39:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 53FEE986360; Thu, 13 Apr 2023 13:39:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 415FE9865F8
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Apr 2023 13:39:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: s130qs3zPIO_YGiqx-yYzw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681393145; x=1683985145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLTEnlNnryDeu3bY+Efaxs2tlXR/HklE3XK0i2rSPDc=;
        b=e1jLwJwGbGXQsQuCEwydKTKfIgxa7LWJ0EZWBMkbdIQMpEZJ957N4Ipl4BFWipJj3V
         tgK3+sIurG5GVX0EsjKIvKPAepAlJ+ulS3tFGZWYeCnQ2pr9cOlEx06kDwBTYZwCp5pp
         KfXpuj18BovxmL20HDRdGdJUIOUxj4xahAyP0lB6ie1myr8z7V2T6vi7WLSQLZpO7vLZ
         oc5jvdfkyWzPaIc6mnJXUKQVVVO1RlONYv5E1fZz5WlLglw/PL+tQbfEhFl0yMum8YZ3
         bh79qznQaZPmwY9gET4Ewknk5embDX4vGOxA5HmvM5QKLLovOi+6zJoN4QVMsStiBcn0
         sycw==
X-Gm-Message-State: AAQBX9dLk2Svs0q9TaZckx6Ugtp5S8DXMVUC215JlK1qs3IxCmeSflNh
	P3Y3jswon8eTfGyOxus5bW5aNRW49VOK5Fg97FXQXthso4Mrit6vNvQqpspSZIJwAI2FLJTkn1z
	ovPv0UQp2Rs0nNzV3f//QaqO7cwsU
X-Received: by 2002:a05:6214:4110:b0:5e9:8487:3978 with SMTP id kc16-20020a056214411000b005e984873978mr2957217qvb.41.1681393145332;
        Thu, 13 Apr 2023 06:39:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZdVtpFtu0/c0su+y8jonHkVOioE5JF2htAL3D+ZJEQBGs2mlBkESWx6V18SUs3Dkk06xuIRA==
X-Received: by 2002:a05:6214:4110:b0:5e9:8487:3978 with SMTP id kc16-20020a056214411000b005e984873978mr2957192qvb.41.1681393145012;
        Thu, 13 Apr 2023 06:39:05 -0700 (PDT)
Message-ID: <9a765411-00ad-307e-9ca2-f6a7defba9cc@redhat.com>
Date: Thu, 13 Apr 2023 15:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtio-dev@lists.oasis-open.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org
References: <15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com>
 <20230413104041.GA3295191@myrica>
 <c6fb5a06-aa7e-91f9-7001-f456b2769595@daynix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <c6fb5a06-aa7e-91f9-7001-f456b2769595@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: virtio-iommu hotplug issue

Hi,

On 4/13/23 13:01, Akihiko Odaki wrote:
> On 2023/04/13 19:40, Jean-Philippe Brucker wrote:
>> Hello,
>>
>> On Thu, Apr 13, 2023 at 01:49:43PM +0900, Akihiko Odaki wrote:
>>> Hi,
>>>
>>> Recently I encountered a problem with the combination of Linux's
>>> virtio-iommu driver and QEMU when a SR-IOV virtual function gets
>>> disabled.
>>> I'd like to ask you what kind of solution is appropriate here and
>>> implement
>>> the solution if possible.
>>>
>>> A PCIe device implementing the SR-IOV specification exports a virtual
>>> function, and the guest can enable or disable it at runtime by
>>> writing to a
>>> configuration register. This effectively looks like a PCI device is
>>> hotplugged for the guest.
>>
>> Just so I understand this better: the guest gets a whole PCIe device PF
>> that implements SR-IOV, and so the guest can dynamically create VFs? 
>> Out
>> of curiosity, is that a hardware device assigned to the guest with VFIO,
>> or a device emulated by QEMU?
>
> Yes, that's right. The guest can dynamically create and delete VFs.
> The device is emulated by QEMU: igb, an Intel NIC recently added to
> QEMU and projected to be released as part of QEMU 8.0.
From below description In understand you then bind this emulated device
to VFIO on guest, correct?
>
>>
>>> In such a case, the kernel assumes the endpoint is
>>> detached from the virtio-iommu domain, but QEMU actually does not
>>> detach it.
The QEMU virtio-iommu device executes commands from the virtio-iommu
driver and my understanding is the VFIO infra is not in trouble here. As
suggested by Jean, a detach command probably is missed.
>>>
>>> This inconsistent view of the removed device sometimes prevents the
>>> VM from
>>> correctly performing the following procedure, for example:
>>> 1. Enable a VF.
>>> 2. Disable the VF.
>>> 3. Open a vfio container.
>>> 4. Open the group which the PF belongs to.
>>> 5. Add the group to the vfio container.
>>> 6. Map some memory region.
>>> 7. Close the group.
>>> 8. Close the vfio container.
>>> 9. Repeat 3-8
>>>
>>> When the VF gets disabled, the kernel assumes the endpoint is
>>> detached from
>>> the IOMMU domain, but QEMU actually doesn't detach it. Later, the
>>> domain
>>> will be reused in step 3-8.
>>>
>>> In step 7, the PF will be detached, and the kernel thinks there is no
>>> endpoint attached and the mapping the domain holds is cleared, but
>>> the VF
>>> endpoint is still attached and the mapping is kept intact.
>>>
>>> In step 9, the same domain will be reused again, and the kernel
>>> requests to
>>> create a new mapping, but it will conflict with the existing mapping
>>> and
>>> result in -EINVAL.
>>>
>>> This problem can be fixed by either of:
>>> - requesting the detachment of the endpoint from the guest when the PCI
>>> device is unplugged (the VF is disabled)
>>
>> Yes, I think this is an issue in the virtio-iommu driver, which
>> should be
>> sending a DETACH request when the VF is disabled, likely from
>> viommu_release_device(). I'll work on a fix unless you would like to
>> do it
>
> It will be nice if you prepare a fix. I will test your patch with my
> workload if you share it with me.

I can help testing too

Thanks

Eric
>
> Regards,
> Akihiko Odaki
>
>>
>>> - detecting that the PCI device is gone and automatically detach it on
>>> QEMU-side.
>>>
>>> It is not completely clear for me which solution is more appropriate
>>> as the
>>> virtio-iommu specification is written in a way independent of the
>>> endpoint
>>> mechanism and does not say what should be done when a PCI device is
>>> unplugged.
>>
>> Yes, I'm not sure it's in scope for the specification, it's more about
>> software guidance
>>
>> Thanks,
>> Jean
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

