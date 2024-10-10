Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681FC2A1D3
	for <virtio-dev@lists.linux.dev>; Thu, 10 Oct 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577045; cv=none; b=iNXEFgxe8m7n4C3Rd8IOiVcIpPeQ400pmvSg+QP72rbzXF6wTfAGyOr8Ly2BumtTitODK/ID8RRNU7cKlj3ABD/lHeoSUFms7tQfasuQSNjtqKXAFN8rxM5zgg43K0wNC7QMEC6rGUrlu8tXgPubrsMIIHQ5HNXZHpGYRRTp2aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577045; c=relaxed/simple;
	bh=sDPEpumwOwMXVZF1NJRop458vAqJf5bX1yKinckuCQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=adGX2wXmQpAk3KM+BM/f1LdZ8dKN0c5tUNhsGmO2fpIPyirq4jRr1fHyxgvVo1gp4kOEt7t07vtGH3VgB9obD0ZbaI3Gv8/KPGEcpG8NUFPTncGuN/YLvgoMhRXxB+Jc/C/IHeXLCYJJiE0pzegUBAX79nKWG5Ioe8m0acKc2F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pw2YBeh5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pw2YBeh5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728577042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F8D07boHcgY+s1K9ISE/p5PpbEV3g5iXZthl0RwXjm8=;
	b=Pw2YBeh5Yn5+/ptuS8eHwELMGbDUEWbjMJuFMnByQKSyb3PtqS6ozsRTzqVxvATAKz/7is
	+GQ0twGkREFSpHTm6R/Nz/LBWhIxsyrk/eJyJyWoxzRWh87WjwH708UUI7/J6opZSfraO5
	RtPG6NmEaX1PuPIon+c9jzS+s6dmakE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-7D80gchON7CkZnze2ga0Hg-1; Thu, 10 Oct 2024 12:17:19 -0400
X-MC-Unique: 7D80gchON7CkZnze2ga0Hg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4311412e042so6837365e9.2
        for <virtio-dev@lists.linux.dev>; Thu, 10 Oct 2024 09:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728577038; x=1729181838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8D07boHcgY+s1K9ISE/p5PpbEV3g5iXZthl0RwXjm8=;
        b=iQl2nXPvBtpGdMCowDuW432bNTq7bmkBJH5uEb9GNBpVDxnVHHfCRbsoWynWWh3w77
         mWFQ9tDuge0a3jmA8hjKi9US3cG7rsWoGMXbc7GJ5450B1A0QCjRV542Qj6xh5xu/6jX
         08h+3LJ3tV5giqvByy2ftt4kb/WxvddpyWyw9CYWxmUVJkYzHen8K9rJFHpxatjf5vKh
         +YEKt1ptk3/p/JN5d0+ZwMtNDoO5lx0M6iFrgG3APNZ4dzB8iOykdGhVgQvUVM6MLtLl
         ICuPMenPU/HXX7FG+cgHMB4twur0aq0Ety5v6eS/hM1inluwBOp5MhcXgCkrIXs+ojXF
         fQfw==
X-Forwarded-Encrypted: i=1; AJvYcCU3aVNyYpxRcJlrXW4ui99oQRoY2QDvSbWz0SUw5TqEs3Jm14KPq3AnzFPS55qXKMuCduTDGiMlzdV5@lists.linux.dev
X-Gm-Message-State: AOJu0YzqwfxzOArUgtxyIHkYYfnnNMr0/ILYUbScmRY/MBso5zh/okGh
	H6WSFxHzHvCA5HXShbC4psF2/AwVOIe5i1ESufPrgOzpbcjKk+lYqsV1xq9jW5d3jeaCWHqId5w
	hZzR/HnSB9ELel9f0N/9rKy7zfeR3WSQXe+p+/xdR5jXYJ5Ev3uJB7iKF1qM=
X-Received: by 2002:a05:600c:70a:b0:431:1c68:1db5 with SMTP id 5b1f17b1804b1-4311c681f02mr3514165e9.14.1728577037639;
        Thu, 10 Oct 2024 09:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnmlNv8/qz4Exm3aw9q+r+Px6+nvOrDA7PzICnxgepk68yQ0PNm4OIk0tANHMdzoON7eYBQg==
X-Received: by 2002:a05:600c:70a:b0:431:1c68:1db5 with SMTP id 5b1f17b1804b1-4311c681f02mr3513855e9.14.1728577037124;
        Thu, 10 Oct 2024 09:17:17 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:fb13:fd72:22f:64e2:b824])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4311835d8f6sm20261105e9.44.2024.10.10.09.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 09:17:15 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:17:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: dverkamp@chromium.org, virtualization@lists.linux-foundation.org,
	mvaralar@redhat.com, stefanha@redhat.com,
	virtio-dev@lists.linux.dev, oren@nvidia.com, parav@nvidia.com,
	nitzanc@nvidia.com, benwalker@nvidia.com
Subject: Re: [PATCH v4 1/1] virtio-blk: Add description for blk_size field
Message-ID: <20241010121303-mutt-send-email-mst@kernel.org>
References: <20241010160725.3087-1-mgurtovoy@nvidia.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241010160725.3087-1-mgurtovoy@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 10, 2024 at 07:07:25PM +0300, Max Gurtovoy wrote:
> This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
> offered by the device.
> 
> The blk_size field actually represents the logical block size of the
> device. It is always a power of two and typically ranges from 512 bytes
> to larger values such as 4 KB.
> 
> Add description for this field to provide clarity on its constraints.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/208
> Reviewed-by: Daniel Verkamp <dverkamp@chromium.org>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>


I have a general question here. Do we need this field before
feature negotiation? If not, I would actually say here that
it exists only if feature has been negotiated.
This opens the door for devices to detect legacy drivers
that do not read block size and work around, somehow.


> ---
>  device-types/blk/description.tex | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
> index 2712ada..0ddc223 100644
> --- a/device-types/blk/description.tex
> +++ b/device-types/blk/description.tex
> @@ -135,6 +135,9 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>  present. The availability of the others all depend on various feature
>  bits as indicated above.
>  
> +The field \field{blk_size} exists only if VIRTIO_BLK_F_BLK_SIZE is offered by the device.
> +This field reports the block size of the device, expressed in bytes.


I would reorder here, too.
The field \field{blk_size} reports the block size of the device,
expressed in bytes. This field exists only if VIRTIO_BLK_F_BLK_SIZE is
offered by the device.

> +
>  The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This field specifies
>  the number of queues.
>  
> @@ -282,6 +285,13 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>  
>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>  
> +Drivers SHOULD negotiate VIRTIO_BLK_F_BLK_SIZE if the feature is offered by the
> +device. When negotiated, drivers SHOULD interpret the \field{blk_size} as the
> +logical block size.
> +
> +If the VIRTIO_BLK_F_BLK_SIZE feature is not offered by the device, then drivers
> +MAY assume that the logical block size is 512 bytes.
> +
>  Drivers SHOULD NOT negotiate VIRTIO_BLK_F_FLUSH if they are incapable of
>  sending VIRTIO_BLK_T_FLUSH commands.
>  
> @@ -319,6 +329,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>  
>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>  
> +Devices SHOULD always offer

I don't get what does always mean here. also the feature?

> VIRTIO_BLK_F_BLK_SIZE feature. When this feature is
> +offered, devices MUST initialize \field{blk_size} to a power of two greater
> +than or equal to 512.
> +
>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
>  if they offer VIRTIO_BLK_F_CONFIG_WCE.
>  
> @@ -879,6 +893,14 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>  The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN
>  and VIRTIO_BLK_T_OUT requests.
>  
> +When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, the length of
> +\field{data} SHOULD be a multiple of \field{blk_size} for VIRTIO_BLK_T_IN and
> +VIRTIO_BLK_T_OUT requests.
> +
> +When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, the value of
> +\field{sector} (multiplied by 512) SHOULD be a multiple of \field{blk_size} for
> +VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests.
> +
>  The length of \field{data} MUST be a multiple of the size of struct
>  virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
>  VIRTIO_BLK_T_SECURE_ERASE and VIRTIO_BLK_T_WRITE_ZEROES requests.
> @@ -966,6 +988,16 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>  for a write request if the VIRTIO_BLK_F_RO feature if offered, and MUST NOT
>  write any data.
>  
> +When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, the device MAY
> +set the \field{status} to VIRTIO_BLK_S_IOERR for VIRTIO_BLK_T_IN or
> +VIRTIO_BLK_T_OUT requests if the requested \field{sector} (multiplied by 512)
> +is not an integer multiple of the device's \field{blk_size}.
> +
> +When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, the device MAY
> +set the \field{status} to VIRTIO_BLK_S_IOERR for VIRTIO_BLK_T_IN or
> +VIRTIO_BLK_T_OUT requests if the length of the requested \field{data} is not an
> +integer multiple of the device's \field{blk_size}.
> +
>  The device MUST set the \field{status} byte to VIRTIO_BLK_S_UNSUPP for
>  discard, secure erase and write zeroes commands if any unknown flag is set.
>  Furthermore, the device MUST set the \field{status} byte to
> -- 
> 2.18.1

