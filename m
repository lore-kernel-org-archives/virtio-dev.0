Return-Path: <virtio-dev-return-14008-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B416FCDB483
	for <virtio-dev@archiver.kernel.org>; Fri, 13 Oct 2023 13:38:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2FC1F2AC9B
	for <virtio-dev@archiver.kernel.org>; Fri, 13 Oct 2023 13:38:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A21CB986842
	for <virtio-dev@archiver.kernel.org>; Fri, 13 Oct 2023 13:38:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 86C7D9868C4; Fri, 13 Oct 2023 13:38:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 65CC198687E
	for <virtio-dev@lists.oasis-open.org>; Fri, 13 Oct 2023 13:38:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Ic74d6o6NdOs57bp-Flc4w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697204329; x=1697809129;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47nA9SM86KpFJd/nDwGVbr4NTlsCi57IVbDpdRBHnMM=;
        b=ApS6AB8EBQ4NXCuvAwm2m1mvfFyxTP5kpitekYTqwSMXrZPtnFXboUQCRwcN92ynWe
         9U5NehVUEbQZc0n4ut+BVnNWLBWGPF7n1bcXx+U4p2A+8aUqe/m0GVmTeUYdfbQxkzdy
         Uef5OTQlj1cuK/c28rKosb5yTmcLZ1ZIxF14TpLQZv9Fsm7WOmg9QJsAiTrXZds6cUZi
         gzqZtdrq/3teN/IxVgGi1b9/P2DIE0LDMGAAwMItwqgL7K4c0xE2PBpg84nPJCykDOCD
         KNWxaC2wUGOwORn26ig1vLK6txFEi4IVyZuTKDaIVEwA+DcXDtU9V4tY1Py/Vif1C/B+
         iJ0g==
X-Gm-Message-State: AOJu0Yxi80z3VmPCU8KjEWEIcXiC8cD61RVw0IH9Koxx+pT9L1kUcV8S
	839TDN3wvNsAo9U6x0Y9Y2SjnmDs6eB3KTv85F+mXjLN+GzXZKwkTiep8LwFOh4QVBxdM61DrOI
	WC0qq3YF3Zr0U5LOkkQhEg+QpF7vx
X-Received: by 2002:a7b:cb8b:0:b0:3fb:e189:3532 with SMTP id m11-20020a7bcb8b000000b003fbe1893532mr23571788wmi.20.1697204329325;
        Fri, 13 Oct 2023 06:38:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsfai2RI7mIRVqFJn93GrfqwnqR5/1KZlP3EnCoBDndajGvgtbdF0C3GEgRlCI5q8T8wNRSw==
X-Received: by 2002:a7b:cb8b:0:b0:3fb:e189:3532 with SMTP id m11-20020a7bcb8b000000b003fbe1893532mr23571771wmi.20.1697204328857;
        Fri, 13 Oct 2023 06:38:48 -0700 (PDT)
Date: Fri, 13 Oct 2023 09:38:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Babis Chalios <bchalios@amazon.es>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	"Cali, Marco" <xmarcalx@amazon.co.uk>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, aams@amazon.de
Message-ID: <20231013093726-mutt-send-email-mst@kernel.org>
References: <c2e7076b-b07e-43cd-a912-9314d742a678@amazon.es>
 <20230919055811-mutt-send-email-mst@kernel.org>
 <4c6d6710-43c8-402b-9ae6-d2f4cafbe9a7@amazon.es>
 <20230922110329-mutt-send-email-mst@kernel.org>
 <c0c5b159-997f-4ddf-ab3e-1c749ad93e10@amazon.es>
 <20230922115920-mutt-send-email-mst@kernel.org>
 <19967fde-8893-4fe8-9f9a-7ce49bf38772@amazon.es>
 <20230927174611-mutt-send-email-mst@kernel.org>
 <4d22d699-b9f3-4d67-940a-8f11bcd29819@amazon.es>
 <5f548d39-2ae4-45a8-9dba-49a2c693dae4@amazon.es>
MIME-Version: 1.0
In-Reply-To: <5f548d39-2ae4-45a8-9dba-49a2c693dae4@amazon.es>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [PATCH RFC 3/3] rng: leak detection support

On Fri, Oct 13, 2023 at 09:49:40AM +0200, Babis Chalios wrote:
> 
> 
> On 28/9/23 20:16, Babis Chalios wrote:
> > 
> > 
> > On 27/9/23 23:47, Michael S. Tsirkin wrote:
> > > On Wed, Sep 27, 2023 at 12:43:20PM +0200, Babis Chalios wrote:
> > > > On 22/9/23 18:01, Michael S. Tsirkin wrote:
> > > > > On Fri, Sep 22, 2023 at 05:40:50PM +0200, Babis Chalios wrote:
> > > > > > On 22/9/23 17:06, Michael S. Tsirkin wrote:
> > > > > > > On Tue, Sep 19, 2023 at 12:11:37PM +0200, Babis Chalios wrote:
> > > > > > > > On 19/9/23 12:01, Michael S. Tsirkin wrote:
> > > > > > > > > On Tue, Sep 19, 2023 at 09:32:08AM +0200, Babis Chalios wrote:
> > > > > > > > > > Resending to fix e-mail formatting issues (sorry for the spam)
> > > > > > > > > > 
> > > > > > > > > > On 18/9/23 18:30, Babis Chalios wrote:
> > > > > > > > > > > > > > > Yes, that's what the driver does now in the RFC patch.
> > > > > > > > > > > > > > > However, this just
> > > > > > > > > > > > > > > decreases
> > > > > > > > > > > > > > > the race window, it doesn't eliminate it. If a third
> > > > > > > > > > > > > > > leak event happens it
> > > > > > > > > > > > > > > might not
> > > > > > > > > > > > > > > find any buffers to use:
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > 1. available buffers to queue 1-X
> > > > > > > > > > > > > > > 2. available buffers to queue X
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > 3. poll queue X
> > > > > > > > > > > > > > > 4. used buffers in queue X       <- leak event 1 will
> > > > > > > > > > > > > > > use buffers in X
> > > > > > > > > > > > > > > 5. avail buffers in queue X
> > > > > > > > > > > > > > > 6. poll queue 1-X                <- leak event 2 will
> > > > > > > > > > > > > > > use buffers in 1-X
> > > > > > > > > > > > > > > 7. used buffers in queue 1-X
> > > > > > > > > > > > > > > 8. avail buffers in queue 1-X
> > > > > > > > > > > > > > > <- leak event 3 (it
> > > > > > > > > > > > > > > needs buffers in X, race with step 5)
> > > > > > > > > > > > > > > 9. goto 3
> > > > > > > > > > > > > > I don't get it. we added buffers in step 5.
> > > > > > > > > > > > > What if the leak event 3 arrives before step 5 had time to
> > > > > > > > > > > > > actually add the
> > > > > > > > > > > > > buffers in X and make
> > > > > > > > > > > > > them visible to the device?
> > > > > > > > > > > > Then it will see a single event
> > > > > > > > > > > > in 1-X instead of two events.  A
> > > > > > > > > > > > leak is
> > > > > > > > > > > > a leak though, I don't see does it matter how many triggered.
> > > > > > > > > > > > 
> > > > > > > > > > So the scenario I have in mind is the following:
> > > > > > > > > > 
> > > > > > > > > > (Epoch here is terminology that I used
> > > > > > > > > > in the Linux RFC. It is a value
> > > > > > > > > > maintained by random.c
> > > > > > > > > > that changes every time a leak event happens).
> > > > > > > > > > 
> > > > > > > > > > 1. add buffers to 1-X
> > > > > > > > > > 2. add buffers to X
> > > > > > > > > > 3. poll queue X
> > > > > > > > > > 4. vcpu 0: get getrandom() entropy and cache epoch value
> > > > > > > > > > 5. Device: First snapshot, uses buffers in X
> > > > > > > > > > 6. vcpu 1: sees used buffers
> > > > > > > > > > 7. Device: Second snapshot, uses buffers in 1-X
> > > > > > > > > > 8. vcpu 0: getrandom() observes new  epoch value & caches it
> > > > > > > > > > 9. Device: Third snapshot, no buffers in
> > > > > > > > > > either queue, (vcpu 1 from step 6
> > > > > > > > > > has not yet finished adding new buffers).
> > > > > > > > > > 10. vcpu 1 adds new buffer in X
> > > > > > > > > > 11. vcpu 0: getrandom() will not see new
> > > > > > > > > > epoch and gets stale entropy.
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > In this succession of events, when the
> > > > > > > > > > third snapshot will happen, the
> > > > > > > > > > device won't find
> > > > > > > > > > any buffers in either queue, so it won't
> > > > > > > > > > increase the RNG epoch value. So,
> > > > > > > > > > any entropy
> > > > > > > > > > gathered after step 8 will be the same
> > > > > > > > > > across all snapshots. Am I missing
> > > > > > > > > > something?
> > > > > > > > > > 
> > > > > > > > > > Cheers,
> > > > > > > > > > Babis
> > > > > > > > > > 
> > > > > > > > > Yes but notice how this is followed by:
> > > > > > > > > 
> > > > > > > > > 12. vcpu 1: sees used buffers in 1-X
> > > > > > > > > 
> > > > > > > > > Driver can notify getrandom I guess?
> > > > > > > > It could, but then we have the exact race
> > > > > > > > condition that VMGENID had,
> > > > > > > > userspace has already consumed stale entropy and there's nothing we
> > > > > > > > can do about that.
> > > > > > > > 
> > > > > > > > Although this is indeed a corner case, it feels
> > > > > > > > like it beats the purpose
> > > > > > > > of having the hardware update directly userspace
> > > > > > > > (via copy on leak).
> > > > > > > > 
> > > > > > > > How do you feel about the proposal a couple of
> > > > > > > > emails back? It looks to
> > > > > > > > me that it avoids completely the race condition.
> > > > > > > > 
> > > > > > > > Cheers,
> > > > > > > > Babis
> > > > > > > It does. The problem of course is that this means that e.g.
> > > > > > > taking a snapshot of a guest that is stuck won't work well.
> > > > > > That is true, but does it matter? The intention of the proposal
> > > > > > is that if it is not safe to take snapshots (i.e. no buffers in the
> > > > > > queue) don't take snapshots.
> > > > > > 
> > > > > > > I have been thinking of adding MAP/UNMAP descriptors for
> > > > > > > a while now. Thus it will be possible to modify
> > > > > > > userspace memory without consuming buffers.
> > > > > > > Would something like this solve the problem?
> > > > > > I am not familiar with MAP/UNMAP descriptors. Is there
> > > > > > a link where I can read about them?
> > > > > > 
> > > > > > Cheers,
> > > > > > Babis
> > > > > Heh no I just came up with the name. Will write up in a couple
> > > > > of days, but the idea is that driver does get_user_pages,
> > > > > adds buffer to queue, and device will remember the address
> > > > > and change that memory on a snapshot. If there are buffers
> > > > > in the queue it will also use these to tell driver,
> > > > > but if there are no buffers then it won't.
> > > > That sounds like a nice mechanism. However in our case the page
> > > > holding the counter that gets increased by the hardware is a kernel
> > > > page.
> > > > 
> > > > The reason for that is that things other than us (virtio-rng) might
> > > > want to notify for leak events. For example, I think that Jason
> > > > intended to use this mechanism to periodically notify user-space
> > > > PRNGs that they need to reseed.
> > > > 
> > > > Cheers,
> > > > Babis
> > > 
> > > Now I'm lost.
> > > when you write, e.g.:
> > > 4. vcpu 0: get getrandom() entropy and cache epoch value
> > > how does vcpu access the epoch?
> > 
> > The kernel provides a user space API to map a pointer to the epoch
> > value. User space then caches its value and checks it every time it
> > needs to make sure that no entropy leak has happened before using
> > cached kernel entropy.
> > 
> > virtio-rng driver adds a copy on leak command to the queue for
> > increasing this value (that's what we are speaking about in this thread).
> > But other systems might want to report "leaks", such as random.c
> > itself.
> > 
> > Cheers,
> > Babis
> 
> Hey Michael, does this explain the flow of things?
> 
> To summarize, end-to-end things work like this:
> 
> 1. kernel allocates a page where an epoch value is stored.
> 2. User-space can mmap this page and look for changes in its value to
>     know when it needs to re-seed its PRNGs.
> 3. virtio-rng driver gets a hold of the address of the page and programs
>     device to update it when entropy is leaked
> 4. Other kernel sub-systems can do the same if they have a concept of
>     entropy leaking. For example, random.c might want to do this
> periodically
> 
> Regarding your suggestion for MAP/UNMAP buffers, I think it could work
> if it was working with kernel addresses as well. The device doesn't care
> about user vs kernel space guest addresses after all. However, if we were to
> use such a mechanism, it seems that we don't need the two leak queues
> anyway.
> 
> So, it sounds like we can have a setup with one leak queue only. If we use a
> MAP/UNMAP type of buffer then all is fine. If we use normal buffers, we can
> add the requirement that the VMM needs to refuse to take a snapshot if there
> is not a copy on leak buffer in the queue.
> 
> Thoughts?
> 
> Cheers,
> Babis

Lost context a bit. I'll think it over. Thanks!


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

