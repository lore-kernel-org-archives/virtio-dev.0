Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBBE30BB81
	for <virtio-dev@lists.linux.dev>; Thu, 28 Aug 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376404; cv=none; b=TZlKbsy3f0lsX3n4FYwzNOdWD1KKqG1fIsl4FQl4D9ljRnJ3tiMkHm+23gcH69owULsvGkUdCU/Hj8DxKynpNVOrpFBfO/a9/3Zast4JQEhm0dfPOdKz014d7WXQUP/z7IJKtP95GFIIvu4qBYDVC08U7JwtgcEPcMNKhu8Syn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376404; c=relaxed/simple;
	bh=C1DYH4kVeKuTMIZnOmx1ZxMHuw47TEaonNH+ssfuphc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XpZ2SIXk5k+A9K96gKgHY6Hfiu+x/rhqBdRBba/eNNzK0EfHA9nvbc+WvTSdeQ6YJJf3YkPvTGq0uQ2MzQBFHAFdR6/xqY12CaEiKcGtzpxX1psrrvGxhHBkG98n8BPdrsoGFp76Ka/GLu90fptkEMxqpV2IJi3RyNGg3xa7EVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=giCt01/g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giCt01/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756376401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBAEoFNbmswFsnSxAIv1w+pBcSdXwLgSTS2jwoutXlw=;
	b=giCt01/gVBKigXLOwKX/OzHYt9HrmPVN86WoQN3YjS5GQsm5znxRdLv7+OuCNYHEq+O3HL
	efuWE/KH8h9Wk3EEYNy5s0NL7c6piLTbvMX2CSI4bSvh5SVEVRbQX9FIxvaUI9DEJD/M1l
	f7WM2+UmN4I5l3qUg75k7zO5K1A7Kpo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-d6U74m12PnWJw0Wbr2bJAw-1; Thu, 28 Aug 2025 06:19:57 -0400
X-MC-Unique: d6U74m12PnWJw0Wbr2bJAw-1
X-Mimecast-MFC-AGG-ID: d6U74m12PnWJw0Wbr2bJAw_1756376396
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b7d84d8a0so202225e9.1
        for <virtio-dev@lists.linux.dev>; Thu, 28 Aug 2025 03:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376396; x=1756981196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBAEoFNbmswFsnSxAIv1w+pBcSdXwLgSTS2jwoutXlw=;
        b=m3oEXYVHLrP2z4knDY6T4s72L46FjWJ+/8jgnI55Hlv7z32JrgksxuWBYGqwpwPrCY
         FyKBEM8LIVSE6faAM5TucG4tG6UF4yPpjYPSXxKIDKURSzK9zvpNdiwbvLZGT5TYja8j
         TCcdznu8TtiX3IaZW/k3KkqAasQWApsksySphXBM6i6znpUTdK8VcojQQnA7jFs93fMh
         F6m0FUyAzfSaNjlvymdOu3JrDpppGOI+eyQadZh4RSftqzhPeWKoej88sezrUOuGXplv
         9fD5bvcoaZyUB/FY5g8LC0Rdg1+tvWefwE22Z+QT+N1Ib4kP3psoakl2kdYh8yORk0ZB
         OwhA==
X-Forwarded-Encrypted: i=1; AJvYcCUnPFR4EfmFV+cI2563RBCJLOcyIu36eLoFXk+k+3dvl9G5cKEraL35TRqdNLG2pPMR9r8FFmLz0w5h@lists.linux.dev
X-Gm-Message-State: AOJu0YxnC+zNzAtbSYCfwad2yTjcVsrMdxiLrdqPTimsyF7vsz01ACmn
	Idy31GBZEXpRDFC+Zxu2VN8HlsUw569ddeqmTT1XrN8A90r9tI7JiM+e3loM7lEbd6zjMSW9Ake
	nSfy1BodIsI+pdfNT32KzhGeo2Cpa/M7mJzpAaWm6E7K0pOP9VhXxTx+Hx6xf5+I=
X-Gm-Gg: ASbGncsQi8HnE2ax/l4bkULj0KagMikfbQHo9ViejWODYUmmfBCcOVk2+Eub5Aovh3m
	rvqnPeyT5ylwIBJjXxNBoGycvMsoZ+Qsia+zf4v4mh5zcA58aQ7RP5+C62KT5Q/WmU4aUzXc39U
	+rwvQ8DUrvpx5qiXoNxLH2Dws9ZMOK2th7yoRcZ3k+bBR3voSvdoqWFgGl9gSypgDz3MHVkx0cO
	IzXkfpea14cVwmgmhx79OLwtndHFNunQpLhZEE2rzIucYnTBXA8dQuRHSLMnLUn+gGmzd6z/aZc
	yl1eBKMRND6JIRyCdkLhOy7pYJ8iR/LG
X-Received: by 2002:a05:600c:a47:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-45b517cfe66mr169732995e9.32.1756376396487;
        Thu, 28 Aug 2025 03:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRzvWTBo2GxDcNnrIlhFHzO2y1QKjqd6ebF9+adqAAZUSWw06wXWnWxmDIghxndloNXqg0Zg==
X-Received: by 2002:a05:600c:a47:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-45b517cfe66mr169732795e9.32.1756376396123;
        Thu, 28 Aug 2025 03:19:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b79799c33sm26094735e9.5.2025.08.28.03.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:19:55 -0700 (PDT)
Date: Thu, 28 Aug 2025 06:19:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: andriy.shevchenko@intel.com, harald.mommer@oss.qualcomm.com,
	quic_msavaliy@quicinc.com, broonie@kernel.org,
	virtio-dev@lists.linux.dev, viresh.kumar@linaro.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	hdanton@sina.com, qiang4.zhang@linux.intel.com,
	alex.bennee@linaro.org, quic_ztu@quicinc.com
Subject: Re: [PATCH v4 2/3] virtio-spi: Add virtio-spi.h
Message-ID: <20250828061943-mutt-send-email-mst@kernel.org>
References: <20250820084944.84505-1-quic_haixcui@quicinc.com>
 <20250820084944.84505-3-quic_haixcui@quicinc.com>
 <20250821044231-mutt-send-email-mst@kernel.org>
 <42806aa8-8cf1-476e-b775-50859fe0e7f1@quicinc.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <42806aa8-8cf1-476e-b775-50859fe0e7f1@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PZAPAKQ556TqTZy7vw-PPQLTe3EJVYx5rev6lCRL4xs_1756376396
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Aug 25, 2025 at 05:12:44PM +0800, Haixu Cui wrote:
> 
> On 8/21/2025 4:42 PM, Michael S. Tsirkin wrote:
> > On Wed, Aug 20, 2025 at 04:49:43PM +0800, Haixu Cui wrote:
> > > Add virtio-spi.h header for virtio SPI.
> > > 
> > > Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> > > ---
> > >   MAINTAINERS                     |   5 +
> > >   include/uapi/linux/virtio_spi.h | 185 ++++++++++++++++++++++++++++++++
> > >   2 files changed, 190 insertions(+)
> > >   create mode 100644 include/uapi/linux/virtio_spi.h
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index daf520a13bdf..3e289677ca18 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -26760,6 +26760,11 @@ S:	Maintained
> > >   F:	include/uapi/linux/virtio_snd.h
> > >   F:	sound/virtio/*
> > > +VIRTIO SPI DRIVER
> > > +M:	Haixu Cui <quic_haixcui@quicinc.com>
> > > +S:	Maintained
> > > +F:	include/uapi/linux/virtio_spi.h
> > > +
> > 
> > I would add a mailing list:
> > 
> > virtualization@lists.linux-foundation.org
> > 
> > 
> 
> Hi Michael,
> 
> Thank you for the suggestion to add a mailing list to the MAINTAINERS entry.
> 
> I noticed that other VIRTIO drivers, such as VIRTIO BALLOON, are currently
> using virtualization@lists.linux.dev rather than
> virtualization@lists.linux-foundation.org.
> 
> Just to confirm—should I use virtualization@lists.linux.dev for consistency,
> or is virtualization@lists.linux-foundation.org the updated preferred list?
> 
> Appreciate your guidance!
> 
> Best regards,
> Haixu Cui


virtualization@lists.linux.dev

Same as others.

