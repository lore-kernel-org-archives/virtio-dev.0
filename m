Return-Path: <jasowang@redhat.com>
Message-ID: <e23b22d3-e53a-f250-8609-0760bf32afb4@redhat.com>
Date: Mon, 28 Nov 2022 11:46:03 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2] virtio_net: support inner header hash for
 GRE-encapsulated packets
References: <20221122090755.70840-1-hengqi@linux.alibaba.com>
 <CACGkMEsvgqPA4-WxmiYEN=A9ob3a0itNghn3Y62pDMsSyGEEiw@mail.gmail.com>
 <20221125064742-mutt-send-email-mst@kernel.org>
 <1669602685.636302-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1669602685.636302-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2022/11/28 10:31, Xuan Zhuo 写道:
> On Fri, 25 Nov 2022 06:49:42 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> On Fri, Nov 25, 2022 at 12:16:05PM +0800, Jason Wang wrote:
>>> On Tue, Nov 22, 2022 at 5:08 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>> When VIRTIO_NET_F_RSS is negotiated and the tunnel is used to
>>>> encapsulate the packets, the hash calculated using the outer header
>>>> of the receive packets is always fixed for the same flow packets,
>>>> i.e. they will be steered to the same receive queue.
>>>>
>>>> We add a VIRTIO_NET_HASH_TYPE_GRE_INNER bitmask in \field{hash_types},
>>>> which instructs the device to calculate the hash using the inner
>>>> headers of GRE-encapsulated packets, and a VIRTIO_NET_HASH_REPORT_GRE
>>>> value in \field{hash_tunnel} to report packet type when calculating
>>>> hash over the inner header.
>>> So I think we need a new feature bit for this to keep migration compatibility.
>> I am not sure I agree.  hash types need to be specified or migrated.
> I think migration is necessary to consider. If VM migrates, it may cause VM's
> behavior to be inconsistent.


Yes, this is a behavior that could be detected by the driver: consider 
GRE is supported on src but not dst, we can't live migrate in this case 
without a feature bit.


>
>> Also having feature bits is a lot of work and duplication,
>> and inconsistency - we do not have bits for existing hash types.
> The existing Hash Types are brought by default when negotiating RSS. I don't
> think it is necessary to negotiate for them separately.
>
> As far as Virtio-Net's Feature Bits are concerned, I am indeed worried, because
> we think Virtio-Net can also add a lot of new features. In the end, there will
> be no feature bit available.


That's the price we need to pay for supporting live migration. Actually, 
transport layer has sufficient bits for us to use, so it's not a big deal.

One thing that might help is to try to reduce the bit usage, e.g 
introduce a _F_TUNNEL_HASH bit for vxlan, ipip etc as well as GRE.

Thanks

