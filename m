Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70133AF676
	for <virtio-dev@lists.linux.dev>; Wed, 14 Oct 2026 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971034; cv=none; b=Uzjq8Gi5RMbspWTtTylSojOcCpksXiTHaC8V8VRHI/h59u8dvMTCRQc29Bk8aObZB2apLnuDxzFNKE36EiCIt0IsH9jsIyiyFsn4bCYsUeZKn6fg2AdmkGJ5WdLzan94A+Ik5+Kb8ZMPAmn+6jqoxfe2jJbHYoG9oi10CzIgdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971034; c=relaxed/simple;
	bh=nHRl5QYx6Jr0mry67qFHh78Qgu5ZDWxsRh5yfqGNHiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=F/13+BwOJRCF23V+N6nILcfPBS8TnPZgyYMhU2wHdwmgl1NpVryEqUnEgUqk2OJNoKmclLVp9yp7aUSlpAhpl9otAE3CyeWzaxoCRQHTaaLt0nNIaBu9Oy2GiQUrEMs6nk8FQ+G9JJcN4e5q9OjoJaniRSfVVtlmZzLVaLhnZt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZhDDzNN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZhDDzNN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791971031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3mWp1irY1ipbIEyWW8FkgZxIFvEYvfkpTktA29Jtnz0=;
	b=QZhDDzNNK4SCj5yybgVfP6IGB4qSOxYVgyNTLX9vd0BisVV7cNr7u8hkSL7THHY5/CwPL7
	aKrEjYNkz9rm+mbY4L2xj/90ATTDi4wVJxNN07/keCZv3tv2nXdkOd5IOVgu7NwoA+KqfL
	GORzKEb8oywNBv51DFwn8pLd8b9QZtk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-R93ZUG3jOsepRZkqHDjR5w-1; Wed, 14 Oct 2026 09:43:50 +0000
X-MC-Unique: R93ZUG3jOsepRZkqHDjR5w-1
X-Mimecast-MFC-AGG-ID: R93ZUG3jOsepRZkqHDjR5w_1791971029
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a01b112fa2so11530965e9.1
        for <virtio-dev@lists.linux.dev>; Wed, 14 Oct 2026 02:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971029; x=1792575829;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3mWp1irY1ipbIEyWW8FkgZxIFvEYvfkpTktA29Jtnz0=;
        b=ZoCDGHq2sK8TVRNRIHKEMmILfkyhvtVskmyd94P30mIJameBl4NarFMy7jmF0vEsY2
         HSwYi6DCwsI9D+HPhAfuhEkmNLgx3Q1wgNBM+9RELYifb/1waS+Ne8zUE1VNQwOlFaY8
         yxA8EDJvpH7oCELQNmhjuth9Idnt+AotexZz5X/Dbljm6iuw2ZGoGsIJ72FKG4z48F28
         eFqv5vOZdEgBM8YazhsBsG3Jeu3VbecrPs3LcdNV9mpRYbwl6BLpI3lGvjP7/el7elHy
         FeXL4+3irLTtIsDxzD4dwpwMEHY1oRZpm39xrEhnSgW/Q7wUM/mSag3akEVYAQMwSoLw
         FWRQ==
X-Gm-Message-State: AFq9FYKvHNBS7mvpaY5j3+zkflaqQsqP+aQFAp0bvP8V53yw9+pgV5hr
	KsYtUfgtds0idR2L+pINBG0578nqj3Sk5S/9ZcE2SP5ts+G2zTekpxyA/v9voGBnOW2N405GWRd
	+zsbOUtN9Fn8AKs2Hyo1QMIiAS8Bsk6KbkXuNwGxJuvLiuligipw6UGP3oCcNCKp12z/FOGk=
X-Gm-Gg: AYBFou3/PcYQTJCUX5/ofsxBrD4ThmtWleghlN5RKtEIkl2R5CIN6HTJLsd+BZGtqnc
	zQuYvSqNhWk3GCE8sggsGTrrlkSvVji20euH5VWEyQ+lbBBxRAahj6t8My6lsu2LIKRAcqajDUS
	pKryPUn+KesBC+xER2jamlBW8IYTL/t3K0YMp2T6JRtaId6Wv8zMnBLcJ/6U8pOYuYv6qQPtMcF
	C+PIEUSw3afadAVmBaooEUSNq1sSPKrANeBlUGwlSLq16kAAjyq1PXjkASZ1fnDuDBvIcwGq97S
	/rpz0IwdFf4u9/mHYFh9B2v3QAxPO5qZNxCFDFrHFQmWPN9dChYWFpzYkxyKPLL7iOLYbw==
X-Received: by 2002:a05:600c:83c7:b0:4a1:7733:5102 with SMTP id 5b1f17b1804b1-4a18e4a3fc8mr289246405e9.15.1791971029095;
        Wed, 14 Oct 2026 02:43:49 -0700 (PDT)
X-Received: by 2002:a05:600c:83c7:b0:4a1:7733:5102 with SMTP id 5b1f17b1804b1-4a18e4a3fc8mr289245885e9.15.1791971028561;
        Wed, 14 Oct 2026 02:43:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b4819302sm34568045e9.3.2026.10.14.02.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:43:46 -0700 (PDT)
Date: Wed, 14 Oct 2026 05:43:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: virtio-dev@lists.linux.dev, stefanha@redhat.com, ebiggers@kernel.org,
	neeraj.soni@oss.qualcomm.com
Subject: Re: [PATCH v3 1/2] virtio-blk: Add the control virtqueue
Message-ID: <20261014054309-mutt-send-email-mst@kernel.org>
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
 <20260913161628.368484-2-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260913161628.368484-2-linlin.zhang@oss.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aS5ryehSG4Sc97VxJs87FVZSSu9vXkxSASA7OYnXYdU_1791971029
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 13, 2026 at 09:16:14AM -0700, Linlin Zhang wrote:
> From: linlzhan <linlin.zhang@oss.qualcomm.com>
> 
> Add VIRTIO_BLK_F_CTRL_VQ to advertise control virtqueue support.
> 
> Define the control virtqueue location, driver queue discovery,
> and common control request buffer layout. This provides a
> standard framework for block-device control commands.
> 
> Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
> ---
>  device-types/blk/description.tex | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
> index 3b3a4e7..9bfdc4a 100644
> --- a/device-types/blk/description.tex
> +++ b/device-types/blk/description.tex
> @@ -13,11 +13,16 @@ \subsection{Virtqueues}\label{sec:Device Types / Block Device / Virtqueues}
>  \item[0] requestq1
>  \item[\ldots]
>  \item[N-1] requestqN
> +\item[N] controlq, if VIRTIO_BLK_F_CTRL_VQ is negotiated
>  \end{description}
>  
>   N=1 if VIRTIO_BLK_F_MQ is not negotiated, otherwise N is set by
>   \field{num_queues}.
>  
> +If VIRTIO_BLK_F_CTRL_VQ is negotiated, the control virtqueue is appended
> +after the request virtqueues. The control virtqueue is reserved for control
> +requests defined by this specification.
> +
>  \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
>  
>  \begin{description}
> @@ -73,6 +78,8 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
>      VIRTIO_BLK_REQ_FLAG_OUT_FUA flag in the \field{flags} bitfield of the
>      \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT requests.
>  
> +\item[VIRTIO_BLK_F_CTRL_VQ (22)] Device supports a control virtqueue.
> +
>  \end{description}
>  
>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
> @@ -274,6 +281,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>  \item If the VIRTIO_BLK_F_MQ feature is negotiated, \field{num_queues} field
>      can be read to determine the number of queues.
>  
> +\item If the VIRTIO_BLK_F_CTRL_VQ feature is negotiated, the driver MUST
> +    identify the control virtqueue as queue N, after all request virtqueues.
> +
>  \item If the VIRTIO_BLK_F_SECURE_ERASE feature is negotiated,
>      \field{max_secure_erase_sectors} and \field{max_secure_erase_seg} can be read
>      to determine the maximum secure erase sectors and maximum number of
> @@ -327,6 +337,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>  The driver MUST NOT negotiate VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without
>  VIRTIO_BLK_F_REQ_FLAGS.
>  
> +If the VIRTIO_BLK_F_CTRL_VQ feature is negotiated, the driver MUST NOT submit
> +any request to the control virtqueue unless the request is defined by this
> +specification.
> +
>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>  
>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> @@ -454,6 +468,11 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>  };
>  \end{lstlisting}
>  
> +Control virtqueue requests consist of a type field in an output buffer,
> +followed by an optional command-specific output buffer, an optional
> +command-specific input buffer, and a status byte in an input buffer. The
> +type field and status byte MUST each be in their own buffer.
> +
>  The type of the request is either a read (VIRTIO_BLK_T_IN), a write
>  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
>  (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get device ID

let the driver control buffering.
you want the status as 1st byte of input. Then driver can separate
it in a buffer of its own.

> -- 
> 2.34.1
> 

