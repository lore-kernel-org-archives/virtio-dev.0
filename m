Return-Path: <hengqi@linux.alibaba.com>
Message-ID: <f13450f0-854d-123f-eb0b-b8bded5670b8@linux.alibaba.com>
Date: Wed, 1 Feb 2023 21:17:54 +0800
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IFt2aXJ0aW8tY29tbWVudF0g5Zue5aSN77yaW3ZpcnRpby1kZXZd?=
 =?UTF-8?Q?_=5BPATCH_v8=5D_virtio=5Fnet=3A_support_for_split_transport_heade?=
 =?UTF-8?Q?r?=
References: <20220920032824.GA125047@h68b04307.sqa.eu95>
 <CACGkMEtOHXtNtG13Zxpc+bhYJVyefp999kttz4YcPi22nMBSpQ@mail.gmail.com>
 <1663903426.8765974-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsmqngS-HYPzzV8b9dmv95=W6dJebAa=asXGmo7VEAnoA@mail.gmail.com>
 <20220923013341-mutt-send-email-mst@kernel.org>
 <619af5b3-4c38-955f-0f7f-f351f5a9527e@redhat.com>
 <20220928093530-mutt-send-email-mst@kernel.org>
 <CACGkMEsKHBo+tgJrADif9y5qLF-OHoK7pO6YvQBa-edjjPwVJQ@mail.gmail.com>
 <20220929022523-mutt-send-email-mst@kernel.org>
 <CACGkMEvmVJVCG-W-phG_JkVnEy_EpKRgG38LexTzStn7dADztw@mail.gmail.com>
 <20221020081601.GA48712@h68b04307.sqa.eu95>
 <dd25da2a-a035-4437-967c-b59c09140ebc.hengqi@linux.alibaba.com>
 <PH0PR12MB54814AE695F25009B7B9C038DCD09@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB54814AE695F25009B7B9C038DCD09@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Parav Pandit <parav@nvidia.com>, virtio-dev <virtio-dev@lists.oasis-open.org>, virtio-comment <virtio-comment@lists.oasis-open.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Kangjie Xu <kangjie.xu@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



在 2023/2/1 上午7:08, Parav Pandit 写道:
> Hi Heng Qi,
>
> Sorry for the joining this conversation little late.
> Your email has very useful summary.
>
> Unfortunately, non-text content (HTML content) doesn’t get achieved.
> So, changing the format to text to capture your useful comments.
> If you can change your email client settings to be text mode, it will be easier to converse.

I'm very sorry, but is it convenient for you to check the format of the 
current quote reply?

I will reply after your response tag, please see below.

>
> We have equal interest in having efficient split hdr support and do together with you.
> Please find response "response" tag below at the end of email to avoid top posting.
>
> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-open.org> On Behalf Of hengqi
> Sent: Tuesday, January 31, 2023 4:23 AM
> To: virtio-dev <virtio-dev@lists.oasis-open.org>; virtio-comment <virtio-comment@lists.oasis-open.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>; Jason Wang <jasowang@redhat.com>; Cornelia Huck <cohuck@redhat.com>; Kangjie Xu <kangjie.xu@linux.alibaba.com>; Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Subject: [virtio-comment] 回复：[virtio-dev] [PATCH v8] virtio_net: support for split transport header
>
> Hi, all.
>
> Split header is a technique with important applications, such as Eric (https://lwn.net/Articles/754681/)
> and Jonathan Lemon (https://lore.kernel.org/io-uring/20221007211713.170714-1- mailto:jonathan.lemon@gmail.com/T/#m678770d1fa7040fd76ed35026b93dfcbf25f6196)
> realize the zero-copy technology respectively, they all have one thing in common that the header and
> the payload need to be in separate buffers, and Eric's method requires the payload to be page-aligned.
>
> We implemented zero-copy on the virtio-net driver according to Eric's method. The commands and
> environment are as follows:
> # environment
> VM1<---->vhost-user<->OVS<->vhost-user<---->VM2
> cpu Model name: Intel(R) Xeon(R) CPU E5-2682 v4 @ 2.50GHz
> kernel version 6.0
>
> # commands (linux/tools/testing/selftests/net)
> ./tcp_mmap -s -z -4 -p 1000 &
> ./tcp_mmap -H 10.0.0.2 -z -4 -p 1000
>
> The performance data is as follows (implemented according to the split header v7 version,
> https://lists.oasis-open.org/archives/virtio-dev/202209/msg00004.html):
> # direct copy
> 17.6604 s 10.08 s
> # zero copy
> 1.9 GB/s 3.3 GB/s
>
> We discussed a lot before, the core point is the choice of method A and method C, we seem
> to be unable to reach an agreement on this point, seeing the above summary and previous discussion (https://lists.oasis-open.org/archives/virtio-dev /202210/msg00017.html),
> how can we resolve this conflict and let this important feature continue?
> I really need your help. Cc Jason, Michael, Cornelia, Xuan.
>
> Thanks.
> ------------------------------------------------------------------
> 发件人：Heng Qi <mailto:hengqi@linux.alibaba.com>
> 发送时间：2022年10月20日(星期四) 16:34
> 收件人：Jason Wang <mailto:jasowang@redhat.com>
> 抄　送：Michael S. Tsirkin <mailto:mst@redhat.com>; Xuan Zhuo <mailto:xuanzhuo@linux.alibaba.com>; Virtio-Dev <mailto:virtio-dev@lists.oasis-open.org>; Kangjie Xu <mailto:kangjie.xu@linux.alibaba.com>
> 主　题：Re: [virtio-dev] [PATCH v8] virtio_net: support for split transport header
>
> On Sat, Oct 08, 2022 at 12:37:45PM +0800, Jason Wang wrote:
>>   On Thu, Sep 29, 2022 at 3:04 PM Michael S. Tsirkin <mailto:mst@redhat.com> wrote:
>>   >
>>   > On Thu, Sep 29, 2022 at 09:48:33AM +0800, Jason Wang wrote:
>>   > > On Wed, Sep 28, 2022 at 9:39 PM Michael S. Tsirkin <mailto:mst@redhat.com> wrote:
>>   > > >
>>   > > > On Mon, Sep 26, 2022 at 04:06:17PM +0800, Jason Wang wrote:
>>   > > > > > Jason I think the issue with previous proposals is that they conflict
>>   > > > > > with VIRTIO_F_ANY_LAYOUT. We have repeatedly found that giving the
>>   > > > > > driver flexibility in arranging the packet in memory is benefitial.
>>   > > > >
>>   > > > >
>>   > > > > Yes, but I didn't found how it can conflict the any_layout. Device can just
>>   > > > > to not split the header when the layout doesn't fit for header splitting.
>>   > > > > (And this seems the case even if we're using buffers).
>>   > > >
>>   > > > Well spec says:
>>   > > >
>>   > > >         indicates to both the device and the driver that no
>>   > > >         assumptions were made about framing.
>>   > > >
>>   > > > if device assumes that descriptor boundaries are where
>>   > > > driver wants packet to be stored that is clearly
>>   > > > an assumption.
>>   > >
>>   > > Yes but what I want to say is, the device can choose to not split the
>>   > > packet if the framing doesn't fit. Does it still comply with the above
>>   > > description?
>>   > >
>>   > > Thanks
>>   >
>>   > The point of ANY_LAYOUT is to give drivers maximum flexibility.
>>   > For example, if driver wants to split the header at some specific
>>   > offset this is already possible without extra functionality.
>>   
>>   I'm not sure how this would work without the support from the device.
>>   This probably can only work if:
>>   
>>   1) the driver know what kind of packet it can receive
>>   2) protocol have fixed length of the header
>>   
>>   This is probably not true consider:
>>   
>>   1) TCP and UDP have different header length
>>   2) IPv6 has an variable length of the header
>>   
>>   
>>   >
>>   > Let's keep it that way.
>>   >
>>   > Now, let's formulate what are some of the problems with the current way.
>>   >
>>   >
>>   >
>>   > A- mergeable buffers is even more flexible, since a single packet
>>   >   is built up of multiple buffers. And in theory device can
>>   >   choose arbitrary set of buffers to store a packet.
>>   >   So you could supply a small buffer for headers followed by a bigger
>>   >   one for payload, in theory even without any changes.
>>   >   Problem 1: However since this is not how devices currently operate,
>>   >   a feature bit would be helpful.
>>   
>>   How do we know the bigger buffer is sufficient for the packet? If we
>>   try to allocate 64K (not sufficient for the future even) it breaks the
>>   effort of the mergeable buffer:
>>   
>>   header buffer #1
>>   payload buffer #1
>>   header buffer #2
>>   payload buffer #2
>>   
>>   Is the device expected to
>>   
>>   1) fill payload in header buffer #2, this breaks the effort that we
>>   want to make payload page aligned
>>   2) skip header buffer #2, in this case, the device assumes the framing
>>   when it breaks any layout
>>   
>>   >
>>   >   Problem 2: Also, in the past we found it useful to be able to figure out whether
>>   >   packet fits in a single buffer without looking at the header.
>>   >   For this reason, we have this text:
>>   >
>>   >         If a receive packet is spread over multiple buffers, the device
>>   >         MUST use all buffers but the last (i.e. the first \field{num_buffers} -
>>   >         1 buffers) completely up to the full length of each buffer
>>   >         supplied by the driver.
>>   >
>>   >   if we want to keep this optimization and allow using a separate
>>   >   buffer for headers, then I think we could rely on the feature bit
>>   >   from Problem 1 and just make an exception for the first buffer.
>>   >   Also num_buffers is then always >= 2, maybe state this to avoid
>>   >   confusion.
>>   >
>>   >
>>   >
>>   >
>>   >
>>   > B- without mergeable, there's no flexibility. In particular, there can
>>   > not be uninitialized space between header and data.
>>   
>>   I had two questions
>>   
>>   1) why is this not a problem of mergeable? There's no guarantee that
>>   the header is just the length of what the driver allocates for header
>>   buffer anyhow
>>   
>>   E.g the header length could be smaller than the header buffer, the
>>   device still needs to skip part of the space in the header buffer.
>>   
>>   2) it should be the responsibility of the driver to handle the
>>   uninitialized space, it should do anything that is necessary for
>>   security, more below
>>   
>
> We've talked a bit more about split header so far, but there still seem to
> be some issues, so let's recap.
>
> 一、 Method Discussion Review
>
> In order to adapt to the Eric's tcp receive interface to achieve zero copy,
> header and payload are required to be stored separately, and the payload is
> stored in a paged alignment way. Therefore, we have discussed several options
> for split header as follows:
>
> 1: method A ( depend on the descriptor chain )
> |                         receive buffer                            |
> |              0th descriptor                      | 1th descriptor |
> | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|      payload   |
> Method A uses a buffer plus a separate page when allocating the receive
> buffer. In this way, we can ensure that all payloads can be put
> independently in a page, which is very beneficial for the zerocopy
> implemented by the upper layer.
>
> The advantage of method A is that the implementation is clearer, it can support normal
> header spit and the rollback conditions. It can also easily support xdp. The downside is
> that devices operating directly on the descriptor chain may cause the layering violation,
> and also affect the performance.
>
> 2. method B ( depend on mergeable buffer)
> |                   receive buffer (page)                                 | receive buffer (page) |
> | <-- offset(hold) --> | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|         payload       |
> ^
> |
> pointer to device
>
> Method B is based on your previous suggestion, it is implemented based
> on mergeable buffer, filling a separate page each time.
>
> If the split header is negotiated and the packet can be successfully split by the device,
> the device needs to find at least two buffers, namely two pages, one for the virtio-net header
> and transport header, and the other for the payload.
>
> The advantage of method B is that it relies on mergeable buffer instead of the descriptor chain.
> It overcomes the shortcomings of method A and can achieve the purpose of the device focusing
> on the buffer instead of the descriptor. Its disadvantage is that it causes memory waste.
>
> 3. method C ( depend on mergeable buffer )
> | small buffer | data buffer (page) | small buffer | data buffer (page) | small buffer | data buffer (page) |
>
> Method B fills a separate page each time, while method C needs to fill the small buffer and
> page buffer separately. Method C puts the header in small buffer and the payload in a page.
>
> The advantage of method C is that some buffers are filled for header and data respectively,
> which reduces the memory waste of method B. However, this method is difficult to weigh
> the number of filled header buffers and data buffers, and an unreasonable proportion will
> affect performance. For example, in a scenario with a large number of large packets,
> too many header buffers will affect performance, or in a scenario with a large number of small
> packets, too many data buffers can also affect performance. At the same time, if some protocols
> with a large number of packets do not support split header, the existence of the header buffers
> will also affect performance.
>
> 二、Points of agreement and disagreement
>
> 1. What we have now agreed upon is that:
> None of the three methods break VIRTIO_F_ANY_LAYOUT, they make virtio net header and
> packet header stored together.
>
> We have now agreed to relax the following in the split header scenario,
>   "indicates to both the device and the driver that no assumptions were made about framing."
> because when a bigger packet comes, and a data buffer is not enough to store this packet,
> the device either chooses to skip the next header buffer to break what the spec says above,
> or chooses not to skip the header buffer and cannot make payload page aligned.
> Therefore, all three methods need to relax the above requirements.
>
> 2. What we haven't now agreed upon is that:
> The point where we don't agree now is that we don't have a more precise discussion of which
> approach to take, but we're still bouncing between approaches.
> At present, all three approaches seem to achieve our requirements, but each has advantages
> and disadvantages. Should we focus on the most important points, such as performance to choose.
> It seems a little difficult to cover everything?
>
> 三、Two forms of implementing receive zerocopy
>
> the Eric's tcp receive interface requires the header and payload are stored in separate buffers, and the payload is
> stored in a paged alignment way.
>
> Now, io_uring also proposes a new receive zerocopy method, which requires header and payload
> to be stored in separate buffers, but does not require payload page aligned.
> https://lore.kernel.org/io-uring/20221007211713.170714-1-jonathan.lemon@gmail.com/T/#m678770d1fa7040fd76ed35026b93dfcbf25f6196
>
> Response....
>
> Page alignment requirements should not come from the virtio spec.
> There are a variety of cases which may use non page aligned data buffers.
> a. A kernel only consumer can use it who doesn't have mmap requirement.
> b. A VQ accessible directly in user space may also use it without page alignment.
> c. A system with 64k page size, page aligned memory has a fair amount of wastage.
> d. iouring example you pointed, also has non page aligned use.
>
> So let the driver deal with alignment restriction, outside of the virtio spec.
>
> In header data split cases, data buffers utilization is more important than the tiny header buffers utilization.
> How about if the headers do not interfere with the data buffers?
>
> In other words, say a given RQ has optionally linked to a circular queue of header buffers.
> All header buffers are of the same size, supplied one time.
> This header size and circular q address is configured one time at RQ creation time.
>
> With this the device doesn't need to process header buffer size every single incoming packet.
> Data buffers can continue as chains or merged mode can be supported.
> When the received packet’s header cannot fit, it continues as-is in the data buffer.
> Virtio net hdr as suggest indicates usage of hdr buffer offset/index.

This is a good direction, thanks a lot for your comments, the new split 
header method might look like this:
When allocating the receive queue, allocate a circular queue storing the 
header buffers at the driver layer,
which is shared with the device, and set the length of the header 
buffer. The length of the circular queue
is the same as the length of the descriptor table.

1. When a data packet is successfully split, all virtio-net-hdr + 
transport headers are stored in the header buffer,
and VIRTIO_NET_HDR_F_SPLIT_HEADER is set in the flag of virtio-net-hdr; 
If the header buffer is not enough
to store virtio-net-hdr + transport header, then roll back, that is, not 
split the packet;

2. When a packet is not split by the device for some reason, 
virtio-net-hdr is placed in the header buffer, and the
transport header and payload are placed in the buffer. At this time, xdp 
is not supported, because xdp requires
the transport header to be placed in the first buffer, the header 
buffer. Then why not start storing packets from
the header buffer? If this is the case, imagine a situation: If all 
small packets are put into the header buffers,
and virtio net driver receives packets according to the descriptor table 
and used_ring, but the data buffers are
empty at this time, then can't seem to continue? It seems that the 
operation of circular queue has become a
producer-consumer problem again.

3. The meaning of hdr_len in virtio-net-hdr:
      i. When splitting successfully: hdr_len represents the effective 
length of the header in the header buffer.
      ii. On unsuccessful split: hdr_len is 0.

What do you think of this plan? Or is there a better one?

Thanks.

>
> This method has few benefits on perf and buffer efficiency as below.
> 1. Data buffers can be directly mapped at best utilization
> 2. Device doesn't need to match up per packet header sizes and descriptor sizes, efficient for device to implement
> 3. No need to keep reposting the header buffers, only its tail index to be updated.
> Directly gives 50% cycle reduction on buffer traversing on driver side on rx path.
> 4. Ability to share this header buffer queue among multiple RQs if needed.
> 5. In the future there may be an extension to place tiny whole packets that can fit in the header buffer also to contain the rest of the data.
> 6. Device can always fall back to place packet header in data buffer when header buffer is not available or smaller than newer protocol
> 7. Because the header buffer comes virtually contiguous memory and not intermixed with data buffers, there isn't small per header allocations
> 8. Also works in both chained and merged mode
> 9. memory utilization for an RQ of depth 256, with 4K page size for data buffers = 1M, and hdr buffer per packet = 256 * 128bytes = only 3% of the data buffer.
> So, in worst case when no packet uses the header buffers wastage is only 3%.
> When high number of packets larger than 4K uses the header buffer, say 8K packets, header buffer utilization is at 50%. So, wastage is only 1.5%.
> At 1500 mtu merged buffer data buffer size, it is also < 10% of hdr buffer memory.
> All 3 cases are very manageable range of buffer utilization.
>
> Crafting and modifying the feature bits from your v7 version and virtio net header is not difficult to get there if we like this approach.

