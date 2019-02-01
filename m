Return-Path: virtio-dev-return-5362-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7AC82985493
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Feb 2019 14:24:00 +0000 (UTC)
From: David Riddoch <driddoch@solarflare.com>
Message-ID: <2f0de388-de01-1e51-b6b6-339389a2268a@solarflare.com>
Date: Fri, 1 Feb 2019 14:23:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and hardware offload
To: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

All,

I'd like to propose a small extension to the packed virtqueue mode.  My 
proposal is to add an offset/wrap field, written by the driver, 
indicating how many available descriptors have been added to the ring.

The reason for wanting this is to improve performance of hardware 
devices.  Because of high read latency over a PCIe bus, it is important 
for hardware devices to read multiple ring entries in parallel.  It is 
desirable to know how many descriptors are available prior to issuing 
these reads, else you risk fetching descriptors that are not yet 
available.  As well as wasting bus bandwidth this adds complexity.

I'd previously hoped that VIRTIO_F_NOTIFICATION_DATA would solve this 
problem, but we still have a problem.  If you rely on doorbells to tell 
you how many descriptors are available, then you have to keep doorbells 
enabled at all times.  This can result in a very high rate of doorbells 
with some drivers, which can become a severe bottleneck (because x86 
CPUs can't emit MMIOs at very high rates).

The proposed offset/wrap field allows devices to disable doorbells when 
appropriate, and determine the latest fill level via a PCIe read.

I suggest the best place to put this would be in the driver area, 
immediately after the event suppression structure.

Presumably we would like this to be an optional feature, as 
implementations of packed mode already exist in the wild.  How about 
VIRTIO_F_RING_PACKED_AVAIL_IDX?

If I prepare a patch to the spec is there still time to get this into v1.1?

Best,
David

-- 
David Riddoch  <driddoch@solarflare.com> -- Chief Architect, Solarflare


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

