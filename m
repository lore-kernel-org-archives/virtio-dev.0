Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA64213DDB5
	for <virtio-dev@lists.linux.dev>; Thu, 25 Jul 2024 05:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721886866; cv=none; b=WdDtCpKtLX4tU83yQGFraVkCZAF0nbsIT0UWDH76VGEMxUA561vK0c8p5t0csws1pBGaRFOnxAW5gdHGXvQjYhM9QAPBW7m5uTUIcfr0guIOW1Yv5ScNkmyBYbTHkFhGyKBhtsHwtyFa6diiYm0p2+fSOvuwPnpWED6RDk0CakA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721886866; c=relaxed/simple;
	bh=gAZvwL67v0vt6xsxrH6XS/itsYUgy+inKlxURoSIcdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qT3xh3lV6rvKVduvtRFQFdnvSlfhticSSL+YvY7v/A2HhxoAb5yf4JwTfAkom1ZkDWd6VJA+ySnpcWB8NmRisbanpkY2W9JYJE9Q/F9MN2/EXP85laZVw5A+6161Wn6q/6tnncfDtZhqoCo1fEl+J4NeXPV/FHfyw3dW94+iKvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9q65Gng; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9q65Gng"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721886863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dh3yyuBj9HXf2A5cEfYqf0NaFgetwfgWSnefr6wKli8=;
	b=G9q65GngDlTuwmB6LFkNOqQUyEw6nY3fm2EmV/GzIPUMXs2tl7QMiA1qUTxfXk5RSnT52E
	FVsuR8ezoxEJpBNHvj33s42MZBSLd0Hq2widp/pDlD+ZOrGtP7rHuv3niCc4PZqGelfFA3
	e9eE0QRsDkZGrvOeWXrzXcsljXirmEw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-NaSGjVuZNQ-HsHfyF71aKg-1; Thu, 25 Jul 2024 01:54:21 -0400
X-MC-Unique: NaSGjVuZNQ-HsHfyF71aKg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3679ab94cdbso334507f8f.3
        for <virtio-dev@lists.linux.dev>; Wed, 24 Jul 2024 22:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721886860; x=1722491660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh3yyuBj9HXf2A5cEfYqf0NaFgetwfgWSnefr6wKli8=;
        b=gDtIyUsbQzw0JBFc4gXtvrWavNY6xlp+lVVdxRyNS0LfIfbjxnWN3wwA2hN+ShtorT
         Q08xtf0rIeMfKZCQ3n9hb2yRdeNGlQI3dNWnT5i4MugQm614eotDWeIB2HLYvFPEIppQ
         PVm7UAi8XIVDP1ByZhFE67O/NTFXsIDfGKEvXZxPva2J51jOIIaf+FCWy2j/Zhgess8w
         lrGFGfiyFN2l9QPQzl4EKiXQg47nO3rfucueiLtWm2jnVwQsB6FUQx/0OApWvXSwaZ/7
         sTKc682f7LjDql3K5wqzhS+UBDBn6dHv8lq0U3TwSqHwPSnYzVto8iENxnbubAmuSxYk
         f92g==
X-Forwarded-Encrypted: i=1; AJvYcCVD+7haxbnF+k5STADcZfR7dQmdeKrOLF7RrKpBGBgrLFc6dhR7LlX1+B4D9lIyTEpyASWwC2yqkVnmAGLm7WiKF6F4m2bml1TIXA==
X-Gm-Message-State: AOJu0YwbGJSqu6sspLot2JrUK/TnUeK4NwwDqlOEaB/hqMpe04LJE9Sd
	/PA0hx2UVNcZ0fbHHHs/qz7tlPy8MpNYJ2KwPfUoyBJh55qHbyvn0eP3RMnvtLAbJuny2TYoga0
	TXdRucT6JFMPHgPJzTfMDUcfqzNPg9dE41cOgEtSAp1leiYiqGgmMVXE5AQg=
X-Received: by 2002:a05:6000:1942:b0:368:3038:8290 with SMTP id ffacd0b85a97d-36b36421ac8mr707586f8f.39.1721886860524;
        Wed, 24 Jul 2024 22:54:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI3Abal444WmsilGMojUOB9llheQDVQUaMgG30HCOZkmwXntXo9Fy/JkeXGpR8m6xgr9AF9A==
X-Received: by 2002:a05:6000:1942:b0:368:3038:8290 with SMTP id ffacd0b85a97d-36b36421ac8mr707561f8f.39.1721886859582;
        Wed, 24 Jul 2024 22:54:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:8427:35e3:731c:3106:ee46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857dcesm900105f8f.85.2024.07.24.22.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 22:54:18 -0700 (PDT)
Date: Thu, 25 Jul 2024 01:54:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
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
Message-ID: <20240725015120-mutt-send-email-mst@kernel.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 24, 2024 at 06:16:37PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The vmclock "device" provides a shared memory region with precision clock
> information. By using shared memory, it is safe across Live Migration.
> 
> Like the KVM PTP clock, this can convert TSC-based cross timestamps into
> KVM clock values. Unlike the KVM PTP clock, it does so only when such is
> actually helpful.
> 
> The memory region of the device is also exposed to userspace so it can be
> read or memory mapped by application which need reliable notification of
> clock disruptions.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

one other thing worth mentioning is that this design can't work
with confidential computing setups. By comparison, mapping e.g. a
range in a PCI BAR would work for these setups.
Is there a reason this functionality is not interesting for
confidential VMs?

-- 
MST

