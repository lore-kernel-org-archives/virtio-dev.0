Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9DA1607BB
	for <virtio-dev@lists.linux.dev>; Mon,  1 Jul 2024 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719859481; cv=none; b=miNZTjgcJ9KPi/t4G8leO6J7x/SUb8NTpYo5hTT8YZhJyiERj/eYG0Xp75SmYMTAQe3FCvh+YyXcTG6El46NivXdUb9TIcLPADEO1llhWE+o8zY3xZsm5fXnZJzmpoWAmsqcFKYOr5iUHh9A5e1eidy9yZ+ESB7d5sSDtaJCtLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719859481; c=relaxed/simple;
	bh=IDQpasIZAYmglhlmAzo2Qxwi9GBbAuhLVhBFkVfCjvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=E2Q1azZwTrU7urajZCSPMJ1qtr50t65usT4ee+r6OEHhGwFRmGnlXMMNBnH3mjXW9j1Tmq9tNv9CDzwygQMf2TnGdEKdkEhxh0Gh2JYimBnN+gSmhR0eGbr8APQELY6jK0/ICSTcNPxkyekC0+W99tV5HR2P0CqmsxigZvt36/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvgHqa9k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvgHqa9k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719859478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bAtx+iWTpTQ78hViwyRlQJ5PRJ4z3TNoFTJ+mZsZELU=;
	b=QvgHqa9kzPrX9jb9RAr6epr4JzLkgo9XcHrgX7QBoFNxZPEmq1y1raOGN04zawNVYNcswk
	ANBmAerfgr0l0Te1ms4UZbtlCSL0VY9djJXS5v7y0Oe28iNS+9tFv5Nzlk+OB1WmxdH615
	bNRBXM3yBGZ04Lhz+iJZo9ADzPOn5uU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-9PnwLa8OO0SFEUB2qLc4BA-1; Mon, 01 Jul 2024 14:44:35 -0400
X-MC-Unique: 9PnwLa8OO0SFEUB2qLc4BA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52cd8314430so3266601e87.3
        for <virtio-dev@lists.linux.dev>; Mon, 01 Jul 2024 11:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719859472; x=1720464272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAtx+iWTpTQ78hViwyRlQJ5PRJ4z3TNoFTJ+mZsZELU=;
        b=rCJuKUzXdAD19FnC9pdfuHBvrVloG2atIk+/64/K4YPSvXF8t4kTdA1lZZ0+AYl2ND
         mcMynxKFfqNvZOyeUADzS1Wcsge7f3cCT0sFIK5ZGD1OqPm16l4eo/AhV66RmD6+zwcf
         G7hRWt4ZGd5Kw/AGekdbcGNlu5W33/GjIj7HsI9XGy2fXjiCdCs8QstZf05ASP0YBqVl
         R4e+wGGjRvzh1Nbmt1exLg8ajGhOHtAh9MOTLHXvFdi2bkoH+Rw5ncAueVCk52FgziDQ
         z6fe7YB5IPPzGFO8m25A9xMrkaNRlUICb6fJJaBeQBhdGzON8OakEyqnqH4PLxV6MLnM
         WpOA==
X-Gm-Message-State: AOJu0Yzb49AZZpQv3vsvsb78ofnHG/DB3Vozb0GAoJhm0WtV+dO15dpA
	tifSVhrTcVeiFbnrfLpEG1pg62gkLeuvzLLTb33wbJAFYYfZMpjsbwAjteB5jM42b5qChiNmBAp
	hJmK37vAZv8yuH+Ppq4GPjWiykPnX/C6iogx/5MmEROaoh4jifHF8dOuSHig=
X-Received: by 2002:a05:6512:3b83:b0:52c:a465:c61f with SMTP id 2adb3069b0e04-52e827364cemr5014149e87.56.1719859472496;
        Mon, 01 Jul 2024 11:44:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPTasNBMe6d/jvoQwFwsdXI01LkupaJDa3pyprd2bWtsHe4G+n3dl77/y6LAWIkVQgvVw81w==
X-Received: by 2002:a05:6512:3b83:b0:52c:a465:c61f with SMTP id 2adb3069b0e04-52e827364cemr5014133e87.56.1719859471614;
        Mon, 01 Jul 2024 11:44:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:614d:9fb:6fdd:72a4:f3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55aeasm162135775e9.17.2024.07.01.11.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:44:30 -0700 (PDT)
Date: Mon, 1 Jul 2024 14:44:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Roman Kiryanov <rkir@google.com>
Cc: virtio-dev@lists.linux.dev, JP Cottin <jpcottin@google.com>
Subject: Re: VIRTIO_VSOCK_OP_REQUEST with the same src_port from a guest
Message-ID: <20240701142831-mutt-send-email-mst@kernel.org>
References: <CAOGAQepPkUDF8vmzRiG41xOGhFdDuq8-EHmdTrdVrK6E346G7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAOGAQepPkUDF8vmzRiG41xOGhFdDuq8-EHmdTrdVrK6E346G7A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 01, 2024 at 10:35:57AM -0700, Roman Kiryanov wrote:
> Hi virtio-dev,
> 
> we (Android Studio Emulator) have our own implementation of
> virtio-vsock and we recently found that the virtio spec does not cover
> the situation if a guest sends a VIRTIO_VSOCK_OP_REQUEST packet with
> the same src_port that is already registered on the device side.
> 
> This sounds like an error to me and I don't think I ever saw this
> happening, but it would be nice if the spec explicitly mentioned how
> this situation should be handled on the device side.
> 
> The spec does mention "A VIRTIO_VSOCK_OP_RST reply is sent if ... the
> destination has insufficient resources to establish the connection",
> but I am not sure if this includes the duplicate src_port case. I
> think this means the previously established connection will be broken.
> 
> Thank you.
> 
> Regards,
> Roman.

Another way is just to forbid this from happening.

How does this happen on the driver side?
-- 
MST

