Return-Path: virtio-dev-return-5453-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C2D0F985B8C
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Feb 2019 06:21:13 +0000 (UTC)
References: <20190211080432-mutt-send-email-mst@kernel.org>
 <97e870fd-dbd5-2fed-b62c-67d24407e5cf@solarflare.com>
 <20190211233612-mutt-send-email-mst@kernel.org>
 <3ce6415d-e36d-8dcb-dd99-5203a63e5883@redhat.com>
 <20190212082915-mutt-send-email-mst@kernel.org>
 <9bed9f5d-ab7d-287e-3497-0c4b61e3b8c0@redhat.com>
 <20190213100640-mutt-send-email-mst@kernel.org>
 <dda354db-2b63-8f73-8017-a7ded99a822e@redhat.com>
 <20190213223515-mutt-send-email-mst@kernel.org>
 <8106d176-5560-7a1b-1e4d-b8f0033ae461@redhat.com>
 <20190214231127-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <93a9569e-03d3-b1ad-e0d7-96287870b6b5@redhat.com>
Date: Tue, 19 Feb 2019 14:21:01 +0800
MIME-Version: 1.0
In-Reply-To: <20190214231127-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and
 hardware offload
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Riddoch <driddoch@solarflare.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2019/2/15 下午12:23, Michael S. Tsirkin wrote:
> On Fri, Feb 15, 2019 at 11:59:55AM +0800, Jason Wang wrote:
>> On 2019/2/14 上午11:41, Michael S. Tsirkin wrote:
>>>> I think it's as simple as increase the avail idx by X? Since descriptor were
>>>> used in order, device can just read the next X-1 descriptors in this case.
>>>>
>>>> Thanks
>>> Right so a spec change would be needed, it's not transparent to guest.
>>
>> With the change, IN_ORDER + split_ring becomes something like submission
>> queue (descriptor ring) + completion queue (used ring). And used ring access
>> could be eliminated sometime, e.g for net for TX, we don't care about used
>> len.
> Oh yes but fundamentally this becomes very close to packed ring.


Looks not, it's a two rings vs one ring.


> So I'm
> not sure yet another option is justified by a small gain in PPS,


10% is done with less than 10 lines of code, I suspect maybe dpdk can 
see more.


> especially considering that it depends on in order and so doesn't
> support zero copy.


It looks to me in order is not the blocker, even if we allow out of 
order, we may still suffer from HOL.


>
>> What's more interesting is, this avail idx optimization is not required for
>> out of order completion which means it could be used for e.g block or SCSI
>> device.
> I don't get the last sentence. This only works for in order right?


Yes, you are right.

Thanks.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

