Return-Path: virtio-dev-return-5212-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 87B85985E31
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Dec 2018 03:06:48 +0000 (UTC)
Message-ID: <5C259485.2030809@intel.com>
Date: Fri, 28 Dec 2018 11:12:05 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1535333539-32420-1-git-send-email-wei.w.wang@intel.com> <1535333539-32420-2-git-send-email-wei.w.wang@intel.com> <49d706f7-a0ee-e571-7d02-bcadac5ce742@de.ibm.com>
In-Reply-To: <49d706f7-a0ee-e571-7d02-bcadac5ce742@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v37 1/3] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: Christian Borntraeger <borntraeger@de.ibm.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, dgilbert@redhat.com
Cc: torvalds@linux-foundation.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, peterx@redhat.com, quintela@redhat.com, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/27/2018 08:03 PM, Christian Borntraeger wrote:
> On 27.08.2018 03:32, Wei Wang wrote:
>>   static int init_vqs(struct virtio_balloon *vb)
>>   {
>> -	struct virtqueue *vqs[3];
>> -	vq_callback_t *callbacks[] = { balloon_ack, balloon_ack, stats_request };
>> -	static const char * const names[] = { "inflate", "deflate", "stats" };
>> -	int err, nvqs;
>> +	struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
>> +	vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
>> +	const char *names[VIRTIO_BALLOON_VQ_MAX];
>> +	int err;
>>
>>   	/*
>> -	 * We expect two virtqueues: inflate and deflate, and
>> -	 * optionally stat.
>> +	 * Inflateq and deflateq are used unconditionally. The names[]
>> +	 * will be NULL if the related feature is not enabled, which will
>> +	 * cause no allocation for the corresponding virtqueue in find_vqs.
>>   	 */
> This might be true for virtio-pci, but it is not for virtio-ccw.

Hi Christian,


Please try the fix patches: https://lkml.org/lkml/2018/12/27/336

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

