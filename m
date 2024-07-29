Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860F513C9A7
	for <virtio-dev@lists.linux.dev>; Mon, 29 Jul 2024 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267230; cv=none; b=L/Ggb/xJGZCJgjp3bCrGEwSyIlST2Att/fB4CP1gexSKInlu/kqEKnas54T39Gerzj/aGWtnqWgBpvHcE4VDgleJGWudReYmTaz0v3dM8d/jcqlVBbQj+KsJik6xB2nTERWHRB2XV1DDn8iG12jndQrAO7vXfVlghypN96JRrm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267230; c=relaxed/simple;
	bh=wqWUVlf7aP1OH80LKZ4ptLvsSw+/kbCzCArTFsf8Z2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WKgcpeDTUmQB0HknAhsgEqi3hcICMCOGWb9JhG4Q0DQARJo8+rwWm6OyfwJLEczWrJqBiPit4DugRJZlQK4egEFTvxsr3suX/RqVVOt6RQVX9DSmmA3genE/EqNOBi45SEU6p3vsD++pcPeYR2LGDH87Cdz7F4ub1fckpyrdTKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cDbh7m7V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDbh7m7V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722267227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gOdxuhlC0hKorSyQVfDMKmXgVB7ow0l5OK4sY+cYrK0=;
	b=cDbh7m7VbzIKhMO5u5xWiUUGUsNSRVDF78yNY0FhwVVgq/k2poyVTpJOd9YOVAsb70wq+V
	VsBq2Q76kSSi471Hoby4bJCd/FMQ9rcahPl2m1vdHCqMuZCqzL/ve7nMbkG90XvPAZQa5L
	Ehos8NgSttWDrf/0Fs+LIosEiwOGi5I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-MK9wo9n6MxiSsn_ZyB_rDw-1; Mon, 29 Jul 2024 11:33:46 -0400
X-MC-Unique: MK9wo9n6MxiSsn_ZyB_rDw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280b119a74so19835885e9.3
        for <virtio-dev@lists.linux.dev>; Mon, 29 Jul 2024 08:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722267225; x=1722872025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOdxuhlC0hKorSyQVfDMKmXgVB7ow0l5OK4sY+cYrK0=;
        b=TJWQH2PKwv8CX+yDtKleHh5gsltTMYIcv+j+UK5AdYvel/af1nk7kX7vowzx5wz0AG
         jip/lxHTMLRPW0o0DzHCCGmKs8fhrxE2bVAK/R5i8fEi6qolczZYKFza5gIIjpchGkBs
         vnS+uZ3073ocxdSzCewzldDYklKf8M98hR43l16/JNfr4jC89+3fQA7BlLbgBNtcfhHr
         ueLdlgdl0OJnQaknBPa9hBuFPbsDPSL3xOwZYbOIOJ04TPW2Uxj2W2KiIhxwWSD3BDyd
         RrKo4IETNMFkrKi/RNhDTMOGqePvlbSR6j7efHO+gxFDcN4snfEEzrBdTnEMjUqcPD7j
         KYJg==
X-Forwarded-Encrypted: i=1; AJvYcCWrhjCBNcvQdvQJM7WWxcgtsmqXjzIsPqSXhEkxWL9Q1xBUl1arX04Cc1J3tSTpKpFd3nea6/61w07QVEiOaZUQ6zhjqitftT/EYQ==
X-Gm-Message-State: AOJu0YxsBOetbu0/WQr7VJHL9t6hYZ73+5GiU+WMj0EKrpXlKfmyoMHe
	HDZYOQpAl71fUUJmMcVvLXw4FTQwoaaQCtTzSs13lvKeZPJ8G3L1O4hvCf+kkh8FlRJW3QRzsYG
	v5RQhKKC0bAjQnhrHh8aAuME023hbWfmxBo2gnVO9EDNdnT9q4uCpDTSo7lI=
X-Received: by 2002:a05:600c:3b99:b0:426:5269:9827 with SMTP id 5b1f17b1804b1-42811a94590mr60054215e9.0.1722267224663;
        Mon, 29 Jul 2024 08:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH11CwyPhlrH2xJ/R5zuEwuK8l7eeYYGyXEbvzQ/zeQzSr5tEaXptiR7TnM3lG3ZWRGuUwuXg==
X-Received: by 2002:a05:600c:3b99:b0:426:5269:9827 with SMTP id 5b1f17b1804b1-42811a94590mr60053985e9.0.1722267223937;
        Mon, 29 Jul 2024 08:33:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:98c4:742e:26be:b52d:dd54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281fd617desm21464125e9.35.2024.07.29.08.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:33:43 -0700 (PDT)
Date: Mon, 29 Jul 2024 11:33:36 -0400
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
Subject: Re: [PATCH v3] ptp: Add vDSO-style vmclock support
Message-ID: <20240729113320-mutt-send-email-mst@kernel.org>
References: <e3164fc80e21336cbf13e24f98c9e5706afb77ab.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e3164fc80e21336cbf13e24f98c9e5706afb77ab.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2024 at 11:42:22AM +0100, David Woodhouse wrote:
> +struct vmclock_abi {
> +	/* CONSTANT FIELDS */
> +	uint32_t magic;
> +#define VMCLOCK_MAGIC	0x4b4c4356 /* "VCLK" */
> +	uint32_t size;		/* Size of region containing this structure */
> +	uint16_t version;	/* 1 */
> +	uint8_t counter_id; /* Matches VIRTIO_RTC_COUNTER_xxx except INVALID */
> +#define VMCLOCK_COUNTER_ARM_VCNT	0
> +#define VMCLOCK_COUNTER_X86_TSC		1
> +#define VMCLOCK_COUNTER_INVALID		0xff
> +	uint8_t time_type; /* Matches VIRTIO_RTC_TYPE_xxx */
> +#define VMCLOCK_TIME_UTC			0	/* Since 1970-01-01 00:00:00z */
> +#define VMCLOCK_TIME_TAI			1	/* Since 1970-01-01 00:00:00z */
> +#define VMCLOCK_TIME_MONOTONIC			2	/* Since undefined epoch */
> +#define VMCLOCK_TIME_INVALID_SMEARED		3	/* Not supported */
> +#define VMCLOCK_TIME_INVALID_MAYBE_SMEARED	4	/* Not supported */
> +
> +	/* NON-CONSTANT FIELDS PROTECTED BY SEQCOUNT LOCK */
> +	uint32_t seq_count;	/* Low bit means an update is in progress */
> +	/*
> +	 * This field changes to another non-repeating value when the CPU
> +	 * counter is disrupted, for example on live migration. This lets
> +	 * the guest know that it should discard any calibration it has
> +	 * performed of the counter against external sources (NTP/PTP/etc.).
> +	 */
> +	uint64_t disruption_marker;
> +	uint64_t flags;
> +	/* Indicates that the tai_offset_sec field is valid */
> +#define VMCLOCK_FLAG_TAI_OFFSET_VALID		(1 << 0)
> +	/*
> +	 * Optionally used to notify guests of pending maintenance events.
> +	 * A guest which provides latency-sensitive services may wish to
> +	 * remove itself from service if an event is coming up. Two flags
> +	 * indicate the approximate imminence of the event.
> +	 */
> +#define VMCLOCK_FLAG_DISRUPTION_SOON		(1 << 1) /* About a day */
> +#define VMCLOCK_FLAG_DISRUPTION_IMMINENT	(1 << 2) /* About an hour */
> +#define VMCLOCK_FLAG_PERIOD_ESTERROR_VALID	(1 << 3)
> +#define VMCLOCK_FLAG_PERIOD_MAXERROR_VALID	(1 << 4)
> +#define VMCLOCK_FLAG_TIME_ESTERROR_VALID	(1 << 5)
> +#define VMCLOCK_FLAG_TIME_MAXERROR_VALID	(1 << 6)
> +	/*
> +	 * If the MONOTONIC flag is set then (other than leap seconds) it is
> +	 * guaranteed that the time calculated according this structure at
> +	 * any given moment shall never appear to be later than the time
> +	 * calculated via the structure at any *later* moment.
> +	 *
> +	 * In particular, a timestamp based on a counter reading taken
> +	 * immediately after setting the low bit of seq_count (and the
> +	 * associated memory barrier), using the previously-valid time and
> +	 * period fields, shall never be later than a timestamp based on
> +	 * a counter reading taken immediately before *clearing* the low
> +	 * bit again after the update, using the about-to-be-valid fields.
> +	 */
> +#define VMCLOCK_FLAG_TIME_MONOTONIC		(1 << 7)
> +
> +	uint8_t pad[2];
> +	uint8_t clock_status;
> +#define VMCLOCK_STATUS_UNKNOWN		0
> +#define VMCLOCK_STATUS_INITIALIZING	1
> +#define VMCLOCK_STATUS_SYNCHRONIZED	2
> +#define VMCLOCK_STATUS_FREERUNNING	3
> +#define VMCLOCK_STATUS_UNRELIABLE	4
> +
> +	/*
> +	 * The time exposed through this device is never smeared. This field
> +	 * corresponds to the 'subtype' field in virtio-rtc, which indicates
> +	 * the smearing method. However in this case it provides a *hint* to
> +	 * the guest operating system, such that *if* the guest OS wants to
> +	 * provide its users with an alternative clock which does not follow
> +	 * UTC, it may do so in a fashion consistent with the other systems
> +	 * in the nearby environment.
> +	 */
> +	uint8_t leap_second_smearing_hint; /* Matches VIRTIO_RTC_SUBTYPE_xxx */
> +#define VMCLOCK_SMEARING_STRICT		0
> +#define VMCLOCK_SMEARING_NOON_LINEAR	1
> +#define VMCLOCK_SMEARING_UTC_SLS	2
> +	int16_t tai_offset_sec;
> +	uint8_t leap_indicator;
> +	/*
> +	 * This field is based on the the VIRTIO_RTC_LEAP_xxx values as
> +	 * defined in the current draft of virtio-rtc, but since smearing
> +	 * cannot be used with the shared memory device, some values are
> +	 * not used.
> +	 *
> +	 * The _POST_POS and _POST_NEG values allow the guest to perform
> +	 * its own smearing during the day or so after a leap second when
> +	 * such smearing may need to continue being applied for a leap
> +	 * second which is now theoretically "historical".
> +	 */
> +#define VMCLOCK_LEAP_NONE	0x00	/* No known nearby leap second */
> +#define VMCLOCK_LEAP_PRE_POS	0x01	/* Positive leap second at EOM */
> +#define VMCLOCK_LEAP_PRE_NEG	0x02	/* Negative leap second at EOM */
> +#define VMCLOCK_LEAP_POS	0x03	/* Set during 23:59:60 second */
> +#define VMCLOCK_LEAP_POST_POS	0x04
> +#define VMCLOCK_LEAP_POST_NEG	0x05
> +
> +	/* Bit shift for counter_period_frac_sec and its error rate */
> +	uint8_t counter_period_shift;
> +	/*
> +	 * Paired values of counter and UTC at a given point in time.
> +	 */
> +	uint64_t counter_value;
> +	/*
> +	 * Counter period, and error margin of same. The unit of these
> +	 * fields is 1/2^(64 + counter_period_shift) of a second.
> +	 */
> +	uint64_t counter_period_frac_sec;
> +	uint64_t counter_period_esterror_rate_frac_sec;
> +	uint64_t counter_period_maxerror_rate_frac_sec;
> +
> +	/*
> +	 * Time according to time_type field above.
> +	 */
> +	uint64_t time_sec;		/* Seconds since time_type epoch */
> +	uint64_t time_frac_sec;		/* Units of 1/2^64 of a second */
> +	uint64_t time_esterror_nanosec;
> +	uint64_t time_maxerror_nanosec;
> +};
> +
> +#endif /*  __VMCLOCK_ABI_H__ */
> -- 
> 2.44.0
> 
> 



you said you will use __le here?

