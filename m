Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BED3CF1FF
	for <virtio-dev@lists.linux.dev>; Thu,  8 Oct 2026 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454515; cv=none; b=Z4dCWVvApsK4tT1hZ0ZMkdlvPwSSJGWrRN7wGb72l3UNtvmhLG1jcXxOoO2izpZ4Zkx/tyIMIO8CjNNrQjyK5lZmslQxsFsdpLwmD8RHsaFcMX758CzttKaHVQBCIxqWl7gwpGlKj9ANKJbCF5VfJF7/QWH3gI15L+aPJRr/lnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454515; c=relaxed/simple;
	bh=uPE1oHHfo4XCC5ELvbrqTmaiy53eKvdKX2wCNLa/h7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JIbHHsGw419sS2qRmQpT2Z6VhzBGZkk2Jt9OWuGPO5nnaoCjOiKVwBlCjKVsCM5xLz749xKBy+Wgrk/BQevA9rUKIQNHncOVaN3hLiQO+ags+HqtMOrZfu3pBO5uGBVIRj4VmEdvVIE7aSYzEzHwhXy3rYfDyUvOSMPBwVDg3+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HoK43fMC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoK43fMC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791454512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v44TfkwQRevPPvDf4uTdKt3oCF5GZOsg/l7riPKjP6A=;
	b=HoK43fMCftCzZRxkTC9pZDl30GsPvT0efbTfE048dPkvTs2FUmwocSRg8jNeUl0yCg0pdN
	aT7CcFABIX1f2L6XnNjWN3Q5APL1P06ZLxPgkPcnbIs0k1iehbLisL+xtKVFYC/GQWAEN7
	6PDu/jJFPfg0seOevL9dyI3kUkZyUh0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-A_3lIJHBOqKT6OLBYn6O6w-1; Thu, 08 Oct 2026 06:15:09 -0400
X-MC-Unique: A_3lIJHBOqKT6OLBYn6O6w-1
X-Mimecast-MFC-AGG-ID: A_3lIJHBOqKT6OLBYn6O6w_1791454508
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a168a8209fso5291335e9.0
        for <virtio-dev@lists.linux.dev>; Thu, 08 Oct 2026 03:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791454508; x=1792059308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v44TfkwQRevPPvDf4uTdKt3oCF5GZOsg/l7riPKjP6A=;
        b=FpORWIs/Vlp3adRUzEliv3jAYljcAdEn/93hUH2zXI00leCuKovW/SuP22H0Bnwzjq
         +Fr/9/WxMLSkWtiBRg4eS1OK6aQPC+WPlRs+lkTwaZa5zGpqUQV5xOB27uLC+W6u99I7
         aCPZufNW4zhZtukLztMkIEwVZkR8pVQA2E6wJoBo/kBZ32WNH6QLvf4T+9KGpHCKeaia
         JkwAh3fHhmDkPaERYxHm+3BF7+8sMrc/EeWQWD4knRihAiAYHnCfyAt+UdQ6t2kt5eNc
         GDc9JSCudw4HHiSbBdUeNixWnZSUZJNeUeSF/9dIIfoHC6Bq88m4DclzhIKxDsMQxdvp
         5O7A==
X-Forwarded-Encrypted: i=1; AKwUvBxqFLVvG5OVnD1027Iz4a0M1+eL78PznCivvDEJUcr92mHcsF2wUR1APM/FNtz3B+YB4ZCeZqQ3XTrm@lists.linux.dev
X-Gm-Message-State: AFuF++lmxEELTjjNqJ4INsRa3gK3LoQllwt9i6cZ7U2tiuUbzZRLBJ7p
	z0TlKYfE2frqyerYRI0LM+FcrFB2cPeaWdCrZ/jLu+plyMjEBF0m6G6Qsq7MeVIyyOU/a180NpO
	TB3Ko65Z9xWTEstaUmW9Rtia44q+PYEz00Sm+6tHP698SoBHiRvGTGX0mqNWVZqA=
X-Gm-Gg: AYBFou1Q3Z3oMciD7aONO2l04poEHv60ibdKa7mvU5m3dGBzSMZKjWozLKeCbjLWF0u
	TKk53aAuR3HwZZ+AyEO/mjWVKbcw96BSJkO/0F51OZw4jWAXhHIh6RXRUsPB5duo79dJQwuT6gC
	tnfwKeEoPb9a0kbBggx61qBzHPyIWkfbr996yswpAYOwq9E0AMwDexPlsUEuxsJ/rUWZ6bP1hMH
	t9vqOJohhJXoIm25fC0fEEWrWeo31uiXbymWkCVNkseWEx+k0Vz9v4QxP2VvPeyUf4OrDh7SNKs
	+cHvlwccLOX/IanXthhUPTsGubGqIOtjLGGx/xv9DXleHTbq5ylZKrkLwjw/vO5fE7kCN1E=
X-Received: by 2002:a05:600c:4fd4:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4a1851ac4c7mr35326215e9.5.1791454507810;
        Thu, 08 Oct 2026 03:15:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4fd4:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4a1851ac4c7mr35325855e9.5.1791454507237;
        Thu, 08 Oct 2026 03:15:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a180310c9fsm108693655e9.4.2026.10.08.03.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:15:05 -0700 (PDT)
Date: Thu, 8 Oct 2026 06:15:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.linux.dev,
	ebiggers@kernel.org, neeraj.soni@oss.qualcomm.com
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
Message-ID: <20261008060644-mutt-send-email-mst@kernel.org>
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
 <20260917210841.GD331587@fedora>
 <2f9affb3-0d1b-4469-9a66-ba052d2d1b6a@oss.qualcomm.com>
 <20260922131442.GB18339@fedora>
 <3a933df3-dff7-4ef3-a120-4c6e22c1fcc1@oss.qualcomm.com>
 <de535820-591b-40f2-b840-d987c3253765@nvidia.com>
 <9515779b-a6da-407f-99f2-011e51683d15@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9515779b-a6da-407f-99f2-011e51683d15@oss.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3WG4zRoqSLrdGcW_qzoCkqcZ5_7pi_PGhUMxhDMvqxY_1791454508
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Oct 08, 2026 at 05:17:30PM +0800, Linlin Zhang wrote:
> 
> 
> On 9/30/2026 6:46 AM, Max Gurtovoy wrote:
> > 
> > On 24/09/2026 12:35, Linlin Zhang wrote:
> >>
> >> On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
> >>> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
> >>>>
> >>>> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
> >>>>> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
> >>>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
> >>>>>>
> >>>>>> This series adds virtio-blk inline encryption support for devices backed
> >>>>>> by storage hardware with an inline crypto engine.
> >>>>>>
> >>>>>> The protocol exposes device capabilities such as keyslot count, maximum
> >>>>>> DUN size, and supported key types. Encrypted requests identify a
> >>>>>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
> >>>>>> capability discovery use the block device control virtqueue.
> >>>>>>
> >>>>>> The control virtqueue is defined as a generic framework so that its
> >>>>>> buffer layout and queue placement are independent of any particular
> >>>>>> control command. Inline encryption then builds on this framework with
> >>>>>> explicit crypto command formats, capability validation, and keyslot
> >>>>>> state semantics.
> >>>>>>
> >>>>>> All key related operatios are handled in the control virtqueue, and
> >>>>>> the crypto I/O request is handled in the request queue.
> >>>>>>
> >>>>>> For background on inline encryption in UFS and eMMC storage, see:
> >>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
> >>>>>>
> >>>>>> changes in v3:
> >>>>>>   - Add a control virtqueue
> >>>>>>   - Move key program/evict/derive_sw_secret/generate/prepare/import to
> >>>>>>     the control virtqueue
> >>>>> Thank you. This was a big change, especially if you already have an
> >>>>> implementation. I appreciate it!
> >>>>>
> >>>>> My main feedback is that the new control virtqueue commands are not yet
> >>>>> documented in enough detail so that implementors could implement them.
> >>>>> Once you've decided on the precise semantics, error codes, etc and added
> >>>>> them to the spec, then this will round off the inline encryption
> >>>>> feature. I look forward to reviewing that in the future.
> >>>>>
> >>>> Thanks a lot for your comment!
> >>>>
> >>>> Would you please help clarify what the precise semantics are about? detail
> >>>> introduction of the filed in the inline encryption control command struct?
> >>>> like struct virtio_blk_crypto_key_desc?
> >>> By precise semantics, I mean specifying not just the constants and
> >>> structs, but documenting what each command does and how it can fail.
> >>> Each of the key slot programming commands needs this. There should be at
> >>> least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
> >>> VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
> >>> VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
> >>> VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.
> >>>
> >>> For example:
> >>>
> >>> The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
> >>> key information is removed and the key slot cannot be used until it is
> >>> programmed again. The key slot index is specified by struct
> >>> virtio_blk_crypto_key_desc \field{slot} and all other fields in the
> >>> struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
> >>> slot index is valid, including if the slot is already empty. If the key
> >>> slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
> >>>
> >>> Stefan
> >> Thanks for the clear example.
> >>
> >> I'll follow the same approach and add explicit normative semantics for
> >> all inline encryption control requests.
> > Can you please explain why we need to introduce yet another VQ type for control?
> > 
> > We've added the Admin VQ as a generic VQ for control operations — I'm not sure why it isn't sufficient.
> > 
> > Adding control VQ to each device type seems strange to me after adding a generic Admin VQ.
> 
> Thanks for your comment! And I agree that the Admin VQ should be considered before
> adding another device-specific control virtqueue.
> 
> My understanding is that some of the inline encryption commands(get_crypto_modes/program key
> /derive_sw_secret/evict key) are runtime operations of a specific virtio-blk deivce.
> In particular, different virtio block devices may have different storage hardware sources
> of crypto modes, and keyslot programming and eviction are invoked through the block device's
> keyslot manager, and the programmed virtual keyslots are subsequently referenced by the
> encryption requests submitted on that device's request virtqueues. These commands are
> not about the management operation of device group.
> 
> There is also a transport compatibility concern. The current virtio SPEC states that
> 'Devices and drivers utilizing Virtio Over MMIO do not support VIRTIO_F_ADMIN_VQ'.
> virtio MMIO is extensively used, so using the Admin VQ would make the feature unavailable
> for that transport unless the proposal also extended the MMIO transport.
> 
> For these reasons, currently I believe that a virtio-blk control virtqueue is the better
> fit: it keeps the complete key lifecycle associated with the block device and remains
> usable across the transports required by the feature.
> 
> I would appreciate any feedback or insights from you and Stefan on the V5 patch series
> posted for review before October ASAP.
> 

Fundamentally, it does not make sense to force all vqs to be admin VQs.

Admin vq would make sense if there is complex resource management going
on - like what is happening with all the flow control things in the
network device, since they have extensive functionality for managing
device resources.

Random device specific commands - I am not sure we want that.
It remains to be proven.

But generally why does this go on a special VQ? Is there a reason?

You define distinct request types seemingly and we are not short on types?

-- 
MST

