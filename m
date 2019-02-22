Return-Path: virtio-dev-return-5510-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 176639860E5
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Feb 2019 14:13:21 +0000 (UTC)
References: <bd73e7d3-b9ed-24bb-a22d-cd81f0239acd@kernkonzept.com>
 <05b89b63-6842-ceab-5a15-d5a392e60f50@redhat.com>
 <a7cd42ed-8320-46a7-4a15-c8115cfa0529@kernkonzept.com>
 <6a9de5da-8858-a534-7686-4c9c5088138c@redhat.com>
From: Jakub Jermar <jakub.jermar@kernkonzept.com>
Message-ID: <d984aa53-c2af-d801-9c3a-f372cd74a8e1@kernkonzept.com>
Date: Fri, 22 Feb 2019 15:13:18 +0100
MIME-Version: 1.0
In-Reply-To: <6a9de5da-8858-a534-7686-4c9c5088138c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] virtio-blk: the nature of discard_sector_alignment
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 2/22/19 2:59 PM, Paolo Bonzini wrote:
> On 22/02/19 10:41, Jakub Jermar wrote:
>>>> Does discard_sector_alignment represent a strict requirement that must
>>>> be always honored or is it rather a hint to the driver?
>>>
>>> It's a hint that misaligned requests might not result in any discard
>>> happening at all.
>>
>> In that case, would the failure to discard anything be silent? In other
>> words, would the request complete with VIRTIO_BLK_S_OK or rather any of
>> VIRTIO_BLK_S_IOERR or VIRTIO_BLK_S_UNSUPP?
> 
> Yes, it would be silent.  The same is true for NVMe, SCSI etc.

Thanks, this helped a lot.

Jakub

-- 
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael
Hohmuth

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

