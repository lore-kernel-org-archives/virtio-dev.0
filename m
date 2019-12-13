Return-Path: virtio-dev-return-6514-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 86A82985FC8
	for <virtio-dev@lists.oasis-open.org>; Fri, 13 Dec 2019 14:58:24 +0000 (UTC)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <9280087.Px4QY1m31c@os-lin-dmo>
Date: Fri, 13 Dec 2019 15:58:04 +0100
Message-Id: <E9EAC077-6966-4A1D-9731-AFC831C089A2@redhat.com>
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com>
 <CAD90VcbYAhk9CiagSEi=ouNMioR4v71uc40rRHGMe_+wvAm+0g@mail.gmail.com>
 <20191204091620.zpnd7jttkpkduort@sirius.home.kraxel.org>
 <9280087.Px4QY1m31c@os-lin-dmo>
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device
 specification
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
To: spice-devel@lists.freedesktop.org, Frediano Ziglio <fziglio@redhat.com>, Uri Lublin <uril@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>, Keiichi Watanabe <keiichiw@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>, =?utf-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

+spice-devel for awareness

Context: there is a lot of work there on video streaming for SPICE, mostly
done ATM through proprietary APIs.

> On 9 Dec 2019, at 15:19, Dmitry Sepp <dmitry.sepp@opensynergy.com> wrote:
>=20
> Hello,
>=20
> I'd like to invite everyone to share ideas regarding required encoder fea=
tures=20
> in this separate sub-tree.
>=20
> In general, encoder devices are more complex compared to decoders. So the=
=20
> question I'd like to rise is in what way we define the minimal subset of=
=20
> features to be implemented by the virtio-video.
>=20
> We may look at the following to define the set of features:
> 1. USB video, 2.3.6 Encoding Unit [1].
> 2. Android 10 Compatibility Definition [2].
>=20
> Would be nice to hear about any specific requirements from the Chromium t=
eam as=20
> well.
>=20
> [1] https://www.usb.org/sites/default/files/USB_Video_Class_1_5.zip
> [2] https://source.android.com/compatibility/android-cdd#5_2_video_encodi=
ng
>=20
> Thank you.
>=20
> Best regards,
> Dmitry.
>=20
> On Mittwoch, 4. Dezember 2019 10:16:20 CET Gerd Hoffmann wrote:
>>  Hi,
>>=20
>>> 1. Focus on only decoder/encoder functionalities first.
>>>=20
>>> As Tomasz said earlier in this thread, it'd be too complicated to suppo=
rt
>>> camera usage at the same time. So, I'd suggest to make it just a generi=
c
>>> mem-to-mem video processing device protocol for now.
>>> If we finally decide to support camera in this protocol, we can add it
>>> later.
>> Agree.
>>=20
>>> 2. Only one feature bit can be specified for one device.
>>>=20
>>> I'd like to have a decoder device and encoder device separately.
>>> It'd be natural to assume it because a decoder and an encoder are provi=
ded
>>> as different hardware.
>>=20
>> Hmm, modern GPUs support both encoding and decoding ...
>>=20
>> I don't think we should bake that restriction into the specification.
>> It probably makes sense to use one virtqueue per function though, that
>> will simplify dispatching in both host and guest.
>>=20
>>> 3. Separate buffer allocation functionalities from virtio-video protoco=
l.
>>>=20
>>> To support various ways of guest/host buffer sharing, we might want to
>>> have a dedicated buffer sharing device as we're discussing in another
>>> thread. Until we reach consensus there, it'd be good not to have buffer
>>> allocation
>>> functionalities in virtio-video.
>>=20
>> I think virtio-video should be able to work as stand-alone device,
>> so we need some way to allocate buffers ...
>>=20
>> Buffer sharing with other devices can be added later.
>>=20
>>>> +The virtio video device is a virtual video streaming device that
>>>> supports the +following functions: encoder, decoder, capture, output.
>>>> +
>>>> +\subsection{Device ID}\label{sec:Device Types / Video Device / Device
>>>> ID}
>>>> +
>>>> +TBD.
>>>=20
>>> I'm wondering how and when we can determine and reserve this ID?
>>=20
>> Grab the next free, update the spec accordingly, submit the one-line
>> patch.
>>=20
>>>> +\begin{lstlisting}
>>>> +enum virtio_video_pixel_format {
>>>> +       VIRTIO_VIDEO_PIX_FMT_UNDEFINED =3D 0,
>>>> +
>>>> +       VIRTIO_VIDEO_PIX_FMT_H264 =3D 0x0100,
>>>> +       VIRTIO_VIDEO_PIX_FMT_NV12,
>>>> +       VIRTIO_VIDEO_PIX_FMT_NV21,
>>>> +       VIRTIO_VIDEO_PIX_FMT_I420,
>>>> +       VIRTIO_VIDEO_PIX_FMT_I422,
>>>> +       VIRTIO_VIDEO_PIX_FMT_XBGR,
>>>> +};
>>>=20
>>> I'm wondering if we can use FOURCC instead. So, we can avoid reinventin=
g a
>>> mapping from formats to integers.
>>> Also, I suppose the word "pixel formats" means only raw (decoded) forma=
ts.
>>> But, it can be encoded format like H.264. So, I guess "image format" or
>>> "fourcc" is a better word choice.
>>=20
>> Use separate pixel_format (fourcc) and stream_format (H.264 etc.) enums?
>>=20
>>>> +\begin{lstlisting}
>>>> +struct virtio_video_function {
>>>> +       struct virtio_video_desc desc;
>>>> +       __le32 function_type; /* One of VIRTIO_VIDEO_FUNC_* types */
>>>> +       __le32 function_id;
>>>> +       struct virtio_video_params in_params;
>>>> +       struct virtio_video_params out_params;
>>>> +       __le32 num_caps;
>>>> +       __u8 padding[4];
>>>> +       /* Followed by struct virtio_video_capability video_caps[]; */
>>>> +};
>>>> +\end{lstlisting}
>>>=20
>>> If one device only has one functionality, virtio_video_function's field=
s
>>> will be no longer needed except in_params and out_params. So, we'd be
>>> able to remove virtio_video_function and have in_params and out_params =
in
>>> virtio_video_capability instead.
>>=20
>> Same goes for per-function virtqueues (used virtqueue implies function).
>>=20
>>>> +\begin{lstlisting}
>>>> +struct virtio_video_resource_detach_backing {
>>>> +       struct virtio_video_ctrl_hdr hdr;
>>>> +       __le32 resource_id;
>>>> +       __u8 padding[4];
>>>> +};
>>>> +\end{lstlisting}
>>>> +
>>>> +\begin{description}
>>>> +\item[\field{resource_id}] internal id of the resource.
>>>> +\end{description}
>>>=20
>>> I suppose that it'd be better not to have the above series of T_RESOURC=
E
>>> controls at least until we reach a conclusion in the thread of
>>> buffer-sharing device. If we end up concluding this type of controls is
>>> the best way, we'll be able to revisit here.
>>=20
>> Well.  For buffer management there are a bunch of options.
>>=20
>> (1) Simply stick the buffers (well, pointers to the buffer pages) into
>>     the virtqueue.  This is the standard virtio way.
>>=20
>> (2) Create resources, then put the resource ids into the virtqueue.
>>     virtio-gpu uses that model.  First, because virtio-gpu needs an id
>>     to reference resources in the rendering command stream
>>     (virtio-video doesn't need this).  Also because (some kinds of)
>>     resources are around for a long time and the guest-physical ->
>>     host-virtual mapping needs to be done only once that way (which
>>     I think would be the case for virtio-video too because v4l2
>>     re-uses buffers in robin-round fashion).  Drawback is this
>>     assumes shared memory between host and guest (which is the case
>>     in typical use cases but it is not mandated by the virtio spec).
>>=20
>> (3) Import external resources (from virtio-gpu for example).
>>     Out of scope for now, will probably added as optional feature
>>     later.
>>=20
>> I guess long-term we want support either (1)+(3) or (2)+(3).
>>=20
>> cheers,
>>  Gerd
>=20
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

