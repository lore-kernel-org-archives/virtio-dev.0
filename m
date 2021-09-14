Return-Path: <virtio-dev-return-8662-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E90F8986313
	for <virtio-dev@lists.oasis-open.org>; Tue, 14 Sep 2021 01:57:55 +0000 (UTC)
MIME-Version: 1.0
References: <20210909013717.861-1-gurchetansingh@chromium.org>
 <20210909013717.861-10-gurchetansingh@chromium.org> <CAPaKu7RB0hHTW9_WoOvp1X1Wz8L65ptSsJXKcPu22Rm9NKjAFQ@mail.gmail.com>
 <CAAfnVBmRKWgGQ2NXQSK9T4Hc95Yh_bpb=TGvyZgwMzDJdghrTQ@mail.gmail.com> <CAPaKu7SvzWPDAOKVSot9W4M880Hgdjm=RbKVrU=nthOaXh_hEg@mail.gmail.com>
In-Reply-To: <CAPaKu7SvzWPDAOKVSot9W4M880Hgdjm=RbKVrU=nthOaXh_hEg@mail.gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Mon, 13 Sep 2021 18:57:38 -0700
Message-ID: <CAAfnVB=+fpYhnjpbAzAgvYBnH9amRx8Nn0kkSR3PBcqPpjWLbw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v1 09/12] drm/virtio: implement context init:
 allocate an array of fence contexts
Content-Type: multipart/alternative; boundary="000000000000b91fba05cbeae861"
To: Chia-I Wu <olvaffe@gmail.com>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000b91fba05cbeae861
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 13, 2021 at 11:52 AM Chia-I Wu <olvaffe@gmail.com> wrote:

> .
>
> On Mon, Sep 13, 2021 at 10:48 AM Gurchetan Singh
> <gurchetansingh@chromium.org> wrote:
> >
> >
> >
> > On Fri, Sep 10, 2021 at 12:33 PM Chia-I Wu <olvaffe@gmail.com> wrote:
> >>
> >> On Wed, Sep 8, 2021 at 6:37 PM Gurchetan Singh
> >> <gurchetansingh@chromium.org> wrote:
> >> >
> >> > We don't want fences from different 3D contexts (virgl, gfxstream,
> >> > venus) to be on the same timeline.  With explicit context creation,
> >> > we can specify the number of ring each context wants.
> >> >
> >> > Execbuffer can specify which ring to use.
> >> >
> >> > Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> >> > Acked-by: Lingfeng Yang <lfy@google.com>
> >> > ---
> >> >  drivers/gpu/drm/virtio/virtgpu_drv.h   |  3 +++
> >> >  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 34
> ++++++++++++++++++++++++--
> >> >  2 files changed, 35 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h
> b/drivers/gpu/drm/virtio/virtgpu_drv.h
> >> > index a5142d60c2fa..cca9ab505deb 100644
> >> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> >> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> >> > @@ -56,6 +56,7 @@
> >> >  #define STATE_ERR 2
> >> >
> >> >  #define MAX_CAPSET_ID 63
> >> > +#define MAX_RINGS 64
> >> >
> >> >  struct virtio_gpu_object_params {
> >> >         unsigned long size;
> >> > @@ -263,6 +264,8 @@ struct virtio_gpu_fpriv {
> >> >         uint32_t ctx_id;
> >> >         uint32_t context_init;
> >> >         bool context_created;
> >> > +       uint32_t num_rings;
> >> > +       uint64_t base_fence_ctx;
> >> >         struct mutex context_lock;
> >> >  };
> >> >
> >> > diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> >> > index f51f3393a194..262f79210283 100644
> >> > --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> >> > +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> >> > @@ -99,6 +99,11 @@ static int virtio_gpu_execbuffer_ioctl(struct
> drm_device *dev, void *data,
> >> >         int in_fence_fd = exbuf->fence_fd;
> >> >         int out_fence_fd = -1;
> >> >         void *buf;
> >> > +       uint64_t fence_ctx;
> >> > +       uint32_t ring_idx;
> >> > +
> >> > +       fence_ctx = vgdev->fence_drv.context;
> >> > +       ring_idx = 0;
> >> >
> >> >         if (vgdev->has_virgl_3d == false)
> >> >                 return -ENOSYS;
> >> > @@ -106,6 +111,17 @@ static int virtio_gpu_execbuffer_ioctl(struct
> drm_device *dev, void *data,
> >> >         if ((exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS))
> >> >                 return -EINVAL;
> >> >
> >> > +       if ((exbuf->flags & VIRTGPU_EXECBUF_RING_IDX)) {
> >> > +               if (exbuf->ring_idx >= vfpriv->num_rings)
> >> > +                       return -EINVAL;
> >> > +
> >> > +               if (!vfpriv->base_fence_ctx)
> >> > +                       return -EINVAL;
> >> > +
> >> > +               fence_ctx = vfpriv->base_fence_ctx;
> >> > +               ring_idx = exbuf->ring_idx;
> >> > +       }
> >> > +
> >> >         exbuf->fence_fd = -1;
> >> >
> >> >         virtio_gpu_create_context(dev, file);
> >> > @@ -173,7 +189,7 @@ static int virtio_gpu_execbuffer_ioctl(struct
> drm_device *dev, void *data,
> >> >                         goto out_memdup;
> >> >         }
> >> >
> >> > -       out_fence = virtio_gpu_fence_alloc(vgdev,
> vgdev->fence_drv.context, 0);
> >> > +       out_fence = virtio_gpu_fence_alloc(vgdev, fence_ctx,
> ring_idx);
> >> >         if(!out_fence) {
> >> >                 ret = -ENOMEM;
> >> >                 goto out_unresv;
> >> > @@ -691,7 +707,7 @@ static int virtio_gpu_context_init_ioctl(struct
> drm_device *dev,
> >> >                 return -EINVAL;
> >> >
> >> >         /* Number of unique parameters supported at this time. */
> >> > -       if (num_params > 1)
> >> > +       if (num_params > 2)
> >> >                 return -EINVAL;
> >> >
> >> >         ctx_set_params =
> memdup_user(u64_to_user_ptr(args->ctx_set_params),
> >> > @@ -731,6 +747,20 @@ static int virtio_gpu_context_init_ioctl(struct
> drm_device *dev,
> >> >
> >> >                         vfpriv->context_init |= value;
> >> >                         break;
> >> > +               case VIRTGPU_CONTEXT_PARAM_NUM_RINGS:
> >> > +                       if (vfpriv->base_fence_ctx) {
> >> > +                               ret = -EINVAL;
> >> > +                               goto out_unlock;
> >> > +                       }
> >> > +
> >> > +                       if (value > MAX_RINGS) {
> >> > +                               ret = -EINVAL;
> >> > +                               goto out_unlock;
> >> > +                       }
> >> > +
> >> > +                       vfpriv->base_fence_ctx =
> dma_fence_context_alloc(value);
> >> With multiple fence contexts, we should do something about implicit
> fencing.
> >>
> >> The classic example is Mesa and X server.  When both use virgl and the
> >> global fence context, no dma_fence_wait is fine.  But when Mesa uses
> >> venus and the ring fence context, dma_fence_wait should be inserted.
> >
> >
> >  If I read your comment correctly, the use case is:
> >
> > context A (venus)
> >
> > sharing a render target with
> >
> > context B (Xserver backed virgl)
> >
> > ?
> >
> > Which function do you envisage dma_fence_wait(...) to be inserted?
> Doesn't implicit synchronization mean there's no fence to share between
> contexts (only buffer objects)?
>
> Fences can be implicitly shared via reservation objects associated
> with buffer objects.
>
> > It may be possible to wait on the reservation object associated with a
> buffer object from a different context (userspace can also do
> DRM_IOCTL_VIRTGPU_WAIT), but not sure if that's what you're looking for.
>
> Right, that's what I am looking for.  Userspace expects implicit
> fencing to work.  While there are works to move the userspace to do
> explicit fencing, it is not there yet in general and we can't require
> the userspace to do explicit fencing or DRM_IOCTL_VIRTGPU_WAIT.


Another option would be to use the upcoming
DMA_BUF_IOCTL_EXPORT_SYNC_FILE + VIRTGPU_EXECBUF_FENCE_FD_IN (which checks
the dma_fence context).

Generally, if it only requires virgl changes, userspace changes are fine
since OpenGL drivers implement implicit sync in many ways.  Waiting on the
reservation object in the kernel is fine too though.

Though venus doesn't use the NUM_RINGS param yet.  Getting all permutations
of context type + display integration working would take some time
(patchset mostly tested with wayland + gfxstream/Android [no implicit
sync]).

WDYT of someone figuring out virgl/venus interop later, independently of
this patchset?




>
> >
> >>
> >>
> >> > +                       vfpriv->num_rings = value;
> >> > +                       break;
> >> >                 default:
> >> >                         ret = -EINVAL;
> >> >                         goto out_unlock;
> >> > --
> >> > 2.33.0.153.gba50c8fa24-goog
> >> >
> >> >
> >> > ---------------------------------------------------------------------
> >> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> >> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >> >
>

--000000000000b91fba05cbeae861
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div dir=3D"ltr"><div dir=3D"lt=
r">=C2=A0</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">On Mon, Sep 13, 2021 at 11:52 AM Chia-I Wu &lt;<a href=3D"mailto:o=
lvaffe@gmail.com" target=3D"_blank">olvaffe@gmail.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">.<br>
<br>
On Mon, Sep 13, 2021 at 10:48 AM Gurchetan Singh<br>
&lt;<a href=3D"mailto:gurchetansingh@chromium.org" target=3D"_blank">gurche=
tansingh@chromium.org</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Fri, Sep 10, 2021 at 12:33 PM Chia-I Wu &lt;<a href=3D"mailto:olvaf=
fe@gmail.com" target=3D"_blank">olvaffe@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Sep 8, 2021 at 6:37 PM Gurchetan Singh<br>
&gt;&gt; &lt;<a href=3D"mailto:gurchetansingh@chromium.org" target=3D"_blan=
k">gurchetansingh@chromium.org</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; We don&#39;t want fences from different 3D contexts (virgl, g=
fxstream,<br>
&gt;&gt; &gt; venus) to be on the same timeline.=C2=A0 With explicit contex=
t creation,<br>
&gt;&gt; &gt; we can specify the number of ring each context wants.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Execbuffer can specify which ring to use.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Gurchetan Singh &lt;<a href=3D"mailto:gurcheta=
nsingh@chromium.org" target=3D"_blank">gurchetansingh@chromium.org</a>&gt;<=
br>
&gt;&gt; &gt; Acked-by: Lingfeng Yang &lt;<a href=3D"mailto:lfy@google.com"=
 target=3D"_blank">lfy@google.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 drivers/gpu/drm/virtio/virtgpu_drv.h=C2=A0 =C2=A0|=C2=
=A0 3 +++<br>
&gt;&gt; &gt;=C2=A0 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 34 +++++++++++=
+++++++++++++--<br>
&gt;&gt; &gt;=C2=A0 2 files changed, 35 insertions(+), 2 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/g=
pu/drm/virtio/virtgpu_drv.h<br>
&gt;&gt; &gt; index a5142d60c2fa..cca9ab505deb 100644<br>
&gt;&gt; &gt; --- a/drivers/gpu/drm/virtio/virtgpu_drv.h<br>
&gt;&gt; &gt; +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h<br>
&gt;&gt; &gt; @@ -56,6 +56,7 @@<br>
&gt;&gt; &gt;=C2=A0 #define STATE_ERR 2<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 #define MAX_CAPSET_ID 63<br>
&gt;&gt; &gt; +#define MAX_RINGS 64<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 struct virtio_gpu_object_params {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long size;<br>
&gt;&gt; &gt; @@ -263,6 +264,8 @@ struct virtio_gpu_fpriv {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t ctx_id;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t context_init;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool context_created;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t num_rings;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t base_fence_ctx;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex context_lock;<b=
r>
&gt;&gt; &gt;=C2=A0 };<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers=
/gpu/drm/virtio/virtgpu_ioctl.c<br>
&gt;&gt; &gt; index f51f3393a194..262f79210283 100644<br>
&gt;&gt; &gt; --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c<br>
&gt;&gt; &gt; +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c<br>
&gt;&gt; &gt; @@ -99,6 +99,11 @@ static int virtio_gpu_execbuffer_ioctl(str=
uct drm_device *dev, void *data,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int in_fence_fd =3D exbuf-&g=
t;fence_fd;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int out_fence_fd =3D -1;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *buf;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t fence_ctx;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t ring_idx;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0fence_ctx =3D vgdev-&gt;fence_drv=
.context;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ring_idx =3D 0;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vgdev-&gt;has_virgl_3d =
=3D=3D false)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return -ENOSYS;<br>
&gt;&gt; &gt; @@ -106,6 +111,17 @@ static int virtio_gpu_execbuffer_ioctl(s=
truct drm_device *dev, void *data,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((exbuf-&gt;flags &amp; ~=
VIRTGPU_EXECBUF_FLAGS))<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return -EINVAL;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((exbuf-&gt;flags &amp; VIRTGP=
U_EXECBUF_RING_IDX)) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (e=
xbuf-&gt;ring_idx &gt;=3D vfpriv-&gt;num_rings)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!=
vfpriv-&gt;base_fence_ctx)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fence=
_ctx =3D vfpriv-&gt;base_fence_ctx;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ring_=
idx =3D exbuf-&gt;ring_idx;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exbuf-&gt;fence_fd =3D -1;<b=
r>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_create_context(de=
v, file);<br>
&gt;&gt; &gt; @@ -173,7 +189,7 @@ static int virtio_gpu_execbuffer_ioctl(st=
ruct drm_device *dev, void *data,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_memdup;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0out_fence =3D virtio_gpu_fence_al=
loc(vgdev, vgdev-&gt;fence_drv.context, 0);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0out_fence =3D virtio_gpu_fence_al=
loc(vgdev, fence_ctx, ring_idx);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if(!out_fence) {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
ret =3D -ENOMEM;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
goto out_unresv;<br>
&gt;&gt; &gt; @@ -691,7 +707,7 @@ static int virtio_gpu_context_init_ioctl(=
struct drm_device *dev,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return -EINVAL;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Number of unique paramete=
rs supported at this time. */<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (num_params &gt; 1)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (num_params &gt; 2)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return -EINVAL;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx_set_params =3D memdup_us=
er(u64_to_user_ptr(args-&gt;ctx_set_params),<br>
&gt;&gt; &gt; @@ -731,6 +747,20 @@ static int virtio_gpu_context_init_ioctl=
(struct drm_device *dev,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0vfpriv-&gt;context_init |=3D value;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case =
VIRTGPU_CONTEXT_PARAM_NUM_RINGS:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (vfpriv-&gt;base_fence_ctx) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_unlock;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (value &gt; MAX_RINGS) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_unlock;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0vfpriv-&gt;base_fence_ctx =3D dma_fence_context_all=
oc(value);<br>
&gt;&gt; With multiple fence contexts, we should do something about implici=
t fencing.<br>
&gt;&gt;<br>
&gt;&gt; The classic example is Mesa and X server.=C2=A0 When both use virg=
l and the<br>
&gt;&gt; global fence context, no dma_fence_wait is fine.=C2=A0 But when Me=
sa uses<br>
&gt;&gt; venus and the ring fence context, dma_fence_wait should be inserte=
d.<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 If I read your comment correctly, the use case is:<br>
&gt;<br>
&gt; context A (venus)<br>
&gt;<br>
&gt; sharing a render target with<br>
&gt;<br>
&gt; context B (Xserver backed virgl)<br>
&gt;<br>
&gt; ?<br>
&gt;<br>
&gt; Which function do you envisage dma_fence_wait(...) to be inserted?=C2=
=A0 Doesn&#39;t implicit synchronization mean there&#39;s no fence to share=
 between contexts (only buffer objects)?<br>
<br>
Fences can be implicitly shared via reservation objects associated<br>
with buffer objects.<br>
<br>
&gt; It may be possible to wait on the reservation object associated with a=
 buffer object from a different context (userspace can also do DRM_IOCTL_VI=
RTGPU_WAIT), but not sure if that&#39;s what you&#39;re looking for.<br>
<br>
Right, that&#39;s what I am looking for.=C2=A0 Userspace expects implicit<b=
r>
fencing to work.=C2=A0 While there are works to move the userspace to do<br=
>
explicit fencing, it is not there yet in general and we can&#39;t require<b=
r>
the userspace to do explicit fencing or DRM_IOCTL_VIRTGPU_WAIT.</blockquote=
><div><br></div><div>Another option would be to use the upcoming DMA_BUF_IO=
CTL_EXPORT_SYNC_FILE=C2=A0+ VIRTGPU_EXECBUF_FENCE_FD_IN (which checks the d=
ma_fence context).=C2=A0=C2=A0</div><div><br></div><div>Generally, if it on=
ly requires virgl changes, userspace changes are fine since OpenGL drivers =
implement implicit sync in many ways.=C2=A0 Waiting on the reservation obje=
ct in the kernel is fine too though.=C2=A0=C2=A0</div><div><br></div><div>T=
hough venus doesn&#39;t use the NUM_RINGS param yet.=C2=A0 Getting all perm=
utations of context type=C2=A0+ display integration working would take some=
 time (patchset mostly tested with wayland=C2=A0+ gfxstream/Android [no imp=
licit sync]).</div><div><br></div><div>WDYT of someone figuring out virgl/v=
enus interop later, independently of this patchset?</div><div><br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0</blockquote><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0vfpriv-&gt;num_rings =3D value;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
default:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_unlock;<br>
&gt;&gt; &gt; --<br>
&gt;&gt; &gt; 2.33.0.153.gba50c8fa24-goog<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -------------------------------------------------------------=
--------<br>
&gt;&gt; &gt; To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscr=
ibe@lists.oasis-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oa=
sis-open.org</a><br>
&gt;&gt; &gt; For additional commands, e-mail: <a href=3D"mailto:virtio-dev=
-help@lists.oasis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-o=
pen.org</a><br>
&gt;&gt; &gt;<br>
</blockquote></div></div>
</div>

--000000000000b91fba05cbeae861--

