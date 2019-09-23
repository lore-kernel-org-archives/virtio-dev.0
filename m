Return-Path: virtio-dev-return-6146-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C845C984354
	for <virtio-dev@lists.oasis-open.org>; Mon, 23 Sep 2019 08:56:39 +0000 (UTC)
Date: Mon, 23 Sep 2019 10:56:37 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190923085637.bsaevedklweijgya@sirius.home.kraxel.org>
References: <20190919093404.182015-1-keiichiw@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919093404.182015-1-keiichiw@chromium.org>
Subject: Re: [virtio-dev] [PATCH] [RFC RESEND] vdec: Add virtio video decode
 device specification
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, acourbot@chromium.org, alexlau@chromium.org, dgreid@chromium.org, marcheu@chromium.org, posciak@chromium.org, stevensd@chromium.org, tfiga@chromium.org, hverkuil@xs4all.nl, linux-media@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> Our prototype implementation uses [4], which allows the virtio-vdec
> device to use buffers allocated by virtio-gpu device.

> [4] https://lkml.org/lkml/2019/9/12/157

Well.  I think before even discussing the protocol details we need a
reasonable plan for buffer handling.  I think using virtio-gpu buffers
should be an optional optimization and not a requirement.  Also the
motivation for that should be clear (Let the host decoder write directly
to virtio-gpu resources, to display video without copying around the
decoded framebuffers from one device to another).

Referencing virtio-gpu buffers needs a better plan than just re-using
virtio-gpu resource handles.  The handles are device-specific.  What if
there are multiple virtio-gpu devices present in the guest?

I think we need a framework for cross-device buffer sharing.  One
possible option would be to have some kind of buffer registry, where
buffers can be registered for cross-device sharing and get a unique
id (a uuid maybe?).  Drivers would typically register buffers on
dma-buf export.

Another option would be to pass around both buffer handle and buffer
owner, i.e. instead of "u32 handle" have something like this:

struct buffer_reference {
	enum device_type; /* pci, virtio-mmio, ... */
	union device_address {
		struct pci_address pci_addr;
		u64 virtio_mmio_addr;
		[ ... ]
	};
	u64 device_buffer_handle; /* device-specific, virtio-gpu could use resource ids here */
};

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

