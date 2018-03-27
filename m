Return-Path: virtio-dev-return-3656-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id BF19058180F8
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Mar 2018 07:01:37 -0700 (PDT)
Date: Tue, 27 Mar 2018 21:59:49 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180327135949.owjzqtbrnlfmj6yd@debian>
References: <20180319071537.28649-1-tiwei.bie@intel.com>
 <20180319071537.28649-7-tiwei.bie@intel.com>
 <20180322171740-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180322171740-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v2 6/6] vhost-user: add VFIO based accelerators support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Mar 22, 2018 at 06:19:44PM +0200, Michael S. Tsirkin wrote:
> On Mon, Mar 19, 2018 at 03:15:37PM +0800, Tiwei Bie wrote:
[...]
> > 
> > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> > index cb3a7595aa..264a58a800 100644
> > --- a/docs/interop/vhost-user.txt
> > +++ b/docs/interop/vhost-user.txt
[...]
> 
> > The accelerator
> > +context will be set for each queue independently. So the page-per-vq property
> > +should also be enabled.
> 
> Backend author is unlikely to know what does page-per-vq property mean.
> 
> Is this intended for users maybe? docs/interop is not the best place
> for user-facing documentation.
> 
> I also wonder:
> 
> 	commit d9997d89a4a09a330a056929d06d4b7b0b7a8239
> 	Author: Marcel Apfelbaum <marcel@redhat.com>
> 	Date:   Wed Sep 7 18:02:25 2016 +0300
> 
> 	    virtio-pci: reduce modern_mem_bar size
> 	    
> 	    Currently each VQ Notification Virtio Capability is allocated
> 	    on a different page. The idea is to enable split drivers within
> 	    guests, however there are no known plans to do that.
> 	    The allocation will result in a 8MB BAR, more than various
> 	    guest firmwares pre-allocates for PCI Bridges hotplug process.
>     
> looks like enabling page per vq will break pci express hotplug.
> I suspect more work is needed to down-size the BAR to # of VQs
> actually supported.
> 

I agree. Maybe we can fix the potential pci express hotplug
issue caused by enabling page-per-vq in another patch set.

Best regards,
Tiwei Bie

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

