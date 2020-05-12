Return-Path: virtio-dev-return-7324-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5EC09985E2C
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 May 2020 12:10:31 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Tue, 12 May 2020 14:10:20 +0200
Message-ID: <64045565.OWohDWQxgf@os-lin-dmo>
In-Reply-To: <20200511143136.GC5830@pendragon.ideasonboard.com>
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com> <CAD90VcYJe7+R256RdOQKxFQciq54+PwbyDRF1cynjOzdQBrq-g@mail.gmail.com> <20200511143136.GC5830@pendragon.ideasonboard.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [libcamera-devel] [virtio-dev] Re: Fwd: Qemu Support for Virtio Video V4L2 driver
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, Saket Sinha <saket.sinha89@gmail.com>, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>, Kiran Pawar <Kiran.Pawar@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, libcamera-devel@lists.libcamera.org, Gerd Hoffmann <kraxel@redhat.com>, Pawel Osciak <posciak@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Laurent,

On Montag, 11. Mai 2020 16:31:36 CEST Laurent Pinchart wrote:
> 
> I don't think this would be the right level of abstraction. The V4L2 API
> is way too low-level when it comes to camera paravirtualization (and may
> not be the only API we'll have in the future). I thus recommend
> virtualizing cameras with a higher-level API, more or less on top of
> libcamera or the Android camera HAL (they both sit at the same level in
> the camera stack). Anything lower than that won't be practical.
> 

I think the the main thing to do first would be to define the logic of such 
virtio-camera device and the set of mandatory features. Host-side API is a bit 
of a side topic. But libcamera fits the best though.

Best regards,
Dmitry.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

