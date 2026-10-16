Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5AD3093CB
	for <virtio-dev@lists.linux.dev>; Fri, 16 Oct 2026 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144113; cv=none; b=MXJ24OzLIEnZBrSRgRYy/pd+doECRlqVe2pTVoiIScAPl8tv3NQ6n1maIlnjYZ11r5y+0sIHRyXWHa9QD2Ymyio6VrWeo/G5TmZb6X/eHcXwH3/fTijCPFjOIMCLv2PaUg2PXAe6CuqDF1HO5yOTBfPihbaHTYPzxp293iUMuoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144113; c=relaxed/simple;
	bh=EmYEvU9N6FUnXc7EIgE0QoelnUJwJSoutmRY6e28KyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=F9enSCZFbT0uVwiMA2ojhw3V9U6CL3I4Du490bCkq8hsZC+B36fl1hiVKas07I39eXj4G5Yn5V8Iu1FASctt0o2IsvRnHniRLm2g8IPLqw90yUnkz6iq7Jn3cho/813Ptx4SyVqOc48C1fiUvOrm8B/zhbA2zfzpbz1AaaRVe3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJp/Eof7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJp/Eof7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792144107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98o4/Rh/f8CKtR99TQ9FUPGVpCO1hitbf+Y8kkKhMeI=;
	b=dJp/Eof7d96nbh5pi/csstPIkCNWvcHe3w3E9wjmKBGT4i9pzvmFb3H+5V+Qwa6HXz0zTk
	bILOW1nJ28TeyqvN+u7QQMv7Q4yYum23vL28nbG1yYvhyLmuB0P3V7XqkO14jc2a1aXKkO
	XaB2mGAYMY5xJ1fk59bba3aexWa2IW8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-3VhLxwzPPzeQk3Zqk7s2Yw-1; Fri, 16 Oct 2026 09:48:26 +0000
X-MC-Unique: 3VhLxwzPPzeQk3Zqk7s2Yw-1
X-Mimecast-MFC-AGG-ID: 3VhLxwzPPzeQk3Zqk7s2Yw_1792144105
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-486f9d150c3so3889044f8f.3
        for <virtio-dev@lists.linux.dev>; Fri, 16 Oct 2026 02:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792144105; x=1792748905;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=98o4/Rh/f8CKtR99TQ9FUPGVpCO1hitbf+Y8kkKhMeI=;
        b=R1EtXBhbiAw9kJGgoRVWU/ekGqLEHITT9pUhnb+gSFvi2KT1J9reJwqCkWH0R1EOj2
         7LHLJ8r5CFcIPrkW/5efvIux5BfHKAPfYikYMRBZ4QeklxEMH4PoSgl+elO6HKNHcFlT
         ESGKqishnTTGmXgIbDn8HNfmvQPotVXS+Tmwtp1zOjMdTMcsqizOwXHQrqa0bq048c0L
         e4faEwQ1lYRdsOt9UuuWBvrhy3d9bAjpJxbV0e9N7DaQ56wY3ydbhSwdc6efSp+UhEy8
         vJU/l8gOoLiCtuya96TSlvqr5Mvjb77OvBby0N0s3ZcWQgTQ0OMMo9cSTzUWEhtOAD2t
         swyw==
X-Gm-Message-State: AFq9FYLkxLZrWdXvYs1onr4w4VCGb7yqSaL+OVPla0MYiddEe9w3/HQm
	luRtdU6NqS8g6HjHDlcKAT5ettAtZOtZ2yEL9n1sdZzOjga1JYcEfUZWzk9lVLcgfAz1EfSnKks
	ZIWbbnQtBHxdoh+sAIJahDpbBsUz04fAnkrh/TrcwTExszD3HF2P3N6lZ5T4fBTE=
X-Gm-Gg: AYBFou1Ja/C45HRYfAS8UD5YO/LHiUg0JsFujQrOIPlXMSYecnd3qkRBrD6b7CjI8XI
	lCtZlMCBsnBxruzlciIs2R/N+Mr6RVICvTdccbIKGMMevKeH0wDABuSyojZFcQJpzWjqmV1ffRc
	CVnigoq8RFXPJvZ5S6+DtsshZSmdSKIXu2lJQsGqeZ9rX4vVYkVAByOrBpKFoZUZc8nXpcrrpdM
	djrZg+Ka8MAMnk0aWuK/qAIZCe+vAB0fVKzzbFDuIlJWWHcnIr31WkgXrCIGGCGIl7No2TO2OZs
	OQEXYltO+xhyDyAHXmhPiYZKF90rPZ+/ySwZG3S0yiS9OZqH+qxwhwUNjn+ktg355yv0jw==
X-Received: by 2002:a05:6000:41cc:b0:48c:7037:aee9 with SMTP id ffacd0b85a97d-48dbad48cc3mr41042733f8f.50.1792144104972;
        Fri, 16 Oct 2026 02:48:24 -0700 (PDT)
X-Received: by 2002:a05:6000:41cc:b0:48c:7037:aee9 with SMTP id ffacd0b85a97d-48dbad48cc3mr41042700f8f.50.1792144104417;
        Fri, 16 Oct 2026 02:48:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8bd9sm4036614f8f.35.2026.10.16.02.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:48:23 -0700 (PDT)
Date: Fri, 16 Oct 2026 05:48:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: virtio-dev@lists.linux.dev, stefanha@redhat.com, ebiggers@kernel.org,
	neeraj.soni@oss.qualcomm.com
Subject: Re: [PATCH v3 1/2] virtio-blk: Add the control virtqueue
Message-ID: <20261016054749-mutt-send-email-mst@kernel.org>
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
 <20260913161628.368484-2-linlin.zhang@oss.qualcomm.com>
 <20261014054309-mutt-send-email-mst@kernel.org>
 <77cf6f89-99a3-42cc-a03f-ef61652f3eb4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <77cf6f89-99a3-42cc-a03f-ef61652f3eb4@oss.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7WSpxTH2s2q67trSALhcjzuwUeoT1B7dbXChpB26ddc_1792144105
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2026 at 04:47:36PM +0800, Linlin Zhang wrote:
> 
> 
> On 10/14/2026 5:43 PM, Michael S. Tsirkin wrote:
> > On Sun, Sep 13, 2026 at 09:16:14AM -0700, Linlin Zhang wrote:
> >> From: linlzhan <linlin.zhang@oss.qualcomm.com>
> >>
> >> Add VIRTIO_BLK_F_CTRL_VQ to advertise control virtqueue support.
> >>
> >> Define the control virtqueue location, driver queue discovery,
> >> and common control request buffer layout. This provides a
> >> standard framework for block-device control commands.
> >>
> >> Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
> >> ---
> >>  device-types/blk/description.tex | 19 +++++++++++++++++++
> >>  1 file changed, 19 insertions(+)
> >>
> >> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
> >> index 3b3a4e7..9bfdc4a 100644
> >> --- a/device-types/blk/description.tex
> >> +++ b/device-types/blk/description.tex
> >> @@ -13,11 +13,16 @@ \subsection{Virtqueues}\label{sec:Device Types / Block Device / Virtqueues}
> >>  \item[0] requestq1
> >>  \item[\ldots]
> >>  \item[N-1] requestqN
> >> +\item[N] controlq, if VIRTIO_BLK_F_CTRL_VQ is negotiated
> >>  \end{description}
> >>  
> >>   N=1 if VIRTIO_BLK_F_MQ is not negotiated, otherwise N is set by
> >>   \field{num_queues}.
> >>  
> >> +If VIRTIO_BLK_F_CTRL_VQ is negotiated, the control virtqueue is appended
> >> +after the request virtqueues. The control virtqueue is reserved for control
> >> +requests defined by this specification.
> >> +
> >>  \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
> >>  
> >>  \begin{description}
> >> @@ -73,6 +78,8 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
> >>      VIRTIO_BLK_REQ_FLAG_OUT_FUA flag in the \field{flags} bitfield of the
> >>      \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT requests.
> >>  
> >> +\item[VIRTIO_BLK_F_CTRL_VQ (22)] Device supports a control virtqueue.
> >> +
> >>  \end{description}
> >>  
> >>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
> >> @@ -274,6 +281,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
> >>  \item If the VIRTIO_BLK_F_MQ feature is negotiated, \field{num_queues} field
> >>      can be read to determine the number of queues.
> >>  
> >> +\item If the VIRTIO_BLK_F_CTRL_VQ feature is negotiated, the driver MUST
> >> +    identify the control virtqueue as queue N, after all request virtqueues.
> >> +
> >>  \item If the VIRTIO_BLK_F_SECURE_ERASE feature is negotiated,
> >>      \field{max_secure_erase_sectors} and \field{max_secure_erase_seg} can be read
> >>      to determine the maximum secure erase sectors and maximum number of
> >> @@ -327,6 +337,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
> >>  The driver MUST NOT negotiate VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without
> >>  VIRTIO_BLK_F_REQ_FLAGS.
> >>  
> >> +If the VIRTIO_BLK_F_CTRL_VQ feature is negotiated, the driver MUST NOT submit
> >> +any request to the control virtqueue unless the request is defined by this
> >> +specification.
> >> +
> >>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
> >>  
> >>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> >> @@ -454,6 +468,11 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
> >>  };
> >>  \end{lstlisting}
> >>  
> >> +Control virtqueue requests consist of a type field in an output buffer,
> >> +followed by an optional command-specific output buffer, an optional
> >> +command-specific input buffer, and a status byte in an input buffer. The
> >> +type field and status byte MUST each be in their own buffer.
> >> +
> >>  The type of the request is either a read (VIRTIO_BLK_T_IN), a write
> >>  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
> >>  (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get device ID
> > 
> > let the driver control buffering.
> > you want the status as 1st byte of input. Then driver can separate
> > it in a buffer of its own.
> 
> Thanks, that makes sense.
> 
> I'll re-word it as the following:
> 
>   - Control virtqueue requests consist of a type field followed by optional
>     command-specific device-readable data, and a status byte followed by
>     optional command-specific device-writable data.

ok

>     The status byte MUST be the first byte of the device-writable portion of the request.

not that informative and stuff like this belongs in a conformance
section anyway. 

> > 
> >> -- 
> >> 2.34.1
> >>
> > 

