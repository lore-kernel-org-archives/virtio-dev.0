Return-Path: virtio-dev-return-6467-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8D31798607D
	for <virtio-dev@lists.oasis-open.org>; Thu,  5 Dec 2019 16:11:44 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Thu, 5 Dec 2019 17:11:37 +0100
Message-ID: <4595464.3jghpSLKuc@os-lin-dmo>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC] virtio video driver
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 7Bit
To: linux-media@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kraxel@redhat.com, tfiga@chromium.org, keiichiw@chromium.org, acourbot@chromium.org, hverkuil@xs4all.nl, posciak@chromium.org, marcheu@chromium.org, stevensd@chromium.org, dgreid@chromium.org, daniel@ffwll.ch, egranata@google.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hello,

My apologies for the long delay. The driver code is now available and provided 
as a follow-up to the discussion from this thread [1].

The reference Linux kernel 5.4 driver implementation is located here:
https://github.com/OpenSynergy/linux/tree/virtio-video-draft-v1

The driver is implemented using the V4L2 API. It allocates a v4l2 device for 
each probed virtio device and then creates a video device for each function 
within the respective virtio device. The driver implements the stateful 
decoder interface [2] and the stateful encoder interface (WIP) [3].

The DMA SG memory allocator tries to map buffers right away. As it is not 
always suitable, and some implementations might need just a physical address, 
we had to introduce a set of simple dma ops directly in the driver.

The driver is in the RFC state and currently a bit ahead of the spec that was 
proposed in the discussion mentioned above. On the other hand, the driver 
unfortunately does not yet include changes proposed in the recent comments 
[4]. The driver currently supports encoder and decoder functions. Also, it 
does not fully pass the v4l2-compliance yet, it has been a bit out of the 
focus so far.

Any feedback and contribution would be greatly appreciated.

[1] https://markmail.org/message/gc6h25acct22niut
[2] https://www.kernel.org/doc/html/v5.4/media/uapi/v4l/dev-decoder.html
[3] https://hverkuil.home.xs4all.nl/codec-api/uapi/v4l/dev-encoder.html
[4] https://markmail.org/message/yy67elx2adbivdsp

Best regards,
Dmitry.




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

