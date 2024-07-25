Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B2DA93A
	for <virtio-dev@lists.linux.dev>; Thu, 25 Jul 2024 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910804; cv=none; b=aNU767y1VkOfH3FFUajuUs+pWTT3TMNXqEf9fwdVoV/sQJKbiYcE/tKIl3vJIv0sDyJy8rJa73cxY983pUtLB3itWhVVBVvwNHLxxtYCa+07CLIuZCjZz4SK9rg/4eIQnzFMKNlzryixULJC4t4Z6f4Dp142mLzPEtZctOj9vnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910804; c=relaxed/simple;
	bh=loisQvxB80cBHcqxsD4j7QC4s2voKR2VBQscCedYzEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=b1MK0jMO7oroenM7D+AVgZUpbut7v3TiQWKaOoNguYWccynWvqBgQPB1UMlvfNiF6BCcijNotKcEOCpO5Mn1ygwRWUUAu7Uqtq+iKHKn6+x5MjZ+DiBwH9Z4GoI8yS0dRGsp4huRLoC/4cYSU81LEAmfY6OrgxPbLTsq4VT6Q6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grdn0bHw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grdn0bHw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721910801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MtA7yhRfm5XfOtod2ZhYC2Xuv723Fg+huPBrtR9uGkE=;
	b=grdn0bHwzEXJByivt4bEqTksKVLD1XRizjb5LrNYCUHQj83mvsybNF19shjbx8wBl1ROaq
	SNkPaBESMMXe0up3j7BzXGkSwGTPAlq1D8MJRX0xXFwhPhMaOSU4OAy+y/BN6Kf5873Qts
	1X31aM2vcmKTnzvTmKEUWlP4v+tum50=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-mR9UPwBAOKGuk4hfUht7bg-1; Thu, 25 Jul 2024 08:33:20 -0400
X-MC-Unique: mR9UPwBAOKGuk4hfUht7bg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36875698d0dso567462f8f.3
        for <virtio-dev@lists.linux.dev>; Thu, 25 Jul 2024 05:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721910799; x=1722515599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtA7yhRfm5XfOtod2ZhYC2Xuv723Fg+huPBrtR9uGkE=;
        b=knLnL+sAA9+lIZt3nxqwLlUek0RacON56i0ujXQWi7gOXMIE1AYWyCE3eULVAPettA
         XsEKSQLEk2Fld7bTkmJjNk577CzfrhpSj6LksJhpPMYoci9vJEbtFXKcvH+1NYTriCg+
         4UQxSkM35dntxBWo1ZTyPUq8qCZuXZqp1zNlem9UoqpBjUbrA5y9xcpcqZzoIf866FGE
         dF70d9rXhrklK0rCVQsaGE64HBfOZJg7iw5UsgYZOQfCH1Yi8S3/LETeWJJk12fHgoMj
         lKl83j+eOTN0VoyIB7B/HuGrIkLES5Kl7bsHEAhaFZWmFDYp0rCQwxX+PHKWvFh6dYAI
         Rj7g==
X-Forwarded-Encrypted: i=1; AJvYcCXWNGZE0ieT1ZCKOEdIaZmiQSuPGa1T4LtGgVzcdJUKoftM7iQSMIohrD6eyIwsZWlJveIekvgfS3d/Itf3Xf2LJOHQLvuiVQaD3g==
X-Gm-Message-State: AOJu0Yzu9ZwLl5mPUOh/M5j6R/1fv99CMGTfvjQiFezAdfNALORbwA6c
	Jv9bGFC8sj9rhRYOWNKcXPolXvHAOvV3eH6SwmsipkN0UrHZN1R1VCm4bJErTMgSwlwG5310U0A
	lh2+HRCvS8IcV6FXB3mMlQaXtNzIbcTCCjNEp9OcJQLVxi0wFk7Bk8VvI4PQ=
X-Received: by 2002:a05:6000:10c4:b0:363:d980:9a9e with SMTP id ffacd0b85a97d-36b31a5187amr2126809f8f.55.1721910799450;
        Thu, 25 Jul 2024 05:33:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNFg/vuWe2oFay9N039fn3TrlpoXUmzQUlnFxLTZeAWFsuS7LiKQSxku9klsp/j5rRo846+Q==
X-Received: by 2002:a05:6000:10c4:b0:363:d980:9a9e with SMTP id ffacd0b85a97d-36b31a5187amr2126769f8f.55.1721910798847;
        Thu, 25 Jul 2024 05:33:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:81aa:776c:8849:e578:516a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367f0e26sm2054573f8f.47.2024.07.25.05.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:33:18 -0700 (PDT)
Date: Thu, 25 Jul 2024 08:33:12 -0400
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
Message-ID: <20240725083215-mutt-send-email-mst@kernel.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
 <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
 <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
 <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2024 at 01:31:19PM +0100, David Woodhouse wrote:
> On Thu, 2024-07-25 at 08:29 -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 25, 2024 at 01:27:49PM +0100, David Woodhouse wrote:
> > > On Thu, 2024-07-25 at 08:17 -0400, Michael S. Tsirkin wrote:
> > > > On Thu, Jul 25, 2024 at 10:56:05AM +0100, David Woodhouse wrote:
> > > > > > Do you want to just help complete virtio-rtc then? Would be easier than
> > > > > > trying to keep two specs in sync.
> > > > > 
> > > > > The ACPI version is much more lightweight and doesn't take up a
> > > > > valuable PCI slot#. (I know, you can do virtio without PCI but that's
> > > > > complex in other ways).
> > > > > 
> > > > 
> > > > Hmm, should we support virtio over ACPI? Just asking.
> > > 
> > > Given that we support virtio DT bindings, and the ACPI "PRP0001" device
> > > exists with a DSM method which literally returns DT properties,
> > > including such properties as "compatible=virtio,mmio" ... do we
> > > already?
> > > 
> > > 
> > 
> > In a sense, but you are saying that is too complex?
> > Can you elaborate?
> 
> No, I think it's fine. I encourage the use of the PRP0001 device to
> expose DT devices through ACPI. I was just reminding you of its
> existence.
> 
> 

Confused. You said "I know, you can do virtio without PCI but that's
complex in other ways" as the explanation why you are doing a custom
protocol.

-- 
MST

