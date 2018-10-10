Return-Path: virtio-dev-return-4888-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E34AE985CA2
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 Oct 2018 14:36:32 +0000 (UTC)
Date: Wed, 10 Oct 2018 10:36:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181010103335-mutt-send-email-mst@kernel.org>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180827170005-mutt-send-email-mst@kernel.org>
 <20180907012225.GA32677@debian>
 <20180907084509-mutt-send-email-mst@kernel.org>
 <20180910030053.GA15645@debian>
 <f5ef0393-cf02-0795-a51a-8783ee300037@redhat.com>
 <20180911053726.GA7472@debian>
 <20180912121457-mutt-send-email-mst@kernel.org>
 <20180913085919.GA42049@fbsd1.sh.intel.com>
 <98d6bd4d-45e2-4207-e961-782f649e0139@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98d6bd4d-45e2-4207-e961-782f649e0139@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH net-next v2 0/5] virtio: support packed
 ring
To: Jason Wang <jasowang@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, wexu@redhat.com, jfreimann@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 13, 2018 at 05:47:29PM +0800, Jason Wang wrote:
> 
> 
> On 2018年09月13日 16:59, Tiwei Bie wrote:
> > > If what you say is true then we should take a careful look
> > > and not supporting these generic things with packed layout.
> > > Once we do support them it will be too late and we won't
> > > be able to get performance back.
> > I think it's a good point that we don't need to support
> > everything in packed ring (especially these which would
> > hurt the performance), as the packed ring aims at high
> > performance. I'm also wondering about the features. Is
> > there any possibility that we won't support the out of
> > order processing (at least not by default) in packed ring?
> > If I didn't miss anything, the need to support out of order
> > processing in packed ring will make the data structure
> > inside the driver not cache friendly which is similar to
> > the case of the descriptor table in the split ring (the
> > difference is that, it only happens in driver now).
> 
> Out of order is not the only user, DMA is another one. We don't have used
> ring(len), so we need to maintain buffer length somewhere even for in order
> device.

For a bunch of systems dma unmap is a nop so we do not really
need to maintain it. It's a question of an API to detect that
and optimize for it. I posted a proposed patch for that -
want to try using that?

> But if it's not too late, I second for a OUT_OF_ORDER feature.
> Starting from in order can have much simpler code in driver.
> 
> Thanks

It's tricky to change the flag polarity because of compatibility
with legacy interfaces. Why is this such a big deal?

Let's teach drivers about IN_ORDER, then if devices
are in order it will get enabled by default.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

