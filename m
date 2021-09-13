Return-Path: <virtio-dev-return-8660-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 882549862EF
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Sep 2021 17:48:28 +0000 (UTC)
MIME-Version: 1.0
References: <20210909013717.861-1-gurchetansingh@chromium.org>
 <20210909013717.861-10-gurchetansingh@chromium.org> <CAPaKu7RB0hHTW9_WoOvp1X1Wz8L65ptSsJXKcPu22Rm9NKjAFQ@mail.gmail.com>
In-Reply-To: <CAPaKu7RB0hHTW9_WoOvp1X1Wz8L65ptSsJXKcPu22Rm9NKjAFQ@mail.gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Mon, 13 Sep 2021 10:48:12 -0700
Message-ID: <CAAfnVBmRKWgGQ2NXQSK9T4Hc95Yh_bpb=TGvyZgwMzDJdghrTQ@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v1 09/12] drm/virtio: implement context init:
 allocate an array of fence contexts
Content-Type: multipart/alternative; boundary="0000000000004ed90105cbe412db"
To: Chia-I Wu <olvaffe@gmail.com>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--0000000000004ed90105cbe412db
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 10, 2021 at 12:33 PM Chia-I Wu <olvaffe@gmail.com> wrote:

> On Wed, Sep 8, 2021 at 6:37 PM Gurchetan Singh
> <gurchetansingh@chromium.org> wrote:
> >
> > We don't want fences from different 3D contexts (virgl, gfxstream,
> > venus) to be on the same timeline.  With explicit context creation,
> > we can specify the number of ring each context wants.
> >
> > Execbuffer can specify which ring to use.
> >
> > Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> > Acked-by: Lingfeng Yang <lfy@google.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_drv.h   |  3 +++
> >  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 34 ++++++++++++++++++++++++--
> >  2 files changed, 35 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h
> b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > index a5142d60c2fa..cca9ab505deb 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > @@ -56,6 +56,7 @@
> >  #define STATE_ERR 2
> >
> >  #define MAX_CAPSET_ID 63
> > +#define MAX_RINGS 64
> >
> >  struct virtio_gpu_object_params {
> >         unsigned long size;
> > @@ -263,6 +264,8 @@ struct virtio_gpu_fpriv {
> >         uint32_t ctx_id;
> >         uint32_t context_init;
> >         bool context_created;
> > +       uint32_t num_rings;
> > +       uint64_t base_fence_ctx;
> >         struct mutex context_lock;
> >  };
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > index f51f3393a194..262f79210283 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > @@ -99,6 +99,11 @@ static int virtio_gpu_execbuffer_ioctl(struct
> drm_device *dev, void *data,
> >         int in_fence_fd = exbuf->fence_fd;
> >         int out_fence_fd = -1;
> >         void *buf;
> > +       uint64_t fence_ctx;
> > +       uint32_t ring_idx;
> > +
> > +       fence_ctx = vgdev->fence_drv.context;
> > +       ring_idx = 0;
> >
> >         if (vgdev->has_virgl_3d == false)
> >                 return -ENOSYS;
> > @@ -106,6 +111,17 @@ static int virtio_gpu_execbuffer_ioctl(struct
> drm_device *dev, void *data,
> >         if ((exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS))
> >                 return -EINVAL;
> >
> > +       if ((exbuf->flags & VIRTGPU_EXECBUF_RING_IDX)) {
> > +               if (exbuf->ring_idx >= vfpriv->num_rings)
> > +                       return -EINVAL;
> > +
> > +               if (!vfpriv->base_fence_ctx)
> > +                       return -EINVAL;
> > +
> > +               fence_ctx = vfpriv->base_fence_ctx;
> > +               ring_idx = exbuf->ring_idx;
> > +       }
> > +
> >         exbuf->fence_fd = -1;
> >
> >         virtio_gpu_create_context(dev, file);
> > @@ -173,7 +189,7 @@ static int virtio_gpu_execbuffer_ioctl(struct
> drm_device *dev, void *data,
> >                         goto out_memdup;
> >         }
> >
> > -       out_fence = virtio_gpu_fence_alloc(vgdev,
> vgdev->fence_drv.context, 0);
> > +       out_fence = virtio_gpu_fence_alloc(vgdev, fence_ctx, ring_idx);
> >         if(!out_fence) {
> >                 ret = -ENOMEM;
> >                 goto out_unresv;
> > @@ -691,7 +707,7 @@ static int virtio_gpu_context_init_ioctl(struct
> drm_device *dev,
> >                 return -EINVAL;
> >
> >         /* Number of unique parameters supported at this time. */
> > -       if (num_params > 1)
> > +       if (num_params > 2)
> >                 return -EINVAL;
> >
> >         ctx_set_params =
> memdup_user(u64_to_user_ptr(args->ctx_set_params),
> > @@ -731,6 +747,20 @@ static int virtio_gpu_context_init_ioctl(struct
> drm_device *dev,
> >
> >                         vfpriv->context_init |= value;
> >                         break;
> > +               case VIRTGPU_CONTEXT_PARAM_NUM_RINGS:
> > +                       if (vfpriv->base_fence_ctx) {
> > +                               ret = -EINVAL;
> > +                               goto out_unlock;
> > +                       }
> > +
> > +                       if (value > MAX_RINGS) {
> > +                               ret = -EINVAL;
> > +                               goto out_unlock;
> > +                       }
> > +
> > +                       vfpriv->base_fence_ctx =
> dma_fence_context_alloc(value);
> With multiple fence contexts, we should do something about implicit
> fencing.
>
> The classic example is Mesa and X server.  When both use virgl and the
> global fence context, no dma_fence_wait is fine.  But when Mesa uses
> venus and the ring fence context, dma_fence_wait should be inserted.
>

 If I read your comment correctly, the use case is:

context A (venus)

sharing a render target with

context B (Xserver backed virgl)

?

Which function do you envisage dma_fence_wait(...) to be inserted?  Doesn't
implicit synchronization mean there's no fence to share between contexts
(only buffer objects)?

It may be possible to wait on the reservation object associated with a
buffer object from a different context (userspace can also do
DRM_IOCTL_VIRTGPU_WAIT), but not sure if that's what you're looking for.


>
> > +                       vfpriv->num_rings = value;
> > +                       break;
> >                 default:
> >                         ret = -EINVAL;
> >                         goto out_unlock;
> > --
> > 2.33.0.153.gba50c8fa24-goog
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >
>

--0000000000004ed90105cbe412db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 10, 2021 at 12:33 PM Chia=
-I Wu &lt;<a href=3D"mailto:olvaffe@gmail.com" target=3D"_blank">olvaffe@gm=
ail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On Wed, Sep 8, 2021 at 6:37 PM Gurchetan Singh<br>
&lt;<a href=3D"mailto:gurchetansingh@chromium.org" target=3D"_blank">gurche=
tansingh@chromium.org</a>&gt; wrote:<br>
&gt;<br>
&gt; We don&#39;t want fences from different 3D contexts (virgl, gfxstream,=
<br>
&gt; venus) to be on the same timeline.=C2=A0 With explicit context creatio=
n,<br>
&gt; we can specify the number of ring each context wants.<br>
&gt;<br>
&gt; Execbuffer can specify which ring to use.<br>
&gt;<br>
&gt; Signed-off-by: Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@ch=
romium.org" target=3D"_blank">gurchetansingh@chromium.org</a>&gt;<br>
&gt; Acked-by: Lingfeng Yang &lt;<a href=3D"mailto:lfy@google.com" target=
=3D"_blank">lfy@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/virtio/virtgpu_drv.h=C2=A0 =C2=A0|=C2=A0 3 +++<b=
r>
&gt;=C2=A0 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 34 ++++++++++++++++++++=
++++--<br>
&gt;=C2=A0 2 files changed, 35 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/vi=
rtio/virtgpu_drv.h<br>
&gt; index a5142d60c2fa..cca9ab505deb 100644<br>
&gt; --- a/drivers/gpu/drm/virtio/virtgpu_drv.h<br>
&gt; +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h<br>
&gt; @@ -56,6 +56,7 @@<br>
&gt;=C2=A0 #define STATE_ERR 2<br>
&gt;<br>
&gt;=C2=A0 #define MAX_CAPSET_ID 63<br>
&gt; +#define MAX_RINGS 64<br>
&gt;<br>
&gt;=C2=A0 struct virtio_gpu_object_params {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long size;<br>
&gt; @@ -263,6 +264,8 @@ struct virtio_gpu_fpriv {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t ctx_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t context_init;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool context_created;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t num_rings;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t base_fence_ctx;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex context_lock;<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/=
virtio/virtgpu_ioctl.c<br>
&gt; index f51f3393a194..262f79210283 100644<br>
&gt; --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c<br>
&gt; +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c<br>
&gt; @@ -99,6 +99,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_d=
evice *dev, void *data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int in_fence_fd =3D exbuf-&gt;fence_f=
d;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int out_fence_fd =3D -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *buf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t fence_ctx;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t ring_idx;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0fence_ctx =3D vgdev-&gt;fence_drv.context;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ring_idx =3D 0;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vgdev-&gt;has_virgl_3d =3D=3D fal=
se)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -E=
NOSYS;<br>
&gt; @@ -106,6 +111,17 @@ static int virtio_gpu_execbuffer_ioctl(struct drm=
_device *dev, void *data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((exbuf-&gt;flags &amp; ~VIRTGPU_E=
XECBUF_FLAGS))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -E=
INVAL;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((exbuf-&gt;flags &amp; VIRTGPU_EXECBUF=
_RING_IDX)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (exbuf-&gt;=
ring_idx &gt;=3D vfpriv-&gt;num_rings)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vfpriv-&g=
t;base_fence_ctx)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fence_ctx =3D =
vfpriv-&gt;base_fence_ctx;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ring_idx =3D e=
xbuf-&gt;ring_idx;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exbuf-&gt;fence_fd =3D -1;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_create_context(dev, file);=
<br>
&gt; @@ -173,7 +189,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_=
device *dev, void *data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0goto out_memdup;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0out_fence =3D virtio_gpu_fence_alloc(vgdev=
, vgdev-&gt;fence_drv.context, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0out_fence =3D virtio_gpu_fence_alloc(vgdev=
, fence_ctx, ring_idx);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if(!out_fence) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -=
ENOMEM;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_=
unresv;<br>
&gt; @@ -691,7 +707,7 @@ static int virtio_gpu_context_init_ioctl(struct dr=
m_device *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -E=
INVAL;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Number of unique parameters suppor=
ted at this time. */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (num_params &gt; 1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (num_params &gt; 2)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -E=
INVAL;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx_set_params =3D memdup_user(u64_to=
_user_ptr(args-&gt;ctx_set_params),<br>
&gt; @@ -731,6 +747,20 @@ static int virtio_gpu_context_init_ioctl(struct d=
rm_device *dev,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0vfpriv-&gt;context_init |=3D value;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case VIRTGPU_C=
ONTEXT_PARAM_NUM_RINGS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (vfpriv-&gt;base_fence_ctx) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_unlock;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (value &gt; MAX_RINGS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_unlock;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0vfpriv-&gt;base_fence_ctx =3D dma_fence_context_alloc(value);=
<br>
With multiple fence contexts, we should do something about implicit fencing=
.<br>
<br>
The classic example is Mesa and X server.=C2=A0 When both use virgl and the=
<br>
global fence context, no dma_fence_wait is fine.=C2=A0 But when Mesa uses<b=
r>
venus and the ring fence context, dma_fence_wait should be inserted.<br></b=
lockquote><div><br></div><div>=C2=A0If I read your comment correctly, the u=
se case is:</div><div><br></div><div>context A (venus)=C2=A0</div><div><br>=
</div><div>sharing a render target with</div><div><br></div><div>context B =
(Xserver backed virgl)</div><div><br></div><div>?</div><div><br></div><div>=
Which function do you envisage dma_fence_wait(...) to be inserted?=C2=A0 Do=
esn&#39;t implicit synchronization mean there&#39;s no fence to share betwe=
en contexts (only buffer objects)?=C2=A0=C2=A0</div><div><br></div><div>It =
may be possible to wait on the reservation object associated with a buffer =
object from a different context (userspace can also do DRM_IOCTL_VIRTGPU_WA=
IT), but not sure if that&#39;s what you&#39;re looking for.</div><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0vfpriv-&gt;num_rings =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0goto out_unlock;<br>
&gt; --<br>
&gt; 2.33.0.153.gba50c8fa24-goog<br>
&gt;<br>
&gt;<br>
&gt; ---------------------------------------------------------------------<=
br>
&gt; To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@lists=
.oasis-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oasis-open.=
org</a><br>
&gt; For additional commands, e-mail: <a href=3D"mailto:virtio-dev-help@lis=
ts.oasis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.org</=
a><br>
&gt;<br>
</blockquote></div></div>

--0000000000004ed90105cbe412db--

