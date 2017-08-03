Return-Path: virtio-dev-return-2449-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6DC325818C9B
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Aug 2017 08:55:59 -0700 (PDT)
Date: Thu, 3 Aug 2017 18:55:50 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170803185508-mutt-send-email-mst@kernel.org>
References: <1501742299-4369-1-git-send-email-wei.w.wang@intel.com>
 <1501742299-4369-4-git-send-email-wei.w.wang@intel.com>
 <20170803151212-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F73928C952@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F73928C952@shsmsx102.ccr.corp.intel.com>
Subject: [virtio-dev] Re: [PATCH v13 3/5] virtio-balloon: VIRTIO_BALLOON_F_SG
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Aug 03, 2017 at 03:17:59PM +0000, Wang, Wei W wrote:
> On Thursday, August 3, 2017 10:23 PM, Michael S. Tsirkin wrote:
> > On Thu, Aug 03, 2017 at 02:38:17PM +0800, Wei Wang wrote:
> > > +static void send_one_sg(struct virtio_balloon *vb, struct virtqueue *vq,
> > > +			void *addr, uint32_t size)
> > > +{
> > > +	struct scatterlist sg;
> > > +	unsigned int len;
> > > +
> > > +	sg_init_one(&sg, addr, size);
> > > +	while (unlikely(virtqueue_add_inbuf(vq, &sg, 1, vb, GFP_KERNEL)
> > > +			== -ENOSPC)) {
> > > +		/*
> > > +		 * It is uncommon to see the vq is full, because the sg is sent
> > > +		 * one by one and the device is able to handle it in time. But
> > > +		 * if that happens, we kick and wait for an entry is released.
> > 
> > is released -> to get used.
> > 
> > > +		 */
> > > +		virtqueue_kick(vq);
> > > +		while (!virtqueue_get_buf(vq, &len) &&
> > > +		       !virtqueue_is_broken(vq))
> > > +			cpu_relax();
> > 
> > Please rework to use wait_event in that case too.
> 
> For the balloon page case here, it is fine to use wait_event. But for the free page
> case, I think it might not be suitable because the mm lock is being held.
> 
> Best,
> Wei

You will have to find a way to drop the lock and restart from where you
stopped then.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

