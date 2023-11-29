Return-Path: <virtio-dev-return-14079-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D69BC4167B
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Nov 2023 10:00:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D91FA4454A
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Nov 2023 10:00:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AF3D0986644
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Nov 2023 10:00:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8BE259865EB; Wed, 29 Nov 2023 10:00:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6A5EE98663F
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Nov 2023 10:00:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701252005; x=1701856805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6i+IBX1n1d4i3lENtWCxvP4EawLelczrPAeQYx35Xcg=;
        b=JNpmfrHADMQZ6cLTzQlbbBvpxHnJ/Na+ayA36zDy8tbOoDq1dHMiWKHbwNefbZIWKv
         IJWqgB9yU/MUFXS7/O2/6Uvo4tkfE2yW6q7YLAf5XrROYlyofpw0c9R10jcT8Nd9YdUb
         gBBnyfBXl0O+4Z1WxsSrI/B46UqmEFwVwArAyzADKYjrC1p1Mt0AlA7dsKkT+G9zk5e4
         sbn1FsLaA+sdacPXVTU6TAIg+wCj7fYaDVxqrogRw5enu/2oY/HH4j+R8ImRAqrr/Pjm
         Q1fmSXb+DSTI/jm0FBh9SPAcB5/wOjY/YcLw1C9bn0EQ3YHNEI+k/1dskVHeecvEwkkV
         WsmQ==
X-Gm-Message-State: AOJu0YxBP2rr8lNJpMmRY/bUxonT+7T4a8u+K7cOBE16OU4E4efAtnWw
	a7DLbaPNzWMWMhvRtvyiDLobsA==
X-Google-Smtp-Source: AGHT+IHHrsbhZ3apxm1WaYEWmzLWX7OBqB5BTAT6eP4ql6YtJd8FDEORuOygGuwz5IMVu3wRbmXKpg==
X-Received: by 2002:a17:902:724a:b0:1cf:d2c3:2865 with SMTP id c10-20020a170902724a00b001cfd2c32865mr8960256pll.40.1701252005276;
        Wed, 29 Nov 2023 02:00:05 -0800 (PST)
Date: Wed, 29 Nov 2023 15:30:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org, harald.mommer@opensynergy.com,
	broonie@kernel.org, qiang4.zhang@linux.intel.com,
	quic_ztu@quicinc.com, alex.bennee@linaro.org,
	vincent.guittot@linaro.org
Message-ID: <20231129100002.q73wtz6mkfixcbzt@vireshk-i7>
References: <20231124072015.12655-1-quic_haixcui@quicinc.com>
 <20231127101750.6xmthho6lnppyw3k@vireshk-i7>
 <2ca987a6-eeb2-4ed6-9a12-10ae450eb4bf@quicinc.com>
 <20231129073022.ohxsfuawambvh3hm@vireshk-i7>
 <0674be8e-221f-479a-8da2-8a3e59e45bb9@quicinc.com>
 <871qc9x8k2.fsf@redhat.com>
 <9e0c5e5e-db7b-4634-9423-f4db1800b148@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e0c5e5e-db7b-4634-9423-f4db1800b148@quicinc.com>
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] [PATCH v5] virtio-spi: add the device
 specification

On 29-11-23, 16:54, Haixu Cui wrote:
> On 11/29/2023 4:33 PM, Cornelia Huck wrote:
> > On Wed, Nov 29 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:
> > > On 11/29/2023 3:30 PM, Viresh Kumar wrote:
> > > > On 28-11-23, 20:58, Haixu Cui wrote:
> > > > > On 11/27/2023 6:17 PM, Viresh Kumar wrote:
> > > > Hmm, I worked with a SPI controller over a decade ago, and I must be forgetting
> > > > something here I guess. But from whatever little I remember, with full-duplex
> > > > transfer, data flows on both MOSI and MISO lines as soon as clock signal is
> > > > applied.  And so amount of data sent is always be equal to amount of data
> > > > received by both sides.
> > > > 
> > > > Also if I see Linux's implementation of the `struct spi_transfer` [1], I see
> > > > `tx_buf`, `rx_buf` and a single `len` field, which applies to both the buffers.
> > > > Which I guess is indicating that both buffers are supposed to be of same length.
> > > > 
> > > > What am I missing ?
> > > 
> > > Oh so sorry for that. And I don't make it clear. Yes, tx_buf and rx_buf
> > > have the same size, Linux has such restriction. Just as you mention,
> > > kernel level spi_transfer has single "len", the same for
> > > spi_ioc_transfer passed from the userland.
> > > 
> > > But I am not sure if this is in the scope of the spec. Because this is
> > > ensured by Linux, but Virtio SPI driver won't also can't verify this.
> > > This is a prerequisite for virtio spi processing requests.

I don't think this is a Linux only thing. This is how the SPI protocol is
designed to begin with. A clock is applied, data from FIFOs of both master and
slaves gets exchanged over the MOSI and MISO lines... And the length is _always_
the same. We are talking about the full-duplex mode of the hardware here and
this is how it works AFAICT.

So the spec should clearly point this out to avoid any mistakes. Or if you have
a usecase where you can have different lengths for tx and rx buffers, that I am
not aware of ?

> > > What is your suggestion? How about adding some descriptions here, like
> > > "for full-duplex, tx_buf and rx_buf are same in size, this is guaranteed
> > > by the kernel"?
> > 
> > We must not really make any assumptions in the spec about concrete
> > implementations (here, the Linux kernel), as someone implementing it in
> > a different environment will need to make explicit choices.

I agree. I pointed this out since this is how the protocol works.

> > So, if tx_buf and rx_buf are required to be of the same size, it needs
> > to be explicitly stated in the spec, or an implementation might choose
> > to do it differently.

--
Viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

