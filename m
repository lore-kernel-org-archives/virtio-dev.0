Return-Path: virtio-dev-return-6476-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 064CA986097
	for <virtio-dev@lists.oasis-open.org>; Fri,  6 Dec 2019 12:30:33 +0000 (UTC)
MIME-Version: 1.0
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com>
 <CAD90Vcbr7L2KsyDxPeoKPRt6y_ai8xkJ=J0JCGsW6tGZJGH=0A@mail.gmail.com>
 <20191120112929.gvsne7ykvcyw65lu@sirius.home.kraxel.org> <7736193.Whgddqjo8n@os-lin-dmo>
 <CAD90VcbYAhk9CiagSEi=ouNMioR4v71uc40rRHGMe_+wvAm+0g@mail.gmail.com>
 <20191204091620.zpnd7jttkpkduort@sirius.home.kraxel.org> <CAPR809uYEjSGqPA57HiDgTf7MESrXnsCKwvSEQQ8LfMvCJwaaQ@mail.gmail.com>
 <CAD90VcaTWvos-PPrniZn_AfFQrCEkMHNXvhR56ApD8kfdTSG9g@mail.gmail.com> <20191206073205.4f3bbqbyeyxeipsx@sirius.home.kraxel.org>
In-Reply-To: <20191206073205.4f3bbqbyeyxeipsx@sirius.home.kraxel.org>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Fri, 6 Dec 2019 21:30:20 +0900
Message-ID: <CAD90VcY1QgJGYYXTWDFMVshtV0ZnwLjYUzf3uHcDR=FNA2mMEw@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Enrico Granata <egranata@google.com>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, virtio-dev@lists.oasis-open.org, Tomasz Figa <tfiga@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

On Fri, Dec 6, 2019 at 4:32 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > > > > +\subsection{Device ID}\label{sec:Device Types / Video Device /=
 Device ID}
> > > > > > +
> > > > > > +TBD.
> > > > >
> > > > > I'm wondering how and when we can determine and reserve this ID?
> > > >
> > > > Grab the next free, update the spec accordingly, submit the one-lin=
e
> > > > patch.
> >
> > Thanks. I will do so at the next version of the patch.
>
> No.  Submit as separate one-liner patch which does nothing but grabbing
> an ID.

Thanks. I sent https://markmail.org/message/jpjekiq7c4gkp6jt

>
> > > > > I'm wondering if we can use FOURCC instead. So, we can avoid rein=
venting a
> > > > > mapping from formats to integers.
> > > > > Also, I suppose the word "pixel formats" means only raw (decoded)=
 formats.
> > > > > But, it can be encoded format like H.264. So, I guess "image form=
at" or
> > > > > "fourcc" is a better word choice.
> > > >
> > > > Use separate pixel_format (fourcc) and stream_format (H.264 etc.) e=
nums?
> > > >
> >
> > Fourcc is used for both raw and coded formats.
> > I'm not sure if it makes much sense to define different enums for raw
> > and coded formats, as
> > we reuse any other structs for both types of formats.
> >
> > What I'd suggest is like this:
> >
> > #define FOURCC(a,b,c,d) (a | (b << 8) | (c << 16) | (d << 24))
> >
> > enum virtio_video_fourcc {
> >     VIRTIO_VIDEO_FOURCC_UNDEFINED =3D 0,
> >
> >     /* Coded formats */
> >     VIRTIO_VIDEO_FOURCC_H264 =3D FOURCC('H', '2', '6', '4'),
> >     ...
> >
> >     /* Raw formats */
> >     VIRTIO_VIDEO_FOURCC_NV12 =3D FOURCC('N', 'V', '1', '2'),
> >     ...
> > }
>
> Ok, that'll work.
>
> I've linked fourcc to drm fourcc codes in my head, and drm hasn't codes
> for the compressed formats.
>
> When defining things this way we should of course make sure that the raw
> format codes are identical to the ones drm uses.
>

Yes. For Linux, though we have different constants for drm foucc and
video fourcc,
actual values are identical.
(e.g. DRM_FORMAT_NV12 and V4L2_PIX_FMT_NV12)
Then, we will have one more constant representing the same format for virti=
o.

> Is there a formal standard for these codes btw?

RFC2361 defines FOURCCs for several formats, but it's not a formal
standard iiuc.
https://tools.ietf.org/html/rfc2361

>
> > > As an interim solution, this form of "manual resource backing-store
> > > management" could be specified as a feature flag.
> > > Once there is an established solution for buffer sharing, we would
> > > then go ahead and introduce a new feature flag for "works with the
> > > buffer sharing mechanism", as an alternative to this manual mechanism=
.
> > >
> > > wdyt?
> >
> > It'd be a good idea to change buffer management method by a feature fla=
g.
>
> I don't think so.  A device might want support multiple kinds of buffer
> management, most notably both their own buffers and imported buffers.
> Indicating which methods are available can be done with feature flags,
> but actually picking one not.
>

Ah, you're right. Then, we might want to extend SET_PARAM or add a new cont=
rol
to specify a way of buffer management.

> > > > Well.  For buffer management there are a bunch of options.
> > > >
> > > >  (1) Simply stick the buffers (well, pointers to the buffer pages) =
into
> > > >      the virtqueue.  This is the standard virtio way.
> > > >
> > > >  (2) Create resources, then put the resource ids into the virtqueue=
.
> > > >      virtio-gpu uses that model.  First, because virtio-gpu needs a=
n id
> > > >      to reference resources in the rendering command stream
> > > >      (virtio-video doesn't need this).  Also because (some kinds of=
)
> > > >      resources are around for a long time and the guest-physical ->
> > > >      host-virtual mapping needs to be done only once that way (whic=
h
> > > >      I think would be the case for virtio-video too because v4l2
> > > >      re-uses buffers in robin-round fashion).  Drawback is this
> > > >      assumes shared memory between host and guest (which is the cas=
e
> > > >      in typical use cases but it is not mandated by the virtio spec=
).
> > > >
> > > >  (3) Import external resources (from virtio-gpu for example).
> > > >      Out of scope for now, will probably added as optional feature
> > > >      later.
> > > >
> > > > I guess long-term we want support either (1)+(3) or (2)+(3).
> > > >
> >
> > In the first version of spec, we might want to support the minimal work=
able set
> > of controls. Then, we'll be able to add additional controls with a new =
feature
> > flag as Enrico suggested.
> >
> > So, the problem is what's the simplest scenario and which types of cont=
rols are
> > required there. I guess it's enough for (1) and (2) if we have T_RESOUR=
CE_CREATE
> > and T_RESOURCE_DESTROY.
>
> For (1) you'll simply do a QUEUE_BUFFER.  The command carries references
> to the buffer pages.  No resource management needed.
>
> For (2) you'll have RESOURCE_CREATE + RESOURCE_DESTROY + QUEUE_RESOURCE,
> where RESOURCE_CREATE passes the scatter list of buffer pages to the
> host and QUEUE_RESOURCE will carry just the resource id.
>
> For (3) you'll have RESOURCE_IMPORT + RESOURCE_DESTROY + QUEUE_RESOURCE.
>

Thanks for the clarification.
On second thought, however, I'm wondering if we should keep all
RESOURCE controls.
This should be an option (4).
Even though (1) and (2) may be simpler, nobody wants to implement it so far=
.
Then, (4) would be the only scenario which virtio-video can work as a
stand alone and we have users of.

As a result, the initial version or virtio-video will
* keep 6 RESOURCE commands as this patch originally proposed,
* add a feature flag to show supported buffer management method, and
* add a field to specify buffer management method in
virtio_video_params, but only one method is defined.

WDYT?

Best regards,
Keiichi


Best regards,
Keiichi

> cheers,
>   Gerd
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

