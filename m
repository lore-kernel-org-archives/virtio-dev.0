Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070F719D074
	for <virtio-dev@lists.linux.dev>; Thu, 25 Jul 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916689; cv=none; b=Rqzpm22WlaNtQgujwzcf36D/0gxjvs0kbqJGh9yeUenqMZgqfaYlHimx1RvyUCVD1gh9vh5DUFukvyfgsLe57zG/iF30Pyd8KLB8iOAyYK9816Ifa07LHY87IdTXp2qvA82PU9hsZKuiB+T57QFJlhriFAr5Vkj6FX+/SK63lyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916689; c=relaxed/simple;
	bh=o+d3VCUm+XiAK3Nsbsy5WUA3R0e+3/oHGpriSysq0og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kN92vBALmsjEteeT5EVjqosUxkDSSeWHrE7IQNsJi9hYqF1yVp9Oxy2xBZs+S5VHRDUyfAfzXXoNG+EoEDRgLrXH4dAiV1ciIuUB0Y9/29zz10xiQbw5K+o9q4lXn3861dwQ0q/cIIQovW/0nC/jVMK0d2aaO9VBKVlQ1LLgwaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIRE/muf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIRE/muf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721916687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+7qqjfSJJedkSM0ho4FvwKX/Ww1MNIJK3ukt4D885M=;
	b=TIRE/mufZdCghlu9Z1l1CGMvcUwJgr2twMFFGVvqQWj9Od+Gbphn7F1BDPsyqc6sCT2eO+
	sTyL6nSvIj2QIgyAGd6EbqL+yTNoNPE8EdFsqje71PcVBLq80+lP/QCHeAu/NiSzKz24Lm
	PGD/oxj0T+snHqWwtrtEL+oKaJzP9GI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-JJ1MU2TqPDGaUG15Rqs6YQ-1; Thu, 25 Jul 2024 10:11:25 -0400
X-MC-Unique: JJ1MU2TqPDGaUG15Rqs6YQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4279418eb2bso6835555e9.1
        for <virtio-dev@lists.linux.dev>; Thu, 25 Jul 2024 07:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721916684; x=1722521484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+7qqjfSJJedkSM0ho4FvwKX/Ww1MNIJK3ukt4D885M=;
        b=tdGYo6cxfpagJ8OYAHzw2b1vI58m8E7AJ9ioYCWF+VWUAicPiclgtXBqHcO7jS4fzN
         LyAtKBpqMUaA5tjGf3fNF69aIcZtPp1vjw1otrffbV7gOLQTCx4tH1yG3lgJaC9vU94X
         8pQAI91aWa+1mzZ4EU4X2x7BLlRGbjxNocQAL5BV5x2ZbkRB8nfMreJC/30st5n0Fqff
         G01RGBhfL7UcFw0cjRQou4x00zqUh+cbl/zA98KTq2MfwWK7TV8SFBPCjLHwyBUS+M8f
         m4x+s8dSJvirxcPWiu+/rgHfq8AOg1ZqDIzEtSZGKVKos98i33RP24jco19pF4HV2fp6
         0a4w==
X-Forwarded-Encrypted: i=1; AJvYcCUnDGG3F4PJPSEkb1wcUrufR7xNmwOdJpZb05zihW/uro+GfxYMwPbKaLYdSoxvhl+HeEXbxXC1MdKfHoMTruRe0Wn2YQCk7JDbIQ==
X-Gm-Message-State: AOJu0YzmGxblbycSX+A0Gnu3AEjVCnIKL8iBZisgdOSCH/K67hLHD1sP
	sb2167bpQAgjFshYMX8Dl/jOv3wdWFdKvNUGvcxIvzmJGUQZB+azsJ9JoJjyg/6E5zD+jLfIPL+
	eQKmh0McrgLlkvXFML+nAOrL2nkoZnhPrN0cJBtkQ3Hi07X6Bwu1XTpdbsG4=
X-Received: by 2002:a05:600c:138a:b0:426:6320:226a with SMTP id 5b1f17b1804b1-4280548fb4cmr18426295e9.15.1721916684228;
        Thu, 25 Jul 2024 07:11:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNsRboMyhKaoJYp9kK8awnKz/IQ2dhEpvJdwFDL7IFTPJdpWaM7Aqb1Bj5iTJbBTmDrGoXmQ==
X-Received: by 2002:a05:600c:138a:b0:426:6320:226a with SMTP id 5b1f17b1804b1-4280548fb4cmr18425765e9.15.1721916683628;
        Thu, 25 Jul 2024 07:11:23 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:81aa:776c:8849:e578:516a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057a6307sm37266205e9.36.2024.07.25.07.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 07:11:23 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:11:18 -0400
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
Message-ID: <20240725100351-mutt-send-email-mst@kernel.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
 <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
 <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
 <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
 <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2024 at 02:50:50PM +0100, David Woodhouse wrote:
> Even if the virtio-rtc specification were official today, and I was
> able to expose it via PCI, I probably wouldn't do it that way. There's
> just far more in virtio-rtc than we need; the simple shared memory
> region is perfectly sufficient for most needs, and especially ours.

I can't stop amazon from shipping whatever in its hypervisor,
I'd just like to understand this better, if there is a use-case
not addressed here then we can change virtio to address it.

The rtc driver patch posted is 900 lines, yours is 700 lines, does not
look like a big difference.  As for using a memory region, this is
valid, but maybe rtc should be changed to do exactly that?
E.g. we can easily add a capability describing such a region.
or put it in device config space.

I mean yes, we can build a new transport for each specific need but in
the end we'll get a ton of interfaces with unclear compatibility
requirements.  If effort is instead spent improving common interfaces,
we get consistency and everyone benefits. That's why I'm trying to
understand the need here.

-- 
MST

