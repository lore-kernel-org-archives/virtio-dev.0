Return-Path: virtio-dev-return-6886-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BCA95985D7E
	for <virtio-dev@lists.oasis-open.org>; Wed,  4 Mar 2020 08:01:30 +0000 (UTC)
Date: Wed, 4 Mar 2020 09:01:19 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200304080119.i55opxkhk4kdt4hp@sirius.home.kraxel.org>
References: <20200302121524.7543-1-stevensd@chromium.org>
 <20200302121524.7543-5-stevensd@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20200302121524.7543-5-stevensd@chromium.org>
Subject: [virtio-dev] Re: [PATCH v2 4/4] drm/virtio: Support virtgpu exported resources
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Stevens <stevensd@chromium.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> +=09if (vgdev->has_resource_assign_uuid) {
> +=09=09spin_lock(&vgdev->resource_export_lock);
> +=09=09if (bo->uuid_state =3D=3D UUID_NOT_INITIALIZED) {
> +=09=09=09bo->uuid_state =3D UUID_INITIALIZING;
> +=09=09=09needs_init =3D true;
> +=09=09}
> +=09=09spin_unlock(&vgdev->resource_export_lock);
> +
> +=09=09if (needs_init) {
> +=09=09=09ret =3D virtio_gpu_cmd_resource_assign_uuid(vgdev, bo);

You can submit a fenced command, then wait on the fence here.  Removes
the need for UUID_INITIALIZING.

Also note that this function will be called only once, on the first
export.  When exporting the same object again drm will simply reuse
the existing dmabuf.  You can drop UUID_NOT_INITIALIZED and needs_init.

So you are left with only two uuid_state states.  You could turn uuid
into a pointer, so it gets only allocated when needed.  Also uuid =3D=3D
NULL can be used for "uuid not available" then.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

