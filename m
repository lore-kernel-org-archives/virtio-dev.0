Return-Path: <virtio-dev-return-14100-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAEFC4167B
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Dec 2023 05:44:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9D69F2236F
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Dec 2023 05:44:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 78478986842
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Dec 2023 05:44:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5C99698669A; Fri,  1 Dec 2023 05:44:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4CC0F98669D
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Dec 2023 05:44:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701409446; x=1702014246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRYwALF9WS2lUzi44MPib+ioLc/DdbV1vmaRK9fsULI=;
        b=HcQhXlt8qYyD2iimSCUFli4OShpk+tzHF9+8K0h4bO/SmBQDMgpHcEYW9L+vWTRJV/
         JfY0bv/uvYLGAAPErbQtW/uzKEZ/2mPlyIZm//ONOQtBDyyJlZ4gokpO5VXlBVfN3Mkg
         +gXljjIUbr97G9YObFazTM5LhyYHvSJHekoSpOyG8IB51asbVP1rfZunryFbXtzR9JWX
         wevkdox0OepIgmegvo22iJt4j4kPYLRwMJ/yPlD7JWIxqAoeaHLMKv8KYiBpmi5FqSxZ
         lPIw2s4ueIcP2bdPDFsaR41tKpa0cAEFogkZZfp0xYwgQVgTHDEtM+bD+9I+nxpxsL4z
         h5Ag==
X-Gm-Message-State: AOJu0Yz5eGBtzrxoUs9rh8KkFncaqMYK+f+Zv2cX1KtIesMnIZznsTBe
	mQBzJFBWoxTN9pHv3vpJBqoDqA==
X-Google-Smtp-Source: AGHT+IEZYQvcg3GaGsUs+qmLMAVXzEuT66aUk5/8tGelt61bKarfdHokgPWXVW8eiq0qajnfX9wipA==
X-Received: by 2002:a17:902:bf09:b0:1cf:fca9:80b3 with SMTP id bi9-20020a170902bf0900b001cffca980b3mr9487110plb.33.1701409445794;
        Thu, 30 Nov 2023 21:44:05 -0800 (PST)
Date: Fri, 1 Dec 2023 11:14:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	cohuck@redhat.com, harald.mommer@opensynergy.com,
	broonie@kernel.org, qiang4.zhang@linux.intel.com,
	quic_ztu@quicinc.com
Message-ID: <20231201054403.kpykp6g7kggxsgyo@vireshk-i7>
References: <20231130092242.17303-1-quic_haixcui@quicinc.com>
 <20231130092242.17303-3-quic_haixcui@quicinc.com>
 <20231130111900.ix3cfsxlns2blp4r@vireshk-i7>
 <b26382c1-6601-44b8-8376-3f96d605f2d5@quicinc.com>
 <20231201043203.7ozpnk2k3dci4pq4@vireshk-i7>
 <bd50a1e1-75ab-41c3-9fdd-9cfbeb13034e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd50a1e1-75ab-41c3-9fdd-9cfbeb13034e@quicinc.com>
Subject: Re: [virtio-dev] [PATCH V6 2/2] virtio-spi: add the device
 specification

On 01-12-23, 13:35, Haixu Cui wrote:
> Hi Viresh,
> 
>     SPI transfer modes here may cause misunderstanding, in Wikipedia, SPI
> mode is the combinations of clock polarity and clock phases:
> 
> 
> https://en.wikipedia.org/w/index.php?title=Serial_Peripheral_Interface&action=edit&section=4

The word 'mode' is indeed confusing. It is used for combinations of PHA/POL,
half/full duplex, n-bit transfers, etc..

>     What about updating as: "Note: The commonly used SPI n-bit transfer
> options are:"

That's fine too.

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

