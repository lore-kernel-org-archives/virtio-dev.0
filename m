Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4C22A1C0
	for <virtio-dev@lists.linux.dev>; Fri, 26 Jul 2024 05:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721970569; cv=none; b=f75wE50dZZjY+0TGOzESkcH2l552b5gc7IWit8RV1nn2w/hUZCyotslvxWj45O+JksbVKUN8KANfgqGjzRklrAcq39YRp+YOzt0L3fZY0JaA2CZPqJmWsEMSExek2WqUuendzqjeXEAc4PY6QeiLNshPjF0YQvj1vfbeRcuhqyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721970569; c=relaxed/simple;
	bh=mwBiyQNVoMNybA5O6D7Gx2PdVoETiCkHnYn15H6Goyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XtBRyKHtGCV10dzC12fnMjqI1lY0Hl6EFlqZMUzMWdo0tCdAJMD9z2MqEGxa9cmA9qAqN+Ghdyyb6HBgBGvb4QprmiCqKTBAGgkTJMeKqQYzeE22NKf3EIGS1c9BemcAE3o7mkIzTiYT+w2Jivu8Xl2cAa3TRMjiFWhm0fuMdQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKEukUIv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKEukUIv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721970567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DbuOgyAkRILEBrf9MJ+4blSFephMiZi+pxSKWGG3nSg=;
	b=SKEukUIvZoZ7MUftFPfDHc4zyve7FilFebcoMyg4Miqpyiq+bBQx2t5GGd73+z/AdkXcPO
	wdPyCqBQ8vi8/mKPIllf+P4uCKhdHNDvktIeNS0Wwi6YeRify4GfyQjvmyjvCuzReh08Ut
	5S+c3Xvdk9LxJj6AjN+w2eltJ8mErlc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-DRse6ODLNpqyziT6R8vYwg-1; Fri, 26 Jul 2024 01:09:25 -0400
X-MC-Unique: DRse6ODLNpqyziT6R8vYwg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280645e3e0so10769705e9.1
        for <virtio-dev@lists.linux.dev>; Thu, 25 Jul 2024 22:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721970564; x=1722575364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbuOgyAkRILEBrf9MJ+4blSFephMiZi+pxSKWGG3nSg=;
        b=TY8rwN7L0D4/CpQwK4bFFdwHsg+K/ishgbIv+aq1z3CYeIGgZReTRemVOOHFVkFiBE
         72w6h8StZo13K7v+tbMsJiVjx3zT8Z+4Y6s/p/HyFyjzJ+jnmDG3+dhPM49Xt/NtkIez
         Umxzo7uXOOmEW0tOM+VXJsMs7ME4y7FS3d7Z8b3Om1UV6vWKaAXxhhpgi1Bsr+ys+tqZ
         tWvlWMn1rDho/l5L6SQqBqhJBSir2WwDxnll9hR+4kq5YGJZMHyDR4W4AYq/26AszL4B
         +PVhRt/6vNFNwdi66VPreOHVMA4FJoNl87saP7+PhVHrJ1myDDxV21Vk4vxrPP7jSX3w
         hvTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7W342JXrlVTMIb/bGv9eNgE6GgDz7XZQHnv+YHeKFZMZExZ0dWZYT+sM6prUmT/12A5l5q9GMk/bUb+PJNP1JHQbSCf/saL35sQ==
X-Gm-Message-State: AOJu0YzFv0MkvLD8nx4fnPYNbXeNvW6Shmg3SUg5n3qXH5PoMm2K+fyy
	7nxvjqvyIxlRKwSdlpxqGzPugPxbWnnWLydskSG/qIdudIES4UHg6IQQH6+n38igxbgMCQuA1KF
	9Mamm5aH5pMaJ/lqu8mKjFpDHaVFzqYRltQrMQrZXM1mRPjotc0xyL58IZ1A=
X-Received: by 2002:a05:600c:1c1f:b0:426:6153:5318 with SMTP id 5b1f17b1804b1-4280570fe50mr29400715e9.19.1721970564587;
        Thu, 25 Jul 2024 22:09:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLGThAmioKqXVYW1bGCeFOTJCJYjUraPBu1ns0STXkcb4YEMtbOBAAif1jc1w6fYVZOAbSOQ==
X-Received: by 2002:a05:600c:1c1f:b0:426:6153:5318 with SMTP id 5b1f17b1804b1-4280570fe50mr29400405e9.19.1721970563829;
        Thu, 25 Jul 2024 22:09:23 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f93e6871sm105269105e9.30.2024.07.25.22.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 22:09:23 -0700 (PDT)
Date: Fri, 26 Jul 2024 01:09:13 -0400
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
Message-ID: <20240726010511-mutt-send-email-mst@kernel.org>
References: <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240725100351-mutt-send-email-mst@kernel.org>
 <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
 <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
 <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2024 at 10:29:18PM +0100, David Woodhouse wrote:
> > > > Then can't we fix it by interrupting all CPUs right after LM?
> > > > 
> > > > To me that seems like a cleaner approach - we then compartmentalize
> > > > the ABI issue - kernel has its own ABI against userspace,
> > > > devices have their own ABI against kernel.
> > > > It'd mean we need a way to detect that interrupt was sent,
> > > > maybe yet another counter inside that structure.
> > > > 
> > > > WDYT?
> > > > 
> > > > By the way the same idea would work for snapshots -
> > > > some people wanted to expose that info to userspace, too.
> 
> Those people included me. I wanted to interrupt all the vCPUs, even the
> ones which were in userspace at the moment of migration, and have the
> kernel deal with passing it on to userspace via a different ABI.
> 
> It ends up being complex and intricate, and requiring a lot of new
> kernel and userspace support. I gave up on it in the end for snapshots,
> and didn't go there again for this.

Maybe become you insist on using ACPI?
I see a fairly simple way to do it. For example, with virtio:

one vq per CPU, with a single outstanding buffer,
callback copies from the buffer into the userspace
visible memory.

Want me to show you the code?

-- 
MST

