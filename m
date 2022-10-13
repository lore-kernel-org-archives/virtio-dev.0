Return-Path: <virtio-dev-return-10014-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 584F798657E
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Oct 2022 14:33:33 +0000 (UTC)
Date: Thu, 13 Oct 2022 10:33:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20221013103229-mutt-send-email-mst@kernel.org>
References: <20220923013341-mutt-send-email-mst@kernel.org>
 <619af5b3-4c38-955f-0f7f-f351f5a9527e@redhat.com>
 <20220928093530-mutt-send-email-mst@kernel.org>
 <CACGkMEsKHBo+tgJrADif9y5qLF-OHoK7pO6YvQBa-edjjPwVJQ@mail.gmail.com>
 <20220929022523-mutt-send-email-mst@kernel.org>
 <CACGkMEvmVJVCG-W-phG_JkVnEy_EpKRgG38LexTzStn7dADztw@mail.gmail.com>
 <20221009155501-mutt-send-email-mst@kernel.org>
 <CACGkMEuRAU-hcqBDU2DpD=9Si85NQE2MCQJ0_zXuEPqYr1vdAQ@mail.gmail.com>
 <20221012010413-mutt-send-email-mst@kernel.org>
 <CACGkMEsTNPoZs0a8H4JWehkP9xaa6NZ5_A-7RRKx8ZuFMHpeSw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsTNPoZs0a8H4JWehkP9xaa6NZ5_A-7RRKx8ZuFMHpeSw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v8] virtio_net: support for split transport
 header
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Kangjie Xu <kangjie.xu@linux.alibaba.com>, Heng Qi <hengqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Oct 13, 2022 at 02:47:55PM +0800, Jason Wang wrote:
> On Wed, Oct 12, 2022 at 1:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Oct 12, 2022 at 11:17:30AM +0800, Jason Wang wrote:
> > > On Tue, Oct 11, 2022 at 1:12 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Sat, Oct 08, 2022 at 12:37:45PM +0800, Jason Wang wrote:
> > > > > On Thu, Sep 29, 2022 at 3:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Sep 29, 2022 at 09:48:33AM +0800, Jason Wang wrote:
> > > > > > > On Wed, Sep 28, 2022 at 9:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Sep 26, 2022 at 04:06:17PM +0800, Jason Wang wrote:
> > > > > > > > > > Jason I think the issue with previous proposals is that they conflict
> > > > > > > > > > with VIRTIO_F_ANY_LAYOUT. We have repeatedly found that giving the
> > > > > > > > > > driver flexibility in arranging the packet in memory is benefitial.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Yes, but I didn't found how it can conflict the any_layout. Device can just
> > > > > > > > > to not split the header when the layout doesn't fit for header splitting.
> > > > > > > > > (And this seems the case even if we're using buffers).
> > > > > > > >
> > > > > > > > Well spec says:
> > > > > > > >
> > > > > > > >         indicates to both the device and the driver that no
> > > > > > > >         assumptions were made about framing.
> > > > > > > >
> > > > > > > > if device assumes that descriptor boundaries are where
> > > > > > > > driver wants packet to be stored that is clearly
> > > > > > > > an assumption.
> > > > > > >
> > > > > > > Yes but what I want to say is, the device can choose to not split the
> > > > > > > packet if the framing doesn't fit. Does it still comply with the above
> > > > > > > description?
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > The point of ANY_LAYOUT is to give drivers maximum flexibility.
> > > > > > For example, if driver wants to split the header at some specific
> > > > > > offset this is already possible without extra functionality.
> > > > >
> > > > > I'm not sure how this would work without the support from the device.
> > > > > This probably can only work if:
> > > > >
> > > > > 1) the driver know what kind of packet it can receive
> > > > > 2) protocol have fixed length of the header
> > > > >
> > > > > This is probably not true consider:
> > > > >
> > > > > 1) TCP and UDP have different header length
> > > > > 2) IPv6 has an variable length of the header
> > > >
> > > > We currently say:
> > > >
> > > > If a receive packet is spread over multiple buffers, the device
> > > > MUST use all buffers but the last (i.e. the first \field{num_buffers} -
> > > > 1 buffers) completely up to the full length of each buffer
> > > > supplied by the driver.
> > > >
> > > > the idea is basically just to lift this requirement for specific
> > > > packets. Things certainly worked before, this is just an
> > > > optimization.
> > >
> > > The problem is, the offset is not fixed and can be determined by the
> > > driver. It's variable so it requires the device to parse the packet to
> > > know.
> > >
> > > Thanks
> >
> > IIUC device parsing packet and splitting the header is exactly what the
> > feature is supposed to do. It's benefitial if device is a hardware one.
> 
> Right, so in any way (even with a mergeable buffer), if the device
> parses and splits, we need to tweak the section you quote above from
> the spec, since there will be some space left in the buffer other than
> the last one?
> 
> Thanks

Exactly. My point was, we know relaxing this does not conflict with
other parts of the spec since we didn't use to require this.

> >
> >
> > > >
> > > >
> > > >
> > > > >
> > > > > >
> > > > > > Let's keep it that way.
> > > > > >
> > > > > > Now, let's formulate what are some of the problems with the current way.
> > > > > >
> > > > > >
> > > > > >
> > > > > > A- mergeable buffers is even more flexible, since a single packet
> > > > > >   is built up of multiple buffers. And in theory device can
> > > > > >   choose arbitrary set of buffers to store a packet.
> > > > > >   So you could supply a small buffer for headers followed by a bigger
> > > > > >   one for payload, in theory even without any changes.
> > > > > >   Problem 1: However since this is not how devices currently operate,
> > > > > >   a feature bit would be helpful.
> > > > >
> > > > > How do we know the bigger buffer is sufficient for the packet? If we
> > > > > try to allocate 64K (not sufficient for the future even) it breaks the
> > > > > effort of the mergeable buffer:
> > > > >
> > > > > header buffer #1
> > > > > payload buffer #1
> > > > > header buffer #2
> > > > > payload buffer #2
> > > > >
> > > > > Is the device expected to
> > > > >
> > > > > 1) fill payload in header buffer #2, this breaks the effort that we
> > > > > want to make payload page aligned
> > > > > 2) skip header buffer #2, in this case, the device assumes the framing
> > > > > when it breaks any layout
> > > > >
> > > > > >
> > > > > >   Problem 2: Also, in the past we found it useful to be able to figure out whether
> > > > > >   packet fits in a single buffer without looking at the header.
> > > > > >   For this reason, we have this text:
> > > > > >
> > > > > >         If a receive packet is spread over multiple buffers, the device
> > > > > >         MUST use all buffers but the last (i.e. the first \field{num_buffers} -
> > > > > >         1 buffers) completely up to the full length of each buffer
> > > > > >         supplied by the driver.
> > > > > >
> > > > > >   if we want to keep this optimization and allow using a separate
> > > > > >   buffer for headers, then I think we could rely on the feature bit
> > > > > >   from Problem 1 and just make an exception for the first buffer.
> > > > > >   Also num_buffers is then always >= 2, maybe state this to avoid
> > > > > >   confusion.
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > B- without mergeable, there's no flexibility. In particular, there can
> > > > > > not be uninitialized space between header and data.
> > > > >
> > > > > I had two questions
> > > > >
> > > > > 1) why is this not a problem of mergeable? There's no guarantee that
> > > > > the header is just the length of what the driver allocates for header
> > > > > buffer anyhow
> > > > >
> > > > > E.g the header length could be smaller than the header buffer, the
> > > > > device still needs to skip part of the space in the header buffer.
> > > > >
> > > > > 2) it should be the responsibility of the driver to handle the
> > > > > uninitialized space, it should do anything that is necessary for
> > > > > security, more below
> > > > >
> > > > > > If we had flexibility here, this could be
> > > > > > helpful for alignment, security, etc.
> > > > > > Unfortunately, our hands are tied:
> > > > > >
> > > > > >
> > > > > >         \field{len} is particularly useful
> > > > > >         for drivers using untrusted buffers: if a driver does not know exactly
> > > > > >         how much has been written by the device, the driver would have to zero
> > > > > >         the buffer in advance to ensure no data leakage occurs.
> > > > > >
> > > > > >         For example, a network driver may hand a received buffer directly to
> > > > > >         an unprivileged userspace application.  If the network device has not
> > > > > >         overwritten the bytes which were in that buffer, this could leak the
> > > > > >         contents of freed memory from other processes to the application.
> > > > >
> > > > > This should be a bug of the driver. For example, if the driver wants
> > > > > to implement zerocopy, it must guarantee that every byte was written
> > > > > by the device before mapping it to the userspace, if it can't it
> > > > > should do the copy instead.
> > > > >
> > > > > >
> > > > > >
> > > > > > so all buffers have to be initialized completely up to the reported
> > > > > > used length.
> > > > > >
> > > > > > It could be that the guarantee is not relevant in some use-cases.
> > > > > > We would have to specify that this is an exception to the rule,
> > > > > > explain that drivers must be careful about information leaks.
> > > > > > Let's say there's a feature bit that adds uninitialized space
> > > > > > somewhere. How much was added? We can find out by parsing the
> > > > > > packet but once you start doing that just to assemble the skb
> > > > > > you have already lost performance.
> > > > >
> > > > > I don't get here, for those uninitialized spaces, it looks just
> > > > > tailroom for the skb.
> > > > >
> > > > > Thanks
> > > > >
> > > > > > So lots of spec work, some security risks, and unclear performance.
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > Is above a fair summary?
> > > > > >
> > > > > >
> > > > > >
> > > > > > If yes I would say let's address A, but make sure we ask drivers
> > > > > > to clear the new feature bit if there's no mergeable
> > > > > > (as opposed to e.g. failing probe) so we can add
> > > > > > support for !mergeable down the road.
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > MST
> > > > > >
> > > >
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

