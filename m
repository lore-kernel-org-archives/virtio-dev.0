Return-Path: <virtio-dev-return-14279-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A15C47422
	for <virtio-dev@archiver.kernel.org>; Mon, 29 Jan 2024 06:30:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 941152AF8C
	for <virtio-dev@archiver.kernel.org>; Mon, 29 Jan 2024 06:30:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 51BC698687E
	for <virtio-dev@archiver.kernel.org>; Mon, 29 Jan 2024 06:30:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2CAE9983F75; Mon, 29 Jan 2024 06:30:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 16EC2986870
	for <virtio-dev@lists.oasis-open.org>; Mon, 29 Jan 2024 06:30:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706509850; x=1707114650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcNcTEhoIWYD8Jyza8FT+m6h2KJ7pAuMT+sHRSLuWk8=;
        b=hM+JfvgrynCwmze51tnUJO0BfQL0/dROFqBiitObSs8oQdWzw0HuIkVEH/dxDEdy2d
         faTmplElumlJTj+7E+ZWiABm0vOOgu3AFJQgKq9ukICb4yCJCFVEIKD9NgxfJnmqN0Ry
         OtZs0La+gbOC31YQVcKwXIw06tdBCrpprfT3iElDpOYKvKUaOMl2NmwNmAllkO/OTIgF
         VQobrEEmyqRG52eXcRirzqXClHsaIZE2yX2MRznnyA0asjRsDUMD/2iI/S9KkQ1upYON
         F14q3ER9d5dUK8e1v5J3jlIWzyHY8DbNB+KguYe91uBf7PxYkU5CFd+b+lMKL3oW/OIg
         EqSA==
X-Gm-Message-State: AOJu0YxrgiE502ueRsv54osbFrE3YOZ06++JeYYFV2QqIqYDu6bOCSIe
	P9eS/8CZ2/hYXXeFBow3G67X069u7bAVCg/jccvZDNJRq9f7Jj7+4uqT2tP2LSM=
X-Google-Smtp-Source: AGHT+IGh1h+05vCnmj809KQhjvUSTg1qxRaQJCyMKHLDmh1e7V1HvPMklyZdkqrrztZ7SNswfm/rew==
X-Received: by 2002:a05:6a20:7f8a:b0:19c:71bc:ec82 with SMTP id d10-20020a056a207f8a00b0019c71bcec82mr4830387pzj.48.1706509849818;
        Sun, 28 Jan 2024 22:30:49 -0800 (PST)
Date: Mon, 29 Jan 2024 12:00:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Message-ID: <20240129063047.hgnljeqq2xswoteh@vireshk-i7>
References: <20240104130129.17823-1-Harald.Mommer@opensynergy.com>
 <20240104130129.17823-2-Harald.Mommer@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104130129.17823-2-Harald.Mommer@opensynergy.com>
Subject: [virtio-dev] Re: [RFC PATCH v2 1/3] virtio: Add ID for virtio SPI.

On 04-01-24, 14:01, Harald Mommer wrote:
> From: Harald Mommer <harald.mommer@opensynergy.com>
> 
> Add #define ID VIRTIO_ID_SPI 45 for virtio SPI.
> 
> Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
> ---
>  include/uapi/linux/virtio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index 7aa2eb766205..6c12db16faa3 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -68,6 +68,7 @@
>  #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
>  #define VIRTIO_ID_BT			40 /* virtio bluetooth */
>  #define VIRTIO_ID_GPIO			41 /* virtio gpio */
> +#define VIRTIO_ID_SPI			45 /* virtio spi */

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

