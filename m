Return-Path: <virtio-dev-return-14098-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A03C4167B
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Dec 2023 04:32:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 224103E56C
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Dec 2023 04:32:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1ECE6986888
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Dec 2023 04:32:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1197D98669E; Fri,  1 Dec 2023 04:32:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F375498669A
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Dec 2023 04:32:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701405126; x=1702009926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrMTUi3n3IWXwZa5eA+PFZzxsM63bvwmlOED7OcwQH4=;
        b=hYKXMp57HSYKknvbkV40g+zKSmgJ2I5olN4PsWxa5Cr7+U/EGCIPCkLAhSsx48Jt6s
         9MpsttVKGlwtQnxrPHIBSIQp+MSwpDBdDUVkpDrBGhCTzWdeS6PhCPxLmktZ9goyOIiN
         bDUUt2WlFxrJSIGI0HPI8PtDSksFPCGFmnopBg6zmCWdy9bQrSVQhUy1o9rBResvmPTP
         ckYko9DW6sCrUDeJUn4r/+7pYUzMCrj1SxNxMBEZrdNO8WnRSKze/2LKvX2QafNOGLO4
         FKaa5ct2I9OG3D1dkXz9dQ7Cr0DQU1rpDKHbru/PsWrXxkK9xwEKmGNbE32YfIg7+pQ5
         gYHA==
X-Gm-Message-State: AOJu0YydUNLPDEgOZBZNWB7vHh5M1eHn7vuZmnIYEyNXTp2J9Th6//6T
	B9FQhfeFMccIJEBh8Qe1Q6XbTg==
X-Google-Smtp-Source: AGHT+IES6NnrZNzbKs95kcDqQM7WoVdH2iF+aZ46wAwRfcSUMgIMPHu4nauxNEUqMUieWOe9my5h9Q==
X-Received: by 2002:a17:90a:bc84:b0:286:2013:cfe9 with SMTP id x4-20020a17090abc8400b002862013cfe9mr10029125pjr.2.1701405126556;
        Thu, 30 Nov 2023 20:32:06 -0800 (PST)
Date: Fri, 1 Dec 2023 10:02:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	cohuck@redhat.com, harald.mommer@opensynergy.com,
	broonie@kernel.org, qiang4.zhang@linux.intel.com,
	quic_ztu@quicinc.com
Message-ID: <20231201043203.7ozpnk2k3dci4pq4@vireshk-i7>
References: <20231130092242.17303-1-quic_haixcui@quicinc.com>
 <20231130092242.17303-3-quic_haixcui@quicinc.com>
 <20231130111900.ix3cfsxlns2blp4r@vireshk-i7>
 <b26382c1-6601-44b8-8376-3f96d605f2d5@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b26382c1-6601-44b8-8376-3f96d605f2d5@quicinc.com>
Subject: Re: [virtio-dev] [PATCH V6 2/2] virtio-spi: add the device
 specification

On 01-12-23, 12:05, Haixu Cui wrote:
> Looks good. Will update as follows:
> 
> \field{tx_nbits_supported} and \field{rx_nbits_supported} indicate the
> different n-bit transfer modes supported by the device, for writing and
> reading respectively. SINGLE is always supported. A set bit here indicates
> that the corresponding n-bit transfer is supported, otherwise not:
>         bit 0: DUAL;
>         bit 1: QUAD;
>         bit 2: OCTAL;
>         other bits are reserved and must be set as 0 by the device.
> 
> Note: Transfer bit options are commonly used in SPI:

Maybe:

Note: The commonly used SPI transfer modes are:

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

