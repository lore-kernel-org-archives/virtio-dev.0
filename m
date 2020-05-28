Return-Path: virtio-dev-return-7421-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 45C8D986065
	for <virtio-dev@lists.oasis-open.org>; Thu, 28 May 2020 13:06:48 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0592979c-c8ae-fd28-2ddf-e64b135a7292@redhat.com>
Date: Thu, 28 May 2020 21:06:36 +0800
MIME-Version: 1.0
Content-Language: en-US
Subject: [virtio-dev] queue_enable vs QueueReady
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi:

I found ambiguity in the virtio specification:

In PCI part, it describes the queue_enable as:

The driver uses this to selectively prevent the device from executing 
requests from this virtqueue. 1 - enabled; 0 - disabled.

In MMIO part, it describes the QueueReady as:

Writing one (0x1) to this register notifies the device that it can 
execute requests from this virtual queue. Reading from this register 
returns the last value written to it. Both read and write accesses apply 
to the queue selected by writing to QueueSel.

If I understand this correctly, they have the same meaning, but the 
driver requirements section looks conflict:

PCI said: The driver MUST NOT write a 0 to queue_enable.

MMIO said:

To stop using the queue the driver MUST write zero (0x0) to this 
QueueReady and MUST read the value back to ensure synchronization.

So we can't disable a queue via queue_enable but QueueReady. Any reason 
for such inconsistency?

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

