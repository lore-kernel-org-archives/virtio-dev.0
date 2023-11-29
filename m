Return-Path: <virtio-dev-return-14081-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA19C4167B
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Nov 2023 11:35:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8468F163E4D
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Nov 2023 11:35:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 53F35986667
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Nov 2023 11:35:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 39364986646; Wed, 29 Nov 2023 11:35:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F1987986642
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Nov 2023 11:34:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701257660; x=1701862460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzSW52z0J1r9u58ZV+HTu+fjNvnbZstrohfCQ1pjh9I=;
        b=aQe7hVy3M9tn3zODcdL+9yk/BYWntTCt/nNxPJBUa/aElMgdBTZDEgCKdQSdPQsAJQ
         VbVElNdAW5eGDkHH+vu0NsBLx5J8BWGGQ/17luWlsyDOvcZNixl98PMqhKxBur6UPKPU
         6TiTQnpWNq5BmYxOb0EaLC6nY9uPhOKKEdEKqQWG7U/Dp7nKtNB01n8Ic5X4CMJQNspE
         qVZSXuMBAJfMlOVgrpozOXG7nqKAuOlXLf8ovrCTlHu6yhvmpEaqbKpSaZPMrDJTxLzn
         OLxUbE52/oUVCWhbaxa9agjyjDDcMRMLEPP5SuIVdodZ8tOR/bk/wYQACUegnn/pgiX7
         tHfw==
X-Gm-Message-State: AOJu0Yy8+Ijr4MokOprJ4A/abX7tKIUJ/I5rqxeY0UE1x4qEcuOan3yv
	ypvUS+Q0buk37/jPozDKMm/n3A==
X-Google-Smtp-Source: AGHT+IEUPJyukT43/15wzH47UF7krxvq0TQ6ZhEfCckrhX3iJYtO5lN7Z1IUbi08ArGwyJSuymJy6Q==
X-Received: by 2002:a17:903:234c:b0:1cf:cb27:3aa5 with SMTP id c12-20020a170903234c00b001cfcb273aa5mr13203610plh.5.1701257660499;
        Wed, 29 Nov 2023 03:34:20 -0800 (PST)
Date: Wed, 29 Nov 2023 17:04:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org, harald.mommer@opensynergy.com,
	broonie@kernel.org, qiang4.zhang@linux.intel.com,
	quic_ztu@quicinc.com, alex.bennee@linaro.org,
	vincent.guittot@linaro.org
Message-ID: <20231129113417.7kb6my3mm67zal3q@vireshk-i7>
References: <20231124072015.12655-1-quic_haixcui@quicinc.com>
 <20231127101750.6xmthho6lnppyw3k@vireshk-i7>
 <2ca987a6-eeb2-4ed6-9a12-10ae450eb4bf@quicinc.com>
 <20231129073022.ohxsfuawambvh3hm@vireshk-i7>
 <0674be8e-221f-479a-8da2-8a3e59e45bb9@quicinc.com>
 <871qc9x8k2.fsf@redhat.com>
 <9e0c5e5e-db7b-4634-9423-f4db1800b148@quicinc.com>
 <20231129100002.q73wtz6mkfixcbzt@vireshk-i7>
 <5367c2e6-93f1-4a4d-867e-0074b452052a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5367c2e6-93f1-4a4d-867e-0074b452052a@quicinc.com>
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] [PATCH v5] virtio-spi: add the device
 specification

On 29-11-23, 18:31, Haixu Cui wrote:
> Hi Viresh,
> 
>     Thank you for your helpful comments. In next patch, I will clearly point
> this out:

Great, finally we are on the same page. Thanks Haixu.

>     "For full-duplex read and write transfer, both \field{tx_buf} and
> \field{rx_buf} are used and the buffer size of \field{tx_buf} must be same
> as \field{rx_buf}."

Suggest rewriting as:

In full-duplex transfer mode, both \field{tx_buf} and \field{rx_buf} are sent by
the driver, \field{tx_buf} followed by \field{rx_buf}. The length of both the
buffers MUST be same.

>     And in drivernormative section, I will add a requirement:
>     "For full-duplex transfer, Virtio SPI driver MUST guarantee the write
> transfer size is equal to the read transfer size"

Maybe:

drivernormative:

In full-duplex transfer mode, the Virtio SPI driver MUST guarantee that the
length of both \field{tx_buf} and \field{rx_buf} are same.

devicenormative:

In full-duplex transfer mode, the Virtio SPI device MUST verify that the length
of both \field{tx_buf} and \field{rx_buf} are same. In case of any mismatch, the
device MUST fail the transfer and notify the driver.

>     In fact, in my prototype, I only perform the transfers with same tx/rx
> length.

Great.

Thanks.

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

