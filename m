Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E9F52F281
	for <virtio-dev@lists.linux.dev>; Tue, 13 Oct 2026 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915023; cv=none; b=pQM+I9+g5NqpbPHN5TlsWQcpq+K//XgRJt9O8DvvUKrUjTUY7vwbNR//40FXQ4E/AkXMcHSu3dHxA0j9aPYRxMEmV2TiMSbjgRS9JLf/sinlHHUSKqw8uu6ux6wn+UWPWAKxC1Ko3COghHZVWfTaYaS4osU+ZTzoxAOJVhp3uPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915023; c=relaxed/simple;
	bh=241yXwRLhl02dhMa1JydV/OiI8WULKOi2EDxBfHXEgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rxbGeGKH1jWDb5iwcCb9LYeR0ALsbTDPOTc8i85n0eDtdYmQYnv0a/43KqYXqmhKSUfQWXb5k0vyiPMYuffDKj8W2JX90xmstjxgP/G1DvFGYFc4sXyHKKIDXcUwsCi6/aUYTdJCOCq25zGe9JaKyHw5RzSO8SiczB8pS0W8iZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmvKBOP8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmvKBOP8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791915020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eEfH0yNAkAX87QeF4LrPL6ePrsguiJ0NV4pwUXZRlJk=;
	b=UmvKBOP8wGRp/iQWNWqsQgWzF7lPCSc7cNXOWnvZN1qjQR9xFbH6XxPHPN10LvJzkDT28q
	89MzuPH/PGETJRmbdH6WIUNylE2CubJNAxeefAamJlNmzsqf0N2DxwMML9oU21FB7w4WFv
	hyZc5PgIKuEgAwNIFVtDBo0IXo2nhRc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-W783DZk8MoqVIE9m1PWVTg-1; Tue, 13 Oct 2026 18:10:17 +0000
X-MC-Unique: W783DZk8MoqVIE9m1PWVTg-1
X-Mimecast-MFC-AGG-ID: W783DZk8MoqVIE9m1PWVTg_1791915017
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c430f0f01so2612192f8f.1
        for <virtio-dev@lists.linux.dev>; Tue, 13 Oct 2026 11:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791915017; x=1792519817;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eEfH0yNAkAX87QeF4LrPL6ePrsguiJ0NV4pwUXZRlJk=;
        b=IVDGZwxdvyNtznyoWdu3L5x7Scv604GCRvR0PqmQmERrjVgB0iFcQkST3XrubSzBzZ
         ur0akR53JiRmmOhHkdo/4NLFgy15mMG7KIXbORgCGjXiB8i+Abq9Q3Sk+h10hSgQYBOY
         eLj6MxFqKELrDZQkkSV4/BNtsjBQxpm7yw5XEOxy0xtxlEjBYn0rNoQjqS3oiwy5KEHf
         fFA+o4nRSNP9tTdjpzcl9xMOgu370T6Bxn/EcDfbBwxwamkso2Jrx5o29bJEWOJLPJjN
         NONiwS/0ylAHa4lvwSqTT+ztfqUUyW21LiZOMXsduIc9emmQmAFuWx4vjNJJv6gLX6G8
         m3/g==
X-Forwarded-Encrypted: i=1; AKwUvBxlZpbeVylMiu1Rd8jdBVLeBO4aeAEy4QaZd0tIarfrnvu85wVcUBlABoM8n7mLidAJmcurGaCf6FL1@lists.linux.dev
X-Gm-Message-State: AFq9FYKOYCRUNh1UJOWac2mILTQA/PkYDSErNj4Bcy4a8RwGUdssXs6R
	BFGa7MfxisygAkuQKopevyiv4ilQMXVwrxJ3O8rm48MC8qt2uAgV1YGweWA8ehoFLje4qMH3fpH
	hn37/u8g20c3rCy1jUTeEx7Xa6Bj/fzAf1BkmFmXOxuawpRj93OLMezGNkufr30c=
X-Gm-Gg: AYBFou21KKmbww5xz+KA/Cy51DKJ5mViiGtnsmbDRWcyfsPLH5/2B88ec9ik4zzCWX+
	gWcG+OO0ERIFupzNydJqbcIclhR+XCcVSg+q0LuhpgtvNWMWG5rBpcgmtxgRVaXGelS+GH71gXg
	1CiXp3fq9JAO2YJ8lm/kuePMfeSkz7pZcwUI3leJqbCM225yM1vm3QSt1Iy5H04GVdrBAUY/OLF
	Fff+NOKMB7x8zebOw9ookuWsagqNaOV3NE3pE8C2zL+FLuLC/Pd0r2/srRDlJpcbfP17JMcSrs/
	vpI70ibv+qsOZYi+797b/3dG7do3dopfBCxHmxQgBFjru1bkC0jsnJBtZ84VZ9vOia2HGA==
X-Received: by 2002:a05:600c:a404:b0:4a1:9945:98a7 with SMTP id 5b1f17b1804b1-4a1994598ddmr149378955e9.0.1791915016565;
        Tue, 13 Oct 2026 11:10:16 -0700 (PDT)
X-Received: by 2002:a05:600c:a404:b0:4a1:9945:98a7 with SMTP id 5b1f17b1804b1-4a1994598ddmr149378315e9.0.1791915016021;
        Tue, 13 Oct 2026 11:10:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bd777fsm6061806f8f.57.2026.10.13.11.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 11:10:15 -0700 (PDT)
Date: Tue, 13 Oct 2026 14:10:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Linlin Zhang <linlin.zhang@oss.qualcomm.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.linux.dev,
	ebiggers@kernel.org, neeraj.soni@oss.qualcomm.com, parav@nvidia.com
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
Message-ID: <20261013140934-mutt-send-email-mst@kernel.org>
References: <20260917210841.GD331587@fedora>
 <2f9affb3-0d1b-4469-9a66-ba052d2d1b6a@oss.qualcomm.com>
 <20260922131442.GB18339@fedora>
 <3a933df3-dff7-4ef3-a120-4c6e22c1fcc1@oss.qualcomm.com>
 <de535820-591b-40f2-b840-d987c3253765@nvidia.com>
 <9515779b-a6da-407f-99f2-011e51683d15@oss.qualcomm.com>
 <20261008060644-mutt-send-email-mst@kernel.org>
 <d503aee0-9920-4c0b-b9a0-c08e505cc3ea@nvidia.com>
 <426abc9a-c7b4-4631-a5fe-3b2bba1d0414@oss.qualcomm.com>
 <4ed90e46-0dc9-40ba-b8a9-800d40b34ef9@nvidia.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4ed90e46-0dc9-40ba-b8a9-800d40b34ef9@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pBVKF5MGFSyfZyqm_z52kVdkmHfvrkRITChfZZS-L4w_1791915017
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 13, 2026 at 09:07:33PM +0300, Max Gurtovoy wrote:
> This limitation was introduced because we didn't want to add more noise when
> AQ was added (it was already a big change).
> 
> Nothing really prevents adding AQ to mmio transport.

Maybe you guys should get on it if you want everyone to use it.

-- 
MST

