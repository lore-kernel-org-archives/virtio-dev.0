Return-Path: <virtio-dev-return-12205-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3595C77B6C
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 11:02:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D2DEB2AEF2
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 11:01:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BFC259865FA
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 11:01:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ADF0F986360; Thu, 13 Apr 2023 11:01:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D2A69865F8
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Apr 2023 11:01:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681383718; x=1683975718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=or7wHY2yF8FKhqgQ0JlTfQUwpZSpEvdswbCSilx9uV8=;
        b=eXEwQdXvkzUapS8IREkXpT//6ratteuU3D1yGZ+nsTwJyjZT3jVrL+h0TI8ygKprRD
         6smEyXTpDm2UJGHG5legZkUAv1eIN5ejSnXKaL2QNVNGuZ9k7ubJ0TK93GFycW0At+NP
         n0vt/yp0UkymDcTudNpa1IKjGCgfBoXuV/Yb66T3KLMToO4crY7JfGOb0ucV3lMM04X/
         ouBz3XI95JfXdii/gqswitqPKAcjkRAuJEZLgPRAX+i58IZlLrMXe0RUZzJmxSZjWxDb
         HTja6H4B0u9lPjtw5LkFZztEqhLy0/AswtCd7dktk2BjOKPIMCi7UbOn39QlykxR5KIG
         FfBw==
X-Gm-Message-State: AAQBX9cPX7aN1kQfY6r/U85phyy7gANSFJ17Hz/tX9PojeOEypeGWy80
	oMFVLzlVtvMUBqUW2Svnv27Dqw==
X-Google-Smtp-Source: AKy350bETWVt0Dg1mDlAGsdQqS/IKqY3EbnbZLkprpNyZAo1j/klHs8mBY+NPYETOP+ZrGUteY/wKA==
X-Received: by 2002:a05:6a20:e20:b0:db:f682:65ed with SMTP id ej32-20020a056a200e2000b000dbf68265edmr1745809pzb.61.1681383717723;
        Thu, 13 Apr 2023 04:01:57 -0700 (PDT)
Message-ID: <c6fb5a06-aa7e-91f9-7001-f456b2769595@daynix.com>
Date: Thu, 13 Apr 2023 20:01:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>, virtio-dev@lists.oasis-open.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org
References: <15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com>
 <20230413104041.GA3295191@myrica>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230413104041.GA3295191@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: virtio-iommu hotplug issue

On 2023/04/13 19:40, Jean-Philippe Brucker wrote:
> Hello,
> 
> On Thu, Apr 13, 2023 at 01:49:43PM +0900, Akihiko Odaki wrote:
>> Hi,
>>
>> Recently I encountered a problem with the combination of Linux's
>> virtio-iommu driver and QEMU when a SR-IOV virtual function gets disabled.
>> I'd like to ask you what kind of solution is appropriate here and implement
>> the solution if possible.
>>
>> A PCIe device implementing the SR-IOV specification exports a virtual
>> function, and the guest can enable or disable it at runtime by writing to a
>> configuration register. This effectively looks like a PCI device is
>> hotplugged for the guest.
> 
> Just so I understand this better: the guest gets a whole PCIe device PF
> that implements SR-IOV, and so the guest can dynamically create VFs?  Out
> of curiosity, is that a hardware device assigned to the guest with VFIO,
> or a device emulated by QEMU?

Yes, that's right. The guest can dynamically create and delete VFs. The 
device is emulated by QEMU: igb, an Intel NIC recently added to QEMU and 
projected to be released as part of QEMU 8.0.

> 
>> In such a case, the kernel assumes the endpoint is
>> detached from the virtio-iommu domain, but QEMU actually does not detach it.
>>
>> This inconsistent view of the removed device sometimes prevents the VM from
>> correctly performing the following procedure, for example:
>> 1. Enable a VF.
>> 2. Disable the VF.
>> 3. Open a vfio container.
>> 4. Open the group which the PF belongs to.
>> 5. Add the group to the vfio container.
>> 6. Map some memory region.
>> 7. Close the group.
>> 8. Close the vfio container.
>> 9. Repeat 3-8
>>
>> When the VF gets disabled, the kernel assumes the endpoint is detached from
>> the IOMMU domain, but QEMU actually doesn't detach it. Later, the domain
>> will be reused in step 3-8.
>>
>> In step 7, the PF will be detached, and the kernel thinks there is no
>> endpoint attached and the mapping the domain holds is cleared, but the VF
>> endpoint is still attached and the mapping is kept intact.
>>
>> In step 9, the same domain will be reused again, and the kernel requests to
>> create a new mapping, but it will conflict with the existing mapping and
>> result in -EINVAL.
>>
>> This problem can be fixed by either of:
>> - requesting the detachment of the endpoint from the guest when the PCI
>> device is unplugged (the VF is disabled)
> 
> Yes, I think this is an issue in the virtio-iommu driver, which should be
> sending a DETACH request when the VF is disabled, likely from
> viommu_release_device(). I'll work on a fix unless you would like to do it

It will be nice if you prepare a fix. I will test your patch with my 
workload if you share it with me.

Regards,
Akihiko Odaki

> 
>> - detecting that the PCI device is gone and automatically detach it on
>> QEMU-side.
>>
>> It is not completely clear for me which solution is more appropriate as the
>> virtio-iommu specification is written in a way independent of the endpoint
>> mechanism and does not say what should be done when a PCI device is
>> unplugged.
> 
> Yes, I'm not sure it's in scope for the specification, it's more about
> software guidance
> 
> Thanks,
> Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

