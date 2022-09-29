Return-Path: <virtio-dev-return-9994-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 42D1798660F
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Sep 2022 10:06:49 +0000 (UTC)
Date: Thu, 29 Sep 2022 06:06:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220929052841-mutt-send-email-mst@kernel.org>
References: <20220920032824.GA125047@h68b04307.sqa.eu95>
 <CACGkMEtOHXtNtG13Zxpc+bhYJVyefp999kttz4YcPi22nMBSpQ@mail.gmail.com>
 <1663903426.8765974-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsmqngS-HYPzzV8b9dmv95=W6dJebAa=asXGmo7VEAnoA@mail.gmail.com>
 <20220923013341-mutt-send-email-mst@kernel.org>
 <619af5b3-4c38-955f-0f7f-f351f5a9527e@redhat.com>
 <20220928093530-mutt-send-email-mst@kernel.org>
 <CACGkMEsKHBo+tgJrADif9y5qLF-OHoK7pO6YvQBa-edjjPwVJQ@mail.gmail.com>
 <20220929022523-mutt-send-email-mst@kernel.org>
 <1664439842.0523622-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1664439842.0523622-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [virtio-dev] [PATCH v8] virtio_net: support for split transport
 header
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Kangjie Xu <kangjie.xu@linux.alibaba.com>, Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 29, 2022 at 04:24:02PM +0800, Xuan Zhuo wrote:
> On Thu, 29 Sep 2022 03:04:03 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Sep 29, 2022 at 09:48:33AM +0800, Jason Wang wrote:
> > > On Wed, Sep 28, 2022 at 9:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Sep 26, 2022 at 04:06:17PM +0800, Jason Wang wrote:
> > > > > > Jason I think the issue with previous proposals is that they conflict
> > > > > > with VIRTIO_F_ANY_LAYOUT. We have repeatedly found that giving the
> > > > > > driver flexibility in arranging the packet in memory is benefitial.
> > > > >
> > > > >
> > > > > Yes, but I didn't found how it can conflict the any_layout. Device can just
> > > > > to not split the header when the layout doesn't fit for header splitting.
> > > > > (And this seems the case even if we're using buffers).
> > > >
> > > > Well spec says:
> > > >
> > > >         indicates to both the device and the driver that no
> > > >         assumptions were made about framing.
> > > >
> > > > if device assumes that descriptor boundaries are where
> > > > driver wants packet to be stored that is clearly
> > > > an assumption.
> > >
> > > Yes but what I want to say is, the device can choose to not split the
> > > packet if the framing doesn't fit. Does it still comply with the above
> > > description?
> > >
> > > Thanks
> >
> > The point of ANY_LAYOUT is to give drivers maximum flexibility.
> > For example, if driver wants to split the header at some specific
> > offset this is already possible without extra functionality.
> >
> > Let's keep it that way.
> >
> > Now, let's formulate what are some of the problems with the current way.
> >
> >
> >
> > A- mergeable buffers is even more flexible, since a single packet
> >   is built up of multiple buffers.
> 
> If I understand correctly, this is our v8.

I think it is, or at least close.

> > And in theory device can
> >   choose arbitrary set of buffers to store a packet.
> >   So you could supply a small buffer for headers followed by a bigger
> >   one for payload, in theory even without any changes.
> 
> This is very interesting, I did not think of this point.
> This is helpful to reduce the waste of memory.

Hmm good point. I should add: since we are no longer fully using the
first buffer the feature has a memory cost and - in case of a cache
pressure - can degrade performance rather than improve it.
Thus, allowing flexibility for both devices and drivers at runtime
rather than fixing things through features thus sounds like a good idea.


> >   Problem 1: However since this is not how devices currently operate,
> >   a feature bit would be helpful.
> >
> >   Problem 2: Also, in the past we found it useful to be able to figure out whether
> >   packet fits in a single buffer without looking at the header.
> >   For this reason, we have this text:
> >
> > 	If a receive packet is spread over multiple buffers, the device
> > 	MUST use all buffers but the last (i.e. the first \field{num_buffers} -
> > 	1 buffers) completely up to the full length of each buffer
> > 	supplied by the driver.
> >
> >   if we want to keep this optimization and allow using a separate
> >   buffer for headers, then I think we could rely on the feature bit
> >   from Problem 1 and just make an exception for the first buffer.
> >   Also num_buffers is then always >= 2, maybe state this to avoid
> >   confusion.
> >
> 
> Yes, I think this is feasible.


Thinking more about this, a question is what to do about packets without
split header. I can see several options
A- add some buffers just for the non split case. without in-order they
  can just stay available. with in-order they have to be recycled which
  might be expensive.
  They will also occupy space in the ring. more memory costs.
  Don't much like it for above reasons.
  OTOH then I wanted to work on partial-order anyway. Maybe it's time
  to prioritize that work.

B- write all of the packet in the payload buffer and just skip header buffer (e.g. make it 0 size?)
  payload within packet will be misaligned then. Do we care? maybe not -
  this was supposed to be an exception. In this case:
  Problem B: where should virtio net header
  go then? we can put it in the header buffer still, or we can
  store it linear with the packet.  or we can leave both options, up to device.
  what is better might depend on
  different factors.  any chance of performance testing?

> >
> >
> >
> >
> > B- without mergeable, there's no flexibility. In particular, there can
> > not be uninitialized space between header and data. If we had flexibility here, this could be
> > helpful for alignment, security, etc.
> > Unfortunately, our hands are tied:
> >
> >
> > 	\field{len} is particularly useful
> > 	for drivers using untrusted buffers: if a driver does not know exactly
> > 	how much has been written by the device, the driver would have to zero
> > 	the buffer in advance to ensure no data leakage occurs.
> >
> > 	For example, a network driver may hand a received buffer directly to
> > 	an unprivileged userspace application.  If the network device has not
> > 	overwritten the bytes which were in that buffer, this could leak the
> > 	contents of freed memory from other processes to the application.
> 
> 
> I don't think this is very troublesome, the device can memset the hole by 0.

Yes it can. But that has a performance cost. How large - depends on the
hole size and a bunch of other factors.

> >
> >
> > so all buffers have to be initialized completely up to the reported
> > used length.
> >
> > It could be that the guarantee is not relevant in some use-cases.
> > We would have to specify that this is an exception to the rule,
> > explain that drivers must be careful about information leaks.
> > Let's say there's a feature bit that adds uninitialized space
> > somewhere. How much was added? We can find out by parsing the
> > packet but once you start doing that just to assemble the skb
> > you have already lost performance.
> > So lots of spec work, some security risks, and unclear performance.
> >
> >
> >
> >
> > Is above a fair summary?
> >
> >
> >
> > If yes I would say let's address A, but make sure we ask drivers
> > to clear the new feature bit if there's no mergeable
> > (as opposed to e.g. failing probe) so we can add
> > support for !mergeable down the road.
> >
> >
> >
> >
> >
> > --
> > MST
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

