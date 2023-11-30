Return-Path: <virtio-dev-return-14092-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826A8C10DC3
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 10:05:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 88089421B9
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 10:05:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 04B1F98692C
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 10:05:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 58DF8986674; Thu, 30 Nov 2023 10:05:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0BC80986671
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Nov 2023 10:04:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701338677; x=1701943477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmv0mTnNuvTnS4PAkFOzy1Laps5jDRgNh8N9nK3sFmk=;
        b=iLbRVuddQnOTkUawGibyaiz7fXoAEGVIhUKRenxTlJzg4grXZKpfNZO6Hh76wz97Np
         bNVbtocX85ONPFX+HEdS/mOBCe6+7i3UmgRvnoX4Dtyl4RxzcKX/CCFSkirczgqrt/mm
         SSTUOy+WtOx2+6t20XSUXTYxmCnEyVebe8M6m4ylaOi3AbwkuYLPN6dWOHUPPZbUmNy7
         IY5/pw3PmnkflBsqKT9BXI/UjJ88e//54APgNvwnNlpSHmPVtl5SZU5SGGJpFvg3i+/f
         rg5DjryggfBbor8wurKU4D+Sun01mhhJKgUQjUTryFGDPG/w6jIJCYIYt6TOlNDJQl/N
         XVhg==
X-Gm-Message-State: AOJu0YznqtrN0lB8cALHE0vilrqIHHOxnegU26Xx5asR98J7uDThjfTK
	Dk3PmXyB+yU7nGotg4MXQT2u7A==
X-Google-Smtp-Source: AGHT+IF44yuyYXIAtyhL0pcPj+W7SD9+weNDVwUn+Y5DuZbFi14K+O2EMcXFQDSrsNOFU1tDWdMUWw==
X-Received: by 2002:a05:6a00:4ace:b0:6c4:e7a0:af4a with SMTP id ds14-20020a056a004ace00b006c4e7a0af4amr23753938pfb.32.1701338677470;
        Thu, 30 Nov 2023 02:04:37 -0800 (PST)
Date: Thu, 30 Nov 2023 15:34:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	cohuck@redhat.com, harald.mommer@opensynergy.com,
	broonie@kernel.org, qiang4.zhang@linux.intel.com,
	quic_ztu@quicinc.com
Message-ID: <20231130100434.4d55mvqcrhstw53n@vireshk-i7>
References: <20231130092242.17303-1-quic_haixcui@quicinc.com>
 <20231130092242.17303-2-quic_haixcui@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130092242.17303-2-quic_haixcui@quicinc.com>
Subject: Re: [virtio-dev] [PATCH V6 1/2] content: Rename SPI master to SPI
 controller

On 30-11-23, 17:22, Haixu Cui wrote:
> SPI master is an outdated term and should use SPI controller.
> 
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> ---
>  content.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/content.tex b/content.tex
> index 0a62dce..1c608eb 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -737,7 +737,7 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  44         &   ISM device \\
>  \hline
> -45         &   SPI master \\
> +45         &   SPI controller \\
>  \hline
>  \end{tabular}

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

