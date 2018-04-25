Return-Path: virtio-dev-return-3954-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F9945818086
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Apr 2018 06:51:43 -0700 (PDT)
Date: Wed, 25 Apr 2018 21:52:27 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180425135227.zvgs4jjxaymhype6@debian>
References: <20180425082312.32244-1-tiwei.bie@intel.com>
 <09fbd602-96f4-9444-977a-979b234cbcdb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09fbd602-96f4-9444-977a-979b234cbcdb@redhat.com>
Subject: Re: [virtio-dev] Re: [RFC] VIRTIO_F_IO_BARRIER: use I/O barriers in
 driver
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: mst@redhat.com, stefanha@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org, cunming.liang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Apr 25, 2018 at 03:23:39PM +0200, Paolo Bonzini wrote:
> On 25/04/2018 10:23, Tiwei Bie wrote:
> > There will be hardware virtio devices in the future, which
> > require drivers to use the barriers suitable for I/O device,
> > compared with software virtio devices which just require
> > drivers to use the barriers suitable for CPU core.
> > 
> > To fix the ordering issue for hardware virtio devices, add
> > a new feature: VIRTIO_F_IO_BARRIER. When negotiated, driver
> > will use the barriers suitable for I/O device.
> 
> Unfortunately this doesn't work as mentioned earlier.  Virtio live
> migration assumes that features are safe if you have them on the
> destination but not on the source; this feature however works the
> opposite way.

If my understanding is correct, I think Michael suggested to add
code to disallow migration between setups with and without the
feature:

http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg03094.html
"""
Right. We'll need a flag for this feature for starters. It doesn't exist
:) Paolo also points out that we should then add code to disallow
migration between setups with and without the feature.
"""

If we do it in the opposite way (i.e. use SMP barriers when feature
is negotiated), the problem is that, old kernels will go into error
silently when using hardware virtio devices.

Best regards,
Tiwei Bie


> 
> Paolo
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

