Return-Path: virtio-dev-return-5431-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7C5B8985E0C
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Feb 2019 09:49:38 +0000 (UTC)
References: <2f0de388-de01-1e51-b6b6-339389a2268a@solarflare.com>
 <20190211021124-mutt-send-email-mst@kernel.org>
 <d5d3b7f6-95a3-0d1c-4890-6e72f2e4bfc5@solarflare.com>
 <20190211080432-mutt-send-email-mst@kernel.org>
 <97e870fd-dbd5-2fed-b62c-67d24407e5cf@solarflare.com>
 <20190211233612-mutt-send-email-mst@kernel.org>
 <02809024-c99c-caf5-5ec4-98ee96ca6cd5@solarflare.com>
 <20190212085415-mutt-send-email-mst@kernel.org>
 <15b8c0b7-643d-d9c2-f05c-0f5d8c8169c3@solarflare.com>
 <20190212122619-mutt-send-email-mst@kernel.org>
From: David Riddoch <driddoch@solarflare.com>
Message-ID: <7220347a-46c3-92ce-4328-fe29ea27056e@solarflare.com>
Date: Wed, 13 Feb 2019 09:49:29 +0000
MIME-Version: 1.0
In-Reply-To: <20190212122619-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and
 hardware offload
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


>>> Maybe we should use a flag in event suppression structure.
>>> This way device can switch between being notification driven
>>> and being driven by index reads.
>> On first thought it seems hard to avoid races: On receiving a doorbell the
>> device wishes to transition from doorbells to polling, so driver->avail_idx
>> currently has an old value; device writes device->flags; a little later
>> device reads driver->avail_idx.  It might have a new value written by the
>> driver, or an old value...the device can't tell.  Needs more thought.
> I would say device writes flags and then reads the descriptor
> ring. This is exactly the same sequence that needs to happen
> when enabling driver notifications.

Yes fair enough.  I was trying to allow a device that never has to read 
descriptors speculatively, but such a device can always have the 
avail_idx update flag enabled permanently.


-- 
David Riddoch  <driddoch@solarflare.com> -- Chief Architect, Solarflare


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

