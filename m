Return-Path: virtio-dev-return-7880-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EBD90985DE0
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Dec 2020 21:51:21 +0000 (UTC)
Date: Thu, 3 Dec 2020 16:51:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20201203164859-mutt-send-email-mst@kernel.org>
References: <20200818115147.2567012-1-tomas.winkler@intel.com>
 <20200818115147.2567012-14-tomas.winkler@intel.com>
 <20201125160326-mutt-send-email-mst@kernel.org>
 <7f6181d8e80d4efb9464e9ec436800b7@intel.com>
MIME-Version: 1.0
In-Reply-To: <7f6181d8e80d4efb9464e9ec436800b7@intel.com>
Subject: [virtio-dev] Re: [char-misc-next 13/13] mei: virtio: virtualization frontend
 driver
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Usyskin, Alexander" <alexander.usyskin@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wang, Yu1" <yu1.wang@intel.com>, "Liu, Shuo A" <shuo.a.liu@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 25, 2020 at 09:18:04PM +0000, Winkler, Tomas wrote:
> > 
> > On Tue, Aug 18, 2020 at 02:51:47PM +0300, Tomas Winkler wrote:
> > > +#ifndef VIRTIO_ID_MEI
> > > +#define VIRTIO_ID_MEI 0xFFFE /* virtio mei */ #endif
> > 
> > Just noticed now that this driver landed upstream.  Can I ask that you guys
> > please register IDs with the virtio TC and not just pick a number at random?
> > In particular this is way outside allowed range.
> > 
> > IDs should also be listed in include/uapi/linux/virtio_ids.h
> > 
> > If people just pick random numbers like this collistions are unavoidable.
> > 
> > List of IDs is part of virtio spec, chapter "Device Types".
> > 
> > Please do this change now before this goes out to production!
> Okay,  this was assigned by ACRN, my impression was it's already registered.
> Will take care of.
> Thanks
> Tomas

Well nothing happened yet.

I think at this point we really should revert this patch before Linux is
released so in the next version the correct ID can be used instead of a reserved one.
Otherwise Linux will be stuck supporting this forever and will conflict
with hypervisors using this for what this range is for which is
experimental use.

Greg, any opinion on that?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

