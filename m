Return-Path: virtio-dev-return-2383-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 688B85818C68
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Jul 2017 06:26:32 -0700 (PDT)
Message-ID: <5966241C.9060503@intel.com>
Date: Wed, 12 Jul 2017 21:29:00 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com> <1499863221-16206-6-git-send-email-wei.w.wang@intel.com> <20170712160129-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170712160129-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v12 5/8] virtio-balloon: VIRTIO_BALLOON_F_SG
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 07/12/2017 09:06 PM, Michael S. Tsirkin wrote:
> On Wed, Jul 12, 2017 at 08:40:18PM +0800, Wei Wang wrote:
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index 28b0e96..9f27101 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -57,8 +57,28 @@ int virtqueue_add_sgs(struct virtqueue *vq,
>>   		      void *data,
>>   		      gfp_t gfp);
>>   
>> +/* A desc with this init id is treated as an invalid desc */
>> +#define VIRTQUEUE_DESC_ID_INIT UINT_MAX
>> +int virtqueue_add_chain_desc(struct virtqueue *_vq,
>> +			     uint64_t addr,
>> +			     uint32_t len,
>> +			     unsigned int *head_id,
>> +			     unsigned int *prev_id,
>> +			     bool in);
>> +
>> +int virtqueue_add_chain(struct virtqueue *_vq,
>> +			unsigned int head,
>> +			bool indirect,
>> +			struct vring_desc *indirect_desc,
>> +			void *data,
>> +			void *ctx);
>> +
>>   bool virtqueue_kick(struct virtqueue *vq);
>>   
>> +bool virtqueue_kick_sync(struct virtqueue *vq);
>> +
>> +bool virtqueue_kick_async(struct virtqueue *vq, wait_queue_head_t wq);
>> +
>>   bool virtqueue_kick_prepare(struct virtqueue *vq);
>>   
>>   bool virtqueue_notify(struct virtqueue *vq);
> I don't much care for this API. It does exactly what balloon needs,
> but at cost of e.g. transparently busy-waiting. Unlikely to be
> a good fit for anything else.

If you were referring to this API - virtqueue_add_chain_desc():

Busy waiting only happens when the vq is full (i.e. no desc left). If
necessary, I think we can add an input parameter like
"bool busywaiting", then the caller can decide to simply get a -ENOSPC
or busy wait to add when no desc is available.

>
> If you don't like my original _first/_next/_last, you will
> need to come up with something else.

I thought the above virtqueue_add_chain_des() performs the same
functionality as _first/next/last, which are used to grab descs from the
vq and chain them together. If not, could you please elaborate the
usage of the original proposal?

Best,
Wei




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

