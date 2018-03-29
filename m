Return-Path: virtio-dev-return-3670-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A31B11CB80EF
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Mar 2018 20:35:41 -0700 (PDT)
Date: Thu, 29 Mar 2018 11:33:29 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180329033329.ucnx34nzimgec7pp@debian>
References: <20180319071537.28649-1-tiwei.bie@intel.com>
 <20180322181952-mutt-send-email-mst@kernel.org>
 <20180328122407.gc6yba26gijlm5g6@debian>
 <20180328183159-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180328183159-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [PATCH v2 0/6] Extend vhost-user to support
 VFIO based accelerators
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 28, 2018 at 06:33:01PM +0300, Michael S. Tsirkin wrote:
> On Wed, Mar 28, 2018 at 08:24:07PM +0800, Tiwei Bie wrote:
> > > > Update notes
> > > > ============
> > > > 
> > > > IOMMU feature bit check is removed in this version, because:
> > > > 
> > > > The IOMMU feature is negotiable, when an accelerator is used and
> > > > it doesn't support virtual IOMMU, its driver just won't provide
> > > > this feature bit when vhost library querying its features. And if
> > > > it supports the virtual IOMMU, its driver can provide this feature
> > > > bit. It's not reasonable to add this limitation in this patch set.
> > > 
> > > Fair enough. Still:
> > > Can hardware on intel platforms actually support IOTLB requests?
> > > Don't you need to add support for vIOMMU shadowing instead?
> > > 
> > 
> > For the hardware I have, I guess they can't for now.
> 
> So VFIO in QEMU has support for vIOMMU shadowing.
> Can you use that somehow?

Yeah, I guess we can use it in some way. Actually supporting
vIOMMU is a quite interesting feature. It would provide
better security, and for the hardware backend case there
would be no performance penalty with static mapping after
the backend got all the mappings. I think it could be done
as another work. Based on your previous suggestion in this
thread, I have split the guest notification offload and host
notification offload (I'll send the new version very soon).
And I plan to let this patch set just focus on fixing the
most critical performance issue - the host notification offload.
With this fix, using hardware backend in vhost-user could get
a very big performance boost and become much more practicable.
So maybe we can focus on fixing this critical performance issue
first. How do you think?

> 
> Ability to run dpdk within guest seems important.

I think vIOMMU isn't a must to run DPDK in guest. For Linux
guest we also have igb_uio and uio_pci_generic to run DPDK,
for FreeBSD guest we have nic_uio. They don't need vIOMMU,
and they could offer the best performance.

Best regards,
Tiwei Bie

> 
> -- 
> MST
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

