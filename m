Return-Path: <virtio-dev-return-14280-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67162C47422
	for <virtio-dev@archiver.kernel.org>; Mon, 29 Jan 2024 06:39:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C05922AF89
	for <virtio-dev@archiver.kernel.org>; Mon, 29 Jan 2024 06:39:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A4D26986872
	for <virtio-dev@archiver.kernel.org>; Mon, 29 Jan 2024 06:39:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 88880983F75; Mon, 29 Jan 2024 06:39:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 78CA0986870
	for <virtio-dev@lists.oasis-open.org>; Mon, 29 Jan 2024 06:39:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706510353; x=1707115153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYeb+OH2qe6fMf4XQ/Nljtlt3l4/tSy9S/76bBZB700=;
        b=pu/wstHk1kJEol05ZEA2QrexdhdqHefFOw2Esd50fdiRlurH7wC2hkKLJfqEHFYvvF
         BBbXvnVR2ONosMtMZ8P+MMULrLSidUHKtKcrKA3iWlTIOgXHJwZpOxgyBrMtXbMPsPUl
         rTI3CG8zd/QGmCrqwc+FRRR38MdSvlLFqEYQ6BCA2Dok4DF0qnr6kEhV9wjpfBMy8UDZ
         +LFkNgLh/SCoYiO7YQad2Xg11BnCIPl1ExiY9bPX69nwpUdne0CP4OzJurO6N6L0dXaa
         rsAblbTB4PBlQNbGtyU2HyRHlrh44DPPaLn63D9MS9KcB7NaoMZhmebVcyOxzLIMgm+W
         PDYw==
X-Gm-Message-State: AOJu0YwAkvD4fhfxY4Vd5whU55CrY2ez9k1beCp05M9zaVUl/V0bxWdQ
	u9i5sOpTw0Vsjbkb2WqmcCMkZ7NDUSW/psYTy4Fhyj+7JJksnjIzODzqYf9X2bs=
X-Google-Smtp-Source: AGHT+IG1RlzICcSgDxtlmC2LbhU4LwqCj/TOnOCSgXomv+Ila8IpJ9Qu9TfGh+pEUU91PnCpRFzO1Q==
X-Received: by 2002:a62:f207:0:b0:6db:e6b9:4d21 with SMTP id m7-20020a62f207000000b006dbe6b94d21mr1509406pfh.4.1706510353710;
        Sun, 28 Jan 2024 22:39:13 -0800 (PST)
Date: Mon, 29 Jan 2024 12:09:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Message-ID: <20240129063911.kqqi4hfxhxoyt2i6@vireshk-i7>
References: <20240104130129.17823-1-Harald.Mommer@opensynergy.com>
 <20240104130129.17823-3-Harald.Mommer@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104130129.17823-3-Harald.Mommer@opensynergy.com>
Subject: [virtio-dev] Re: [RFC PATCH v2 2/3] virtio-spi: Add virtio-spi.h (V10 draft
 specification).

On 04-01-24, 14:01, Harald Mommer wrote:
> From: Harald Mommer <harald.mommer@opensynergy.com>
> 
> Add virtio-spi.h header for virtio SPI. The header file is compliant to
> the virtio SPI draft specification V10.
> 
> Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
> ---
>  include/uapi/linux/virtio_spi.h | 185 ++++++++++++++++++++++++++++++++
>  1 file changed, 185 insertions(+)
>  create mode 100644 include/uapi/linux/virtio_spi.h
> 
> diff --git a/include/uapi/linux/virtio_spi.h b/include/uapi/linux/virtio_spi.h
> new file mode 100644
> index 000000000000..d56843fcb2ec
> --- /dev/null
> +++ b/include/uapi/linux/virtio_spi.h
> @@ -0,0 +1,185 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */
> +/*
> + * Copyright (C) 2023 OpenSynergy GmbH
> + */
> +#ifndef _LINUX_VIRTIO_VIRTIO_SPI_H
> +#define _LINUX_VIRTIO_VIRTIO_SPI_H
> +
> +#include <linux/types.h>
> +#include <linux/virtio_types.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_config.h>

Maybe keep them in alphabetical order. Looks good otherwise.

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

