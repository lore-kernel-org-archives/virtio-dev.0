Return-Path: virtio-dev-return-4537-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7122F5818EAE
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Jun 2018 06:34:35 -0700 (PDT)
Date: Tue, 26 Jun 2018 16:34:27 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180626163139-mutt-send-email-mst@kernel.org>
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com>
 <1529928312-30500-3-git-send-email-wei.w.wang@intel.com>
 <20180626002822-mutt-send-email-mst@kernel.org>
 <5B31B71B.6080709@intel.com>
 <20180626064338-mutt-send-email-mst@kernel.org>
 <5B323140.1000306@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B323140.1000306@intel.com>
Subject: [virtio-dev] Re: [PATCH v34 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, peterx@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jun 26, 2018 at 08:27:44PM +0800, Wei Wang wrote:
> On 06/26/2018 11:56 AM, Michael S. Tsirkin wrote:
> > On Tue, Jun 26, 2018 at 11:46:35AM +0800, Wei Wang wrote:
> > 
> 
> > > 
> > > > 
> > > > > +	if (!arrays)
> > > > > +		return NULL;
> > > > > +
> > > > > +	for (i = 0; i < max_array_num; i++) {
> > > > So we are getting a ton of memory here just to free it up a bit later.
> > > > Why doesn't get_from_free_page_list get the pages from free list for us?
> > > > We could also avoid the 1st allocation then - just build a list
> > > > of these.
> > > That wouldn't be a good choice for us. If we check how the regular
> > > allocation works, there are many many things we need to consider when pages
> > > are allocated to users.
> > > For example, we need to take care of the nr_free
> > > counter, we need to check the watermark and perform the related actions.
> > > Also the folks working on arch_alloc_page to monitor page allocation
> > > activities would get a surprise..if page allocation is allowed to work in
> > > this way.
> > > 
> > mm/ code is well positioned to handle all this correctly.
> 
> I'm afraid that would be a re-implementation of the alloc functions,

A re-factoring - you can share code. The main difference is locking.

> and
> that would be much more complex than what we have. I think your idea of
> passing a list of pages is better.
> 
> Best,
> Wei

How much memory is this allocating anyway?

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

