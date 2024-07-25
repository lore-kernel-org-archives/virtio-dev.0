Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8AD199E87
	for <virtio-dev@lists.linux.dev>; Thu, 25 Jul 2024 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910582; cv=none; b=DRRQmgc+nZs+X+AJjV0VYo0N66K+qXkqHg3kkni1+6vN8Z/x9Q1T6yXx42r+3uWaepgagOwKqttxyVX4AJqUoFGRGiT2L0DnBmPAfFKmITtE79Mck7hRWgtQQudlCRnJWiOVByUavubz/DiMuU4JU6ez7R19qm7O6e8L/bwyZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910582; c=relaxed/simple;
	bh=1x+MRrK/gKvb0AP5m2fDvNNFyowu/Kb6wBFKgceGBH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WRumRIHXOMNs79jJj2CT+V8vd0CQI/7mGLFdspYbVMWpBjBSRnqoaEupl7OOLsQxbc7gzHRrCPTt5C0NTThhsKy6znAtmGvCAWWjUxGVyhR0q9L9k0jj/5nqEi4TGhwYOX4R7NSI2CGyJxBGlKqTUJPZOZdm5N7tMW3793zxqtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iY2hGiJM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iY2hGiJM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721910580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GmqP7A+JPqJziazr6AG6F2fPGPMKo7eb6D/y7TyUksU=;
	b=iY2hGiJMegGYi1tgITFilEuNCyQ9dadErA8+BSvpOJsV4n5IM/1X9ioSO1HFszmeoe+FsP
	+4t5sH32FNf+7H7arjaj19g8xoEX9IOC/VDOUfnUdVKggRGtKHOZ6XUJXGwpNn9aVsocRL
	OzI36+BnpUeWf7tq1e9oY/7SxSTguP0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-aK-3mvVVOgWZKmfIvSadEQ-1; Thu, 25 Jul 2024 08:29:38 -0400
X-MC-Unique: aK-3mvVVOgWZKmfIvSadEQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a2ceb035f9so1311239a12.0
        for <virtio-dev@lists.linux.dev>; Thu, 25 Jul 2024 05:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721910577; x=1722515377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmqP7A+JPqJziazr6AG6F2fPGPMKo7eb6D/y7TyUksU=;
        b=vqZyaHeE+6SiZQICY8SN7iqXfg+61OtukrFK3IcdNmTidRhylWShODYsUBSKc9ODFv
         3SLP4LmRTiz2osPA9Hyc8Jxbm26GD7cKh9h+QbFYzjqm8WfqULvpJkB442YHPir6q56q
         f8yJiOjv45RanQLjkI6NrJqFhUdnTk1bYHa8VpdGUSYkyHiL3zTahYhvvRBiSGA1nI2s
         CYOVZLC/CMd2fPrmzyVqsvuHFUScQmfEOa3n2QicHLaPSV3oKnvrFBci9FUEvoal1W8f
         RnrhfT9YXIylKg6YG699HUQs3k32c1jX6n8+NRf+YM2yQAhq20mlj+ccrjndVPO+flv2
         301g==
X-Forwarded-Encrypted: i=1; AJvYcCVmc2tYenyWVZFjrMO+pUi9QmgO0CZftiyhQk/hAR9aLqU7BMaH3HDudZ7GA9xZNTG1Z5Tc6/E+xBgsn172+mlwPnv8nWaYWvgaDQ==
X-Gm-Message-State: AOJu0YxrGvpo7kjMalqgzn6YdL02qCAyvPINqlsnKLAhxVUR+/tr7cfO
	cbhA9VSWL3B93+4ploB43CCu9r2RhNTDCgqwoNHERLB04wtLRVOFfUMd2K2au9d+VrF5pV0U6lt
	dORMhJdfXMmUaKyqqDAwiQkiJJGD5nhTZIufdC0TVV6JiEDNf5Jkx947WFKE=
X-Received: by 2002:a50:baa3:0:b0:58c:10fd:5082 with SMTP id 4fb4d7f45d1cf-5ab1a7af0f3mr5616855a12.10.1721910577478;
        Thu, 25 Jul 2024 05:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESzTf1Dq4jXq+lb4GZ/ln7u62lD42/qJf2maAOGtbm2TYn0twTp0kEGmFg6gBHrHiC+FsesQ==
X-Received: by 2002:a50:baa3:0:b0:58c:10fd:5082 with SMTP id 4fb4d7f45d1cf-5ab1a7af0f3mr5616818a12.10.1721910576749;
        Thu, 25 Jul 2024 05:29:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:81aa:776c:8849:e578:516a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3becsm768874a12.74.2024.07.25.05.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:29:36 -0700 (PDT)
Date: Thu, 25 Jul 2024 08:29:31 -0400
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
Message-ID: <20240725082828-mutt-send-email-mst@kernel.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
 <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
 <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2024 at 01:27:49PM +0100, David Woodhouse wrote:
> On Thu, 2024-07-25 at 08:17 -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 25, 2024 at 10:56:05AM +0100, David Woodhouse wrote:
> > > > Do you want to just help complete virtio-rtc then? Would be easier than
> > > > trying to keep two specs in sync.
> > > 
> > > The ACPI version is much more lightweight and doesn't take up a
> > > valuable PCI slot#. (I know, you can do virtio without PCI but that's
> > > complex in other ways).
> > > 
> > 
> > Hmm, should we support virtio over ACPI? Just asking.
> 
> Given that we support virtio DT bindings, and the ACPI "PRP0001" device
> exists with a DSM method which literally returns DT properties,
> including such properties as "compatible=virtio,mmio" ... do we
> already?
> 
> 

In a sense, but you are saying that is too complex?
Can you elaborate?

-- 
MST

