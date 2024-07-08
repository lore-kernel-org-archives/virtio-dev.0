Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6A54F8C;
	Mon,  8 Jul 2024 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430236; cv=none; b=XYVmGeGCO6hr6vMhDVGHoiF9xzlXPFqFPwN5kWD1zlAplvRt/gsDl/f9xD+I9mGKtD2zDZZj3CYRPSGdSmfcnEAbq2CahSNpbPAm8IE/l8Zlc5DpDrieyccy+dp8qA7HddVNDyIDs1h7p0a4tYgyAmFqQK3N748DoR2t1Uew2eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430236; c=relaxed/simple;
	bh=7movIOln5FthDg/xi31aDehlhJhJvIbc2LrM9jeDAKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/g1NuqCtjKVDxzqfma961eE591RIbEIpW8kAEuSeCeDLFU36ckx82O+uwKDIxPx4FaWfPDa/3iX289U2omc35/P8WnpJ2jhBBf/1y3c/yDaciZqDqwvkPiHfABMfRUllBuPABVSMDv7OJDxxi0L2bmlCT+bzVdIcSF+xNMVfuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYukOoa+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYukOoa+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF410C116B1;
	Mon,  8 Jul 2024 09:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720430235;
	bh=7movIOln5FthDg/xi31aDehlhJhJvIbc2LrM9jeDAKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYukOoa+4ATZ673jdHLmqVqq2lPB1o/rLAjEWyDzlNY838hgsSalPSWBfzjpbM+Ok
	 adhXPZbu/lnuYk/banGIPjNBokQP/JsRXWe3waHfWkXljGAQ88vWukbk5ErdUSAMJo
	 1qOzG2GSH7AMPT45SzOdhGnw2EBcgXwFW8LUcr7B3vvM5RmB9Kf2I50kYgqv2UTLAs
	 0iu6/4BaQ6Wg5hX5or08u57apD+rdEvP00CvpVPpuW32vD3nvpZwcTGAjW9EXBp9Ld
	 9ql+qgQZjTkr/Hwu/zZwodbzTtmjMTlseJnHNj5FCs98g7ZLiMtzFUJayHCP5RQCJI
	 b9e7UEHJDAdFA==
Date: Mon, 8 Jul 2024 10:17:08 +0100
From: Simon Horman <horms@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	"Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
	"Luu, Ryan" <rluu@amazon.com>,
	"Chashper, David" <chashper@amazon.com>,
	"Christopher S. Hall" <christopher.s.hall@intel.com>,
	Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH v3] ptp: Add vDSO-style vmclock support
Message-ID: <20240708091708.GJ1481495@kernel.org>
References: <830699d1fa8aaf3de1fa9ded54228d0811b5aab8.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <830699d1fa8aaf3de1fa9ded54228d0811b5aab8.camel@infradead.org>

On Sat, Jul 06, 2024 at 04:14:39PM +0100, David Woodhouse wrote:
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
> The shared memory structure is intended to be adopted into the nascent
> virtio-rtc specification (since one might consider a virtio-rtc
> specification that doesn't fix the live migration problem to be not fit
> for purpose). It can also be presented via a simple ACPI device.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

...

> diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c

...

> +	/* If there is valid clock information, register a PTP clock */
> +	if (st->cs_id) {
> +		st->ptp_clock_info = ptp_vmclock_info;
> +		strncpy(st->ptp_clock_info.name, st->name, sizeof(st->ptp_clock_info.name));

Hi David,

As per my comment on v2, although it is harmless in this case,
it would be nicer to use strscpy() here and avoid fortification warnings.


...

