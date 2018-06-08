Return-Path: virtio-dev-return-4305-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id ABE305818F2F
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Jun 2018 19:49:40 -0700 (PDT)
Date: Fri, 8 Jun 2018 05:49:26 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180608054637-mutt-send-email-mst@kernel.org>
References: <1524550428-27173-5-git-send-email-wei.w.wang@intel.com>
 <20180606064315.GB7815@xz-mi>
 <5B17B366.5030802@intel.com>
 <20180607031732.GG7815@xz-mi>
 <5B18C2B2.30709@intel.com>
 <20180607065808.GB750@xz-mi>
 <5B191EA6.3020004@intel.com>
 <20180608013723.GQ750@xz-mi>
 <20180608045316-mutt-send-email-mst@kernel.org>
 <20180608023425.GT750@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608023425.GT750@xz-mi>
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v7 4/5] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: Peter Xu <peterx@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jun 08, 2018 at 10:34:25AM +0800, Peter Xu wrote:
> On Fri, Jun 08, 2018 at 04:58:21AM +0300, Michael S. Tsirkin wrote:
> > On Fri, Jun 08, 2018 at 09:37:23AM +0800, Peter Xu wrote:
> > > > > Asked since I see this in virtio spec (v1.0, though I guess it won't
> > > > > change) in chapter "2.2.1 Driver Requirements: Feature Bits":
> > > > > 
> > > > > "The driver MUST NOT accept a feature which the device did not offer"
> > > > > 
> > > > > Then I'm curious what would happen if:
> > > > > 
> > > > > - a emulator (not QEMU) only offered F_FREE_PAGE_HINT, not F_POISON
> > > > > - a guest that enabled PAGE_POISON
> > > > > 
> > > > > Then how the driver could tell the host that PAGE_POISON is enabled
> > > > > considering that guest should never set that feature bit if the
> > > > > emulation code didn't provide it?
> > 
> > It wouldn't. It just has to deal with the fact that host can discard
> > writes to hinted pages. Right now driver deals with it simply by
> > disabling F_FREE_PAGE_HINT.
> 
> Ah I see.  Thanks Michael.
> 
> Then it seems to me that it's more important to implement the F_POISON
> along with where it is declared since otherwise it'll be a real broken
> (device declares F_POISON, guest assumes it can handle the POISON so
> guest will enable FREE_PAGE_HINT, however the device can't really
> handle that).

It seems to handle it fine, it just ignores the hints.

> Or, if the guest driver is capable to drop F_FREE_PAGE_HINT when
> F_POISON is not declared, we can safely split the two features into
> two patches in QEMU too.
> 
> Regards,
> 
> -- 
> Peter Xu

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

