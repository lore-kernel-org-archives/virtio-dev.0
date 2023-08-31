Return-Path: <virtio-dev-return-13590-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CD5C83F2F
	for <virtio-dev@archiver.kernel.org>; Thu, 31 Aug 2023 08:30:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 51926780E6
	for <virtio-dev@archiver.kernel.org>; Thu, 31 Aug 2023 08:30:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2E19998655D
	for <virtio-dev@archiver.kernel.org>; Thu, 31 Aug 2023 08:30:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1623E98408C; Thu, 31 Aug 2023 08:30:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F3E19986546
	for <virtio-dev@lists.oasis-open.org>; Thu, 31 Aug 2023 08:30:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693470640; x=1694075440;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hbe+7E0ZUpGb8+DmjEOUMRwyxF3swPKGVxGWg0XWsi0=;
        b=VpSZRXgOdTWHegYw/0fHY7wyFJx3eHi36XlOAkDdjurjnw8ewWdXyWMOhi/PEL5YSD
         MmnPtz3B3CBx2dxPJ4kdPFUwcT+Muf43SWcXaXnleiC7xVvayiIGWcTTHUM8oZbB09yP
         p7v9ao6Ih6RqRS5QzFCdG+JNPtVG2DkCEtTWEAE+/y/TxRgSpDw4SWUH1EqceVSq29r4
         FrxpDt0b8arvt0O0xL87zBbFeykcg9fRCOZJw8wt2OxbLyHS8RgOLzR+moMpUTSfxZe8
         FM6OfBNBubSmUfKD874L06rVx/b0eX0v2Rc9GauP9vd2m+4J8c+/KJ9IKCqGTdO+NxjF
         VGJQ==
X-Gm-Message-State: AOJu0Yx8ZNP9d48s50lLqBxXUxB7cjHYNKfqKA18aKmpBXZFAo9UTEsT
	xrHMcviTc0n7GKgpq+vkAAqQ2A==
X-Google-Smtp-Source: AGHT+IH0u1KaJnZOl4WEHEupdFXPoTkdI8acXe/NRuoBzZY04AP+7xd1ZonMqgOIMFkZJIQue+1Ktg==
X-Received: by 2002:a9d:6181:0:b0:6bc:dbbf:47be with SMTP id g1-20020a9d6181000000b006bcdbbf47bemr4813821otk.26.1693470640481;
        Thu, 31 Aug 2023 01:30:40 -0700 (PDT)
Message-ID: <747ba9a2-07f1-451b-b052-b51b95da1b2b@daynix.com>
Date: Thu, 31 Aug 2023 17:30:37 +0900
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
 <b7b62822-4371-4a47-bc28-25a0b0ef92c5@daynix.com>
 <20230814112502.GA37241@myrica>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230814112502.GA37241@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH 4/4] virtio-iommu: Clarify hot-unplug behavior

On 2023/08/14 20:25, Jean-Philippe Brucker wrote:
> On Sat, Aug 12, 2023 at 03:25:10PM +0900, Akihiko Odaki wrote:
>>>> By the way, crosvm's logic to detach endpoint on removal looks incorrect for
>>>> me. A domain may have several endpoints attached, but the code looks like
>>>> it's always destroying a domain whether there are other endpoints attached
>>>> to the domain. I'm adding Zide Chen, who wrote the code according to git
>>>> blame, and crosvm-dev@chromium.org to CC.
>>>
>>> Link to this thread for more context:
>>> https://lore.kernel.org/virtio-dev/20230803153238.541803-5-jean-philippe@linaro.org/
>>>
>>> I thought crosvm rejected attaching multiple endpoints to one domain but I
>>> think I misread. Rejecting multiple attach would be a straightforward fix
>>> (it's allowed by the spec), though it would prevent assigning endpoints
>>> that cannot be isolated from each others by the hardware (the driver won't
>>> attach those to different domains, if it's made aware that they should be
>>> in the same IOMMU group, for example if they are on a conventional PCI
>>> bus).
>>
>> Now we figured out an endpoint should not be detached from a domain without
>> a request from the driver anyway so the code to detach an endpoint can be
>> simply removed.
> 
> Yes, but I think the other detach path, when handling ATTACH or DETACH
> requests, doesn't support domains with multiple endpoints attached either:
> 
>      // Currently, we only support detaching an endpoint if it is the only endpoint attached
>      // to its domain.
> 
> But the ATTACH handler seems to accept attaching multiple endpoints to the
> same domain?
> 
> Thanks,
> Jean

We saw no response from crosvm people for a few weeks so I opened an 
issue on their bug tracker for heads-up:
https://issuetracker.google.com/u/1/issues/298297288

Regards,
Akihiko Odaki

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

