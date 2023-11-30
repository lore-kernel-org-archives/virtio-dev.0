Return-Path: <virtio-dev-return-14083-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF54C4167B
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 04:13:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AD1782AF76
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 04:13:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F01198666B
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 04:13:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 914B1986669; Thu, 30 Nov 2023 04:13:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7C4C5986668
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Nov 2023 04:13:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701317594; x=1701922394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWtZgA3nu53R7A42unkUv/I07a8KBKJ4js7mw+kZz2Q=;
        b=v1pFhPH5Jd83AbCd2yBI1Cfzm5uReI9lcXhvsEpLaGwWbY88wSolWYy7YhwrPuVfHZ
         LdGMkAckSu396R+5MwQwEenH1vQA9wQZCo00fcZ0pPzMcY8z31mtS6aGpxFjz9AyDFRJ
         2mZ6jxG8mg/ItZ+z0m5qgw/iY0z62GvO8NqSUQsgQ/IYVm3vt0TbqGbyt1YzbMt3aees
         +2JTy4L25xXuwzLd6dGov795cBdGmGyluTbwIHoQXxfC172JKOZOEzRkw61OX3XnqnmQ
         urjT43+fkeMi4sdw2upafj+uVIs2RBXfP6pEJU9rLvfPIyRc0egZDXNhGkEsdoRJ/8/h
         hwxg==
X-Gm-Message-State: AOJu0YwoddLiC3asRW8B/mzyyMsgfSGpSuCibvifcrstyzarUpEcSuWV
	8NrOVysq7N7+Xcp3SyLF3IfGRA==
X-Google-Smtp-Source: AGHT+IGrBsyglmFw93JCly//zw3xWrM49pjQS47QAwpf94OUnoDX57t86yeJWk73bp/OtiFRbvktrA==
X-Received: by 2002:a05:6a20:160b:b0:18c:3ec:5ad5 with SMTP id l11-20020a056a20160b00b0018c03ec5ad5mr23146619pzj.57.1701317593839;
        Wed, 29 Nov 2023 20:13:13 -0800 (PST)
Date: Thu, 30 Nov 2023 09:43:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Haixu Cui <quic_haixcui@quicinc.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org, harald.mommer@opensynergy.com,
	broonie@kernel.org, qiang4.zhang@linux.intel.com,
	quic_ztu@quicinc.com, alex.bennee@linaro.org,
	vincent.guittot@linaro.org
Message-ID: <20231130041311.3azypbxfoujkwhj7@vireshk-i7>
References: <20231127101750.6xmthho6lnppyw3k@vireshk-i7>
 <2ca987a6-eeb2-4ed6-9a12-10ae450eb4bf@quicinc.com>
 <20231129073022.ohxsfuawambvh3hm@vireshk-i7>
 <0674be8e-221f-479a-8da2-8a3e59e45bb9@quicinc.com>
 <871qc9x8k2.fsf@redhat.com>
 <9e0c5e5e-db7b-4634-9423-f4db1800b148@quicinc.com>
 <20231129100002.q73wtz6mkfixcbzt@vireshk-i7>
 <5367c2e6-93f1-4a4d-867e-0074b452052a@quicinc.com>
 <20231129113417.7kb6my3mm67zal3q@vireshk-i7>
 <87y1egwx27.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1egwx27.fsf@redhat.com>
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] [PATCH v5] virtio-spi: add the device
 specification

On 29-11-23, 13:42, Cornelia Huck wrote:
> On Wed, Nov 29 2023, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > On 29-11-23, 18:31, Haixu Cui wrote:
> >> Hi Viresh,
> >> 
> >>     Thank you for your helpful comments. In next patch, I will clearly point
> >> this out:
> >
> > Great, finally we are on the same page. Thanks Haixu.
> >
> >>     "For full-duplex read and write transfer, both \field{tx_buf} and
> >> \field{rx_buf} are used and the buffer size of \field{tx_buf} must be same
> >> as \field{rx_buf}."
> >
> > Suggest rewriting as:
> >
> > In full-duplex transfer mode, both \field{tx_buf} and \field{rx_buf} are sent by
> > the driver, \field{tx_buf} followed by \field{rx_buf}. The length of both the
> > buffers MUST be same.
> 
> Is that in a non-normative section? (Sorry, I've lost track here...)

I think yes, though I am not sure where Haixu will put it eventually :)

> If
> so, I would say:
> 
> "The length of both buffers has to be the same."

That's better. Thanks.

> > device MUST fail the transfer and notify the driver.
> 
> "notify the driver" == "set an appropriate error value"?
> 
> Can this be covered by one of the existing error values?

I think yes, this can be handled by the Param error.

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

