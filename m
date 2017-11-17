Return-Path: virtio-dev-return-2694-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 621265818CAB
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Nov 2017 05:18:13 -0800 (PST)
Date: Fri, 17 Nov 2017 15:18:04 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171117144517-mutt-send-email-mst@kernel.org>
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>
 <1509696786-1597-7-git-send-email-wei.w.wang@intel.com>
 <20171115220743-mutt-send-email-mst@kernel.org>
 <5A0D923C.4020807@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A0D923C.4020807@intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v17 6/6] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_VQ
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 16, 2017 at 09:27:24PM +0800, Wei Wang wrote:
> On 11/16/2017 04:32 AM, Michael S. Tsirkin wrote:
> > On Fri, Nov 03, 2017 at 04:13:06PM +0800, Wei Wang wrote:
> > > Negotiation of the VIRTIO_BALLOON_F_FREE_PAGE_VQ feature indicates the
> > > support of reporting hints of guest free pages to the host via
> > > virtio-balloon. The host requests the guest to report the free pages by
> > > sending commands via the virtio-balloon configuration registers.
> > > 
> > > When the guest starts to report, the first element added to the free page
> > > vq is a sequence id of the start reporting command. The id is given by
> > > the host, and it indicates whether the following free pages correspond
> > > to the command. For example, the host may stop the report and start again
> > > with a new command id. The obsolete pages for the previous start command
> > > can be detected by the id dismatching on the host. The id is added to the
> > > vq using an output buffer, and the free pages are added to the vq using
> > > input buffer.
> > > 
> > > Here are some explainations about the added configuration registers:
> > > - host2guest_cmd: a register used by the host to send commands to the
> > > guest.
> > > - guest2host_cmd: written by the guest to ACK to the host about the
> > > commands that have been received. The host will clear the corresponding
> > > bits on the host2guest_cmd register. The guest also uses this register
> > > to send commands to the host (e.g. when finish free page reporting).
> > > - free_page_cmd_id: the sequence id of the free page report command
> > > given by the host.
> > > 
> > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > > Signed-off-by: Liang Li <liang.z.li@intel.com>
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Michal Hocko <mhocko@kernel.org>
> > > ---
> > > 
> > > +
> > > +static void report_free_page(struct work_struct *work)
> > > +{
> > > +	struct virtio_balloon *vb;
> > > +
> > > +	vb = container_of(work, struct virtio_balloon, report_free_page_work);
> > > +	report_free_page_cmd_id(vb);
> > > +	walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
> > > +	/*
> > > +	 * The last few free page blocks that were added may not reach the
> > > +	 * batch size, but need a kick to notify the device to handle them.
> > > +	 */
> > > +	virtqueue_kick(vb->free_page_vq);
> > > +	report_free_page_end(vb);
> > > +}
> > > +
> > I think there's an issue here: if pages are poisoned and hypervisor
> > subsequently drops them, testing them after allocation will
> > trigger a false positive.
> > 
> > The specific configuration:
> > 
> > PAGE_POISONING on
> > PAGE_POISONING_NO_SANITY off
> > PAGE_POISONING_ZERO off
> > 
> > 
> > Solutions:
> > 1. disable the feature in that configuration
> > 	suggested as an initial step
> 
> Thanks for the finding.
> Similar to this option: I'm thinking could we make walk_free_mem_block()
> simply return if that option is on?
> That is, at the beginning of the function:
>     if (!page_poisoning_enabled())
>                 return;
> 
> I think in most usages, people would not choose to use the poisoning option
> due to the added overhead.
> 
> 
> Probably we could make it a separate fix patch of this report following
> patch 5 to explain the above reasons in the commit.
> 
> > 2. pass poison value to host so it can validate page content
> >     before it drops it
> > 3. pass poison value to host so it can init allocated pages with that value
> > 
> > In fact one nice side effect would be that unmap
> > becomes safe even though free list is not locked anymore.
> 
> I haven't got this point yet,  how would it bring performance benefit?

Upon getting a free page, host could check that its content
matches the poison value. If it doesn't page has been used.

But let's ignore this for now.

> > It would be interesting to see whether this last has
> > any value performance-wise.
> > 
> 
> Best,
> Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

