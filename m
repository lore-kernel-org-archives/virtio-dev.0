Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327BA15CD6F
	for <virtio-dev@lists.linux.dev>; Fri,  7 Jun 2024 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755746; cv=none; b=EB7g7rWPHTZb4R1poRGy3HFIqT8yZZDW3t/0JLNtONj8j+c+qhb1VbAsM5H+9Mk1mC8aVjIrOIDHcbfxB8sOoBgMDZ6B/jf4ci4+28xRLtWkDwPHkFPR8G4fpFurQtvKQFkefh7DTwqzkvbwDILy7Qc4rnU02momNqkZ/A04GE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755746; c=relaxed/simple;
	bh=E5a8JUqw2N0hu4wfsPwoSSZDyCfON7mvBB+h9/6ocMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RcYbAy4euSN+sMNxU3qq3jE4G4qTid2syYwAqUlKnAfmWrCd7R4pvxVu/euxkbov2WwiVnP7EeUx8Cu5hxP+0LRl2jjuA5b6V/9WWxdDBkjkxhCA/rAs79K8sZm+ets/O+UYnCjgxB7lF/Raamxnbh4hppNfdIAJ22kS5sbCggc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNoAQOZZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNoAQOZZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717755744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJVnADXrO6bWPgEbeB24YGs9MChqka2QoUiw3f4S0b8=;
	b=WNoAQOZZHoxYm4SfZ/NFwWnGh4omXmPuJZUynhw7kgPfO2Vop3/RIs4XkK/Dcdwk6uQHVo
	drOMhfV55HQjaJvgOWPidFPyvGrz1IxT338fq7ATgx82D3RqqIfBrerOaE5pmPH2ntcu6G
	moRC9lumPKE/If+UX5kycsIliMdBPL4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-LJlHFLlXMGiW4pPMAc3YLQ-1; Fri, 07 Jun 2024 06:22:23 -0400
X-MC-Unique: LJlHFLlXMGiW4pPMAc3YLQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-57a52cb6d86so1180734a12.1
        for <virtio-dev@lists.linux.dev>; Fri, 07 Jun 2024 03:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717755741; x=1718360541;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJVnADXrO6bWPgEbeB24YGs9MChqka2QoUiw3f4S0b8=;
        b=t9KcDNmhWEaFd6s6AlPxrcwVwONbw2KW8NaiyLAO2TZwCAr2k6gJfA7blGvbW+WtyW
         1xR4JXNKNO7zfCjVfrAq7H6XykqJd5FH8YIUwodQK+Sf5oO5Y5SBUwI8GloKhq8NsEzD
         nBT9SGB5SWN2tRnaTJjFGMtAe6SCK8uvodvioNGwpFdCGKJxoHYAmFZHjZDn0k80wdCU
         51cRX1eparJqjCaakeqCu2A1silVR2smuHJlwiEqVIkVOdQcbupxNiC1lvqOfFF26+4b
         oi0UY+u52c3p/aZq1R/Sr+WBRz7VTOX77Fwguh992i8pdlgcN250LNADwZ86c3bKSEAH
         29sQ==
X-Gm-Message-State: AOJu0YxwLAVeF9KwmdJwykSQYnBM07xaE7jZXq9jqM7V0J8rlaRDPP97
	EBaC+bWI4M1e0CRNdcjADVc/PFjJyiEn2B7QMBqG9P9c1ZrohOmDoFEX1ernzle2QAl14uB8ndb
	EzCQ5FNhwzCpntjvMJaxFqutLLmONfcE/LVIF0u0BLBQ0RKAOgX1hzRIPX6M=
X-Received: by 2002:a50:9fa5:0:b0:57a:73cd:abac with SMTP id 4fb4d7f45d1cf-57c50890727mr1214425a12.4.1717755741535;
        Fri, 07 Jun 2024 03:22:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA97Dxl/qMWzh5eAPEO6ZdHAbQ5vkY4UwvSy7moo8NKVscr5W2VllHhaiGUt1GpW/cURenTQ==
X-Received: by 2002:a50:9fa5:0:b0:57a:73cd:abac with SMTP id 4fb4d7f45d1cf-57c50890727mr1214400a12.4.1717755740763;
        Fri, 07 Jun 2024 03:22:20 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:d5af:1ef7:424d:1c87:7d25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae232981sm2516239a12.83.2024.06.07.03.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:22:20 -0700 (PDT)
Date: Fri, 7 Jun 2024 06:22:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: virtio-dev@lists.linux.dev, Matti.Moell@opensynergy.com,
	cohuck@redhat.com, acourbot@chromium.org,
	daniel.almeida@collabora.com, Alexander.Gordeev@opensynergy.com,
	changyeon@google.com, alex.bennee@linaro.org,
	gurchetansingh@google.com, ribalda@google.com,
	nicolas.dufresne@collabora.com, eballetb@redhat.com,
	linux-media@vger.kernel.org, virtio-comment@lists.oasis-open.org
Subject: Re: [PATCH v2 0/1] virtio-media: Add device specification
Message-ID: <20240607062139-mutt-send-email-mst@kernel.org>
References: <20240607080045.1337046-1-aesteve@redhat.com>
 <20240607053839-mutt-send-email-mst@kernel.org>
 <CADSE00KP+dsN5W0DHzML8f4wjiH-NQEifQ5zxLusw65mEUb+wA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CADSE00KP+dsN5W0DHzML8f4wjiH-NQEifQ5zxLusw65mEUb+wA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jun 07, 2024 at 11:48:36AM +0200, Albert Esteve wrote:
> 
> 
> On Fri, Jun 7, 2024 at 11:41 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     On Fri, Jun 07, 2024 at 10:00:44AM +0200, Albert Esteve wrote:
>     > Hi,
>     >
>     > This a formal attempt of including virtio-media
>     > device specification.
> 
>     This was sent to a wrong mailing list.
>     Please repost to the correct list.
> 
>     Albert, when you subscribed to virtio-dev you should
>     have received a message that read, in part:
> 
>     When to use this list:
>     - questions and change proposals for Virtio drivers and devices
>       implementing the specification.
> 
>     When not to use this list:
>     - questions and change proposals for the Virtio specification,
>       including the specification of basic functionality, transports and
>       devices (please use the virtio-comment mailing list
>       [mailto:virtio-comment@lists.linux.dev] for this).
> 
>     To do:
>     - send email preferably in text format (best for archiving)
> 
>     Not to do:
>     - copy both virtio-dev and virtio-comment mailing lists (instead, pick
>       one)
>     - send full copies of the virtio spec (in any format)
> 
> 
> 
>     So what made you send a specification change proposal to
>     virtio-dev, and also copy the defunct, non-functional
>     list at virtio-dev@lists.oasis-open.org ?
> 
> 
>     Was the message unclear? If yes I'd like to improve it.
> 
> 
> My bad.
> The instructions were clear, and I set up the mail to be sent to the
> correct virtio-dev mailing list address.


Hmm no, it's actually virtio-comment@lists.linux.dev for change
proposals for the Virtio specification which is what you have here.


> But I had the configuration
> of the project set to automatically add both of the old addresses to the
> patch. I only noticed after sending, so the damage was already
> made. 
> 
> I will fix it for the next drop.
>  
> 
> 
> 
>     --
>     MST
> 
> 

