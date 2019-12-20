Return-Path: virtio-dev-return-6559-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C4D3D985F5C
	for <virtio-dev@lists.oasis-open.org>; Fri, 20 Dec 2019 15:01:41 +0000 (UTC)
MIME-Version: 1.0
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com>
 <CAD90VcY_CUVNpq6w06HPRknHtT+WhT3gPnaLtMe2yHS1dCHMzQ@mail.gmail.com>
 <CAD90VcaCWUmXBkkrGdH=-BJKmoXRKGxa+NK7x9qz1K28h5cLJw@mail.gmail.com> <6979954.MWBlvXQWzh@os-lin-dmo>
In-Reply-To: <6979954.MWBlvXQWzh@os-lin-dmo>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Sat, 21 Dec 2019 00:01:27 +0900
Message-ID: <CAD90VcZg49E+eZ5c-6vL1jKKQuJLVxS9vDn3Egn-=9R7AEcwxQ@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: Enrico Granata <egranata@google.com>, Changyeon Jo <changyeon@google.com>, virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>, Tomasz Figa <tfiga@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Dmitry,

On Fri, Dec 20, 2019 at 11:25 PM Dmitry Sepp
<dmitry.sepp@opensynergy.com> wrote:
>
> Hi Keiichi,
>
> Could you please explain in a more detailed way what exactly CROP is used=
 for?
> Is it equivalent to G/S_CROP or G/S_SELECTION in v4l2? Do you only need t=
o get
> it, or to set as well? Can it also be useful for the encoder?

It corresponds to struct v4l2_rect in V4L2, which is used in
G/S_SELECTION. IIUC, G/S_SELECTION is a kind of super set of G/S_CROP.
Both decoder and encoder can utilize both G_SELECTION and S_SELECTION.
Their usages are documented in the specs of V4L2 stateful
decoder/encoder API.

stateful decoder spec:
https://linuxtv.org/downloads/v4l-dvb-apis/uapi/v4l/dev-decoder.html
stateful encoder spec (in maintainer's tree):
https://hverkuil.home.xs4all.nl/codec-api/uapi/v4l/dev-encoder.html

Best regards,
Keiichi

>
> Regrds,
> Dmitry.
>
> On Freitag, 13. Dezember 2019 17:31:24 CET Keiichi Watanabe wrote:
> > On Fri, Dec 13, 2019 at 11:20 PM Keiichi Watanabe <keiichiw@chromium.or=
g>
> wrote:
> > > On Thu, Dec 12, 2019 at 7:34 PM Dmitry Sepp <dmitry.sepp@opensynergy.=
com>
> wrote:
> > > > Hi Keiichi,
> > > >
> > > > Thank you for your comment.
> > > > What do you thing about selection/crop rectangles? Should this be
> > > > defined as a must have? Or we just assume the device always sticks =
to
> > > > the stream resolution.
> > >
> > > For decoding, the device needs to tell the driver crop rectangle when
> > > a resolution change happens, as virtio-vdec has
> > > virtio_vdec_host_req_stream_crop.
> > > So, we should add a new field in virtio_video_param for it.
> > >
> > > For what it's worth, we have C-headers that exposes Chrome's video
> > > codec functionalities. So, our virtio-video device will do
> > > decoding/encoding by calling these functions.
> > > Decoder:
> > > https://chromium.git.corp.google.com/chromiumos/platform2/+/00ad71fa6=
40c0
> > > 18c1d014f467c50b9a7dc962a10/arc/vm/libvda/libvda_decode.h Encoder:
> > > https://chromium.git.corp.google.com/chromiumos/platform2/+/00ad71fa6=
40c0
> > > 18c1d014f467c50b9a7dc962a10/arc/vm/libvda/libvda_encode.h
> > Oops, the links were not accesible...
> > The correct links are:
> > Decoder:
> > https://chromium.googlesource.com/chromiumos/platform2/+/00ad71fa640c01=
8c1d
> > 014f467c50b9a7dc962a10/arc/vm/libvda/libvda_decode.h Encoder:
> > https://chromium.googlesource.com/chromiumos/platform2/+/00ad71fa640c01=
8c1d
> > 014f467c50b9a7dc962a10/arc/vm/libvda/libvda_encode.h
> >
> > Best,
> > Keiichi
> >
> > > BTW, I'm preparing the next version of virtio-video spec by addressin=
g
> > > points we discussed in this thread. I'll send it here next week,
> > > hopefully.
> > >
> > > Best,
> > > Keiichi
> > >
> > > > Regards,
> > > > Dmitry.
> > > >
> > > > On Donnerstag, 12. Dezember 2019 06:39:11 CET Keiichi Watanabe wrot=
e:
> > > > > On Tue, Dec 10, 2019 at 10:16 PM Dmitry Sepp
> > > > >
> > > > > <dmitry.sepp@opensynergy.com> wrote:
> > > > > > Hi,
> > > > > >
> > > > > > Just to start, let's consider this v4l2 control:
> > > > > > V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE.
> > > > > > As I can see, this control is referenced as a mandatory one in =
the
> > > > > > Chromium
> > > > > > sources [1].
> > > > > >
> > > > > > So could someone from the Chromium team please explain why it i=
s
> > > > > > mandatory?
> > > > > > (YouTube?) In fact, almost no encoders implement this control. =
Do we
> > > > > > need
> > > > > > it in virtio-video?
> > > > >
> > > > > That control is used to encode videos in constant bitrate (CBR) m=
ode,
> > > > > which is critical for
> > > > > real-time use case like video conferencing.
> > > > >
> > > > > However, that Chromium source code just requires *host-side* driv=
ers
> > > > > to have the v4l2
> > > > > control. Also, I guess it's rare that a guest app wants to use CQ=
P
> > > > > instead of CBR from our
> > > > > experience.
> > > > > So, I suppose we can omit this control in virtio spec for now by
> > > > > assuming that guests
> > > > > always use CBR mode.
> > > > >
> > > > > Best regards,
> > > > > Keiichi
> > > > >
> > > > > > [1]
> > > > > > https://chromium.googlesource.com/chromium/src/media/+/refs/hea=
ds/ma
> > > > > > ster/
> > > > > > gpu/v4l2/v4l2_video_encode_accelerator.cc#1500
> > > > > >
> > > > > > Regards,
> > > > > > Dmitry.
> > > > > >
> > > > > > On Montag, 9. Dezember 2019 22:12:28 CET Enrico Granata wrote:
> > > > > > > +Changyeon Jo <changyeon@google.com> for his awareness
> > > > > > >
> > > > > > > Thanks,
> > > > > > > - Enrico
> > > > > > >
> > > > > > >
> > > > > > > On Mon, Dec 9, 2019 at 6:20 AM Dmitry Sepp
> > > > > > > <dmitry.sepp@opensynergy.com>
> > > > > > >
> > > > > > > wrote:
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > I'd like to invite everyone to share ideas regarding requir=
ed
> > > > > > > > encoder
> > > > > > > > features
> > > > > > > > in this separate sub-tree.
> > > > > > > >
> > > > > > > > In general, encoder devices are more complex compared to
> > > > > > > > decoders. So
> > > > > > > > the
> > > > > > > > question I'd like to rise is in what way we define the mini=
mal
> > > > > > > > subset
> > > > > > > > of
> > > > > > > > features to be implemented by the virtio-video.
> > > > > > > >
> > > > > > > > We may look at the following to define the set of features:
> > > > > > > > 1. USB video, 2.3.6 Encoding Unit [1].
> > > > > > > > 2. Android 10 Compatibility Definition [2].
> > > > > > > >
> > > > > > > > Would be nice to hear about any specific requirements from =
the
> > > > > > > > Chromium
> > > > > > > > team as
> > > > > > > > well.
> > > > > > > >
> > > > > > > > [1]
> > > > > > > > https://www.usb.org/sites/default/files/USB_Video_Class_1_5=
.zip
> > > > > > > > [2]
> > > > > > > > https://source.android.com/compatibility/android-cdd#5_2_vi=
deo_e
> > > > > > > > ncodin
> > > > > > > > g
> > > > > > > >
> > > > > > > > Thank you.
> > > > > > > >
> > > > > > > > Best regards,
> > > > > > > > Dmitry.
> > > > > > > >
> > > > > > > > On Mittwoch, 4. Dezember 2019 10:16:20 CET Gerd Hoffmann wr=
ote:
> > > > > > > > >   Hi,
> > > > > > > > >
> > > > > > > > > > 1. Focus on only decoder/encoder functionalities first.
> > > > > > > > > >
> > > > > > > > > > As Tomasz said earlier in this thread, it'd be too
> > > > > > > > > > complicated to
> > > > > > > >
> > > > > > > > support
> > > > > > > >
> > > > > > > > > > camera usage at the same time. So, I'd suggest to make =
it
> > > > > > > > > > just a
> > > > > > > >
> > > > > > > > generic
> > > > > > > >
> > > > > > > > > > mem-to-mem video processing device protocol for now.
> > > > > > > > > > If we finally decide to support camera in this protocol=
, we
> > > > > > > > > > can
> > > > > > > > > > add it
> > > > > > > > > > later.
> > > > > > > > >
> > > > > > > > > Agree.
> > > > > > > > >
> > > > > > > > > > 2. Only one feature bit can be specified for one device=
.
> > > > > > > > > >
> > > > > > > > > > I'd like to have a decoder device and encoder device
> > > > > > > > > > separately.
> > > > > > > > > > It'd be natural to assume it because a decoder and an
> > > > > > > > > > encoder are
> > > > > > > >
> > > > > > > > provided
> > > > > > > >
> > > > > > > > > > as different hardware.
> > > > > > > > >
> > > > > > > > > Hmm, modern GPUs support both encoding and decoding ...
> > > > > > > > >
> > > > > > > > > I don't think we should bake that restriction into the
> > > > > > > > > specification.
> > > > > > > > > It probably makes sense to use one virtqueue per function
> > > > > > > > > though,
> > > > > > > > > that
> > > > > > > > > will simplify dispatching in both host and guest.
> > > > > > > > >
> > > > > > > > > > 3. Separate buffer allocation functionalities from
> > > > > > > > > > virtio-video
> > > > > > > >
> > > > > > > > protocol.
> > > > > > > >
> > > > > > > > > > To support various ways of guest/host buffer sharing, w=
e
> > > > > > > > > > might
> > > > > > > > > > want to
> > > > > > > > > > have a dedicated buffer sharing device as we're discuss=
ing
> > > > > > > > > > in
> > > > > > > > > > another
> > > > > > > > > > thread. Until we reach consensus there, it'd be good no=
t to
> > > > > > > > > > have
> > > > > > > > > > buffer
> > > > > > > > > > allocation
> > > > > > > > > > functionalities in virtio-video.
> > > > > > > > >
> > > > > > > > > I think virtio-video should be able to work as stand-alon=
e
> > > > > > > > > device,
> > > > > > > > > so we need some way to allocate buffers ...
> > > > > > > > >
> > > > > > > > > Buffer sharing with other devices can be added later.
> > > > > > > > >
> > > > > > > > > > > +The virtio video device is a virtual video streaming
> > > > > > > > > > > device
> > > > > > > > > > > that
> > > > > > > > > > > supports the +following functions: encoder, decoder,
> > > > > > > > > > > capture,
> > > > > > > > > > > output.
> > > > > > > > > > > +
> > > > > > > > > > > +\subsection{Device ID}\label{sec:Device Types / Vide=
o
> > > > > > > > > > > Device /
> > > > > > > >
> > > > > > > > Device
> > > > > > > >
> > > > > > > > > > > ID}
> > > > > > > > > > > +
> > > > > > > > > > > +TBD.
> > > > > > > > > >
> > > > > > > > > > I'm wondering how and when we can determine and reserve=
 this
> > > > > > > > > > ID?
> > > > > > > > >
> > > > > > > > > Grab the next free, update the spec accordingly, submit t=
he
> > > > > > > > > one-line
> > > > > > > > > patch.
> > > > > > > > >
> > > > > > > > > > > +\begin{lstlisting}
> > > > > > > > > > > +enum virtio_video_pixel_format {
> > > > > > > > > > > +       VIRTIO_VIDEO_PIX_FMT_UNDEFINED =3D 0,
> > > > > > > > > > > +
> > > > > > > > > > > +       VIRTIO_VIDEO_PIX_FMT_H264 =3D 0x0100,
> > > > > > > > > > > +       VIRTIO_VIDEO_PIX_FMT_NV12,
> > > > > > > > > > > +       VIRTIO_VIDEO_PIX_FMT_NV21,
> > > > > > > > > > > +       VIRTIO_VIDEO_PIX_FMT_I420,
> > > > > > > > > > > +       VIRTIO_VIDEO_PIX_FMT_I422,
> > > > > > > > > > > +       VIRTIO_VIDEO_PIX_FMT_XBGR,
> > > > > > > > > > > +};
> > > > > > > > > >
> > > > > > > > > > I'm wondering if we can use FOURCC instead. So, we can =
avoid
> > > > > > > >
> > > > > > > > reinventing a
> > > > > > > >
> > > > > > > > > > mapping from formats to integers.
> > > > > > > > > > Also, I suppose the word "pixel formats" means only raw
> > > > > > > > > > (decoded)
> > > > > > > >
> > > > > > > > formats.
> > > > > > > >
> > > > > > > > > > But, it can be encoded format like H.264. So, I guess "=
image
> > > > > > > > > > format"
> > > > > > > > > > or
> > > > > > > > > > "fourcc" is a better word choice.
> > > > > > > > >
> > > > > > > > > Use separate pixel_format (fourcc) and stream_format (H.2=
64
> > > > > > > > > etc.)
> > > > > > > > > enums?
> > > > > > > > >
> > > > > > > > > > > +\begin{lstlisting}
> > > > > > > > > > > +struct virtio_video_function {
> > > > > > > > > > > +       struct virtio_video_desc desc;
> > > > > > > > > > > +       __le32 function_type; /* One of
> > > > > > > > > > > VIRTIO_VIDEO_FUNC_*
> > > > > > > > > > > types */
> > > > > > > > > > > +       __le32 function_id;
> > > > > > > > > > > +       struct virtio_video_params in_params;
> > > > > > > > > > > +       struct virtio_video_params out_params;
> > > > > > > > > > > +       __le32 num_caps;
> > > > > > > > > > > +       __u8 padding[4];
> > > > > > > > > > > +       /* Followed by struct virtio_video_capability
> > > > > > > > > > > video_caps[];
> > > > > > > >
> > > > > > > > */
> > > > > > > >
> > > > > > > > > > > +};
> > > > > > > > > > > +\end{lstlisting}
> > > > > > > > > >
> > > > > > > > > > If one device only has one functionality,
> > > > > > > > > > virtio_video_function's
> > > > > > > >
> > > > > > > > fields
> > > > > > > >
> > > > > > > > > > will be no longer needed except in_params and out_param=
s.
> > > > > > > > > > So, we'd
> > > > > > > > > > be
> > > > > > > > > > able to remove virtio_video_function and have in_params=
 and
> > > > > > > > > > out_params
> > > > > > > >
> > > > > > > > in
> > > > > > > >
> > > > > > > > > > virtio_video_capability instead.
> > > > > > > > >
> > > > > > > > > Same goes for per-function virtqueues (used virtqueue imp=
lies
> > > > > > > > > function).
> > > > > > > > >
> > > > > > > > > > > +\begin{lstlisting}
> > > > > > > > > > > +struct virtio_video_resource_detach_backing {
> > > > > > > > > > > +       struct virtio_video_ctrl_hdr hdr;
> > > > > > > > > > > +       __le32 resource_id;
> > > > > > > > > > > +       __u8 padding[4];
> > > > > > > > > > > +};
> > > > > > > > > > > +\end{lstlisting}
> > > > > > > > > > > +
> > > > > > > > > > > +\begin{description}
> > > > > > > > > > > +\item[\field{resource_id}] internal id of the resour=
ce.
> > > > > > > > > > > +\end{description}
> > > > > > > > > >
> > > > > > > > > > I suppose that it'd be better not to have the above ser=
ies
> > > > > > > > > > of
> > > > > > > >
> > > > > > > > T_RESOURCE
> > > > > > > >
> > > > > > > > > > controls at least until we reach a conclusion in the th=
read
> > > > > > > > > > of
> > > > > > > > > > buffer-sharing device. If we end up concluding this typ=
e of
> > > > > > > > > > controls
> > > > > > > > > > is
> > > > > > > > > > the best way, we'll be able to revisit here.
> > > > > > > > >
> > > > > > > > > Well.  For buffer management there are a bunch of options=
.
> > > > > > > > >
> > > > > > > > >  (1) Simply stick the buffers (well, pointers to the buff=
er
> > > > > > > > >  pages)
> > > > > > > > >  into
> > > > > > > > >
> > > > > > > > >      the virtqueue.  This is the standard virtio way.
> > > > > > > > >
> > > > > > > > >  (2) Create resources, then put the resource ids into the
> > > > > > > > >  virtqueue.
> > > > > > > > >
> > > > > > > > >      virtio-gpu uses that model.  First, because virtio-g=
pu
> > > > > > > > >      needs an
> > > > > > > > >      id
> > > > > > > > >      to reference resources in the rendering command stre=
am
> > > > > > > > >      (virtio-video doesn't need this).  Also because (som=
e
> > > > > > > > >      kinds of)
> > > > > > > > >      resources are around for a long time and the
> > > > > > > > >      guest-physical ->
> > > > > > > > >      host-virtual mapping needs to be done only once that=
 way
> > > > > > > > >      (which
> > > > > > > > >      I think would be the case for virtio-video too becau=
se
> > > > > > > > >      v4l2
> > > > > > > > >      re-uses buffers in robin-round fashion).  Drawback i=
s
> > > > > > > > >      this
> > > > > > > > >      assumes shared memory between host and guest (which =
is
> > > > > > > > >      the case
> > > > > > > > >      in typical use cases but it is not mandated by the v=
irtio
> > > > > > > > >      spec).
> > > > > > > > >
> > > > > > > > >  (3) Import external resources (from virtio-gpu for examp=
le).
> > > > > > > > >
> > > > > > > > >      Out of scope for now, will probably added as optiona=
l
> > > > > > > > >      feature
> > > > > > > > >      later.
> > > > > > > > >
> > > > > > > > > I guess long-term we want support either (1)+(3) or (2)+(=
3).
> > > > > > > > >
> > > > > > > > > cheers,
> > > > > > > > >
> > > > > > > > >   Gerd
> > > > > > > >
> > > > > > > > -----------------------------------------------------------=
-----
> > > > > > > > -----
> > > > > > > > To unsubscribe, e-mail:
> > > > > > > > virtio-dev-unsubscribe@lists.oasis-open.org
> > > > > > > > For additional commands, e-mail:
> > > > > > > > virtio-dev-help@lists.oasis-open.org
>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

