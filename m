Return-Path: virtio-dev-return-4893-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2577F985CB1
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 Oct 2018 12:13:46 +0000 (UTC)
Date: Thu, 11 Oct 2018 20:12:21 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20181011121221.GA27106@debian>
References: <20180827170005-mutt-send-email-mst@kernel.org>
 <20180907012225.GA32677@debian>
 <20180907084509-mutt-send-email-mst@kernel.org>
 <20180910030053.GA15645@debian>
 <f5ef0393-cf02-0795-a51a-8783ee300037@redhat.com>
 <20180911053726.GA7472@debian>
 <20180912121457-mutt-send-email-mst@kernel.org>
 <20180913085919.GA42049@fbsd1.sh.intel.com>
 <98d6bd4d-45e2-4207-e961-782f649e0139@redhat.com>
 <20181010103335-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181010103335-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [PATCH net-next v2 0/5] virtio: support packed
 ring
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, wexu@redhat.com, jfreimann@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Oct 10, 2018 at 10:36:26AM -0400, Michael S. Tsirkin wrote:
> On Thu, Sep 13, 2018 at 05:47:29PM +0800, Jason Wang wrote:
> > On 2018年09月13日 16:59, Tiwei Bie wrote:
> > > > If what you say is true then we should take a careful look
> > > > and not supporting these generic things with packed layout.
> > > > Once we do support them it will be too late and we won't
> > > > be able to get performance back.
> > > I think it's a good point that we don't need to support
> > > everything in packed ring (especially these which would
> > > hurt the performance), as the packed ring aims at high
> > > performance. I'm also wondering about the features. Is
> > > there any possibility that we won't support the out of
> > > order processing (at least not by default) in packed ring?
> > > If I didn't miss anything, the need to support out of order
> > > processing in packed ring will make the data structure
> > > inside the driver not cache friendly which is similar to
> > > the case of the descriptor table in the split ring (the
> > > difference is that, it only happens in driver now).
> > 
> > Out of order is not the only user, DMA is another one. We don't have used
> > ring(len), so we need to maintain buffer length somewhere even for in order
> > device.
> 
> For a bunch of systems dma unmap is a nop so we do not really
> need to maintain it. It's a question of an API to detect that
> and optimize for it. I posted a proposed patch for that -
> want to try using that?

Yeah, definitely!

> 
> > But if it's not too late, I second for a OUT_OF_ORDER feature.
> > Starting from in order can have much simpler code in driver.
> > 
> > Thanks
> 
> It's tricky to change the flag polarity because of compatibility
> with legacy interfaces. Why is this such a big deal?
> 
> Let's teach drivers about IN_ORDER, then if devices
> are in order it will get enabled by default.

Yeah, make sense.

Besides, I have done some further profiling and debugging
both in kernel driver and DPDK vhost. Previously I was mislead
by a bug in vhost code. I will send a patch to fix that bug.
With that bug fixed, the performance of packed ring in the
test between kernel driver and DPDK vhost is better now.
I will send a new series soon. Thanks!

> 
> -- 
> MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

