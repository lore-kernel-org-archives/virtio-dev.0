Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183971991DC
	for <virtio-dev@lists.linux.dev>; Thu, 25 Jul 2024 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925515; cv=none; b=Pb9djNG/ti488jeyyVxvJkSmaStCjv/BTnPNVSUOoInkiwLGwu8k4Hijxm2EAT6sxmG8Q0qUjUM5cgq5ORbsm8B/S6ys5JNf3WzRMFjwagWrhWEXhta4IrHTYLDvTJa5CIlIety0qUgCbitVnCAUWAscwRCfpaLKGOeqh+4Hql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925515; c=relaxed/simple;
	bh=DFJqdzFltqvFCb7O3HVaF7UJ9yWxMML3AVCrY79j1ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=V2dzCDmO0KJ2DVAUQVoI+K0KxmD7PsmJXzxqn+ezwx5ehs8pSRUDbtL7ALkVLxhDuvqhaaGGGdcgJbLSuXJuGzLXEOR01rmEXBRW5p7QGt1xg065uMx1rJzBHAyiTbifQh0orH58AeqIHWtjBxEm+d/diHb1UHHVy4SiaeqI6wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPnlixS3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPnlixS3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721925512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmhpMaKw4X5CZZDMzXoNDtyzrmJbLZhDy7YR6GMuBto=;
	b=YPnlixS3yb0Ytg/Pj+J02qAjhMR93ouMfbmllveLSQegeYZ+4OBIK21GVHcG2eoIY0Qd6c
	YbdyD6cv01ZYf5e50vQnGx0rQK2yclkvdzL3R32FZ9KLdbUwk16RMLcTnN8yMy0oxM5yAK
	e8D+chMOwuFUTcnNhPsfv06pAfzCAjA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-LTHnr32UMuWd6WHxIokCkA-1; Thu, 25 Jul 2024 12:38:30 -0400
X-MC-Unique: LTHnr32UMuWd6WHxIokCkA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36b356a73fcso610861f8f.1
        for <virtio-dev@lists.linux.dev>; Thu, 25 Jul 2024 09:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721925509; x=1722530309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmhpMaKw4X5CZZDMzXoNDtyzrmJbLZhDy7YR6GMuBto=;
        b=vl3j4pwOB0LuJoXn3qfS4J16oV3GoGPR45Y/i8zMoCOllbxUw8mofl3MHFsRCtmQr6
         yTUjq6FsQFrkWkE31e39USWVdQ/ek42YoSchqrkuRQPNSlrFBXRfR/REFDHm1FOtoZkZ
         t7+KPdhSfLIh31UQq7xFFJ/V/QYb4RDvqosiTBeD+av0tsTwEgo5jwj7ROH7mocGG9Up
         bc/Amr9ZmZis2XvhMZr/fAf7Kt16VDaXLrdotc9IvI6YsIobhekZCRUIQ7MRPcCfTCUy
         WcI+u7ujLihhgvZEm/vOAdFHCzutxihaPLbXnGDerNdPS6dziMXyv4VpjiAK9fVkhICn
         em8g==
X-Forwarded-Encrypted: i=1; AJvYcCWFiWd0AeWtTvUq3tCEDW6gYD4fDLYRkFjOiEgRo+aoGS3Xkrfmj1S1pAg8hD9kRUrvCYo8R4b/snTCcyTu4GagD4CTHbJYea6gzw==
X-Gm-Message-State: AOJu0YyMAy4QQeY/5un50qUfi641h9ajKDNC123r/XZhrOEvjp9OthGc
	mZYkGt8zxjC1WMx/KgENXigfm9OmnR1Ob2W2DG3n37rO1ckiHTstgz7R7yMSRUjcJ92tEPjvNbN
	JJp7LfSeadryLtliJZcWvuk2tXWEou16klQ7SyCnpGnWNTdP1IFgw+uN7Dvg=
X-Received: by 2002:adf:ed47:0:b0:368:7f8f:ca72 with SMTP id ffacd0b85a97d-36b364443d0mr1823935f8f.29.1721925509557;
        Thu, 25 Jul 2024 09:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVkxqW5ZWpJzphEm72RP12t9yKD8nLEmAUKvkzy8Xw/le9MV4rpuQJkrCb/1ZIHocRHb/ATg==
X-Received: by 2002:adf:ed47:0:b0:368:7f8f:ca72 with SMTP id ffacd0b85a97d-36b364443d0mr1823895f8f.29.1721925508498;
        Thu, 25 Jul 2024 09:38:28 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:81aa:776c:8849:e578:516a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857fdesm2828283f8f.75.2024.07.25.09.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 09:38:27 -0700 (PDT)
Date: Thu, 25 Jul 2024 12:38:23 -0400
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
Message-ID: <20240725122603-mutt-send-email-mst@kernel.org>
References: <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
 <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
 <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
 <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240725100351-mutt-send-email-mst@kernel.org>
 <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jul 25, 2024 at 04:18:43PM +0100, David Woodhouse wrote:
> On Thu, 2024-07-25 at 10:11 -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 25, 2024 at 02:50:50PM +0100, David Woodhouse wrote:
> > > Even if the virtio-rtc specification were official today, and I was
> > > able to expose it via PCI, I probably wouldn't do it that way. There's
> > > just far more in virtio-rtc than we need; the simple shared memory
> > > region is perfectly sufficient for most needs, and especially ours.
> > 
> > I can't stop amazon from shipping whatever in its hypervisor,
> > I'd just like to understand this better, if there is a use-case
> > not addressed here then we can change virtio to address it.
> > 
> > The rtc driver patch posted is 900 lines, yours is 700 lines, does not
> > look like a big difference.  As for using a memory region, this is
> > valid, but maybe rtc should be changed to do exactly that?
> 
> I'm certainly aiming for virtio-rtc to include that as an *option*,
> because I think I don't think it makes sense for an RTC specification
> aimed at virtual machines *not* to deal with the live migration
> problem.
> 
> AFAICT the only ways to deal with the LM problem are either to make a
> hypercall/virtio transaction for *every* clock read which needs to be
> accurate, or expose a memory region for the guest to do it "vDSO-
> style".

virtio can support the second option, we already have
VIRTIO_PCI_CAP_SHARED_MEMORY_CFG, I'd just use it.


> And similarly, unless we want guest userspace to have to make a
> *system* call every time, that memory region needs to be mappable all
> the way to userspace.

This part is classic for pci, mapping pci bar has been well
studied.


> The use case isn't necessarily for all users of gettimeofday(), of
> course; this is for those applications which *need* precision time.
> Like distributed databases which rely on timestamps for coherency, and
> users who get fined millions of dollars when LM messes up their clocks
> and they put wrong timestamps on financial transactions.

I would however worry that with all this pass through,
applications have to be coded to each hypervisor or even
version of the hypervisor.

I don't really know the use-case well enough - is sending
an interrupt to linux and having linux create a device
independent structure not workable?


> > E.g. we can easily add a capability describing such a region.
> > or put it in device config space.
> 
> I think it has to be memory, not config space. But yes.

virtio config space, which is just a region in a BAR.
But yes, maybe VIRTIO_PCI_CAP_SHARED_MEMORY_CFG is cleaner.

> The intent is that my driver would be usable with the shared memory
> region from a virtio-rtc device too. It'd need a tiny amount of
> refactoring of the discovery code in vmclock_probe(), which I haven't
> done yet as it would be premature optimisation. 
> 
> > I mean yes, we can build a new transport for each specific need but in
> > the end we'll get a ton of interfaces with unclear compatibility
> > requirements.  If effort is instead spent improving common interfaces,
> > we get consistency and everyone benefits. That's why I'm trying to
> > understand the need here.
> 
> It's simplicity. Because this isn't even a "transport". It's just a
> simple breadcrumb given to the guest to tell it where the information
> is.
> In the fullness of time assuming this becomes part of virtio-rtc too,
> the fact that it can *also* be discovered by ACPI is just a tiny
> detail. And it allows hypervisors to implement it a *whole* lot more
> simply.
> 
> The addition of an ACPI method to enable the timekeeping does make it a
> tiny bit more than a 'breadcrump', I concede — but that's still
> basically trivial to implement. A whole lot simpler than a full virtio
> device.

virtio has been developed with the painful experience that we keep
making mistakes, or coming up with new needed features,
and that maintaining forward and backward compatibility
becomes a whole lot harder than it seems in the beginning.

-- 
MST

