Return-Path: virtio-dev-return-4947-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 29FA2985DB2
	for <virtio-dev@lists.oasis-open.org>; Fri,  9 Nov 2018 02:31:06 +0000 (UTC)
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180711022711.7090-4-tiwei.bie@intel.com>
 <20181107123933-mutt-send-email-mst@kernel.org>
 <20181108013759.GA20591@debian>
 <2d46a41e-bc00-276a-e19a-105c9dffc75a@redhat.com>
 <20181108115148.GA15701@debian>
 <20181108103155-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <67bd6a88-00f2-ed13-ad13-bdfe92ceeffc@redhat.com>
Date: Fri, 9 Nov 2018 10:30:50 +0800
MIME-Version: 1.0
In-Reply-To: <20181108103155-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v2 3/5] virtio_ring: add packed ring support
To: "Michael S. Tsirkin" <mst@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, wexu@redhat.com, jfreimann@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2018/11/8 下午11:56, Michael S. Tsirkin wrote:
> On Thu, Nov 08, 2018 at 07:51:48PM +0800, Tiwei Bie wrote:
>> On Thu, Nov 08, 2018 at 04:18:25PM +0800, Jason Wang wrote:
>>> On 2018/11/8 上午9:38, Tiwei Bie wrote:
>>>>>> +
>>>>>> +	if (vq->vq.num_free < descs_used) {
>>>>>> +		pr_debug("Can't add buf len %i - avail = %i\n",
>>>>>> +			 descs_used, vq->vq.num_free);
>>>>>> +		/* FIXME: for historical reasons, we force a notify here if
>>>>>> +		 * there are outgoing parts to the buffer.  Presumably the
>>>>>> +		 * host should service the ring ASAP. */
>>>>> I don't think we have a reason to do this for packed ring.
>>>>> No historical baggage there, right?
>>>> Based on the original commit log, it seems that the notify here
>>>> is just an "optimization". But I don't quite understand what does
>>>> the "the heuristics which KVM uses" refer to. If it's safe to drop
>>>> this in packed ring, I'd like to do it.
>>>
>>> According to the commit log, it seems like a workaround of lguest networking
>>> backend.
>> Do you know why removing this notify in Tx will break "the
>> heuristics which KVM uses"? Or what does "the heuristics
>> which KVM uses" refer to?
> Yes. QEMU has a mode where it disables notifications and processes TX
> ring periodically from a timer.  It's off by default but used to be on
> by default a long time ago. If ring becomes full this causes traffic
> stalls.


Do you mean tx-timer? If yes, we can still enable it for packed ring and 
the timer will finally fired and we can go.


> As a work-around Rusty put in this hack to kick on ring full
> even with notifications disabled.


 From the commit log it looks more like a performance workaround instead 
of a bug fix.


> It's easy enough to make sure QEMU
> does not combine devices with packed ring support with the timer hack.
> And I am guessing it's safe enough to also block that option completely
> e.g. when virtio 1.0 is enabled.


I agree.

Thanks


>>> I agree to drop it, we should not have such burden.
>>>
>>> But we should notice that, with this removed, the compare between packed vs
>>> split is kind of unfair. Consider the removal of lguest support recently,
>>> maybe we can drop this for split ring as well?
>>>
>>> Thanks
>>>
>>>
>>>> commit 44653eae1407f79dff6f52fcf594ae84cb165ec4
>>>> Author: Rusty Russell<rusty@rustcorp.com.au>
>>>> Date:   Fri Jul 25 12:06:04 2008 -0500
>>>>
>>>>       virtio: don't always force a notification when ring is full
>>>>       We force notification when the ring is full, even if the host has
>>>>       indicated it doesn't want to know.  This seemed like a good idea at
>>>>       the time: if we fill the transmit ring, we should tell the host
>>>>       immediately.
>>>>       Unfortunately this logic also applies to the receiving ring, which is
>>>>       refilled constantly.  We should introduce real notification thesholds
>>>>       to replace this logic.  Meanwhile, removing the logic altogether breaks
>>>>       the heuristics which KVM uses, so we use a hack: only notify if there are
>>>>       outgoing parts of the new buffer.
>>>>       Here are the number of exits with lguest's crappy network implementation:
>>>>       Before:
>>>>               network xmit 7859051 recv 236420
>>>>       After:
>>>>               network xmit 7858610 recv 118136
>>>>       Signed-off-by: Rusty Russell<rusty@rustcorp.com.au>
>>>>
>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>>> index 72bf8bc09014..21d9a62767af 100644
>>>> --- a/drivers/virtio/virtio_ring.c
>>>> +++ b/drivers/virtio/virtio_ring.c
>>>> @@ -87,8 +87,11 @@ static int vring_add_buf(struct virtqueue *_vq,
>>>>    	if (vq->num_free < out + in) {
>>>>    		pr_debug("Can't add buf len %i - avail = %i\n",
>>>>    			 out + in, vq->num_free);
>>>> -		/* We notify*even if*  VRING_USED_F_NO_NOTIFY is set here. */
>>>> -		vq->notify(&vq->vq);
>>>> +		/* FIXME: for historical reasons, we force a notify here if
>>>> +		 * there are outgoing parts to the buffer.  Presumably the
>>>> +		 * host should service the ring ASAP. */
>>>> +		if (out)
>>>> +			vq->notify(&vq->vq);
>>>>    		END_USE(vq);
>>>>    		return -ENOSPC;
>>>>    	}
>>>>
>>>>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

