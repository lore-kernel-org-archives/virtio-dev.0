Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F00430EF98
	for <virtio-dev@lists.linux.dev>; Thu, 28 Aug 2025 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377253; cv=none; b=BXfhP2eAPk/8hnq6moe6hJ6lwTB3KoUHYLzDMKZGer7gBkm4momo6+Zi97yQiqRJFx/bTy+so//tSrCzdV6UUUNef8GapHrUAkAUSdBgRhf7uMtAGgo7dL8Qghp/faYmLVVTclabToUXIeNKpcsIP5hPX4fwTvG/Ht5RELkUpeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377253; c=relaxed/simple;
	bh=wtX1QaBz9wXYD4soHMyGal0DPdeF2TDx5Z3Sfo0JTI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Nl98n2ntIEwOqDAHPAnYfqNbokBHkrP+bDVO66oEE2GUqzkmf3CJMiLrlt9jWos+GGCL4JWySXYxX/bncrZ+jPXrvwuVHNTySyHPhdH/jamivp71TSh0mVZ+LUcB69H/tKpaKD6eMgSVXcqGBwdihusOSZQ6+xj74Xg4+NvPWlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4NFaD8/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4NFaD8/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756377251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+FTwNA1bk0v6rrtoNJE35RPWClvjcf2jCc0VyKhrWjA=;
	b=T4NFaD8/00H9VwOmVA39JJI18EBp0PIl49guU0/+wmj6OwT23Qfc1e06aYLNDqCdwnblTI
	V9zXnXvisIzBzwqkLT0bH04gIuI5p1h+cdvhOscrSPrzOpdb1GIPrAlVJepGS5QuwsaZAB
	U8Tz7w44OrdFTN9Mrg2MuMxe6iJH2QM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-7XF5_fSGP3aMOUw8SaxlMg-1; Thu, 28 Aug 2025 06:34:09 -0400
X-MC-Unique: 7XF5_fSGP3aMOUw8SaxlMg-1
X-Mimecast-MFC-AGG-ID: 7XF5_fSGP3aMOUw8SaxlMg_1756377249
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b10418aso4229285e9.3
        for <virtio-dev@lists.linux.dev>; Thu, 28 Aug 2025 03:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756377248; x=1756982048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FTwNA1bk0v6rrtoNJE35RPWClvjcf2jCc0VyKhrWjA=;
        b=Hij4d62h+sO09npk34EOpPAfkobvYaZy8Mepyd0wq3v7GS8+piwXOtQufAHJgb0oCC
         F52/5hViFbBJtifQU2Uh3aHgp0uNZZx8j98Z6kJQF9DtvMO1o35/omG01rxTDla0ZGW6
         OdSlx1DlT/5TiFzBQx3NkxthoGQIG/t41M7nm3YUxW0wrr41vo/FWSnMr6RiTSFKBT4W
         Mg+hyw1SHnvQuMBJslAEe+IwTJE0ZNlZGL8Im+1RXprpbTT6DMvGXmJDXLb5dlx209JY
         gtTGxHb7we30xuSKJl7duX+UfLBCSWZsogGyTAcSrYfORq+xOELT+N1HT+gMkEImIAbH
         YSOw==
X-Forwarded-Encrypted: i=1; AJvYcCVR/zT/yQY7WoctLvMT4of2wlfCfeo4BeDfcXO9mIlQh8EdkkQXaEG1D67yLeFtOL3+/HD5CQDEE9yh@lists.linux.dev
X-Gm-Message-State: AOJu0YxPyzY6sJcdSAp82pcAgpc0fUZpkDviV2qIDHmHVP6D0MVy8wJe
	lLLf2mV/9I4XP0SubIqMQzOUqMs4eDlVTSRqDSNonCWYhAY1wplD04Qn+DWtpseFFtTDaAKwM1Y
	upyeFA7ukI4GthPON8/WG1JaGyCSRD6lnRk3t7NwbVocMPIay4rQ9mRs+FAM1gUQ=
X-Gm-Gg: ASbGncsKelpDAYyEoBHchlaEZYeIfGxWeTkx1L2kcU1PxPlg5NDuHOYeFKRM4LxL5kf
	eeuC841x3Xz7LGjheTSl2KnqMDjmll53/1FL9MjkfZTVG1XH6YLn+N/+C0d226CSX9rIGhZN4V2
	i6uJkFWP28/gpsduHDQrvGxBsRI47TUqRV6YvAqX1szHI9VZPwgW0wVeK5vTq79wxE3qn2ka4Dz
	Ur7N/lJWFow0HpQvEMid8hJ1sJQe7kaA9is6lS3VVQQswRoN04cGZKeDm0htlTcS0OYuRlQNWN3
	f+3o1jH/jAllHxRkDkYfopSyFL4NqjRL
X-Received: by 2002:a5d:5f8e:0:b0:3c8:443:4066 with SMTP id ffacd0b85a97d-3c804434575mr12697625f8f.61.1756377248601;
        Thu, 28 Aug 2025 03:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8oxOyBv4dBursJjsEHiDAvHkrowxoRe1iT8xj3dArCwD5U9uf5ibj+41tEIuHcsKWsgLqeg==
X-Received: by 2002:a5d:5f8e:0:b0:3c8:443:4066 with SMTP id ffacd0b85a97d-3c804434575mr12697598f8f.61.1756377248066;
        Thu, 28 Aug 2025 03:34:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211e87sm23884597f8f.44.2025.08.28.03.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:34:07 -0700 (PDT)
Date: Thu, 28 Aug 2025 06:34:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: andriy.shevchenko@intel.com, harald.mommer@oss.qualcomm.com,
	quic_msavaliy@quicinc.com, broonie@kernel.org,
	virtio-dev@lists.linux.dev, viresh.kumar@linaro.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	hdanton@sina.com, qiang4.zhang@linux.intel.com,
	alex.bennee@linaro.org, quic_ztu@quicinc.com
Subject: Re: [PATCH v4 2/3] virtio-spi: Add virtio-spi.h
Message-ID: <20250828063350-mutt-send-email-mst@kernel.org>
References: <20250820084944.84505-1-quic_haixcui@quicinc.com>
 <20250820084944.84505-3-quic_haixcui@quicinc.com>
 <20250821044351-mutt-send-email-mst@kernel.org>
 <1a63f5f9-add0-4a22-b01c-2f0c8d9efcec@quicinc.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1a63f5f9-add0-4a22-b01c-2f0c8d9efcec@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WPGv7CUhEa1db3xWiog50Iu-8T5B0EeDQHmkYJ71-ZA_1756377249
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 25, 2025 at 05:19:03PM +0800, Haixu Cui wrote:
> 
> 
> On 8/21/2025 4:45 PM, Michael S. Tsirkin wrote:
> 
> 
> > > +
> > > +/* Sample data on trailing clock edge */
> > > +#define VIRTIO_SPI_CPHA			_BITUL(0)
> > > +/* Clock is high when IDLE */
> > > +#define VIRTIO_SPI_CPOL			_BITUL(1)
> > > +/* Chip Select is active high */
> > > +#define VIRTIO_SPI_CS_HIGH			_BITUL(2)
> > > +/* Transmit LSB first */
> > > +#define VIRTIO_SPI_MODE_LSB_FIRST		_BITUL(3)
> > > +/* Loopback mode */
> > > +#define VIRTIO_SPI_MODE_LOOP			_BITUL(4)
> > 
> > It is generally preferable to have an enum with just bit
> > numbers.
> > 
> > 
> > E.g.
> > 
> > enum {
> > VIRTIO_SPI_F_CPHA = 0,
> > }
> > 
> > 
> > Userspace can add _BITUL wrappers itself if it
> > wants.
> > 
> > 
> 
> Hi Michael,
> 
> Thank you for the suggestion regarding the bit definitions.
> 
> Would it be acceptable to keep the current macro definitions with _BITUL()
> because these macros are also used within the virtio SPI driver itself?
> 
> Looking forward to your guidance.
> 
> Best regards,
> Haixu Cui
> 


move them to the .c file if you want them.

