Return-Path: virtio-dev-return-7674-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6B4B5985A9A
	for <virtio-dev@lists.oasis-open.org>; Tue, 18 Aug 2020 07:11:32 +0000 (UTC)
MIME-Version: 1.0
References: <20200818013744.3327271-1-stevensd@chromium.org> <20200818055949.6si4jzuubba5dx5u@sirius.home.kraxel.org>
In-Reply-To: <20200818055949.6si4jzuubba5dx5u@sirius.home.kraxel.org>
From: David Stevens <stevensd@chromium.org>
Date: Tue, 18 Aug 2020 00:11:21 -0700
Message-ID: <CAD=HUj5xqNE=7VPMH5MDq8h735-OnbancrkemJGkDKYmeddfNQ@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v6 0/3] Support virtio cross-device resources
Content-Type: text/plain; charset="UTF-8"
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

> Hmm, checkpatch still complains, full log below.
>
> IIRC "dim checkpatch" runs scripts/checkpatch.pl with --strict
> so it is a bit more picky ...

Ah, I didn't know --strict was being used. I'll send an update
momentarily. Sorry for the churn.

> -:250: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u32' over 'uint32_t'
> #250: FILE: drivers/gpu/drm/virtio/virtgpu_vq.c:1118:
> +       uint32_t resp_type = le32_to_cpu(resp->hdr.type);
>

For consistency with the rest of the virtgpu code, I'll leave uint32_t.

Cheers,
David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

