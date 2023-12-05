Return-Path: <virtio-dev-return-14116-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E2FC07E97
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 09:20:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 814BE2A835
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 09:20:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7654D98664F
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 09:20:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6741198645D; Tue,  5 Dec 2023 09:20:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48761986458
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Dec 2023 09:20:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768001; x=1702372801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r89z295gg+ziSr15+xMFG9e3Z/J9EOhPdZz/7Z4rOPI=;
        b=rZR/J5KHKM4EoEHMlGN6JEbKFU4GOmqsomh0LLRjoAwCWGWNfVbqyHHiRvLNIlQhFi
         hOs267NNvhZgCN8uaiLuvbro1O99S5tK9Avz8A06sn8FGivxb7eiMm3vAV2dhQXcHeGN
         JjHT4MIZyS4/EG5+HfwiUHAgzYfDCDAa9Uhdpk0ucms8UNYNBDUmyAX46hTKjdFM/Nl0
         o3sUl4SmWYielj8mLWfN5n3mLUkU/XRhbhDfiiPLqSbAUg5zYPfqIkobSTXKqIhN7xj7
         vxDUiT37jDzO9ZK0vnq8b72tGycfbBo5lPu0sTZNDtRDLIcOgdtdDC56Wug7Fpy1q64r
         6LPw==
X-Gm-Message-State: AOJu0YxzAl6QN+0UpeGwpsuoLBVllFX2Px9In7OBKw5SYC1rJubb7iF3
	hYI+IDaBcjHiMmX/NpKEd9Ut5g==
X-Google-Smtp-Source: AGHT+IGuX4dLDVnHO6GDvd3to0Y7OnbWJKI9lyg5e3zcbUbWd93A9gOz/yElos+LkPO19VHXQDtA8w==
X-Received: by 2002:a05:6a20:914a:b0:18c:95f1:20bf with SMTP id x10-20020a056a20914a00b0018c95f120bfmr7295084pzc.47.1701768001421;
        Tue, 05 Dec 2023 01:20:01 -0800 (PST)
Date: Tue, 5 Dec 2023 14:49:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	cohuck@redhat.com, harald.mommer@opensynergy.com,
	broonie@kernel.org, qiang4.zhang@linux.intel.com,
	quic_ztu@quicinc.com
Message-ID: <20231205091958.uqzw4lcqmmdkfpzq@vireshk-i7>
References: <20231205082401.18111-1-quic_haixcui@quicinc.com>
 <20231205082401.18111-3-quic_haixcui@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205082401.18111-3-quic_haixcui@quicinc.com>
Subject: Re: [virtio-dev][PATCH V8 2/2] virtio-spi: add the device
 specification

On 05-12-23, 16:24, Haixu Cui wrote:
> The Virtio SPI (Serial Peripheral Interface) device is a virtual
> SPI controller that allows the driver to operate and use the SPI
> controller under the control of the host.
> 
> This patch adds the specification for virtio-spi.
> 
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

