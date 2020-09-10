Return-Path: virtio-dev-return-7772-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 65B71985F8B
	for <virtio-dev@lists.oasis-open.org>; Thu, 10 Sep 2020 00:28:21 +0000 (UTC)
MIME-Version: 1.0
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
 <20200902210847.2689-5-gurchetansingh@chromium.org> <20200902221514.GE1263242@redhat.com>
 <CAAfnVBnfbwc07au1OMec8g5yHC0D3yXc88nOtTopO4sitYf8ig@mail.gmail.com>
 <20200909070349.uyvg44xakdftibxh@sirius.home.kraxel.org> <CAJfpegsMEZoCQe7frsr9Kaq6EZsuRFWP3zs7sgrxnUDLzfcx_w@mail.gmail.com>
 <20200909092646.GA438822@phenom.ffwll.local> <CAKMK7uHzES32APTafwYjWc=-hswGe3q7Re4Rw354hKwA+mb0zg@mail.gmail.com>
In-Reply-To: <CAKMK7uHzES32APTafwYjWc=-hswGe3q7Re4Rw354hKwA+mb0zg@mail.gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed, 9 Sep 2020 17:28:04 -0700
Message-ID: <CAAfnVBkbmxB7jdE3W2x3fjsiQYvJ1nimPNsk7qZnJKQJB7JrKw@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2 04/23] virtio: Add get_shm_region method
Content-Type: multipart/alternative; boundary="000000000000eb9e8405aeeaa4e2"
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, ML dri-devel <dri-devel@lists.freedesktop.org>, virtio-dev@lists.oasis-open.org, Sebastien Boeuf <sebastien.boeuf@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000eb9e8405aeeaa4e2
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 9, 2020 at 2:28 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:

> On Wed, Sep 9, 2020 at 11:27 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Wed, Sep 09, 2020 at 09:13:11AM +0200, Miklos Szeredi wrote:
> > > On Wed, Sep 9, 2020 at 9:04 AM Gerd Hoffmann <kraxel@redhat.com>
> wrote:
> > > >
> > > > On Wed, Sep 02, 2020 at 05:00:25PM -0700, Gurchetan Singh wrote:
> > > > > On Wed, Sep 2, 2020 at 3:15 PM Vivek Goyal <vgoyal@redhat.com>
> wrote:
> > > > >
> > > > > > Hi Gurchetan,
> > > > > >
> > > > > > Now Miklos has queued, these tree virtio patches for shared
> memory
> > > > > > region in his tree as part of virtiofs dax patch series.
> > > > > >
> > > > > > I am hoping this will get merged in 5.10 through his tree.
> > > > > >
> > > > > >
> > > > > >
> https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/log/?h=dax
> > > > >
> > > > >
> > > > > Terrific ... !  Maybe we can queue the version Miklos has in
> drm-misc-next
> > > > > to avoid merge conflicts ?!?
> > > >
> > > > I guess it would either be merging the fuse tree into drm-misc-next,
> > > > or cherry-picking the three virtio shm patches from the fuse tree.
> > >
> > > Maybe cleanest if we'd do a separate branch for the virtio patches and
> > > pull that into both the fuse-next and the drm-misc-next trees?
> >
> > +1
> >
> > If the trees are more closely related (e.g. drm and v4l or so) then
> > occasionally we just merge patches into one tree with acks from all the
> > other maintainers. But topic branch for the common bits feels better
> here.
> >
> > Please send the topic pull request to drm-misc maintainers (Maarten,
> > Maxime, Thomas) so they can pull it in.
>

That sounds like an excellent plan !

I will send out blob v3 (incorporating kraxel@'s feedback) once the topic
pull request (it seems Miklos will do this?) for the shm region patches has
been merged into drm-misc-next.


>
> Works better when I add them :-)
> -Daniel
>
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
>

--000000000000eb9e8405aeeaa4e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 2:28 AM Daniel=
 Vetter &lt;<a href=3D"mailto:daniel.vetter@ffwll.ch">daniel.vetter@ffwll.c=
h</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>On Wed, Sep 9, 2020 at 11:27 AM Daniel Vetter &lt;<a href=3D"mailto:daniel=
@ffwll.ch" target=3D"_blank">daniel@ffwll.ch</a>&gt; wrote:<br>
&gt;<br>
&gt; On Wed, Sep 09, 2020 at 09:13:11AM +0200, Miklos Szeredi wrote:<br>
&gt; &gt; On Wed, Sep 9, 2020 at 9:04 AM Gerd Hoffmann &lt;<a href=3D"mailt=
o:kraxel@redhat.com" target=3D"_blank">kraxel@redhat.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Wed, Sep 02, 2020 at 05:00:25PM -0700, Gurchetan Singh wr=
ote:<br>
&gt; &gt; &gt; &gt; On Wed, Sep 2, 2020 at 3:15 PM Vivek Goyal &lt;<a href=
=3D"mailto:vgoyal@redhat.com" target=3D"_blank">vgoyal@redhat.com</a>&gt; w=
rote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Hi Gurchetan,<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Now Miklos has queued, these tree virtio patches f=
or shared memory<br>
&gt; &gt; &gt; &gt; &gt; region in his tree as part of virtiofs dax patch s=
eries.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; I am hoping this will get merged in 5.10 through h=
is tree.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; <a href=3D"https://git.kernel.org/pub/scm/linux/ke=
rnel/git/mszeredi/fuse.git/log/?h=3Ddax" rel=3D"noreferrer" target=3D"_blan=
k">https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/log/?h=
=3Ddax</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Terrific ... !=C2=A0 Maybe we can queue the version Mik=
los has in drm-misc-next<br>
&gt; &gt; &gt; &gt; to avoid merge conflicts ?!?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I guess it would either be merging the fuse tree into drm-mi=
sc-next,<br>
&gt; &gt; &gt; or cherry-picking the three virtio shm patches from the fuse=
 tree.<br>
&gt; &gt;<br>
&gt; &gt; Maybe cleanest if we&#39;d do a separate branch for the virtio pa=
tches and<br>
&gt; &gt; pull that into both the fuse-next and the drm-misc-next trees?<br=
>
&gt;<br>
&gt; +1<br>
&gt;<br>
&gt; If the trees are more closely related (e.g. drm and v4l or so) then<br=
>
&gt; occasionally we just merge patches into one tree with acks from all th=
e<br>
&gt; other maintainers. But topic branch for the common bits feels better h=
ere.<br>
&gt;<br>
&gt; Please send the topic pull request to drm-misc maintainers (Maarten,<b=
r>
&gt; Maxime, Thomas) so they can pull it in.<br></blockquote><div><br></div=
><div><div>That sounds like an excellent plan !</div><div><br></div><div>I =
will send out blob v3 (incorporating kraxel@&#39;s feedback) once the topic=
 pull request (it seems Miklos will do this?) for the shm region patches ha=
s been merged into drm-misc-next.</div></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
Works better when I add them :-)<br>
-Daniel<br>
<br>
&gt; --<br>
&gt; Daniel Vetter<br>
&gt; Software Engineer, Intel Corporation<br>
&gt; <a href=3D"http://blog.ffwll.ch" rel=3D"noreferrer" target=3D"_blank">=
http://blog.ffwll.ch</a><br>
<br>
<br>
<br>
-- <br>
Daniel Vetter<br>
Software Engineer, Intel Corporation<br>
<a href=3D"http://blog.ffwll.ch" rel=3D"noreferrer" target=3D"_blank">http:=
//blog.ffwll.ch</a><br>
</blockquote></div></div>

--000000000000eb9e8405aeeaa4e2--

