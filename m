Return-Path: <virtio-dev-return-9978-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ECE9F986602
	for <virtio-dev@lists.oasis-open.org>; Fri, 23 Sep 2022 10:59:59 +0000 (UTC)
Message-ID: <1663930136.9909854-1-xuanzhuo@linux.alibaba.com>
Date: Fri, 23 Sep 2022 18:48:56 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1663297006-64248-1-git-send-email-hengqi@linux.alibaba.com>
 <3c3cc916-c605-1ed2-d3ff-d8d8ce668f17@redhat.com>
 <20220920032824.GA125047@h68b04307.sqa.eu95>
 <CACGkMEtOHXtNtG13Zxpc+bhYJVyefp999kttz4YcPi22nMBSpQ@mail.gmail.com>
 <1663903426.8765974-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsmqngS-HYPzzV8b9dmv95=W6dJebAa=asXGmo7VEAnoA@mail.gmail.com>
 <20220923013341-mutt-send-email-mst@kernel.org>
 <1663916247.3806806-1-xuanzhuo@linux.alibaba.com>
 <20220923064208-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220923064208-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] [PATCH v8] virtio_net: support for split transport header
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Kangjie Xu <kangjie.xu@linux.alibaba.com>, Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 23 Sep 2022 06:44:54 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Sep 23, 2022 at 02:57:27PM +0800, Xuan Zhuo wrote:
> > > > > Michael doesn't want to use desc chain, it's not just a performance issue. In an
> > > > > early email, he mentioned that desc chain may be abandoned in the future. So we
> > > > > have been trying not to rely on desc chain.
> > > >
> > > > This seems to be a very large change which seems a little bit too
> > > > early to be considered.
> > >
> > > I'd like to put it in other terms. Fundamentally devices are not
> > > supposed to talk about descriptors at all. Descriptors are
> > > a way to describe buffers, and devices should all work in terms
> > > of buffers. I am working on cleaning up the spec from confusion
> > > and terminology mixups. We have several major sources all over the spec:
> > > - descriptor/buffer used inconsistently
> > > - feature negotiated/offered used inconsistently
> > > - field exists/valid used inconsistently
> > >
> > > My way to address the first issue is to make sure devices all work
> > > with buffers. And buffers are described by descriptors (makes sense,
> > > right?) and made available to device by driver and used by device.
> >
> > Can we try to keep desc info? I think it's a very important feature for
> > virtio-net, and many NICs are designed based on this.
> >
> > Our current solutions B and C will waste a lot of memory. If the page occupied
> > by the header can be quickly reclaimed, then we have to do a copy in the driver.
>
> Not sure I understand. Can you explain?


For example B, we allocate two consecutive pages, the second page is used for
payload. The first page is used to reserve the header. The first page is too
wasteful, 4k of space, only the header is saved. In this way, we can copy away
the data of the first page, so that the first page can be quickly reclaimed.

Why two consecutive pages? The payload achieves page alignment, and there is
still some space in front of the page, so we must allocate two connected pages.

>
> > >
> > > The advantage of this is layering - we can change the way buffers
> > > are passed around without changing devices. And, it matches
> > > the virtio API nicely.
> > >
> > > Existing devices are all fine with this - they do not pass any
> > > information in the descriptor. Yes, this seems like an option to
> > > pass some information around, but I am not convinced it is worth
> > > the layering violation.
> > >
> > > By comparison, ability to write data at an offset seems generally
> > > useful, in particular we have a very old issue even without
> > > the split header feature where with mergeable buffers
> > > if we attempt to align the data in the 1st buffer at a cache line
> > > boundary by adding an offset before ETH header, then when it spills
> > > over to the second buffer it will be misaligned there. Wastes
> > > an extra cache line for such packets. Offsets can allow fixing this.
> > >
> >
> > Scheme B In addition to the memory problem, under this scheme, if we want to
> > implement tcp zerocopy, then we must apply for two consecutive pages for a
> > buffer. The second page is used to place the payload. The first is used to place
> > the header.
>
>
> I just don't understand why there would be a difference. Explanation?

I'm concerned that allocating two contiguous pages in large numbers will cause
unknowable problems(such perfermance)

Thanks.


>
> >
> > >
> > > I don't see architecturally what is wrong with making feature just
> > > depend on mergeable buffers for now. We can always allow a combination
> > > down the road. Let's just make it clear that if drivers see SPLIT &&
> > > !MERGEABLE they should not fail probe, they should instead clear the
> > > split header feature.
> > >
> >
> > According to my understanding, for B, it does not depend on mergeable.
> >
> > If we give up desc info completely, then we prefer B.
> >
> > Hi Jason, what are your thoughts?
> >
> > Thanks.
> >
> > >
> > >
> > >
> > > > >
> > > > > If we can't make a feature depend only on mergeable, should we use solution B?
> > > > >
> > > > >      2. Scheme B ( refer to your suggestion )
> > > > >
> > > > >      Our rethinking approach is no longer based on descriptor chain.
> > > > >
> > > > >      We refer to your proposed offset-based scheme as scheme B.
> > > >
> > > > The offset seems to be the suggestion of Michael.
> > > >
> > > > I think I like the design of v7 for several reasons:
> > > >
> > > > 1) easy to reserve head/tailroom without any extension of the spec
> > > > 2) easy to work with mergeable rx buffer
> > > > 3) it is the model used by modern NIC like e810 [1]
> > > >
> > > > [1] e810 manual 2.4 Figure 10-4 have a nic diagram to demonstrate how
> > > > it works which is similar to v7
> > > >
> > > > Thanks
> > > >
> > > > >      As you suggested, scheme B gives the device a buffer, using offset to
> > > > >      indicate where to place the payload. Like this:
> > > > >
> > > > >      <header>...<padding>... <beginning of page><data>
> > > > >
> > > > >      But how to apply for this buffer?
> > > > >      Since we want the payload to be placed on a separate page, the method
> > > > >      we consider is to directly alloc two pages from driver of contiguous memory.
> > > > >
> > > > >      Then the beginning of this contiguous memory is used to store the headroom,
> > > > >      and the contiguous memory after the headroom is directly handed over to the device.
> > > > >      Similar to the following:
> > > > >
> > > > >      [------------------ receive buffer(2 pages) ------------------------------]
> > > > >      [<------------first page -------------------><------ second page -------->]
> > > > >      [<-----><virtnet hdr> <mac,ip,tcp>..<padding><       payload             >]
> > > > >         ^    ^
> > > > >         |    |
> > > > >         |    pointer to device
> > > > >         |
> > > > >         |
> > > > >         Driver reserved, the later part is filled
> > > > >
> > > > > We have already entered v8, but we have not been able to reach an agreement on
> > > > > the basic capabilities. I want to solve this problem first.
> > > > >
> > > > > @Jason @Michael
> > > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > > >+    \item The total size of the virtio net header and the transport header exceeds \field{max_len}.
> > > > > > > >
> > > > > > > >
> > > > > > > > I don't get the reason why we need max_len. Can't it implied in the
> > > > > > > > length of the first descriptor?
> > > > > > > >
> > > > > > >
> > > > > > > Split transport header is usually used in high-throughput scenarios, such as GSO-enabled cases.
> > > > > > > Therefore, it is best to reserve tailroom with $ (the length of the buffer) - (\field{offset} + \filed{max_len}) $
> > > > > > > in the first buffer to build the non-linear data area of the socket buffer.
> > > > > > >
> > > > > > > >
> > > > > > > > >+\end{itemize}
> > > > > > > > >+
> > > > > > > > >+If the transport header is split by the device, the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER
> > > > > > > > >+bit in \field{flags} MUST be set. The transport header MUST be on the first
> > > > > > > > >+buffer, following the virtio net header. The payload MUST start from the
> > > > > > > > >+second buffer. The device MUST set \field{hdr_len} of structure
> > > > > > > > >+virtio_net_hdr to the length of the transport header.
> > > > > > > > >+The used length still reports the number of bytes it has written to memory.
> > > > > > > > >+
> > > > > > > > >+\field{offset} and \field{max_len} are valid when device uses the first buffer.
> > > > > > > > >+The device MUST reserve space in the first buffer using \filed{offset}.
> > > > > > > > >+If \field{offset} exceeds the length of the buffer, the device MUST drop
> > > > > > > > >+the receive packets.
> > > > > > > >
> > > > > > > >
> > > > > > > > Can the device simply don't split the packet in this case? Anyhow we
> > > > > > > > need synchronize the driver with the device in the case (e.g when
> > > > > > > > driver is try to having a new max_len).
> > > > > > > >
> > > > > > >
> > > > > > > We think that \field{offset} is actively set by the driver, so the driver
> > > > > > > will also receive packets according to this offset.
> > > > > > > But if the case is considered to be caused by driver error settings,
> > > > > > > the device can do not split the packet.
> > > > > >
> > > > > > Note that protocol like ipv6 allows variable length of the header,
> > > > > > falling back to not split the header seems better to me.
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > > (I wonder if the offset deserves a independent feature (but depends
> > > > > > > > on the merge able) in this case).
> > > > > > > >
> > > > > > >
> > > > > > > Okay, we can consider later.
> > > > > > >
> > > > > > > >
> > > > > > > > >  The maximum available length of the first buffer
> > > > > > > > >+used by the device is specified by \field{max_len}.
> > > > > > > >
> > > > > > > >
> > > > > > > > Similarly the max length seems to be implied by length - offset?
> > > > > > > >
> > > > > > >
> > > > > > > You can refer to the above answer about \field{max_len} similarly.
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > >
> > > > > > > > >  If \field{max_len} is 0 or
> > > > > > > > >+$ \field{offset} + \field{max_len} $ is greater than the length of the buffer,
> > > > > > > > >+the device can use the entire buffer starting at \field{offset}.
> > > > > > > > >+
> > > > > > > > >+\drivernormative{\subparagraph}{Setting Split Transport Header}{Device Types / Network Device / Device Operation / Control Virtqueue / Split Transport Header}
> > > > > > > > >+
> > > > > > > > >+If the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags} is set, the driver
> > > > > > > > >+SHOULD treat the contents of \field{hdr_len} as the length of the transport header
> > > > > > > > >+inside the first buffer.
> > > > > > > > >+
> > > > > > > > >+If \field{max_len} is not equal to 0, it MUST be greater than the size of the virtio net header.
> > > > > > > > >  \paragraph{Notifications Coalescing}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
> > > > > > >
> > > > > >
> > > > > >
> > > > > > ---------------------------------------------------------------------
> > > > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > > > > >
> > > > >
> > >
> > >
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > >
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

