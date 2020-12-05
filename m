Return-Path: virtio-dev-return-7881-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0F75B9865DD
	for <virtio-dev@lists.oasis-open.org>; Sat,  5 Dec 2020 19:40:19 +0000 (UTC)
Date: Sat, 5 Dec 2020 14:40:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20201205143909-mutt-send-email-mst@kernel.org>
References: <20200818115147.2567012-1-tomas.winkler@intel.com>
 <20200818115147.2567012-14-tomas.winkler@intel.com>
 <20201125160326-mutt-send-email-mst@kernel.org>
 <7f6181d8e80d4efb9464e9ec436800b7@intel.com>
 <20201203164859-mutt-send-email-mst@kernel.org>
 <X8lgSb9vB6UoJbVB@kroah.com>
MIME-Version: 1.0
In-Reply-To: <X8lgSb9vB6UoJbVB@kroah.com>
Subject: [virtio-dev] Re: [char-misc-next 13/13] mei: virtio: virtualization frontend
 driver
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Winkler, Tomas" <tomas.winkler@intel.com>, "Usyskin, Alexander" <alexander.usyskin@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wang, Yu1" <yu1.wang@intel.com>, "Liu, Shuo A" <shuo.a.liu@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Dec 03, 2020 at 11:01:45PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 03, 2020 at 04:51:10PM -0500, Michael S. Tsirkin wrote:
> > On Wed, Nov 25, 2020 at 09:18:04PM +0000, Winkler, Tomas wrote:
> > > > 
> > > > On Tue, Aug 18, 2020 at 02:51:47PM +0300, Tomas Winkler wrote:
> > > > > +#ifndef VIRTIO_ID_MEI
> > > > > +#define VIRTIO_ID_MEI 0xFFFE /* virtio mei */ #endif
> > > > 
> > > > Just noticed now that this driver landed upstream.  Can I ask that you guys
> > > > please register IDs with the virtio TC and not just pick a number at random?
> > > > In particular this is way outside allowed range.
> > > > 
> > > > IDs should also be listed in include/uapi/linux/virtio_ids.h
> > > > 
> > > > If people just pick random numbers like this collistions are unavoidable.
> > > > 
> > > > List of IDs is part of virtio spec, chapter "Device Types".
> > > > 
> > > > Please do this change now before this goes out to production!
> > > Okay,  this was assigned by ACRN, my impression was it's already registered.
> > > Will take care of.
> > > Thanks
> > > Tomas
> > 
> > Well nothing happened yet.
> > 
> > I think at this point we really should revert this patch before Linux is
> > released so in the next version the correct ID can be used instead of a reserved one.
> > Otherwise Linux will be stuck supporting this forever and will conflict
> > with hypervisors using this for what this range is for which is
> > experimental use.
> > 
> > Greg, any opinion on that?
> 
> I will be glad to revert it, what's the git commit id?

commit d162219c655c8cf8003128a13840d6c1e183fb80
Author: Tomas Winkler <tomas.winkler@intel.com>
Date:   Tue Aug 18 14:51:47 2020 +0300

    mei: virtio: virtualization frontend driver
    

I sent a revert on list in case it makes things easier,
but it's just a result of a plain git revert,
build-tested.


> thanks,
> 
> greg k-h


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

