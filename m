Return-Path: <virtio-dev-return-14033-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E881C4167B
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Nov 2023 11:20:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A4DAA26A45
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Nov 2023 11:20:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 98C88986C06
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Nov 2023 11:20:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8CC78986BF7; Thu,  2 Nov 2023 11:20:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 77E6C986BF5
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Nov 2023 11:20:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: bLDUstYCOAqNFovjmepDpw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698924025; x=1699528825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88J+wET4Nuz1g/cdMSTL+aVrkpDwdltVhtxM9uILjJI=;
        b=dVKpWX4+1hJmISPL4ER6nxXLN2Bjm4yklGbOgKq9hwcr1sp0B0OPWzJnKpjlM+PhB/
         9gILAkVrGCeKKwByLZQv0m6XXAEknsqnlYH9fcZbuQqoIcmvOeHI2If342H8ikP304D/
         C9nCgYzSilYyk22+D8t77R7sr6AkAVpDqW2ySAhUaWJD5m7mE4WEIi9ky7htLj5vFj4C
         eoZkR91HwFXyZa4oPGGt20cx9I9ynwPpkwyhtYbXdwbIrTPstaOBEXIf4J/KG6lA0eQN
         Iy5LXbNUOi/ROWqx89mba1iZ6f12x1b3P/9ewou1j3B/2jMDXAOg01o9a5hxm+3Zr/E6
         iRdQ==
X-Gm-Message-State: AOJu0YzcayEM3d1AXaY2SWG1yrGiw4Mux9C4l2oC/WoUOTVcyCem0vxn
	KqGEanJTxyhywSXyxrWTChuitunoOWq5vbB7dTql7ZajI5Yyp42NoryKpQ1Qsw45ZYaOtMEZdPL
	CijbTGBNQalc93unJKoG435KePddg
X-Received: by 2002:a05:6512:2806:b0:509:4b78:69b5 with SMTP id cf6-20020a056512280600b005094b7869b5mr1270875lfb.36.1698924025476;
        Thu, 02 Nov 2023 04:20:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmIos2Go/QCZvtPtJ73lkKTd7kunP3773zLctZ0MPwsjfLuW+qggVrVAgmPCbCdC60A444Bg==
X-Received: by 2002:a05:6512:2806:b0:509:4b78:69b5 with SMTP id cf6-20020a056512280600b005094b7869b5mr1270842lfb.36.1698924025026;
        Thu, 02 Nov 2023 04:20:25 -0700 (PDT)
Date: Thu, 2 Nov 2023 07:20:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Babis Chalios <bchalios@amazon.es>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	"Cali, Marco" <xmarcalx@amazon.co.uk>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, aams@amazon.de
Message-ID: <20231102071934-mutt-send-email-mst@kernel.org>
References: <4ab1b10e-4524-4b6c-a3df-863360fd225d@amazon.es>
 <c2e7076b-b07e-43cd-a912-9314d742a678@amazon.es>
 <20230919055811-mutt-send-email-mst@kernel.org>
 <4c6d6710-43c8-402b-9ae6-d2f4cafbe9a7@amazon.es>
 <20230922110329-mutt-send-email-mst@kernel.org>
 <c0c5b159-997f-4ddf-ab3e-1c749ad93e10@amazon.es>
 <20230922115920-mutt-send-email-mst@kernel.org>
 <19967fde-8893-4fe8-9f9a-7ce49bf38772@amazon.es>
 <20230927174611-mutt-send-email-mst@kernel.org>
 <4d22d699-b9f3-4d67-940a-8f11bcd29819@amazon.es>
MIME-Version: 1.0
In-Reply-To: <4d22d699-b9f3-4d67-940a-8f11bcd29819@amazon.es>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] [PATCH RFC 3/3] rng: leak detection support

On Thu, Sep 28, 2023 at 08:16:11PM +0200, Babis Chalios wrote:
> 
> 
> On 27/9/23 23:47, Michael S. Tsirkin wrote:
> > On Wed, Sep 27, 2023 at 12:43:20PM +0200, Babis Chalios wrote:
> > > On 22/9/23 18:01, Michael S. Tsirkin wrote:
> > > > On Fri, Sep 22, 2023 at 05:40:50PM +0200, Babis Chalios wrote:
> > > > > On 22/9/23 17:06, Michael S. Tsirkin wrote:
> > > > > > On Tue, Sep 19, 2023 at 12:11:37PM +0200, Babis Chalios wrote:
> > > > > > > On 19/9/23 12:01, Michael S. Tsirkin wrote:
> > > > > > > > On Tue, Sep 19, 2023 at 09:32:08AM +0200, Babis Chalios wrote:
> > > > > > > > > Resending to fix e-mail formatting issues (sorry for the spam)
> > > > > > > > > 
> > > > > > > > > On 18/9/23 18:30, Babis Chalios wrote:
> > > > > > > > > > > > > > Yes, that's what the driver does now in the RFC patch.
> > > > > > > > > > > > > > However, this just
> > > > > > > > > > > > > > decreases
> > > > > > > > > > > > > > the race window, it doesn't eliminate it. If a third
> > > > > > > > > > > > > > leak event happens it
> > > > > > > > > > > > > > might not
> > > > > > > > > > > > > > find any buffers to use:
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 1. available buffers to queue 1-X
> > > > > > > > > > > > > > 2. available buffers to queue X
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 3. poll queue X
> > > > > > > > > > > > > > 4. used buffers in queue X       <- leak event 1 will
> > > > > > > > > > > > > > use buffers in X
> > > > > > > > > > > > > > 5. avail buffers in queue X
> > > > > > > > > > > > > > 6. poll queue 1-X                <- leak event 2 will
> > > > > > > > > > > > > > use buffers in 1-X
> > > > > > > > > > > > > > 7. used buffers in queue 1-X
> > > > > > > > > > > > > > 8. avail buffers in queue 1-X
> > > > > > > > > > > > > >                                        <- leak event 3 (it
> > > > > > > > > > > > > > needs buffers in X, race with step 5)
> > > > > > > > > > > > > > 9. goto 3
> > > > > > > > > > > > > I don't get it. we added buffers in step 5.
> > > > > > > > > > > > What if the leak event 3 arrives before step 5 had time to
> > > > > > > > > > > > actually add the
> > > > > > > > > > > > buffers in X and make
> > > > > > > > > > > > them visible to the device?
> > > > > > > > > > > Then it will see a single event in 1-X instead of two events.  A leak is
> > > > > > > > > > > a leak though, I don't see does it matter how many triggered.
> > > > > > > > > > > 
> > > > > > > > > So the scenario I have in mind is the following:
> > > > > > > > > 
> > > > > > > > > (Epoch here is terminology that I used in the Linux RFC. It is a value
> > > > > > > > > maintained by random.c
> > > > > > > > > that changes every time a leak event happens).
> > > > > > > > > 
> > > > > > > > > 1. add buffers to 1-X
> > > > > > > > > 2. add buffers to X
> > > > > > > > > 3. poll queue X
> > > > > > > > > 4. vcpu 0: get getrandom() entropy and cache epoch value
> > > > > > > > > 5. Device: First snapshot, uses buffers in X
> > > > > > > > > 6. vcpu 1: sees used buffers
> > > > > > > > > 7. Device: Second snapshot, uses buffers in 1-X
> > > > > > > > > 8. vcpu 0: getrandom() observes new  epoch value & caches it
> > > > > > > > > 9. Device: Third snapshot, no buffers in either queue, (vcpu 1 from step 6
> > > > > > > > > has not yet finished adding new buffers).
> > > > > > > > > 10. vcpu 1 adds new buffer in X
> > > > > > > > > 11. vcpu 0: getrandom() will not see new epoch and gets stale entropy.
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > In this succession of events, when the third snapshot will happen, the
> > > > > > > > > device won't find
> > > > > > > > > any buffers in either queue, so it won't increase the RNG epoch value. So,
> > > > > > > > > any entropy
> > > > > > > > > gathered after step 8 will be the same across all snapshots. Am I missing
> > > > > > > > > something?
> > > > > > > > > 
> > > > > > > > > Cheers,
> > > > > > > > > Babis
> > > > > > > > > 
> > > > > > > > Yes but notice how this is followed by:
> > > > > > > > 
> > > > > > > > 12. vcpu 1: sees used buffers in 1-X
> > > > > > > > 
> > > > > > > > Driver can notify getrandom I guess?
> > > > > > > It could, but then we have the exact race condition that VMGENID had,
> > > > > > > userspace has already consumed stale entropy and there's nothing we
> > > > > > > can do about that.
> > > > > > > 
> > > > > > > Although this is indeed a corner case, it feels like it beats the purpose
> > > > > > > of having the hardware update directly userspace (via copy on leak).
> > > > > > > 
> > > > > > > How do you feel about the proposal a couple of emails back? It looks to
> > > > > > > me that it avoids completely the race condition.
> > > > > > > 
> > > > > > > Cheers,
> > > > > > > Babis
> > > > > > It does. The problem of course is that this means that e.g.
> > > > > > taking a snapshot of a guest that is stuck won't work well.
> > > > > That is true, but does it matter? The intention of the proposal
> > > > > is that if it is not safe to take snapshots (i.e. no buffers in the
> > > > > queue) don't take snapshots.
> > > > > 
> > > > > > I have been thinking of adding MAP/UNMAP descriptors for
> > > > > > a while now. Thus it will be possible to modify
> > > > > > userspace memory without consuming buffers.
> > > > > > Would something like this solve the problem?
> > > > > I am not familiar with MAP/UNMAP descriptors. Is there
> > > > > a link where I can read about them?
> > > > > 
> > > > > Cheers,
> > > > > Babis
> > > > Heh no I just came up with the name. Will write up in a couple
> > > > of days, but the idea is that driver does get_user_pages,
> > > > adds buffer to queue, and device will remember the address
> > > > and change that memory on a snapshot. If there are buffers
> > > > in the queue it will also use these to tell driver,
> > > > but if there are no buffers then it won't.
> > > That sounds like a nice mechanism. However in our case the page
> > > holding the counter that gets increased by the hardware is a kernel
> > > page.
> > > 
> > > The reason for that is that things other than us (virtio-rng) might
> > > want to notify for leak events. For example, I think that Jason
> > > intended to use this mechanism to periodically notify user-space
> > > PRNGs that they need to reseed.
> > > 
> > > Cheers,
> > > Babis
> > 
> > Now I'm lost.
> > when you write, e.g.:
> > 4. vcpu 0: get getrandom() entropy and cache epoch value
> > how does vcpu access the epoch?
> 
> The kernel provides a user space API to map a pointer to the epoch
> value. User space then caches its value and checks it every time it
> needs to make sure that no entropy leak has happened before using
> cached kernel entropy.
> 
> virtio-rng driver adds a copy on leak command to the queue for
> increasing this value (that's what we are speaking about in this thread).
> But other systems might want to report "leaks", such as random.c
> itself.
> 
> Cheers,
> Babis


This idea would be fine but I don't see how it's so different
from VMGENID. Care to explain?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

