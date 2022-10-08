Return-Path: <virtio-dev-return-10005-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B302798650D
	for <virtio-dev@lists.oasis-open.org>; Sat,  8 Oct 2022 04:37:59 +0000 (UTC)
MIME-Version: 1.0
References: <1663297006-64248-1-git-send-email-hengqi@linux.alibaba.com>
 <3c3cc916-c605-1ed2-d3ff-d8d8ce668f17@redhat.com> <20220920032824.GA125047@h68b04307.sqa.eu95>
 <CACGkMEtOHXtNtG13Zxpc+bhYJVyefp999kttz4YcPi22nMBSpQ@mail.gmail.com>
 <1663903426.8765974-1-xuanzhuo@linux.alibaba.com> <CACGkMEsmqngS-HYPzzV8b9dmv95=W6dJebAa=asXGmo7VEAnoA@mail.gmail.com>
 <20220923013341-mutt-send-email-mst@kernel.org> <619af5b3-4c38-955f-0f7f-f351f5a9527e@redhat.com>
 <20220928093530-mutt-send-email-mst@kernel.org> <CACGkMEsKHBo+tgJrADif9y5qLF-OHoK7pO6YvQBa-edjjPwVJQ@mail.gmail.com>
 <20220929022523-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220929022523-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 8 Oct 2022 12:37:45 +0800
Message-ID: <CACGkMEvmVJVCG-W-phG_JkVnEy_EpKRgG38LexTzStn7dADztw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v8] virtio_net: support for split transport header
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Kangjie Xu <kangjie.xu@linux.alibaba.com>, Heng Qi <hengqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 29, 2022 at 3:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Sep 29, 2022 at 09:48:33AM +0800, Jason Wang wrote:
> > On Wed, Sep 28, 2022 at 9:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Sep 26, 2022 at 04:06:17PM +0800, Jason Wang wrote:
> > > > > Jason I think the issue with previous proposals is that they conflict
> > > > > with VIRTIO_F_ANY_LAYOUT. We have repeatedly found that giving the
> > > > > driver flexibility in arranging the packet in memory is benefitial.
> > > >
> > > >
> > > > Yes, but I didn't found how it can conflict the any_layout. Device can just
> > > > to not split the header when the layout doesn't fit for header splitting.
> > > > (And this seems the case even if we're using buffers).
> > >
> > > Well spec says:
> > >
> > >         indicates to both the device and the driver that no
> > >         assumptions were made about framing.
> > >
> > > if device assumes that descriptor boundaries are where
> > > driver wants packet to be stored that is clearly
> > > an assumption.
> >
> > Yes but what I want to say is, the device can choose to not split the
> > packet if the framing doesn't fit. Does it still comply with the above
> > description?
> >
> > Thanks
>
> The point of ANY_LAYOUT is to give drivers maximum flexibility.
> For example, if driver wants to split the header at some specific
> offset this is already possible without extra functionality.

I'm not sure how this would work without the support from the device.
This probably can only work if:

1) the driver know what kind of packet it can receive
2) protocol have fixed length of the header

This is probably not true consider:

1) TCP and UDP have different header length
2) IPv6 has an variable length of the header


>
> Let's keep it that way.
>
> Now, let's formulate what are some of the problems with the current way.
>
>
>
> A- mergeable buffers is even more flexible, since a single packet
>   is built up of multiple buffers. And in theory device can
>   choose arbitrary set of buffers to store a packet.
>   So you could supply a small buffer for headers followed by a bigger
>   one for payload, in theory even without any changes.
>   Problem 1: However since this is not how devices currently operate,
>   a feature bit would be helpful.

How do we know the bigger buffer is sufficient for the packet? If we
try to allocate 64K (not sufficient for the future even) it breaks the
effort of the mergeable buffer:

header buffer #1
payload buffer #1
header buffer #2
payload buffer #2

Is the device expected to

1) fill payload in header buffer #2, this breaks the effort that we
want to make payload page aligned
2) skip header buffer #2, in this case, the device assumes the framing
when it breaks any layout

>
>   Problem 2: Also, in the past we found it useful to be able to figure out whether
>   packet fits in a single buffer without looking at the header.
>   For this reason, we have this text:
>
>         If a receive packet is spread over multiple buffers, the device
>         MUST use all buffers but the last (i.e. the first \field{num_buffers} -
>         1 buffers) completely up to the full length of each buffer
>         supplied by the driver.
>
>   if we want to keep this optimization and allow using a separate
>   buffer for headers, then I think we could rely on the feature bit
>   from Problem 1 and just make an exception for the first buffer.
>   Also num_buffers is then always >= 2, maybe state this to avoid
>   confusion.
>
>
>
>
>
> B- without mergeable, there's no flexibility. In particular, there can
> not be uninitialized space between header and data.

I had two questions

1) why is this not a problem of mergeable? There's no guarantee that
the header is just the length of what the driver allocates for header
buffer anyhow

E.g the header length could be smaller than the header buffer, the
device still needs to skip part of the space in the header buffer.

2) it should be the responsibility of the driver to handle the
uninitialized space, it should do anything that is necessary for
security, more below

> If we had flexibility here, this could be
> helpful for alignment, security, etc.
> Unfortunately, our hands are tied:
>
>
>         \field{len} is particularly useful
>         for drivers using untrusted buffers: if a driver does not know exactly
>         how much has been written by the device, the driver would have to zero
>         the buffer in advance to ensure no data leakage occurs.
>
>         For example, a network driver may hand a received buffer directly to
>         an unprivileged userspace application.  If the network device has not
>         overwritten the bytes which were in that buffer, this could leak the
>         contents of freed memory from other processes to the application.

This should be a bug of the driver. For example, if the driver wants
to implement zerocopy, it must guarantee that every byte was written
by the device before mapping it to the userspace, if it can't it
should do the copy instead.

>
>
> so all buffers have to be initialized completely up to the reported
> used length.
>
> It could be that the guarantee is not relevant in some use-cases.
> We would have to specify that this is an exception to the rule,
> explain that drivers must be careful about information leaks.
> Let's say there's a feature bit that adds uninitialized space
> somewhere. How much was added? We can find out by parsing the
> packet but once you start doing that just to assemble the skb
> you have already lost performance.

I don't get here, for those uninitialized spaces, it looks just
tailroom for the skb.

Thanks

> So lots of spec work, some security risks, and unclear performance.
>
>
>
>
> Is above a fair summary?
>
>
>
> If yes I would say let's address A, but make sure we ask drivers
> to clear the new feature bit if there's no mergeable
> (as opposed to e.g. failing probe) so we can add
> support for !mergeable down the road.
>
>
>
>
>
> --
> MST
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

