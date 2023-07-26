Return-Path: <virtio-dev-return-13410-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDA6C001B0
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Jul 2023 14:33:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 738E17532B
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Jul 2023 14:33:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1D9179866C8
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Jul 2023 14:33:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E35B59866BD; Wed, 26 Jul 2023 14:33:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C90739866BF
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Jul 2023 14:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 6ILaAUrlNeiC-7bJEcI34g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381977; x=1690986777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SrNmIcwVN0vibQmkztM8vJ7dbgHlVZtWoaK3+whgZfo=;
        b=D2ztpIgFdRG/+0KqTkgs9jZ+qIZISZTyVJadyCXt0uupfG7zF1ivJXeuSmDKOBEibS
         kRO4nrxQGK2jxDsZWgXGWfdAsUN5Sy35OAPmwSl82C8hFqn6kFcac3XIfwyeQQT52mL0
         Qe/r4t5dROQznKNKv74sw9aSfm2gy/Kbb+m4Lk+nSXqL5fawVVdqAIErLakpoJ2dF4E0
         nHBZy8GsnRNR7y+bUJSveCEDX0G+Z3Q8wZfGNBSPpTL5DlwDFsVzeUvX+bb1WdaOE/LK
         S1OZvTxuc5xFSBQM4FDWy5tjhcEVJnU93iLiBh21FlGQPweDVc/DS7zCXiy0amTCFtfP
         wiOQ==
X-Gm-Message-State: ABy/qLblDQ8ySn9a+1ZpSUQIwCrAHo5Nlp5HpHoejvzxwlxzlpkFaEhi
	0oaGImNWuTRyhqtwu7JNvstxCGtoXNNJgcVjF65dAvaRXWl8erlLwVgeza+u0ZFgcAxnYmFS04b
	6xk99DGZsyPBLn6UHx7b4cVvJpnKjJW6E/KPtNXub+qNf
X-Received: by 2002:a17:90b:1d03:b0:267:f86b:813c with SMTP id on3-20020a17090b1d0300b00267f86b813cmr1521342pjb.48.1690381977095;
        Wed, 26 Jul 2023 07:32:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEIEyD5gzoHFi/pYLaNmaRc7vFxv0zwP4hV3f7nmlPcgQuUJ+bm/+SIVRGCyD3ha+6Ia+mvV1NcUht3eb3oXwg=
X-Received: by 2002:a17:90b:1d03:b0:267:f86b:813c with SMTP id
 on3-20020a17090b1d0300b00267f86b813cmr1521319pjb.48.1690381976503; Wed, 26
 Jul 2023 07:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230629144915.597188-1-Alexander.Gordeev@opensynergy.com>
 <20230629144915.597188-2-Alexander.Gordeev@opensynergy.com>
 <CADSE00K7Tc2y58x=6yTV5dXkOdfwm9yO+nkya8B4Jd=y7Gad5w@mail.gmail.com> <363411d2-31d4-e7f9-7e65-534b6ede3d1b@opensynergy.com>
In-Reply-To: <363411d2-31d4-e7f9-7e65-534b6ede3d1b@opensynergy.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 26 Jul 2023 16:32:44 +0200
Message-ID: <CADSE00LjAhSOkM-TwkzAz1_E=z1pDOQ2kiENVXu8TJeQ64SjTw@mail.gmail.com>
To: Alexander Gordeev <alexander.gordeev@opensynergy.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, 
	Alexandre Courbot <acourbot@chromium.org>, alex.bennee@linaro.org, 
	Andrew Gazizov <andrew.gazizov@opensynergy.com>, 
	Andrii Cherniavskyi <andrii.cherniavskyi@opensynergy.com>, Cornelia Huck <cohuck@redhat.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Enric Balletbo i Serra <eballetb@redhat.com>, 
	Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, 
	Keiichi Watanabe <keiichiw@chromium.org>, Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marcin Wojtas <mwojtas@google.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Tomasz Figa <tfiga@chromium.org>, Matti.Moell@opensynergy.com, bag@semihalf.com, 
	bgrzesik@google.com, hmazur@google.com, mikrawczyk@google.com, 
	srosek@google.com, zyta@google.com, linux-media@vger.kernel.org, 
	libcamera-devel@lists.libcamera.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000003e9d2e060164b9e2"
Subject: [virtio-dev] Re: [RFC PATCH v8 1/1] virtio-video: Add virtio video device specification

--0000000000003e9d2e060164b9e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 10:52=E2=80=AFAM Alexander Gordeev <
alexander.gordeev@opensynergy.com> wrote:

> Hi Albert,
>
> On 06.07.23 16:59, Albert Esteve wrote:
> > Hi Alexander,
> >
> > Thanks for the patch! It is a long document, so I skimmed a bit in the
> > first read. Find some comments/questions inlined.
> > I will give it a second deeper read soon, but overall I think is in
> > quite good shape. It feels really matured.
>
> Great! Thank you for taking the time to review it.
>
> > On Thu, Jun 29, 2023 at 4:49=E2=80=AFPM Alexander Gordeev
> > <Alexander.Gordeev@opensynergy.com
> > <mailto:Alexander.Gordeev@opensynergy.com>> wrote:
> >
> >     Add the specification of the video decoder and encoder devices, whi=
ch
> >     can be used to provide host-accelerated video operations to the
> guest.
> >
> >     Signed-off-by: Alexander Gordeev <Alexander.Gordeev@opensynergy.com
> >     <mailto:Alexander.Gordeev@opensynergy.com>>
> >     Co-authored-by: Keiichi Watanabe <keiichiw@chromium.org
> >     <mailto:keiichiw@chromium.org>>
> >     Co-authored-by: Alexandre Courbot <acourbot@chromium.org
> >     <mailto:acourbot@chromium.org>>
> >     ---
> >       conformance.tex                           |    4 +
> >       content.tex                               |    1 +
> >       device-types/video/description.tex        | 2040
> +++++++++++++++++++++
> >       device-types/video/device-conformance.tex |   22 +
> >       device-types/video/driver-conformance.tex |   16 +
> >       introduction.tex                          |   21 +
> >       6 files changed, 2104 insertions(+)
> >       create mode 100644 device-types/video/description.tex
> >       create mode 100644 device-types/video/device-conformance.tex
> >       create mode 100644 device-types/video/driver-conformance.tex
> >
> >     diff --git a/conformance.tex b/conformance.tex
> >     index 01ccd69..d719eda 100644
> >     --- a/conformance.tex
> >     +++ b/conformance.tex
> >     @@ -34,6 +34,7 @@ \section{Conformance
> >     Targets}\label{sec:Conformance / Conformance Targets}
> >       \ref{sec:Conformance / Driver Conformance / SCMI Driver
> Conformance},
> >       \ref{sec:Conformance / Driver Conformance / GPIO Driver
> >     Conformance} or
> >       \ref{sec:Conformance / Driver Conformance / PMEM Driver
> Conformance}.
> >     +\ref{sec:Conformance / Driver Conformance / Video Driver
> Conformance},
> >
> >           \item Clause \ref{sec:Conformance / Legacy Interface:
> >     Transitional Device and Transitional Driver Conformance}.
> >         \end{itemize}
> >     @@ -61,6 +62,7 @@ \section{Conformance
> >     Targets}\label{sec:Conformance / Conformance Targets}
> >       \ref{sec:Conformance / Device Conformance / SCMI Device
> Conformance},
> >       \ref{sec:Conformance / Device Conformance / GPIO Device
> >     Conformance} or
> >       \ref{sec:Conformance / Device Conformance / PMEM Device
> Conformance}.
> >     +\ref{sec:Conformance / Device Conformance / Video Device
> Conformance},
> >
> >           \item Clause \ref{sec:Conformance / Legacy Interface:
> >     Transitional Device and Transitional Driver Conformance}.
> >         \end{itemize}
> >     @@ -152,6 +154,7 @@ \section{Conformance
> >     Targets}\label{sec:Conformance / Conformance Targets}
> >       \input{device-types/scmi/driver-conformance.tex}
> >       \input{device-types/gpio/driver-conformance.tex}
> >       \input{device-types/pmem/driver-conformance.tex}
> >     +\input{device-types/video/driver-conformance.tex}
> >
> >       \conformance{\section}{Device Conformance}\label{sec:Conformance =
/
> >     Device Conformance}
> >
> >     @@ -238,6 +241,7 @@ \section{Conformance
> >     Targets}\label{sec:Conformance / Conformance Targets}
> >       \input{device-types/scmi/device-conformance.tex}
> >       \input{device-types/gpio/device-conformance.tex}
> >       \input{device-types/pmem/device-conformance.tex}
> >     +\input{device-types/video/device-conformance.tex}
> >
> >       \conformance{\section}{Legacy Interface: Transitional Device and
> >     Transitional Driver Conformance}\label{sec:Conformance / Legacy
> >     Interface: Transitional Device and Transitional Driver Conformance}
> >       A conformant implementation MUST be either transitional or
> >     diff --git a/content.tex b/content.tex
> >     index d2ab9eb..90708d7 100644
> >     --- a/content.tex
> >     +++ b/content.tex
> >     @@ -765,6 +765,7 @@ \chapter{Device Types}\label{sec:Device Types}
> >       \input{device-types/scmi/description.tex}
> >       \input{device-types/gpio/description.tex}
> >       \input{device-types/pmem/description.tex}
> >     +\input{device-types/video/description.tex}
> >
> >       \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> >
> >     diff --git a/device-types/video/description.tex
> >     b/device-types/video/description.tex
> >     new file mode 100644
> >     index 0000000..760df7f
> >     --- /dev/null
> >     +++ b/device-types/video/description.tex
> >     @@ -0,0 +1,2040 @@
> >     +\section{Video Device}
> >     +\label{sec:Device Types / Video Device}
> >     +
> >     +The virtio video encoder and decoder devices provide support for
> >     +host-accelerated video encoding and decoding. Despite being
> different
> >     +device types, they use the same protocol and general flow.
> >     +
> >     +\subsection{Device ID}
> >     +\label{sec:Device Types / Video Device / Device ID}
> >     +
> >     +\begin{description}
> >     +\item[30]
> >     +  encoder device
> >     +\item[31]
> >     +  decoder device
> >     +\end{description}
> >     +
> >     +\subsection{Virtqueues}
> >     +\label{sec:Device Types / Video Device / Virtqueues}
> >     +
> >     +\begin{description}
> >     +\item[0]
> >     +  commandq - queue for driver commands and device responses to
> >     these commands
> >     +\item[1]
> >     +  eventq - queue for device delayed responses to commands and
> >     standalone
> >     +  device events
> >     +\end{description}
> >     +
> >     +\subsection{Feature bits}
> >     +\label{sec:Device Types / Video Device / Feature bits}
> >     +
> >     +\begin{description}
> >     +\item[VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES (0)]
> >     +  Guest pages can be used as the backing memory of resources.
> >     +\item[VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG (1)]
> >     +  The device can use non-contiguous guest memory as the backing
> >     memory of
> >     +  resources. Only meaningful if VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGE=
S
> >     is also
> >     +  set.
> >     +\item[VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT (2)]
> >     +  Objects exported by another virtio device can be used as the
> >     backing memory
> >     +  of resources.
> >     +\item[VIRTIO_VIDEO_F_RESOURCE_DYNAMIC (3)]
> >     +  The device supports re-attaching memory to resources while
> streaming.
> >     +% TODO this flag is not used anywhere at the moment.
> >     +% Might be necessary with Android.
> >     +\end{description}
> >
> >
> > Maybe I am missing part of the previous dicussion, but is this
> > VIRTIO_VIDEO_F_RESOURCE_DYNAMIC flag new?
> > Not sure what re-attaching memory means and what the flag is supossed t=
o
> do.
> > In the comment you mention specifically Android, so it got me curious.
> > What is the usecase for this feature flag?
>
> This flag first appeared in draft v6, but it is still not used anywhere
> in the text. I'm almost sure I know why it was added by Alexandre. Our
> experince with Android's Codec2 and v4l2_codec2 shows that something
> like this can happen:
>
> 1. The V4L2 device is opened. For example, a decoder.
> 2. All parameters and buffers are set up. Both queues are started.
> 3. A buffer is queued and then dequeued later. From this moment it
> "belongs" to the guest user-space.
> 4. This opportunity is used to detach the buffer's memory and attach
> some different chunks of memory.
> 5. Then the buffer is queued again. And so on.
>
> The problem here is that according to V4L2 conventions the old memory is
> expected to not be modified after it is dequeued because it could be
> used as a reference in the decoding process. Unfortunately these
> conventions were rather informal until recently AFAIU. Here is the
> patch, that adds this and an interesting discussuin related to the
> issue:
> https://lore.kernel.org/all/20211018091427.88468-1-acourbot@chromium.org/
>
> So the way it is done in Android could be problematic. So the driver
> should probably forbid the reattaching unless the queue is stopped. But
> if the virtio video device is, for example, always doing a pixel format
> conversion after the decoding, then it is OK to reattach the memory. In
> this case the device can advertise the VIRTIO_VIDEO_F_RESOURCE_DYNAMIC
> flag to notify the driver, that the memory could be safely reattached.
> Maybe this is not the best way to deal with this, see the discussion at
> the link above. At least it is not very invasive.
>
> >     +
> >     +\devicenormative{\subsubsection}{Feature bits}{Device Types / Vide=
o
> >     Device / Feature bits}
> >     +
> >     +The device MUST set at least one of
> >     VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES or
> >     +VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT, since the absence of both
> >     bits would
> >     +mean that no memory can be used at all for resources.
> >     +
> >     +The device MUST NOT set VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG unless
> >     it also sets
> >     +VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES.
> >     +
> >     +\drivernormative{\subsubsection}{Feature bits}{Device Types / Vide=
o
> >     Device / Feature bits}
> >     +
> >     +The driver MUST negotiate at least one of the
> >     +VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES and
> >     VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT
> >     +features.
> >     +
> >     +If VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES has been negotiated, but no=
t
> >     +VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG, the driver MUST use physically
> >     +contiguous memory for all the buffers it allocates.
> >     +
> >     +\subsection{Device configuration layout}
> >     +\label{sec:Device Types / Video Device / Device configuration
> layout}
> >     +
> >     +The video device configuration space uses the following layout:
> >     +
> >     +\begin{lstlisting}
> >     +struct virtio_video_config {
> >     +        le32 caps_length;
> >     +};
> >     +\end{lstlisting}
> >     +
> >     +\begin{description}
> >     +\item[\field{caps_length}]
> >     +  is the minimum length in bytes that a device-writable buffer mus=
t
> >     have
> >     +  in order to receive the response to
> >     VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS, see
> >     +  \ref{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.
> >     +\end{description}
> >     +
> >     +\devicenormative{\subsubsection}{Device configuration
> >     layout}{Device Types / Video Device / Device configuration layout}
> >     +
> >     +The device MUST set the \field{caps_length} field to a value equal
> to
> >     +the response size of VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS.
> >     +
> >     +\subsection{Supported parameters}
> >     +\label{sec:Device Types / Video Device / Supported parameters}
> >     +
> >     +\subsubsection{Supported coded formats}
> >     +\label{sec:Device Types / Video Device / Supported parameters /
> >     Supported coded formats}
> >     +
> >     +The following coded formats are defined:
> >     +\begin{lstlisting}
> >     +#define VIRTIO_VIDEO_CODED_FORMAT_MPEG2  1  /* MPEG-2 Part 2
> >     (V4L2_PIX_FMT_MPEG2) */
> >     +#define VIRTIO_VIDEO_CODED_FORMAT_MPEG4  2  /* MPEG-4 Part 2
> >     (V4L2_PIX_FMT_MPEG4) */
> >     +#define VIRTIO_VIDEO_CODED_FORMAT_H264   3  /* H.264
> >     (V4L2_PIX_FMT_H264)  */
> >     +#define VIRTIO_VIDEO_CODED_FORMAT_HEVC   4  /* HEVC aka H.265
> >     (V4L2_PIX_FMT_HEVC)  */
> >     +#define VIRTIO_VIDEO_CODED_FORMAT_VP8    5  /* VP8
> >     (V4L2_PIX_FMT_VP8)   */
> >     +#define VIRTIO_VIDEO_CODED_FORMAT_VP9    6  /* VP9
> >     (V4L2_PIX_FMT_VP9)   */
> >     +\end{lstlisting}
> >     +
> >     +The above constants have two usages:
> >     +\begin{enumerate}
> >     +\item As bit numbers, used to tell the driver which coded formats
> are
> >     +supported by the device, see
> >     +\ref{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.
> >     +\item As values, used to designate the coded format when working
> with
> >     +stream parameters, see
> >     +\ref{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.
> >     +\end{enumerate}
> >     +
> >     +The coded formats and the expected data units per buffer are
> >     documented in
> >     +\hyperref[intro:V4L2]{V4L2 header} and
> >     +\hyperref[intro:V4L2 compressed]{V4L2 compressed formats
> >     documentation}.
> >     +
> >     +\subsubsection{Supported raw formats}
> >     +\label{sec:Device Types / Video Device / Supported parameters /
> >     Supported raw formats}
> >     +
> >     +The following raw formats are defined:
> >     +\begin{lstlisting}
> >     +#define VIRTIO_VIDEO_RAW_FORMAT_ARGB8888  1  /* DRM_FORMAT_ARGB888=
8
> >     / V4L2_PIX_FMT_ABGR32 */
> >     +#define VIRTIO_VIDEO_RAW_FORMAT_BGRA8888  2  /* DRM_FORMAT_BGRA888=
8
> >     / V4L2_PIX_FMT_ARGB32 */
> >     +#define VIRTIO_VIDEO_RAW_FORMAT_RGBA8888  3  /* DRM_FORMAT_RGBA888=
8
> >     / V4L2_PIX_FMT_BGRA32 */
> >     +#define VIRTIO_VIDEO_RAW_FORMAT_NV12      4  /* DRM_FORMAT_NV12
> >       / V4L2_PIX_FMT_NV12   */
> >     +#define VIRTIO_VIDEO_RAW_FORMAT_YUV420    5  /* DRM_FORMAT_YUV420
> >       / V4L2_PIX_FMT_YUV420 */
> >     +#define VIRTIO_VIDEO_RAW_FORMAT_YVU420    6  /* DRM_FORMAT_YVU420
> >       / V4L2_PIX_FMT_YVU420 */
> >     +#define VIRTIO_VIDEO_RAW_FORMAT_YUYV      7  /* DRM_FORMAT_YUYV
> >       / V4L2_PIX_FMT_YUYV   */
> >     +\end{lstlisting}
> >     +
> >     +The above constants have two usages:
> >     +\begin{enumerate}
> >     +\item As bit numbers, used to tell the driver which raw formats ar=
e
> >     +supported by the device, see
> >     +\ref{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.
> >     +\item As values, used to designate the raw format when working wit=
h
> >     +stream parameters, see
> >     +\ref{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.
> >     +\end{enumerate}
> >     +
> >     +The layouts of raw formats are documented in \hyperref[intro:DRM
> >     formats]{DRM}
> >     +and \hyperref[intro:V4L2]{V4L2} headers, as well as in
> >     +\hyperref[intro:V4L2 RGB]{V4L2 RGB} and
> >     +\hyperref[intro:V4L2 YUV]{planar YUV} formats documentation.
> >     +
> >     +\subsubsection{Supported stream parameters}
> >     +\label{sec:Device Types / Video Device / Supported parameters /
> >     Supported stream parameters}
> >     +
> >     +The following stream parameters are defined:
> >     +\begin{lstlisting}
> >     +#define VIRTIO_VIDEO_PARAM_CODED_FORMAT       1
> >     +#define VIRTIO_VIDEO_PARAM_RAW_FORMAT         2
> >     +#define VIRTIO_VIDEO_PARAM_CODED_RESOURCES    3
> >     +#define VIRTIO_VIDEO_PARAM_RAW_RESOURCES      4
> >     +#define VIRTIO_VIDEO_PARAM_CROP               5
> >     +#define VIRTIO_VIDEO_PARAM_BITRATE            6  /* Same as
> >     V4L2_CID_MPEG_VIDEO_BITRATE */
> >     +#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_MPEG2  7
> >     +#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_MPEG4  8
> >     +#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_H264   9
> >     +#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_HEVC   10
> >     +#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_VP8    11
> >     +#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_VP9    12
> >     +\end{lstlisting}
> >     +% TODO acourbot: See b/241492607 (fractional frame rates??)
> >     +
> >     +The above constants have two usages:
> >     +\begin{enumerate}
> >     +\item As bit numbers, used to tell the driver which stream
> >     parameters are
> >     +supported by the device, see
> >     +\ref{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.
> >     +\item As values, used to designate the stream parameters when
> >     working with
> >     +them, see
> >     +\ref{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.
> >     +\end{enumerate}
> >     +
> >     +\subsection{Device Initialization}
> >     +\label{sec:Device Types / Video Device / Device Initialization}
> >     +
> >     +\begin{enumerate}
> >     +\def\labelenumi{\arabic{enumi}.}
> >     +\item
> >     +  The driver reads the feature bits and negotiates the features it
> >     needs.
> >     +\item
> >     +  The driver sets up the commandq and the eventq.
> >     +\item
> >     +  The driver reads the \field{caps_length} field of the
> configuration
> >     +  space and prepares a buffer of at least that size.
> >     +\item
> >     +  The driver sends that buffer on the commandq with the
> >     +  VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS command.
> >     +\item
> >     +  The driver receives the response from the device, and parses its
> >     capabilities.
> >     +\end{enumerate}
> >     +
> >     +\subsection{Device Operation}
> >     +\label{sec:Device Types / Video Device / Device Operation}
> >     +
> >     +The commandq is used by the driver to send commands to the device
> >     and to
> >     +receive the device's responses via used buffers. The eventq is use=
d
> >     by the
> >     +device to send the device's delayed responses to commands and
> >     standalone
> >     +device events.
> >     +
> >     +The driver can create new streams using the
> >     +VIRTIO_VIDEO_CMD_STREAM_CREATE command. Each stream has two resour=
ce
> >     +queues (not to be confused with the virtio queues) called INPUT an=
d
> >     +OUTPUT, when the direction of the data flow matters. The INPUT
> >     queue accepts
> >     +driver-filled input data for the device (coded data for a decoder;
> >     +input frames for an encoder), while the OUTPUT queue receives
> >     resources to be
> >     +filled by the device as a result of processing the INPUT queue
> >     (decoded raw
> >     +frames for a decoder; encoded data for an encoder).
> >     +
> >     +These same queues can be also called CODED and RAW, when their
> >     content matters.
> >     +The CODED queue is used to transfer compressed video data (INPUT
> >     for a decoder;
> >     +OUTPUT for an encoder), while the RAW queue is used to transfer ra=
w
> >     frames
> >     +(OUTPUT for a decoder; INPUT for an encoder).
> >     +
> >     +The INPUT and OUTPUT queues are effectively independent, and the
> driver
> >     +can fill them without caring about the other queue. In particular
> there
> >     +is no need to queue input and output resources in pairs: one input
> >     +resource can result in zero to many produced output resources.
> >     +
> >     +A resource is a set of memory buffers that contain a unit of data
> that
> >     +the device can process or produce. Most resources will only have o=
ne
> >     +buffer (like coded data and single-planar raw frames), but frames
> >     using a
> >     +multi-planar format can have several.
> >     +
> >     +Parameters allow the driver to configure the stream for the
> decoding or
> >     +encoding operation. The parameters can be obtained and configured
> using
> >     +VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS. Available parameters depend on
> >     +the device type and are detailed in section
> >     +\ref{sec:Device Types / Video Device / Supported parameters /
> >     Supported stream parameters}.
> >     +
> >     +Before resources can be submitted to a queue, backing memory must =
be
> >     +attached to them using VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING.
> >     +The exact form of that memory is negotiated using the feature flag=
s.
> >     +
> >     +In the case of a decoder device, the decoded frames are made
> available
> >     +on the OUTPUT queue in presentation order.
> >     +
> >     +Resources are queued to the INPUT or OUTPUT queue using the
> >     +VIRTIO_VIDEO_CMD_RESOURCE_QUEUE command. The device sends a delaye=
d
> >     response
> >     +to this command when an input resource has been fully processed an=
d
> >     can be
> >     +reused by the driver, or when an output resource has been filled b=
y
> the
> >     +device as a result of processing.
> >     +
> >     +The device can detect stream-related events that require
> intervention
> >     +from the driver and signals them on the eventq, see
> >     +\ref{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Standalone Events}.
> >     +One example is a dynamic parameters change while decoding a stream=
,
> >     which
> >     +may require the driver to reallocate the backing memory of its
> output
> >     +resources to fit the new resolution.
> >     +
> >     +% RESET and DRAIN have essentially the same outcome: all the input
> >     +% resources queued before the command are released, there are no
> >     related
> >     +% output resources in the decoder/encoder, the dequeued output
> >     resources
> >     +% can't be used as a reference by the device. So the other
> >     requirements should
> >     +% be reasonably similar.
> >     +% Use-case: playback in a loop from second 1 till the end of file.
> >     +
> >     +% TODO put some examples in the comments
> >     +
> >     +\subsubsection{Device Operation: Command Virtqueue}
> >     +\label{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Command Virtqueue}
> >     +
> >     +This section details the commands that can be sent on the commandq
> by
> >     +the driver, as well as the responses that the device will write.
> >     +
> >     +Different structures are used for each command and response. A
> command
> >     +structure starts with the requested command code, defined as
> follows:
> >     +
> >     +\begin{lstlisting}
> >     +/* Device */
> >     +#define VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS       0x100
> >     +
> >     +/* Stream */
> >     +#define VIRTIO_VIDEO_CMD_STREAM_CREATE           0x200
> >     +#define VIRTIO_VIDEO_CMD_STREAM_DESTROY          0x201
> >     +#define VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS       0x202
> >
> >
> > Why not having a GET_PARAMS counterpart?
>
> With the current approach to setting the parameters GET_PARAMS would be
> almost exactly the same as SET_PARAMS if params.stream_params_bitmask is
> set to zero. So I assumed that it is better to save the space and remove
> the GET_PARAMS counterpart since the length of the spec is already a
> sensitive topic.
>
> >     +#define VIRTIO_VIDEO_CMD_STREAM_DRAIN            0x203
> >     +#define VIRTIO_VIDEO_CMD_STREAM_RESET            0x204
> >     +
> >     +/* Resource */
> >     +#define VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING 0x300
> >     +#define VIRTIO_VIDEO_CMD_RESOURCE_QUEUE          0x301
> >     +\end{lstlisting}
> >     +
> >     +A response structure starts with the result of the requested
> command,
> >     +defined as follows:
> >     +
> >     +\begin{lstlisting}
> >     +/* Success */
> >     +#define VIRTIO_VIDEO_RESULT_OK                          0x000
> >     +#define VIRTIO_VIDEO_RESULT_OK_DELAYED                  0x001
> >     +
> >     +/* Error */
> >     +#define VIRTIO_VIDEO_RESULT_ERR_INVALID_COMMAND         0x100
> >     +#define VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION       0x101
> >     +#define VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID       0x102
> >     +#define VIRTIO_VIDEO_RESULT_ERR_INVALID_RESOURCE_ID     0x103
> >     +#define VIRTIO_VIDEO_RESULT_ERR_INVALID_ARGUMENT        0x104
> >     +#define VIRTIO_VIDEO_RESULT_ERR_OUT_OF_MEMORY           0x105
> >     +\end{lstlisting}
> >     +
> >     +For response structures carrying an error code, the rest of the
> >     +structure is considered invalid.
> >     +
> >     +For all commands beginning background operations and returning
> delayed
> >     +responses over eventq, the command response is defined as follows:
> >     +
> >     +\begin{lstlisting}
> >     +#define VIRTIO_VIDEO_INVALID_RESPONSE_ID  0xffffffff
> >     +
> >     +struct virtio_video_command_resp_delayed_common {
> >     +        le32 result; /* VIRTIO_VIDEO_RESULT_* */
> >     +        le32 delayed_response_id;
> >     +};
> >     +\end{lstlisting}
> >     +
> >     +\begin{description}
> >     +\item[\field{result}]
> >     +  is
> >     +
> >     +  \begin{description}
> >     +  \item[VIRTIO_VIDEO_RESULT_OK_DELAYED]
> >     +    if the command started the desired background operation
> >     successfully,
> >     +  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID]
> >     +    if the mentioned stream ID does not exist,
> >     +  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_RESOURCE_ID]
> >     +    if the mentioned resource ID does not exist,
> >     +  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_ARGUMENT]
> >     +    if other command parameters are not valid, e.g. not within the
> >     device's
> >     +    capabilities,
> >     +  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION]
> >     +    if the command is performed at a time when it is not valid.
> >     +  \end{description}
> >     +\item[\field{delayed_response_id}]
> >     +  is an ID of the future delayed response provided by the device,
> >     that allows
> >     +  to relate it to the command.
> >     +\end{description}
> >     +
> >     +\devicenormative{\paragraph}{Device Operation: Command
> >     Virtqueue}{Device Types / Video Device / Device Operation / Device
> >     Operation: Command Virtqueue}
> >     +
> >     +Responses to a command MUST be written by the device in the first
> >     +device-writable descriptor of the descriptor chain from which the
> >     +command came.
> >     +
> >     +The device MUST return VIRTIO_VIDEO_RESULT_ERR_INVALID_COMMAND to
> >     +any command code it does not recognize.
> >     +
> >     +\field{delayed_response_id} MUST be set to a stream-unique
> >     identifier that
> >     +remains valid as long as the background operation hasn't finished.
> >
> >     +
> >     +\drivernormative{\paragraph}{Device Operation: Command
> >     Virtqueue}{Device Types / Video Device / Device Operation / Device
> >     Operation: Command Virtqueue}
> >     +
> >     +Descriptor chains sent to the commandq by the driver MUST include =
at
> >     +least one device-writable descriptor of a size sufficient to
> >     receive the
> >     +response to the queued command.
> >     +
> >     +The driver MUST NOT interpret the rest of a response whose result
> >     is not
> >     +VIRTIO_VIDEO_RESULT_OK or VIRTIO_VIDEO_RESULT_OK_DELAYED.
> >     +
> >     +\subsubsection{Device Operation: Event Virtqueue}
> >     +\label{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Event Virtqueue}
> >     +
> >     +The eventq is used by the device to send delayed responses to
> >     commands queued
> >     +by the driver on the commandq and standalone events. Stream errors
> >     and dynamic
> >     +parameters changes are caused by changes in the device's state, no=
t
> by
> >     +commands, still they are delivered as
> >     VIRTIO_VIDEO_DELAYED_RESP_STREAM_DESTROY
> >     +and VIRTIO_VIDEO_DELAYED_RESP_STREAM_SET_PARAMS, respectively.
> >
> >
> > So, ERROR and DRC events trigger a
> VIRTIO_VIDEO_DELAYED_RESP_STREAM_DESTROY
> > and VIRTIO_VIDEO_DELAYED_RESP_STREAM_SET_PARAMS events, respectively.
> > And VIRTIO_VIDEO_DELAYED_RESP_STREAM_SET_PARAMS will have
> > a valid `delayed_response_id` only if it comes from a SET_PARAMS comman=
d
> > from the
> > driver. Otherwise, if it is due to a dynamic parameter change,
> > `delayed_response_id`
> > will be set to `VIRTIO_VIDEO_INVALID_RESPONSE_ID`. Is this correct?
>
> Yes, this is correct. Looks like it is better to rename
> VIRTIO_VIDEO_INVALID_RESPONSE_ID to VIRTIO_VIDEO_STANDALONE_EVENT_ID
> maybe. Thanks!
>
> >     +
> >     +The supported events are defined as follows:
> >     +
> >     +\begin{lstlisting}
> >     +#define VIRTIO_VIDEO_DELAYED_RESP_STREAM_DESTROY     1
> >     +#define VIRTIO_VIDEO_DELAYED_RESP_STREAM_SET_PARAMS  2
> >     +#define VIRTIO_VIDEO_DELAYED_RESP_STREAM_DRAIN       3
> >     +#define VIRTIO_VIDEO_DELAYED_RESP_STREAM_RESET       4
> >     +#define VIRTIO_VIDEO_DELAYED_RESP_RESOURCE_QUEUE     5
> >     +
> >     +#define VIRTIO_VIDEO_EVENT_FLAG_CANCELED             (1 << 0)
> >     +
> >     +struct virtio_video_event {
> >     +        le32 event_type; /* VIRTIO_VIDEO_DELAYED_RESP_* */
> >     +        le32 stream_id;
> >     +        le32 delayed_response_id;
> >     +        le32 event_flags; /* Bitmask of VIRTIO_VIDEO_EVENT_FLAG_* =
*/
> >     +        union {
> >     +                struct virtio_video_stream_set_params_delayed_resp
> >     set_params;
> >     +                struct virtio_video_resource_queue_delayed_resp
> queue;
> >     +        };
> >     +};
> >     +\end{lstlisting}
> >     +
> >     +\begin{description}
> >     +\item[\field{event_type}]
> >     +  is the type of the event.
> >     +\item[\field{stream_id}]
> >     +  is the ID of a valid stream.
> >     +\item[\field{delayed_response_id}]
> >     +  is an ID of the delayed response, that allows to relate it to a
> >     previously
> >     +  submitted command. If it is set to
> >     VIRTIO_VIDEO_INVALID_RESPONSE_ID, then
> >     +  this is a standalone event, see
> >     +  \ref{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Standalone Events}.
> >     +\item[\field{event_flags}]
> >     +  is a bitmask of VIRTIO_VIDEO_EVENT_FLAG_* flags
> >     +
> >     +  \begin{description}
> >     +  \item[VIRTIO_VIDEO_EVENT_FLAG_CANCELED]
> >     +    is set if the command has been canceled by another command,
> >     that has
> >     +    higher priority. Doesn't make sense for standalone events.
> >     +  \end{description}
> >     +\end{description}
> >     +
> >     +The particular member of the union is selected according to the
> >     +\field{event_type} for some of the types.
> >     +
> >     +\drivernormative{\paragraph}{Device Operation: Event
> >     Virtqueue}{Device Types / Video Device / Device Operation / Device
> >     Operation: Event Virtqueue}
> >     +
> >     +The driver MUST at any time have at least one descriptor with a us=
ed
> >     +buffer large enough to contain a \field{struct virtio_video_event}
> >     +queued on the eventq.
> >     +
> >     +The driver MUST NOT put device-readable descriptors into the event=
q.
> >     +
> >     +\subsubsection{Device Operation: Device Commands}
> >     +\label{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Device Commands}
> >     +
> >     +This command allows retrieving the device capabilities.
> >     +
> >     +\paragraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}
> >     +\label{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}
> >     +
> >     +Retrieve device capabilities for all available stream parameters.
> >     +
> >     +The driver sends this command with
> >     +\field{struct virtio_video_device_query_caps}:
> >     +
> >     +\begin{lstlisting}
> >     +struct virtio_video_device_query_caps {
> >     +        le32 cmd_type; /* VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS */
> >     +};
> >     +\end{lstlisting}
> >     +
> >     +The device responds with
> >     +\field{struct virtio_video_device_query_caps_resp}:
> >     +
> >     +\begin{lstlisting}
> >     +#define MASK(x) (1 << (x))
> >     +
> >     +struct virtio_video_device_query_caps_resp {
> >     +        le32 result; /* VIRTIO_VIDEO_RESULT_* */
> >     +        le32 stream_params_bitmask; /* Bitmask of
> >     MASK(VIRTIO_VIDEO_PARAM_*) */
> >     +        le32 coded_formats_bitmask; /* Bitmaks of
> >     MASK(VIRTIO_VIDEO_CODED_FORMAT_*) */
> >     +        le32 raw_formats_bitmask; /* Bitmask of
> >     MASK(VIRTIO_VIDEO_RAW_FORMAT_*) */
> >     +        le32 num_format_deps;
> >     +        le32 num_raw_format_caps;
> >     +        le32 num_coded_resources_caps;
> >     +        le32 num_raw_resources_caps;
> >     +        le32 num_bitrate_caps; /* If
> >     MASK(VIRTIO_VIDEO_PARAM_BITRATE) is set. */
> >     +        u8 padding[4];
> >     +        /* If corresponding MASK(VIRTIO_VIDEO_PARAM_GROUP_CODEC_*)
> >     is set. */
> >     +        struct virtio_video_mpeg2_caps mpeg2_caps;
> >     +        struct virtio_video_mpeg4_caps mpeg4_caps;
> >     +        struct virtio_video_h264_caps h264_caps;
> >     +        struct virtio_video_hevc_caps hevc_caps;
> >     +        struct virtio_video_vp8_caps vp8_caps;
> >     +        struct virtio_video_vp9_caps vp9_caps;
> >     +        /**
> >     +         * Followed by
> >     +         * struct virtio_video_format_dependency
> >     format_deps[num_format_deps];
> >     +         */
> >     +        /**
> >     +         * Followed by
> >     +         * struct virtio_video_raw_format_caps
> >     raw_format_caps[num_raw_format_caps];
> >     +         */
> >     +        /**
> >     +         * Followed by
> >     +         * struct virtio_video_coded_resources_caps
> >     +         * coded_resources_caps[num_coded_resources_caps];
> >     +         */
> >     +        /**
> >     +         * Followed by
> >     +         * struct virtio_video_raw_resources_caps
> >     raw_resources_caps[num_raw_resources_caps];
> >     +         */
> >     +        /**
> >     +         * Followed by if MASK(VIRTIO_VIDEO_PARAM_BITRATE) is set
> >     +         * struct virtio_video_bitrate_caps
> >     bitrate_caps[num_bitrate_caps];
> >     +         */
> >     +};
> >
> >
> > Maybe nitpicking, but some of the member structs are inside a comment
> > and some are not.
> > Does not seem to correlate with them being conditional.
> > I think is nice to have conditional fields in comment blocks to
> > highlight it, but then the
> > VIRTIO_VIDEO_PARAM_GROUP_CODEC_* structs need to be in their own commen=
t
> > block.
>
> Yeah, this style comes from draft v5, then I added the conditional
> statementson top, so now it is harder to understand. I also would like
> to do this in a different way. I was thinking recently about
> extendability of this construct, it doesn't look good. If a new codec or
> a new codec-specific parameters is added, it has to be guarded by a new
> feature flag, say VIRTIO_VIDEO_F_CODECS_2024. Then the device will have
> to provide different structures depending on the negotiated flags and
> the driver will have to parse it. This looks quite painful and
> error-prone. My current idea is to replace this with something like FDT
> to make it much more flexible. The resulting blob with all the
> capabilities can even be mapped directly to the guest memory. I'm still
> exploring this idea. WDYT?
>
>
Yes, the struct looks a bit cumbersome and difficult to expand, as you
mention.
But I am not sure what do you mean by FDT, or how you plan to map it to the
guest
memory. Could you expand the idea?
But from what I see, structures for most formats have similar fields for
capabilities.
Couldn't this be unified into a single capabilities struct and fill it with
the raw data obtained
from the host device?


> >     +\end{lstlisting}
> >     +
> >     +\begin{description}
> >     +\item[\field{result}]
> >     +  is
> >     +
> >     +  \begin{description}
> >     +  \item[VIRTIO_VIDEO_RESULT_OK]
> >     +    if the operation succeeded,
> >     +  \item[VIRTIO_VIDEO_RESULT_ERR_OUT_OF_MEMORY]
> >     +    if the descriptor was smaller than the defined
> >     \field{caps_length} in
> >     +    the video device configuration.
> >     +  \end{description}
> >     +\item[\field{stream_params_bitmask}]
> >     +  is a bitmask of supported stream parameters.
> >     +\item[\field{coded_formats_bitmask}]
> >     +  is a bitmask of supported coded formats.
> >     +\item[\field{raw_formats_bitmask}]
> >     +  is a bitmask of supported raw formats.
> >     +\item[\field{num_format_deps}]
> >     +  is the number of elements in the format_deps array.
> >     +\item[\field{num_raw_format_caps}]
> >     +  is the number of elements in the raw_format_caps array.
> >     +\item[\field{num_coded_resources_caps}]
> >     +  is the number of elements in the coded_resources_caps array.
> >     +\item[\field{num_raw_resources_caps}]
> >     +  is the number of elements in the raw_resources_caps array.
> >     +\item[\field{num_bitrate_caps}]
> >     +  is the number of elements in the bitrate_caps array.
> >     +\item[\field{mpeg2_caps}]
> >     +  groups the capabilities of MPEG2 specific parameters.
> >     +\item[\field{mpeg4_caps}]
> >     +  groups the capabilities of MPEG4 specific parameters.
> >     +\item[\field{h264_caps}]
> >     +  groups the capabilities of H.264 specific parameters.
> >     +\item[\field{hevc_caps}]
> >     +  groups the capabilities of HEVC specific parameters.
> >     +\item[\field{vp8_caps}]
> >     +  groups the capabilities of VP8 specific parameters.
> >     +\item[\field{vp9_caps}]
> >     +  groups the capabilities of VP9 specific parameters.
> >     +\item[\field{format_deps}]
> >     +  is an array of size \field{num_format_deps} establishing
> dependencies
> >     +  between coded and raw formats.
> >     +\item[\field{raw_format_caps}]
> >     +  is an array of size \field{num_raw_format_caps} containing the
> >     supported
> >     +  raw formats capabilities.
> >     +\item[\field{coded_resources_caps}]
> >     +  is an array of size \field{num_coded_resources_caps}, that sets
> >     bounds for
> >     +  the number of resources in the CODED queue.
> >     +\item[\field{raw_resources_caps}]
> >     +  is an array of size \field{num_raw_resources_caps}, that sets
> >     bounds for
> >     +  the number of resources in the RAW queue.
> >     +\item[\field{bitrate_caps}]
> >     +  is an array of size \field{num_bitrate_caps} containing the
> supported
> >     +  bitrates.
> >     +\end{description}
> >     +
> >     +% TODO: V4L2 flow: 1. coded format without variants (maybe these
> flags
> >     +% are relevant too: V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM?,
> >     +% V4L2_FMT_FLAG_DYN_RESOLUTION?,
> >     V4L2_FMT_FLAG_ENC_CAP_FRAME_INTERVAL???),
> >     +% also include variants (see VIDIOC_QUERYCTRL), then raw formats,
> >     +% then resolutions (discrete or stepwise, see
> VIDIOC_ENUM_FRAMESIZES),
> >     +% intervals are optional (see VIDIOC_ENUM_FRAMEINTERVALS)
> >     +
> >
>  +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}{Dev=
ice
> Types / Video Device / Device Operation / Device Operation: Device Comman=
ds
> / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}
> >     +
> >     +The device MUST support at least these parameters:
> >     +VIRTIO_VIDEO_PARAM_CODED_FORMAT, VIRTIO_VIDEO_PARAM_RAW_FORMAT,
> >     +VIRTIO_VIDEO_PARAM_CODED_RESOURCES,
> VIRTIO_VIDEO_PARAM_RAW_RESOURCES.
> >     +
> >     +The device MUST NOT mark codec-specific parameters
> >     +(VIRTIO_VIDEO_PARAM_GROUP_CODEC_*) as supported unless the
> >     corresponding
> >     +codecs are supported as well.
> >     +
> >     +The device MUST set to zero all fields with capabilities of
> unsupported
> >     +parameters.
> >     +
> >     +The lengths \field{num_format_deps}, \field{num_raw_format_caps},
> >     +\field{num_coded_resources_caps} and \field{num_raw_resources_caps=
}
> >     MUST be
> >     +positive.
> >     +
> >     +The device MUST write the five \field{format_deps},
> >     +\field{raw_format_caps}, \field{coded_resources_caps},
> >     +\field{raw_resources_caps} and \field{bitrate_caps} arrays, of
> length
> >     +\field{num_format_deps}, \field{num_raw_format_caps},
> >     +\field{num_coded_resources_caps}, \field{num_raw_resources_caps} a=
nd
> >     +\field{num_bitrate_caps}, respectively.
> >     +
> >     +For each coded format in the \field{coded_formats_bitmask} there
> >     MUST be
> >     +at least one element of \field{format_deps} referencing it.
> >     +
> >     +For each raw format in the \field{raw_formats_bitmask} there MUST =
be
> >     +at least one element of \field{format_deps} referencing it.
> >     +
> >     +For any coded and any raw format there MUST be at most one element
> of
> >     +\field{format_deps} referencing both of them.
> >     +
> >     +Elements of \field{format_deps} SHOULD be ordered according to raw
> >     format
> >     +preferences of the device from preferred to not preferred ones.
> >     +
> >     +For each raw format in the \field{raw_formats_bitmask} there MUST =
be
> >     +exactly one element of \field{raw_format_caps} referencing it.
> >     +
> >     +For each coded format in the \field{coded_formats_bitmask} there
> >     MUST be
> >     +exactly one element of \field{coded_resources_caps} referencing it=
.
> >     +
> >     +For each raw format in the \field{raw_formats_bitmask} there MUST =
be
> >     +exactly one element of \field{raw_resources_caps} referencing it.
> >     +
> >     +If VIRTIO_VIDEO_PARAM_BITRATE is supported, then for each coded
> >     format in
> >     +the \field{coded_formats_bitmask} there MUST be exactly one elemen=
t
> of
> >     +\field{bitrate_caps} referencing it.
> >     +
> >     +The total size of the response MUST be equal to \field{caps_length=
}
> >     +bytes, as reported by the device configuration.
> >     +
> >     +\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Format
> dependencies}
> >     +
> >     +The description of dependencies between coded and raw formats
> >     +\field{virtio_video_format_dependency} is defined as follows:
> >     +
> >     +\begin{lstlisting}
> >     +struct virtio_video_format_dependency {
> >     +        le32 coded_formats_bitmask; /* Bitmask of
> >     MASK(VIRTIO_VIDEO_CODED_FORMAT_*) */
> >     +        le32 raw_format; /* VIRTIO_VIDEO_RAW_FORMAT_* */
> >     +};
> >     +\end{lstlisting}
> >     +
> >     +\begin{description}
> >     +\item[\field{coded_formats_bitmask}]
> >     +  specifies coded formats, see
> >     +  \ref{sec:Device Types / Video Device / Supported parameters /
> >     Supported coded formats}.
> >     +  If a bit for a specific coded format is set, then this coded
> >     format can be
> >     +  decoded into the specified raw format or encoded from it.
> >     +\item[\field{raw_format}]
> >     +  is a raw format, see
> >     +  \ref{sec:Device Types / Video Device / Supported parameters /
> >     Supported raw formats}.
> >     +\end{description}
> >     +
> >     +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS=
:
> >     Format dependencies}{Device Types / Video Device / Device Operation
> >     / Device Operation: Device Commands /
> >     VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS /
> >     VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Format dependencies}
> >     +
> >     +\field{coded_formats_bitmask} MUST be a subset of
> >     \field{coded_formats_bitmask}
> >     +field of \field{struct virtio_video_device_query_caps_resp}.
> >     +
> >     +\field{coded_formats_bitmask} MUST specify at least one coded
> format.
> >     +
> >     +\field{raw_format} MUST be set to one of the supported raw formats
> >     according to
> >     +the \field{raw_formats_bitmask} field of
> >     +\field{struct virtio_video_device_query_caps_resp}.
> >     +
> >     +\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format
> >     capabilities}
> >     +\label{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS /
> >     VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format capabilities}
> >     +
> >     +The raw format capability description
> >     \field{virtio_video_raw_format_caps} is
> >     +defined as follows:
> >     +
> >     +\begin{lstlisting}
> >     +enum virtio_video_planes_layout {
> >     +        VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER =3D 1,
> >     +        VIRTIO_VIDEO_PLANES_LAYOUT_MULTI_BUFFERS =3D 2,
> >     +};
> >     +
> >     +struct virtio_video_range {
> >     +        le32 min;
> >     +        le32 max;
> >     +        le32 step;
> >     +        u8 padding[4];
> >     +};
> >     +
> >     +struct virtio_video_raw_format_caps {
> >     +        le32 raw_formats_bitmask; /* Bitmask of
> >     MASK(VIRTIO_VIDEO_RAW_FORMAT_*) */
> >     +        le32 planes_layouts; /* Bitmask of
> >     VIRTIO_VIDEO_PLANES_LAYOUT_* */
> >     +        le32 plane_align;
> >     +        le32 stride_align_mask;
> >     +        struct virtio_video_range width_range;
> >     +        struct virtio_video_range height_range;
> >     +};
> >     +\end{lstlisting}
> >     +
> >     +\field{struct virtio_video_range} is used to represent a range of
> >     values.
> >     +An integer \(x\) is within the range \field{r} if
> >     +\(\field{r.min} \le x \le \field{r.max}\) holds and \(x\) equals t=
o
> >     +\((\field{min} + \field{step} * n)\) for some integer \(n\).
> >     +
> >     +\begin{description}
> >     +\item[\field{raw_formats_bitmask}]
> >     +  specifies raw formats, see
> >     +  \ref{sec:Device Types / Video Device / Supported parameters /
> >     Supported raw formats},
> >     +  to which these capabilities apply.
> >     +\item[\field{planes_layouts}]
> >     +  is a bitmask with the set of plane layout types from
> >     +  \field{enum virtio_video_planes_layout}.
> >     +\item[\field{plane_align}]
> >     +  is the alignment of planes within a buffer in bytes. This field
> >     is valid
> >     +  only if \field{planes_layouts} has the
> >     +  \field{VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER} bit set.
> >     +\item[\field{stride_align_mask}]
> >     +  is a mask of all supported power of two stride alignments.
> >     +\item[\field{width_range}]
> >     +  is a range of widths in pixels.
> >     +\item[\field{height_range}]
> >     +  is a range of heights in pixels.
> >     +\end{description}
> >     +
> >     +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS=
:
> >     Raw format capabilities}{Device Types / Video Device / Device
> >     Operation / Device Operation: Device Commands /
> >     VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS /
> >     VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format capabilities}
> >     +
> >     +\field{raw_formats_bitmask} MUST be a subset of
> >     \field{raw_formats_bitmask}
> >     +field of \field{struct virtio_video_device_query_caps_resp}.
> >     +
> >     +\field{raw_formats_bitmask} MUST specify at least one raw format.
> >     +
> >     +The device MUST set
> >     \field{VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER} bit in
> >     +\field{planes_layouts} if the plane layout with planes of a frame
> >     laid out one
> >     +after another in the same buffer is supported.
> >     +
> >     +The device MUST set
> >     \field{VIRTIO_VIDEO_PLANES_LAYOUT_MULTI_BUFFERS} bit in
> >     +\field{planes_layouts} if the plane layout with planes of a frame
> >     laid out in
> >     +separate buffers is supported.
> >     +
> >     +\field{plane_align} MUST be set to a power of two according to the
> >     device
> >     +plane alignment requirements if \field{planes_layouts} has the
> >     +\field{VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER} bit set or to zer=
o
> >     otherwise.
> >     +
> >     +\field{min}, \field{step} and \field{max} MUST be positive.
> >     +
> >     +\field{min} MUST be less then or equal to \field{max} within the
> >     same range.
> >     +
> >     +\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Resource
> >     capabilities}
> >     +
> >     +The CODED resource capabilities
> >     \field{virtio_video_coded_resources_caps} is
> >     +defined as follows:
> >     +
> >     +\begin{lstlisting}
> >     +struct virtio_video_coded_resources_caps {
> >     +        le32 coded_formats_bitmask; /* Bitmask of
> >     MASK(VIRTIO_VIDEO_CODED_FORMAT_*) */
> >     +        le32 min_resources;
> >     +        le32 max_resources;
> >     +        le32 buffer_size;
> >     +};
> >     +\end{lstlisting}
> >     +
> >     +\begin{description}
> >     +\item[\field{coded_formats_bitmask}]
> >     +  specifies coded formats, see
> >     +  \ref{sec:Device Types / Video Device / Supported parameters /
> >     Supported coded formats},
> >     +  to which these capabilities apply.
> >     +\item[\field{min_resources}]
> >     +  is the minimum number of resources that the CODED queue supports
> >     for all
> >     +  the specified coded formats.
> >     +\item[\field{max_resources}]
> >     +  is the maximum number of resources that the CODED queue supports
> >     for all
> >     +  the specified coded formats.
> >     +\item[\field{buffer_size}]
> >     +  is the minimum size of the buffers that will back resources to b=
e
> >     queued.
> >     +\end{description}
> >     +
> >     +The RAW resource capabilities
> >     \field{virtio_video_raw_resources_caps} is
> >     +defined as follows:
> >     +
> >     +\begin{lstlisting}
> >     +struct virtio_video_raw_resources_caps {
> >     +        le32 raw_formats_bitmask; /* Bitmask of
> >     MASK(VIRTIO_VIDEO_RAW_FORMAT_*) */
> >     +        le32 min_resources;
> >     +        le32 max_resources;
> >     +        u8 padding[4];
> >     +};
> >     +\end{lstlisting}
> >     +
> >     +\begin{description}
> >     +\item[\field{raw_formats_bitmask}]
> >     +  specifies raw formats, see
> >     +  \ref{sec:Device Types / Video Device / Supported parameters /
> >     Supported raw formats},
> >     +  to which these capabilities apply.
> >     +\item[\field{min_resources}]
> >     +  is the minimum number of resources that the RAW queue supports
> >     for all
> >     +  the specified raw formats.
> >     +\item[\field{max_resources}]
> >     +  is the maximum number of resources that the RAW queue supports
> >     for all
> >     +  the specified raw formats.
> >     +\end{description}
> >     +
> >     +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS=
:
> >     Resource capabilities}{Device Types / Video Device / Device
> >     Operation / Device Operation: Device Commands /
> >     VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS /
> >     VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Resource capabilities}
> >     +
> >     +\field{coded_formats_bitmask} MUST be a subset of
> >     \field{coded_formats_bitmask}
> >     +field of \field{struct virtio_video_device_query_caps_resp}.
> >     +
> >     +\field{coded_formats_bitmask} MUST specify at least one coded
> format.
> >     +
> >     +\field{raw_formats_bitmask} MUST be a subset of
> >     \field{raw_formats_bitmask}
> >     +field of \field{struct virtio_video_device_query_caps_resp}.
> >     +
> >     +\field{raw_formats_bitmask} MUST specify at least one raw format.
> >     +
> >     +\field{min_resources} MUST NOT be negative.
> >     +
> >     +\field{max_resources} MUST be greater then or equal to
> >     \field{min_resources}
> >     +within the same struct instance.
> >     +
> >     +\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Bitrates}
> >     +
> >     +The bitrate capabilities \field{virtio_video_bitrate_caps} is
> >     +defined as follows:
> >     +
> >     +\begin{lstlisting}
> >     +struct virtio_video_bitrate_caps {
> >     +        le32 coded_formats_bitmask; /* Bitmask of
> >     MASK(VIRTIO_VIDEO_CODED_FORMAT_*) */
> >     +        le32 min_bitrate;
> >     +        le32 max_bitrate;
> >     +        u8 padding[4];
> >     +};
> >     +\end{lstlisting}
> >     +
> >     +\begin{description}
> >     +\item[\field{coded_formats_bitmask}]
> >     +  specifies coded formats, see
> >     +  \ref{sec:Device Types / Video Device / Supported parameters /
> >     Supported coded formats},
> >     +  to which these capabilities apply.
> >     +\item[\field{min_bitrate}]
> >     +  is the minimum bitrate in bits per second supported by the
> >     encoder for all the specified coded
> >     +  formats.
> >     +\item[\field{max_bitrate}]
> >     +  is the maximum bitrate in bits per second supported by the
> >     encoder for all the specified coded
> >     +  formats.
> >     +\end{description}
> >     +
> >     +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS=
:
> >     Bitrates}{Device Types / Video Device / Device Operation / Device
> >     Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS /
> >     VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Bitrates}
> >     +
> >     +\field{coded_formats_bitmask} MUST be a subset of
> >     \field{coded_formats_bitmask}
> >     +field of \field{struct virtio_video_device_query_caps_resp}.
> >     +
> >     +\field{coded_formats_bitmask} MUST specify at least one coded
> format.
> >     +
> >     +\field{min_bitrate} MUST NOT be negative.
> >     +
> >     +\field{max_bitrate} MUST be greater then or equal to
> >     \field{min_bitrate}
> >     +within the same \field{struct virtio_video_bitrate_caps} instance.
> >     +
> >     +\subsubsection{Device Operation: Stream commands}
> >     +\label{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Stream commands}
> >     +
> >     +Stream commands allow the creation, destruction, and flow control
> of a
> >     +stream.
> >     +
> >     +\paragraph{VIRTIO_VIDEO_CMD_STREAM_CREATE}
> >     +\label{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_CREATE}
> >     +
> >     +Create a new stream using the device.
> >     +
> >     +The driver sends this command with
> >     +\field{struct virtio_video_stream_create}:
> >     +
> >     +\begin{lstlisting}
> >     +struct virtio_video_stream_create {
> >     +        le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_CREATE */
> >     +};
> >     +\end{lstlisting}
> >     +
> >     +The device responds with \field{struct
> >     virtio_video_stream_create_resp}:
> >     +
> >     +\begin{lstlisting}
> >     +struct virtio_video_stream_create_resp {
> >     +        le32 result; /* VIRTIO_VIDEO_RESULT_* */
> >     +        le32 stream_id;
> >     +};
> >     +\end{lstlisting}
> >     +
> >     +\begin{description}
> >     +\item[\field{result}]
> >     +  is
> >     +
> >     +  \begin{description}
> >     +  \item[VIRTIO_VIDEO_RESULT_OK]
> >     +    if the operation succeeded,
> >     +  \item[VIRTIO_VIDEO_RESULT_ERR_OUT_OF_MEMORY]
> >     +    if the limit of simultaneous streams has been reached by the
> >     device and
> >     +    no more can be created.
> >     +  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION]
> >     +    if the stream cannot be created due to an unexpected device
> issue.
> >     +  \end{description}
> >     +\item[\field{stream_id}]
> >     +  is the ID of the created stream allocated by the device.
> >     +\end{description}
> >     +
> >
>  +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_CREATE}{Device
> Types / Video Device / Device Operation / Device Operation: Stream comman=
ds
> / VIRTIO_VIDEO_CMD_STREAM_CREATE}
> >     +
> >     +\field{stream_id} MUST be set to a device-unique identifier that
> >     remains
> >     +valid as long as the stream is alive.
> >     +
> >     +\paragraph{VIRTIO_VIDEO_CMD_STREAM_DESTROY}
> >     +\label{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DESTROY}
> >     +
> >     +% DESTROY has to be more like RESET, not DRAIN, because it is
> >     called, for
> >     +% example, when the guest user-space app closes a file descriptor.
> >     So there
> >     +% is no sense in continuing the processing.
> >     +
> >     +Destroy a video stream and all its resources. Any activity on the
> >     stream
> >     +is halted and all resources are released by the time the delayed
> >     response is
> >     +received by the driver.
> >     +
> >     +The driver sends this command with
> >     +\field{struct virtio_video_stream_destroy}:
> >     +
> >     +\begin{lstlisting}
> >     +struct virtio_video_stream_destroy {
> >     +        le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_DESTROY */
> >     +        le32 stream_id;
> >     +};
> >     +\end{lstlisting}
> >     +
> >     +\begin{description}
> >     +\item[\field{stream_id}]
> >     +  is the ID of the stream to be destroyed, as previously returned =
by
> >     +  VIRTIO_VIDEO_CMD_STREAM_CREATE.
> >     +\end{description}
> >     +
> >     +The device responds as described in
> >     +\ref{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Command Virtqueue}
> >     +and begins the background DESTROY operation.
> >     +
> >     +When the command is completed the device sends the
> >     +VIRTIO_VIDEO_DELAYED_RESP_STREAM_DESTROY delayed response, see
> >     +\ref{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Event Virtqueue}.
> >     +The delayed response can also come in case of unrecoverable stream
> >     error, see
> >     +\ref{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Standalone Events / Error Event}.
> >     +
> >
>  +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_DESTROY}{Device
> Types / Video Device / Device Operation / Device Operation: Stream comman=
ds
> / VIRTIO_VIDEO_CMD_STREAM_DESTROY}
> >     +
> >     +Before the device sends a delayed response to
> >     VIRTIO_VIDEO_CMD_STREAM_DESTROY,
> >     +it MUST send all other pending delayed responses with
> >     +VIRTIO_VIDEO_EVENT_FLAG_CANCELED flag set and detach all resources=
.
> >     +
> >     +After VIRTIO_VIDEO_CMD_STREAM_DESTROY is queued, the device MUST
> >     reply with
> >     +VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID to any subsequently
> >     queued command
> >     +with this stream ID.
> >     +
> >     +The DESTROY operation MUST NOT be canceled.
> >     +
> >
>  +\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_DESTROY}{Device
> Types / Video Device / Device Operation / Device Operation: Stream comman=
ds
> / VIRTIO_VIDEO_CMD_STREAM_DESTROY}
> >     +
> >     +\field{stream_id} MUST be set to a valid stream ID previously
> returned
> >     +by VIRTIO_VIDEO_CMD_STREAM_CREATE.
> >     +
> >     +The driver MUST stop using \field{stream_id} as a valid stream
> after it
> >     +received the delayed response to this command.
> >     +
> >     +\paragraph{VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}
> >     +\label{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}
> >     +
> >     +Write values of selected parameters of a given stream, and receive
> >     back the
> >     +values for all the parameters supported by the device as reported =
by
> >     +\ref{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.
> >     +The operation can be either executed immediately, or queued into
> >     the INPUT
> >     +queue, i.e. after processing all the INPUT queue elements that are
> >     queued
> >     +before the command.
> >     +
> >     +The driver sends this command with
> >     +\field{struct virtio_video_stream_set_params}:
> >     +
> >     +\begin{lstlisting}
> >     +#define VIRTIO_VIDEO_SET_PARAMS_FLAG_IN_BAND  (1 << 0)
> >     +
> >     +struct virtio_video_stream_set_params {
> >     +        le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS */
> >     +        le32 stream_id;
> >     +        le32 flags; /* Bitmask of VIRTIO_VIDEO_SET_PARAMS_FLAG_* *=
/
> >     +        u8 padding[4];
> >     +        struct virtio_video_params params;
> >     +};
> >     +\end{lstlisting}
> >     +
> >     +\begin{description}
> >     +\item[\field{stream_id}]
> >     +  is the ID of the stream we want to set a parameter for.
> >     +\item[\field{flags}]
> >     +  is a bitmask of VIRTIO_VIDEO_SET_PARAMS_FLAG_* values.
> >     +
> >     +  \begin{description}
> >     +  \item[\field{VIRTIO_VIDEO_SET_PARAMS_FLAG_IN_BAND}]
> >     +    The submitted parameters are to be set only after all of the
> >     previously
> >     +    queued INPUT queue elements are processed. Without this flag t=
he
> >     +    parameters are set Immediately.
> >     +  \end{description}
> >     +\item[\field{params}]
> >     +  is a container for the selected stream parameters to be set.
> >     +\end{description}
> >     +
> >     +The device responds as described in
> >     +\ref{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Command Virtqueue}
> >     +and begins the background SET_PARAMS operation.
> >     +
> >     +When the background processing of the resource is completed the
> >     device sends
> >     +the VIRTIO_VIDEO_DELAYED_RESP_STREAM_SET_PARAMS delayed response,
> see
> >     +\ref{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Event Virtqueue}.
> >     +The delayed response can also come in case of dynamic parameters
> >     change, see
> >     +\ref{sec:Device Types / Video Device / Device Operation / Device
> >     Operation: Standalone Events / Dynamic Parameters Change Event}.
> >     +
> >     +The command-specific delayed response
> >     +\field{struct virtio_video_stream_set_params_delayed_resp} is
> defined
> >     +as follows:
> >     +
> >     +\begin{lstlisting}
> >     +struct virtio_video_stream_set_params_delayed_resp {
> >     +        struct virtio_video_params params;
> >     +};
> >     +\end{lstlisting}
> >     +
> >     +\begin{description}
> >     +\item[\field{params}]
> >     +  is a container for the actual values of all the parameters
> >     supported by the
> >     +  device. The values set by the device may differ from the
> >     requested values
> >     +  depending on the device's capabilities.
> >     +\end{description}
> >     +
> >     +The \field{struct virtio_video_params} is defined as follows:
> >     +
> >     +\begin{lstlisting}
> >     +struct virtio_video_raw_format {
> >     +        le32 format;
> >     +        le32 planes_layout; /* VIRTIO_VIDEO_PLANES_LAYOUT_* */
> >     +        le32 stride;
> >     +        le32 width;
> >     +        le32 height;
> >     +        u8 padding[4];
> >     +};
> >     +
> >     +struct virtio_video_param_crop {
> >     +        le32 left;
> >     +        le32 top;
> >     +        le32 width;
> >     +        le32 height;
> >     +};
> >     +
> >     +union virtio_video_codec_params {
> >     +        struct virtio_video_mpeg2_params mpeg2;
> >     +        struct virtio_video_mpeg4_params mpeg4;
> >     +        struct virtio_video_h264_params h264;
> >     +        struct virtio_video_hevc_params hevc;
> >     +        struct virtio_video_vp8_params vp8;
> >     +        struct virtio_video_vp9_params vp9;
> >     +};
> >     +
> >     +struct virtio_video_params {
> >     +        le32 stream_params_bitmask; /* Bitmask of
> >     MASK(VIRTIO_VIDEO_PARAM_*) */
> >     +        le32 coded_format; /* If
> >     MASK(VIRTIO_VIDEO_PARAM_CODED_FORMAT) is set. */
> >     +        /* If MASK(VIRTIO_VIDEO_PARAM_RAW_FORMAT) is set. */
> >     +        struct virtio_video_raw_format raw_format;
> >     +        /* If MASK(VIRTIO_VIDEO_PARAM_CODED_RESOURCES) is set. */
> >     +        struct virtio_video_param_resources coded_resources;
> >     +        /* If MASK(VIRTIO_VIDEO_PARAM_RAW_RESOURCES) is set. */
> >     +        struct virtio_video_param_resources raw_resources;
> >     +        struct virtio_video_param_crop crop; /* If
> >     MASK(VIRTIO_VIDEO_PARAM_CROP) is set. */
> >     +        le32 bitrate; /* If MASK(VIRTIO_VIDEO_PARAM_BITRATE) is
> set. */
> >     +        u8 padding[4];
> >     +        /* If the corresponding
> >     MASK(VIRTIO_VIDEO_PARAM_GROUP_CODEC_*) is set
> >     +        * depending on the coded_format. */
> >     +        union virtio_video_codec_params codec;
> >     +};
> >     +\end{lstlisting}
> >
> >
> > This is a bit difficult to read for me, as some of the *if* comments ar=
e
> > written AFTER
> > the member definition, and some others BEFORE the member defintion.
> > Above, when introducing the VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS command,
> > you use this format for the conditional fields:
> > /**
> > * Followed by if MASK(VIRTIO_VIDEO_PARAM_BITRATE) is set
> > * struct virtio_video_bitrate_caps bitrate_caps[num_bitrate_caps];
> > */
> > It spaces a bit more the members, and leaves them as part of the
> > comment block. I would suggest to keep the format consistent.
>
> Ack, I'll try to make it more readable.
> Also given the extendability concerns, that I explained above, I'd like
> to maybe finish combining all the parameters into groups and then to
> make the SET_PARAMS command operating on the parameter group level.
> Still thinking about this...
>
> --
> Alexander Gordeev
> Senior Software Engineer
>
> OpenSynergy GmbH
> Rotherstr. 20, 10245 Berlin
>
> Phone: +49 30 60 98 54 0 - 88
> Fax: +49 (30) 60 98 54 0 - 99
> EMail: alexander.gordeev@opensynergy.com
>
> www.opensynergy.com
>
> Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB
> 108616B
> Gesch=C3=A4ftsf=C3=BChrer/Managing Director: R=C3=A9gis Adjamah
>
>

--0000000000003e9d2e060164b9e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 10, 2023 at 10:52=
=E2=80=AFAM Alexander Gordeev &lt;<a href=3D"mailto:alexander.gordeev@opens=
ynergy.com" target=3D"_blank">alexander.gordeev@opensynergy.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Albert,<b=
r>
<br>
On 06.07.23 16:59, Albert Esteve wrote:<br>
&gt; Hi Alexander,<br>
&gt; <br>
&gt; Thanks for the patch! It is a long document, so I skimmed a bit in the=
 <br>
&gt; first=C2=A0read. Find some comments/questions inlined.<br>
&gt; I will give it a second deeper read soon, but overall I think is in <b=
r>
&gt; quite good shape. It feels really matured.<br>
<br>
Great! Thank you for taking the time to review it.<br>
<br>
&gt; On Thu, Jun 29, 2023 at 4:49=E2=80=AFPM Alexander Gordeev <br>
&gt; &lt;<a href=3D"mailto:Alexander.Gordeev@opensynergy.com" target=3D"_bl=
ank">Alexander.Gordeev@opensynergy.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:Alexander.Gordeev@opensynergy.com" target=
=3D"_blank">Alexander.Gordeev@opensynergy.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Add the specification of the video decoder and enco=
der devices, which<br>
&gt;=C2=A0 =C2=A0 =C2=A0can be used to provide host-accelerated video opera=
tions to the guest.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Alexander Gordeev &lt;<a href=3D"mai=
lto:Alexander.Gordeev@opensynergy.com" target=3D"_blank">Alexander.Gordeev@=
opensynergy.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:Alexander.Gordeev@open=
synergy.com" target=3D"_blank">Alexander.Gordeev@opensynergy.com</a>&gt;&gt=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Co-authored-by: Keiichi Watanabe &lt;<a href=3D"mai=
lto:keiichiw@chromium.org" target=3D"_blank">keiichiw@chromium.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:keiichiw@chromium.org"=
 target=3D"_blank">keiichiw@chromium.org</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Co-authored-by: Alexandre Courbot &lt;<a href=3D"ma=
ilto:acourbot@chromium.org" target=3D"_blank">acourbot@chromium.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:acourbot@chromium.org"=
 target=3D"_blank">acourbot@chromium.org</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0conformance.tex=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A0 4 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0content.tex=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0device-types/video/description.tex=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 2040 +++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0device-types/video/device-conformance.tex |=
=C2=A0 =C2=A022 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0device-types/video/driver-conformance.tex |=
=C2=A0 =C2=A016 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0introduction.tex=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A021 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A06 files changed, 2104 insertions(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 device-types/video/descri=
ption.tex<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 device-types/video/device=
-conformance.tex<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 device-types/video/driver=
-conformance.tex<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/conformance.tex b/conformance.tex<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 01ccd69..d719eda 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/conformance.tex<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/conformance.tex<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -34,6 +34,7 @@ \section{Conformance<br>
&gt;=C2=A0 =C2=A0 =C2=A0Targets}\label{sec:Conformance / Conformance Target=
s}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\ref{sec:Conformance / Driver Conformance / =
SCMI Driver Conformance},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\ref{sec:Conformance / Driver Conformance / =
GPIO Driver<br>
&gt;=C2=A0 =C2=A0 =C2=A0Conformance} or<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\ref{sec:Conformance / Driver Conformance / =
PMEM Driver Conformance}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\ref{sec:Conformance / Driver Conformance / Video =
Driver Conformance},<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\item Clause \ref{sec:Conforma=
nce / Legacy Interface:<br>
&gt;=C2=A0 =C2=A0 =C2=A0Transitional Device and Transitional Driver Conform=
ance}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\end{itemize}<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -61,6 +62,7 @@ \section{Conformance<br>
&gt;=C2=A0 =C2=A0 =C2=A0Targets}\label{sec:Conformance / Conformance Target=
s}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\ref{sec:Conformance / Device Conformance / =
SCMI Device Conformance},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\ref{sec:Conformance / Device Conformance / =
GPIO Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Conformance} or<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\ref{sec:Conformance / Device Conformance / =
PMEM Device Conformance}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\ref{sec:Conformance / Device Conformance / Video =
Device Conformance},<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\item Clause \ref{sec:Conforma=
nce / Legacy Interface:<br>
&gt;=C2=A0 =C2=A0 =C2=A0Transitional Device and Transitional Driver Conform=
ance}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\end{itemize}<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -152,6 +154,7 @@ \section{Conformance<br>
&gt;=C2=A0 =C2=A0 =C2=A0Targets}\label{sec:Conformance / Conformance Target=
s}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\input{device-types/scmi/driver-conformance.=
tex}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\input{device-types/gpio/driver-conformance.=
tex}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\input{device-types/pmem/driver-conformance.=
tex}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\input{device-types/video/driver-conformance.tex}<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\conformance{\section}{Device Conformance}\l=
abel{sec:Conformance /<br>
&gt;=C2=A0 =C2=A0 =C2=A0Device Conformance}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -238,6 +241,7 @@ \section{Conformance<br>
&gt;=C2=A0 =C2=A0 =C2=A0Targets}\label{sec:Conformance / Conformance Target=
s}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\input{device-types/scmi/device-conformance.=
tex}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\input{device-types/gpio/device-conformance.=
tex}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\input{device-types/pmem/device-conformance.=
tex}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\input{device-types/video/device-conformance.tex}<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\conformance{\section}{Legacy Interface: Tra=
nsitional Device and<br>
&gt;=C2=A0 =C2=A0 =C2=A0Transitional Driver Conformance}\label{sec:Conforma=
nce / Legacy<br>
&gt;=C2=A0 =C2=A0 =C2=A0Interface: Transitional Device and Transitional Dri=
ver Conformance}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0A conformant implementation MUST be either t=
ransitional or<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/content.tex b/content.tex<br>
&gt;=C2=A0 =C2=A0 =C2=A0index d2ab9eb..90708d7 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/content.tex<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/content.tex<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -765,6 +765,7 @@ \chapter{Device Types}\label{se=
c:Device Types}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\input{device-types/scmi/description.tex}<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\input{device-types/gpio/description.tex}<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\input{device-types/pmem/description.tex}<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+\input{device-types/video/description.tex}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\chapter{Reserved Feature Bits}\label{sec:Re=
served Feature Bits}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/device-types/video/description.tex<br>
&gt;=C2=A0 =C2=A0 =C2=A0b/device-types/video/description.tex<br>
&gt;=C2=A0 =C2=A0 =C2=A0new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 0000000..760df7f<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/device-types/video/description.tex<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -0,0 +1,2040 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\section{Video Device}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The virtio video encoder and decoder devices provi=
de support for<br>
&gt;=C2=A0 =C2=A0 =C2=A0+host-accelerated video encoding and decoding. Desp=
ite being different<br>
&gt;=C2=A0 =C2=A0 =C2=A0+device types, they use the same protocol and gener=
al flow.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\subsection{Device ID}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Device ID=
}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[30]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 encoder device<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[31]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 decoder device<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\subsection{Virtqueues}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Virtqueue=
s}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[0]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 commandq - queue for driver commands and de=
vice responses to<br>
&gt;=C2=A0 =C2=A0 =C2=A0these commands<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[1]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 eventq - queue for device delayed responses=
 to commands and<br>
&gt;=C2=A0 =C2=A0 =C2=A0standalone<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 device events<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\subsection{Feature bits}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Feature b=
its}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES (0)]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 Guest pages can be used as the backing memo=
ry of resources.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG (1)]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 The device can use non-contiguous guest mem=
ory as the backing<br>
&gt;=C2=A0 =C2=A0 =C2=A0memory of<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 resources. Only meaningful if VIRTIO_VIDEO_=
F_RESOURCE_GUEST_PAGES<br>
&gt;=C2=A0 =C2=A0 =C2=A0is also<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 set.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT (2)]<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 Objects exported by another virtio device c=
an be used as the<br>
&gt;=C2=A0 =C2=A0 =C2=A0backing memory<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 of resources.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[VIRTIO_VIDEO_F_RESOURCE_DYNAMIC (3)]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 The device supports re-attaching memory to =
resources while streaming.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% TODO this flag is not used anywhere at the momen=
t.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% Might be necessary with Android.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{description}<br>
&gt; <br>
&gt; <br>
&gt; Maybe I am missing part of the previous dicussion, but is=C2=A0this <b=
r>
&gt; VIRTIO_VIDEO_F_RESOURCE_DYNAMIC flag new?<br>
&gt; Not sure what re-attaching memory means and what the flag is supossed=
=C2=A0to do.<br>
&gt; In the comment you mention specifically Android, so it got me curious.=
 <br>
&gt; What is the usecase=C2=A0for this feature flag?<br>
<br>
This flag first appeared in draft v6, but it is still not used anywhere <br=
>
in the text. I&#39;m almost sure I know why it was added by Alexandre. Our =
<br>
experince with Android&#39;s Codec2 and v4l2_codec2 shows that something <b=
r>
like this can happen:<br>
<br>
1. The V4L2 device is opened. For example, a decoder.<br>
2. All parameters and buffers are set up. Both queues are started.<br>
3. A buffer is queued and then dequeued later. From this moment it <br>
&quot;belongs&quot; to the guest user-space.<br>
4. This opportunity is used to detach the buffer&#39;s memory and attach <b=
r>
some different chunks of memory.<br>
5. Then the buffer is queued again. And so on.<br>
<br>
The problem here is that according to V4L2 conventions the old memory is <b=
r>
expected to not be modified after it is dequeued because it could be <br>
used as a reference in the decoding process. Unfortunately these <br>
conventions were rather informal until recently AFAIU. Here is the <br>
patch, that adds this and an interesting discussuin related to the <br>
issue: <br>
<a href=3D"https://lore.kernel.org/all/20211018091427.88468-1-acourbot@chro=
mium.org/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/all=
/20211018091427.88468-1-acourbot@chromium.org/</a><br>
<br>
So the way it is done in Android could be problematic. So the driver <br>
should probably forbid the reattaching unless the queue is stopped. But <br=
>
if the virtio video device is, for example, always doing a pixel format <br=
>
conversion after the decoding, then it is OK to reattach the memory. In <br=
>
this case the device can advertise the VIRTIO_VIDEO_F_RESOURCE_DYNAMIC <br>
flag to notify the driver, that the memory could be safely reattached. <br>
Maybe this is not the best way to deal with this, see the discussion at <br=
>
the link above. At least it is not very invasive.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\devicenormative{\subsubsection}{Feature bits}{Dev=
ice Types / Video<br>
&gt;=C2=A0 =C2=A0 =C2=A0Device / Feature bits}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The device MUST set at least one of<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES or<br>
&gt;=C2=A0 =C2=A0 =C2=A0+VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT, since the a=
bsence of both<br>
&gt;=C2=A0 =C2=A0 =C2=A0bits would<br>
&gt;=C2=A0 =C2=A0 =C2=A0+mean that no memory can be used at all for resourc=
es.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The device MUST NOT set VIRTIO_VIDEO_F_RESOURCE_NO=
N_CONTIG unless<br>
&gt;=C2=A0 =C2=A0 =C2=A0it also sets<br>
&gt;=C2=A0 =C2=A0 =C2=A0+VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\drivernormative{\subsubsection}{Feature bits}{Dev=
ice Types / Video<br>
&gt;=C2=A0 =C2=A0 =C2=A0Device / Feature bits}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The driver MUST negotiate at least one of the<br>
&gt;=C2=A0 =C2=A0 =C2=A0+VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES and<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT<br>
&gt;=C2=A0 =C2=A0 =C2=A0+features.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+If VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES has been ne=
gotiated, but not<br>
&gt;=C2=A0 =C2=A0 =C2=A0+VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG, the driver MUS=
T use physically<br>
&gt;=C2=A0 =C2=A0 =C2=A0+contiguous memory for all the buffers it allocates=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\subsection{Device configuration layout}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Device co=
nfiguration layout}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The video device configuration space uses the foll=
owing layout:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_config {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 caps_length;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{caps_length}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the minimum length in bytes that a devic=
e-writable buffer must<br>
&gt;=C2=A0 =C2=A0 =C2=A0have<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 in order to receive the response to<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \ref{sec:Device Types / Video Device / Devi=
ce Operation / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVIC=
E_QUERY_CAPS}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\devicenormative{\subsubsection}{Device configurat=
ion<br>
&gt;=C2=A0 =C2=A0 =C2=A0layout}{Device Types / Video Device / Device config=
uration layout}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The device MUST set the \field{caps_length} field =
to a value equal to<br>
&gt;=C2=A0 =C2=A0 =C2=A0+the response size of VIRTIO_VIDEO_CMD_DEVICE_QUERY=
_CAPS.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\subsection{Supported parameters}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Supported=
 parameters}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\subsubsection{Supported coded formats}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Supported=
 parameters /<br>
&gt;=C2=A0 =C2=A0 =C2=A0Supported coded formats}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The following coded formats are defined:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_CODED_FORMAT_MPEG2=C2=A0 1=C2=
=A0 /* MPEG-2 Part 2 <br>
&gt;=C2=A0 =C2=A0 =C2=A0(V4L2_PIX_FMT_MPEG2) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_CODED_FORMAT_MPEG4=C2=A0 2=C2=
=A0 /* MPEG-4 Part 2 <br>
&gt;=C2=A0 =C2=A0 =C2=A0(V4L2_PIX_FMT_MPEG4) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_CODED_FORMAT_H264=C2=A0 =C2=
=A03=C2=A0 /* H.264=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0(V4L2_PIX_FMT_H264)=C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_CODED_FORMAT_HEVC=C2=A0 =C2=
=A04=C2=A0 /* HEVC aka H.265<br>
&gt;=C2=A0 =C2=A0 =C2=A0(V4L2_PIX_FMT_HEVC)=C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_CODED_FORMAT_VP8=C2=A0 =C2=A0=
 5=C2=A0 /* VP8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0(V4L2_PIX_FMT_VP8)=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_CODED_FORMAT_VP9=C2=A0 =C2=A0=
 6=C2=A0 /* VP9=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0(V4L2_PIX_FMT_VP9)=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The above constants have two usages:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{enumerate}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item As bit numbers, used to tell the driver whic=
h coded formats are<br>
&gt;=C2=A0 =C2=A0 =C2=A0+supported by the device, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\ref{sec:Device Types / Video Device / Device Oper=
ation / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVIC=
E_QUERY_CAPS}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item As values, used to designate the coded forma=
t when working with<br>
&gt;=C2=A0 =C2=A0 =C2=A0+stream parameters, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\ref{sec:Device Types / Video Device / Device Oper=
ation / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Stream commands / VIRTIO_VIDEO_CMD_STREA=
M_SET_PARAMS}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{enumerate}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The coded formats and the expected data units per =
buffer are<br>
&gt;=C2=A0 =C2=A0 =C2=A0documented in<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\hyperref[intro:V4L2]{V4L2 header} and<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\hyperref[intro:V4L2 compressed]{V4L2 compressed f=
ormats<br>
&gt;=C2=A0 =C2=A0 =C2=A0documentation}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\subsubsection{Supported raw formats}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Supported=
 parameters /<br>
&gt;=C2=A0 =C2=A0 =C2=A0Supported raw formats}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The following raw formats are defined:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_RAW_FORMAT_ARGB8888=C2=A0 1=
=C2=A0 /* DRM_FORMAT_ARGB8888<br>
&gt;=C2=A0 =C2=A0 =C2=A0/ V4L2_PIX_FMT_ABGR32 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_RAW_FORMAT_BGRA8888=C2=A0 2=
=C2=A0 /* DRM_FORMAT_BGRA8888<br>
&gt;=C2=A0 =C2=A0 =C2=A0/ V4L2_PIX_FMT_ARGB32 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_RAW_FORMAT_RGBA8888=C2=A0 3=
=C2=A0 /* DRM_FORMAT_RGBA8888<br>
&gt;=C2=A0 =C2=A0 =C2=A0/ V4L2_PIX_FMT_BGRA32 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_RAW_FORMAT_NV12=C2=A0 =C2=A0 =
=C2=A0 4=C2=A0 /* DRM_FORMAT_NV12=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/ V4L2_PIX_FMT_NV12=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_RAW_FORMAT_YUV420=C2=A0 =C2=
=A0 5=C2=A0 /* DRM_FORMAT_YUV420 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/ V4L2_PIX_FMT_YUV420 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_RAW_FORMAT_YVU420=C2=A0 =C2=
=A0 6=C2=A0 /* DRM_FORMAT_YVU420 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/ V4L2_PIX_FMT_YVU420 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_RAW_FORMAT_YUYV=C2=A0 =C2=A0 =
=C2=A0 7=C2=A0 /* DRM_FORMAT_YUYV=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/ V4L2_PIX_FMT_YUYV=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The above constants have two usages:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{enumerate}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item As bit numbers, used to tell the driver whic=
h raw formats are<br>
&gt;=C2=A0 =C2=A0 =C2=A0+supported by the device, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\ref{sec:Device Types / Video Device / Device Oper=
ation / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVIC=
E_QUERY_CAPS}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item As values, used to designate the raw format =
when working with<br>
&gt;=C2=A0 =C2=A0 =C2=A0+stream parameters, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\ref{sec:Device Types / Video Device / Device Oper=
ation / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Stream commands / VIRTIO_VIDEO_CMD_STREA=
M_SET_PARAMS}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{enumerate}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The layouts of raw formats are documented in \hype=
rref[intro:DRM<br>
&gt;=C2=A0 =C2=A0 =C2=A0formats]{DRM}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+and \hyperref[intro:V4L2]{V4L2} headers, as well a=
s in<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\hyperref[intro:V4L2 RGB]{V4L2 RGB} and<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\hyperref[intro:V4L2 YUV]{planar YUV} formats docu=
mentation.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\subsubsection{Supported stream parameters}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Supported=
 parameters /<br>
&gt;=C2=A0 =C2=A0 =C2=A0Supported stream parameters}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The following stream parameters are defined:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_PARAM_CODED_FORMAT=C2=A0 =C2=
=A0 =C2=A0 =C2=A01<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_PARAM_RAW_FORMAT=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A02<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_PARAM_CODED_RESOURCES=C2=A0 =
=C2=A0 3<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_PARAM_RAW_RESOURCES=C2=A0 =C2=
=A0 =C2=A0 4<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_PARAM_CROP=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_PARAM_BITRATE=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 6=C2=A0 /* Same as<br>
&gt;=C2=A0 =C2=A0 =C2=A0V4L2_CID_MPEG_VIDEO_BITRATE */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_MPEG2=C2=A0=
 7<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_MPEG4=C2=A0=
 8<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_H264=C2=A0 =
=C2=A09<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_HEVC=C2=A0 =
=C2=A010<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_VP8=C2=A0 =
=C2=A0 11<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_VP9=C2=A0 =
=C2=A0 12<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% TODO acourbot: See b/241492607 (fractional frame=
 rates??)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The above constants have two usages:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{enumerate}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item As bit numbers, used to tell the driver whic=
h stream<br>
&gt;=C2=A0 =C2=A0 =C2=A0parameters are<br>
&gt;=C2=A0 =C2=A0 =C2=A0+supported by the device, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\ref{sec:Device Types / Video Device / Device Oper=
ation / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVIC=
E_QUERY_CAPS}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item As values, used to designate the stream para=
meters when<br>
&gt;=C2=A0 =C2=A0 =C2=A0working with<br>
&gt;=C2=A0 =C2=A0 =C2=A0+them, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\ref{sec:Device Types / Video Device / Device Oper=
ation / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Stream commands / VIRTIO_VIDEO_CMD_STREA=
M_SET_PARAMS}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{enumerate}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\subsection{Device Initialization}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Device In=
itialization}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{enumerate}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\def\labelenumi{\arabic{enumi}.}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 The driver reads the feature bits and negot=
iates the features it<br>
&gt;=C2=A0 =C2=A0 =C2=A0needs.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 The driver sets up the commandq and the eve=
ntq.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 The driver reads the \field{caps_length} fi=
eld of the configuration<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 space and prepares a buffer of at least tha=
t size.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 The driver sends that buffer on the command=
q with the<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS command.=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 The driver receives the response from the d=
evice, and parses its<br>
&gt;=C2=A0 =C2=A0 =C2=A0capabilities.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{enumerate}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\subsection{Device Operation}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Device Op=
eration}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The commandq is used by the driver to send command=
s to the device<br>
&gt;=C2=A0 =C2=A0 =C2=A0and to<br>
&gt;=C2=A0 =C2=A0 =C2=A0+receive the device&#39;s responses via used buffer=
s. The eventq is used<br>
&gt;=C2=A0 =C2=A0 =C2=A0by the<br>
&gt;=C2=A0 =C2=A0 =C2=A0+device to send the device&#39;s delayed responses =
to commands and<br>
&gt;=C2=A0 =C2=A0 =C2=A0standalone<br>
&gt;=C2=A0 =C2=A0 =C2=A0+device events.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The driver can create new streams using the<br>
&gt;=C2=A0 =C2=A0 =C2=A0+VIRTIO_VIDEO_CMD_STREAM_CREATE command. Each strea=
m has two resource<br>
&gt;=C2=A0 =C2=A0 =C2=A0+queues (not to be confused with the virtio queues)=
 called INPUT and<br>
&gt;=C2=A0 =C2=A0 =C2=A0+OUTPUT, when the direction of the data flow matter=
s. The INPUT<br>
&gt;=C2=A0 =C2=A0 =C2=A0queue accepts<br>
&gt;=C2=A0 =C2=A0 =C2=A0+driver-filled input data for the device (coded dat=
a for a decoder;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+input frames for an encoder), while the OUTPUT que=
ue receives<br>
&gt;=C2=A0 =C2=A0 =C2=A0resources to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0+filled by the device as a result of processing the=
 INPUT queue<br>
&gt;=C2=A0 =C2=A0 =C2=A0(decoded raw<br>
&gt;=C2=A0 =C2=A0 =C2=A0+frames for a decoder; encoded data for an encoder)=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+These same queues can be also called CODED and RAW=
, when their<br>
&gt;=C2=A0 =C2=A0 =C2=A0content matters.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The CODED queue is used to transfer compressed vid=
eo data (INPUT<br>
&gt;=C2=A0 =C2=A0 =C2=A0for a decoder;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+OUTPUT for an encoder), while the RAW queue is use=
d to transfer raw<br>
&gt;=C2=A0 =C2=A0 =C2=A0frames<br>
&gt;=C2=A0 =C2=A0 =C2=A0+(OUTPUT for a decoder; INPUT for an encoder).<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The INPUT and OUTPUT queues are effectively indepe=
ndent, and the driver<br>
&gt;=C2=A0 =C2=A0 =C2=A0+can fill them without caring about the other queue=
. In particular there<br>
&gt;=C2=A0 =C2=A0 =C2=A0+is no need to queue input and output resources in =
pairs: one input<br>
&gt;=C2=A0 =C2=A0 =C2=A0+resource can result in zero to many produced outpu=
t resources.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+A resource is a set of memory buffers that contain=
 a unit of data that<br>
&gt;=C2=A0 =C2=A0 =C2=A0+the device can process or produce. Most resources =
will only have one<br>
&gt;=C2=A0 =C2=A0 =C2=A0+buffer (like coded data and single-planar raw fram=
es), but frames<br>
&gt;=C2=A0 =C2=A0 =C2=A0using a<br>
&gt;=C2=A0 =C2=A0 =C2=A0+multi-planar format can have several.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+Parameters allow the driver to configure the strea=
m for the decoding or<br>
&gt;=C2=A0 =C2=A0 =C2=A0+encoding operation. The parameters can be obtained=
 and configured using<br>
&gt;=C2=A0 =C2=A0 =C2=A0+VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS. Available para=
meters depend on<br>
&gt;=C2=A0 =C2=A0 =C2=A0+the device type and are detailed in section<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\ref{sec:Device Types / Video Device / Supported p=
arameters /<br>
&gt;=C2=A0 =C2=A0 =C2=A0Supported stream parameters}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+Before resources can be submitted to a queue, back=
ing memory must be<br>
&gt;=C2=A0 =C2=A0 =C2=A0+attached to them using VIRTIO_VIDEO_CMD_RESOURCE_A=
TTACH_BACKING.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The exact form of that memory is negotiated using =
the feature flags.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+In the case of a decoder device, the decoded frame=
s are made available<br>
&gt;=C2=A0 =C2=A0 =C2=A0+on the OUTPUT queue in presentation order.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+Resources are queued to the INPUT or OUTPUT queue =
using the<br>
&gt;=C2=A0 =C2=A0 =C2=A0+VIRTIO_VIDEO_CMD_RESOURCE_QUEUE command. The devic=
e sends a delayed<br>
&gt;=C2=A0 =C2=A0 =C2=A0response<br>
&gt;=C2=A0 =C2=A0 =C2=A0+to this command when an input resource has been fu=
lly processed and<br>
&gt;=C2=A0 =C2=A0 =C2=A0can be<br>
&gt;=C2=A0 =C2=A0 =C2=A0+reused by the driver, or when an output resource h=
as been filled by the<br>
&gt;=C2=A0 =C2=A0 =C2=A0+device as a result of processing.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The device can detect stream-related events that r=
equire intervention<br>
&gt;=C2=A0 =C2=A0 =C2=A0+from the driver and signals them on the eventq, se=
e<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\ref{sec:Device Types / Video Device / Device Oper=
ation / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Standalone Events}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+One example is a dynamic parameters change while d=
ecoding a stream,<br>
&gt;=C2=A0 =C2=A0 =C2=A0which<br>
&gt;=C2=A0 =C2=A0 =C2=A0+may require the driver to reallocate the backing m=
emory of its output<br>
&gt;=C2=A0 =C2=A0 =C2=A0+resources to fit the new resolution.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% RESET and DRAIN have essentially the same outcom=
e: all the input<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% resources queued before the command are released=
, there are no<br>
&gt;=C2=A0 =C2=A0 =C2=A0related<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% output resources in the decoder/encoder, the deq=
ueued output<br>
&gt;=C2=A0 =C2=A0 =C2=A0resources<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% can&#39;t be used as a reference by the device. =
So the other<br>
&gt;=C2=A0 =C2=A0 =C2=A0requirements should<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% be reasonably similar.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% Use-case: playback in a loop from second 1 till =
the end of file.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% TODO put some examples in the comments<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\subsubsection{Device Operation: Command Virtqueue=
}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Device Op=
eration / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Command Virtqueue}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+This section details the commands that can be sent=
 on the commandq by<br>
&gt;=C2=A0 =C2=A0 =C2=A0+the driver, as well as the responses that the devi=
ce will write.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+Different structures are used for each command and=
 response. A command<br>
&gt;=C2=A0 =C2=A0 =C2=A0+structure starts with the requested command code, =
defined as follows:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+/* Device */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS=C2=A0 =
=C2=A0 =C2=A0 =C2=A00x100<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+/* Stream */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_CMD_STREAM_CREATE=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x200<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_CMD_STREAM_DESTROY=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0x201<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS=C2=A0 =
=C2=A0 =C2=A0 =C2=A00x202<br>
&gt; <br>
&gt; <br>
&gt; Why not having a GET_PARAMS counterpart?<br>
<br>
With the current approach to setting the parameters GET_PARAMS would be <br=
>
almost exactly the same as SET_PARAMS if params.stream_params_bitmask is <b=
r>
set to zero. So I assumed that it is better to save the space and remove <b=
r>
the GET_PARAMS counterpart since the length of the spec is already a <br>
sensitive topic.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_CMD_STREAM_DRAIN=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x203<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_CMD_STREAM_RESET=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x204<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+/* Resource */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING 0=
x300<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_CMD_RESOURCE_QUEUE=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0x301<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+A response structure starts with the result of the=
 requested command,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+defined as follows:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+/* Success */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_RESULT_OK=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00=
0<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_RESULT_OK_DELAYED=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x001<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+/* Error */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_RESULT_ERR_INVALID_COMMAND=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x100<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION=
=C2=A0 =C2=A0 =C2=A0 =C2=A00x101<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID=
=C2=A0 =C2=A0 =C2=A0 =C2=A00x102<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_RESULT_ERR_INVALID_RESOURCE_I=
D=C2=A0 =C2=A0 =C2=A00x103<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_RESULT_ERR_INVALID_ARGUMENT=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x104<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_RESULT_ERR_OUT_OF_MEMORY=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x105<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+For response structures carrying an error code, th=
e rest of the<br>
&gt;=C2=A0 =C2=A0 =C2=A0+structure is considered invalid.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+For all commands beginning background operations a=
nd returning delayed<br>
&gt;=C2=A0 =C2=A0 =C2=A0+responses over eventq, the command response is def=
ined as follows:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_INVALID_RESPONSE_ID=C2=A0 0xf=
fffffff<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_command_resp_delayed_common {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 result; /* VIRTIO=
_VIDEO_RESULT_* */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 delayed_response_=
id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{result}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \item[VIRTIO_VIDEO_RESULT_OK_DELAYED]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if the command started the desired b=
ackground operation<br>
&gt;=C2=A0 =C2=A0 =C2=A0successfully,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_STREA=
M_ID]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if the mentioned stream ID does not =
exist,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_RESOU=
RCE_ID]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if the mentioned resource ID does no=
t exist,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_ARGUM=
ENT]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if other command parameters are not =
valid, e.g. not within the<br>
&gt;=C2=A0 =C2=A0 =C2=A0device&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 capabilities,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERA=
TION]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if the command is performed at a tim=
e when it is not valid.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{delayed_response_id}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is an ID of the future delayed response pro=
vided by the device,<br>
&gt;=C2=A0 =C2=A0 =C2=A0that allows<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 to relate it to the command.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\devicenormative{\paragraph}{Device Operation: Com=
mand<br>
&gt;=C2=A0 =C2=A0 =C2=A0Virtqueue}{Device Types / Video Device / Device Ope=
ration / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Command Virtqueue}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+Responses to a command MUST be written by the devi=
ce in the first<br>
&gt;=C2=A0 =C2=A0 =C2=A0+device-writable descriptor of the descriptor chain=
 from which the<br>
&gt;=C2=A0 =C2=A0 =C2=A0+command came.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The device MUST return VIRTIO_VIDEO_RESULT_ERR_INV=
ALID_COMMAND to<br>
&gt;=C2=A0 =C2=A0 =C2=A0+any command code it does not recognize.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{delayed_response_id} MUST be set to a strea=
m-unique<br>
&gt;=C2=A0 =C2=A0 =C2=A0identifier that<br>
&gt;=C2=A0 =C2=A0 =C2=A0+remains valid as long as the background operation =
hasn&#39;t finished.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\drivernormative{\paragraph}{Device Operation: Com=
mand<br>
&gt;=C2=A0 =C2=A0 =C2=A0Virtqueue}{Device Types / Video Device / Device Ope=
ration / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Command Virtqueue}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+Descriptor chains sent to the commandq by the driv=
er MUST include at<br>
&gt;=C2=A0 =C2=A0 =C2=A0+least one device-writable descriptor of a size suf=
ficient to<br>
&gt;=C2=A0 =C2=A0 =C2=A0receive the<br>
&gt;=C2=A0 =C2=A0 =C2=A0+response to the queued command.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The driver MUST NOT interpret the rest of a respon=
se whose result<br>
&gt;=C2=A0 =C2=A0 =C2=A0is not<br>
&gt;=C2=A0 =C2=A0 =C2=A0+VIRTIO_VIDEO_RESULT_OK or VIRTIO_VIDEO_RESULT_OK_D=
ELAYED.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\subsubsection{Device Operation: Event Virtqueue}<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Device Op=
eration / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Event Virtqueue}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The eventq is used by the device to send delayed r=
esponses to<br>
&gt;=C2=A0 =C2=A0 =C2=A0commands queued<br>
&gt;=C2=A0 =C2=A0 =C2=A0+by the driver on the commandq and standalone event=
s. Stream errors<br>
&gt;=C2=A0 =C2=A0 =C2=A0and dynamic<br>
&gt;=C2=A0 =C2=A0 =C2=A0+parameters changes are caused by changes in the de=
vice&#39;s state, not by<br>
&gt;=C2=A0 =C2=A0 =C2=A0+commands, still they are delivered as<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_DELAYED_RESP_STREAM_DESTROY<br>
&gt;=C2=A0 =C2=A0 =C2=A0+and VIRTIO_VIDEO_DELAYED_RESP_STREAM_SET_PARAMS, r=
espectively.<br>
&gt; <br>
&gt; <br>
&gt; So, ERROR and DRC events trigger a VIRTIO_VIDEO_DELAYED_RESP_STREAM_DE=
STROY<br>
&gt; and VIRTIO_VIDEO_DELAYED_RESP_STREAM_SET_PARAMS events, respectively.<=
br>
&gt; And VIRTIO_VIDEO_DELAYED_RESP_STREAM_SET_PARAMS will have<br>
&gt; a valid `delayed_response_id` only if it comes from a SET_PARAMS comma=
nd <br>
&gt; from the<br>
&gt; driver. Otherwise, if it is due to a dynamic parameter change, <br>
&gt; `delayed_response_id`<br>
&gt; will be set to `VIRTIO_VIDEO_INVALID_RESPONSE_ID`. Is this correct?<br=
>
<br>
Yes, this is correct. Looks like it is better to rename <br>
VIRTIO_VIDEO_INVALID_RESPONSE_ID to VIRTIO_VIDEO_STANDALONE_EVENT_ID <br>
maybe. Thanks!<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The supported events are defined as follows:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_DELAYED_RESP_STREAM_DESTROY=
=C2=A0 =C2=A0 =C2=A01<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_DELAYED_RESP_STREAM_SET_PARAM=
S=C2=A0 2<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_DELAYED_RESP_STREAM_DRAIN=C2=
=A0 =C2=A0 =C2=A0 =C2=A03<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_DELAYED_RESP_STREAM_RESET=C2=
=A0 =C2=A0 =C2=A0 =C2=A04<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_DELAYED_RESP_RESOURCE_QUEUE=
=C2=A0 =C2=A0 =C2=A05<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_EVENT_FLAG_CANCELED=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_event {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 event_type; /* VI=
RTIO_VIDEO_DELAYED_RESP_* */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stream_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 delayed_response_=
id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 event_flags; /* B=
itmask of VIRTIO_VIDEO_EVENT_FLAG_* */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 union {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct virtio_video_stream_set_params_delayed_resp<br>
&gt;=C2=A0 =C2=A0 =C2=A0set_params;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct virtio_video_resource_queue_delayed_resp queue;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{event_type}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the type of the event.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{stream_id}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the ID of a valid stream.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{delayed_response_id}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is an ID of the delayed response, that allo=
ws to relate it to a<br>
&gt;=C2=A0 =C2=A0 =C2=A0previously<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 submitted command. If it is set to<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_INVALID_RESPONSE_ID, then<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 this is a standalone event, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \ref{sec:Device Types / Video Device / Devi=
ce Operation / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Standalone Events}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{event_flags}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is a bitmask of VIRTIO_VIDEO_EVENT_FLAG_* f=
lags<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \item[VIRTIO_VIDEO_EVENT_FLAG_CANCELED]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 is set if the command has been cance=
led by another command,<br>
&gt;=C2=A0 =C2=A0 =C2=A0that has<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 higher priority. Doesn&#39;t make se=
nse for standalone events.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The particular member of the union is selected acc=
ording to the<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{event_type} for some of the types.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\drivernormative{\paragraph}{Device Operation: Eve=
nt<br>
&gt;=C2=A0 =C2=A0 =C2=A0Virtqueue}{Device Types / Video Device / Device Ope=
ration / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Event Virtqueue}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The driver MUST at any time have at least one desc=
riptor with a used<br>
&gt;=C2=A0 =C2=A0 =C2=A0+buffer large enough to contain a \field{struct vir=
tio_video_event}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+queued on the eventq.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The driver MUST NOT put device-readable descriptor=
s into the eventq.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\subsubsection{Device Operation: Device Commands}<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Device Op=
eration / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Device Commands}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+This command allows retrieving the device capabili=
ties.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\paragraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Device Op=
eration / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVIC=
E_QUERY_CAPS}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+Retrieve device capabilities for all available str=
eam parameters.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The driver sends this command with<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{struct virtio_video_device_query_caps}:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_device_query_caps {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 cmd_type; /* VIRT=
IO_VIDEO_CMD_DEVICE_QUERY_CAPS */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The device responds with<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{struct virtio_video_device_query_caps_resp}=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define MASK(x) (1 &lt;&lt; (x))<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_device_query_caps_resp {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 result; /* VIRTIO=
_VIDEO_RESULT_* */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stream_params_bit=
mask; /* Bitmask of<br>
&gt;=C2=A0 =C2=A0 =C2=A0MASK(VIRTIO_VIDEO_PARAM_*) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 coded_formats_bit=
mask; /* Bitmaks of<br>
&gt;=C2=A0 =C2=A0 =C2=A0MASK(VIRTIO_VIDEO_CODED_FORMAT_*) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 raw_formats_bitma=
sk; /* Bitmask of<br>
&gt;=C2=A0 =C2=A0 =C2=A0MASK(VIRTIO_VIDEO_RAW_FORMAT_*) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 num_format_deps;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 num_raw_format_ca=
ps;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 num_coded_resourc=
es_caps;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 num_raw_resources=
_caps;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 num_bitrate_caps;=
 /* If<br>
&gt;=C2=A0 =C2=A0 =C2=A0MASK(VIRTIO_VIDEO_PARAM_BITRATE) is set. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If corresponding MA=
SK(VIRTIO_VIDEO_PARAM_GROUP_CODEC_*)<br>
&gt;=C2=A0 =C2=A0 =C2=A0is set. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_mp=
eg2_caps mpeg2_caps;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_mp=
eg4_caps mpeg4_caps;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_h2=
64_caps h264_caps;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_he=
vc_caps hevc_caps;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_vp=
8_caps vp8_caps;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_vp=
9_caps vp9_caps;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Followed by<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* struct virtio_=
video_format_dependency<br>
&gt;=C2=A0 =C2=A0 =C2=A0format_deps[num_format_deps];<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Followed by<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* struct virtio_=
video_raw_format_caps<br>
&gt;=C2=A0 =C2=A0 =C2=A0raw_format_caps[num_raw_format_caps];<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Followed by<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* struct virtio_=
video_coded_resources_caps<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* coded_resource=
s_caps[num_coded_resources_caps];<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Followed by<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* struct virtio_=
video_raw_resources_caps<br>
&gt;=C2=A0 =C2=A0 =C2=A0raw_resources_caps[num_raw_resources_caps];<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Followed by if=
 MASK(VIRTIO_VIDEO_PARAM_BITRATE) is set<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* struct virtio_=
video_bitrate_caps<br>
&gt;=C2=A0 =C2=A0 =C2=A0bitrate_caps[num_bitrate_caps];<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt; <br>
&gt; <br>
&gt; Maybe nitpicking, but some of the member structs are inside a comment =
<br>
&gt; and some are not.<br>
&gt; Does not seem to correlate with them being conditional.<br>
&gt; I think is nice to have conditional fields in comment blocks to <br>
&gt; highlight it, but then the<br>
&gt; VIRTIO_VIDEO_PARAM_GROUP_CODEC_* structs need to be in their own comme=
nt <br>
&gt; block.<br>
<br>
Yeah, this style comes from draft v5, then I added the conditional <br>
statementson top, so now it is harder to understand. I also would like <br>
to do this in a different way. I was thinking recently about <br>
extendability of this construct, it doesn&#39;t look good. If a new codec o=
r <br>
a new codec-specific parameters is added, it has to be guarded by a new <br=
>
feature flag, say VIRTIO_VIDEO_F_CODECS_2024. Then the device will have <br=
>
to provide different structures depending on the negotiated flags and <br>
the driver will have to parse it. This looks quite painful and <br>
error-prone. My current idea is to replace this with something like FDT <br=
>
to make it much more flexible. The resulting blob with all the <br>
capabilities can even be mapped directly to the guest memory. I&#39;m still=
 <br>
exploring this idea. WDYT?<br>
<br></blockquote><div><br></div><div>Yes, the struct looks a bit cumbersome=
=C2=A0and difficult to expand, as you mention.</div><div>But I am not sure =
what do you mean by FDT, or how you plan to map it to the guest</div><div>m=
emory. Could you expand the idea?</div><div>But from what I see, structures=
 for most formats have similar fields for capabilities.</div><div>Couldn&#3=
9;t this be unified into a single capabilities struct and fill it with the =
raw data obtained</div><div>from the host device?</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{result}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \item[VIRTIO_VIDEO_RESULT_OK]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if the operation succeeded,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \item[VIRTIO_VIDEO_RESULT_ERR_OUT_OF_MEMORY=
]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if the descriptor was smaller than t=
he defined<br>
&gt;=C2=A0 =C2=A0 =C2=A0\field{caps_length} in<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 the video device configuration.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{stream_params_bitmask}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is a bitmask of supported stream parameters=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{coded_formats_bitmask}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is a bitmask of supported coded formats.<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{raw_formats_bitmask}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is a bitmask of supported raw formats.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{num_format_deps}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the number of elements in the format_dep=
s array.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{num_raw_format_caps}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the number of elements in the raw_format=
_caps array.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{num_coded_resources_caps}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the number of elements in the coded_reso=
urces_caps array.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{num_raw_resources_caps}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the number of elements in the raw_resour=
ces_caps array.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{num_bitrate_caps}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the number of elements in the bitrate_ca=
ps array.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{mpeg2_caps}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 groups the capabilities of MPEG2 specific p=
arameters.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{mpeg4_caps}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 groups the capabilities of MPEG4 specific p=
arameters.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{h264_caps}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 groups the capabilities of H.264 specific p=
arameters.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{hevc_caps}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 groups the capabilities of HEVC specific pa=
rameters.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{vp8_caps}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 groups the capabilities of VP8 specific par=
ameters.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{vp9_caps}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 groups the capabilities of VP9 specific par=
ameters.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{format_deps}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is an array of size \field{num_format_deps}=
 establishing dependencies<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 between coded and raw formats.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{raw_format_caps}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is an array of size \field{num_raw_format_c=
aps} containing the<br>
&gt;=C2=A0 =C2=A0 =C2=A0supported<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 raw formats capabilities.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{coded_resources_caps}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is an array of size \field{num_coded_resour=
ces_caps}, that sets<br>
&gt;=C2=A0 =C2=A0 =C2=A0bounds for<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 the number of resources in the CODED queue.=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{raw_resources_caps}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is an array of size \field{num_raw_resource=
s_caps}, that sets<br>
&gt;=C2=A0 =C2=A0 =C2=A0bounds for<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 the number of resources in the RAW queue.<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{bitrate_caps}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is an array of size \field{num_bitrate_caps=
} containing the supported<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 bitrates.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% TODO: V4L2 flow: 1. coded format without variant=
s (maybe these flags<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% are relevant too: V4L2_FMT_FLAG_CONTINUOUS_BYTES=
TREAM?,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% V4L2_FMT_FLAG_DYN_RESOLUTION?,<br>
&gt;=C2=A0 =C2=A0 =C2=A0V4L2_FMT_FLAG_ENC_CAP_FRAME_INTERVAL???),<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% also include variants (see VIDIOC_QUERYCTRL), th=
en raw formats,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% then resolutions (discrete or stepwise, see VIDI=
OC_ENUM_FRAMESIZES),<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% intervals are optional (see VIDIOC_ENUM_FRAMEINT=
ERVALS)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_D=
EVICE_QUERY_CAPS}{Device Types / Video Device / Device Operation / Device O=
peration: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The device MUST support at least these parameters:=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0+VIRTIO_VIDEO_PARAM_CODED_FORMAT, VIRTIO_VIDEO_PARA=
M_RAW_FORMAT,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+VIRTIO_VIDEO_PARAM_CODED_RESOURCES, VIRTIO_VIDEO_P=
ARAM_RAW_RESOURCES.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The device MUST NOT mark codec-specific parameters=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0+(VIRTIO_VIDEO_PARAM_GROUP_CODEC_*) as supported un=
less the<br>
&gt;=C2=A0 =C2=A0 =C2=A0corresponding<br>
&gt;=C2=A0 =C2=A0 =C2=A0+codecs are supported as well.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The device MUST set to zero all fields with capabi=
lities of unsupported<br>
&gt;=C2=A0 =C2=A0 =C2=A0+parameters.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The lengths \field{num_format_deps}, \field{num_ra=
w_format_caps},<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{num_coded_resources_caps} and \field{num_ra=
w_resources_caps}<br>
&gt;=C2=A0 =C2=A0 =C2=A0MUST be<br>
&gt;=C2=A0 =C2=A0 =C2=A0+positive.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The device MUST write the five \field{format_deps}=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{raw_format_caps}, \field{coded_resources_ca=
ps},<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{raw_resources_caps} and \field{bitrate_caps=
} arrays, of length<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{num_format_deps}, \field{num_raw_format_cap=
s},<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{num_coded_resources_caps}, \field{num_raw_r=
esources_caps} and<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{num_bitrate_caps}, respectively.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+For each coded format in the \field{coded_formats_=
bitmask} there<br>
&gt;=C2=A0 =C2=A0 =C2=A0MUST be<br>
&gt;=C2=A0 =C2=A0 =C2=A0+at least one element of \field{format_deps} refere=
ncing it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+For each raw format in the \field{raw_formats_bitm=
ask} there MUST be<br>
&gt;=C2=A0 =C2=A0 =C2=A0+at least one element of \field{format_deps} refere=
ncing it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+For any coded and any raw format there MUST be at =
most one element of<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{format_deps} referencing both of them.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+Elements of \field{format_deps} SHOULD be ordered =
according to raw<br>
&gt;=C2=A0 =C2=A0 =C2=A0format<br>
&gt;=C2=A0 =C2=A0 =C2=A0+preferences of the device from preferred to not pr=
eferred ones.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+For each raw format in the \field{raw_formats_bitm=
ask} there MUST be<br>
&gt;=C2=A0 =C2=A0 =C2=A0+exactly one element of \field{raw_format_caps} ref=
erencing it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+For each coded format in the \field{coded_formats_=
bitmask} there<br>
&gt;=C2=A0 =C2=A0 =C2=A0MUST be<br>
&gt;=C2=A0 =C2=A0 =C2=A0+exactly one element of \field{coded_resources_caps=
} referencing it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+For each raw format in the \field{raw_formats_bitm=
ask} there MUST be<br>
&gt;=C2=A0 =C2=A0 =C2=A0+exactly one element of \field{raw_resources_caps} =
referencing it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+If VIRTIO_VIDEO_PARAM_BITRATE is supported, then f=
or each coded<br>
&gt;=C2=A0 =C2=A0 =C2=A0format in<br>
&gt;=C2=A0 =C2=A0 =C2=A0+the \field{coded_formats_bitmask} there MUST be ex=
actly one element of<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{bitrate_caps} referencing it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The total size of the response MUST be equal to \f=
ield{caps_length}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+bytes, as reported by the device configuration.<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: =
Format dependencies}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The description of dependencies between coded and =
raw formats<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{virtio_video_format_dependency} is defined =
as follows:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_format_dependency {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 coded_formats_bit=
mask; /* Bitmask of<br>
&gt;=C2=A0 =C2=A0 =C2=A0MASK(VIRTIO_VIDEO_CODED_FORMAT_*) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 raw_format; /* VI=
RTIO_VIDEO_RAW_FORMAT_* */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{coded_formats_bitmask}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 specifies coded formats, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \ref{sec:Device Types / Video Device / Supp=
orted parameters /<br>
&gt;=C2=A0 =C2=A0 =C2=A0Supported coded formats}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 If a bit for a specific coded format is set=
, then this coded<br>
&gt;=C2=A0 =C2=A0 =C2=A0format can be<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 decoded into the specified raw format or en=
coded from it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{raw_format}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is a raw format, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \ref{sec:Device Types / Video Device / Supp=
orted parameters /<br>
&gt;=C2=A0 =C2=A0 =C2=A0Supported raw formats}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_D=
EVICE_QUERY_CAPS:<br>
&gt;=C2=A0 =C2=A0 =C2=A0Format dependencies}{Device Types / Video Device / =
Device Operation<br>
&gt;=C2=A0 =C2=A0 =C2=A0/ Device Operation: Device Commands /<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS /<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Format dependen=
cies}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{coded_formats_bitmask} MUST be a subset of<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0\field{coded_formats_bitmask}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+field of \field{struct virtio_video_device_query_c=
aps_resp}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{coded_formats_bitmask} MUST specify at leas=
t one coded format.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{raw_format} MUST be set to one of the suppo=
rted raw formats<br>
&gt;=C2=A0 =C2=A0 =C2=A0according to<br>
&gt;=C2=A0 =C2=A0 =C2=A0+the \field{raw_formats_bitmask} field of<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{struct virtio_video_device_query_caps_resp}=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: =
Raw format<br>
&gt;=C2=A0 =C2=A0 =C2=A0capabilities}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Device Op=
eration / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVIC=
E_QUERY_CAPS /<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format capa=
bilities}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The raw format capability description<br>
&gt;=C2=A0 =C2=A0 =C2=A0\field{virtio_video_raw_format_caps} is<br>
&gt;=C2=A0 =C2=A0 =C2=A0+defined as follows:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+enum virtio_video_planes_layout {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_VIDEO_PLANES_LA=
YOUT_SINGLE_BUFFER =3D 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_VIDEO_PLANES_LA=
YOUT_MULTI_BUFFERS =3D 2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_range {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 min;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 max;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 step;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_raw_format_caps {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 raw_formats_bitma=
sk; /* Bitmask of<br>
&gt;=C2=A0 =C2=A0 =C2=A0MASK(VIRTIO_VIDEO_RAW_FORMAT_*) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 planes_layouts; /=
* Bitmask of<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_PLANES_LAYOUT_* */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 plane_align;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stride_align_mask=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_ra=
nge width_range;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_ra=
nge height_range;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{struct virtio_video_range} is used to repre=
sent a range of<br>
&gt;=C2=A0 =C2=A0 =C2=A0values.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+An integer \(x\) is within the range \field{r} if<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0+\(\field{r.min} \le x \le \field{r.max}\) holds an=
d \(x\) equals to<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\((\field{min} + \field{step} * n)\) for some inte=
ger \(n\).<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{raw_formats_bitmask}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 specifies raw formats, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \ref{sec:Device Types / Video Device / Supp=
orted parameters /<br>
&gt;=C2=A0 =C2=A0 =C2=A0Supported raw formats},<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 to which these capabilities apply.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{planes_layouts}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is a bitmask with the set of plane layout t=
ypes from<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \field{enum virtio_video_planes_layout}.<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{plane_align}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the alignment of planes within a buffer =
in bytes. This field<br>
&gt;=C2=A0 =C2=A0 =C2=A0is valid<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 only if \field{planes_layouts} has the<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \field{VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BU=
FFER} bit set.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{stride_align_mask}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is a mask of all supported power of two str=
ide alignments.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{width_range}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is a range of widths in pixels.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{height_range}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is a range of heights in pixels.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_D=
EVICE_QUERY_CAPS:<br>
&gt;=C2=A0 =C2=A0 =C2=A0Raw format capabilities}{Device Types / Video Devic=
e / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation / Device Operation: Device Commands /<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS /<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format capa=
bilities}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{raw_formats_bitmask} MUST be a subset of<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0\field{raw_formats_bitmask}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+field of \field{struct virtio_video_device_query_c=
aps_resp}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{raw_formats_bitmask} MUST specify at least =
one raw format.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The device MUST set<br>
&gt;=C2=A0 =C2=A0 =C2=A0\field{VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER} bi=
t in<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{planes_layouts} if the plane layout with pl=
anes of a frame<br>
&gt;=C2=A0 =C2=A0 =C2=A0laid out one<br>
&gt;=C2=A0 =C2=A0 =C2=A0+after another in the same buffer is supported.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The device MUST set<br>
&gt;=C2=A0 =C2=A0 =C2=A0\field{VIRTIO_VIDEO_PLANES_LAYOUT_MULTI_BUFFERS} bi=
t in<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{planes_layouts} if the plane layout with pl=
anes of a frame<br>
&gt;=C2=A0 =C2=A0 =C2=A0laid out in<br>
&gt;=C2=A0 =C2=A0 =C2=A0+separate buffers is supported.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{plane_align} MUST be set to a power of two =
according to the<br>
&gt;=C2=A0 =C2=A0 =C2=A0device<br>
&gt;=C2=A0 =C2=A0 =C2=A0+plane alignment requirements if \field{planes_layo=
uts} has the<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER} b=
it set or to zero<br>
&gt;=C2=A0 =C2=A0 =C2=A0otherwise.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{min}, \field{step} and \field{max} MUST be =
positive.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{min} MUST be less then or equal to \field{m=
ax} within the<br>
&gt;=C2=A0 =C2=A0 =C2=A0same range.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: =
Resource<br>
&gt;=C2=A0 =C2=A0 =C2=A0capabilities}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The CODED resource capabilities<br>
&gt;=C2=A0 =C2=A0 =C2=A0\field{virtio_video_coded_resources_caps} is<br>
&gt;=C2=A0 =C2=A0 =C2=A0+defined as follows:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_coded_resources_caps {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 coded_formats_bit=
mask; /* Bitmask of<br>
&gt;=C2=A0 =C2=A0 =C2=A0MASK(VIRTIO_VIDEO_CODED_FORMAT_*) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 min_resources;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 max_resources;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 buffer_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{coded_formats_bitmask}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 specifies coded formats, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \ref{sec:Device Types / Video Device / Supp=
orted parameters /<br>
&gt;=C2=A0 =C2=A0 =C2=A0Supported coded formats},<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 to which these capabilities apply.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{min_resources}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the minimum number of resources that the=
 CODED queue supports<br>
&gt;=C2=A0 =C2=A0 =C2=A0for all<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 the specified coded formats.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{max_resources}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the maximum number of resources that the=
 CODED queue supports<br>
&gt;=C2=A0 =C2=A0 =C2=A0for all<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 the specified coded formats.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{buffer_size}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the minimum size of the buffers that wil=
l back resources to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0queued.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The RAW resource capabilities<br>
&gt;=C2=A0 =C2=A0 =C2=A0\field{virtio_video_raw_resources_caps} is<br>
&gt;=C2=A0 =C2=A0 =C2=A0+defined as follows:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_raw_resources_caps {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 raw_formats_bitma=
sk; /* Bitmask of<br>
&gt;=C2=A0 =C2=A0 =C2=A0MASK(VIRTIO_VIDEO_RAW_FORMAT_*) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 min_resources;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 max_resources;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{raw_formats_bitmask}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 specifies raw formats, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \ref{sec:Device Types / Video Device / Supp=
orted parameters /<br>
&gt;=C2=A0 =C2=A0 =C2=A0Supported raw formats},<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 to which these capabilities apply.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{min_resources}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the minimum number of resources that the=
 RAW queue supports<br>
&gt;=C2=A0 =C2=A0 =C2=A0for all<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 the specified raw formats.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{max_resources}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the maximum number of resources that the=
 RAW queue supports<br>
&gt;=C2=A0 =C2=A0 =C2=A0for all<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 the specified raw formats.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_D=
EVICE_QUERY_CAPS:<br>
&gt;=C2=A0 =C2=A0 =C2=A0Resource capabilities}{Device Types / Video Device =
/ Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation / Device Operation: Device Commands /<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS /<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Resource capabi=
lities}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{coded_formats_bitmask} MUST be a subset of<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0\field{coded_formats_bitmask}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+field of \field{struct virtio_video_device_query_c=
aps_resp}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{coded_formats_bitmask} MUST specify at leas=
t one coded format.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{raw_formats_bitmask} MUST be a subset of<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0\field{raw_formats_bitmask}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+field of \field{struct virtio_video_device_query_c=
aps_resp}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{raw_formats_bitmask} MUST specify at least =
one raw format.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{min_resources} MUST NOT be negative.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{max_resources} MUST be greater then or equa=
l to<br>
&gt;=C2=A0 =C2=A0 =C2=A0\field{min_resources}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+within the same struct instance.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: =
Bitrates}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The bitrate capabilities \field{virtio_video_bitra=
te_caps} is<br>
&gt;=C2=A0 =C2=A0 =C2=A0+defined as follows:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_bitrate_caps {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 coded_formats_bit=
mask; /* Bitmask of<br>
&gt;=C2=A0 =C2=A0 =C2=A0MASK(VIRTIO_VIDEO_CODED_FORMAT_*) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 min_bitrate;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 max_bitrate;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{coded_formats_bitmask}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 specifies coded formats, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \ref{sec:Device Types / Video Device / Supp=
orted parameters /<br>
&gt;=C2=A0 =C2=A0 =C2=A0Supported coded formats},<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 to which these capabilities apply.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{min_bitrate}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the minimum bitrate in bits per second s=
upported by the<br>
&gt;=C2=A0 =C2=A0 =C2=A0encoder for all the specified coded<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 formats.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{max_bitrate}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the maximum bitrate in bits per second s=
upported by the<br>
&gt;=C2=A0 =C2=A0 =C2=A0encoder for all the specified coded<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 formats.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_D=
EVICE_QUERY_CAPS:<br>
&gt;=C2=A0 =C2=A0 =C2=A0Bitrates}{Device Types / Video Device / Device Oper=
ation / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVIC=
E_QUERY_CAPS /<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Bitrates}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{coded_formats_bitmask} MUST be a subset of<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0\field{coded_formats_bitmask}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+field of \field{struct virtio_video_device_query_c=
aps_resp}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{coded_formats_bitmask} MUST specify at leas=
t one coded format.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{min_bitrate} MUST NOT be negative.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{max_bitrate} MUST be greater then or equal =
to<br>
&gt;=C2=A0 =C2=A0 =C2=A0\field{min_bitrate}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+within the same \field{struct virtio_video_bitrate=
_caps} instance.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\subsubsection{Device Operation: Stream commands}<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Device Op=
eration / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Stream commands}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+Stream commands allow the creation, destruction, a=
nd flow control of a<br>
&gt;=C2=A0 =C2=A0 =C2=A0+stream.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\paragraph{VIRTIO_VIDEO_CMD_STREAM_CREATE}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Device Op=
eration / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Stream commands / VIRTIO_VIDEO_CMD_STREA=
M_CREATE}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+Create a new stream using the device.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The driver sends this command with<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{struct virtio_video_stream_create}:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_stream_create {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 cmd_type; /* VIRT=
IO_VIDEO_CMD_STREAM_CREATE */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The device responds with \field{struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio_video_stream_create_resp}:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_stream_create_resp {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 result; /* VIRTIO=
_VIDEO_RESULT_* */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stream_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{result}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \item[VIRTIO_VIDEO_RESULT_OK]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if the operation succeeded,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \item[VIRTIO_VIDEO_RESULT_ERR_OUT_OF_MEMORY=
]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if the limit of simultaneous streams=
 has been reached by the<br>
&gt;=C2=A0 =C2=A0 =C2=A0device and<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 no more can be created.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERA=
TION]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if the stream cannot be created due =
to an unexpected device issue.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{stream_id}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the ID of the created stream allocated b=
y the device.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_S=
TREAM_CREATE}{Device Types / Video Device / Device Operation / Device Opera=
tion: Stream commands / VIRTIO_VIDEO_CMD_STREAM_CREATE}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{stream_id} MUST be set to a device-unique i=
dentifier that<br>
&gt;=C2=A0 =C2=A0 =C2=A0remains<br>
&gt;=C2=A0 =C2=A0 =C2=A0+valid as long as the stream is alive.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\paragraph{VIRTIO_VIDEO_CMD_STREAM_DESTROY}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Device Op=
eration / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Stream commands / VIRTIO_VIDEO_CMD_STREA=
M_DESTROY}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% DESTROY has to be more like RESET, not DRAIN, be=
cause it is<br>
&gt;=C2=A0 =C2=A0 =C2=A0called, for<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% example, when the guest user-space app closes a =
file descriptor.<br>
&gt;=C2=A0 =C2=A0 =C2=A0So there<br>
&gt;=C2=A0 =C2=A0 =C2=A0+% is no sense in continuing the processing.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+Destroy a video stream and all its resources. Any =
activity on the<br>
&gt;=C2=A0 =C2=A0 =C2=A0stream<br>
&gt;=C2=A0 =C2=A0 =C2=A0+is halted and all resources are released by the ti=
me the delayed<br>
&gt;=C2=A0 =C2=A0 =C2=A0response is<br>
&gt;=C2=A0 =C2=A0 =C2=A0+received by the driver.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The driver sends this command with<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{struct virtio_video_stream_destroy}:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_stream_destroy {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 cmd_type; /* VIRT=
IO_VIDEO_CMD_STREAM_DESTROY */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stream_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{stream_id}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the ID of the stream to be destroyed, as=
 previously returned by<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 VIRTIO_VIDEO_CMD_STREAM_CREATE.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The device responds as described in<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\ref{sec:Device Types / Video Device / Device Oper=
ation / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Command Virtqueue}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+and begins the background DESTROY operation.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+When the command is completed the device sends the=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0+VIRTIO_VIDEO_DELAYED_RESP_STREAM_DESTROY delayed r=
esponse, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\ref{sec:Device Types / Video Device / Device Oper=
ation / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Event Virtqueue}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The delayed response can also come in case of unre=
coverable stream<br>
&gt;=C2=A0 =C2=A0 =C2=A0error, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\ref{sec:Device Types / Video Device / Device Oper=
ation / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Standalone Events / Error Event}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_S=
TREAM_DESTROY}{Device Types / Video Device / Device Operation / Device Oper=
ation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DESTROY}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+Before the device sends a delayed response to<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_VIDEO_CMD_STREAM_DESTROY,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+it MUST send all other pending delayed responses w=
ith<br>
&gt;=C2=A0 =C2=A0 =C2=A0+VIRTIO_VIDEO_EVENT_FLAG_CANCELED flag set and deta=
ch all resources.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+After VIRTIO_VIDEO_CMD_STREAM_DESTROY is queued, t=
he device MUST<br>
&gt;=C2=A0 =C2=A0 =C2=A0reply with<br>
&gt;=C2=A0 =C2=A0 =C2=A0+VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID to any s=
ubsequently<br>
&gt;=C2=A0 =C2=A0 =C2=A0queued command<br>
&gt;=C2=A0 =C2=A0 =C2=A0+with this stream ID.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The DESTROY operation MUST NOT be canceled.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_S=
TREAM_DESTROY}{Device Types / Video Device / Device Operation / Device Oper=
ation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DESTROY}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{stream_id} MUST be set to a valid stream ID=
 previously returned<br>
&gt;=C2=A0 =C2=A0 =C2=A0+by VIRTIO_VIDEO_CMD_STREAM_CREATE.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The driver MUST stop using \field{stream_id} as a =
valid stream after it<br>
&gt;=C2=A0 =C2=A0 =C2=A0+received the delayed response to this command.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\paragraph{VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\label{sec:Device Types / Video Device / Device Op=
eration / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Stream commands / VIRTIO_VIDEO_CMD_STREA=
M_SET_PARAMS}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+Write values of selected parameters of a given str=
eam, and receive<br>
&gt;=C2=A0 =C2=A0 =C2=A0back the<br>
&gt;=C2=A0 =C2=A0 =C2=A0+values for all the parameters supported by the dev=
ice as reported by<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\ref{sec:Device Types / Video Device / Device Oper=
ation / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVIC=
E_QUERY_CAPS}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The operation can be either executed immediately, =
or queued into<br>
&gt;=C2=A0 =C2=A0 =C2=A0the INPUT<br>
&gt;=C2=A0 =C2=A0 =C2=A0+queue, i.e. after processing all the INPUT queue e=
lements that are<br>
&gt;=C2=A0 =C2=A0 =C2=A0queued<br>
&gt;=C2=A0 =C2=A0 =C2=A0+before the command.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The driver sends this command with<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{struct virtio_video_stream_set_params}:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define VIRTIO_VIDEO_SET_PARAMS_FLAG_IN_BAND=C2=A0=
 (1 &lt;&lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_stream_set_params {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 cmd_type; /* VIRT=
IO_VIDEO_CMD_STREAM_SET_PARAMS */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stream_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 flags; /* Bitmask=
 of VIRTIO_VIDEO_SET_PARAMS_FLAG_* */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_pa=
rams params;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{stream_id}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is the ID of the stream we want to set a pa=
rameter for.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{flags}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is a bitmask of VIRTIO_VIDEO_SET_PARAMS_FLA=
G_* values.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \item[\field{VIRTIO_VIDEO_SET_PARAMS_FLAG_I=
N_BAND}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 The submitted parameters are to be s=
et only after all of the<br>
&gt;=C2=A0 =C2=A0 =C2=A0previously<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 queued INPUT queue elements are proc=
essed. Without this flag the<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 parameters are set Immediately.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 \end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{params}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is a container for the selected stream para=
meters to be set.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The device responds as described in<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\ref{sec:Device Types / Video Device / Device Oper=
ation / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Command Virtqueue}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+and begins the background SET_PARAMS operation.<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+When the background processing of the resource is =
completed the<br>
&gt;=C2=A0 =C2=A0 =C2=A0device sends<br>
&gt;=C2=A0 =C2=A0 =C2=A0+the VIRTIO_VIDEO_DELAYED_RESP_STREAM_SET_PARAMS de=
layed response, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\ref{sec:Device Types / Video Device / Device Oper=
ation / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Event Virtqueue}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The delayed response can also come in case of dyna=
mic parameters<br>
&gt;=C2=A0 =C2=A0 =C2=A0change, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\ref{sec:Device Types / Video Device / Device Oper=
ation / Device<br>
&gt;=C2=A0 =C2=A0 =C2=A0Operation: Standalone Events / Dynamic Parameters C=
hange Event}.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The command-specific delayed response<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\field{struct virtio_video_stream_set_params_delay=
ed_resp} is defined<br>
&gt;=C2=A0 =C2=A0 =C2=A0+as follows:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_stream_set_params_delayed_resp=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_pa=
rams params;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\item[\field{params}]<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 is a container for the actual values of all=
 the parameters<br>
&gt;=C2=A0 =C2=A0 =C2=A0supported by the<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 device. The values set by the device may di=
ffer from the<br>
&gt;=C2=A0 =C2=A0 =C2=A0requested values<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 depending on the device&#39;s capabilities.=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+The \field{struct virtio_video_params} is defined =
as follows:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_raw_format {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 format;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 planes_layout; /*=
 VIRTIO_VIDEO_PLANES_LAYOUT_* */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stride;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 width;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 height;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_param_crop {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 left;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 top;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 width;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 height;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+union virtio_video_codec_params {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_mp=
eg2_params mpeg2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_mp=
eg4_params mpeg4;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_h2=
64_params h264;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_he=
vc_params hevc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_vp=
8_params vp8;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_vp=
9_params vp9;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct virtio_video_params {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stream_params_bit=
mask; /* Bitmask of<br>
&gt;=C2=A0 =C2=A0 =C2=A0MASK(VIRTIO_VIDEO_PARAM_*) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 coded_format; /* =
If<br>
&gt;=C2=A0 =C2=A0 =C2=A0MASK(VIRTIO_VIDEO_PARAM_CODED_FORMAT) is set. */<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If MASK(VIRTIO_VIDE=
O_PARAM_RAW_FORMAT) is set. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_ra=
w_format raw_format;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If MASK(VIRTIO_VIDE=
O_PARAM_CODED_RESOURCES) is set. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_pa=
ram_resources coded_resources;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If MASK(VIRTIO_VIDE=
O_PARAM_RAW_RESOURCES) is set. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_pa=
ram_resources raw_resources;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_pa=
ram_crop crop; /* If<br>
&gt;=C2=A0 =C2=A0 =C2=A0MASK(VIRTIO_VIDEO_PARAM_CROP) is set. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 bitrate; /* If MA=
SK(VIRTIO_VIDEO_PARAM_BITRATE) is set. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If the correspondin=
g<br>
&gt;=C2=A0 =C2=A0 =C2=A0MASK(VIRTIO_VIDEO_PARAM_GROUP_CODEC_*) is set<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * depending on the cod=
ed_format. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 union virtio_video_cod=
ec_params codec;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+\end{lstlisting}<br>
&gt; <br>
&gt; <br>
&gt; This is a bit difficult to read for me, as some of the *if* comments a=
re <br>
&gt; written AFTER<br>
&gt; the member definition, and some others BEFORE the member defintion.<br=
>
&gt; Above, when introducing the=C2=A0VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS co=
mmand,<br>
&gt; you use this format for the conditional fields:<br>
&gt; /**<br>
&gt; * Followed by if MASK(VIRTIO_VIDEO_PARAM_BITRATE) is set<br>
&gt; * struct virtio_video_bitrate_caps bitrate_caps[num_bitrate_caps];<br>
&gt; */<br>
&gt; It spaces a bit more the members, and leaves them as part of the<br>
&gt; comment block. I would suggest to keep the format consistent.<br>
<br>
Ack, I&#39;ll try to make it more readable.<br>
Also given the extendability concerns, that I explained above, I&#39;d like=
 <br>
to maybe finish combining all the parameters into groups and then to <br>
make the SET_PARAMS command operating on the parameter group level. <br>
Still thinking about this...<br>
<br>
-- <br>
Alexander Gordeev<br>
Senior Software Engineer<br>
<br>
OpenSynergy GmbH<br>
Rotherstr. 20, 10245 Berlin<br>
<br>
Phone: +49 30 60 98 54 0 - 88<br>
Fax: +49 (30) 60 98 54 0 - 99<br>
EMail: <a href=3D"mailto:alexander.gordeev@opensynergy.com" target=3D"_blan=
k">alexander.gordeev@opensynergy.com</a><br>
<br>
<a href=3D"http://www.opensynergy.com" rel=3D"noreferrer" target=3D"_blank"=
>www.opensynergy.com</a><br>
<br>
Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616=
B<br>
Gesch=C3=A4ftsf=C3=BChrer/Managing Director: R=C3=A9gis Adjamah<br>
<br>
</blockquote></div></div>

--0000000000003e9d2e060164b9e2--

