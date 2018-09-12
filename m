Return-Path: virtio-dev-return-4845-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3E8E985D26
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Sep 2018 16:41:13 +0000 (UTC)
From: David Riddoch <driddoch@solarflare.com>
Message-ID: <0f4e7431-3c87-f783-579a-7e9fe6bc20d2@solarflare.com>
Date: Wed, 12 Sep 2018 17:41:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Device-to-driver notification management for hardware implementations
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

All,

The VIRTIO_F_NOTIFICATION_DATA feature helps hardware implementations by 
telling them directly how many descriptors are available in the ring, 
saving speculative reads.  There is a related issue with interrupts: As 
things stand, after writing 'used' descriptors into the ring (packed or 
split) the device has to read the event idx to determine whether a 
device-to-driver notification (interrupt) is needed.

It would be very helpful to a hardware implementation if the event idx 
could be written directly to the device.  Has anyone proposed an 
extension to address this already?  (I have some thoughts on how to do 
this if we don't have a proposal yet).

Best,
David



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

