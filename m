Return-Path: virtio-dev-return-7122-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EC339986079
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Apr 2020 10:31:22 +0000 (UTC)
References: <20200417021335-mutt-send-email-mst@kernel.org>
 <08d2c4e2-8c0f-7d3c-89f1-0e6c6a2756c8@redhat.com>
 <20200417044641-mutt-send-email-mst@kernel.org>
 <0f867029-aef4-72b9-356f-ec25c265db1b@redhat.com>
 <20200417051223-mutt-send-email-mst@kernel.org>
 <3447361c-4d07-1785-c59b-8c98ddaebd92@redhat.com>
 <20200417055217-mutt-send-email-mst@kernel.org>
 <1823d9be-d175-6cb5-0c7d-8a68d959a0d5@redhat.com>
 <20200417061815-mutt-send-email-mst@kernel.org>
 <34f46dfc-be16-d057-0760-3cb7c1d1288a@redhat.com>
 <20200417062804-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <be245104-c10b-8a91-24d9-d678126a9304@redhat.com>
Date: Fri, 17 Apr 2020 12:31:14 +0200
MIME-Version: 1.0
In-Reply-To: <20200417062804-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH] virtio-balloon: Disable free page
 hinting/reporting if page poison is disabled
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 17.04.20 12:29, Michael S. Tsirkin wrote:
> On Fri, Apr 17, 2020 at 12:26:24PM +0200, David Hildenbrand wrote:
>> On 17.04.20 12:19, Michael S. Tsirkin wrote:
>>> On Fri, Apr 17, 2020 at 12:09:38PM +0200, David Hildenbrand wrote:
>>>>  > What do you call "hinting ends" though? The fact we put
>>>>> a page in the VQ is not a guarantee that it's been consumed
>>>>> by the hypervisor.
>>>>>
>>>>
>>>> I'd say hinting ends once the hypervisor sets FREE_PAGE_REPORT_S_DONE.
>>>
>>> Can't find that one anywhere. what did I miss?
>>
>> Sorry, the QEMU implementation is confusing. FREE_PAGE_REPORT_S_DONE is
>> translated to VIRTIO_BALLOON_CMD_ID_DONE
> 
> Well VIRTIO_BALLOON_CMD_ID_DONE just means "don't give me any
> more hints, I finished migration".
> Guest will stop hinting even without that once it scans all
> free memory.

Yeah, that's the end of the whole process where you can be sure the host
processed all requests definetly.

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

