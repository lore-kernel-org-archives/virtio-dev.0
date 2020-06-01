Return-Path: virtio-dev-return-7431-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A85E59842AF
	for <virtio-dev@lists.oasis-open.org>; Mon,  1 Jun 2020 06:01:43 +0000 (UTC)
Date: Mon, 1 Jun 2020 02:01:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200601015736-mutt-send-email-mst@kernel.org>
References: <0592979c-c8ae-fd28-2ddf-e64b135a7292@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0592979c-c8ae-fd28-2ddf-e64b135a7292@redhat.com>
Subject: [virtio-dev] Re: queue_enable vs QueueReady
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, May 28, 2020 at 09:06:36PM +0800, Jason Wang wrote:
> Hi:
> 
> I found ambiguity in the virtio specification:
> 
> In PCI part, it describes the queue_enable as:
> 
> The driver uses this to selectively prevent the device from executing
> requests from this virtqueue. 1 - enabled; 0 - disabled.
> 
> In MMIO part, it describes the QueueReady as:
> 
> Writing one (0x1) to this register notifies the device that it can execute
> requests from this virtual queue. Reading from this register returns the
> last value written to it. Both read and write accesses apply to the queue
> selected by writing to QueueSel.
> 
> If I understand this correctly, they have the same meaning, but the driver
> requirements section looks conflict:
> 
> PCI said: The driver MUST NOT write a 0 to queue_enable.
> 
> MMIO said:
> 
> To stop using the queue the driver MUST write zero (0x0) to this QueueReady
> and MUST read the value back to ensure synchronization.
> 
> So we can't disable a queue via queue_enable but QueueReady. Any reason for
> such inconsistency?
> 
> Thanks

PCI assumed device reset is enough to stop all queues.  We had tons of
bugs around shutdown because of this, so in hindsight, MMIO had maybe a
better idea.

Ability to stop a queue and take back buffers would be nice, e.g. serial
is kind of messed up around port disconnect without it.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

