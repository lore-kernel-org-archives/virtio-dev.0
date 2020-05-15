Return-Path: virtio-dev-return-7345-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 688C8986048
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 May 2020 07:26:28 +0000 (UTC)
MIME-Version: 1.0
References: <20200311112004.47138-1-stevensd@chromium.org> <20200311112004.47138-5-stevensd@chromium.org>
 <20200513123326-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200513123326-mutt-send-email-mst@kernel.org>
From: David Stevens <stevensd@chromium.org>
Date: Fri, 15 May 2020 16:26:15 +0900
Message-ID: <CAD=HUj5qcMLw__LfJizR6nzCR9Qmu21Sjk3i0j_8+=rxt1Hk=w@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v3 4/4] drm/virtio: Support virtgpu exported resources
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

> > +     if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_UUID)) {
> > +             vgdev->has_resource_assign_uuid = true;
> > +     }
>
>
> Just a question: this relies on DMA bufs so I assume it is
> not really assumed to work when DMA API is bypassed, right?
> Rather than worry what does it mean, how about just
> disabling  this feature without PLATFORM_DMA for now?

By PLATFORM_DMA, do you mean CONFIG_DMA_SHARED_BUFFER? Virtio-gpu
depends on DRM, which selects that feature. So I think DMA bufs should
always be available when virtio-gpu is present.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

