Return-Path: <virtio-dev-return-9939-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 24577986584
	for <virtio-dev@lists.oasis-open.org>; Fri,  9 Sep 2022 10:23:05 +0000 (UTC)
Date: Fri, 9 Sep 2022 18:22:59 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
Message-ID: <20220909102259.GA64822@h68b04307.sqa.eu95>
References: <1660642495-104002-1-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuy2m7PagJwccx3QSnasuJpnF0MtKn-1MQSJ3sPLjvjew@mail.gmail.com>
 <d091f3e4-3d69-f0ba-5c6b-d3e05ca6b88c@linux.alibaba.com>
 <20220904162337-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220904162337-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [PATCH v7] virtio_net: support split header
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, kangjie.xu@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Sep 04, 2022 at 04:27:38PM -0400, Michael S. Tsirkin wrote:
> On Fri, Sep 02, 2022 at 03:36:25PM +0800, Heng Qi wrote:
> > We need to clarify that the purpose of header splitting is to make all payloads
> > can be independently in a page, which is beneficial for the zerocopy
> > implemented by the upper layer.
> 
> absolutely, pls add motivation.
> 
> > If the driver does not enforce that the buffers submitted to the receiveq MUST
> > be composed of at least two descriptors, then header splitting will become meaningless,
> > or the VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER feature should not be negotiated at this time.
> > 
> > 
> > Thanks.
> > 
> > 
> 
> 
> This seems very narrow and unecessarily wasteful of descriptors.
> What is wrong in this:
> 
> <header>...<padding>... <beginning of page><data>
> 
> seems to achieve the goal of data in a separate page without
> using extra descriptors.
> 
> thus my proposal to replace the requirement of a separate
> descriptor with an offset of data from beginning of
> buffer that driver sets.
>


We have carefully considered your suggestion. 

Let's summarize the schemes we've considered before and now.

1. Scheme A ( refer to spec v7 )

We refer to spec v7 and earlier as scheme A for short. Review scheme A below: 
|                         receive buffer                            | 
|              0th descriptor                      | 1th descriptor | 
| virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|      payload   | 

We use a buffer plus a separate page when allocating the receive
buffer. In this way, we can ensure that all payloads can be put
independently in a page, which is very beneficial for the zerocopy 
implemented by the upper layer. 

Scheme A better solves the problem of headroom, tailroom and
memory waste, but as you said, this solution relies on descriptor chain. 

2. Scheme B ( refer to your suggestion )

Our rethinking approach is no longer based on descriptor chain.
 
We refer to your proposed offset-based scheme as scheme B.
As you suggested, scheme B gives the device a buffer, using offset to
indicate where to place the payload. Like this: 

<header>...<padding>... <beginning of page><data> 

But how to apply for this buffer?
Since we want the payload to be placed on a separate page, the method
we consider is to directly alloc two pages from driver of contiguous memory. 

Then the beginning of this contiguous memory is used to store the headroom,
and the contiguous memory after the headroom is directly handed over to the device.
Similar to the following: 

[------------------ receive buffer(2 pages) ------------------------------] 
[<------------first page -------------------><------ second page -------->] 
[<-----><virtnet hdr> <mac,ip,tcp>..<padding><       payload             >] 
   ^    ^
   |    |
   |    pointer to device
   |
   |
   Driver reserved, the later part is filled

3. Scheme C (this sheme we have sent to you on September 7th, maybe you miss it.)

Based on your previous suggestion, we also considered another new scheme C. 
This scheme is implemented based on mergeable buffer, filling a separate page each time. 

If the split header is negotiated and the packet can be successfully split by the device,
the device needs to find at least two buffers, namely two pages, one for the virtio-net header
and transport header, and the other for the payload. Like the following: 

|                       receive buffer1(page)      |     receive buffer2 (page)   | 
| virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|         payload              | 

At the same time, if XDP is considered, then the device needs to add headroom at the
beginning of receive buffer1 when receiving packets, so that the driver can process
programs similar to XDP. 

In order to solve this problem, scheme C introduce an offset which requires
the device to write data from the offset to receive buffer1, like the following: 

|                   receive buffer (page)                                 | receive buffer (page) | 
| <-- offset(hold) --> | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|         payload       | 
^
|
pointer to device
					   


4. Summarize

Then we simply compare the advantages and disadvantages of scheme A(spec v7),
scheme B (offset buffer(2 pages)) and scheme C (based on mergeable buffer): 

1). descriptor chain: 
         i)  A depends on desciptor chain;
         ii) B, C do not depend on desciptor chain. 

2). page alloc 
         i) B fills with two consecutive pages, which causes a great waste of memory
                for small packages such as arp;
         ii) C fills with a single page, slightly better than B. 

3). Memory waste: 
         i) The memory waste of scheme A is mainly the 0th descriptor
                that is skipped by the device;
         ii) When scheme B and scheme C successfully split the header,
                there is a huge waste of the first page, but the first page
                can be quickly released by copying in driver. 

4). headroom 
         i) The headrooms of plan A and plan B are reserved;
         ii) Scheme C requires the driver to set offset to let the device skip
                offset when using receive buffer1. 

Which plan do you prefer? 

Thanks. 



> 
> -- 
> MST
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

