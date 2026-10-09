Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF633EC834
	for <virtio-dev@lists.linux.dev>; Fri,  9 Oct 2026 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548748; cv=none; b=stcXcZSn49oV/nPAgIOIggMc46/pV3JyWx/pC/bm2nn+Kmzr8kXL6+yvCBpD8/xN29mgU85d+Jd2XNPAA7DiT02xx2pmznz0GPpUY5XvURBo9NkBHLveXWg46SiHEb0N99K1kONFg5IhDl6rGcXzJ635aJpR5qkCErNsObRyS10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548748; c=relaxed/simple;
	bh=vGE0ZX0SjZwdvfSnajA1zHgVQgklppcN+gAexDlhr1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EyW2aZfhCjt7i5zyv4XSoxANx9cvJ0etxpQrGSEBrKLDOd34NrTubkmw1tGaEtxcTxeuuDW3InBqNgSrRejNKq/qc7+rCMLtb5WxLB+NjVD6KZwrTk7vxDcapJuWrBdFeEYK0fd9wvoStsphqgtRTwACU4ykdfWHnpcKNi9muh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ty/EBuiN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ty/EBuiN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791548740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XFSs1dW/SUlToPLxurheRjTTzI/82c+ud3IcJ2OhVT8=;
	b=Ty/EBuiN6fEanmewgxtIBbLsS2sPJTOnS4SfkEb0Re5ulezNF+5CR8KsZuMSr73YQ67tng
	8Ka6nSNFhzb5junOWsQyfIM8CMUxIMSNS0pJalq13OThhRzVPt2QzWk1hcMWJGXuLvDRO2
	/M47uftu3HHbB6UEh0tiVxc2mMt6dzw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-KWY0cjHUOdiL2DFXJ9zrZQ-1; Fri, 9 Oct 2026 12:25:38 +0000
X-MC-Unique: KWY0cjHUOdiL2DFXJ9zrZQ-1
X-Mimecast-MFC-AGG-ID: KWY0cjHUOdiL2DFXJ9zrZQ_1791548736
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48b028d93c5so3666974f8f.3
        for <virtio-dev@lists.linux.dev>; Fri, 09 Oct 2026 05:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791548736; x=1792153536;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XFSs1dW/SUlToPLxurheRjTTzI/82c+ud3IcJ2OhVT8=;
        b=H5aqiJWlKzh3bkjr8j7ppM58+1OxSFwgZam6/nMGtSO/+wKGtkjzVMszCsLpCpp62f
         D9dAlPgcw1vDl+0ltLzVUGm5gzUfnbQfgrmU+g10qFFMC4J+KqxUnc1gieF/mpEFOgHv
         e3y7sBg7807OjwwJV78RdQJdvnTEgggLDdbngc5X25dqqM8N6IWE6nidczcVaNVpqyQE
         30V4k3OGhcxI/nklLUuiZ0PSxULp1zxdrPLGmE0hqDuYsKJTTrachVpcPau1EyO/eZz+
         BRSZNq6LPOM734dcn8l+71kCHIlNzaQgvssq1OBtdP5j4CawkfKqVZOB87aMLTCrPjcp
         r6uQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWa9kGU0vhH2smbShO9z/gL00lQbXzK9zUYdQocIkDGDN+8n5ijk4fXV2Jv/2BTjO0C5q6S5YKBZpT@lists.linux.dev
X-Gm-Message-State: AFq9FYKhpvhC2D3Lriq8yLOtJriVXl9l1hW4p9k+kdMu2Jmtpo6o5txZ
	CISRo3MQdkurDqNaL09KYnzzqdXUViNyc6VblNJ7huOgr5mvsvxWIn+6k8K+s4AJmnayY+9Hc79
	YZ82ZSvkmYS6UCXGv3WKkui+zgDy0Uo+QXf4sDsTxTvsn77xJuQokoE+actjMDmk=
X-Gm-Gg: AYBFou0VWOI4U+WZSa1fsXLP81Heh5k6hjspZkYWDwozKTEXolncw5lZtOVNrY7IR54
	LYZG78yCUv0KXkS3DR5RVm7TANfug/0v4aZ4nB5JPs1U0TY6utlQd1Cy6cZv49p8oXF3e4TpuP/
	QCA65IwUUfPS7G9CvaO9pXyL3R+NmrcBHEEcUWnfHphvd8iKmk1LH5YSHA6ULPOc2WRSKJpp+CS
	+DuH9ZlGP/98S6bYNpDCCbFdy9p1NEurgSzbdKEde/LgEgkN1QBPNN0OeIZScgPre3RAEvurdvL
	UpKD55L12jI7XKC0TnbTcv0zpEGgSQxkHZ5XFAnQa9SMaSXxzSVYSdqAofI16LRbssGD9KQ=
X-Received: by 2002:a05:6000:22c8:b0:48c:6a50:cb9a with SMTP id ffacd0b85a97d-48dbacf56a0mr3379733f8f.51.1791548735863;
        Fri, 09 Oct 2026 05:25:35 -0700 (PDT)
X-Received: by 2002:a05:6000:22c8:b0:48c:6a50:cb9a with SMTP id ffacd0b85a97d-48dbacf56a0mr3379633f8f.51.1791548735113;
        Fri, 09 Oct 2026 05:25:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9abd574sm3842533f8f.34.2026.10.09.05.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:25:34 -0700 (PDT)
Date: Fri, 9 Oct 2026 08:25:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.linux.dev,
	ebiggers@kernel.org, neeraj.soni@oss.qualcomm.com
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
Message-ID: <20261009081523-mutt-send-email-mst@kernel.org>
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
 <20260917210841.GD331587@fedora>
 <2f9affb3-0d1b-4469-9a66-ba052d2d1b6a@oss.qualcomm.com>
 <20260922131442.GB18339@fedora>
 <3a933df3-dff7-4ef3-a120-4c6e22c1fcc1@oss.qualcomm.com>
 <de535820-591b-40f2-b840-d987c3253765@nvidia.com>
 <9515779b-a6da-407f-99f2-011e51683d15@oss.qualcomm.com>
 <20261008060644-mutt-send-email-mst@kernel.org>
 <bfbb51cb-8a90-4b23-8ed1-26ea41102dd6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <bfbb51cb-8a90-4b23-8ed1-26ea41102dd6@oss.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tSnjpfVvjkJLyAvsQAKW1maLHb8VCPyQlNo0-ARfhkc_1791548736
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Oct 09, 2026 at 07:21:13PM +0800, Linlin Zhang wrote:
> 
> 
> On 10/8/2026 6:15 PM, Michael S. Tsirkin wrote:
> > On Thu, Oct 08, 2026 at 05:17:30PM +0800, Linlin Zhang wrote:
> >>
> >>
> >> On 9/30/2026 6:46 AM, Max Gurtovoy wrote:
> >>>
> >>> On 24/09/2026 12:35, Linlin Zhang wrote:
> >>>>
> >>>> On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
> >>>>> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
> >>>>>>
> >>>>>> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
> >>>>>>> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
> >>>>>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
> >>>>>>>>
> >>>>>>>> This series adds virtio-blk inline encryption support for devices backed
> >>>>>>>> by storage hardware with an inline crypto engine.
> >>>>>>>>
> >>>>>>>> The protocol exposes device capabilities such as keyslot count, maximum
> >>>>>>>> DUN size, and supported key types. Encrypted requests identify a
> >>>>>>>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
> >>>>>>>> capability discovery use the block device control virtqueue.
> >>>>>>>>
> >>>>>>>> The control virtqueue is defined as a generic framework so that its
> >>>>>>>> buffer layout and queue placement are independent of any particular
> >>>>>>>> control command. Inline encryption then builds on this framework with
> >>>>>>>> explicit crypto command formats, capability validation, and keyslot
> >>>>>>>> state semantics.
> >>>>>>>>
> >>>>>>>> All key related operatios are handled in the control virtqueue, and
> >>>>>>>> the crypto I/O request is handled in the request queue.
> >>>>>>>>
> >>>>>>>> For background on inline encryption in UFS and eMMC storage, see:
> >>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
> >>>>>>>>
> >>>>>>>> changes in v3:
> >>>>>>>>   - Add a control virtqueue
> >>>>>>>>   - Move key program/evict/derive_sw_secret/generate/prepare/import to
> >>>>>>>>     the control virtqueue
> >>>>>>> Thank you. This was a big change, especially if you already have an
> >>>>>>> implementation. I appreciate it!
> >>>>>>>
> >>>>>>> My main feedback is that the new control virtqueue commands are not yet
> >>>>>>> documented in enough detail so that implementors could implement them.
> >>>>>>> Once you've decided on the precise semantics, error codes, etc and added
> >>>>>>> them to the spec, then this will round off the inline encryption
> >>>>>>> feature. I look forward to reviewing that in the future.
> >>>>>>>
> >>>>>> Thanks a lot for your comment!
> >>>>>>
> >>>>>> Would you please help clarify what the precise semantics are about? detail
> >>>>>> introduction of the filed in the inline encryption control command struct?
> >>>>>> like struct virtio_blk_crypto_key_desc?
> >>>>> By precise semantics, I mean specifying not just the constants and
> >>>>> structs, but documenting what each command does and how it can fail.
> >>>>> Each of the key slot programming commands needs this. There should be at
> >>>>> least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
> >>>>> VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
> >>>>> VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
> >>>>> VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.
> >>>>>
> >>>>> For example:
> >>>>>
> >>>>> The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
> >>>>> key information is removed and the key slot cannot be used until it is
> >>>>> programmed again. The key slot index is specified by struct
> >>>>> virtio_blk_crypto_key_desc \field{slot} and all other fields in the
> >>>>> struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
> >>>>> slot index is valid, including if the slot is already empty. If the key
> >>>>> slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
> >>>>>
> >>>>> Stefan
> >>>> Thanks for the clear example.
> >>>>
> >>>> I'll follow the same approach and add explicit normative semantics for
> >>>> all inline encryption control requests.
> >>> Can you please explain why we need to introduce yet another VQ type for control?
> >>>
> >>> We've added the Admin VQ as a generic VQ for control operations — I'm not sure why it isn't sufficient.
> >>>
> >>> Adding control VQ to each device type seems strange to me after adding a generic Admin VQ.
> >>
> >> Thanks for your comment! And I agree that the Admin VQ should be considered before
> >> adding another device-specific control virtqueue.
> >>
> >> My understanding is that some of the inline encryption commands(get_crypto_modes/program key
> >> /derive_sw_secret/evict key) are runtime operations of a specific virtio-blk deivce.
> >> In particular, different virtio block devices may have different storage hardware sources
> >> of crypto modes, and keyslot programming and eviction are invoked through the block device's
> >> keyslot manager, and the programmed virtual keyslots are subsequently referenced by the
> >> encryption requests submitted on that device's request virtqueues. These commands are
> >> not about the management operation of device group.
> >>
> >> There is also a transport compatibility concern. The current virtio SPEC states that
> >> 'Devices and drivers utilizing Virtio Over MMIO do not support VIRTIO_F_ADMIN_VQ'.
> >> virtio MMIO is extensively used, so using the Admin VQ would make the feature unavailable
> >> for that transport unless the proposal also extended the MMIO transport.
> >>
> >> For these reasons, currently I believe that a virtio-blk control virtqueue is the better
> >> fit: it keeps the complete key lifecycle associated with the block device and remains
> >> usable across the transports required by the feature.
> >>
> >> I would appreciate any feedback or insights from you and Stefan on the V5 patch series
> >> posted for review before October ASAP.
> >>
> > 
> > Fundamentally, it does not make sense to force all vqs to be admin VQs.
> > 
> > Admin vq would make sense if there is complex resource management going
> > on - like what is happening with all the flow control things in the
> > network device, since they have extensive functionality for managing
> > device resources.
> > 
> > Random device specific commands - I am not sure we want that.
> > It remains to be proven.
> > 
> > But generally why does this go on a special VQ? Is there a reason?
> > 
> > You define distinct request types seemingly and we are not short on types?
> > 
> 
> Thanks for your comments!
> 
> The key programming operation is initiated while preparing a block I/O
> request and sent to the VQ after the block I/O request has entered the
> block request queue, before the request is submitted to the device's VQ.
> see blk_mq_submit_bio(). Using the same virtqueue for both key-program
> command and normal I/O could lead to bio_queue_enter() called 2 times
> for the same block queue, which is possible to have deadlock if
> blk_mq_freeze_queue() is called between above 2 bio_queue_enter() caller.
> 
> A separate control virtqueue provides an independent execution path for
> key programming, key eviction, and related operations. It allows these
> operations to be issued even when the normal request virtqueues are full
> or unable to make progress. Once the operation completes, the corresponding
> request can safely reference the programmed virtual keyslot.
> 
> For such reasons, we believe that a virtio-blk-specific control VQ is a
> more appropriate mechanism than the standard VQ.

I don't understand. Do these commands go through bio queue?
Don't they go to VQ directly, just like you would with the control VQ?

-- 
MST

