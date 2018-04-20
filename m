Return-Path: virtio-dev-return-3914-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 30EC75818F5D
	for <virtio-dev@lists.oasis-open.org>; Fri, 20 Apr 2018 07:12:30 -0700 (PDT)
Date: Fri, 20 Apr 2018 17:12:21 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180420165302-mutt-send-email-mst@kernel.org>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
 <622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
 <20180410045723.rftsb7l4l3ip2ioi@debian>
 <30a63fff-7599-640a-361f-a27e5783012a@redhat.com>
 <20180419212911-mutt-send-email-mst@kernel.org>
 <060e2b5f-2e93-c53f-387b-5baaa33e87cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <060e2b5f-2e93-c53f-387b-5baaa33e87cd@redhat.com>
Subject: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware vhost backend
To: Jason Wang <jasowang@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, alex.williamson@redhat.com, ddutile@redhat.com, alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com, jianfeng.tan@intel.com, xiao.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 20, 2018 at 11:52:47AM +0800, Jason Wang wrote:
> > The biggest issue is that you let userspace poke at the
> > device which is also allowed by the IOMMU to poke at
> > kernel memory (needed for kernel driver to work).
> 
> I don't quite get. The userspace driver could be built on top of VFIO for
> sure. So kernel memory were perfectly isolated in this case.

VFIO does what it can but it mostly just has the IOMMU to play with.
So don't overestimate what it can do - it assumes a high level
of spec compliance for protections to work. For example,
ATS is enabled by default if device has it, and that
treats translated requests are trusted. FLS is assumed to reset
the device for when VFIO is unbound from the device. etc.


> > 
> > Yes, maybe if device is not buggy it's all fine, but
> > it's better if we do not have to trust the device
> > otherwise the security picture becomes more murky.
> > 
> > I suggested attaching a PASID to (some) queues - see my old post "using
> > PASIDs to enable a safe variant of direct ring access".
> > 
> > Then using IOMMU with VFIO to limit access through queue to corrent
> > ranges of memory.
> 
> Well userspace driver could benefit from this too. And we can even go
> further by using nested IO page tables to share IOVA address space between
> devices and a VM.
> 
> Thanks

Yes I suggested this separately.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

