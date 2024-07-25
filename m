Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED3019D897
	for <virtio-dev@lists.linux.dev>; Thu, 25 Jul 2024 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909848; cv=none; b=Eg0hJnzLMpIwSN8L4BG8wN37dC5kMWpLIAXju64GfPxjf6q1gC8HVgzJ03fykz1+L5rzokrS/gBNv9hhOeYNth/TNovqutlegPWwksl1C3AOTTiMqB7KCRxJTAMTP/g+ivjS3n7bPEHig8+/wfKPOSJcESklfM/kv0rMI9ylK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909848; c=relaxed/simple;
	bh=HVM0mVlaCtLos7f5wbrHV96ayPcblkpUKWT9CLfBrMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kBMGZQ00YRcd0X4KWuWrKmSY8iYRATSXdD4RK+vOdUZ9fQQ7OBfQRhQJnMv60qhBst5nAwmfkapAv4hknUaXQiEtbahMP6m9V0csOMKgyn7jn+ZCwqWnewQEoRc09+PJYwxRKN1P3/0BNotrsc9NyzDsB+8X4kwo9vfajYo8qLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ha/pGXR8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ha/pGXR8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721909846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S3UGu/KRztNRY0Bp3FrBUk5j7TGUvdGU0FLKSCgJsvw=;
	b=ha/pGXR8icjENtPTCR9V+eeiWEyryCYY+wjtXH2UqL0HQ2LW54r4YR0iwN/bSCYu5oko1q
	DC+apfav+VeCgLpZILoyTw69/rNjAsYQp5t6cN97fDvquQ4dgb6QcPSaZH8JC10YRskEne
	vqAMsaMrTEXoAKA5HTjTjp/nffJzD/E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-3PYsyl3QNC6QvYJTuBr0Ug-1; Thu, 25 Jul 2024 08:17:22 -0400
X-MC-Unique: 3PYsyl3QNC6QvYJTuBr0Ug-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36871eb0a8eso500565f8f.3
        for <virtio-dev@lists.linux.dev>; Thu, 25 Jul 2024 05:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721909841; x=1722514641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3UGu/KRztNRY0Bp3FrBUk5j7TGUvdGU0FLKSCgJsvw=;
        b=hgG92MR3KlhHLmCcBQpUEdRLbPyOuog+HVCiF+2ij8hyHn7l/cvjUY7AEqeZthGYMf
         gLNCPPF3JkGrFwpJgCpYiamVypZ2GbHR/TaCJ4v6ggGtBftdKQhoqVK55fVXq5U3Rg9/
         sxmtbclCClJfGVC9b13VL+D0cc7cZBQ9i4YxCrAcAhi3lAs7mHaXk9PXWAnkClnHJo5r
         2ZzE92/Bhl/vEEmzzQidDdZNwWzt/r3MmcfmSlr+TS4sRoZF9+0jm+0Skjdl84BPd0ws
         uy38FFKiMbA7vFfhWoiIsPiKuE8eyZkMkAJw8R4n4bwRkbeqhDtvttgDxS1gUSvejaTm
         1sjg==
X-Forwarded-Encrypted: i=1; AJvYcCUJFcs9f0yxKIjxsqYq5MXV6WM6Stomx91i/r6euGVQwCdPBGbWfwwXbiMtSr81WipLjcy3izXKOs0/qWsUn8wjoLihdfvJgEObLw==
X-Gm-Message-State: AOJu0YwjRsXXFPcOnDCI0aBPe04AoVkbfdtSndBBgz6IeK+Rg/KBZdGg
	wht4KUu6r7BW1u5QybOpK4RMWLzck1H44eLvyt+GRHTi/pQUfCWfd8LugXW+xHqqJYBTQmTQi0x
	92Htj2X8MDC3nA4ATWkkO4a7hkNzRq/W2F51UkE2hbqlfEf+ZcWyrsy/DUrE=
X-Received: by 2002:a05:6000:10c4:b0:367:f281:260e with SMTP id ffacd0b85a97d-36b31ac7126mr1799106f8f.3.1721909841502;
        Thu, 25 Jul 2024 05:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEKfa12+yv+9oCURpazLfKX3NylqFM0NYsmdlmyULxdYJys5id/PrGbgGHwZdmlDCg2IQWng==
X-Received: by 2002:a05:6000:10c4:b0:367:f281:260e with SMTP id ffacd0b85a97d-36b31ac7126mr1799053f8f.3.1721909840718;
        Thu, 25 Jul 2024 05:17:20 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f8:1b05:4ed8:7577:e2b:7ae3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863aa7sm1983920f8f.109.2024.07.25.05.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:17:20 -0700 (PDT)
Date: Thu, 25 Jul 2024 08:17:14 -0400
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
Message-ID: <20240725081502-mutt-send-email-mst@kernel.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
 <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2024 at 10:56:05AM +0100, David Woodhouse wrote:
> > Do you want to just help complete virtio-rtc then? Would be easier than
> > trying to keep two specs in sync.
> 
> The ACPI version is much more lightweight and doesn't take up a
> valuable PCI slot#. (I know, you can do virtio without PCI but that's
> complex in other ways).
> 

Hmm, should we support virtio over ACPI? Just asking.

-- 
MST

