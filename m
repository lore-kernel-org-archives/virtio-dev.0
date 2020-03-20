Return-Path: virtio-dev-return-6964-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C96D6985DE0
	for <virtio-dev@lists.oasis-open.org>; Fri, 20 Mar 2020 06:48:45 +0000 (UTC)
Date: Fri, 20 Mar 2020 07:48:30 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200320064830.svdgh4xuxbxz6bc4@sirius.home.kraxel.org>
References: <20200311112004.47138-1-stevensd@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20200311112004.47138-1-stevensd@chromium.org>
Subject: [virtio-dev] Re: [PATCH v3 0/4] Support virtio cross-device resources
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Stevens <stevensd@chromium.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 11, 2020 at 08:20:00PM +0900, David Stevens wrote:
> This patchset implements the current proposal for virtio cross-device
> resource sharing [1], with minor changes based on recent comments. It
> is expected that this will be used to import virtio resources into the
> virtio-video driver currently under discussion [2].
>=20
> This patchset adds a new hook to dma-buf, for querying the dma-buf's
> underlying virtio UUID. This hook is then plumbed through DRM PRIME
> buffers, and finally implemented in virtgpu.

Looks all fine to me.  We should wait for the virtio protocol update
(patch 3/4) being accepted into the virtio specification.  When this is
done I'll go commit this to drm-misc-next.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

