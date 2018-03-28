Return-Path: virtio-dev-return-3663-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id EA9005818F11
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Mar 2018 08:33:18 -0700 (PDT)
Date: Wed, 28 Mar 2018 18:33:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180328183159-mutt-send-email-mst@kernel.org>
References: <20180319071537.28649-1-tiwei.bie@intel.com>
 <20180322181952-mutt-send-email-mst@kernel.org>
 <20180328122407.gc6yba26gijlm5g6@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328122407.gc6yba26gijlm5g6@debian>
Subject: [virtio-dev] Re: [PATCH v2 0/6] Extend vhost-user to support VFIO based
 accelerators
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 28, 2018 at 08:24:07PM +0800, Tiwei Bie wrote:
> > > Update notes
> > > ============
> > > 
> > > IOMMU feature bit check is removed in this version, because:
> > > 
> > > The IOMMU feature is negotiable, when an accelerator is used and
> > > it doesn't support virtual IOMMU, its driver just won't provide
> > > this feature bit when vhost library querying its features. And if
> > > it supports the virtual IOMMU, its driver can provide this feature
> > > bit. It's not reasonable to add this limitation in this patch set.
> > 
> > Fair enough. Still:
> > Can hardware on intel platforms actually support IOTLB requests?
> > Don't you need to add support for vIOMMU shadowing instead?
> > 
> 
> For the hardware I have, I guess they can't for now.

So VFIO in QEMU has support for vIOMMU shadowing.
Can you use that somehow?

Ability to run dpdk within guest seems important.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

