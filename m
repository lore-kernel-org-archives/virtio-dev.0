Return-Path: <virtio-dev-return-8225-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C17DA986372
	for <virtio-dev@lists.oasis-open.org>; Mon,  5 Jul 2021 18:04:23 +0000 (UTC)
Date: Mon, 5 Jul 2021 14:04:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20210705140337-mutt-send-email-mst@kernel.org>
References: <75e7814a85767f111aefda0c173c83d4@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <75e7814a85767f111aefda0c173c83d4@codeaurora.org>
Subject: [virtio-dev] Re: virtio mmio reset - driver requirements
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc: virtio-dev@lists.oasis-open.org, vatsa.ml@gmail.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 05, 2021 at 10:07:15PM +0530, Srivatsa Vaddagiri wrote:
> I noticed this in virtio spec for PCI transport based devices:
> 
> "After writing 0 to device_status, the driver MUST wait for a read of
> device_status to return 0 before reinitializing the device."
> 
> I was wondering why the spec does not recommend a similar "wait after
> writing 0
> to status register" for other transports such as MMIO.
> 
> Even the Linux code for virtio_mmio does not have any such wait:
> 
> static void vm_reset(struct virtio_device *vdev)
> {
>         struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> 
>         /* 0 status means a reset. */
>         writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> }
> 
> Does that assume that backends are implemented in software when MMIO writes
> result in trap and backend synchronously does everything needed to handle
> reset
> as part of trap handling? Wouldn't it break if we were to have backends
> implemented in hardware device accessed via MMIO transport?
> 
> Thanks
> vatsa

I guess yes.

> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

