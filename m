Return-Path: virtio-dev-return-6484-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ECFF7985B2F
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Dec 2019 21:12:41 +0000 (UTC)
MIME-Version: 1.0
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com>
 <CAD90VcbYAhk9CiagSEi=ouNMioR4v71uc40rRHGMe_+wvAm+0g@mail.gmail.com>
 <20191204091620.zpnd7jttkpkduort@sirius.home.kraxel.org> <9280087.Px4QY1m31c@os-lin-dmo>
In-Reply-To: <9280087.Px4QY1m31c@os-lin-dmo>
From: Enrico Granata <egranata@google.com>
Date: Mon, 9 Dec 2019 13:12:28 -0800
Message-ID: <CAPR809t2X3eEZj14Y-0CdnmzGZFhWKt2vwFSZBrEZbChQpmU_w@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device specification
Content-Type: multipart/alternative; boundary="0000000000000ade9f05994bdb9f"
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>, Changyeon Jo <changyeon@google.com>
Cc: virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>, Keiichi Watanabe <keiichiw@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

--0000000000000ade9f05994bdb9f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

+Changyeon Jo <changyeon@google.com> for his awareness

Thanks,
- Enrico


On Mon, Dec 9, 2019 at 6:20 AM Dmitry Sepp <dmitry.sepp@opensynergy.com>
wrote:

> Hello,
>
> I'd like to invite everyone to share ideas regarding required encoder
> features
> in this separate sub-tree.
>
> In general, encoder devices are more complex compared to decoders. So the
> question I'd like to rise is in what way we define the minimal subset of
> features to be implemented by the virtio-video.
>
> We may look at the following to define the set of features:
> 1. USB video, 2.3.6 Encoding Unit [1].
> 2. Android 10 Compatibility Definition [2].
>
> Would be nice to hear about any specific requirements from the Chromium
> team as
> well.
>
> [1] https://www.usb.org/sites/default/files/USB_Video_Class_1_5.zip
> [2]
> https://source.android.com/compatibility/android-cdd#5_2_video_encoding
>
> Thank you.
>
> Best regards,
> Dmitry.
>
> On Mittwoch, 4. Dezember 2019 10:16:20 CET Gerd Hoffmann wrote:
> >   Hi,
> >
> > > 1. Focus on only decoder/encoder functionalities first.
> > >
> > > As Tomasz said earlier in this thread, it'd be too complicated to
> support
> > > camera usage at the same time. So, I'd suggest to make it just a
> generic
> > > mem-to-mem video processing device protocol for now.
> > > If we finally decide to support camera in this protocol, we can add i=
t
> > > later.
> > Agree.
> >
> > > 2. Only one feature bit can be specified for one device.
> > >
> > > I'd like to have a decoder device and encoder device separately.
> > > It'd be natural to assume it because a decoder and an encoder are
> provided
> > > as different hardware.
> >
> > Hmm, modern GPUs support both encoding and decoding ...
> >
> > I don't think we should bake that restriction into the specification.
> > It probably makes sense to use one virtqueue per function though, that
> > will simplify dispatching in both host and guest.
> >
> > > 3. Separate buffer allocation functionalities from virtio-video
> protocol.
> > >
> > > To support various ways of guest/host buffer sharing, we might want t=
o
> > > have a dedicated buffer sharing device as we're discussing in another
> > > thread. Until we reach consensus there, it'd be good not to have buff=
er
> > > allocation
> > > functionalities in virtio-video.
> >
> > I think virtio-video should be able to work as stand-alone device,
> > so we need some way to allocate buffers ...
> >
> > Buffer sharing with other devices can be added later.
> >
> > > > +The virtio video device is a virtual video streaming device that
> > > > supports the +following functions: encoder, decoder, capture, outpu=
t.
> > > > +
> > > > +\subsection{Device ID}\label{sec:Device Types / Video Device /
> Device
> > > > ID}
> > > > +
> > > > +TBD.
> > >
> > > I'm wondering how and when we can determine and reserve this ID?
> >
> > Grab the next free, update the spec accordingly, submit the one-line
> > patch.
> >
> > > > +\begin{lstlisting}
> > > > +enum virtio_video_pixel_format {
> > > > +       VIRTIO_VIDEO_PIX_FMT_UNDEFINED =3D 0,
> > > > +
> > > > +       VIRTIO_VIDEO_PIX_FMT_H264 =3D 0x0100,
> > > > +       VIRTIO_VIDEO_PIX_FMT_NV12,
> > > > +       VIRTIO_VIDEO_PIX_FMT_NV21,
> > > > +       VIRTIO_VIDEO_PIX_FMT_I420,
> > > > +       VIRTIO_VIDEO_PIX_FMT_I422,
> > > > +       VIRTIO_VIDEO_PIX_FMT_XBGR,
> > > > +};
> > >
> > > I'm wondering if we can use FOURCC instead. So, we can avoid
> reinventing a
> > > mapping from formats to integers.
> > > Also, I suppose the word "pixel formats" means only raw (decoded)
> formats.
> > > But, it can be encoded format like H.264. So, I guess "image format" =
or
> > > "fourcc" is a better word choice.
> >
> > Use separate pixel_format (fourcc) and stream_format (H.264 etc.) enums=
?
> >
> > > > +\begin{lstlisting}
> > > > +struct virtio_video_function {
> > > > +       struct virtio_video_desc desc;
> > > > +       __le32 function_type; /* One of VIRTIO_VIDEO_FUNC_* types *=
/
> > > > +       __le32 function_id;
> > > > +       struct virtio_video_params in_params;
> > > > +       struct virtio_video_params out_params;
> > > > +       __le32 num_caps;
> > > > +       __u8 padding[4];
> > > > +       /* Followed by struct virtio_video_capability video_caps[];
> */
> > > > +};
> > > > +\end{lstlisting}
> > >
> > > If one device only has one functionality, virtio_video_function's
> fields
> > > will be no longer needed except in_params and out_params. So, we'd be
> > > able to remove virtio_video_function and have in_params and out_param=
s
> in
> > > virtio_video_capability instead.
> >
> > Same goes for per-function virtqueues (used virtqueue implies function)=
.
> >
> > > > +\begin{lstlisting}
> > > > +struct virtio_video_resource_detach_backing {
> > > > +       struct virtio_video_ctrl_hdr hdr;
> > > > +       __le32 resource_id;
> > > > +       __u8 padding[4];
> > > > +};
> > > > +\end{lstlisting}
> > > > +
> > > > +\begin{description}
> > > > +\item[\field{resource_id}] internal id of the resource.
> > > > +\end{description}
> > >
> > > I suppose that it'd be better not to have the above series of
> T_RESOURCE
> > > controls at least until we reach a conclusion in the thread of
> > > buffer-sharing device. If we end up concluding this type of controls =
is
> > > the best way, we'll be able to revisit here.
> >
> > Well.  For buffer management there are a bunch of options.
> >
> >  (1) Simply stick the buffers (well, pointers to the buffer pages) into
> >      the virtqueue.  This is the standard virtio way.
> >
> >  (2) Create resources, then put the resource ids into the virtqueue.
> >      virtio-gpu uses that model.  First, because virtio-gpu needs an id
> >      to reference resources in the rendering command stream
> >      (virtio-video doesn't need this).  Also because (some kinds of)
> >      resources are around for a long time and the guest-physical ->
> >      host-virtual mapping needs to be done only once that way (which
> >      I think would be the case for virtio-video too because v4l2
> >      re-uses buffers in robin-round fashion).  Drawback is this
> >      assumes shared memory between host and guest (which is the case
> >      in typical use cases but it is not mandated by the virtio spec).
> >
> >  (3) Import external resources (from virtio-gpu for example).
> >      Out of scope for now, will probably added as optional feature
> >      later.
> >
> > I guess long-term we want support either (1)+(3) or (2)+(3).
> >
> > cheers,
> >   Gerd
>
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
>

--0000000000000ade9f05994bdb9f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><a class=3D"gmail_plusreply" id=3D"plusReplyChip-3" h=
ref=3D"mailto:changyeon@google.com" tabindex=3D"-1">+Changyeon Jo</a>=C2=A0=
for his awareness<br></div><br clear=3D"all"><div><div dir=3D"ltr" class=3D=
"gmail_signature" data-smartmail=3D"gmail_signature">Thanks,<br>- Enrico</d=
iv></div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Mon, Dec 9, 2019 at 6:20 AM Dmitry Sepp &lt;<a href=3D"mail=
to:dmitry.sepp@opensynergy.com">dmitry.sepp@opensynergy.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello,<br>
<br>
I&#39;d like to invite everyone to share ideas regarding required encoder f=
eatures <br>
in this separate sub-tree.<br>
<br>
In general, encoder devices are more complex compared to decoders. So the <=
br>
question I&#39;d like to rise is in what way we define the minimal subset o=
f <br>
features to be implemented by the virtio-video.<br>
<br>
We may look at the following to define the set of features:<br>
1. USB video, 2.3.6 Encoding Unit [1].<br>
2. Android 10 Compatibility Definition [2].<br>
<br>
Would be nice to hear about any specific requirements from the Chromium tea=
m as <br>
well.<br>
<br>
[1] <a href=3D"https://www.usb.org/sites/default/files/USB_Video_Class_1_5.=
zip" rel=3D"noreferrer" target=3D"_blank">https://www.usb.org/sites/default=
/files/USB_Video_Class_1_5.zip</a><br>
[2] <a href=3D"https://source.android.com/compatibility/android-cdd#5_2_vid=
eo_encoding" rel=3D"noreferrer" target=3D"_blank">https://source.android.co=
m/compatibility/android-cdd#5_2_video_encoding</a><br>
<br>
Thank you.<br>
<br>
Best regards,<br>
Dmitry.<br>
<br>
On Mittwoch, 4. Dezember 2019 10:16:20 CET Gerd Hoffmann wrote:<br>
&gt;=C2=A0 =C2=A0Hi,<br>
&gt; <br>
&gt; &gt; 1. Focus on only decoder/encoder functionalities first.<br>
&gt; &gt; <br>
&gt; &gt; As Tomasz said earlier in this thread, it&#39;d be too complicate=
d to support<br>
&gt; &gt; camera usage at the same time. So, I&#39;d suggest to make it jus=
t a generic<br>
&gt; &gt; mem-to-mem video processing device protocol for now.<br>
&gt; &gt; If we finally decide to support camera in this protocol, we can a=
dd it<br>
&gt; &gt; later.<br>
&gt; Agree.<br>
&gt; <br>
&gt; &gt; 2. Only one feature bit can be specified for one device.<br>
&gt; &gt; <br>
&gt; &gt; I&#39;d like to have a decoder device and encoder device separate=
ly.<br>
&gt; &gt; It&#39;d be natural to assume it because a decoder and an encoder=
 are provided<br>
&gt; &gt; as different hardware.<br>
&gt; <br>
&gt; Hmm, modern GPUs support both encoding and decoding ...<br>
&gt; <br>
&gt; I don&#39;t think we should bake that restriction into the specificati=
on.<br>
&gt; It probably makes sense to use one virtqueue per function though, that=
<br>
&gt; will simplify dispatching in both host and guest.<br>
&gt; <br>
&gt; &gt; 3. Separate buffer allocation functionalities from virtio-video p=
rotocol.<br>
&gt; &gt; <br>
&gt; &gt; To support various ways of guest/host buffer sharing, we might wa=
nt to<br>
&gt; &gt; have a dedicated buffer sharing device as we&#39;re discussing in=
 another<br>
&gt; &gt; thread. Until we reach consensus there, it&#39;d be good not to h=
ave buffer<br>
&gt; &gt; allocation<br>
&gt; &gt; functionalities in virtio-video.<br>
&gt; <br>
&gt; I think virtio-video should be able to work as stand-alone device,<br>
&gt; so we need some way to allocate buffers ...<br>
&gt; <br>
&gt; Buffer sharing with other devices can be added later.<br>
&gt; <br>
&gt; &gt; &gt; +The virtio video device is a virtual video streaming device=
 that<br>
&gt; &gt; &gt; supports the +following functions: encoder, decoder, capture=
, output.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\subsection{Device ID}\label{sec:Device Types / Video Devic=
e / Device<br>
&gt; &gt; &gt; ID}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +TBD.<br>
&gt; &gt; <br>
&gt; &gt; I&#39;m wondering how and when we can determine and reserve this =
ID?<br>
&gt; <br>
&gt; Grab the next free, update the spec accordingly, submit the one-line<b=
r>
&gt; patch.<br>
&gt; <br>
&gt; &gt; &gt; +\begin{lstlisting}<br>
&gt; &gt; &gt; +enum virtio_video_pixel_format {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_PIX_FMT_UNDEFINED =
=3D 0,<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_PIX_FMT_H264 =3D 0x=
0100,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_PIX_FMT_NV12,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_PIX_FMT_NV21,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_PIX_FMT_I420,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_PIX_FMT_I422,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_PIX_FMT_XBGR,<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; <br>
&gt; &gt; I&#39;m wondering if we can use FOURCC instead. So, we can avoid =
reinventing a<br>
&gt; &gt; mapping from formats to integers.<br>
&gt; &gt; Also, I suppose the word &quot;pixel formats&quot; means only raw=
 (decoded) formats.<br>
&gt; &gt; But, it can be encoded format like H.264. So, I guess &quot;image=
 format&quot; or<br>
&gt; &gt; &quot;fourcc&quot; is a better word choice.<br>
&gt; <br>
&gt; Use separate pixel_format (fourcc) and stream_format (H.264 etc.) enum=
s?<br>
&gt; <br>
&gt; &gt; &gt; +\begin{lstlisting}<br>
&gt; &gt; &gt; +struct virtio_video_function {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_video_desc desc;<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 function_type; /* One of =
VIRTIO_VIDEO_FUNC_* types */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 function_id;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_video_params in_pa=
rams;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_video_params out_p=
arams;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 num_caps;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 padding[4];<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Followed by struct virtio_vid=
eo_capability video_caps[]; */<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +\end{lstlisting}<br>
&gt; &gt; <br>
&gt; &gt; If one device only has one functionality, virtio_video_function&#=
39;s fields<br>
&gt; &gt; will be no longer needed except in_params and out_params. So, we&=
#39;d be<br>
&gt; &gt; able to remove virtio_video_function and have in_params and out_p=
arams in<br>
&gt; &gt; virtio_video_capability instead.<br>
&gt; <br>
&gt; Same goes for per-function virtqueues (used virtqueue implies function=
).<br>
&gt; <br>
&gt; &gt; &gt; +\begin{lstlisting}<br>
&gt; &gt; &gt; +struct virtio_video_resource_detach_backing {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_video_ctrl_hdr hdr=
;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 resource_id;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 padding[4];<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +\end{lstlisting}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\begin{description}<br>
&gt; &gt; &gt; +\item[\field{resource_id}] internal id of the resource.<br>
&gt; &gt; &gt; +\end{description}<br>
&gt; &gt; <br>
&gt; &gt; I suppose that it&#39;d be better not to have the above series of=
 T_RESOURCE<br>
&gt; &gt; controls at least until we reach a conclusion in the thread of<br=
>
&gt; &gt; buffer-sharing device. If we end up concluding this type of contr=
ols is<br>
&gt; &gt; the best way, we&#39;ll be able to revisit here.<br>
&gt; <br>
&gt; Well.=C2=A0 For buffer management there are a bunch of options.<br>
&gt; <br>
&gt;=C2=A0 (1) Simply stick the buffers (well, pointers to the buffer pages=
) into<br>
&gt;=C2=A0 =C2=A0 =C2=A0 the virtqueue.=C2=A0 This is the standard virtio w=
ay.<br>
&gt; <br>
&gt;=C2=A0 (2) Create resources, then put the resource ids into the virtque=
ue.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 virtio-gpu uses that model.=C2=A0 First, because v=
irtio-gpu needs an id<br>
&gt;=C2=A0 =C2=A0 =C2=A0 to reference resources in the rendering command st=
ream<br>
&gt;=C2=A0 =C2=A0 =C2=A0 (virtio-video doesn&#39;t need this).=C2=A0 Also b=
ecause (some kinds of)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 resources are around for a long time and the guest=
-physical -&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 host-virtual mapping needs to be done only once th=
at way (which<br>
&gt;=C2=A0 =C2=A0 =C2=A0 I think would be the case for virtio-video too bec=
ause v4l2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 re-uses buffers in robin-round fashion).=C2=A0 Dra=
wback is this<br>
&gt;=C2=A0 =C2=A0 =C2=A0 assumes shared memory between host and guest (whic=
h is the case<br>
&gt;=C2=A0 =C2=A0 =C2=A0 in typical use cases but it is not mandated by the=
 virtio spec).<br>
&gt; <br>
&gt;=C2=A0 (3) Import external resources (from virtio-gpu for example).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Out of scope for now, will probably added as optio=
nal feature<br>
&gt;=C2=A0 =C2=A0 =C2=A0 later.<br>
&gt; <br>
&gt; I guess long-term we want support either (1)+(3) or (2)+(3).<br>
&gt; <br>
&gt; cheers,<br>
&gt;=C2=A0 =C2=A0Gerd<br>
<br>
<br>
<br>
---------------------------------------------------------------------<br>
To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@lists.oasi=
s-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oasis-open.org</=
a><br>
For additional commands, e-mail: <a href=3D"mailto:virtio-dev-help@lists.oa=
sis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.org</a><br=
>
<br>
</blockquote></div>

--0000000000000ade9f05994bdb9f--

