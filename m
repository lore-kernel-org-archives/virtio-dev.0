Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7D725624
	for <virtio-dev@lists.linux.dev>; Fri, 26 Jul 2024 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721973985; cv=none; b=S7HPhjeqOIIYXln6exSQFx9qbdqLcPjNYiAOrdueYjMd9SZCMrjdwOYeH2FASJGkea5pw26eDYTJc+CX/9qEETdaE+1pjXLHHlZCDqQ0nQEw5D9K5ijpBvOJ67HnP9zPY1oYHex6aTRJo5eVFn1p2f9q1xKpp/GjZSp6YYA+jJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721973985; c=relaxed/simple;
	bh=6a7x76ue8Tb/QiSBhzrn7bO0FzEBds6B8ZU9VxKhPik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gN49K5CPPEFM6Zo6Mgu477nRVBGX1pF8JoIF1fn7iUy9YURCGYUlfg0nGByVUv5Q4kfRO0cAN16M3zoNZGezo9mMmL+bgn59wwOUHY2vSl1IHRkiSCmNCqPZ5nxp0rtfAEdqNjLSqC5bNGmK6TvaOJWLlQv8fowm6+g2TviXfIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dBRdlWxi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBRdlWxi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721973983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SsMd5ReUoNivIVt7CipMVyDPULIY2oYNW6l4qiM7rgQ=;
	b=dBRdlWxi6JJk9/cdviUy17MtkGMw4Zs38LbH4p2A7OZqiQsGBmStjAKPQcSVQyAaKcCoxh
	2Tzf0ss7Z7Xrw1pGEVJirW7xVnc2ljgRFNm5HRMVJru4HkdRRRyBaJVujxvytXImRCWhtW
	zSYLZHsjIiW0OHFwXBWM5iSFJz0K9HY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-Qi7Hga4fM5ipFu3acQk5HA-1; Fri, 26 Jul 2024 02:06:21 -0400
X-MC-Unique: Qi7Hga4fM5ipFu3acQk5HA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-368374dc565so925648f8f.2
        for <virtio-dev@lists.linux.dev>; Thu, 25 Jul 2024 23:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721973980; x=1722578780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsMd5ReUoNivIVt7CipMVyDPULIY2oYNW6l4qiM7rgQ=;
        b=rEWgH0I36EPjz6peqpAB3V8n2Z5eHxHnRnMuHiAm5TRhrUF9nsNgT1S9H/N08kGFJC
         tQze7812WaDppk3OI0IJGohk/echJX16PatPRww8oXJF/cYhIIfpU2ppx8QiN/4wJ151
         sAjpAOft8VEEZhfPNjgA8wmBBap8Wm3HNJQfHiO8mPp13RgLlyqXOWnOqKeE74bYA4IE
         EpmP4z2AZBR7VZp+WeCiZJ0BIvhtjF0RDNDJ7yJXNUp0aaVpIHo2ArSCqmwlxfmnCiUr
         OaezKKOfqsgfBWihSYq25dfv3vP5Wcd7FuVGDsMo8DgwS3Oissf6E8IWxtkHGUA2kKK0
         VuCA==
X-Forwarded-Encrypted: i=1; AJvYcCVIDhu5uj6X+e+9QXiyOY8WNAOv1kNYvpNdmVSJAXQXr854Pv7WpfEgClaHwlJ4gtJNNlgk/r0YlTmwpP+Asn00p+JDnqJpF3TtrQ==
X-Gm-Message-State: AOJu0Yx8K0koqBFPwRYv9I3pVkQU5kFT5Efkv+lmnViOJva8SK5Qkvgw
	O8DHSD/wQLANTPUuyJ0iXsMpafSs+JNTOVUPHZn/ul6RwXVyCatxo/9ZC3SQgzzVdcumOZiH85Q
	tD9isnpzKJYuMwhSYIh+ashZDQWoZ8oXnt54Rg9CJlUD2G52rwiYoyRhAZ5c=
X-Received: by 2002:adf:e3d0:0:b0:368:3731:1614 with SMTP id ffacd0b85a97d-36b3639c90cmr2555954f8f.32.1721973980463;
        Thu, 25 Jul 2024 23:06:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECcqinn2RbOzn7J7peOWcha9uEPwJVbe5Fk8jNLudEw/NhTNHYXX4sldsTgb73GWvF/16VyA==
X-Received: by 2002:adf:e3d0:0:b0:368:3731:1614 with SMTP id ffacd0b85a97d-36b3639c90cmr2555913f8f.32.1721973979719;
        Thu, 25 Jul 2024 23:06:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863aa7sm4031338f8f.109.2024.07.25.23.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 23:06:19 -0700 (PDT)
Date: Fri, 26 Jul 2024 02:06:10 -0400
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
Message-ID: <20240726015613-mutt-send-email-mst@kernel.org>
References: <20240725100351-mutt-send-email-mst@kernel.org>
 <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
 <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
 <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
 <20240725174327-mutt-send-email-mst@kernel.org>
 <9261e393083bcd151a017a5af3345a1364b3e0f3.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9261e393083bcd151a017a5af3345a1364b3e0f3.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2024 at 11:20:56PM +0100, David Woodhouse wrote:
> We're rolling out the AMZNVCLK device for internal use cases, and plan
> to add it in public instances some time later.

Let's be real. If amazon does something in its own hypervisor, and the
only way to use that is to expose the interface to userspace, there is
very little the linux community can do.  Moreover, userspace will be
written to this ABI, and be locked in to the specific hypervisor. It
might be a win for amazon short term but long term you will want to
extend things and it will be a mess.

So I feel you have chosen ACPI badly.  It just does not have the APIs
that you need. Virtio does, and would not create a userpspace lock-in
to a specific hypervisor. It's not really virtio specific either,
you can write a bare pci device with a BAR and a bunch of msix
vectors and it will get you the same effect.

-- 
MST

