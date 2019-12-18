Return-Path: virtio-dev-return-6533-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5E14E985EFE
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Dec 2019 13:40:47 +0000 (UTC)
Date: Wed, 18 Dec 2019 14:40:37 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191218134037.3jbouht52bxqwfyy@sirius.home.kraxel.org>
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <20191218130214.170703-2-keiichiw@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20191218130214.170703-2-keiichiw@chromium.org>
Subject: [virtio-dev] Re: [PATCH v2 1/1] virtio-video: Add virtio video device
 specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, linux-media@vger.kernel.org, acourbot@chromium.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, dmitry.sepp@opensynergy.com, egranata@google.com, fziglio@redhat.com, hverkuil@xs4all.nl, marcheu@chromium.org, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> +The device MUST mark the last buffer with the
> +VIRTIO_VIDEO_BUFFER_F_EOS flag to denote completion of the drain
> +sequence.

No, that would build a race condition into the protocol.  The device
could complete the last buffer after the driver has sent the drain
command but before the device saw it.  So the flag would not be
reliable.

I also can't see why the flag is needed in the first place.  The driver
should know which buffers are queued still and be able to figure
whenever the drain is complete or not without depending on that flag.
So I'd suggest to simply drop it.

That is the only issue I've spotted in the protocol on a first quick
look.  There are a few places where the spec text could be improved.
I'll try to set aside some time to go over this in detail, but I can't
promise I'll find the time to do that before xmas and new year.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

