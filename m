Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B2553362
	for <virtio-dev@lists.linux.dev>; Sun, 28 Jul 2024 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722180246; cv=none; b=YbYcLmNMqRLw2HNf+eGN7WTdiafBXyr4J52oTI2K3QN71vQxXm/TPFqj+IMuovazsOoKlqTVahVSyf4V6xURxLs1YeUgXvaPi6c+YgmI0CDS8GvvDdX0hjzWGd0tysb5LN8mmZ6YjcJy7qL2BXXCgMkvRHZsZDIDhEa+Vmf4BWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722180246; c=relaxed/simple;
	bh=IOwAsnqgHoluJc7mNb67jddHNZA6RYbBXNw2KHo1ji0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ADztPz6xJFa9k4Pq3I/F80jT9VJpU14xuH17sWtL6KHv1H0v+S0V3Zq5lnj4IoiZ3iiq/gSqccaGzYmAqYrz3tUjIAGPTbqA82Dobk3Pcv91psF50zeeRKYqQesik7Ol9at5PSBd3f+kl7e6xmlfaiSE/LaOCx87uaU83HU59xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tb0hsyG0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tb0hsyG0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722180244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5bC7CjlZdsdHI4lvHiT2ExOZBWJ7XMhmuhfoptCNZqw=;
	b=Tb0hsyG0Ykxd/u9oGSARFjCxaaW/j9aIWXR3zS+gePZN/w/pNSmiATtLaHx1LRUKOVc/Vq
	S73v2lxYdzkDHhEAm90CXXOYBpAG7BWfL3PcmP1a9ICBS+tTMH55iM16KU7AbazSuc3K0f
	fyqGxHWjbGN5UstlLkEEF9zEQb6eO00=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-OCBapXJQOQ-ymrpiGQu4Sg-1; Sun, 28 Jul 2024 11:24:00 -0400
X-MC-Unique: OCBapXJQOQ-ymrpiGQu4Sg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f0276170f9so25168751fa.2
        for <virtio-dev@lists.linux.dev>; Sun, 28 Jul 2024 08:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722180239; x=1722785039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bC7CjlZdsdHI4lvHiT2ExOZBWJ7XMhmuhfoptCNZqw=;
        b=RK1hy1hCjPf2dtMBgCwK51dZHdkJTYIS+A2vQ3CMjY6yUZWYDhS15W/XXJ2VmZ/aM5
         NU3yB9Uiqdt40R4yLUgz6gwGbpNWuj390adcL/9bBCbrW6+hLdsCo/lfTDnQ4+53uEWU
         uLXIYUe/xqzHfPKuzvAve0/WhuKLkpXQQX6dvMctVtlhkjsy6VplTajfyKJb1qzBOHGv
         q7ooRPj31Dx6ezW2wFjxvnQurkMfEymWoWci4UHPvCWWufa5XankkSy/dH+RVmY8azLX
         S3SijKRO8LFubqCmnbAdiNH5OOlIob1hhks/GOiSscxtvDMr/eCnrHE7whnMVRLQ05n1
         IDRw==
X-Forwarded-Encrypted: i=1; AJvYcCU0lcke9EXv3NxF06BnMMuXn9L+o+ecmW0YUFo7sSbceod5PIWlX5qXd8E5wfFC6oOJrVbSK4shF8O1h2VtaNNKALxwYnGHQj7IeA==
X-Gm-Message-State: AOJu0YzVI1MvSQrKyvH9+VfzLeBj5Ll7JDXxErR55mbVsHS/9SxzY/0A
	Rqc0LdEakqkvqnn7JJb+I9R5PwxkSiwivIjBu6wHacLcvd73JR5OvGaa0qkOhQG+913WRcpPlPV
	crcoVE5WohZ2CFPuQsCg2jGLs97/L1lzL7Yy/YQbfiEmevl/oNhRdbr4/los=
X-Received: by 2002:a2e:be22:0:b0:2ef:1c0a:9b94 with SMTP id 38308e7fff4ca-2f12edfddc0mr34329321fa.16.1722180238922;
        Sun, 28 Jul 2024 08:23:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU13tBt+N37F7ob3Jx0ruuvo8+dsNp9muZtzaqjHOl31gS3qTrnO0jECcjoxvWesNrjNQyHQ==
X-Received: by 2002:a2e:be22:0:b0:2ef:1c0a:9b94 with SMTP id 38308e7fff4ca-2f12edfddc0mr34329181fa.16.1722180238084;
        Sun, 28 Jul 2024 08:23:58 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:98c4:742e:26be:b52d:dd54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428054b9196sm147521925e9.0.2024.07.28.08.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 08:23:57 -0700 (PDT)
Date: Sun, 28 Jul 2024 11:23:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Peter Hilber <peter.hilber@opensynergy.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	"Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
	"Luu, Ryan" <rluu@amazon.com>,
	"Chashper, David" <chashper@amazon.com>,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	"Christopher S . Hall" <christopher.s.hall@intel.com>,
	Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
	netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] ptp: Add vDSO-style vmclock support
Message-ID: <20240728111746-mutt-send-email-mst@kernel.org>
References: <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
 <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
 <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240726174958.00007d10@Huawei.com>
 <811E8A25-3DBC-452D-B594-F9B7B0B61335@infradead.org>
 <20240728062521-mutt-send-email-mst@kernel.org>
 <9817300C-9280-4CC3-B9DB-37D24C8C20B5@infradead.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9817300C-9280-4CC3-B9DB-37D24C8C20B5@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 28, 2024 at 02:07:01PM +0100, David Woodhouse wrote:
> On 28 July 2024 11:37:04 BST, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >Glad you asked :)
> 
> Heh, I'm not sure I'm so glad. Did I mention I hate ACPI? Perhaps it's still not too late for me just to define a DT binding and use PRP0001 for it :)
> 
> >Long story short, QEMUVGID is indeed out of spec, but it works
> >both because of guest compatibility with ACPI 1.0, and because no one
> >much uses it.
> 
> 
> I think it's reasonable enough to follow that example and use AMZNVCLK (or QEMUVCLK, but there seems little point in both) then?

I'd stick to spec. If you like puns, QEMUC10C maybe?

