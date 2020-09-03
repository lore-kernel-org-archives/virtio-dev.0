Return-Path: virtio-dev-return-7757-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 618FD985EC8
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Sep 2020 00:00:42 +0000 (UTC)
MIME-Version: 1.0
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
 <20200902210847.2689-5-gurchetansingh@chromium.org> <20200902221514.GE1263242@redhat.com>
In-Reply-To: <20200902221514.GE1263242@redhat.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed, 2 Sep 2020 17:00:25 -0700
Message-ID: <CAAfnVBnfbwc07au1OMec8g5yHC0D3yXc88nOtTopO4sitYf8ig@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2 04/23] virtio: Add get_shm_region method
Content-Type: multipart/alternative; boundary="0000000000003049d305ae5d711d"
To: Vivek Goyal <vgoyal@redhat.com>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, virtio-dev@lists.oasis-open.org, Sebastien Boeuf <sebastien.boeuf@intel.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
List-ID: <virtio-dev.lists.oasis-open.org>

--0000000000003049d305ae5d711d
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 2, 2020 at 3:15 PM Vivek Goyal <vgoyal@redhat.com> wrote:

> Hi Gurchetan,
>
> Now Miklos has queued, these tree virtio patches for shared memory
> region in his tree as part of virtiofs dax patch series.
>
> I am hoping this will get merged in 5.10 through his tree.
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/log/?h=dax


Terrific ... !  Maybe we can queue the version Miklos has in drm-misc-next
to avoid merge conflicts ?!?

There's a few checkpatch --strict fixes in the blob version, but I doubt
anyone cares.


>
> Thanks
> Vivek
>
> On Wed, Sep 02, 2020 at 02:08:28PM -0700, Gurchetan Singh wrote:
> > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> >
> > Virtio defines 'shared memory regions' that provide a continuously
> > shared region between the host and guest.
> >
> > Provide a method to find a particular region on a device.
> >
> > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > Cc: kvm@vger.kernel.org
> > Cc: virtualization@lists.linux-foundation.org
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > ---
> >  include/linux/virtio_config.h | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/include/linux/virtio_config.h
> b/include/linux/virtio_config.h
> > index 8fe857e27ef32..4b8e38c5c4d8c 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -11,6 +11,11 @@
> >
> >  struct irq_affinity;
> >
> > +struct virtio_shm_region {
> > +     u64 addr;
> > +     u64 len;
> > +};
> > +
> >  /**
> >   * virtio_config_ops - operations for configuring a virtio device
> >   * Note: Do not assume that a transport implements all of the operations
> > @@ -66,6 +71,7 @@ struct irq_affinity;
> >   *      the caller can then copy.
> >   * @set_vq_affinity: set the affinity for a virtqueue (optional).
> >   * @get_vq_affinity: get the affinity for a virtqueue (optional).
> > + * @get_shm_region: get a shared memory region based on the index.
> >   */
> >  typedef void vq_callback_t(struct virtqueue *);
> >  struct virtio_config_ops {
> > @@ -89,6 +95,8 @@ struct virtio_config_ops {
> >                              const struct cpumask *cpu_mask);
> >       const struct cpumask *(*get_vq_affinity)(struct virtio_device
> *vdev,
> >                       int index);
> > +     bool (*get_shm_region)(struct virtio_device *vdev,
> > +                            struct virtio_shm_region *region, u8 id);
> >  };
> >
> >  /* If driver didn't advertise the feature, it will never appear. */
> > @@ -251,6 +259,15 @@ int virtqueue_set_affinity(struct virtqueue *vq,
> const struct cpumask *cpu_mask)
> >       return 0;
> >  }
> >
> > +static inline
> > +bool virtio_get_shm_region(struct virtio_device *vdev,
> > +                        struct virtio_shm_region *region, u8 id)
> > +{
> > +     if (!vdev->config->get_shm_region)
> > +             return false;
> > +     return vdev->config->get_shm_region(vdev, region, id);
> > +}
> > +
> >  static inline bool virtio_is_little_endian(struct virtio_device *vdev)
> >  {
> >       return virtio_has_feature(vdev, VIRTIO_F_VERSION_1) ||
> > --
> > 2.26.2
> >
>
>

--0000000000003049d305ae5d711d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 2, 2020 at 3:15 PM Vivek =
Goyal &lt;<a href=3D"mailto:vgoyal@redhat.com">vgoyal@redhat.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Gurcheta=
n,<br>
<br>
Now Miklos has queued, these tree virtio patches for shared memory<br>
region in his tree as part of virtiofs dax patch series.<br>
<br>
I am hoping this will get merged in 5.10 through his tree.<br>
<br>
<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.gi=
t/log/?h=3Ddax" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org=
/pub/scm/linux/kernel/git/mszeredi/fuse.git/log/?h=3Ddax</a></blockquote><d=
iv><br></div><div>Terrific ... !=C2=A0 Maybe we can queue the version Miklo=
s has in drm-misc-next to avoid merge conflicts ?!?</div><div><br></div><di=
v>There&#39;s a few checkpatch --strict fixes in the blob version, but I do=
ubt anyone cares.</div><div><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><br>
<br>
Thanks<br>
Vivek<br>
<br>
On Wed, Sep 02, 2020 at 02:08:28PM -0700, Gurchetan Singh wrote:<br>
&gt; From: Sebastien Boeuf &lt;<a href=3D"mailto:sebastien.boeuf@intel.com"=
 target=3D"_blank">sebastien.boeuf@intel.com</a>&gt;<br>
&gt; <br>
&gt; Virtio defines &#39;shared memory regions&#39; that provide a continuo=
usly<br>
&gt; shared region between the host and guest.<br>
&gt; <br>
&gt; Provide a method to find a particular region on a device.<br>
&gt; <br>
&gt; Signed-off-by: Sebastien Boeuf &lt;<a href=3D"mailto:sebastien.boeuf@i=
ntel.com" target=3D"_blank">sebastien.boeuf@intel.com</a>&gt;<br>
&gt; Signed-off-by: Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgilbert@r=
edhat.com" target=3D"_blank">dgilbert@redhat.com</a>&gt;<br>
&gt; Acked-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" tar=
get=3D"_blank">mst@redhat.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:kvm@vger.kernel.org" target=3D"_blank">kvm@vger.=
kernel.org</a><br>
&gt; Cc: <a href=3D"mailto:virtualization@lists.linux-foundation.org" targe=
t=3D"_blank">virtualization@lists.linux-foundation.org</a><br>
&gt; Cc: &quot;Michael S. Tsirkin&quot; &lt;<a href=3D"mailto:mst@redhat.co=
m" target=3D"_blank">mst@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/linux/virtio_config.h | 17 +++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 17 insertions(+)<br>
&gt; <br>
&gt; diff --git a/include/linux/virtio_config.h b/include/linux/virtio_conf=
ig.h<br>
&gt; index 8fe857e27ef32..4b8e38c5c4d8c 100644<br>
&gt; --- a/include/linux/virtio_config.h<br>
&gt; +++ b/include/linux/virtio_config.h<br>
&gt; @@ -11,6 +11,11 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 struct irq_affinity;<br>
&gt;=C2=A0 <br>
&gt; +struct virtio_shm_region {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u64 addr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u64 len;<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 /**<br>
&gt;=C2=A0 =C2=A0* virtio_config_ops - operations for configuring a virtio =
device<br>
&gt;=C2=A0 =C2=A0* Note: Do not assume that a transport implements all of t=
he operations<br>
&gt; @@ -66,6 +71,7 @@ struct irq_affinity;<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0 the caller can then copy.<br>
&gt;=C2=A0 =C2=A0* @set_vq_affinity: set the affinity for a virtqueue (opti=
onal).<br>
&gt;=C2=A0 =C2=A0* @get_vq_affinity: get the affinity for a virtqueue (opti=
onal).<br>
&gt; + * @get_shm_region: get a shared memory region based on the index.<br=
>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 typedef void vq_callback_t(struct virtqueue *);<br>
&gt;=C2=A0 struct virtio_config_ops {<br>
&gt; @@ -89,6 +95,8 @@ struct virtio_config_ops {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct cpumask *cpu_mask);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct cpumask *(*get_vq_affinity)(str=
uct virtio_device *vdev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0int index);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool (*get_shm_region)(struct virtio_device *vdev=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_shm_region *region, u8 id);<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* If driver didn&#39;t advertise the feature, it will never app=
ear. */<br>
&gt; @@ -251,6 +259,15 @@ int virtqueue_set_affinity(struct virtqueue *vq, =
const struct cpumask *cpu_mask)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static inline<br>
&gt; +bool virtio_get_shm_region(struct virtio_device *vdev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 struct virtio_shm_region *region, u8 id)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!vdev-&gt;config-&gt;get_shm_region)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return vdev-&gt;config-&gt;get_shm_region(vdev, r=
egion, id);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static inline bool virtio_is_little_endian(struct virtio_device =
*vdev)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return virtio_has_feature(vdev, VIRTIO_F_VER=
SION_1) ||<br>
&gt; -- <br>
&gt; 2.26.2<br>
&gt; <br>
<br>
</blockquote></div></div>

--0000000000003049d305ae5d711d--

