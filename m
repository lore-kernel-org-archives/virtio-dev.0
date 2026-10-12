Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044E3B8BD4
	for <virtio-dev@lists.linux.dev>; Mon, 12 Oct 2026 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791844451; cv=none; b=JAujx3TUW5xhiEvMR+7Bl9DmKontGWHI14lCW0XuMZtX536l5c/A+klHXYHacj6hzGuyyBOVNwpi9QLlcxdJPJCrVbyPt1TgSmcwaWDym6VU3BBice/PsO53Pqv7pszTRwOxngBWFCg2lZQtRfFBjD//wjrPV78n0oen+kPfE8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791844451; c=relaxed/simple;
	bh=bAW8LaogUxoy0Sos8VPU79jNCoCEWKgozEq8yclbxy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KCGkyvXIO5vD6zHqgV7bh3iaPKUsbJOYRhTW+0yu3DTRNLvdR2syvF3RwrV4abvD6yvyy4ond9+T8VFEvpVLXD7U4i26bLCPYJydOPX/cS7IYVO0wK41V+uouyKRERaQLxaIe40j2C/LwnZguJOAm2o2ixPF4pMh7XgGh8l69pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+CE5ysE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+CE5ysE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791844447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgkxjhQt4N/cho4i4PYmNkOzxbZ+/168O8wNxtUBiok=;
	b=V+CE5ysEfBLatQDY6zTWKT9MmbETSxIDgNF7RfUUPcPmYhlQyZPPMZ1yxu0Qz+eUJyjx5l
	aUtiBInh/OTTH2vH8Sjq/ouBsgMhg0m87tNNbIbld7FfAvI4Zmycuh//65u+6LqTACDWVg
	upTNwnOywRuOKyzgPgML3+9f7sd9nHc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-KsDtYkgGMzqc4JD3MCEE3w-1; Mon, 12 Oct 2026 22:34:06 +0000
X-MC-Unique: KsDtYkgGMzqc4JD3MCEE3w-1
X-Mimecast-MFC-AGG-ID: KsDtYkgGMzqc4JD3MCEE3w_1791844445
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48af5a07314so1351585f8f.2
        for <virtio-dev@lists.linux.dev>; Mon, 12 Oct 2026 15:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791844445; x=1792449245;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lgkxjhQt4N/cho4i4PYmNkOzxbZ+/168O8wNxtUBiok=;
        b=a19VvJ9vOJHT3xLtrIvLobfg2bVFVK+1L2UbS4+vNjEWCbLQPviKvZ6RAiLPy2g0lJ
         aC3lx3Ja3SL+ZQ2uPp5jvdZoAph1s7Bszq6//W7NTZ16wZXVRg/G9pG3nYtUlb3WdRf2
         +e38AUAE96Qb3RF3IqFFz0X0OJzCFjcYMGwora1pgWYWWaoBxsEl9aDEuQXe2fCW8HYj
         picOd4OC8nrl8HPGs8Jtgf5TXSH+0EZO5siG8Xs+Xq2w9qobVJ5+9wMNmwLjhKfXkAJ7
         4yZUBhljx8icG8WLpkMxPF6d4uedCphdd8XlSAL+/8VBf8c3cBLWS4Z/Ry8ql07gCkj5
         hIRQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGST9vakjNqw0kAOELisBEhr+3zrpjJ5klMkY/ko3gX0DVoemHGcMk1zMXACdwG1XD0cMg1K6LcBQm@lists.linux.dev
X-Gm-Message-State: AFq9FYLVMZ/6bxV3Z4T0CTW3/F6LGOIsMygvDy3p0kNy/SDuaQxqMpiu
	g34LK+/hLFMeYgfhf4sp66ITTQFVzN061gxihZYd2zWVivTLz4meEZjugvI+XctIpL4+CigDkXc
	lApRKKivuIADhuGcIhOn+Hy0xBgh8viJLrWlgNrTpABFJRgAKadoX6BiTQ7Z1cWTCPieEO7k=
X-Gm-Gg: AYBFou06j1Eywqn25GQCvlfzs5Ko1eV3K3ua3Grz8pgREY/PI8PJECFyoWj5UEab0FU
	HUjDL78zKiRn2s2NGJoKeFBOsrUwIAQXSkhrPPSS22bsVu+RTqjPkUVBtlKkXwJ1U8tVw+bYauu
	31QddCZk6iZtdufIABHqajTF5OVLyAUBsfFwwSh0A4uE/BxLW8fmJbx2tMaBfXXmHoW45C9ROA2
	3f9AAPf+EPnZXZjT2B5vTtDQG+otag0HnxCYyQqg50Al6CbwX/c5wQofShxqmu+EohMI5DX/57i
	VGAdCGTR2dcjPADtmOSWMt3b8S+QIdGM4RTupT9KtasjulJvowJvOtIPIaGX3O6ECpRdGg==
X-Received: by 2002:adf:e80b:0:b0:487:342:d141 with SMTP id ffacd0b85a97d-48dbaae8b8dmr14677248f8f.23.1791844445089;
        Mon, 12 Oct 2026 15:34:05 -0700 (PDT)
X-Received: by 2002:adf:e80b:0:b0:487:342:d141 with SMTP id ffacd0b85a97d-48dbaae8b8dmr14677175f8f.23.1791844442986;
        Mon, 12 Oct 2026 15:34:02 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc5e0asm1600749f8f.50.2026.10.12.15.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 15:34:01 -0700 (PDT)
Date: Mon, 12 Oct 2026 18:33:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.linux.dev,
	ebiggers@kernel.org, neeraj.soni@oss.qualcomm.com
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
Message-ID: <20261012183102-mutt-send-email-mst@kernel.org>
References: <20260917210841.GD331587@fedora>
 <2f9affb3-0d1b-4469-9a66-ba052d2d1b6a@oss.qualcomm.com>
 <20260922131442.GB18339@fedora>
 <3a933df3-dff7-4ef3-a120-4c6e22c1fcc1@oss.qualcomm.com>
 <de535820-591b-40f2-b840-d987c3253765@nvidia.com>
 <9515779b-a6da-407f-99f2-011e51683d15@oss.qualcomm.com>
 <20261008060644-mutt-send-email-mst@kernel.org>
 <bfbb51cb-8a90-4b23-8ed1-26ea41102dd6@oss.qualcomm.com>
 <20261009081523-mutt-send-email-mst@kernel.org>
 <e13d2da8-e8e9-4014-98f0-2c1bfa801d59@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e13d2da8-e8e9-4014-98f0-2c1bfa801d59@oss.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JMIMDQ7VL09eqhlhwC-260jGFZ5NFYMKTWnlBKodu9s_1791844445
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, Oct 10, 2026 at 06:54:06PM +0800, Linlin Zhang wrote:
> 
> 
> On 10/9/2026 8:25 PM, Michael S. Tsirkin wrote:
> > On Fri, Oct 09, 2026 at 07:21:13PM +0800, Linlin Zhang wrote:
> >>
> >>
> >> On 10/8/2026 6:15 PM, Michael S. Tsirkin wrote:
> >>> On Thu, Oct 08, 2026 at 05:17:30PM +0800, Linlin Zhang wrote:
> >>>>
> >>>>
> >>>> On 9/30/2026 6:46 AM, Max Gurtovoy wrote:
> >>>>>
> >>>>> On 24/09/2026 12:35, Linlin Zhang wrote:
> >>>>>>
> >>>>>> On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
> >>>>>>> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
> >>>>>>>>
> >>>>>>>> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
> >>>>>>>>> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
> >>>>>>>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
> >>>>>>>>>>
> >>>>>>>>>> This series adds virtio-blk inline encryption support for devices backed
> >>>>>>>>>> by storage hardware with an inline crypto engine.
> >>>>>>>>>>
> >>>>>>>>>> The protocol exposes device capabilities such as keyslot count, maximum
> >>>>>>>>>> DUN size, and supported key types. Encrypted requests identify a
> >>>>>>>>>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
> >>>>>>>>>> capability discovery use the block device control virtqueue.
> >>>>>>>>>>
> >>>>>>>>>> The control virtqueue is defined as a generic framework so that its
> >>>>>>>>>> buffer layout and queue placement are independent of any particular
> >>>>>>>>>> control command. Inline encryption then builds on this framework with
> >>>>>>>>>> explicit crypto command formats, capability validation, and keyslot
> >>>>>>>>>> state semantics.
> >>>>>>>>>>
> >>>>>>>>>> All key related operatios are handled in the control virtqueue, and
> >>>>>>>>>> the crypto I/O request is handled in the request queue.
> >>>>>>>>>>
> >>>>>>>>>> For background on inline encryption in UFS and eMMC storage, see:
> >>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
> >>>>>>>>>>
> >>>>>>>>>> changes in v3:
> >>>>>>>>>>   - Add a control virtqueue
> >>>>>>>>>>   - Move key program/evict/derive_sw_secret/generate/prepare/import to
> >>>>>>>>>>     the control virtqueue
> >>>>>>>>> Thank you. This was a big change, especially if you already have an
> >>>>>>>>> implementation. I appreciate it!
> >>>>>>>>>
> >>>>>>>>> My main feedback is that the new control virtqueue commands are not yet
> >>>>>>>>> documented in enough detail so that implementors could implement them.
> >>>>>>>>> Once you've decided on the precise semantics, error codes, etc and added
> >>>>>>>>> them to the spec, then this will round off the inline encryption
> >>>>>>>>> feature. I look forward to reviewing that in the future.
> >>>>>>>>>
> >>>>>>>> Thanks a lot for your comment!
> >>>>>>>>
> >>>>>>>> Would you please help clarify what the precise semantics are about? detail
> >>>>>>>> introduction of the filed in the inline encryption control command struct?
> >>>>>>>> like struct virtio_blk_crypto_key_desc?
> >>>>>>> By precise semantics, I mean specifying not just the constants and
> >>>>>>> structs, but documenting what each command does and how it can fail.
> >>>>>>> Each of the key slot programming commands needs this. There should be at
> >>>>>>> least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
> >>>>>>> VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
> >>>>>>> VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
> >>>>>>> VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.
> >>>>>>>
> >>>>>>> For example:
> >>>>>>>
> >>>>>>> The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
> >>>>>>> key information is removed and the key slot cannot be used until it is
> >>>>>>> programmed again. The key slot index is specified by struct
> >>>>>>> virtio_blk_crypto_key_desc \field{slot} and all other fields in the
> >>>>>>> struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
> >>>>>>> slot index is valid, including if the slot is already empty. If the key
> >>>>>>> slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
> >>>>>>>
> >>>>>>> Stefan
> >>>>>> Thanks for the clear example.
> >>>>>>
> >>>>>> I'll follow the same approach and add explicit normative semantics for
> >>>>>> all inline encryption control requests.
> >>>>> Can you please explain why we need to introduce yet another VQ type for control?
> >>>>>
> >>>>> We've added the Admin VQ as a generic VQ for control operations — I'm not sure why it isn't sufficient.
> >>>>>
> >>>>> Adding control VQ to each device type seems strange to me after adding a generic Admin VQ.
> >>>>
> >>>> Thanks for your comment! And I agree that the Admin VQ should be considered before
> >>>> adding another device-specific control virtqueue.
> >>>>
> >>>> My understanding is that some of the inline encryption commands(get_crypto_modes/program key
> >>>> /derive_sw_secret/evict key) are runtime operations of a specific virtio-blk deivce.
> >>>> In particular, different virtio block devices may have different storage hardware sources
> >>>> of crypto modes, and keyslot programming and eviction are invoked through the block device's
> >>>> keyslot manager, and the programmed virtual keyslots are subsequently referenced by the
> >>>> encryption requests submitted on that device's request virtqueues. These commands are
> >>>> not about the management operation of device group.
> >>>>
> >>>> There is also a transport compatibility concern. The current virtio SPEC states that
> >>>> 'Devices and drivers utilizing Virtio Over MMIO do not support VIRTIO_F_ADMIN_VQ'.
> >>>> virtio MMIO is extensively used, so using the Admin VQ would make the feature unavailable
> >>>> for that transport unless the proposal also extended the MMIO transport.
> >>>>
> >>>> For these reasons, currently I believe that a virtio-blk control virtqueue is the better
> >>>> fit: it keeps the complete key lifecycle associated with the block device and remains
> >>>> usable across the transports required by the feature.
> >>>>
> >>>> I would appreciate any feedback or insights from you and Stefan on the V5 patch series
> >>>> posted for review before October ASAP.
> >>>>
> >>>
> >>> Fundamentally, it does not make sense to force all vqs to be admin VQs.
> >>>
> >>> Admin vq would make sense if there is complex resource management going
> >>> on - like what is happening with all the flow control things in the
> >>> network device, since they have extensive functionality for managing
> >>> device resources.
> >>>
> >>> Random device specific commands - I am not sure we want that.
> >>> It remains to be proven.
> >>>
> >>> But generally why does this go on a special VQ? Is there a reason?
> >>>
> >>> You define distinct request types seemingly and we are not short on types?
> >>>
> >>
> >> Thanks for your comments!
> >>
> >> The key programming operation is initiated while preparing a block I/O
> >> request and sent to the VQ after the block I/O request has entered the
> >> block request queue, before the request is submitted to the device's VQ.
> >> see blk_mq_submit_bio(). Using the same virtqueue for both key-program
> >> command and normal I/O could lead to bio_queue_enter() called 2 times
> >> for the same block queue, which is possible to have deadlock if
> >> blk_mq_freeze_queue() is called between above 2 bio_queue_enter() caller.
> >>
> >> A separate control virtqueue provides an independent execution path for
> >> key programming, key eviction, and related operations. It allows these
> >> operations to be issued even when the normal request virtqueues are full
> >> or unable to make progress. Once the operation completes, the corresponding
> >> request can safely reference the programmed virtual keyslot.
> >>
> >> For such reasons, we believe that a virtio-blk-specific control VQ is a
> >> more appropriate mechanism than the standard VQ.
> > 
> > I don't understand. Do these commands go through bio queue?
> > Don't they go to VQ directly, just like you would with the control VQ?
> > 
> 
> Thanks for your comment! my earlier reply conflated two separate concerns.
> Let me address them precisely based on Linux kernel code.
> 
> I agree that block-layer queue entry and virtqueue selection are independent
> issues.
> 
> Whether key program commands going through bio queue or not depends on the
> implementation.
> 
>   - Option A: Reuse the standard block-request helpers (e.g.,
>     blk_mq_alloc_request() + blk_execute_rq(), the same pattern virtblk_get_id()
>     uses):
>     
>       - blk_mq_submit_bio()
>          -> blk_crypto_submit_bio()   # outer bio_queue_enter() already held
>            -> keyslot manager
>              -> virtblk_crypto_keyslot_program()
>                -> blk_mq_alloc_request()
>                  -> blk_queue_enter()    # deadlock: freeze in progress
> 
>     This is not safe at the keyslot-manager call site. Key programming is invoked
>     from inside blk_mq_submit_bio(), at a point where the submitting thread already
>     holds an unreleased reference from an earlier bio_queue_enter() call on the same
>     queue. Calling blk_queue_enter() a second time on the same thread and queue —
>     while a concurrent blk_mq_freeze_queue() is in flight — produces a circular wait:
>     the freezer blocks waiting for all references (including the outer one) to drop to
>     zero, while the submitting thread blocks waiting for the freeze depth to clear.
>     Neither can make progress. The problem is not allocation starvation but queue-entry
>     reentrancy under freeze. 
> 
>     This is the deadlock concern I mentioned last time.
> 
>   - Option B: Bypass the block layer entirely and raw-submit to a data VQ (i.e.,
>     virtqueue_add_sgs() / virtqueue_kick() directly, just targeting a request VQ instead
>     of the control VQ):
> 
>     This would indeed sidestep the blk_queue_enter() reentrancy problem. However, it is
>     not equivalent to simply adding a new request type — it would require changing the
>     data VQ token and completion contract:
> 
>     virtblk_done() — the completion callback registered for every data VQ — unconditionally
>     calls blk_mq_rq_from_pdu() and then blk_mq_complete_request() for every buffer it pulls
>     off the ring. It assumes every returned token is a struct virtblk_req embedded in a
>     blk-mq–allocated struct request. A new specific virtblk_crypto_request injected into a
>     data VQ ring is not such an object. The completion path has no way to distinguish it,
>     and treating it as one computes a bogus request pointer and corrupts blk-mq tag state.
> 
>     Making this safe would require adding out-of-band type tagging and dispatch logic into
>     the hot I/O completion path, making the data-VQ callback polymorphic in a way that
>     currently has no precedent.
> 
>     Furthermore, there is a scope mismatch: data VQs are scoped to individual blk-mq hardware
>     queues (hctx->queue_num), whereas keyslot management is a per-device operation. On a
>     multi-queue device, there is no single canonical data VQ to target. Choosing queue[0]
>     arbitrarily concentrates control traffic, causes contention with that hctx's in-flight
>     I/O and submission lock (vblk->vqs[i].lock), and can be blocked entirely if that ring
>     is saturated.
> 
>     In summary, using a data VQ in this way is implementable in principle, but it would require
>     changing the established data-VQ token/completion contract and coupling a device-scoped
>     control operation to an arbitrarily chosen hctx-scoped queue.


Actually even simpler. Option C: spec allows any mix. Linux practically
can choose a VQ and dedicates it to the key slot management.
It can then submit requests there in any way it wants.
No?


> While the separate control virtqueue provides a direct submission path without entering the
> block layer, while also providing a distinct request format, completion callback, lock, and
> descriptor pool. This keeps key-management operations separate from blk-mq request/tag
> and from the per-hardware-queue I/O completion path.
> 
> Given the above, I prefer to having a new control VQ. I'm appreciated if you have any
> insights about it. 
> 
> In addition, the control VQ is currently used for inline encryption. From the virtio
> specification perspective, should we state that it is currently used only for inline
> encryption, or leave room for future extensions?

