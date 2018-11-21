Return-Path: virtio-dev-return-5005-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E5167985C92
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Nov 2018 13:46:15 +0000 (UTC)
References: <20181121100330.24846-1-tiwei.bie@intel.com>
 <20181121071308-mutt-send-email-mst@kernel.org>
 <20181121124233.GA32189@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <84e80a22-75cc-5b9d-7f6e-980e41850e00@redhat.com>
Date: Wed, 21 Nov 2018 21:46:06 +0800
MIME-Version: 1.0
In-Reply-To: <20181121124233.GA32189@debian>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v3 00/13] virtio: support packed ring
To: Tiwei Bie <tiwei.bie@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2018/11/21 下午8:42, Tiwei Bie wrote:
> On Wed, Nov 21, 2018 at 07:20:27AM -0500, Michael S. Tsirkin wrote:
>> On Wed, Nov 21, 2018 at 06:03:17PM +0800, Tiwei Bie wrote:
>>> Hi,
>>>
>>> This patch set implements packed ring support in virtio driver.
>>>
>>> A performance test between pktgen (pktgen_sample03_burst_single_flow.sh)
>>> and DPDK vhost (testpmd/rxonly/vhost-PMD) has been done, I saw
>>> ~30% performance gain in packed ring in this case.
>> Thanks a lot, this is very exciting!
>> Dave, given the holiday, attempts to wrap up the 1.1 spec and the
>> patchset size I would very much appreciate a bit more time for
>> review. Say until Nov 28?
>>
>>> To make this patch set work with below patch set for vhost,
>>> some hacks are needed to set the _F_NEXT flag in indirect
>>> descriptors (this should be fixed in vhost):
>>>
>>> https://lkml.org/lkml/2018/7/3/33
>> Could you pls clarify - do you mean it doesn't yet work with vhost
>> because of a vhost bug, and to test it with the linked patches
>> you had to hack in _F_NEXT? Because I do not see _F_NEXT
>> in indirect descriptors in this patch (which is fine).
>> Or did I miss it?
> You didn't miss anything. :)
>
> I think it's a small bug in vhost, which Jason may fix very
> quickly, so I didn't post it. Below is the hack I used:


Good catch. I didn't notice the subtle difference since split ring 
requires for it.

Let me fix it in next version.

Thanks.


>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cd7e755484e3..42faea7d8cf8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -980,6 +980,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>   	unsigned int i, n, err_idx;
>   	u16 head, id;
>   	dma_addr_t addr;
> +	int c = 0;
>   
>   	head = vq->packed.next_avail_idx;
>   	desc = alloc_indirect_packed(total_sg, gfp);
> @@ -1001,8 +1002,9 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>   			if (vring_mapping_error(vq, addr))
>   				goto unmap_release;
>   
> -			desc[i].flags = cpu_to_le16(n < out_sgs ?
> -						0 : VRING_DESC_F_WRITE);
> +			desc[i].flags = cpu_to_le16((n < out_sgs ?
> +						0 : VRING_DESC_F_WRITE) |
> +				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT));
>   			desc[i].addr = cpu_to_le64(addr);
>   			desc[i].len = cpu_to_le32(sg->length);
>   			i++;

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

