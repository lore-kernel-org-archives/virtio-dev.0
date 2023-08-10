Return-Path: <virtio-dev-return-13507-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82566C001B0
	for <virtio-dev@archiver.kernel.org>; Thu, 10 Aug 2023 22:21:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B1C4E41A09
	for <virtio-dev@archiver.kernel.org>; Thu, 10 Aug 2023 22:21:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 91B369865E9
	for <virtio-dev@archiver.kernel.org>; Thu, 10 Aug 2023 22:21:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7814C985E68; Thu, 10 Aug 2023 22:21:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 614779865CA
	for <virtio-dev@lists.oasis-open.org>; Thu, 10 Aug 2023 22:21:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691706094; x=1692310894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZrfSuXre9u+lYlanUQCl4BfiMM0OVDT04Rg6kJSu2U=;
        b=IWy2TBb9I4gd94ZOYbKXaeSvy0dMMmx3aOsuvTr1CCAuRclAnm8xbl9NT9h6FvkCa5
         BWyBXlIsHH832qupT6gzX4uNt0UAzm945rYanKrsLzbmAiZbZEOBXO+6iz/d+ZHNPir5
         gg3kFT7ZIBUUXNw2LnUCkUsBHYNRNOihJkT80NZQcIgYUy/4ptz+EzxSVPlDOaiE1slk
         HRGfNFGmT+zT5pZ15timMRfemN2Pn6F6qJ/dboELNwkjbswOkrmiebUv/pUQtoS2oPGK
         m/nN7WK0u4KlElhaiDJEmuYtOvtwTfLQeykz/ym6U4YwStErmP/B4S/e6ii9/gSLIoHa
         I9Jw==
X-Gm-Message-State: AOJu0YyGM14a5svlV5F8+Ar4jklPlaLzCdBve3/YQaMdd6cLbR3gqOLs
	/DdvDuWiliDAreCfq5WxbSJn4w==
X-Google-Smtp-Source: AGHT+IEk0MrhL5N0Bad2+/htrNPTkiGWI76YLI5r+Orf2fTeM5RaY48h81HImClrirsPVQlDQapKpw==
X-Received: by 2002:a17:902:9893:b0:1bd:1b89:2c67 with SMTP id s19-20020a170902989300b001bd1b892c67mr71606plp.65.1691706093680;
        Thu, 10 Aug 2023 15:21:33 -0700 (PDT)
Message-ID: <96d8b628-3f21-40de-ab2e-20e6043dc937@daynix.com>
Date: Fri, 11 Aug 2023 07:21:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtio-comment@lists.oasis-open.org, eric.auger@redhat.com,
 virtio-dev@lists.oasis-open.org,
 Zide Chen <zide.chen@intel.corp-partner.google.com>, crosvm-dev@chromium.org
References: <20230803153238.541803-1-jean-philippe@linaro.org>
 <20230803153238.541803-5-jean-philippe@linaro.org>
 <ca33f633-26ea-b254-a75d-3bbf86d15d24@daynix.com>
 <20230810151036.GA1901900@myrica>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230810151036.GA1901900@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH 4/4] virtio-iommu: Clarify hot-unplug behavior

On 2023/08/11 0:10, Jean-Philippe Brucker wrote:
> On Fri, Aug 04, 2023 at 03:19:27PM +0900, Akihiko Odaki wrote:
>> On 2023/08/04 0:32, Jean-Philippe Brucker wrote:
>>> Since it is not obvious what the virtio-iommu device or driver should do
>>> when an endpoint is removed [1], add some guidance in the specification.
>>> Follow the same principle as other (hardware) IOMMU devices: clearing
>>> endpoint ID state on endpoint removal is the responsibility of the
>>> driver, not the IOMMU device.
>>>
>>> On most hardware IOMMU devices, the endpoint ID state is kept in tables
>>> managed by the driver, so intuitively the driver should be updating the
>>> tables on hot-unplug, so that a new endpoint plugged later with the same
>>> ID does not inherit stale translations. Besides, hardware IOMMUs have no
>>> knowledge of endpoint removal. It is less obvious for virtio-iommu
>>> because endpoint states are managed with ATTACH/DETACH requests, and a
>>> virtual platform could in theory update the endpoint state when it is
>>> removed. Existing VMMs like QEMU don't do it, and rightly expect the
>>> driver to manage endpoint ID state like with other IOMMUs. It is not
>>> invalid for a VMM to clean up state on endpoint removal, but a driver
>>> shouldn't count on it.
>>
>> I think it's better to say it's invalid to detach on endpoint removal.
> 
> It's certainly not a clear cut choice and I'm still hesitating whether we
> should allow, deny or let the VMM choose what to do.
> 
> However, it looks like crosvm already detaches the domain when an endpoint
> is unplugged:
> 
> https://github.com/google/crosvm/blob/e8b2cd080e8174948563567d395c2a42416f2807/devices/src/virtio/iommu/sys/unix.rs#L68
> 
> If I understood correctly, this function is called on PCIe hot-unplug, and
> endpoint_map represents the domain attached to an endpoint ID. So the
> domain is detached on endpoint removal. If a DETACH request is sent
> afterwards, it will still succeed (detach_endpoint() in
> devices/src/virtio/iommu.rs returns detached=true, which causes DETACH to
> succeed, even if the endpoint is not in endpoint_map). But I could be
> wrong as I'm not familiar with crosvm or rust.
> 
> That does make the decision a little easier, because if we did
> retroactively specify that detaching on removal is invalid, this code
> would become a bug. But in my opinion crosvm isn't doing anything wrong
> here. It feels valid and even good practice to clean up all state
> associated to an endpoint when it is removed, to avoid leaks and stale
> objects.

In this case I think it's creating use-after-free hazard. The guest 
believes it is managing domains and assume a domain is available until 
it makes a DETACH request for the last endpoint attached to the domain.

However, if the host automatically detaches an endpoint from a domain 
and if the domain has no other endpoints, the domain will be gone and 
the domain ID may be reused for another domain. If the guest makes a 
request with the stale domain ID before it becomes aware that the device 
is unplugged, the request will be performed on some arbitrary domain and 
may break things.

By the way, crosvm's logic to detach endpoint on removal looks incorrect 
for me. A domain may have several endpoints attached, but the code looks 
like it's always destroying a domain whether there are other endpoints 
attached to the domain. I'm adding Zide Chen, who wrote the code 
according to git blame, and crosvm-dev@chromium.org to CC.

Regards,
Akihiko Odaki

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

