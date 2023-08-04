Return-Path: <virtio-dev-return-13463-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE91C001DE
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 06:20:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 13FDC75326
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 06:20:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by host09.ws5.connectedcommunity.org (Postfix) with QMQP
	id F2D3E2AFF8; Fri,  4 Aug 2023 06:20:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5137E9866DF
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Aug 2023 06:19:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691129970; x=1691734770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vh7Kn76Vl2nApBRFfyThko6XyKP+dLz5xy23+JITAg=;
        b=Mj8bdcep/h+BjWzQT35VNKDFcgEquHq70dgVQxu5okWnP90pLi3T2MczjKZaGEBHaH
         rh4tQ4mHozdJToimT+YoFZ8BHPUe/k4/K8OwVuubQp6WF15zkJFuE+vlOdXQj9w11OAD
         2yBOJdOeZnMlPiQmqdQL9ZELkDzcCr8T9EfouoiJItQ2/sEXWL7qpKClQLPvSUmhxCf7
         K7sRn/huofJSMtoLUawJOryZ+pQdyP/F4mZZpPMFOGMWdtF3vjm7eaFPpIqZqZtux+FV
         ZOqWZL7LfQhyFOaD0wBGcYn1/Dejg7e/rGa1/Mc0SaxjEG99jhzgA+zM4uNQaLl/EFoO
         7Epg==
X-Gm-Message-State: AOJu0YxaOxE4x365dP+YMK4KdZxJH1R+/1F6chlg/AE1FUEBkzNCBJjP
	jNA0YKzXWrEp8d469VRzX1QZIw==
X-Google-Smtp-Source: AGHT+IFpRjWIn5ofe1+jwAVESz/x9fUkKpfMbUUYahomyJ1TOwpW7O8WKFZ7HtWOjdshEw3yx4D60g==
X-Received: by 2002:a05:6a21:338b:b0:132:ce08:1e28 with SMTP id yy11-20020a056a21338b00b00132ce081e28mr1422579pzb.22.1691129970365;
        Thu, 03 Aug 2023 23:19:30 -0700 (PDT)
Message-ID: <ca33f633-26ea-b254-a75d-3bbf86d15d24@daynix.com>
Date: Fri, 4 Aug 2023 15:19:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 virtio-comment@lists.oasis-open.org
Cc: eric.auger@redhat.com, virtio-dev@lists.oasis-open.org
References: <20230803153238.541803-1-jean-philippe@linaro.org>
 <20230803153238.541803-5-jean-philippe@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230803153238.541803-5-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH 4/4] virtio-iommu: Clarify hot-unplug behavior

On 2023/08/04 0:32, Jean-Philippe Brucker wrote:
> Since it is not obvious what the virtio-iommu device or driver should do
> when an endpoint is removed [1], add some guidance in the specification.
> Follow the same principle as other (hardware) IOMMU devices: clearing
> endpoint ID state on endpoint removal is the responsibility of the
> driver, not the IOMMU device.
> 
> On most hardware IOMMU devices, the endpoint ID state is kept in tables
> managed by the driver, so intuitively the driver should be updating the
> tables on hot-unplug, so that a new endpoint plugged later with the same
> ID does not inherit stale translations. Besides, hardware IOMMUs have no
> knowledge of endpoint removal. It is less obvious for virtio-iommu
> because endpoint states are managed with ATTACH/DETACH requests, and a
> virtual platform could in theory update the endpoint state when it is
> removed. Existing VMMs like QEMU don't do it, and rightly expect the
> driver to manage endpoint ID state like with other IOMMUs. It is not
> invalid for a VMM to clean up state on endpoint removal, but a driver
> shouldn't count on it.

I think it's better to say it's invalid to detach on endpoint removal. 
Otherwise, the DETACH request made by the driver on endpoint removal 
will result in an error, which may make the driver emit an spurious 
warning. In fact, the Linux driver emits a warning if a DETACH request 
fails*

* 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/iommu/virtio-iommu.c?id=809d0810e3520da669d231303608cdf5fe5c1a70

> 
> [1] https://lore.kernel.org/all/15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com/
> 
> Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   device-types/iommu/description.tex | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/device-types/iommu/description.tex b/device-types/iommu/description.tex
> index fb1b840..63ccd41 100644
> --- a/device-types/iommu/description.tex
> +++ b/device-types/iommu/description.tex
> @@ -407,6 +407,11 @@ \subsubsection{DETACH request}
>   After all endpoints have been successfully detached from a domain, it
>   ceases to exist and its ID can be reused by the driver for another domain.
>   
> +When an endpoint is removed from the platform (for example
> +unplugged, or disabled with PCIe SR-IOV), the device is not
> +required to detach the endpoint ID from its domain. It is the
> +driver's responsibility to detach the endpoint before removal.
> +
>   \drivernormative{\paragraph}{DETACH request}{Device Types / IOMMU Device / Device operations / DETACH request}
>   
>   The driver SHOULD set \field{reserved} to zero.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

