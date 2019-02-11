Return-Path: virtio-dev-return-5384-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 47795985BE6
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Feb 2019 10:16:31 +0000 (UTC)
From: David Riddoch <driddoch@solarflare.com>
References: <6795ebb5-4f21-1274-fa35-b8354bc65049@solarflare.com>
 <e28d3203-4566-ae6e-61c7-24a9a3e6ca3b@solarflare.com>
 <BYAPR02MB471166783BC223C9AB8A12BBBB990@BYAPR02MB4711.namprd02.prod.outlook.com>
 <20190211020351-mutt-send-email-mst@kernel.org>
Message-ID: <8d5a6fd6-e5b3-b203-ffef-6cde348f994a@solarflare.com>
Date: Mon, 11 Feb 2019 10:16:23 +0000
MIME-Version: 1.0
In-Reply-To: <20190211020351-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: [virtio-dev] Re: [virtio] RE: Re: [virtio-dev] Device-to-driver notification
 management for hardware implementations
To: "Michael S. Tsirkin" <mst@redhat.com>, Chandra Thyamagondlu <CTHYAMAG@xilinx.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Kumar Sanghvi <kumars@xilinx.com>
List-ID: <virtio-dev.lists.oasis-open.org>

(Apologies if you got this a second time: The first copy went to the 
wrong list).

>> I think your proposal of write to p_int_en_doorbell will work for us. 
>> The write
>> event to this new address in BAR itself implicitly tell the device that
>> interrupt is enabled and also it conveys the last used entry that it 
>> processed.
>> Then device can provide nice interrupt moderation by making sure at 
>> least one
>> new used entry was written and some time has elapsed from previous 
>> interrupt to
>> driver.
>>
>> It would also be helpful if you can also outline the new structure 
>> and your
>> proposal for offset in the BAR.
>>
>>
>> Chandra
> So this boils down to adding ability to notify devices about enabling
> interrupts. Question would be, this slows down the driver. Is this
> still worth doing? Right now we are trying to offload as
> much as we can to the device.
I don't think it slows down the driver significantly, because the 
interrupt rate is usually moderated so that it is not too high. (So 
these notify MMIOs should not be issued at a high enough rate to get 
close to causing a bottleneck).

It is a win in terms of PCIe overheads, as the device never needs to 
read the suppression structure.  But again the win is limited because 
interrupt rate will usually be limited by moderation.

It can be a win for latency.  In the case of a net rx virt-queue the 
device can issue an interrupt without first reading the suppression 
structure.

However, despite having made the proposal, I no longer consider this 
high priority: Because it is an optional feature it would not reduce 
complexity since a device has to be able to operate without it.  I'm not 
sure the benefits are worth the complexity added.

David

-- 
David Riddoch  <driddoch@solarflare.com> -- Chief Architect, Solarflare


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

