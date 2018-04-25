Return-Path: virtio-dev-return-3955-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 93B381CB80F0
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Apr 2018 07:29:58 -0700 (PDT)
Date: Wed, 25 Apr 2018 17:29:54 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180425172658-mutt-send-email-mst@kernel.org>
References: <20180425082312.32244-1-tiwei.bie@intel.com>
 <09fbd602-96f4-9444-977a-979b234cbcdb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09fbd602-96f4-9444-977a-979b234cbcdb@redhat.com>
Subject: [virtio-dev] Re: [RFC] VIRTIO_F_IO_BARRIER: use I/O barriers in driver
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, stefanha@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org, cunming.liang@intel.com
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
> 
> Paolo

That's a qemu code property, and it's because it does not
migrate host properties right now. When implementing this feature we
can add migration of host features.

But that's only if we want to catch mis-use. We can also
punt it up the stack and say feature flags must match
on source and destination, and if they do not the problem
is between the keyboard and the chair.


-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

