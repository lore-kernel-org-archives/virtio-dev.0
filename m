Return-Path: virtio-dev-return-6238-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 493B2984347
	for <virtio-dev@lists.oasis-open.org>; Mon, 14 Oct 2019 12:34:47 +0000 (UTC)
Date: Mon, 14 Oct 2019 14:34:43 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191014123443.ey3yfdnr43kplqaq@sirius.home.kraxel.org>
References: <20190919093404.182015-1-keiichiw@chromium.org>
 <4037801.MZecyecTDs@os-lin-dmo>
 <CAAFQd5CfNK1oisDaOWaW+9NTQOLn1EHPrPzvxMPcSxLkBgv3Ww@mail.gmail.com>
 <15135216.K0K410U5qv@os-lin-dmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15135216.K0K410U5qv@os-lin-dmo>
Subject: Re: [virtio-dev] [PATCH] [RFC RESEND] vdec: Add virtio video decode
 device specification
To: Dmitry Morozov <dmitry.morozov@opensynergy.com>
Cc: Tomasz Figa <tfiga@chromium.org>, stevensd@chromium.org, virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, alexlau@chromium.org, dgreid@chromium.org, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Linux Media Mailing List <linux-media@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> My take on this (for a decoder) would be to allocate memory for output buffers 
> from a secure ION heap, import in the v4l2 driver, and then to provide those 
> to the device using virtio. The device side then uses the dmabuf framework to 
> make the buffers accessible for the hardware. I'm not sure about that, it's 
> just an idea.

Virtualization aside, how does the complete video decoding workflow
work?  I assume along the lines of ...

  (1) allocate buffer for decoded video frames (from ion).
  (2) export those buffers as dma-buf.
  (3) import dma-buf to video decoder.
  (4) import dma-buf to gpu.

... to establish buffers shared between video decoder and gpu?

Then feed the video stream into the decoder, which decodes into the ion
buffers?  Ask the gpu to scanout the ion buffers to show the video?

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

