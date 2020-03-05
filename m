Return-Path: virtio-dev-return-6890-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F45D985F2D
	for <virtio-dev@lists.oasis-open.org>; Thu,  5 Mar 2020 08:51:03 +0000 (UTC)
MIME-Version: 1.0
References: <20200302121524.7543-1-stevensd@chromium.org> <20200302121524.7543-5-stevensd@chromium.org>
 <20200304080119.i55opxkhk4kdt4hp@sirius.home.kraxel.org>
In-Reply-To: <20200304080119.i55opxkhk4kdt4hp@sirius.home.kraxel.org>
From: David Stevens <stevensd@chromium.org>
Date: Thu, 5 Mar 2020 17:50:51 +0900
Message-ID: <CAD=HUj7jS5jaRmiJwtGMSQZnR8Qd0VvPkBSbs1d-nATdczWdZA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2 4/4] drm/virtio: Support virtgpu exported resources
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 4, 2020 at 5:01 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > +     if (vgdev->has_resource_assign_uuid) {
> > +             spin_lock(&vgdev->resource_export_lock);
> > +             if (bo->uuid_state =3D=3D UUID_NOT_INITIALIZED) {
> > +                     bo->uuid_state =3D UUID_INITIALIZING;
> > +                     needs_init =3D true;
> > +             }
> > +             spin_unlock(&vgdev->resource_export_lock);
> > +
> > +             if (needs_init) {
> > +                     ret =3D virtio_gpu_cmd_resource_assign_uuid(vgdev=
, bo);
>
> You can submit a fenced command, then wait on the fence here.  Removes
> the need for UUID_INITIALIZING.

Synchronously waiting is simper, but only doing the wait when trying
to use the UUID can help to hide the latency of the virito commands.
That can save quite a bit of time when setting up multiple buffers for
a graphics pipeline, which I think is worthwhile.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

