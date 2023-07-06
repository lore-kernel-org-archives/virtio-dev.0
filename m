Return-Path: <virtio-dev-return-13257-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE87EB64DC
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 15:00:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3DCB060089
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 15:00:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EF659986809
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 15:00:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C43CA986728; Thu,  6 Jul 2023 15:00:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A3BFB98672A
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 15:00:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: qYFpfvZZNSC9Xzt_DXaZZA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688655609; x=1691247609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsi0PYYLyYhgZ8K0zcR5DFMs7BH8ISxd9NxdOVy2Svg=;
        b=W5+Q4eFQmacy9F3+o6F3BfdU/WkJDwwKG3TccoZQaoVV2x2obp1khP1lSA/iTK/WQC
         peH1745apkVcx5LhlNeg6NQmFe0ZG3X7CzHH+cfXpDM/zY2gYhwdZV8eegc2yZffhV7/
         Yr05YxKNOBdlhHQXHwIg0ts5Fi4GDM349+jagGcyArt0rwgNMK10+dDvPYB30FVgQapj
         yYPSpjm/WrYMCfMOjDesXDcxyuy4flWphXLz8nlz4KTURBoh3fsEQOeAuNlRxFfpW2LD
         ivh+TQCaVmAVkAB/NzZ8fHUqA6icQQ6Jpwhxe9rC7XXHRY5VDDlK1vsHBLJ33QCr35MQ
         3RAQ==
X-Gm-Message-State: ABy/qLYLbP49yLenbrbXyZn3pfzIN01SP3kq5cAisRA8yujJnubJyhvQ
	XY5NmH3ADVj3e4Z/UQ6AyW26EJCKMEq440EG+KgTwhFRAxdfSecp6VwKy5WwoSynMWWpEUKOpTb
	Gww/48JX6AkSN77f0ZuKTKfyrHJOM0SzM+8zeca4IAdPr
X-Received: by 2002:a05:6a00:1487:b0:668:97bf:5ed7 with SMTP id v7-20020a056a00148700b0066897bf5ed7mr2711116pfu.22.1688655607901;
        Thu, 06 Jul 2023 08:00:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHvn9v9gHX6HOM780KVGZ79ZWLzFn59vmAYNUNVWSQU6jVeDLFbC94lrAaEjRzWB2XpnIPZyWw3zAFpNs7Dmik=
X-Received: by 2002:a05:6a00:1487:b0:668:97bf:5ed7 with SMTP id
 v7-20020a056a00148700b0066897bf5ed7mr2710996pfu.22.1688655606936; Thu, 06 Jul
 2023 08:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230629144915.597188-1-Alexander.Gordeev@opensynergy.com> <20230629144915.597188-2-Alexander.Gordeev@opensynergy.com>
In-Reply-To: <20230629144915.597188-2-Alexander.Gordeev@opensynergy.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 6 Jul 2023 16:59:55 +0200
Message-ID: <CADSE00K7Tc2y58x=6yTV5dXkOdfwm9yO+nkya8B4Jd=y7Gad5w@mail.gmail.com>
To: Alexander Gordeev <Alexander.Gordeev@opensynergy.com>
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
Content-Type: multipart/alternative; boundary="0000000000009988fb05ffd2c581"
Subject: [virtio-dev] Re: [RFC PATCH v8 1/1] virtio-video: Add virtio video device specification

--0000000000009988fb05ffd2c581
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

Thanks for the patch! It is a long document, so I skimmed a bit in the
first read. Find some comments/questions inlined.
I will give it a second deeper read soon, but overall I think is in quite
good shape. It feels really matured.

On Thu, Jun 29, 2023 at 4:49=E2=80=AFPM Alexander Gordeev <
Alexander.Gordeev@opensynergy.com> wrote:

> Add the specification of the video decoder and encoder devices, which
> can be used to provide host-accelerated video operations to the guest.
>
> Signed-off-by: Alexander Gordeev <Alexander.Gordeev@opensynergy.com>
> Co-authored-by: Keiichi Watanabe <keiichiw@chromium.org>
> Co-authored-by: Alexandre Courbot <acourbot@chromium.org>
> ---
>  conformance.tex                           |    4 +
>  content.tex                               |    1 +
>  device-types/video/description.tex        | 2040 +++++++++++++++++++++
>  device-types/video/device-conformance.tex |   22 +
>  device-types/video/driver-conformance.tex |   16 +
>  introduction.tex                          |   21 +
>  6 files changed, 2104 insertions(+)
>  create mode 100644 device-types/video/description.tex
>  create mode 100644 device-types/video/device-conformance.tex
>  create mode 100644 device-types/video/driver-conformance.tex
>
> diff --git a/conformance.tex b/conformance.tex
> index 01ccd69..d719eda 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -34,6 +34,7 @@ \section{Conformance Targets}\label{sec:Conformance /
> Conformance Targets}
>  \ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},
>  \ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance} or
>  \ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
> +\ref{sec:Conformance / Driver Conformance / Video Driver Conformance},
>
>      \item Clause \ref{sec:Conformance / Legacy Interface: Transitional
> Device and Transitional Driver Conformance}.
>    \end{itemize}
> @@ -61,6 +62,7 @@ \section{Conformance Targets}\label{sec:Conformance /
> Conformance Targets}
>  \ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
>  \ref{sec:Conformance / Device Conformance / GPIO Device Conformance} or
>  \ref{sec:Conformance / Device Conformance / PMEM Device Conformance}.
> +\ref{sec:Conformance / Device Conformance / Video Device Conformance},
>
>      \item Clause \ref{sec:Conformance / Legacy Interface: Transitional
> Device and Transitional Driver Conformance}.
>    \end{itemize}
> @@ -152,6 +154,7 @@ \section{Conformance Targets}\label{sec:Conformance /
> Conformance Targets}
>  \input{device-types/scmi/driver-conformance.tex}
>  \input{device-types/gpio/driver-conformance.tex}
>  \input{device-types/pmem/driver-conformance.tex}
> +\input{device-types/video/driver-conformance.tex}
>
>  \conformance{\section}{Device Conformance}\label{sec:Conformance / Devic=
e
> Conformance}
>
> @@ -238,6 +241,7 @@ \section{Conformance Targets}\label{sec:Conformance /
> Conformance Targets}
>  \input{device-types/scmi/device-conformance.tex}
>  \input{device-types/gpio/device-conformance.tex}
>  \input{device-types/pmem/device-conformance.tex}
> +\input{device-types/video/device-conformance.tex}
>
>  \conformance{\section}{Legacy Interface: Transitional Device and
> Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface=
:
> Transitional Device and Transitional Driver Conformance}
>  A conformant implementation MUST be either transitional or
> diff --git a/content.tex b/content.tex
> index d2ab9eb..90708d7 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -765,6 +765,7 @@ \chapter{Device Types}\label{sec:Device Types}
>  \input{device-types/scmi/description.tex}
>  \input{device-types/gpio/description.tex}
>  \input{device-types/pmem/description.tex}
> +\input{device-types/video/description.tex}
>
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>
> diff --git a/device-types/video/description.tex
> b/device-types/video/description.tex
> new file mode 100644
> index 0000000..760df7f
> --- /dev/null
> +++ b/device-types/video/description.tex
> @@ -0,0 +1,2040 @@
> +\section{Video Device}
> +\label{sec:Device Types / Video Device}
> +
> +The virtio video encoder and decoder devices provide support for
> +host-accelerated video encoding and decoding. Despite being different
> +device types, they use the same protocol and general flow.
> +
> +\subsection{Device ID}
> +\label{sec:Device Types / Video Device / Device ID}
> +
> +\begin{description}
> +\item[30]
> +  encoder device
> +\item[31]
> +  decoder device
> +\end{description}
> +
> +\subsection{Virtqueues}
> +\label{sec:Device Types / Video Device / Virtqueues}
> +
> +\begin{description}
> +\item[0]
> +  commandq - queue for driver commands and device responses to these
> commands
> +\item[1]
> +  eventq - queue for device delayed responses to commands and standalone
> +  device events
> +\end{description}
> +
> +\subsection{Feature bits}
> +\label{sec:Device Types / Video Device / Feature bits}
> +
> +\begin{description}
> +\item[VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES (0)]
> +  Guest pages can be used as the backing memory of resources.
> +\item[VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG (1)]
> +  The device can use non-contiguous guest memory as the backing memory o=
f
> +  resources. Only meaningful if VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES is
> also
> +  set.
> +\item[VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT (2)]
> +  Objects exported by another virtio device can be used as the backing
> memory
> +  of resources.
> +\item[VIRTIO_VIDEO_F_RESOURCE_DYNAMIC (3)]
> +  The device supports re-attaching memory to resources while streaming.
> +% TODO this flag is not used anywhere at the moment.
> +% Might be necessary with Android.
> +\end{description}
>

Maybe I am missing part of the previous dicussion, but is this
VIRTIO_VIDEO_F_RESOURCE_DYNAMIC flag new?
Not sure what re-attaching memory means and what the flag is supossed to do=
.
In the comment you mention specifically Android, so it got me curious. What
is the usecase for this feature flag?


> +
> +\devicenormative{\subsubsection}{Feature bits}{Device Types / Video
> Device / Feature bits}
> +
> +The device MUST set at least one of VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES =
or
> +VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT, since the absence of both bits
> would
> +mean that no memory can be used at all for resources.
> +
> +The device MUST NOT set VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG unless it als=
o
> sets
> +VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES.
> +
> +\drivernormative{\subsubsection}{Feature bits}{Device Types / Video
> Device / Feature bits}
> +
> +The driver MUST negotiate at least one of the
> +VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES and
> VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT
> +features.
> +
> +If VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES has been negotiated, but not
> +VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG, the driver MUST use physically
> +contiguous memory for all the buffers it allocates.
> +
> +\subsection{Device configuration layout}
> +\label{sec:Device Types / Video Device / Device configuration layout}
> +
> +The video device configuration space uses the following layout:
> +
> +\begin{lstlisting}
> +struct virtio_video_config {
> +        le32 caps_length;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{caps_length}]
> +  is the minimum length in bytes that a device-writable buffer must have
> +  in order to receive the response to VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS=
,
> see
> +  \ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.
> +\end{description}
> +
> +\devicenormative{\subsubsection}{Device configuration layout}{Device
> Types / Video Device / Device configuration layout}
> +
> +The device MUST set the \field{caps_length} field to a value equal to
> +the response size of VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS.
> +
> +\subsection{Supported parameters}
> +\label{sec:Device Types / Video Device / Supported parameters}
> +
> +\subsubsection{Supported coded formats}
> +\label{sec:Device Types / Video Device / Supported parameters / Supporte=
d
> coded formats}
> +
> +The following coded formats are defined:
> +\begin{lstlisting}
> +#define VIRTIO_VIDEO_CODED_FORMAT_MPEG2  1  /* MPEG-2 Part 2
> (V4L2_PIX_FMT_MPEG2) */
> +#define VIRTIO_VIDEO_CODED_FORMAT_MPEG4  2  /* MPEG-4 Part 2
> (V4L2_PIX_FMT_MPEG4) */
> +#define VIRTIO_VIDEO_CODED_FORMAT_H264   3  /* H.264
> (V4L2_PIX_FMT_H264)  */
> +#define VIRTIO_VIDEO_CODED_FORMAT_HEVC   4  /* HEVC aka H.265
> (V4L2_PIX_FMT_HEVC)  */
> +#define VIRTIO_VIDEO_CODED_FORMAT_VP8    5  /* VP8
> (V4L2_PIX_FMT_VP8)   */
> +#define VIRTIO_VIDEO_CODED_FORMAT_VP9    6  /* VP9
> (V4L2_PIX_FMT_VP9)   */
> +\end{lstlisting}
> +
> +The above constants have two usages:
> +\begin{enumerate}
> +\item As bit numbers, used to tell the driver which coded formats are
> +supported by the device, see
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.
> +\item As values, used to designate the coded format when working with
> +stream parameters, see
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.
> +\end{enumerate}
> +
> +The coded formats and the expected data units per buffer are documented =
in
> +\hyperref[intro:V4L2]{V4L2 header} and
> +\hyperref[intro:V4L2 compressed]{V4L2 compressed formats documentation}.
> +
> +\subsubsection{Supported raw formats}
> +\label{sec:Device Types / Video Device / Supported parameters / Supporte=
d
> raw formats}
> +
> +The following raw formats are defined:
> +\begin{lstlisting}
> +#define VIRTIO_VIDEO_RAW_FORMAT_ARGB8888  1  /* DRM_FORMAT_ARGB8888 /
> V4L2_PIX_FMT_ABGR32 */
> +#define VIRTIO_VIDEO_RAW_FORMAT_BGRA8888  2  /* DRM_FORMAT_BGRA8888 /
> V4L2_PIX_FMT_ARGB32 */
> +#define VIRTIO_VIDEO_RAW_FORMAT_RGBA8888  3  /* DRM_FORMAT_RGBA8888 /
> V4L2_PIX_FMT_BGRA32 */
> +#define VIRTIO_VIDEO_RAW_FORMAT_NV12      4  /* DRM_FORMAT_NV12     /
> V4L2_PIX_FMT_NV12   */
> +#define VIRTIO_VIDEO_RAW_FORMAT_YUV420    5  /* DRM_FORMAT_YUV420   /
> V4L2_PIX_FMT_YUV420 */
> +#define VIRTIO_VIDEO_RAW_FORMAT_YVU420    6  /* DRM_FORMAT_YVU420   /
> V4L2_PIX_FMT_YVU420 */
> +#define VIRTIO_VIDEO_RAW_FORMAT_YUYV      7  /* DRM_FORMAT_YUYV     /
> V4L2_PIX_FMT_YUYV   */
> +\end{lstlisting}
> +
> +The above constants have two usages:
> +\begin{enumerate}
> +\item As bit numbers, used to tell the driver which raw formats are
> +supported by the device, see
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.
> +\item As values, used to designate the raw format when working with
> +stream parameters, see
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.
> +\end{enumerate}
> +
> +The layouts of raw formats are documented in \hyperref[intro:DRM
> formats]{DRM}
> +and \hyperref[intro:V4L2]{V4L2} headers, as well as in
> +\hyperref[intro:V4L2 RGB]{V4L2 RGB} and
> +\hyperref[intro:V4L2 YUV]{planar YUV} formats documentation.
> +
> +\subsubsection{Supported stream parameters}
> +\label{sec:Device Types / Video Device / Supported parameters / Supporte=
d
> stream parameters}
> +
> +The following stream parameters are defined:
> +\begin{lstlisting}
> +#define VIRTIO_VIDEO_PARAM_CODED_FORMAT       1
> +#define VIRTIO_VIDEO_PARAM_RAW_FORMAT         2
> +#define VIRTIO_VIDEO_PARAM_CODED_RESOURCES    3
> +#define VIRTIO_VIDEO_PARAM_RAW_RESOURCES      4
> +#define VIRTIO_VIDEO_PARAM_CROP               5
> +#define VIRTIO_VIDEO_PARAM_BITRATE            6  /* Same as
> V4L2_CID_MPEG_VIDEO_BITRATE */
> +#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_MPEG2  7
> +#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_MPEG4  8
> +#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_H264   9
> +#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_HEVC   10
> +#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_VP8    11
> +#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_VP9    12
> +\end{lstlisting}
> +% TODO acourbot: See b/241492607 (fractional frame rates??)
> +
> +The above constants have two usages:
> +\begin{enumerate}
> +\item As bit numbers, used to tell the driver which stream parameters ar=
e
> +supported by the device, see
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.
> +\item As values, used to designate the stream parameters when working wi=
th
> +them, see
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.
> +\end{enumerate}
> +
> +\subsection{Device Initialization}
> +\label{sec:Device Types / Video Device / Device Initialization}
> +
> +\begin{enumerate}
> +\def\labelenumi{\arabic{enumi}.}
> +\item
> +  The driver reads the feature bits and negotiates the features it needs=
.
> +\item
> +  The driver sets up the commandq and the eventq.
> +\item
> +  The driver reads the \field{caps_length} field of the configuration
> +  space and prepares a buffer of at least that size.
> +\item
> +  The driver sends that buffer on the commandq with the
> +  VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS command.
> +\item
> +  The driver receives the response from the device, and parses its
> capabilities.
> +\end{enumerate}
> +
> +\subsection{Device Operation}
> +\label{sec:Device Types / Video Device / Device Operation}
> +
> +The commandq is used by the driver to send commands to the device and to
> +receive the device's responses via used buffers. The eventq is used by t=
he
> +device to send the device's delayed responses to commands and standalone
> +device events.
> +
> +The driver can create new streams using the
> +VIRTIO_VIDEO_CMD_STREAM_CREATE command. Each stream has two resource
> +queues (not to be confused with the virtio queues) called INPUT and
> +OUTPUT, when the direction of the data flow matters. The INPUT queue
> accepts
> +driver-filled input data for the device (coded data for a decoder;
> +input frames for an encoder), while the OUTPUT queue receives resources
> to be
> +filled by the device as a result of processing the INPUT queue (decoded
> raw
> +frames for a decoder; encoded data for an encoder).
> +
> +These same queues can be also called CODED and RAW, when their content
> matters.
> +The CODED queue is used to transfer compressed video data (INPUT for a
> decoder;
> +OUTPUT for an encoder), while the RAW queue is used to transfer raw fram=
es
> +(OUTPUT for a decoder; INPUT for an encoder).
> +
> +The INPUT and OUTPUT queues are effectively independent, and the driver
> +can fill them without caring about the other queue. In particular there
> +is no need to queue input and output resources in pairs: one input
> +resource can result in zero to many produced output resources.
> +
> +A resource is a set of memory buffers that contain a unit of data that
> +the device can process or produce. Most resources will only have one
> +buffer (like coded data and single-planar raw frames), but frames using =
a
> +multi-planar format can have several.
> +
> +Parameters allow the driver to configure the stream for the decoding or
> +encoding operation. The parameters can be obtained and configured using
> +VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS. Available parameters depend on
> +the device type and are detailed in section
> +\ref{sec:Device Types / Video Device / Supported parameters / Supported
> stream parameters}.
> +
> +Before resources can be submitted to a queue, backing memory must be
> +attached to them using VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING.
> +The exact form of that memory is negotiated using the feature flags.
> +
> +In the case of a decoder device, the decoded frames are made available
> +on the OUTPUT queue in presentation order.
> +
> +Resources are queued to the INPUT or OUTPUT queue using the
> +VIRTIO_VIDEO_CMD_RESOURCE_QUEUE command. The device sends a delayed
> response
> +to this command when an input resource has been fully processed and can =
be
> +reused by the driver, or when an output resource has been filled by the
> +device as a result of processing.
> +
> +The device can detect stream-related events that require intervention
> +from the driver and signals them on the eventq, see
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Standalone Events}.
> +One example is a dynamic parameters change while decoding a stream, whic=
h
> +may require the driver to reallocate the backing memory of its output
> +resources to fit the new resolution.
> +
> +% RESET and DRAIN have essentially the same outcome: all the input
> +% resources queued before the command are released, there are no related
> +% output resources in the decoder/encoder, the dequeued output resources
> +% can't be used as a reference by the device. So the other requirements
> should
> +% be reasonably similar.
> +% Use-case: playback in a loop from second 1 till the end of file.
> +
> +% TODO put some examples in the comments
> +
> +\subsubsection{Device Operation: Command Virtqueue}
> +\label{sec:Device Types / Video Device / Device Operation / Device
> Operation: Command Virtqueue}
> +
> +This section details the commands that can be sent on the commandq by
> +the driver, as well as the responses that the device will write.
> +
> +Different structures are used for each command and response. A command
> +structure starts with the requested command code, defined as follows:
> +
> +\begin{lstlisting}
> +/* Device */
> +#define VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS       0x100
> +
> +/* Stream */
> +#define VIRTIO_VIDEO_CMD_STREAM_CREATE           0x200
> +#define VIRTIO_VIDEO_CMD_STREAM_DESTROY          0x201
> +#define VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS       0x202
>

Why not having a GET_PARAMS counterpart?


> +#define VIRTIO_VIDEO_CMD_STREAM_DRAIN            0x203
> +#define VIRTIO_VIDEO_CMD_STREAM_RESET            0x204
> +
> +/* Resource */
> +#define VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING 0x300
> +#define VIRTIO_VIDEO_CMD_RESOURCE_QUEUE          0x301
> +\end{lstlisting}
> +
> +A response structure starts with the result of the requested command,
> +defined as follows:
> +
> +\begin{lstlisting}
> +/* Success */
> +#define VIRTIO_VIDEO_RESULT_OK                          0x000
> +#define VIRTIO_VIDEO_RESULT_OK_DELAYED                  0x001
> +
> +/* Error */
> +#define VIRTIO_VIDEO_RESULT_ERR_INVALID_COMMAND         0x100
> +#define VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION       0x101
> +#define VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID       0x102
> +#define VIRTIO_VIDEO_RESULT_ERR_INVALID_RESOURCE_ID     0x103
> +#define VIRTIO_VIDEO_RESULT_ERR_INVALID_ARGUMENT        0x104
> +#define VIRTIO_VIDEO_RESULT_ERR_OUT_OF_MEMORY           0x105
> +\end{lstlisting}
> +
> +For response structures carrying an error code, the rest of the
> +structure is considered invalid.
> +
> +For all commands beginning background operations and returning delayed
> +responses over eventq, the command response is defined as follows:
> +
> +\begin{lstlisting}
> +#define VIRTIO_VIDEO_INVALID_RESPONSE_ID  0xffffffff
> +
> +struct virtio_video_command_resp_delayed_common {
> +        le32 result; /* VIRTIO_VIDEO_RESULT_* */
> +        le32 delayed_response_id;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{result}]
> +  is
> +
> +  \begin{description}
> +  \item[VIRTIO_VIDEO_RESULT_OK_DELAYED]
> +    if the command started the desired background operation successfully=
,
> +  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID]
> +    if the mentioned stream ID does not exist,
> +  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_RESOURCE_ID]
> +    if the mentioned resource ID does not exist,
> +  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_ARGUMENT]
> +    if other command parameters are not valid, e.g. not within the
> device's
> +    capabilities,
> +  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION]
> +    if the command is performed at a time when it is not valid.
> +  \end{description}
> +\item[\field{delayed_response_id}]
> +  is an ID of the future delayed response provided by the device, that
> allows
> +  to relate it to the command.
> +\end{description}
> +
> +\devicenormative{\paragraph}{Device Operation: Command Virtqueue}{Device
> Types / Video Device / Device Operation / Device Operation: Command
> Virtqueue}
> +
> +Responses to a command MUST be written by the device in the first
> +device-writable descriptor of the descriptor chain from which the
> +command came.
> +
> +The device MUST return VIRTIO_VIDEO_RESULT_ERR_INVALID_COMMAND to
> +any command code it does not recognize.
> +
> +\field{delayed_response_id} MUST be set to a stream-unique identifier th=
at
> +remains valid as long as the background operation hasn't finished.

+
> +\drivernormative{\paragraph}{Device Operation: Command Virtqueue}{Device
> Types / Video Device / Device Operation / Device Operation: Command
> Virtqueue}
> +
> +Descriptor chains sent to the commandq by the driver MUST include at
> +least one device-writable descriptor of a size sufficient to receive the
> +response to the queued command.
> +
> +The driver MUST NOT interpret the rest of a response whose result is not
> +VIRTIO_VIDEO_RESULT_OK or VIRTIO_VIDEO_RESULT_OK_DELAYED.
> +
> +\subsubsection{Device Operation: Event Virtqueue}
> +\label{sec:Device Types / Video Device / Device Operation / Device
> Operation: Event Virtqueue}
> +
> +The eventq is used by the device to send delayed responses to commands
> queued
> +by the driver on the commandq and standalone events. Stream errors and
> dynamic
> +parameters changes are caused by changes in the device's state, not by
> +commands, still they are delivered as
> VIRTIO_VIDEO_DELAYED_RESP_STREAM_DESTROY
> +and VIRTIO_VIDEO_DELAYED_RESP_STREAM_SET_PARAMS, respectively.
>

So, ERROR and DRC events trigger a VIRTIO_VIDEO_DELAYED_RESP_STREAM_DESTROY
and VIRTIO_VIDEO_DELAYED_RESP_STREAM_SET_PARAMS events, respectively.
And VIRTIO_VIDEO_DELAYED_RESP_STREAM_SET_PARAMS will have
a valid `delayed_response_id` only if it comes from a SET_PARAMS command
from the
driver. Otherwise, if it is due to a dynamic parameter change,
`delayed_response_id`
will be set to `VIRTIO_VIDEO_INVALID_RESPONSE_ID`. Is this correct?


> +
> +The supported events are defined as follows:
> +
> +\begin{lstlisting}
> +#define VIRTIO_VIDEO_DELAYED_RESP_STREAM_DESTROY     1
> +#define VIRTIO_VIDEO_DELAYED_RESP_STREAM_SET_PARAMS  2
> +#define VIRTIO_VIDEO_DELAYED_RESP_STREAM_DRAIN       3
> +#define VIRTIO_VIDEO_DELAYED_RESP_STREAM_RESET       4
> +#define VIRTIO_VIDEO_DELAYED_RESP_RESOURCE_QUEUE     5
> +
> +#define VIRTIO_VIDEO_EVENT_FLAG_CANCELED             (1 << 0)
> +
> +struct virtio_video_event {
> +        le32 event_type; /* VIRTIO_VIDEO_DELAYED_RESP_* */
> +        le32 stream_id;
> +        le32 delayed_response_id;
> +        le32 event_flags; /* Bitmask of VIRTIO_VIDEO_EVENT_FLAG_* */
> +        union {
> +                struct virtio_video_stream_set_params_delayed_resp
> set_params;
> +                struct virtio_video_resource_queue_delayed_resp queue;
> +        };
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{event_type}]
> +  is the type of the event.
> +\item[\field{stream_id}]
> +  is the ID of a valid stream.
> +\item[\field{delayed_response_id}]
> +  is an ID of the delayed response, that allows to relate it to a
> previously
> +  submitted command. If it is set to VIRTIO_VIDEO_INVALID_RESPONSE_ID,
> then
> +  this is a standalone event, see
> +  \ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Standalone Events}.
> +\item[\field{event_flags}]
> +  is a bitmask of VIRTIO_VIDEO_EVENT_FLAG_* flags
> +
> +  \begin{description}
> +  \item[VIRTIO_VIDEO_EVENT_FLAG_CANCELED]
> +    is set if the command has been canceled by another command, that has
> +    higher priority. Doesn't make sense for standalone events.
> +  \end{description}
> +\end{description}
> +
> +The particular member of the union is selected according to the
> +\field{event_type} for some of the types.
> +
> +\drivernormative{\paragraph}{Device Operation: Event Virtqueue}{Device
> Types / Video Device / Device Operation / Device Operation: Event Virtque=
ue}
> +
> +The driver MUST at any time have at least one descriptor with a used
> +buffer large enough to contain a \field{struct virtio_video_event}
> +queued on the eventq.
> +
> +The driver MUST NOT put device-readable descriptors into the eventq.
> +
> +\subsubsection{Device Operation: Device Commands}
> +\label{sec:Device Types / Video Device / Device Operation / Device
> Operation: Device Commands}
> +
> +This command allows retrieving the device capabilities.
> +
> +\paragraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}
> +\label{sec:Device Types / Video Device / Device Operation / Device
> Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}
> +
> +Retrieve device capabilities for all available stream parameters.
> +
> +The driver sends this command with
> +\field{struct virtio_video_device_query_caps}:
> +
> +\begin{lstlisting}
> +struct virtio_video_device_query_caps {
> +        le32 cmd_type; /* VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS */
> +};
> +\end{lstlisting}
> +
> +The device responds with
> +\field{struct virtio_video_device_query_caps_resp}:
> +
> +\begin{lstlisting}
> +#define MASK(x) (1 << (x))
> +
> +struct virtio_video_device_query_caps_resp {
> +        le32 result; /* VIRTIO_VIDEO_RESULT_* */
> +        le32 stream_params_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_PARAM_*) */
> +        le32 coded_formats_bitmask; /* Bitmaks of
> MASK(VIRTIO_VIDEO_CODED_FORMAT_*) */
> +        le32 raw_formats_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_RAW_FORMAT_*) */
> +        le32 num_format_deps;
> +        le32 num_raw_format_caps;
> +        le32 num_coded_resources_caps;
> +        le32 num_raw_resources_caps;
> +        le32 num_bitrate_caps; /* If MASK(VIRTIO_VIDEO_PARAM_BITRATE) is
> set. */
> +        u8 padding[4];
> +        /* If corresponding MASK(VIRTIO_VIDEO_PARAM_GROUP_CODEC_*) is
> set. */
> +        struct virtio_video_mpeg2_caps mpeg2_caps;
> +        struct virtio_video_mpeg4_caps mpeg4_caps;
> +        struct virtio_video_h264_caps h264_caps;
> +        struct virtio_video_hevc_caps hevc_caps;
> +        struct virtio_video_vp8_caps vp8_caps;
> +        struct virtio_video_vp9_caps vp9_caps;
> +        /**
> +         * Followed by
> +         * struct virtio_video_format_dependency
> format_deps[num_format_deps];
> +         */
> +        /**
> +         * Followed by
> +         * struct virtio_video_raw_format_caps
> raw_format_caps[num_raw_format_caps];
> +         */
> +        /**
> +         * Followed by
> +         * struct virtio_video_coded_resources_caps
> +         * coded_resources_caps[num_coded_resources_caps];
> +         */
> +        /**
> +         * Followed by
> +         * struct virtio_video_raw_resources_caps
> raw_resources_caps[num_raw_resources_caps];
> +         */
> +        /**
> +         * Followed by if MASK(VIRTIO_VIDEO_PARAM_BITRATE) is set
> +         * struct virtio_video_bitrate_caps
> bitrate_caps[num_bitrate_caps];
> +         */
> +};
>

Maybe nitpicking, but some of the member structs are inside a comment and
some are not.
Does not seem to correlate with them being conditional.
I think is nice to have conditional fields in comment blocks to highlight
it, but then the
VIRTIO_VIDEO_PARAM_GROUP_CODEC_* structs need to be in their own comment
block.


> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{result}]
> +  is
> +
> +  \begin{description}
> +  \item[VIRTIO_VIDEO_RESULT_OK]
> +    if the operation succeeded,
> +  \item[VIRTIO_VIDEO_RESULT_ERR_OUT_OF_MEMORY]
> +    if the descriptor was smaller than the defined \field{caps_length} i=
n
> +    the video device configuration.
> +  \end{description}
> +\item[\field{stream_params_bitmask}]
> +  is a bitmask of supported stream parameters.
> +\item[\field{coded_formats_bitmask}]
> +  is a bitmask of supported coded formats.
> +\item[\field{raw_formats_bitmask}]
> +  is a bitmask of supported raw formats.
> +\item[\field{num_format_deps}]
> +  is the number of elements in the format_deps array.
> +\item[\field{num_raw_format_caps}]
> +  is the number of elements in the raw_format_caps array.
> +\item[\field{num_coded_resources_caps}]
> +  is the number of elements in the coded_resources_caps array.
> +\item[\field{num_raw_resources_caps}]
> +  is the number of elements in the raw_resources_caps array.
> +\item[\field{num_bitrate_caps}]
> +  is the number of elements in the bitrate_caps array.
> +\item[\field{mpeg2_caps}]
> +  groups the capabilities of MPEG2 specific parameters.
> +\item[\field{mpeg4_caps}]
> +  groups the capabilities of MPEG4 specific parameters.
> +\item[\field{h264_caps}]
> +  groups the capabilities of H.264 specific parameters.
> +\item[\field{hevc_caps}]
> +  groups the capabilities of HEVC specific parameters.
> +\item[\field{vp8_caps}]
> +  groups the capabilities of VP8 specific parameters.
> +\item[\field{vp9_caps}]
> +  groups the capabilities of VP9 specific parameters.
> +\item[\field{format_deps}]
> +  is an array of size \field{num_format_deps} establishing dependencies
> +  between coded and raw formats.
> +\item[\field{raw_format_caps}]
> +  is an array of size \field{num_raw_format_caps} containing the support=
ed
> +  raw formats capabilities.
> +\item[\field{coded_resources_caps}]
> +  is an array of size \field{num_coded_resources_caps}, that sets bounds
> for
> +  the number of resources in the CODED queue.
> +\item[\field{raw_resources_caps}]
> +  is an array of size \field{num_raw_resources_caps}, that sets bounds f=
or
> +  the number of resources in the RAW queue.
> +\item[\field{bitrate_caps}]
> +  is an array of size \field{num_bitrate_caps} containing the supported
> +  bitrates.
> +\end{description}
> +
> +% TODO: V4L2 flow: 1. coded format without variants (maybe these flags
> +% are relevant too: V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM?,
> +% V4L2_FMT_FLAG_DYN_RESOLUTION?, V4L2_FMT_FLAG_ENC_CAP_FRAME_INTERVAL???=
),
> +% also include variants (see VIDIOC_QUERYCTRL), then raw formats,
> +% then resolutions (discrete or stepwise, see VIDIOC_ENUM_FRAMESIZES),
> +% intervals are optional (see VIDIOC_ENUM_FRAMEINTERVALS)
> +
> +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}{Devi=
ce
> Types / Video Device / Device Operation / Device Operation: Device Comman=
ds
> / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}
> +
> +The device MUST support at least these parameters:
> +VIRTIO_VIDEO_PARAM_CODED_FORMAT, VIRTIO_VIDEO_PARAM_RAW_FORMAT,
> +VIRTIO_VIDEO_PARAM_CODED_RESOURCES, VIRTIO_VIDEO_PARAM_RAW_RESOURCES.
> +
> +The device MUST NOT mark codec-specific parameters
> +(VIRTIO_VIDEO_PARAM_GROUP_CODEC_*) as supported unless the corresponding
> +codecs are supported as well.
> +
> +The device MUST set to zero all fields with capabilities of unsupported
> +parameters.
> +
> +The lengths \field{num_format_deps}, \field{num_raw_format_caps},
> +\field{num_coded_resources_caps} and \field{num_raw_resources_caps} MUST
> be
> +positive.
> +
> +The device MUST write the five \field{format_deps},
> +\field{raw_format_caps}, \field{coded_resources_caps},
> +\field{raw_resources_caps} and \field{bitrate_caps} arrays, of length
> +\field{num_format_deps}, \field{num_raw_format_caps},
> +\field{num_coded_resources_caps}, \field{num_raw_resources_caps} and
> +\field{num_bitrate_caps}, respectively.
> +
> +For each coded format in the \field{coded_formats_bitmask} there MUST be
> +at least one element of \field{format_deps} referencing it.
> +
> +For each raw format in the \field{raw_formats_bitmask} there MUST be
> +at least one element of \field{format_deps} referencing it.
> +
> +For any coded and any raw format there MUST be at most one element of
> +\field{format_deps} referencing both of them.
> +
> +Elements of \field{format_deps} SHOULD be ordered according to raw forma=
t
> +preferences of the device from preferred to not preferred ones.
> +
> +For each raw format in the \field{raw_formats_bitmask} there MUST be
> +exactly one element of \field{raw_format_caps} referencing it.
> +
> +For each coded format in the \field{coded_formats_bitmask} there MUST be
> +exactly one element of \field{coded_resources_caps} referencing it.
> +
> +For each raw format in the \field{raw_formats_bitmask} there MUST be
> +exactly one element of \field{raw_resources_caps} referencing it.
> +
> +If VIRTIO_VIDEO_PARAM_BITRATE is supported, then for each coded format i=
n
> +the \field{coded_formats_bitmask} there MUST be exactly one element of
> +\field{bitrate_caps} referencing it.
> +
> +The total size of the response MUST be equal to \field{caps_length}
> +bytes, as reported by the device configuration.
> +
> +\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Format dependencies}
> +
> +The description of dependencies between coded and raw formats
> +\field{virtio_video_format_dependency} is defined as follows:
> +
> +\begin{lstlisting}
> +struct virtio_video_format_dependency {
> +        le32 coded_formats_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_CODED_FORMAT_*) */
> +        le32 raw_format; /* VIRTIO_VIDEO_RAW_FORMAT_* */
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{coded_formats_bitmask}]
> +  specifies coded formats, see
> +  \ref{sec:Device Types / Video Device / Supported parameters / Supporte=
d
> coded formats}.
> +  If a bit for a specific coded format is set, then this coded format ca=
n
> be
> +  decoded into the specified raw format or encoded from it.
> +\item[\field{raw_format}]
> +  is a raw format, see
> +  \ref{sec:Device Types / Video Device / Supported parameters / Supporte=
d
> raw formats}.
> +\end{description}
> +
> +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS:
> Format dependencies}{Device Types / Video Device / Device Operation /
> Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS /
> VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Format dependencies}
> +
> +\field{coded_formats_bitmask} MUST be a subset of
> \field{coded_formats_bitmask}
> +field of \field{struct virtio_video_device_query_caps_resp}.
> +
> +\field{coded_formats_bitmask} MUST specify at least one coded format.
> +
> +\field{raw_format} MUST be set to one of the supported raw formats
> according to
> +the \field{raw_formats_bitmask} field of
> +\field{struct virtio_video_device_query_caps_resp}.
> +
> +\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format capabilitie=
s}
> +\label{sec:Device Types / Video Device / Device Operation / Device
> Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS /
> VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format capabilities}
> +
> +The raw format capability description
> \field{virtio_video_raw_format_caps} is
> +defined as follows:
> +
> +\begin{lstlisting}
> +enum virtio_video_planes_layout {
> +        VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER =3D 1,
> +        VIRTIO_VIDEO_PLANES_LAYOUT_MULTI_BUFFERS =3D 2,
> +};
> +
> +struct virtio_video_range {
> +        le32 min;
> +        le32 max;
> +        le32 step;
> +        u8 padding[4];
> +};
> +
> +struct virtio_video_raw_format_caps {
> +        le32 raw_formats_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_RAW_FORMAT_*) */
> +        le32 planes_layouts; /* Bitmask of VIRTIO_VIDEO_PLANES_LAYOUT_* =
*/
> +        le32 plane_align;
> +        le32 stride_align_mask;
> +        struct virtio_video_range width_range;
> +        struct virtio_video_range height_range;
> +};
> +\end{lstlisting}
> +
> +\field{struct virtio_video_range} is used to represent a range of values=
.
> +An integer \(x\) is within the range \field{r} if
> +\(\field{r.min} \le x \le \field{r.max}\) holds and \(x\) equals to
> +\((\field{min} + \field{step} * n)\) for some integer \(n\).
> +
> +\begin{description}
> +\item[\field{raw_formats_bitmask}]
> +  specifies raw formats, see
> +  \ref{sec:Device Types / Video Device / Supported parameters / Supporte=
d
> raw formats},
> +  to which these capabilities apply.
> +\item[\field{planes_layouts}]
> +  is a bitmask with the set of plane layout types from
> +  \field{enum virtio_video_planes_layout}.
> +\item[\field{plane_align}]
> +  is the alignment of planes within a buffer in bytes. This field is val=
id
> +  only if \field{planes_layouts} has the
> +  \field{VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER} bit set.
> +\item[\field{stride_align_mask}]
> +  is a mask of all supported power of two stride alignments.
> +\item[\field{width_range}]
> +  is a range of widths in pixels.
> +\item[\field{height_range}]
> +  is a range of heights in pixels.
> +\end{description}
> +
> +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw
> format capabilities}{Device Types / Video Device / Device Operation /
> Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS /
> VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format capabilities}
> +
> +\field{raw_formats_bitmask} MUST be a subset of
> \field{raw_formats_bitmask}
> +field of \field{struct virtio_video_device_query_caps_resp}.
> +
> +\field{raw_formats_bitmask} MUST specify at least one raw format.
> +
> +The device MUST set \field{VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER} bit
> in
> +\field{planes_layouts} if the plane layout with planes of a frame laid
> out one
> +after another in the same buffer is supported.
> +
> +The device MUST set \field{VIRTIO_VIDEO_PLANES_LAYOUT_MULTI_BUFFERS} bit
> in
> +\field{planes_layouts} if the plane layout with planes of a frame laid
> out in
> +separate buffers is supported.
> +
> +\field{plane_align} MUST be set to a power of two according to the devic=
e
> +plane alignment requirements if \field{planes_layouts} has the
> +\field{VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER} bit set or to zero
> otherwise.
> +
> +\field{min}, \field{step} and \field{max} MUST be positive.
> +
> +\field{min} MUST be less then or equal to \field{max} within the same
> range.
> +
> +\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Resource capabilities}
> +
> +The CODED resource capabilities \field{virtio_video_coded_resources_caps=
}
> is
> +defined as follows:
> +
> +\begin{lstlisting}
> +struct virtio_video_coded_resources_caps {
> +        le32 coded_formats_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_CODED_FORMAT_*) */
> +        le32 min_resources;
> +        le32 max_resources;
> +        le32 buffer_size;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{coded_formats_bitmask}]
> +  specifies coded formats, see
> +  \ref{sec:Device Types / Video Device / Supported parameters / Supporte=
d
> coded formats},
> +  to which these capabilities apply.
> +\item[\field{min_resources}]
> +  is the minimum number of resources that the CODED queue supports for a=
ll
> +  the specified coded formats.
> +\item[\field{max_resources}]
> +  is the maximum number of resources that the CODED queue supports for a=
ll
> +  the specified coded formats.
> +\item[\field{buffer_size}]
> +  is the minimum size of the buffers that will back resources to be
> queued.
> +\end{description}
> +
> +The RAW resource capabilities \field{virtio_video_raw_resources_caps} is
> +defined as follows:
> +
> +\begin{lstlisting}
> +struct virtio_video_raw_resources_caps {
> +        le32 raw_formats_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_RAW_FORMAT_*) */
> +        le32 min_resources;
> +        le32 max_resources;
> +        u8 padding[4];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{raw_formats_bitmask}]
> +  specifies raw formats, see
> +  \ref{sec:Device Types / Video Device / Supported parameters / Supporte=
d
> raw formats},
> +  to which these capabilities apply.
> +\item[\field{min_resources}]
> +  is the minimum number of resources that the RAW queue supports for all
> +  the specified raw formats.
> +\item[\field{max_resources}]
> +  is the maximum number of resources that the RAW queue supports for all
> +  the specified raw formats.
> +\end{description}
> +
> +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS:
> Resource capabilities}{Device Types / Video Device / Device Operation /
> Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS /
> VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Resource capabilities}
> +
> +\field{coded_formats_bitmask} MUST be a subset of
> \field{coded_formats_bitmask}
> +field of \field{struct virtio_video_device_query_caps_resp}.
> +
> +\field{coded_formats_bitmask} MUST specify at least one coded format.
> +
> +\field{raw_formats_bitmask} MUST be a subset of
> \field{raw_formats_bitmask}
> +field of \field{struct virtio_video_device_query_caps_resp}.
> +
> +\field{raw_formats_bitmask} MUST specify at least one raw format.
> +
> +\field{min_resources} MUST NOT be negative.
> +
> +\field{max_resources} MUST be greater then or equal to
> \field{min_resources}
> +within the same struct instance.
> +
> +\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Bitrates}
> +
> +The bitrate capabilities \field{virtio_video_bitrate_caps} is
> +defined as follows:
> +
> +\begin{lstlisting}
> +struct virtio_video_bitrate_caps {
> +        le32 coded_formats_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_CODED_FORMAT_*) */
> +        le32 min_bitrate;
> +        le32 max_bitrate;
> +        u8 padding[4];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{coded_formats_bitmask}]
> +  specifies coded formats, see
> +  \ref{sec:Device Types / Video Device / Supported parameters / Supporte=
d
> coded formats},
> +  to which these capabilities apply.
> +\item[\field{min_bitrate}]
> +  is the minimum bitrate in bits per second supported by the encoder for
> all the specified coded
> +  formats.
> +\item[\field{max_bitrate}]
> +  is the maximum bitrate in bits per second supported by the encoder for
> all the specified coded
> +  formats.
> +\end{description}
> +
> +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS:
> Bitrates}{Device Types / Video Device / Device Operation / Device
> Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS /
> VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Bitrates}
> +
> +\field{coded_formats_bitmask} MUST be a subset of
> \field{coded_formats_bitmask}
> +field of \field{struct virtio_video_device_query_caps_resp}.
> +
> +\field{coded_formats_bitmask} MUST specify at least one coded format.
> +
> +\field{min_bitrate} MUST NOT be negative.
> +
> +\field{max_bitrate} MUST be greater then or equal to \field{min_bitrate}
> +within the same \field{struct virtio_video_bitrate_caps} instance.
> +
> +\subsubsection{Device Operation: Stream commands}
> +\label{sec:Device Types / Video Device / Device Operation / Device
> Operation: Stream commands}
> +
> +Stream commands allow the creation, destruction, and flow control of a
> +stream.
> +
> +\paragraph{VIRTIO_VIDEO_CMD_STREAM_CREATE}
> +\label{sec:Device Types / Video Device / Device Operation / Device
> Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_CREATE}
> +
> +Create a new stream using the device.
> +
> +The driver sends this command with
> +\field{struct virtio_video_stream_create}:
> +
> +\begin{lstlisting}
> +struct virtio_video_stream_create {
> +        le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_CREATE */
> +};
> +\end{lstlisting}
> +
> +The device responds with \field{struct virtio_video_stream_create_resp}:
> +
> +\begin{lstlisting}
> +struct virtio_video_stream_create_resp {
> +        le32 result; /* VIRTIO_VIDEO_RESULT_* */
> +        le32 stream_id;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{result}]
> +  is
> +
> +  \begin{description}
> +  \item[VIRTIO_VIDEO_RESULT_OK]
> +    if the operation succeeded,
> +  \item[VIRTIO_VIDEO_RESULT_ERR_OUT_OF_MEMORY]
> +    if the limit of simultaneous streams has been reached by the device
> and
> +    no more can be created.
> +  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION]
> +    if the stream cannot be created due to an unexpected device issue.
> +  \end{description}
> +\item[\field{stream_id}]
> +  is the ID of the created stream allocated by the device.
> +\end{description}
> +
> +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_CREATE}{Device
> Types / Video Device / Device Operation / Device Operation: Stream comman=
ds
> / VIRTIO_VIDEO_CMD_STREAM_CREATE}
> +
> +\field{stream_id} MUST be set to a device-unique identifier that remains
> +valid as long as the stream is alive.
> +
> +\paragraph{VIRTIO_VIDEO_CMD_STREAM_DESTROY}
> +\label{sec:Device Types / Video Device / Device Operation / Device
> Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DESTROY}
> +
> +% DESTROY has to be more like RESET, not DRAIN, because it is called, fo=
r
> +% example, when the guest user-space app closes a file descriptor. So
> there
> +% is no sense in continuing the processing.
> +
> +Destroy a video stream and all its resources. Any activity on the stream
> +is halted and all resources are released by the time the delayed respons=
e
> is
> +received by the driver.
> +
> +The driver sends this command with
> +\field{struct virtio_video_stream_destroy}:
> +
> +\begin{lstlisting}
> +struct virtio_video_stream_destroy {
> +        le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_DESTROY */
> +        le32 stream_id;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{stream_id}]
> +  is the ID of the stream to be destroyed, as previously returned by
> +  VIRTIO_VIDEO_CMD_STREAM_CREATE.
> +\end{description}
> +
> +The device responds as described in
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Command Virtqueue}
> +and begins the background DESTROY operation.
> +
> +When the command is completed the device sends the
> +VIRTIO_VIDEO_DELAYED_RESP_STREAM_DESTROY delayed response, see
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Event Virtqueue}.
> +The delayed response can also come in case of unrecoverable stream error=
,
> see
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Standalone Events / Error Event}.
> +
> +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_DESTROY}{Device
> Types / Video Device / Device Operation / Device Operation: Stream comman=
ds
> / VIRTIO_VIDEO_CMD_STREAM_DESTROY}
> +
> +Before the device sends a delayed response to
> VIRTIO_VIDEO_CMD_STREAM_DESTROY,
> +it MUST send all other pending delayed responses with
> +VIRTIO_VIDEO_EVENT_FLAG_CANCELED flag set and detach all resources.
> +
> +After VIRTIO_VIDEO_CMD_STREAM_DESTROY is queued, the device MUST reply
> with
> +VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID to any subsequently queued
> command
> +with this stream ID.
> +
> +The DESTROY operation MUST NOT be canceled.
> +
> +\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_DESTROY}{Device
> Types / Video Device / Device Operation / Device Operation: Stream comman=
ds
> / VIRTIO_VIDEO_CMD_STREAM_DESTROY}
> +
> +\field{stream_id} MUST be set to a valid stream ID previously returned
> +by VIRTIO_VIDEO_CMD_STREAM_CREATE.
> +
> +The driver MUST stop using \field{stream_id} as a valid stream after it
> +received the delayed response to this command.
> +
> +\paragraph{VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}
> +\label{sec:Device Types / Video Device / Device Operation / Device
> Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}
> +
> +Write values of selected parameters of a given stream, and receive back
> the
> +values for all the parameters supported by the device as reported by
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.
> +The operation can be either executed immediately, or queued into the INP=
UT
> +queue, i.e. after processing all the INPUT queue elements that are queue=
d
> +before the command.
> +
> +The driver sends this command with
> +\field{struct virtio_video_stream_set_params}:
> +
> +\begin{lstlisting}
> +#define VIRTIO_VIDEO_SET_PARAMS_FLAG_IN_BAND  (1 << 0)
> +
> +struct virtio_video_stream_set_params {
> +        le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS */
> +        le32 stream_id;
> +        le32 flags; /* Bitmask of VIRTIO_VIDEO_SET_PARAMS_FLAG_* */
> +        u8 padding[4];
> +        struct virtio_video_params params;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{stream_id}]
> +  is the ID of the stream we want to set a parameter for.
> +\item[\field{flags}]
> +  is a bitmask of VIRTIO_VIDEO_SET_PARAMS_FLAG_* values.
> +
> +  \begin{description}
> +  \item[\field{VIRTIO_VIDEO_SET_PARAMS_FLAG_IN_BAND}]
> +    The submitted parameters are to be set only after all of the
> previously
> +    queued INPUT queue elements are processed. Without this flag the
> +    parameters are set Immediately.
> +  \end{description}
> +\item[\field{params}]
> +  is a container for the selected stream parameters to be set.
> +\end{description}
> +
> +The device responds as described in
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Command Virtqueue}
> +and begins the background SET_PARAMS operation.
> +
> +When the background processing of the resource is completed the device
> sends
> +the VIRTIO_VIDEO_DELAYED_RESP_STREAM_SET_PARAMS delayed response, see
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Event Virtqueue}.
> +The delayed response can also come in case of dynamic parameters change,
> see
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Standalone Events / Dynamic Parameters Change Event}.
> +
> +The command-specific delayed response
> +\field{struct virtio_video_stream_set_params_delayed_resp} is defined
> +as follows:
> +
> +\begin{lstlisting}
> +struct virtio_video_stream_set_params_delayed_resp {
> +        struct virtio_video_params params;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{params}]
> +  is a container for the actual values of all the parameters supported b=
y
> the
> +  device. The values set by the device may differ from the requested
> values
> +  depending on the device's capabilities.
> +\end{description}
> +
> +The \field{struct virtio_video_params} is defined as follows:
> +
> +\begin{lstlisting}
> +struct virtio_video_raw_format {
> +        le32 format;
> +        le32 planes_layout; /* VIRTIO_VIDEO_PLANES_LAYOUT_* */
> +        le32 stride;
> +        le32 width;
> +        le32 height;
> +        u8 padding[4];
> +};
> +
> +struct virtio_video_param_crop {
> +        le32 left;
> +        le32 top;
> +        le32 width;
> +        le32 height;
> +};
> +
> +union virtio_video_codec_params {
> +        struct virtio_video_mpeg2_params mpeg2;
> +        struct virtio_video_mpeg4_params mpeg4;
> +        struct virtio_video_h264_params h264;
> +        struct virtio_video_hevc_params hevc;
> +        struct virtio_video_vp8_params vp8;
> +        struct virtio_video_vp9_params vp9;
> +};
> +
> +struct virtio_video_params {
> +        le32 stream_params_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_PARAM_*) */
> +        le32 coded_format; /* If MASK(VIRTIO_VIDEO_PARAM_CODED_FORMAT) i=
s
> set. */
> +        /* If MASK(VIRTIO_VIDEO_PARAM_RAW_FORMAT) is set. */
> +        struct virtio_video_raw_format raw_format;
> +        /* If MASK(VIRTIO_VIDEO_PARAM_CODED_RESOURCES) is set. */
> +        struct virtio_video_param_resources coded_resources;
> +        /* If MASK(VIRTIO_VIDEO_PARAM_RAW_RESOURCES) is set. */
> +        struct virtio_video_param_resources raw_resources;
> +        struct virtio_video_param_crop crop; /* If
> MASK(VIRTIO_VIDEO_PARAM_CROP) is set. */
> +        le32 bitrate; /* If MASK(VIRTIO_VIDEO_PARAM_BITRATE) is set. */
> +        u8 padding[4];
> +        /* If the corresponding MASK(VIRTIO_VIDEO_PARAM_GROUP_CODEC_*) i=
s
> set
> +        * depending on the coded_format. */
> +        union virtio_video_codec_params codec;
> +};
> +\end{lstlisting}
>

This is a bit difficult to read for me, as some of the *if* comments are
written AFTER
the member definition, and some others BEFORE the member defintion.
Above, when introducing the VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS command,
you use this format for the conditional fields:
/**
* Followed by if MASK(VIRTIO_VIDEO_PARAM_BITRATE) is set
* struct virtio_video_bitrate_caps bitrate_caps[num_bitrate_caps];
*/
It spaces a bit more the members, and leaves them as part of the
comment block. I would suggest to keep the format consistent.


> +
> +\begin{description}
> +\item[\field{stream_params_bitmask}]
> +  is a bitmask of supported stream parameters.
> +\item[\field{coded_format}]
> +  is a coded format of the CODED queue, see
> +  \ref{sec:Device Types / Video Device / Supported parameters}.
> +\item[\field{raw_format}]
> +  is a raw format of the RAW queue including related parameters
> +
> +  \begin{description}
> +  \item[\field{format}]
> +    is the actual format, see
> +    \ref{sec:Device Types / Video Device / Supported parameters /
> Supported raw formats}.
> +  \item[\field{planes_layout}]
> +    is the actual layout of the planes, see
> +    \ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS /
> VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format capabilities}.
> +  \item[\field{stride}]
> +    is the distance in bytes between two lines of data.
> +  \item[\field{width}]
> +    is the width in pixels of the stream frames.
> +  \item[\field{height}]
> +    is the height in pixels of the stream frames.
> +  \end{description}
> +\item[\field{coded_resources}]
> +  is the CODED queue resources parameters, see
> +  \ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.
> +\item[\field{raw_resources}]
> +  is the RAW queue resources parameters, see
> +  \ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.
> +\item[\field{crop}]
> +  is the rectangle covering the visible size of the frame, i.e the part =
of
> +  the frame that should be displayed, \field{width} and \field{height} a=
re
> +  relative to \field{left} and \field{top}.
> +\item[\field{bitrate}]
> +  is the current desired bitrate for the encoder. This can be changed at
> +  any moment by the driver and will apply to subsequently submitted
> frames.
> +\item[\field{codec}]
> +  consists of codec-specific parameters, see
> +  \ref{sec:Device Types / Video Device / Codec-specific parameters} for
> the
> +  definitions. Not available until \field{coded_format} is set.
> +\end{description}
> +
> +Successfully setting \field{coded_format}, \field{coded_resources},
> +\field{raw_format} or \field{raw_resources} starts with an implicit
> +background DRAIN operation if the corresponding queue has any queued
> +resources, then all the remaining elements in the queue are cancelled if
> +there are any and then all currently attached resources of the queue are
> +detached if there are any, i.e. the driver cannot queue a resource to th=
e
> +queue without attaching some backing memory first.
> +
> +% Use-case: for the decoder, resolution can be set manually by the drive=
r
> +% (useful for codecs that do not embed this information). The processing
> +% sequence should the look similar to the dynamic parameters change case=
.
> +
> +\field{struct virtio_video_param_resources} is used to control the
> +number of resources and their backing memory type for the INPUT and
> +OUTPUT queues:
> +
> +\begin{lstlisting}
> +#define VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES       0x1
> +#define VIRTIO_VIDEO_MEM_TYPE_VIRTIO_OBJECT     0x2
> +
> +struct virtio_video_param_resources {
> +        le32 num_resources;
> +        u8 mem_type; /* VIRTIO_VIDEO_MEM_TYPE_* */
> +        u8 padding[3];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{num_resources}]
> +  is the number of resources that can be addressed for the queue, number=
ed
> +  from \(0\) to \(num\_resources - 1\). Can be equal to zero if no
> +  resources are allocated, otherwise will be comprised between
> +  \field{min_resources} and \field{max_resources}.
> +\item[\field{mem_type}]
> +  is the memory type that will be used to back these resources.
> +\end{description}
> +
> +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}{Devi=
ce
> Types / Video Device / Device Operation / Device Operation: Stream comman=
ds
> / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}
> +
> +The device MUST initialize each parameter to a valid default value.
> +
> +The device MUST allow each parameter to be read even without the driver
> +explicitly setting a value for them beforehand.
> +
> +\field{stream_params_bitmask} MUST be a subset of
> \field{stream_params_bitmask}
> +field of \field{struct virtio_video_device_query_caps_resp}.
> +
> +The fields \field{coded_format}, \field{raw_format},
> \field{coded_resources},
> +\field{raw_resources}, \field{bitrate}, \field{codec} MUST be set
> according
> +to the capabilities returned by VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS, see
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.
> +The conformance check MUST be performed before the command response is
> sent.
> +
> +\field{stream_params_bitmask} MAY contain at most one of
> +VIRTIO_VIDEO_PARAM_GROUP_CODEC_* bits. This bit MUST correspond to the
> +coded format selected with \field{coded_format}.
> +
> +The device MAY adjust any requested parameter to a closest supported
> +value if the requested one is not supported with the current settings.
> +
> +There MAY be at most one out of band SET_PARAMS operations at the same
> time.
> +The amount of in band SET_PARAMS operations at the same time MUST NOT
> exceed
> +the number of input resources.
> +
> +The parameters MUST be applied in the same order as in
> +\ref{sec:Device Types / Video Device / Supported parameters / Supported
> stream parameters}.
> +
> +When \field{coded_format}, \field{coded_resources},
> +\field{raw_format} or \field{raw_resources} are being changed, the devic=
e
> +MUST first check if there are any queued resources in the corresponding
> +queue. If there are any the device MUST run a DRAIN operation in the sam=
e
> way
> +as with VIRTIO_VIDEO_CMD_STREAM_DRAIN except that sending
> +VIRTIO_VIDEO_DELAYED_RESP_STREAM_DRAIN MUST be omitted. Then the device
> MUST
> +cancel all remaining elements in the queue if there are any. Then the
> device
> +MUST detach all attached resources of the queue if there are any. Then t=
he
> +device MUST set the requested parameters and send the delayed response.
> Any
> +subsequent operations using the queue MUST be blocked until the first
> +resource is attached and queued again. All these steps MUST be performed
> +before processing any subsequent commands.
> +
> +The device MUST process parameters changes, that are embedded in the inp=
ut
> +stream, in the same way as if there is an in band
> +VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS command changing the OUTPUT queue
> +parameters. A standalone DPC event MUST be sent instead of the command's
> +delayed response in this case.
> +
> +The device MUST return all the available parameters in the delayed
> response
> +to the command. \field{codec} is not available until \field{coded_format=
}
> +is set.
> +
> +% TODO define when changing other parameters is allowed.
> +
> +\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}{Devi=
ce
> Types / Video Device / Device Operation / Device Operation: Stream comman=
ds
> / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}
> +
> +\field{stream_id} MUST be set to a valid stream ID previously returned
> +by VIRTIO_VIDEO_CMD_STREAM_CREATE.
> +
> +The driver MUST fill the fields according to the parameters selected wit=
h
> +\field{stream_params_bitmask}. All the other fields MUST be set to zero.
> +
> +The driver MUST check the actual values of the parameters as set by the
> +device and work with these values, or try to set a different one if it
> +cannot, or fail properly.
> +
> +After creating a new stream, the initial value of all parameters is
> +undefined to the driver. Thus, the driver MUST NOT assume the default
> +value of any parameter and MAY use VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS
> +in order to get the values of the parameters it needs.
> +
> +The driver SHOULD NOT send any in band SET_PARAMS commands or QUEUE
> commands
> +on the INPUT queue before receiving the delayed response, when changing
> the
> +\field{coded_format} or \field{coded_resources} for decoder or
> +\field{raw_format} or \field{raw_resources} for encoder.
> +
> +If some of the resources were detached as a result of this command the
> +driver SHOULD maybe reallocate and reattach the backing memories of thes=
e
> +resources and queue them again to resume the device operation.
> +
> +\paragraph{VIRTIO_VIDEO_CMD_STREAM_DRAIN}
> +\label{sec:Device Types / Video Device / Device Operation / Device
> Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DRAIN}
> +
> +Complete processing of all INPUT queue elements queued before this comma=
nd
> +and make the resulting output resources available to the driver.
> +
> +The driver sends this command with
> +\field{struct virtio_video_stream_drain}:
> +
> +\begin{lstlisting}
> +struct virtio_video_stream_drain {
> +        le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_DRAIN */
> +        le32 stream_id;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{stream_id}]
> +  is the ID of the stream to drain, as previously returned by
> +  VIRTIO_VIDEO_CMD_STREAM_CREATE.
> +\end{description}
> +
> +The device responds as described in
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Command Virtqueue}
> +and begins the background DRAIN operation.
> +
> +When the background DRAIN operation is completed the device sends the
> +VIRTIO_VIDEO_DELAYED_RESP_STREAM_DRAIN delayed response, see
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Event Virtqueue}.
> +
> +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_DRAIN}{Device
> Types / Video Device / Device Operation / Device Operation: Stream comman=
ds
> / VIRTIO_VIDEO_CMD_STREAM_DRAIN}
> +
> +Before the device sends the response, it MUST process and respond to all
> +the VIRTIO_VIDEO_CMD_RESOURCE_QUEUE commands on the INPUT queue that
> +were sent before the drain command, and make all the corresponding
> +output resources available to the driver by responding to their
> +VIRTIO_VIDEO_CMD_RESOURCE_QUEUE command.
> +
> +The device MUST be able to accept input work while a DRAIN operation
> +is ongoing, but any resulting delayed responses MUST NOT be sent before
> +the delayed response to the DRAIN command.
> +
> +The amount of DRAIN operations at the same time in the INPUT queue MUST
> NOT
> +exceed the number of input resources. The device MUST return
> +VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION if the number is exceeded.
> +
> +If the command is interrupted with a VIRTIO_VIDEO_CMD_STREAM_RESET
> +or VIRTIO_VIDEO_CMD_STREAM_DESTROY commands, the device MUST
> +send the delayed response with VIRTIO_VIDEO_EVENT_FLAG_CANCELED flag set=
.
> +
> +\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_DRAIN}{Device
> Types / Video Device / Device Operation / Device Operation: Stream comman=
ds
> / VIRTIO_VIDEO_CMD_STREAM_DRAIN}
> +
> +\field{stream_id} MUST be set to a valid stream ID previously returned
> +by VIRTIO_VIDEO_CMD_STREAM_CREATE.
> +
> +The driver MUST keep queueing output resources until it gets the
> +response to this command or cancels it using
> +VIRTIO_VIDEO_CMD_STREAM_RESET or
> +VIRTIO_VIDEO_CMD_STREAM_DESTROY. Failure to do so may result in the
> +device stalling as it waits for output resources to write into.
> +
> +The driver MUST account for the fact that the response to this command
> +might come out-of-order (i.e. after other commands sent to the device),
> +and that it can be interrupted.
> +
> +The driver MUST send a DRAIN command when it does not have any further
> +input, in order to ensure it receives all the output corresponding to
> +the stream.
> +
> +\paragraph{VIRTIO_VIDEO_CMD_STREAM_RESET}
> +\label{sec:Device Types / Video Device / Device Operation / Device
> Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_RESET}
> +
> +Immediately cancel all INPUT queue elements queued before this command
> +without processing them and discard any processing results in the output
> +resources, that are not yet dequeued. This command is mostly useful for
> +decoders that need to quickly jump from one point of the stream to anoth=
er
> +(i.e. seeking), or in order to stop processing as quickly as possible.
> +
> +The driver sends this command with
> +\field{struct virtio_video_stream_reset}:
> +
> +\begin{lstlisting}
> +struct virtio_video_stream_reset {
> +        le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_RESET */
> +        le32 stream_id;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{stream_id}]
> +  is the ID of the stream to reset, as previously returned by
> +  VIRTIO_VIDEO_CMD_STREAM_CREATE.
> +\end{description}
> +
> +The device responds as described in
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Command Virtqueue}
> +and begins the background RESET operation.
> +
> +When the background RESET operation is completed the device sends the
> +VIRTIO_VIDEO_DELAYED_RESP_STREAM_RESET delayed response, see
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Event Virtqueue}.
> +
> +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_RESET}{Device
> Types / Video Device / Device Operation / Device Operation: Stream comman=
ds
> / VIRTIO_VIDEO_CMD_STREAM_RESET}
> +
> +The device MUST send delayed responses with
> VIRTIO_VIDEO_EVENT_FLAG_CANCELED
> +flag set for a background DRAIN operation and
> VIRTIO_VIDEO_CMD_RESOURCE_QUEUE
> +commands on the INPUT queue before responding to this command.
> +
> +While the device is processing the command, it MUST return
> +VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION to any subsequent
> +VIRTIO_VIDEO_CMD_STREAM_RESET commands.
> +
> +The device MUST be able to accept input work while a RESET operation
> +is ongoing, but any resulting delayed responses MUST NOT be sent before
> +the delayed response to the RESET command.
> +
> +The device MUST interrupt operation as quickly as possible, and not be
> +dependent on output resources being queued by the driver.
> +
> +Upon resuming processing, the device MAY skip input data until it finds
> +a point that allows it to resume operation properly (e.g. until a
> +keyframe is found in the input stream of a decoder).
> +
> +\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_RESET}{Device
> Types / Video Device / Device Operation / Device Operation: Stream comman=
ds
> / VIRTIO_VIDEO_CMD_STREAM_RESET}
> +
> +\field{stream_id} MUST be set to a valid stream ID previously returned
> +by VIRTIO_VIDEO_CMD_STREAM_CREATE.
> +
> +Upon receiving the response to this command, the driver SHOULD process
> +(or drop) any output resource before resuming operation by queueing new
> +input resources.
> +
> +Upon receiving the response to this command, the driver MAY modify the
> +\field{struct virtio_video_param_resources} parameter corresponding to
> +the INPUT queue, and subsequently attach new backing memory to the input
> +resources using the VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING
> +command.
> +
> +\subsubsection{Device Operation: Resource Commands}
> +\label{sec:Device Types / Video Device / Device Operation / Device
> Operation: Resource Commands}
> +
> +Resource commands manage the memory backing of individual resources and
> +queue them for the device to process.
> +
> +\paragraph{VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}
> +\label{sec:Device Types / Video Device / Device Operation / Device
> Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}
> +
> +Attach backing memory to a resource.
> +
> +The driver sends this command with
> +\field{struct virtio_video_resource_attach_backing}:
> +
> +\begin{lstlisting}
> +#define VIRTIO_VIDEO_QUEUE_TYPE_INPUT       0
> +#define VIRTIO_VIDEO_QUEUE_TYPE_OUTPUT      1
> +
> +struct virtio_video_resource_attach_backing {
> +        le32 cmd_type; /* VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING */
> +        le32 stream_id;
> +        le32 queue_type; /* VIRTIO_VIDEO_QUEUE_TYPE_* */
> +        le32 resource_id;
> +        union virtio_video_resource resources[];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{stream_id}]
> +  is the ID of a valid stream.
> +\item[\field{queue_type}]
> +  is the direction of the queue.
> +\item[\field{resource_id}]
> +  is the ID of the resource to be attached to.
> +\item[\field{resources}]
> +  specifies memory regions to attach.
> +% TODO add number of resources?
> +\end{description}
> +
> +The union \field{virtio_video_resource} is defined as follows:
> +
> +\begin{lstlisting}
> +union virtio_video_resource {
> +        struct virtio_video_resource_sg_list sg_list;
> +        struct virtio_video_resource_object object;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{sg_list}]
> +  represents a scatter-gather list. This variant can be used when the
> +  \field{mem_type} member of the \field{virtio_video_param_resources}
> +  corresponding to the queue is set to
> +  VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES, see
> +  \ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.
> +\item[\field{object}]
> +  represents an object exported from another virtio device as defined in
> +  \ref{sec:Basic Facilities of a Virtio Device / Exporting Objects}.
> +  This variant can be used when the \field{mem_type} member of the
> +  \field{virtio_video_param_resources} corresponding to the queue is set
> +  to VIRTIO_VIDEO_MEM_TYPE_VIRTIO_OBJECT, see
> +  \ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.
> +\end{description}
> +
> +The struct \field{virtio_video_resource_sg_list} is defined as follows:
> +
> +\begin{lstlisting}
> +struct virtio_video_resource_sg_entry {
> +        le64 addr;
> +        le32 length;
> +        u8 padding[4];
> +};
> +
> +struct virtio_video_resource_sg_list {
> +        le32 num_entries;
> +        u8 padding[4];
> +        /* Followed by num_entries instances of
> +           virtio_video_resource_sg_entry */
> +};
> +\end{lstlisting}
> +
> +Within \field{struct virtio_video_resource_sg_entry}:
> +
> +\begin{description}
> +\item[\field{addr}]
> +  is a guest physical address to the start of the SG entry. Must be
> +  aligned to the size of physical guest pages.
> +\item[\field{length}]
> +  is the length of the SG entry in bytes. Must be aligned to the size
> +  of physical guest pages.
> +\end{description}
> +
> +Finally, for \field{struct virtio_video_resource_sg_list}:
> +
> +\begin{description}
> +\item[\field{num_entries}]
> +  is the number of \field{struct virtio_video_resource_sg_entry} instanc=
es
> +  that follow.
> +\end{description}
> +
> +\field{struct virtio_video_resource_object} is defined as follows:
> +
> +\begin{lstlisting}
> +struct virtio_video_resource_object {
> +        u8 uuid[16];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[uuid]
> +  is a version 4 UUID specified by \hyperref[intro:rfc4122]{[RFC4122]}.
> +\end{description}
> +
> +The device responds with
> +\field{struct virtio_video_resource_attach_backing_resp}:
> +
> +\begin{lstlisting}
> +struct virtio_video_resource_attach_backing_resp {
> +        le32 result; /* VIRTIO_VIDEO_RESULT_* */
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{result}]
> +  is
> +
> +  \begin{description}
> +  \item[VIRTIO_VIDEO_RESULT_OK]
> +    if the operation succeeded,
> +  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID]
> +    if the mentioned stream does not exist,
> +  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_RESOURCE_ID]
> +    if the mentioned resource does not exist,
> +  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_ARGUMENT]
> +    if \field{queue_type} or \field{resources} have an invalid value,
> +  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION]
> +    if the operation is performed at a time when it is not valid.
> +  \end{description}
> +\end{description}
> +
> +VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING can only be called during
> +the following times:
> +
> +\begin{itemize}
> +\item
> +  AFTER a VIRTIO_VIDEO_CMD_STREAM_CREATE and BEFORE invoking
> +  VIRTIO_VIDEO_CMD_RESOURCE_QUEUE for the first time on the
> +  resource,
> +\item
> +  AFTER successfully changing the \field{virtio_video_param_resources}
> +  parameter corresponding to the queue and BEFORE
> +  VIRTIO_VIDEO_CMD_RESOURCE_QUEUE is called again on the resource.
> +\end{itemize}
> +
> +This is to ensure that the device can rely on the fact that a given
> +resource will always point to the same memory for as long as it may be
> +used by the video device. For instance, a decoder may use returned
> +decoded frames as reference for future frames and won't overwrite the
> +backing resource of a frame that is being referenced. It is only before
> +a stream is started and after a Dynamic Parameters Change event has
> +occurred that we can be sure that all resources won't be used in that
> +way.
> +
> +% TODO add a requirement for the driver or the device to handle a case
> +% when a still referenced frame is queued again. So that it is less like=
ly
> +% to be forgotten.
> +
> +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING=
}{Device
> Types / Video Device / Device Operation / Device Operation: Resource
> Commands / VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}
> +
> +At any time other than the times valid for calling this command, the
> +device MUST return VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION.
> +
> +\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING=
}{Device
> Types / Video Device / Device Operation / Device Operation: Resource
> Commands / VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}
> +
> +\field{stream_id} MUST be set to a valid stream ID previously returned
> +by VIRTIO_VIDEO_CMD_STREAM_CREATE.
> +
> +\field{queue_type} MUST be set to a valid queue type.
> +
> +\field{resource_id} MUST be an integer inferior to the number of
> +resources currently allocated for the queue.
> +
> +The length of the \field{resources} array of
> +\field{struct virtio_video_resource_attach_backing} MUST be equal to the
> +number of resources required by the format currently set on the queue,
> +as described in
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.
> +
> +\paragraph{VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}
> +\label{sec:Device Types / Video Device / Device Operation / Device
> Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}
> +
> +Add a resource to the device's queue.
> +
> +\begin{lstlisting}
> +#define VIRTIO_VIDEO_MAX_PLANES                    8
> +
> +#define VIRTIO_VIDEO_ENQUEUE_FLAG_FORCE_KEY_FRAME  (1 << 0)
> +
> +struct virtio_video_resource_queue {
> +        le32 cmd_type; /* VIRTIO_VIDEO_CMD_RESOURCE_QUEUE */
> +        le32 stream_id;
> +        le32 queue_type; /* VIRTIO_VIDEO_QUEUE_TYPE_* */
> +        le32 resource_id;
> +        le32 flags; /* Bitmask of VIRTIO_VIDEO_ENQUEUE_FLAG_* */
> +        u8 padding[4];
> +        le64 timestamp;
> +        le32 offsets[VIRTIO_VIDEO_MAX_PLANES];
> +        le32 data_sizes[VIRTIO_VIDEO_MAX_PLANES];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{stream_id}]
> +  is the ID of a valid stream.
> +\item[\field{queue_type}]
> +  is the direction of the queue.
> +\item[\field{resource_id}]
> +  is the ID of the resource to be queued.
> +\item[\field{flags}]
> +  is a bitmask of VIRTIO_VIDEO_ENQUEUE_FLAG_* values.
> +
> +  \begin{description}
> +  \item[\field{VIRTIO_VIDEO_ENQUEUE_FLAG_FORCE_KEY_FRAME}]
> +    The submitted frame is to be encoded as a key frame. Only valid for
> the
> +    encoder's INPUT queue.
> +  \end{description}
> +\item[\field{timestamp}]
> +  is an abstract sequence counter that can be used on the INPUT queue fo=
r
> +  synchronization. Resources produced on the output queue will carry the
> +  \field{timestamp} of the first input resource they have been produced
> +  from.
> +% TODO take note about timestamps from V4L2 spec
> +\item[\field{offsets}]
> +  is the starting offset for the data in the buffer for each plane.
> +  The number of planes depends on the format. Set by the driver for inpu=
t
> +  resources.
> +\item[\field{data_sizes}]
> +  is number of data bytes used for each plane. Set by the driver for inp=
ut
> +  resources.
> +\end{description}
> +
> +The device responds as described in
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Command Virtqueue}
> +and puts the resource in the selected queue for background processing.
> +
> +When the background processing of the resource is completed the device
> sends
> +the VIRTIO_VIDEO_DELAYED_RESP_RESOURCE_QUEUE delayed response, see
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Event Virtqueue}.
> +
> +The command-specific delayed response
> +\field{struct virtio_video_resource_queue_delayed_resp} is defined
> +as follows:
> +
> +\begin{lstlisting}
> +#define VIRTIO_VIDEO_DEQUEUE_FLAG_ERR           (1 << 0)
> +/* Encoder only */
> +#define VIRTIO_VIDEO_DEQUEUE_FLAG_KEY_FRAME     (1 << 1)
> +#define VIRTIO_VIDEO_DEQUEUE_FLAG_P_FRAME       (1 << 2)
> +#define VIRTIO_VIDEO_DEQUEUE_FLAG_B_FRAME       (1 << 3)
> +
> +struct virtio_video_resource_queue_delayed_resp {
> +        le32 queue_type; /* VIRTIO_VIDEO_QUEUE_TYPE_* */
> +        le32 resource_id;
> +        le32 flags;
> +        u8 padding[4];
> +        le64 timestamp;
> +        le32 offsets[VIRTIO_VIDEO_MAX_PLANES];
> +        le32 data_sizes[VIRTIO_VIDEO_MAX_PLANES];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{queue_type}]
> +  is the direction of the queue.
> +\item[\field{resource_id}]
> +  is the ID of the dequeued resource.
> +\item[\field{flags}]
> +  is a bitmask of VIRTIO_VIDEO_DEQUEUE_FLAG_* flags.
> +
> +  \begin{description}
> +  \item[VIRTIO_VIDEO_DEQUEUE_FLAG_ERR]
> +    is set on resources when a non-fatal processing error has happened a=
nd
> +    the data contained by the resource is likely to be corrupted,
> +  \item[VIRTIO_VIDEO_DEQUEUE_FLAG_KEY_FRAME]
> +    is set on output resources when the resource contains an encoded key
> +    frame (only for encoders).
> +  \item[VIRTIO_VIDEO_DEQUEUE_FLAG_P_FRAME]
> +    is set on output resources when the resource contains only differenc=
es
> +    to a previous key frame (only for encoders).
> +  \item[VIRTIO_VIDEO_DEQUEUE_FLAG_B_FRAME]
> +    is set on output resources when the resource contains only the
> +    differences between the current frame and both the preceding and
> +    following key frames (only for encoders).
> +  \end{description}
> +\item[\field{timestamp}]
> +  is set on output resources to the \field{timestamp} value of the input
> +  resource that produced the resource.
> +\item[\field{offsets}]
> +  is set on output resources to the starting offset for the data in the
> +  buffer for each plane.
> +\item[\field{data_sizes}]
> +  is set on output resources to the amount of data written by the device=
,
> +  for each plane.
> +\end{description}
> +
> +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}{Device
> Types / Video Device / Device Operation / Device Operation: Resource
> Commands / VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}
> +
> +The device MUST return VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION if
> +VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING has not been
> +successfully called on the resource prior to queueing it or for an
> +attempt to queue a resources that is still processed in background.
> +
> +The device MUST mark resources that might contain corrupted content due =
to
> +an error with the VIRTIO_VIDEO_BUFFER_FLAG_ERR flag.
> +
> +For output resources, the device MUST copy the \field{timestamp}
> +parameter of the input resource that produced it into its response.
> +% TODO rephrase?
> +
> +In case of encoder, the device MUST mark each output resource with one
> +of VIRTIO_VIDEO_DEQUEUE_FLAG_KEY_FRAME,
> +VIRTIO_VIDEO_DEQUEUE_FLAG_P_FRAME, or
> +VIRTIO_VIDEO_DEQUEUE_FLAG_B_FRAME.
> +
> +If the processing of a resource was stopped due to a stream event, a
> +VIRTIO_VIDEO_CMD_STREAM_RESET, or a VIRTIO_VIDEO_CMD_STREAM_DESTROY,
> +the device MUST send the corresponding delayed responses with
> +VIRTIO_VIDEO_EVENT_FLAG_CANCELED flag set.
> +
> +\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}{Device
> Types / Video Device / Device Operation / Device Operation: Resource
> Commands / VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}
> +
> +\field{stream_id} MUST be set to a valid stream ID previously returned
> +by VIRTIO_VIDEO_CMD_STREAM_CREATE.
> +
> +\field{queue_type} MUST be set to a valid queue type.
> +
> +\field{resource_id} MUST be an integer inferior to the number of
> +resources currently allocated for the queue.
> +
> +The driver MUST account for the fact that the response to this command
> +might come out-of-order (i.e. after other commands sent to the device),
> +and that it can be interrupted.
> +
> +% TODO acourbot: The driver and device MUST follow requirements about
> +% buffer ownership explained in
> +% \ref{sec:Device Types / Video Device / Device Operation / Buffer
> lifecycle}.
> +
> +\subsubsection{Device Operation: Standalone Events}
> +\label{sec:Device Types / Video Device / Device Operation / Device
> Operation: Standalone Events}
> +
> +These events are caused by state changes in the device, not as a delayed
> +response to any command.
> +
> +\paragraph{Error Event}
> +\label{sec:Device Types / Video Device / Device Operation / Device
> Operation: Standalone Events / Error Event}
> +
> +The error event is sent by the device when an unrecoverable error occurs
> +during processing a stream. The device operation is exactly the same as
> when
> +it receives a VIRTIO_VIDEO_CMD_STREAM_DESTROY command, see
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DESTROY}.
> +Note that this is different from dequeued resources carrying the
> +VIRTIO_VIDEO_DEQUEUE_FLAG_ERR flag. This flag indicates that the
> +particular output frame might be corrupted, but the stream still exists
> +and can recover.
> +
> +\paragraph{Dynamic Parameters Change Event}
> +\label{sec:Device Types / Video Device / Device Operation / Device
> Operation: Standalone Events / Dynamic Parameters Change Event}
> +
> +A Dynamic Parameters Change (or DPC) event is sent by a decoder device
> when it
> +detects that the parameters of the stream being decoded have changed.
> +The device operation is exactly the same as when it receives an in band
> +VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS command at the exact same point in th=
e
> +stream, that changes OUTPUT queue parameters, see
> +\ref{sec:Device Types / Video Device / Device Operation / Device
> Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.
> +
> +% TODO add QoS events and overall think about quotas. Codecs are normall=
y
> +% limited by bandwidth. How can we accommodate this?
> +
> +\subsection{Codec-specific parameters}
> +\label{sec:Device Types / Video Device / Codec-specific parameters}
> +
> +The codec-specific controls follow V4L2 controls definitions, that can b=
e
> +found in \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +Human-readable descriptions for the codec-specific V4L2 controls can be
> found
> +in \hyperref[intro:V4L2 codec controls]{V4L2 documentation}.
> +
> +\subsubsection{MPEG2}
> +
> +MPEG2 capabilities are defined as follows:
> +
> +\begin{lstlisting}
> +#define VIRTIO_VIDEO_MPEG2_PARAM_PROFILE  1  /* Same as
> V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE */
> +#define VIRTIO_VIDEO_MPEG2_PARAM_LEVEL    2  /* Same as
> V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL */
> +
> +struct virtio_video_mpeg2_caps {
> +        le32 mpeg2_params_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_MPEG2_PARAM_*) */
> +        le32 mpeg2_profiles_bitmask; /* Bitmask of
> MASK(V4L2_MPEG_VIDEO_MPEG2_PROFILE_*) */
> +        le32 mpeg2_levels_bitmask; /* Bitmask of
> MASK(V4L2_MPEG_VIDEO_MPEG2_LEVEL_*) */
> +        u8 padding[4];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{mpeg2_params_bitmask}]
> +  is a bitmask of supported MPEG2 codec parameters.
> +\item[\field{mpeg2_profiles_bitmask}]
> +  is a bitmask of supported MPEG2 profiles used as bit numbers, see
> +  \field{enum v4l2_mpeg_video_mpeg2_profile} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\item[\field{mpeg2_levels_bitmask}]
> +  is a bitmask of supported MPEG2 levels used as bit numbers, see
> +  \field{enum v4l2_mpeg_video_mpeg2_level} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\end{description}
> +
> +MPEG2 parameters are defined as follows:
> +
> +\begin{lstlisting}
> +struct virtio_video_mpeg2_params {
> +        le32 mpeg2_params_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_MPEG2_PARAM_*) */
> +        le32 mpeg2_profile; /* V4L2_MPEG_VIDEO_MPEG2_PROFILE_* */
> +        le32 mpeg2_level; /* V4L2_MPEG_VIDEO_MPEG2_LEVEL_* */
> +        u8 padding[4];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{mpeg2_params_bitmask}]
> +  is a bitmask of supported MPEG2 codec parameters.
> +\item[\field{mpeg2_profile}]
> +  is one of the supported MPEG2 profiles, see
> +  \field{enum v4l2_mpeg_video_mpeg2_profile} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\item[\field{mpeg2_level}]
> +  is one of the supported MPEG2 levels, see
> +  \field{enum v4l2_mpeg_video_mpeg2_level} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\end{description}
> +
> +\subsubsection{MPEG4}
> +
> +MPEG4 capabilities are defined as follows:
> +
> +\begin{lstlisting}
> +#define VIRTIO_VIDEO_MPEG4_PARAM_PROFILE  1  /* Same as
> V4L2_CID_MPEG_VIDEO_MPEG4_PROFILE */
> +#define VIRTIO_VIDEO_MPEG4_PARAM_LEVEL    2  /* Same as
> V4L2_CID_MPEG_VIDEO_MPEG4_LEVEL */
> +
> +struct virtio_video_mpeg4_caps {
> +        le32 mpeg4_params_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_MPEG4_PARAM_*) */
> +        le32 mpeg4_profiles_bitmask; /* Bitmask of
> MASK(V4L2_MPEG_VIDEO_MPEG4_PROFILE_*) */
> +        le32 mpeg4_levels_bitmask; /* Bitmask of
> MASK(V4L2_MPEG_VIDEO_MPEG4_LEVEL_*) */
> +        u8 padding[4];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{mpeg4_params_bitmask}]
> +  is a bitmask of supported MPEG4 codec parameters.
> +\item[\field{mpeg4_profiles_bitmask}]
> +  is a bitmask of supported MPEG4 profiles used as bit numbers, see
> +  \field{enum v4l2_mpeg_video_mpeg4_profile} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\item[\field{mpeg4_levels_bitmask}]
> +  is a bitmask of supported MPEG4 levels used as bit numbers, see
> +  \field{enum v4l2_mpeg_video_mpeg4_level} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\end{description}
> +
> +MPEG4 parameters are defined as follows:
> +
> +\begin{lstlisting}
> +struct virtio_video_mpeg4_params {
> +        le32 mpeg4_params_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_MPEG4_PARAM_*) */
> +        le32 mpeg4_profile; /* V4L2_MPEG_VIDEO_MPEG4_PROFILE_* */
> +        le32 mpeg4_level; /* V4L2_MPEG_VIDEO_MPEG4_LEVEL_* */
> +        u8 padding[4];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{mpeg4_params_bitmask}]
> +  is a bitmask of supported MPEG4 codec parameters.
> +\item[\field{mpeg4_profile}]
> +  is one of the supported MPEG4 profiles, see
> +  \field{enum v4l2_mpeg_video_mpeg4_profile} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\item[\field{mpeg4_level}]
> +  is one of the supported MPEG4 levels, see
> +  \field{enum v4l2_mpeg_video_mpeg4_level} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\end{description}
> +
> +\subsubsection{H.264}
> +
> +H.264 capabilities are defined as follows:
> +
> +\begin{lstlisting}
> +#define VIRTIO_VIDEO_H264_PARAM_PROFILE  1  /* Same as
> V4L2_CID_MPEG_VIDEO_H264_PROFILE */
> +#define VIRTIO_VIDEO_H264_PARAM_LEVEL    2  /* Same as
> V4L2_CID_MPEG_VIDEO_H264_LEVEL */
> +
> +struct virtio_video_h264_caps {
> +        le32 h264_params_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_H264_PARAM_*) */
> +        le32 h264_profiles_bitmask; /* Bitmask of
> MASK(V4L2_MPEG_VIDEO_H264_PROFILE_*) */
> +        le32 h264_levels_bitmask; /* Bitmask of
> MASK(V4L2_MPEG_VIDEO_H264_LEVEL_*) */
> +        u8 padding[4];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{h264_params_bitmask}]
> +  is a bitmask of supported H.264 codec parameters.
> +\item[\field{h264_profiles_bitmask}]
> +  is a bitmask of supported H.264 profiles used as bit numbers, see
> +  \field{enum v4l2_mpeg_video_h264_profile} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\item[\field{h264_levels_bitmask}]
> +  is a bitmask of supported H.264 levels used as bit numbers, see
> +  \field{enum v4l2_mpeg_video_h264_level} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\end{description}
> +
> +H.264 parameters are defined as follows:
> +
> +\begin{lstlisting}
> +struct virtio_video_h264_params {
> +        le32 h264_params_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_H264_PARAM_*) */
> +        le32 h264_profile; /* V4L2_MPEG_VIDEO_H264_PROFILE_* */
> +        le32 h264_level; /* V4L2_MPEG_VIDEO_H264_LEVEL_* */
> +        u8 padding[4];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{h264_params_bitmask}]
> +  is a bitmask of supported H.264 codec parameters.
> +\item[\field{h264_profile}]
> +  is one of the supported H.264 profiles, see
> +  \field{enum v4l2_mpeg_video_h264_profile} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\item[\field{h264_level}]
> +  is one of the supported H.264 levels, see
> +  \field{enum v4l2_mpeg_video_h264_level} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\end{description}
> +
> +\subsubsection{HEVC}
> +
> +HEVC capabilities are defined as follows:
> +
> +\begin{lstlisting}
> +#define VIRTIO_VIDEO_HEVC_PARAM_PROFILE  1  /* Same as
> V4L2_CID_MPEG_VIDEO_HEVC_PROFILE */
> +#define VIRTIO_VIDEO_HEVC_PARAM_LEVEL    2  /* Same as
> V4L2_CID_MPEG_VIDEO_HEVC_LEVEL */
> +
> +struct virtio_video_hevc_caps {
> +        le32 hevc_params_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_HEVC_PARAM_*) */
> +        le32 hevc_profiles_bitmask; /* Bitmask of
> MASK(V4L2_MPEG_VIDEO_HEVC_PROFILE_*) */
> +        le32 hevc_levels_bitmask; /* Bitmask of
> MASK(V4L2_MPEG_VIDEO_HEVC_LEVEL_*) */
> +        u8 padding[4];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{hevc_params_bitmask}]
> +  is a bitmask of supported HEVC codec parameters.
> +\item[\field{hevc_profiles_bitmask}]
> +  is a bitmask of supported HEVC profiles used as bit numbers, see
> +  \field{enum v4l2_mpeg_video_hevc_profile} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\item[\field{hevc_levels_bitmask}]
> +  is a bitmask of supported HEVC levels used as bit numbers, see
> +  \field{enum v4l2_mpeg_video_hevc_level} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\end{description}
> +
> +HEVC parameters are defined as follows:
> +
> +\begin{lstlisting}
> +struct virtio_video_hevc_params {
> +        le32 hevc_params_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_HEVC_PARAM_*) */
> +        le32 hevc_profile; /* V4L2_MPEG_VIDEO_HEVC_PROFILE_* */
> +        le32 hevc_level; /* V4L2_MPEG_VIDEO_HEVC_LEVEL_* */
> +        u8 padding[4];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{hevc_params_bitmask}]
> +  is a bitmask of supported HEVC codec parameters.
> +\item[\field{hevc_profile}]
> +  is one of the supported HEVC profiles, see
> +  \field{enum v4l2_mpeg_video_hevc_profile} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\item[\field{hevc_level}]
> +  is one of the supported HEVC levels, see
> +  \field{enum v4l2_mpeg_video_hevc_level} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\end{description}
> +
> +\subsubsection{VP8}
> +
> +VP8 capabilities are defined as follows:
> +
> +\begin{lstlisting}
> +#define VIRTIO_VIDEO_VP8_PARAM_PROFILE  1  /* Same as
> V4L2_CID_MPEG_VIDEO_VP8_PROFILE */
> +
> +struct virtio_video_vp8_caps {
> +        le32 vp8_params_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_VP8_PARAM_*) */
> +        le32 vp8_profiles_bitmask; /* Bitmask of
> MASK(V4L2_MPEG_VIDEO_VP8_PROFILE_*) */
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{vp8_params_bitmask}]
> +  is a bitmask of supported VP8 codec parameters.
> +\item[\field{vp8_profiles_bitmask}]
> +  is a bitmask of supported VP8 profiles used as bit numbers, see
> +  \field{enum v4l2_mpeg_video_vp8_profile} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\end{description}
> +
> +VP8 parameters are defined as follows:
> +
> +\begin{lstlisting}
> +struct virtio_video_vp8_params {
> +        le32 vp8_params_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_VP8_PARAM_*) */
> +        le32 vp8_profile; /* V4L2_MPEG_VIDEO_VP8_PROFILE_* */
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{vp8_params_bitmask}]
> +  is a bitmask of supported VP8 codec parameters.
> +\item[\field{vp8_profile}]
> +  is one of the supported VP8 profiles, see
> +  \field{enum v4l2_mpeg_video_vp8_profile} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\end{description}
> +
> +\subsubsection{VP9}
> +
> +VP9 capabilities are defined as follows:
> +
> +\begin{lstlisting}
> +#define VIRTIO_VIDEO_VP9_PARAM_PROFILE  1  /* Same as
> V4L2_CID_MPEG_VIDEO_VP9_PROFILE */
> +#define VIRTIO_VIDEO_VP9_PARAM_LEVEL    2  /* Same as
> V4L2_CID_MPEG_VIDEO_VP9_LEVEL */
> +
> +struct virtio_video_vp9_caps {
> +        le32 vp9_params_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_VP9_PARAM_*) */
> +        le32 vp9_profiles_bitmask; /* Bitmask of
> MASK(V4L2_MPEG_VIDEO_VP9_PROFILE_*) */
> +        le32 vp9_levels_bitmask; /* Bitmask of
> MASK(V4L2_MPEG_VIDEO_VP9_LEVEL_*) */
> +        u8 padding[4];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{vp9_params_bitmask}]
> +  is a bitmask of supported VP9 codec parameters.
> +\item[\field{vp9_profiles_bitmask}]
> +  is a bitmask of supported VP9 profiles used as bit numbers, see
> +  \field{enum v4l2_mpeg_video_vp9_profile} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\item[\field{vp9_levels_bitmask}]
> +  is a bitmask of supported VP9 levels used as bit numbers, see
> +  \field{enum v4l2_mpeg_video_vp9_level} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\end{description}
> +
> +VP9 parameters are defined as follows:
> +
> +\begin{lstlisting}
> +struct virtio_video_vp9_params {
> +        le32 vp9_params_bitmask; /* Bitmask of
> MASK(VIRTIO_VIDEO_VP9_PARAM_*) */
> +        le32 vp9_profile; /* V4L2_MPEG_VIDEO_VP9_PROFILE_* */
> +        le32 vp9_level; /* V4L2_MPEG_VIDEO_VP9_LEVEL_* */
> +        u8 padding[4];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{vp9_params_bitmask}]
> +  is a bitmask of supported VP9 codec parameters.
> +\item[\field{vp9_profile}]
> +  is one of the supported VP9 profiles, see
> +  \field{enum v4l2_mpeg_video_vp9_profile} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\item[\field{vp9_level}]
> +  is one of the supported VP9 levels, see
> +  \field{enum v4l2_mpeg_video_vp9_level} in
> +  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
> +\end{description}
> diff --git a/device-types/video/device-conformance.tex
> b/device-types/video/device-conformance.tex
> new file mode 100644
> index 0000000..8aaf744
> --- /dev/null
> +++ b/device-types/video/device-conformance.tex
> @@ -0,0 +1,22 @@
> +\conformance{\subsection}{Video Device Conformance}
> +\label{sec:Conformance / Device Conformance / Video Device Conformance}
> +
> +A video device MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / Video Device / Feature bits}
> +\item \ref{devicenormative:Device Types / Video Device / Device
> configuration layout}
> +\item \ref{devicenormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Command Virtqueue}
> +\item \ref{devicenormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}
> +\item \ref{devicenormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS =
/
> VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Format dependencies}
> +\item \ref{devicenormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS =
/
> VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format capabilities}
> +\item \ref{devicenormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS =
/
> VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Resource capabilities}
> +\item \ref{devicenormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS =
/
> VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Bitrates}
> +\item \ref{devicenormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_CREATE}
> +\item \ref{devicenormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DESTROY}
> +\item \ref{devicenormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}
> +\item \ref{devicenormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DRAIN}
> +\item \ref{devicenormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_RESET}
> +\item \ref{devicenormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Resource Commands /
> VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}
> +\item \ref{devicenormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}
> +\end{itemize}
> diff --git a/device-types/video/driver-conformance.tex
> b/device-types/video/driver-conformance.tex
> new file mode 100644
> index 0000000..1fe8473
> --- /dev/null
> +++ b/device-types/video/driver-conformance.tex
> @@ -0,0 +1,16 @@
> +\conformance{\subsection}{Video Driver Conformance}
> +\label{sec:Conformance / Driver Conformance / Video Driver Conformance}
> +
> +A video driver MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{drivernormative:Device Types / Video Device / Feature bits}
> +\item \ref{drivernormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Command Virtqueue}
> +\item \ref{drivernormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Event Virtqueue}
> +\item \ref{drivernormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DESTROY}
> +\item \ref{drivernormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}
> +\item \ref{drivernormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DRAIN}
> +\item \ref{drivernormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_RESET}
> +\item \ref{drivernormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Resource Commands /
> VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}
> +\item \ref{drivernormative:Device Types / Video Device / Device Operatio=
n
> / Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}
> +\end{itemize}
> diff --git a/introduction.tex b/introduction.tex
> index b7155bf..b378883 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -101,6 +101,15 @@ \section{Normative References}\label{sec:Normative
> References}
>         \phantomsection\label{intro:SEC1}\textbf{[SEC1]} &
>      Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic
> Cureve Cryptography'', Version 1.0, September 2000.
>         \newline\url{https://www.secg.org/sec1-v2.pdf}\\
> +       \phantomsection\label{intro:V4L2}\textbf{[V4L2]} &
> +       Linux V4L2 interface.
> +       \newline\url{
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/uapi/linux/videodev2.h
> }\\
> +       \phantomsection\label{intro:V4L2 controls}\textbf{[V4L2 Controls]=
}
> &
> +       Linux V4L2 controls definitions.
> +       \newline\url{
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/uapi/linux/v4l2-controls.h
> }\\
> +       \phantomsection\label{intro:DRM formats}\textbf{[DRM Formats]} &
> +       Linux DRM format definitions.
> +       \newline\url{
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/uapi/drm/drm_fourcc.h
> }\\
>
>  \end{longtable}
>
> @@ -110,6 +119,18 @@ \section{Non-Normative References}
>         \phantomsection\label{intro:Virtio PCI Draft}\textbf{[Virtio PCI
> Draft]} &
>         Virtio PCI Draft Specification
>         \newline\url{http://ozlabs.org/~rusty/virtio-spec/virtio-0.9.5.pd=
f
> }\\
> +       \phantomsection\label{intro:V4L2 compressed}\textbf{[V4L2
> compressed formats]} &
> +       Detailed descriptions of V4L2 compressed formats
> +       \newline\url{
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/userspace-api/media/v4l/pixfmt-compressed.rst
> }\\
> +       \phantomsection\label{intro:V4L2 RGB}\textbf{[V4L2 RGB formats]} =
&
> +       Detailed descriptions of V4L2 RGB formats
> +       \newline\url{
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/userspace-api/media/v4l/pixfmt-rgb.rst
> }\\
> +       \phantomsection\label{intro:V4L2 YUV}\textbf{[V4L2 planar YUV
> formats]} &
> +       Detailed descriptions of V4L2 planar YUV formats
> +       \newline\url{
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> }\\
> +       \phantomsection\label{intro:V4L2 codec controls}\textbf{[V4L2
> codec controls]} &
> +       Detailed descriptions of V4L2 controls
> +       \newline\url{
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> }\\
>  \end{longtable}
>
>  \section{Terminology}\label{Terminology}
> --
> 2.34.1
>

BR,
Albert

--0000000000009988fb05ffd2c581
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Alexander,<div><br></div><div>Thanks f=
or the patch! It is a long document, so I skimmed a bit in the first=C2=A0r=
ead. Find some comments/questions inlined.</div><div>I will give it a secon=
d deeper read soon, but overall I think is in quite good shape. It feels re=
ally matured.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Thu, Jun 29, 2023 at 4:49=E2=80=AFPM Alexander Gordee=
v &lt;<a href=3D"mailto:Alexander.Gordeev@opensynergy.com" target=3D"_blank=
">Alexander.Gordeev@opensynergy.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Add the specification of the video decod=
er and encoder devices, which<br>
can be used to provide host-accelerated video operations to the guest.<br>
<br>
Signed-off-by: Alexander Gordeev &lt;<a href=3D"mailto:Alexander.Gordeev@op=
ensynergy.com" target=3D"_blank">Alexander.Gordeev@opensynergy.com</a>&gt;<=
br>
Co-authored-by: Keiichi Watanabe &lt;<a href=3D"mailto:keiichiw@chromium.or=
g" target=3D"_blank">keiichiw@chromium.org</a>&gt;<br>
Co-authored-by: Alexandre Courbot &lt;<a href=3D"mailto:acourbot@chromium.o=
rg" target=3D"_blank">acourbot@chromium.org</a>&gt;<br>
---<br>
=C2=A0conformance.tex=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 4 +<br>
=C2=A0content.tex=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1 +<b=
r>
=C2=A0device-types/video/description.tex=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2040 =
+++++++++++++++++++++<br>
=C2=A0device-types/video/device-conformance.tex |=C2=A0 =C2=A022 +<br>
=C2=A0device-types/video/driver-conformance.tex |=C2=A0 =C2=A016 +<br>
=C2=A0introduction.tex=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A021 +<br>
=C2=A06 files changed, 2104 insertions(+)<br>
=C2=A0create mode 100644 device-types/video/description.tex<br>
=C2=A0create mode 100644 device-types/video/device-conformance.tex<br>
=C2=A0create mode 100644 device-types/video/driver-conformance.tex<br>
<br>
diff --git a/conformance.tex b/conformance.tex<br>
index 01ccd69..d719eda 100644<br>
--- a/conformance.tex<br>
+++ b/conformance.tex<br>
@@ -34,6 +34,7 @@ \section{Conformance Targets}\label{sec:Conformance / Con=
formance Targets}<br>
=C2=A0\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},=
<br>
=C2=A0\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance} =
or<br>
=C2=A0\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.=
<br>
+\ref{sec:Conformance / Driver Conformance / Video Driver Conformance},<br>
<br>
=C2=A0 =C2=A0 =C2=A0\item Clause \ref{sec:Conformance / Legacy Interface: T=
ransitional Device and Transitional Driver Conformance}.<br>
=C2=A0 =C2=A0\end{itemize}<br>
@@ -61,6 +62,7 @@ \section{Conformance Targets}\label{sec:Conformance / Con=
formance Targets}<br>
=C2=A0\ref{sec:Conformance / Device Conformance / SCMI Device Conformance},=
<br>
=C2=A0\ref{sec:Conformance / Device Conformance / GPIO Device Conformance} =
or<br>
=C2=A0\ref{sec:Conformance / Device Conformance / PMEM Device Conformance}.=
<br>
+\ref{sec:Conformance / Device Conformance / Video Device Conformance},<br>
<br>
=C2=A0 =C2=A0 =C2=A0\item Clause \ref{sec:Conformance / Legacy Interface: T=
ransitional Device and Transitional Driver Conformance}.<br>
=C2=A0 =C2=A0\end{itemize}<br>
@@ -152,6 +154,7 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}<br>
=C2=A0\input{device-types/scmi/driver-conformance.tex}<br>
=C2=A0\input{device-types/gpio/driver-conformance.tex}<br>
=C2=A0\input{device-types/pmem/driver-conformance.tex}<br>
+\input{device-types/video/driver-conformance.tex}<br>
<br>
=C2=A0\conformance{\section}{Device Conformance}\label{sec:Conformance / De=
vice Conformance}<br>
<br>
@@ -238,6 +241,7 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}<br>
=C2=A0\input{device-types/scmi/device-conformance.tex}<br>
=C2=A0\input{device-types/gpio/device-conformance.tex}<br>
=C2=A0\input{device-types/pmem/device-conformance.tex}<br>
+\input{device-types/video/device-conformance.tex}<br>
<br>
=C2=A0\conformance{\section}{Legacy Interface: Transitional Device and Tran=
sitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Tran=
sitional Device and Transitional Driver Conformance}<br>
=C2=A0A conformant implementation MUST be either transitional or<br>
diff --git a/content.tex b/content.tex<br>
index d2ab9eb..90708d7 100644<br>
--- a/content.tex<br>
+++ b/content.tex<br>
@@ -765,6 +765,7 @@ \chapter{Device Types}\label{sec:Device Types}<br>
=C2=A0\input{device-types/scmi/description.tex}<br>
=C2=A0\input{device-types/gpio/description.tex}<br>
=C2=A0\input{device-types/pmem/description.tex}<br>
+\input{device-types/video/description.tex}<br>
<br>
=C2=A0\chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}<br>
<br>
diff --git a/device-types/video/description.tex b/device-types/video/descri=
ption.tex<br>
new file mode 100644<br>
index 0000000..760df7f<br>
--- /dev/null<br>
+++ b/device-types/video/description.tex<br>
@@ -0,0 +1,2040 @@<br>
+\section{Video Device}<br>
+\label{sec:Device Types / Video Device}<br>
+<br>
+The virtio video encoder and decoder devices provide support for<br>
+host-accelerated video encoding and decoding. Despite being different<br>
+device types, they use the same protocol and general flow.<br>
+<br>
+\subsection{Device ID}<br>
+\label{sec:Device Types / Video Device / Device ID}<br>
+<br>
+\begin{description}<br>
+\item[30]<br>
+=C2=A0 encoder device<br>
+\item[31]<br>
+=C2=A0 decoder device<br>
+\end{description}<br>
+<br>
+\subsection{Virtqueues}<br>
+\label{sec:Device Types / Video Device / Virtqueues}<br>
+<br>
+\begin{description}<br>
+\item[0]<br>
+=C2=A0 commandq - queue for driver commands and device responses to these =
commands<br>
+\item[1]<br>
+=C2=A0 eventq - queue for device delayed responses to commands and standal=
one<br>
+=C2=A0 device events<br>
+\end{description}<br>
+<br>
+\subsection{Feature bits}<br>
+\label{sec:Device Types / Video Device / Feature bits}<br>
+<br>
+\begin{description}<br>
+\item[VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES (0)]<br>
+=C2=A0 Guest pages can be used as the backing memory of resources.<br>
+\item[VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG (1)]<br>
+=C2=A0 The device can use non-contiguous guest memory as the backing memor=
y of<br>
+=C2=A0 resources. Only meaningful if VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES i=
s also<br>
+=C2=A0 set.<br>
+\item[VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT (2)]<br>
+=C2=A0 Objects exported by another virtio device can be used as the backin=
g memory<br>
+=C2=A0 of resources.<br>
+\item[VIRTIO_VIDEO_F_RESOURCE_DYNAMIC (3)]<br>
+=C2=A0 The device supports re-attaching memory to resources while streamin=
g.<br>
+% TODO this flag is not used anywhere at the moment.<br>
+% Might be necessary with Android.<br>
+\end{description}<br></blockquote><div><br></div><div>Maybe I am missing p=
art of the previous dicussion, but is=C2=A0this VIRTIO_VIDEO_F_RESOURCE_DYN=
AMIC flag new?</div><div>Not sure what re-attaching memory means and what t=
he flag is supossed=C2=A0to do.</div><div>In the comment you mention specif=
ically Android, so it got me curious. What is the usecase=C2=A0for this fea=
ture flag?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
+<br>
+\devicenormative{\subsubsection}{Feature bits}{Device Types / Video Device=
 / Feature bits}<br>
+<br>
+The device MUST set at least one of VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES or=
<br>
+VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT, since the absence of both bits woul=
d<br>
+mean that no memory can be used at all for resources.<br>
+<br>
+The device MUST NOT set VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG unless it also =
sets<br>
+VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES.<br>
+<br>
+\drivernormative{\subsubsection}{Feature bits}{Device Types / Video Device=
 / Feature bits}<br>
+<br>
+The driver MUST negotiate at least one of the<br>
+VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES and VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJ=
ECT<br>
+features.<br>
+<br>
+If VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES has been negotiated, but not<br>
+VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG, the driver MUST use physically<br>
+contiguous memory for all the buffers it allocates.<br>
+<br>
+\subsection{Device configuration layout}<br>
+\label{sec:Device Types / Video Device / Device configuration layout}<br>
+<br>
+The video device configuration space uses the following layout:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_config {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 caps_length;<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{caps_length}]<br>
+=C2=A0 is the minimum length in bytes that a device-writable buffer must h=
ave<br>
+=C2=A0 in order to receive the response to VIRTIO_VIDEO_CMD_DEVICE_QUERY_C=
APS, see<br>
+=C2=A0 \ref{sec:Device Types / Video Device / Device Operation / Device Op=
eration: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.<br>
+\end{description}<br>
+<br>
+\devicenormative{\subsubsection}{Device configuration layout}{Device Types=
 / Video Device / Device configuration layout}<br>
+<br>
+The device MUST set the \field{caps_length} field to a value equal to<br>
+the response size of VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS.<br>
+<br>
+\subsection{Supported parameters}<br>
+\label{sec:Device Types / Video Device / Supported parameters}<br>
+<br>
+\subsubsection{Supported coded formats}<br>
+\label{sec:Device Types / Video Device / Supported parameters / Supported =
coded formats}<br>
+<br>
+The following coded formats are defined:<br>
+\begin{lstlisting}<br>
+#define VIRTIO_VIDEO_CODED_FORMAT_MPEG2=C2=A0 1=C2=A0 /* MPEG-2 Part 2=C2=
=A0 (V4L2_PIX_FMT_MPEG2) */<br>
+#define VIRTIO_VIDEO_CODED_FORMAT_MPEG4=C2=A0 2=C2=A0 /* MPEG-4 Part 2=C2=
=A0 (V4L2_PIX_FMT_MPEG4) */<br>
+#define VIRTIO_VIDEO_CODED_FORMAT_H264=C2=A0 =C2=A03=C2=A0 /* H.264=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (V4L2_PIX_FMT_H264)=C2=A0 */<br>
+#define VIRTIO_VIDEO_CODED_FORMAT_HEVC=C2=A0 =C2=A04=C2=A0 /* HEVC aka H.2=
65 (V4L2_PIX_FMT_HEVC)=C2=A0 */<br>
+#define VIRTIO_VIDEO_CODED_FORMAT_VP8=C2=A0 =C2=A0 5=C2=A0 /* VP8=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (V4L2_PIX_FMT_VP8)=C2=A0 =C2=A0*/<br>
+#define VIRTIO_VIDEO_CODED_FORMAT_VP9=C2=A0 =C2=A0 6=C2=A0 /* VP9=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (V4L2_PIX_FMT_VP9)=C2=A0 =C2=A0*/<br>
+\end{lstlisting}<br>
+<br>
+The above constants have two usages:<br>
+\begin{enumerate}<br>
+\item As bit numbers, used to tell the driver which coded formats are<br>
+supported by the device, see<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.<br>
+\item As values, used to designate the coded format when working with<br>
+stream parameters, see<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.<br>
+\end{enumerate}<br>
+<br>
+The coded formats and the expected data units per buffer are documented in=
<br>
+\hyperref[intro:V4L2]{V4L2 header} and<br>
+\hyperref[intro:V4L2 compressed]{V4L2 compressed formats documentation}.<b=
r>
+<br>
+\subsubsection{Supported raw formats}<br>
+\label{sec:Device Types / Video Device / Supported parameters / Supported =
raw formats}<br>
+<br>
+The following raw formats are defined:<br>
+\begin{lstlisting}<br>
+#define VIRTIO_VIDEO_RAW_FORMAT_ARGB8888=C2=A0 1=C2=A0 /* DRM_FORMAT_ARGB8=
888 / V4L2_PIX_FMT_ABGR32 */<br>
+#define VIRTIO_VIDEO_RAW_FORMAT_BGRA8888=C2=A0 2=C2=A0 /* DRM_FORMAT_BGRA8=
888 / V4L2_PIX_FMT_ARGB32 */<br>
+#define VIRTIO_VIDEO_RAW_FORMAT_RGBA8888=C2=A0 3=C2=A0 /* DRM_FORMAT_RGBA8=
888 / V4L2_PIX_FMT_BGRA32 */<br>
+#define VIRTIO_VIDEO_RAW_FORMAT_NV12=C2=A0 =C2=A0 =C2=A0 4=C2=A0 /* DRM_FO=
RMAT_NV12=C2=A0 =C2=A0 =C2=A0/ V4L2_PIX_FMT_NV12=C2=A0 =C2=A0*/<br>
+#define VIRTIO_VIDEO_RAW_FORMAT_YUV420=C2=A0 =C2=A0 5=C2=A0 /* DRM_FORMAT_=
YUV420=C2=A0 =C2=A0/ V4L2_PIX_FMT_YUV420 */<br>
+#define VIRTIO_VIDEO_RAW_FORMAT_YVU420=C2=A0 =C2=A0 6=C2=A0 /* DRM_FORMAT_=
YVU420=C2=A0 =C2=A0/ V4L2_PIX_FMT_YVU420 */<br>
+#define VIRTIO_VIDEO_RAW_FORMAT_YUYV=C2=A0 =C2=A0 =C2=A0 7=C2=A0 /* DRM_FO=
RMAT_YUYV=C2=A0 =C2=A0 =C2=A0/ V4L2_PIX_FMT_YUYV=C2=A0 =C2=A0*/<br>
+\end{lstlisting}<br>
+<br>
+The above constants have two usages:<br>
+\begin{enumerate}<br>
+\item As bit numbers, used to tell the driver which raw formats are<br>
+supported by the device, see<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.<br>
+\item As values, used to designate the raw format when working with<br>
+stream parameters, see<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.<br>
+\end{enumerate}<br>
+<br>
+The layouts of raw formats are documented in \hyperref[intro:DRM formats]{=
DRM}<br>
+and \hyperref[intro:V4L2]{V4L2} headers, as well as in<br>
+\hyperref[intro:V4L2 RGB]{V4L2 RGB} and<br>
+\hyperref[intro:V4L2 YUV]{planar YUV} formats documentation.<br>
+<br>
+\subsubsection{Supported stream parameters}<br>
+\label{sec:Device Types / Video Device / Supported parameters / Supported =
stream parameters}<br>
+<br>
+The following stream parameters are defined:<br>
+\begin{lstlisting}<br>
+#define VIRTIO_VIDEO_PARAM_CODED_FORMAT=C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
+#define VIRTIO_VIDEO_PARAM_RAW_FORMAT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02<b=
r>
+#define VIRTIO_VIDEO_PARAM_CODED_RESOURCES=C2=A0 =C2=A0 3<br>
+#define VIRTIO_VIDEO_PARAM_RAW_RESOURCES=C2=A0 =C2=A0 =C2=A0 4<br>
+#define VIRTIO_VIDEO_PARAM_CROP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A05<br>
+#define VIRTIO_VIDEO_PARAM_BITRATE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 6=C2=A0 /* Same as V4L2_CID_MPEG_VIDEO_BITRATE */<br>
+#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_MPEG2=C2=A0 7<br>
+#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_MPEG4=C2=A0 8<br>
+#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_H264=C2=A0 =C2=A09<br>
+#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_HEVC=C2=A0 =C2=A010<br>
+#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_VP8=C2=A0 =C2=A0 11<br>
+#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_VP9=C2=A0 =C2=A0 12<br>
+\end{lstlisting}<br>
+% TODO acourbot: See b/241492607 (fractional frame rates??)<br>
+<br>
+The above constants have two usages:<br>
+\begin{enumerate}<br>
+\item As bit numbers, used to tell the driver which stream parameters are<=
br>
+supported by the device, see<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.<br>
+\item As values, used to designate the stream parameters when working with=
<br>
+them, see<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.<br>
+\end{enumerate}<br>
+<br>
+\subsection{Device Initialization}<br>
+\label{sec:Device Types / Video Device / Device Initialization}<br>
+<br>
+\begin{enumerate}<br>
+\def\labelenumi{\arabic{enumi}.}<br>
+\item<br>
+=C2=A0 The driver reads the feature bits and negotiates the features it ne=
eds.<br>
+\item<br>
+=C2=A0 The driver sets up the commandq and the eventq.<br>
+\item<br>
+=C2=A0 The driver reads the \field{caps_length} field of the configuration=
<br>
+=C2=A0 space and prepares a buffer of at least that size.<br>
+\item<br>
+=C2=A0 The driver sends that buffer on the commandq with the<br>
+=C2=A0 VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS command.<br>
+\item<br>
+=C2=A0 The driver receives the response from the device, and parses its ca=
pabilities.<br>
+\end{enumerate}<br>
+<br>
+\subsection{Device Operation}<br>
+\label{sec:Device Types / Video Device / Device Operation}<br>
+<br>
+The commandq is used by the driver to send commands to the device and to<b=
r>
+receive the device&#39;s responses via used buffers. The eventq is used by=
 the<br>
+device to send the device&#39;s delayed responses to commands and standalo=
ne<br>
+device events.<br>
+<br>
+The driver can create new streams using the<br>
+VIRTIO_VIDEO_CMD_STREAM_CREATE command. Each stream has two resource<br>
+queues (not to be confused with the virtio queues) called INPUT and<br>
+OUTPUT, when the direction of the data flow matters. The INPUT queue accep=
ts<br>
+driver-filled input data for the device (coded data for a decoder;<br>
+input frames for an encoder), while the OUTPUT queue receives resources to=
 be<br>
+filled by the device as a result of processing the INPUT queue (decoded ra=
w<br>
+frames for a decoder; encoded data for an encoder).<br>
+<br>
+These same queues can be also called CODED and RAW, when their content mat=
ters.<br>
+The CODED queue is used to transfer compressed video data (INPUT for a dec=
oder;<br>
+OUTPUT for an encoder), while the RAW queue is used to transfer raw frames=
<br>
+(OUTPUT for a decoder; INPUT for an encoder).<br>
+<br>
+The INPUT and OUTPUT queues are effectively independent, and the driver<br=
>
+can fill them without caring about the other queue. In particular there<br=
>
+is no need to queue input and output resources in pairs: one input<br>
+resource can result in zero to many produced output resources.<br>
+<br>
+A resource is a set of memory buffers that contain a unit of data that<br>
+the device can process or produce. Most resources will only have one<br>
+buffer (like coded data and single-planar raw frames), but frames using a<=
br>
+multi-planar format can have several.<br>
+<br>
+Parameters allow the driver to configure the stream for the decoding or<br=
>
+encoding operation. The parameters can be obtained and configured using<br=
>
+VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS. Available parameters depend on<br>
+the device type and are detailed in section<br>
+\ref{sec:Device Types / Video Device / Supported parameters / Supported st=
ream parameters}.<br>
+<br>
+Before resources can be submitted to a queue, backing memory must be<br>
+attached to them using VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING.<br>
+The exact form of that memory is negotiated using the feature flags.<br>
+<br>
+In the case of a decoder device, the decoded frames are made available<br>
+on the OUTPUT queue in presentation order.<br>
+<br>
+Resources are queued to the INPUT or OUTPUT queue using the<br>
+VIRTIO_VIDEO_CMD_RESOURCE_QUEUE command. The device sends a delayed respon=
se<br>
+to this command when an input resource has been fully processed and can be=
<br>
+reused by the driver, or when an output resource has been filled by the<br=
>
+device as a result of processing.<br>
+<br>
+The device can detect stream-related events that require intervention<br>
+from the driver and signals them on the eventq, see<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Standalone Events}.<br>
+One example is a dynamic parameters change while decoding a stream, which<=
br>
+may require the driver to reallocate the backing memory of its output<br>
+resources to fit the new resolution.<br>
+<br>
+% RESET and DRAIN have essentially the same outcome: all the input<br>
+% resources queued before the command are released, there are no related<b=
r>
+% output resources in the decoder/encoder, the dequeued output resources<b=
r>
+% can&#39;t be used as a reference by the device. So the other requirement=
s should<br>
+% be reasonably similar.<br>
+% Use-case: playback in a loop from second 1 till the end of file.<br>
+<br>
+% TODO put some examples in the comments<br>
+<br>
+\subsubsection{Device Operation: Command Virtqueue}<br>
+\label{sec:Device Types / Video Device / Device Operation / Device Operati=
on: Command Virtqueue}<br>
+<br>
+This section details the commands that can be sent on the commandq by<br>
+the driver, as well as the responses that the device will write.<br>
+<br>
+Different structures are used for each command and response. A command<br>
+structure starts with the requested command code, defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+/* Device */<br>
+#define VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS=C2=A0 =C2=A0 =C2=A0 =C2=A00x100=
<br>
+<br>
+/* Stream */<br>
+#define VIRTIO_VIDEO_CMD_STREAM_CREATE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x200<br>
+#define VIRTIO_VIDEO_CMD_STREAM_DESTROY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
0x201<br>
+#define VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS=C2=A0 =C2=A0 =C2=A0 =C2=A00x202=
<br></blockquote><div><br></div><div>Why not having a GET_PARAMS counterpar=
t?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+#define VIRTIO_VIDEO_CMD_STREAM_DRAIN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x203<br>
+#define VIRTIO_VIDEO_CMD_STREAM_RESET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x204<br>
+<br>
+/* Resource */<br>
+#define VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING 0x300<br>
+#define VIRTIO_VIDEO_CMD_RESOURCE_QUEUE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
0x301<br>
+\end{lstlisting}<br>
+<br>
+A response structure starts with the result of the requested command,<br>
+defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+/* Success */<br>
+#define VIRTIO_VIDEO_RESULT_OK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000<br>
+#define VIRTIO_VIDEO_RESULT_OK_DELAYED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x001<br>
+<br>
+/* Error */<br>
+#define VIRTIO_VIDEO_RESULT_ERR_INVALID_COMMAND=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00x100<br>
+#define VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION=C2=A0 =C2=A0 =C2=A0 =C2=
=A00x101<br>
+#define VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID=C2=A0 =C2=A0 =C2=A0 =C2=
=A00x102<br>
+#define VIRTIO_VIDEO_RESULT_ERR_INVALID_RESOURCE_ID=C2=A0 =C2=A0 =C2=A00x1=
03<br>
+#define VIRTIO_VIDEO_RESULT_ERR_INVALID_ARGUMENT=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x104<br>
+#define VIRTIO_VIDEO_RESULT_ERR_OUT_OF_MEMORY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x105<br>
+\end{lstlisting}<br>
+<br>
+For response structures carrying an error code, the rest of the<br>
+structure is considered invalid.<br>
+<br>
+For all commands beginning background operations and returning delayed<br>
+responses over eventq, the command response is defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+#define VIRTIO_VIDEO_INVALID_RESPONSE_ID=C2=A0 0xffffffff<br>
+<br>
+struct virtio_video_command_resp_delayed_common {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 result; /* VIRTIO_VIDEO_RESULT_* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 delayed_response_id;<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{result}]<br>
+=C2=A0 is<br>
+<br>
+=C2=A0 \begin{description}<br>
+=C2=A0 \item[VIRTIO_VIDEO_RESULT_OK_DELAYED]<br>
+=C2=A0 =C2=A0 if the command started the desired background operation succ=
essfully,<br>
+=C2=A0 \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID]<br>
+=C2=A0 =C2=A0 if the mentioned stream ID does not exist,<br>
+=C2=A0 \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_RESOURCE_ID]<br>
+=C2=A0 =C2=A0 if the mentioned resource ID does not exist,<br>
+=C2=A0 \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_ARGUMENT]<br>
+=C2=A0 =C2=A0 if other command parameters are not valid, e.g. not within t=
he device&#39;s<br>
+=C2=A0 =C2=A0 capabilities,<br>
+=C2=A0 \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION]<br>
+=C2=A0 =C2=A0 if the command is performed at a time when it is not valid.<=
br>
+=C2=A0 \end{description}<br>
+\item[\field{delayed_response_id}]<br>
+=C2=A0 is an ID of the future delayed response provided by the device, tha=
t allows<br>
+=C2=A0 to relate it to the command.<br>
+\end{description}<br>
+<br>
+\devicenormative{\paragraph}{Device Operation: Command Virtqueue}{Device T=
ypes / Video Device / Device Operation / Device Operation: Command Virtqueu=
e}<br>
+<br>
+Responses to a command MUST be written by the device in the first<br>
+device-writable descriptor of the descriptor chain from which the<br>
+command came.<br>
+<br>
+The device MUST return VIRTIO_VIDEO_RESULT_ERR_INVALID_COMMAND to<br>
+any command code it does not recognize.<br>
+<br>
+\field{delayed_response_id} MUST be set to a stream-unique identifier that=
<br>
+remains valid as long as the background operation hasn&#39;t finished.</bl=
ockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+\drivernormative{\paragraph}{Device Operation: Command Virtqueue}{Device T=
ypes / Video Device / Device Operation / Device Operation: Command Virtqueu=
e}<br>
+<br>
+Descriptor chains sent to the commandq by the driver MUST include at<br>
+least one device-writable descriptor of a size sufficient to receive the<b=
r>
+response to the queued command.<br>
+<br>
+The driver MUST NOT interpret the rest of a response whose result is not<b=
r>
+VIRTIO_VIDEO_RESULT_OK or VIRTIO_VIDEO_RESULT_OK_DELAYED.<br>
+<br>
+\subsubsection{Device Operation: Event Virtqueue}<br>
+\label{sec:Device Types / Video Device / Device Operation / Device Operati=
on: Event Virtqueue}<br>
+<br>
+The eventq is used by the device to send delayed responses to commands que=
ued<br>
+by the driver on the commandq and standalone events. Stream errors and dyn=
amic<br>
+parameters changes are caused by changes in the device&#39;s state, not by=
<br>
+commands, still they are delivered as VIRTIO_VIDEO_DELAYED_RESP_STREAM_DES=
TROY<br>
+and VIRTIO_VIDEO_DELAYED_RESP_STREAM_SET_PARAMS, respectively.<br></blockq=
uote><div><br></div><div>So, ERROR and DRC events trigger a VIRTIO_VIDEO_DE=
LAYED_RESP_STREAM_DESTROY</div><div>and VIRTIO_VIDEO_DELAYED_RESP_STREAM_SE=
T_PARAMS events, respectively.</div><div>And VIRTIO_VIDEO_DELAYED_RESP_STRE=
AM_SET_PARAMS will have</div><div>a valid `delayed_response_id` only if it =
comes from a SET_PARAMS command from the</div><div>driver. Otherwise, if it=
 is due to a dynamic parameter change, `delayed_response_id`</div><div>will=
 be set to `VIRTIO_VIDEO_INVALID_RESPONSE_ID`. Is this correct?</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+The supported events are defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+#define VIRTIO_VIDEO_DELAYED_RESP_STREAM_DESTROY=C2=A0 =C2=A0 =C2=A01<br>
+#define VIRTIO_VIDEO_DELAYED_RESP_STREAM_SET_PARAMS=C2=A0 2<br>
+#define VIRTIO_VIDEO_DELAYED_RESP_STREAM_DRAIN=C2=A0 =C2=A0 =C2=A0 =C2=A03=
<br>
+#define VIRTIO_VIDEO_DELAYED_RESP_STREAM_RESET=C2=A0 =C2=A0 =C2=A0 =C2=A04=
<br>
+#define VIRTIO_VIDEO_DELAYED_RESP_RESOURCE_QUEUE=C2=A0 =C2=A0 =C2=A05<br>
+<br>
+#define VIRTIO_VIDEO_EVENT_FLAG_CANCELED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0(1 &lt;&lt; 0)<br>
+<br>
+struct virtio_video_event {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 event_type; /* VIRTIO_VIDEO_DELAYED_RESP_=
* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stream_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 delayed_response_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 event_flags; /* Bitmask of VIRTIO_VIDEO_E=
VENT_FLAG_* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 union {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_vide=
o_stream_set_params_delayed_resp set_params;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_vide=
o_resource_queue_delayed_resp queue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{event_type}]<br>
+=C2=A0 is the type of the event.<br>
+\item[\field{stream_id}]<br>
+=C2=A0 is the ID of a valid stream.<br>
+\item[\field{delayed_response_id}]<br>
+=C2=A0 is an ID of the delayed response, that allows to relate it to a pre=
viously<br>
+=C2=A0 submitted command. If it is set to VIRTIO_VIDEO_INVALID_RESPONSE_ID=
, then<br>
+=C2=A0 this is a standalone event, see<br>
+=C2=A0 \ref{sec:Device Types / Video Device / Device Operation / Device Op=
eration: Standalone Events}.<br>
+\item[\field{event_flags}]<br>
+=C2=A0 is a bitmask of VIRTIO_VIDEO_EVENT_FLAG_* flags<br>
+<br>
+=C2=A0 \begin{description}<br>
+=C2=A0 \item[VIRTIO_VIDEO_EVENT_FLAG_CANCELED]<br>
+=C2=A0 =C2=A0 is set if the command has been canceled by another command, =
that has<br>
+=C2=A0 =C2=A0 higher priority. Doesn&#39;t make sense for standalone event=
s.<br>
+=C2=A0 \end{description}<br>
+\end{description}<br>
+<br>
+The particular member of the union is selected according to the<br>
+\field{event_type} for some of the types.<br>
+<br>
+\drivernormative{\paragraph}{Device Operation: Event Virtqueue}{Device Typ=
es / Video Device / Device Operation / Device Operation: Event Virtqueue}<b=
r>
+<br>
+The driver MUST at any time have at least one descriptor with a used<br>
+buffer large enough to contain a \field{struct virtio_video_event}<br>
+queued on the eventq.<br>
+<br>
+The driver MUST NOT put device-readable descriptors into the eventq.<br>
+<br>
+\subsubsection{Device Operation: Device Commands}<br>
+\label{sec:Device Types / Video Device / Device Operation / Device Operati=
on: Device Commands}<br>
+<br>
+This command allows retrieving the device capabilities.<br>
+<br>
+\paragraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}<br>
+\label{sec:Device Types / Video Device / Device Operation / Device Operati=
on: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}<br>
+<br>
+Retrieve device capabilities for all available stream parameters.<br>
+<br>
+The driver sends this command with<br>
+\field{struct virtio_video_device_query_caps}:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_device_query_caps {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 cmd_type; /* VIRTIO_VIDEO_CMD_DEVICE_QUER=
Y_CAPS */<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+The device responds with<br>
+\field{struct virtio_video_device_query_caps_resp}:<br>
+<br>
+\begin{lstlisting}<br>
+#define MASK(x) (1 &lt;&lt; (x))<br>
+<br>
+struct virtio_video_device_query_caps_resp {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 result; /* VIRTIO_VIDEO_RESULT_* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stream_params_bitmask; /* Bitmask of MASK=
(VIRTIO_VIDEO_PARAM_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 coded_formats_bitmask; /* Bitmaks of MASK=
(VIRTIO_VIDEO_CODED_FORMAT_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 raw_formats_bitmask; /* Bitmask of MASK(V=
IRTIO_VIDEO_RAW_FORMAT_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 num_format_deps;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 num_raw_format_caps;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 num_coded_resources_caps;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 num_raw_resources_caps;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 num_bitrate_caps; /* If MASK(VIRTIO_VIDEO=
_PARAM_BITRATE) is set. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If corresponding MASK(VIRTIO_VIDEO_PARAM_GR=
OUP_CODEC_*) is set. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_mpeg2_caps mpeg2_caps;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_mpeg4_caps mpeg4_caps;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_h264_caps h264_caps;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_hevc_caps hevc_caps;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_vp8_caps vp8_caps;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_vp9_caps vp9_caps;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Followed by<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* struct virtio_video_format_dependency =
format_deps[num_format_deps];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Followed by<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* struct virtio_video_raw_format_caps ra=
w_format_caps[num_raw_format_caps];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Followed by<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* struct virtio_video_coded_resources_ca=
ps<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* coded_resources_caps[num_coded_resourc=
es_caps];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Followed by<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* struct virtio_video_raw_resources_caps=
 raw_resources_caps[num_raw_resources_caps];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Followed by if MASK(VIRTIO_VIDEO_PARAM=
_BITRATE) is set<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* struct virtio_video_bitrate_caps bitra=
te_caps[num_bitrate_caps];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+};<br></blockquote><div><br></div><div>Maybe nitpicking, but some of the m=
ember structs are inside a comment and some are not.</div><div>Does not see=
m to correlate with them being conditional.</div><div>I think is nice to ha=
ve conditional fields in comment blocks to highlight it, but then the</div>=
<div>VIRTIO_VIDEO_PARAM_GROUP_CODEC_* structs need to be in their own comme=
nt block.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{result}]<br>
+=C2=A0 is<br>
+<br>
+=C2=A0 \begin{description}<br>
+=C2=A0 \item[VIRTIO_VIDEO_RESULT_OK]<br>
+=C2=A0 =C2=A0 if the operation succeeded,<br>
+=C2=A0 \item[VIRTIO_VIDEO_RESULT_ERR_OUT_OF_MEMORY]<br>
+=C2=A0 =C2=A0 if the descriptor was smaller than the defined \field{caps_l=
ength} in<br>
+=C2=A0 =C2=A0 the video device configuration.<br>
+=C2=A0 \end{description}<br>
+\item[\field{stream_params_bitmask}]<br>
+=C2=A0 is a bitmask of supported stream parameters.<br>
+\item[\field{coded_formats_bitmask}]<br>
+=C2=A0 is a bitmask of supported coded formats.<br>
+\item[\field{raw_formats_bitmask}]<br>
+=C2=A0 is a bitmask of supported raw formats.<br>
+\item[\field{num_format_deps}]<br>
+=C2=A0 is the number of elements in the format_deps array.<br>
+\item[\field{num_raw_format_caps}]<br>
+=C2=A0 is the number of elements in the raw_format_caps array.<br>
+\item[\field{num_coded_resources_caps}]<br>
+=C2=A0 is the number of elements in the coded_resources_caps array.<br>
+\item[\field{num_raw_resources_caps}]<br>
+=C2=A0 is the number of elements in the raw_resources_caps array.<br>
+\item[\field{num_bitrate_caps}]<br>
+=C2=A0 is the number of elements in the bitrate_caps array.<br>
+\item[\field{mpeg2_caps}]<br>
+=C2=A0 groups the capabilities of MPEG2 specific parameters.<br>
+\item[\field{mpeg4_caps}]<br>
+=C2=A0 groups the capabilities of MPEG4 specific parameters.<br>
+\item[\field{h264_caps}]<br>
+=C2=A0 groups the capabilities of H.264 specific parameters.<br>
+\item[\field{hevc_caps}]<br>
+=C2=A0 groups the capabilities of HEVC specific parameters.<br>
+\item[\field{vp8_caps}]<br>
+=C2=A0 groups the capabilities of VP8 specific parameters.<br>
+\item[\field{vp9_caps}]<br>
+=C2=A0 groups the capabilities of VP9 specific parameters.<br>
+\item[\field{format_deps}]<br>
+=C2=A0 is an array of size \field{num_format_deps} establishing dependenci=
es<br>
+=C2=A0 between coded and raw formats.<br>
+\item[\field{raw_format_caps}]<br>
+=C2=A0 is an array of size \field{num_raw_format_caps} containing the supp=
orted<br>
+=C2=A0 raw formats capabilities.<br>
+\item[\field{coded_resources_caps}]<br>
+=C2=A0 is an array of size \field{num_coded_resources_caps}, that sets bou=
nds for<br>
+=C2=A0 the number of resources in the CODED queue.<br>
+\item[\field{raw_resources_caps}]<br>
+=C2=A0 is an array of size \field{num_raw_resources_caps}, that sets bound=
s for<br>
+=C2=A0 the number of resources in the RAW queue.<br>
+\item[\field{bitrate_caps}]<br>
+=C2=A0 is an array of size \field{num_bitrate_caps} containing the support=
ed<br>
+=C2=A0 bitrates.<br>
+\end{description}<br>
+<br>
+% TODO: V4L2 flow: 1. coded format without variants (maybe these flags<br>
+% are relevant too: V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM?,<br>
+% V4L2_FMT_FLAG_DYN_RESOLUTION?, V4L2_FMT_FLAG_ENC_CAP_FRAME_INTERVAL???),=
<br>
+% also include variants (see VIDIOC_QUERYCTRL), then raw formats,<br>
+% then resolutions (discrete or stepwise, see VIDIOC_ENUM_FRAMESIZES),<br>
+% intervals are optional (see VIDIOC_ENUM_FRAMEINTERVALS)<br>
+<br>
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}{Device=
 Types / Video Device / Device Operation / Device Operation: Device Command=
s / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}<br>
+<br>
+The device MUST support at least these parameters:<br>
+VIRTIO_VIDEO_PARAM_CODED_FORMAT, VIRTIO_VIDEO_PARAM_RAW_FORMAT,<br>
+VIRTIO_VIDEO_PARAM_CODED_RESOURCES, VIRTIO_VIDEO_PARAM_RAW_RESOURCES.<br>
+<br>
+The device MUST NOT mark codec-specific parameters<br>
+(VIRTIO_VIDEO_PARAM_GROUP_CODEC_*) as supported unless the corresponding<b=
r>
+codecs are supported as well.<br>
+<br>
+The device MUST set to zero all fields with capabilities of unsupported<br=
>
+parameters.<br>
+<br>
+The lengths \field{num_format_deps}, \field{num_raw_format_caps},<br>
+\field{num_coded_resources_caps} and \field{num_raw_resources_caps} MUST b=
e<br>
+positive.<br>
+<br>
+The device MUST write the five \field{format_deps},<br>
+\field{raw_format_caps}, \field{coded_resources_caps},<br>
+\field{raw_resources_caps} and \field{bitrate_caps} arrays, of length<br>
+\field{num_format_deps}, \field{num_raw_format_caps},<br>
+\field{num_coded_resources_caps}, \field{num_raw_resources_caps} and<br>
+\field{num_bitrate_caps}, respectively.<br>
+<br>
+For each coded format in the \field{coded_formats_bitmask} there MUST be<b=
r>
+at least one element of \field{format_deps} referencing it.<br>
+<br>
+For each raw format in the \field{raw_formats_bitmask} there MUST be<br>
+at least one element of \field{format_deps} referencing it.<br>
+<br>
+For any coded and any raw format there MUST be at most one element of<br>
+\field{format_deps} referencing both of them.<br>
+<br>
+Elements of \field{format_deps} SHOULD be ordered according to raw format<=
br>
+preferences of the device from preferred to not preferred ones.<br>
+<br>
+For each raw format in the \field{raw_formats_bitmask} there MUST be<br>
+exactly one element of \field{raw_format_caps} referencing it.<br>
+<br>
+For each coded format in the \field{coded_formats_bitmask} there MUST be<b=
r>
+exactly one element of \field{coded_resources_caps} referencing it.<br>
+<br>
+For each raw format in the \field{raw_formats_bitmask} there MUST be<br>
+exactly one element of \field{raw_resources_caps} referencing it.<br>
+<br>
+If VIRTIO_VIDEO_PARAM_BITRATE is supported, then for each coded format in<=
br>
+the \field{coded_formats_bitmask} there MUST be exactly one element of<br>
+\field{bitrate_caps} referencing it.<br>
+<br>
+The total size of the response MUST be equal to \field{caps_length}<br>
+bytes, as reported by the device configuration.<br>
+<br>
+\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Format dependencies}<br>
+<br>
+The description of dependencies between coded and raw formats<br>
+\field{virtio_video_format_dependency} is defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_format_dependency {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 coded_formats_bitmask; /* Bitmask of MASK=
(VIRTIO_VIDEO_CODED_FORMAT_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 raw_format; /* VIRTIO_VIDEO_RAW_FORMAT_* =
*/<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{coded_formats_bitmask}]<br>
+=C2=A0 specifies coded formats, see<br>
+=C2=A0 \ref{sec:Device Types / Video Device / Supported parameters / Suppo=
rted coded formats}.<br>
+=C2=A0 If a bit for a specific coded format is set, then this coded format=
 can be<br>
+=C2=A0 decoded into the specified raw format or encoded from it.<br>
+\item[\field{raw_format}]<br>
+=C2=A0 is a raw format, see<br>
+=C2=A0 \ref{sec:Device Types / Video Device / Supported parameters / Suppo=
rted raw formats}.<br>
+\end{description}<br>
+<br>
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Format=
 dependencies}{Device Types / Video Device / Device Operation / Device Oper=
ation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / VIRTIO_VIDEO_=
CMD_DEVICE_QUERY_CAPS: Format dependencies}<br>
+<br>
+\field{coded_formats_bitmask} MUST be a subset of \field{coded_formats_bit=
mask}<br>
+field of \field{struct virtio_video_device_query_caps_resp}.<br>
+<br>
+\field{coded_formats_bitmask} MUST specify at least one coded format.<br>
+<br>
+\field{raw_format} MUST be set to one of the supported raw formats accordi=
ng to<br>
+the \field{raw_formats_bitmask} field of<br>
+\field{struct virtio_video_device_query_caps_resp}.<br>
+<br>
+\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format capabilities}=
<br>
+\label{sec:Device Types / Video Device / Device Operation / Device Operati=
on: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / VIRTIO_VIDEO_CMD=
_DEVICE_QUERY_CAPS: Raw format capabilities}<br>
+<br>
+The raw format capability description \field{virtio_video_raw_format_caps}=
 is<br>
+defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+enum virtio_video_planes_layout {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER =3D 1=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_VIDEO_PLANES_LAYOUT_MULTI_BUFFERS =3D 2=
,<br>
+};<br>
+<br>
+struct virtio_video_range {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 min;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 max;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 step;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+};<br>
+<br>
+struct virtio_video_raw_format_caps {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 raw_formats_bitmask; /* Bitmask of MASK(V=
IRTIO_VIDEO_RAW_FORMAT_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 planes_layouts; /* Bitmask of VIRTIO_VIDE=
O_PLANES_LAYOUT_* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 plane_align;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stride_align_mask;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_range width_range;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_range height_range;<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\field{struct virtio_video_range} is used to represent a range of values.<=
br>
+An integer \(x\) is within the range \field{r} if<br>
+\(\field{r.min} \le x \le \field{r.max}\) holds and \(x\) equals to<br>
+\((\field{min} + \field{step} * n)\) for some integer \(n\).<br>
+<br>
+\begin{description}<br>
+\item[\field{raw_formats_bitmask}]<br>
+=C2=A0 specifies raw formats, see<br>
+=C2=A0 \ref{sec:Device Types / Video Device / Supported parameters / Suppo=
rted raw formats},<br>
+=C2=A0 to which these capabilities apply.<br>
+\item[\field{planes_layouts}]<br>
+=C2=A0 is a bitmask with the set of plane layout types from<br>
+=C2=A0 \field{enum virtio_video_planes_layout}.<br>
+\item[\field{plane_align}]<br>
+=C2=A0 is the alignment of planes within a buffer in bytes. This field is =
valid<br>
+=C2=A0 only if \field{planes_layouts} has the<br>
+=C2=A0 \field{VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER} bit set.<br>
+\item[\field{stride_align_mask}]<br>
+=C2=A0 is a mask of all supported power of two stride alignments.<br>
+\item[\field{width_range}]<br>
+=C2=A0 is a range of widths in pixels.<br>
+\item[\field{height_range}]<br>
+=C2=A0 is a range of heights in pixels.<br>
+\end{description}<br>
+<br>
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw fo=
rmat capabilities}{Device Types / Video Device / Device Operation / Device =
Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / VIRTIO_VI=
DEO_CMD_DEVICE_QUERY_CAPS: Raw format capabilities}<br>
+<br>
+\field{raw_formats_bitmask} MUST be a subset of \field{raw_formats_bitmask=
}<br>
+field of \field{struct virtio_video_device_query_caps_resp}.<br>
+<br>
+\field{raw_formats_bitmask} MUST specify at least one raw format.<br>
+<br>
+The device MUST set \field{VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER} bit i=
n<br>
+\field{planes_layouts} if the plane layout with planes of a frame laid out=
 one<br>
+after another in the same buffer is supported.<br>
+<br>
+The device MUST set \field{VIRTIO_VIDEO_PLANES_LAYOUT_MULTI_BUFFERS} bit i=
n<br>
+\field{planes_layouts} if the plane layout with planes of a frame laid out=
 in<br>
+separate buffers is supported.<br>
+<br>
+\field{plane_align} MUST be set to a power of two according to the device<=
br>
+plane alignment requirements if \field{planes_layouts} has the<br>
+\field{VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER} bit set or to zero otherw=
ise.<br>
+<br>
+\field{min}, \field{step} and \field{max} MUST be positive.<br>
+<br>
+\field{min} MUST be less then or equal to \field{max} within the same rang=
e.<br>
+<br>
+\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Resource capabilities}<b=
r>
+<br>
+The CODED resource capabilities \field{virtio_video_coded_resources_caps} =
is<br>
+defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_coded_resources_caps {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 coded_formats_bitmask; /* Bitmask of MASK=
(VIRTIO_VIDEO_CODED_FORMAT_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 min_resources;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 max_resources;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 buffer_size;<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{coded_formats_bitmask}]<br>
+=C2=A0 specifies coded formats, see<br>
+=C2=A0 \ref{sec:Device Types / Video Device / Supported parameters / Suppo=
rted coded formats},<br>
+=C2=A0 to which these capabilities apply.<br>
+\item[\field{min_resources}]<br>
+=C2=A0 is the minimum number of resources that the CODED queue supports fo=
r all<br>
+=C2=A0 the specified coded formats.<br>
+\item[\field{max_resources}]<br>
+=C2=A0 is the maximum number of resources that the CODED queue supports fo=
r all<br>
+=C2=A0 the specified coded formats.<br>
+\item[\field{buffer_size}]<br>
+=C2=A0 is the minimum size of the buffers that will back resources to be q=
ueued.<br>
+\end{description}<br>
+<br>
+The RAW resource capabilities \field{virtio_video_raw_resources_caps} is<b=
r>
+defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_raw_resources_caps {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 raw_formats_bitmask; /* Bitmask of MASK(V=
IRTIO_VIDEO_RAW_FORMAT_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 min_resources;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 max_resources;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{raw_formats_bitmask}]<br>
+=C2=A0 specifies raw formats, see<br>
+=C2=A0 \ref{sec:Device Types / Video Device / Supported parameters / Suppo=
rted raw formats},<br>
+=C2=A0 to which these capabilities apply.<br>
+\item[\field{min_resources}]<br>
+=C2=A0 is the minimum number of resources that the RAW queue supports for =
all<br>
+=C2=A0 the specified raw formats.<br>
+\item[\field{max_resources}]<br>
+=C2=A0 is the maximum number of resources that the RAW queue supports for =
all<br>
+=C2=A0 the specified raw formats.<br>
+\end{description}<br>
+<br>
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Resour=
ce capabilities}{Device Types / Video Device / Device Operation / Device Op=
eration: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / VIRTIO_VIDE=
O_CMD_DEVICE_QUERY_CAPS: Resource capabilities}<br>
+<br>
+\field{coded_formats_bitmask} MUST be a subset of \field{coded_formats_bit=
mask}<br>
+field of \field{struct virtio_video_device_query_caps_resp}.<br>
+<br>
+\field{coded_formats_bitmask} MUST specify at least one coded format.<br>
+<br>
+\field{raw_formats_bitmask} MUST be a subset of \field{raw_formats_bitmask=
}<br>
+field of \field{struct virtio_video_device_query_caps_resp}.<br>
+<br>
+\field{raw_formats_bitmask} MUST specify at least one raw format.<br>
+<br>
+\field{min_resources} MUST NOT be negative.<br>
+<br>
+\field{max_resources} MUST be greater then or equal to \field{min_resource=
s}<br>
+within the same struct instance.<br>
+<br>
+\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Bitrates}<br>
+<br>
+The bitrate capabilities \field{virtio_video_bitrate_caps} is<br>
+defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_bitrate_caps {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 coded_formats_bitmask; /* Bitmask of MASK=
(VIRTIO_VIDEO_CODED_FORMAT_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 min_bitrate;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 max_bitrate;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{coded_formats_bitmask}]<br>
+=C2=A0 specifies coded formats, see<br>
+=C2=A0 \ref{sec:Device Types / Video Device / Supported parameters / Suppo=
rted coded formats},<br>
+=C2=A0 to which these capabilities apply.<br>
+\item[\field{min_bitrate}]<br>
+=C2=A0 is the minimum bitrate in bits per second supported by the encoder =
for all the specified coded<br>
+=C2=A0 formats.<br>
+\item[\field{max_bitrate}]<br>
+=C2=A0 is the maximum bitrate in bits per second supported by the encoder =
for all the specified coded<br>
+=C2=A0 formats.<br>
+\end{description}<br>
+<br>
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Bitrat=
es}{Device Types / Video Device / Device Operation / Device Operation: Devi=
ce Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / VIRTIO_VIDEO_CMD_DEVICE_=
QUERY_CAPS: Bitrates}<br>
+<br>
+\field{coded_formats_bitmask} MUST be a subset of \field{coded_formats_bit=
mask}<br>
+field of \field{struct virtio_video_device_query_caps_resp}.<br>
+<br>
+\field{coded_formats_bitmask} MUST specify at least one coded format.<br>
+<br>
+\field{min_bitrate} MUST NOT be negative.<br>
+<br>
+\field{max_bitrate} MUST be greater then or equal to \field{min_bitrate}<b=
r>
+within the same \field{struct virtio_video_bitrate_caps} instance.<br>
+<br>
+\subsubsection{Device Operation: Stream commands}<br>
+\label{sec:Device Types / Video Device / Device Operation / Device Operati=
on: Stream commands}<br>
+<br>
+Stream commands allow the creation, destruction, and flow control of a<br>
+stream.<br>
+<br>
+\paragraph{VIRTIO_VIDEO_CMD_STREAM_CREATE}<br>
+\label{sec:Device Types / Video Device / Device Operation / Device Operati=
on: Stream commands / VIRTIO_VIDEO_CMD_STREAM_CREATE}<br>
+<br>
+Create a new stream using the device.<br>
+<br>
+The driver sends this command with<br>
+\field{struct virtio_video_stream_create}:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_stream_create {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_CREA=
TE */<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+The device responds with \field{struct virtio_video_stream_create_resp}:<b=
r>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_stream_create_resp {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 result; /* VIRTIO_VIDEO_RESULT_* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stream_id;<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{result}]<br>
+=C2=A0 is<br>
+<br>
+=C2=A0 \begin{description}<br>
+=C2=A0 \item[VIRTIO_VIDEO_RESULT_OK]<br>
+=C2=A0 =C2=A0 if the operation succeeded,<br>
+=C2=A0 \item[VIRTIO_VIDEO_RESULT_ERR_OUT_OF_MEMORY]<br>
+=C2=A0 =C2=A0 if the limit of simultaneous streams has been reached by the=
 device and<br>
+=C2=A0 =C2=A0 no more can be created.<br>
+=C2=A0 \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION]<br>
+=C2=A0 =C2=A0 if the stream cannot be created due to an unexpected device =
issue.<br>
+=C2=A0 \end{description}<br>
+\item[\field{stream_id}]<br>
+=C2=A0 is the ID of the created stream allocated by the device.<br>
+\end{description}<br>
+<br>
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_CREATE}{Device Typ=
es / Video Device / Device Operation / Device Operation: Stream commands / =
VIRTIO_VIDEO_CMD_STREAM_CREATE}<br>
+<br>
+\field{stream_id} MUST be set to a device-unique identifier that remains<b=
r>
+valid as long as the stream is alive.<br>
+<br>
+\paragraph{VIRTIO_VIDEO_CMD_STREAM_DESTROY}<br>
+\label{sec:Device Types / Video Device / Device Operation / Device Operati=
on: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DESTROY}<br>
+<br>
+% DESTROY has to be more like RESET, not DRAIN, because it is called, for<=
br>
+% example, when the guest user-space app closes a file descriptor. So ther=
e<br>
+% is no sense in continuing the processing.<br>
+<br>
+Destroy a video stream and all its resources. Any activity on the stream<b=
r>
+is halted and all resources are released by the time the delayed response =
is<br>
+received by the driver.<br>
+<br>
+The driver sends this command with<br>
+\field{struct virtio_video_stream_destroy}:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_stream_destroy {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_DEST=
ROY */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stream_id;<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{stream_id}]<br>
+=C2=A0 is the ID of the stream to be destroyed, as previously returned by<=
br>
+=C2=A0 VIRTIO_VIDEO_CMD_STREAM_CREATE.<br>
+\end{description}<br>
+<br>
+The device responds as described in<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Command Virtqueue}<br>
+and begins the background DESTROY operation.<br>
+<br>
+When the command is completed the device sends the<br>
+VIRTIO_VIDEO_DELAYED_RESP_STREAM_DESTROY delayed response, see<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Event Virtqueue}.<br>
+The delayed response can also come in case of unrecoverable stream error, =
see<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Standalone Events / Error Event}.<br>
+<br>
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_DESTROY}{Device Ty=
pes / Video Device / Device Operation / Device Operation: Stream commands /=
 VIRTIO_VIDEO_CMD_STREAM_DESTROY}<br>
+<br>
+Before the device sends a delayed response to VIRTIO_VIDEO_CMD_STREAM_DEST=
ROY,<br>
+it MUST send all other pending delayed responses with<br>
+VIRTIO_VIDEO_EVENT_FLAG_CANCELED flag set and detach all resources.<br>
+<br>
+After VIRTIO_VIDEO_CMD_STREAM_DESTROY is queued, the device MUST reply wit=
h<br>
+VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID to any subsequently queued comma=
nd<br>
+with this stream ID.<br>
+<br>
+The DESTROY operation MUST NOT be canceled.<br>
+<br>
+\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_DESTROY}{Device Ty=
pes / Video Device / Device Operation / Device Operation: Stream commands /=
 VIRTIO_VIDEO_CMD_STREAM_DESTROY}<br>
+<br>
+\field{stream_id} MUST be set to a valid stream ID previously returned<br>
+by VIRTIO_VIDEO_CMD_STREAM_CREATE.<br>
+<br>
+The driver MUST stop using \field{stream_id} as a valid stream after it<br=
>
+received the delayed response to this command.<br>
+<br>
+\paragraph{VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}<br>
+\label{sec:Device Types / Video Device / Device Operation / Device Operati=
on: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}<br>
+<br>
+Write values of selected parameters of a given stream, and receive back th=
e<br>
+values for all the parameters supported by the device as reported by<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.<br>
+The operation can be either executed immediately, or queued into the INPUT=
<br>
+queue, i.e. after processing all the INPUT queue elements that are queued<=
br>
+before the command.<br>
+<br>
+The driver sends this command with<br>
+\field{struct virtio_video_stream_set_params}:<br>
+<br>
+\begin{lstlisting}<br>
+#define VIRTIO_VIDEO_SET_PARAMS_FLAG_IN_BAND=C2=A0 (1 &lt;&lt; 0)<br>
+<br>
+struct virtio_video_stream_set_params {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_SET_=
PARAMS */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stream_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 flags; /* Bitmask of VIRTIO_VIDEO_SET_PAR=
AMS_FLAG_* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_params params;<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{stream_id}]<br>
+=C2=A0 is the ID of the stream we want to set a parameter for.<br>
+\item[\field{flags}]<br>
+=C2=A0 is a bitmask of VIRTIO_VIDEO_SET_PARAMS_FLAG_* values.<br>
+<br>
+=C2=A0 \begin{description}<br>
+=C2=A0 \item[\field{VIRTIO_VIDEO_SET_PARAMS_FLAG_IN_BAND}]<br>
+=C2=A0 =C2=A0 The submitted parameters are to be set only after all of the=
 previously<br>
+=C2=A0 =C2=A0 queued INPUT queue elements are processed. Without this flag=
 the<br>
+=C2=A0 =C2=A0 parameters are set Immediately.<br>
+=C2=A0 \end{description}<br>
+\item[\field{params}]<br>
+=C2=A0 is a container for the selected stream parameters to be set.<br>
+\end{description}<br>
+<br>
+The device responds as described in<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Command Virtqueue}<br>
+and begins the background SET_PARAMS operation.<br>
+<br>
+When the background processing of the resource is completed the device sen=
ds<br>
+the VIRTIO_VIDEO_DELAYED_RESP_STREAM_SET_PARAMS delayed response, see<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Event Virtqueue}.<br>
+The delayed response can also come in case of dynamic parameters change, s=
ee<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Standalone Events / Dynamic Parameters Change Event}.<br>
+<br>
+The command-specific delayed response<br>
+\field{struct virtio_video_stream_set_params_delayed_resp} is defined<br>
+as follows:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_stream_set_params_delayed_resp {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_params params;<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{params}]<br>
+=C2=A0 is a container for the actual values of all the parameters supporte=
d by the<br>
+=C2=A0 device. The values set by the device may differ from the requested =
values<br>
+=C2=A0 depending on the device&#39;s capabilities.<br>
+\end{description}<br>
+<br>
+The \field{struct virtio_video_params} is defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_raw_format {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 format;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 planes_layout; /* VIRTIO_VIDEO_PLANES_LAY=
OUT_* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stride;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 width;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 height;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+};<br>
+<br>
+struct virtio_video_param_crop {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 left;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 top;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 width;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 height;<br>
+};<br>
+<br>
+union virtio_video_codec_params {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_mpeg2_params mpeg2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_mpeg4_params mpeg4;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_h264_params h264;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_hevc_params hevc;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_vp8_params vp8;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_vp9_params vp9;<br>
+};<br>
+<br>
+struct virtio_video_params {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stream_params_bitmask; /* Bitmask of MASK=
(VIRTIO_VIDEO_PARAM_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 coded_format; /* If MASK(VIRTIO_VIDEO_PAR=
AM_CODED_FORMAT) is set. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If MASK(VIRTIO_VIDEO_PARAM_RAW_FORMAT) is s=
et. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_raw_format raw_format;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If MASK(VIRTIO_VIDEO_PARAM_CODED_RESOURCES)=
 is set. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_param_resources coded_reso=
urces;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If MASK(VIRTIO_VIDEO_PARAM_RAW_RESOURCES) i=
s set. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_param_resources raw_resour=
ces;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_param_crop crop; /* If MAS=
K(VIRTIO_VIDEO_PARAM_CROP) is set. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 bitrate; /* If MASK(VIRTIO_VIDEO_PARAM_BI=
TRATE) is set. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If the corresponding MASK(VIRTIO_VIDEO_PARA=
M_GROUP_CODEC_*) is set<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * depending on the coded_format. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 union virtio_video_codec_params codec;<br>
+};<br>
+\end{lstlisting}<br></blockquote><div><br></div><div>This is a bit difficu=
lt to read for me, as some of the *if* comments are written AFTER</div><div=
>the member definition, and some others BEFORE the member defintion.</div><=
div>Above, when introducing the=C2=A0VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS com=
mand,</div><div>you use this format for the conditional fields:</div><div>/=
**<br>* Followed by if MASK(VIRTIO_VIDEO_PARAM_BITRATE) is set<br>* struct =
virtio_video_bitrate_caps bitrate_caps[num_bitrate_caps];<br>*/<br></div><d=
iv>It spaces a bit more the members, and leaves them as part of the</div><d=
iv>comment block. I would suggest to keep the format consistent.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+\begin{description}<br>
+\item[\field{stream_params_bitmask}]<br>
+=C2=A0 is a bitmask of supported stream parameters.<br>
+\item[\field{coded_format}]<br>
+=C2=A0 is a coded format of the CODED queue, see<br>
+=C2=A0 \ref{sec:Device Types / Video Device / Supported parameters}.<br>
+\item[\field{raw_format}]<br>
+=C2=A0 is a raw format of the RAW queue including related parameters<br>
+<br>
+=C2=A0 \begin{description}<br>
+=C2=A0 \item[\field{format}]<br>
+=C2=A0 =C2=A0 is the actual format, see<br>
+=C2=A0 =C2=A0 \ref{sec:Device Types / Video Device / Supported parameters =
/ Supported raw formats}.<br>
+=C2=A0 \item[\field{planes_layout}]<br>
+=C2=A0 =C2=A0 is the actual layout of the planes, see<br>
+=C2=A0 =C2=A0 \ref{sec:Device Types / Video Device / Device Operation / De=
vice Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / VIRT=
IO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format capabilities}.<br>
+=C2=A0 \item[\field{stride}]<br>
+=C2=A0 =C2=A0 is the distance in bytes between two lines of data.<br>
+=C2=A0 \item[\field{width}]<br>
+=C2=A0 =C2=A0 is the width in pixels of the stream frames.<br>
+=C2=A0 \item[\field{height}]<br>
+=C2=A0 =C2=A0 is the height in pixels of the stream frames.<br>
+=C2=A0 \end{description}<br>
+\item[\field{coded_resources}]<br>
+=C2=A0 is the CODED queue resources parameters, see<br>
+=C2=A0 \ref{sec:Device Types / Video Device / Device Operation / Device Op=
eration: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.<br>
+\item[\field{raw_resources}]<br>
+=C2=A0 is the RAW queue resources parameters, see<br>
+=C2=A0 \ref{sec:Device Types / Video Device / Device Operation / Device Op=
eration: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.<br>
+\item[\field{crop}]<br>
+=C2=A0 is the rectangle covering the visible size of the frame, i.e the pa=
rt of<br>
+=C2=A0 the frame that should be displayed, \field{width} and \field{height=
} are<br>
+=C2=A0 relative to \field{left} and \field{top}.<br>
+\item[\field{bitrate}]<br>
+=C2=A0 is the current desired bitrate for the encoder. This can be changed=
 at<br>
+=C2=A0 any moment by the driver and will apply to subsequently submitted f=
rames.<br>
+\item[\field{codec}]<br>
+=C2=A0 consists of codec-specific parameters, see<br>
+=C2=A0 \ref{sec:Device Types / Video Device / Codec-specific parameters} f=
or the<br>
+=C2=A0 definitions. Not available until \field{coded_format} is set.<br>
+\end{description}<br>
+<br>
+Successfully setting \field{coded_format}, \field{coded_resources},<br>
+\field{raw_format} or \field{raw_resources} starts with an implicit<br>
+background DRAIN operation if the corresponding queue has any queued<br>
+resources, then all the remaining elements in the queue are cancelled if<b=
r>
+there are any and then all currently attached resources of the queue are<b=
r>
+detached if there are any, i.e. the driver cannot queue a resource to the<=
br>
+queue without attaching some backing memory first.<br>
+<br>
+% Use-case: for the decoder, resolution can be set manually by the driver<=
br>
+% (useful for codecs that do not embed this information). The processing<b=
r>
+% sequence should the look similar to the dynamic parameters change case.<=
br>
+<br>
+\field{struct virtio_video_param_resources} is used to control the<br>
+number of resources and their backing memory type for the INPUT and<br>
+OUTPUT queues:<br>
+<br>
+\begin{lstlisting}<br>
+#define VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES=C2=A0 =C2=A0 =C2=A0 =C2=A00x1<br=
>
+#define VIRTIO_VIDEO_MEM_TYPE_VIRTIO_OBJECT=C2=A0 =C2=A0 =C2=A00x2<br>
+<br>
+struct virtio_video_param_resources {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 num_resources;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 mem_type; /* VIRTIO_VIDEO_MEM_TYPE_* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[3];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{num_resources}]<br>
+=C2=A0 is the number of resources that can be addressed for the queue, num=
bered<br>
+=C2=A0 from \(0\) to \(num\_resources - 1\). Can be equal to zero if no<br=
>
+=C2=A0 resources are allocated, otherwise will be comprised between<br>
+=C2=A0 \field{min_resources} and \field{max_resources}.<br>
+\item[\field{mem_type}]<br>
+=C2=A0 is the memory type that will be used to back these resources.<br>
+\end{description}<br>
+<br>
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}{Device=
 Types / Video Device / Device Operation / Device Operation: Stream command=
s / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}<br>
+<br>
+The device MUST initialize each parameter to a valid default value.<br>
+<br>
+The device MUST allow each parameter to be read even without the driver<br=
>
+explicitly setting a value for them beforehand.<br>
+<br>
+\field{stream_params_bitmask} MUST be a subset of \field{stream_params_bit=
mask}<br>
+field of \field{struct virtio_video_device_query_caps_resp}.<br>
+<br>
+The fields \field{coded_format}, \field{raw_format}, \field{coded_resource=
s},<br>
+\field{raw_resources}, \field{bitrate}, \field{codec} MUST be set accordin=
g<br>
+to the capabilities returned by VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS, see<br=
>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.<br>
+The conformance check MUST be performed before the command response is sen=
t.<br>
+<br>
+\field{stream_params_bitmask} MAY contain at most one of<br>
+VIRTIO_VIDEO_PARAM_GROUP_CODEC_* bits. This bit MUST correspond to the<br>
+coded format selected with \field{coded_format}.<br>
+<br>
+The device MAY adjust any requested parameter to a closest supported<br>
+value if the requested one is not supported with the current settings.<br>
+<br>
+There MAY be at most one out of band SET_PARAMS operations at the same tim=
e.<br>
+The amount of in band SET_PARAMS operations at the same time MUST NOT exce=
ed<br>
+the number of input resources.<br>
+<br>
+The parameters MUST be applied in the same order as in<br>
+\ref{sec:Device Types / Video Device / Supported parameters / Supported st=
ream parameters}.<br>
+<br>
+When \field{coded_format}, \field{coded_resources},<br>
+\field{raw_format} or \field{raw_resources} are being changed, the device<=
br>
+MUST first check if there are any queued resources in the corresponding<br=
>
+queue. If there are any the device MUST run a DRAIN operation in the same =
way<br>
+as with VIRTIO_VIDEO_CMD_STREAM_DRAIN except that sending<br>
+VIRTIO_VIDEO_DELAYED_RESP_STREAM_DRAIN MUST be omitted. Then the device MU=
ST<br>
+cancel all remaining elements in the queue if there are any. Then the devi=
ce<br>
+MUST detach all attached resources of the queue if there are any. Then the=
<br>
+device MUST set the requested parameters and send the delayed response. An=
y<br>
+subsequent operations using the queue MUST be blocked until the first<br>
+resource is attached and queued again. All these steps MUST be performed<b=
r>
+before processing any subsequent commands.<br>
+<br>
+The device MUST process parameters changes, that are embedded in the input=
<br>
+stream, in the same way as if there is an in band<br>
+VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS command changing the OUTPUT queue<br>
+parameters. A standalone DPC event MUST be sent instead of the command&#39=
;s<br>
+delayed response in this case.<br>
+<br>
+The device MUST return all the available parameters in the delayed respons=
e<br>
+to the command. \field{codec} is not available until \field{coded_format}<=
br>
+is set.<br>
+<br>
+% TODO define when changing other parameters is allowed.<br>
+<br>
+\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}{Device=
 Types / Video Device / Device Operation / Device Operation: Stream command=
s / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}<br>
+<br>
+\field{stream_id} MUST be set to a valid stream ID previously returned<br>
+by VIRTIO_VIDEO_CMD_STREAM_CREATE.<br>
+<br>
+The driver MUST fill the fields according to the parameters selected with<=
br>
+\field{stream_params_bitmask}. All the other fields MUST be set to zero.<b=
r>
+<br>
+The driver MUST check the actual values of the parameters as set by the<br=
>
+device and work with these values, or try to set a different one if it<br>
+cannot, or fail properly.<br>
+<br>
+After creating a new stream, the initial value of all parameters is<br>
+undefined to the driver. Thus, the driver MUST NOT assume the default<br>
+value of any parameter and MAY use VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS<br>
+in order to get the values of the parameters it needs.<br>
+<br>
+The driver SHOULD NOT send any in band SET_PARAMS commands or QUEUE comman=
ds<br>
+on the INPUT queue before receiving the delayed response, when changing th=
e<br>
+\field{coded_format} or \field{coded_resources} for decoder or<br>
+\field{raw_format} or \field{raw_resources} for encoder.<br>
+<br>
+If some of the resources were detached as a result of this command the<br>
+driver SHOULD maybe reallocate and reattach the backing memories of these<=
br>
+resources and queue them again to resume the device operation.<br>
+<br>
+\paragraph{VIRTIO_VIDEO_CMD_STREAM_DRAIN}<br>
+\label{sec:Device Types / Video Device / Device Operation / Device Operati=
on: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DRAIN}<br>
+<br>
+Complete processing of all INPUT queue elements queued before this command=
<br>
+and make the resulting output resources available to the driver.<br>
+<br>
+The driver sends this command with<br>
+\field{struct virtio_video_stream_drain}:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_stream_drain {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_DRAI=
N */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stream_id;<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{stream_id}]<br>
+=C2=A0 is the ID of the stream to drain, as previously returned by<br>
+=C2=A0 VIRTIO_VIDEO_CMD_STREAM_CREATE.<br>
+\end{description}<br>
+<br>
+The device responds as described in<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Command Virtqueue}<br>
+and begins the background DRAIN operation.<br>
+<br>
+When the background DRAIN operation is completed the device sends the<br>
+VIRTIO_VIDEO_DELAYED_RESP_STREAM_DRAIN delayed response, see<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Event Virtqueue}.<br>
+<br>
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_DRAIN}{Device Type=
s / Video Device / Device Operation / Device Operation: Stream commands / V=
IRTIO_VIDEO_CMD_STREAM_DRAIN}<br>
+<br>
+Before the device sends the response, it MUST process and respond to all<b=
r>
+the VIRTIO_VIDEO_CMD_RESOURCE_QUEUE commands on the INPUT queue that<br>
+were sent before the drain command, and make all the corresponding<br>
+output resources available to the driver by responding to their<br>
+VIRTIO_VIDEO_CMD_RESOURCE_QUEUE command.<br>
+<br>
+The device MUST be able to accept input work while a DRAIN operation<br>
+is ongoing, but any resulting delayed responses MUST NOT be sent before<br=
>
+the delayed response to the DRAIN command.<br>
+<br>
+The amount of DRAIN operations at the same time in the INPUT queue MUST NO=
T<br>
+exceed the number of input resources. The device MUST return<br>
+VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION if the number is exceeded.<br>
+<br>
+If the command is interrupted with a VIRTIO_VIDEO_CMD_STREAM_RESET<br>
+or VIRTIO_VIDEO_CMD_STREAM_DESTROY commands, the device MUST<br>
+send the delayed response with VIRTIO_VIDEO_EVENT_FLAG_CANCELED flag set.<=
br>
+<br>
+\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_DRAIN}{Device Type=
s / Video Device / Device Operation / Device Operation: Stream commands / V=
IRTIO_VIDEO_CMD_STREAM_DRAIN}<br>
+<br>
+\field{stream_id} MUST be set to a valid stream ID previously returned<br>
+by VIRTIO_VIDEO_CMD_STREAM_CREATE.<br>
+<br>
+The driver MUST keep queueing output resources until it gets the<br>
+response to this command or cancels it using<br>
+VIRTIO_VIDEO_CMD_STREAM_RESET or<br>
+VIRTIO_VIDEO_CMD_STREAM_DESTROY. Failure to do so may result in the<br>
+device stalling as it waits for output resources to write into.<br>
+<br>
+The driver MUST account for the fact that the response to this command<br>
+might come out-of-order (i.e. after other commands sent to the device),<br=
>
+and that it can be interrupted.<br>
+<br>
+The driver MUST send a DRAIN command when it does not have any further<br>
+input, in order to ensure it receives all the output corresponding to<br>
+the stream.<br>
+<br>
+\paragraph{VIRTIO_VIDEO_CMD_STREAM_RESET}<br>
+\label{sec:Device Types / Video Device / Device Operation / Device Operati=
on: Stream commands / VIRTIO_VIDEO_CMD_STREAM_RESET}<br>
+<br>
+Immediately cancel all INPUT queue elements queued before this command<br>
+without processing them and discard any processing results in the output<b=
r>
+resources, that are not yet dequeued. This command is mostly useful for<br=
>
+decoders that need to quickly jump from one point of the stream to another=
<br>
+(i.e. seeking), or in order to stop processing as quickly as possible.<br>
+<br>
+The driver sends this command with<br>
+\field{struct virtio_video_stream_reset}:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_stream_reset {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_RESE=
T */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stream_id;<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{stream_id}]<br>
+=C2=A0 is the ID of the stream to reset, as previously returned by<br>
+=C2=A0 VIRTIO_VIDEO_CMD_STREAM_CREATE.<br>
+\end{description}<br>
+<br>
+The device responds as described in<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Command Virtqueue}<br>
+and begins the background RESET operation.<br>
+<br>
+When the background RESET operation is completed the device sends the<br>
+VIRTIO_VIDEO_DELAYED_RESP_STREAM_RESET delayed response, see<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Event Virtqueue}.<br>
+<br>
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_RESET}{Device Type=
s / Video Device / Device Operation / Device Operation: Stream commands / V=
IRTIO_VIDEO_CMD_STREAM_RESET}<br>
+<br>
+The device MUST send delayed responses with VIRTIO_VIDEO_EVENT_FLAG_CANCEL=
ED<br>
+flag set for a background DRAIN operation and VIRTIO_VIDEO_CMD_RESOURCE_QU=
EUE<br>
+commands on the INPUT queue before responding to this command.<br>
+<br>
+While the device is processing the command, it MUST return<br>
+VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION to any subsequent<br>
+VIRTIO_VIDEO_CMD_STREAM_RESET commands.<br>
+<br>
+The device MUST be able to accept input work while a RESET operation<br>
+is ongoing, but any resulting delayed responses MUST NOT be sent before<br=
>
+the delayed response to the RESET command.<br>
+<br>
+The device MUST interrupt operation as quickly as possible, and not be<br>
+dependent on output resources being queued by the driver.<br>
+<br>
+Upon resuming processing, the device MAY skip input data until it finds<br=
>
+a point that allows it to resume operation properly (e.g. until a<br>
+keyframe is found in the input stream of a decoder).<br>
+<br>
+\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_RESET}{Device Type=
s / Video Device / Device Operation / Device Operation: Stream commands / V=
IRTIO_VIDEO_CMD_STREAM_RESET}<br>
+<br>
+\field{stream_id} MUST be set to a valid stream ID previously returned<br>
+by VIRTIO_VIDEO_CMD_STREAM_CREATE.<br>
+<br>
+Upon receiving the response to this command, the driver SHOULD process<br>
+(or drop) any output resource before resuming operation by queueing new<br=
>
+input resources.<br>
+<br>
+Upon receiving the response to this command, the driver MAY modify the<br>
+\field{struct virtio_video_param_resources} parameter corresponding to<br>
+the INPUT queue, and subsequently attach new backing memory to the input<b=
r>
+resources using the VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING<br>
+command.<br>
+<br>
+\subsubsection{Device Operation: Resource Commands}<br>
+\label{sec:Device Types / Video Device / Device Operation / Device Operati=
on: Resource Commands}<br>
+<br>
+Resource commands manage the memory backing of individual resources and<br=
>
+queue them for the device to process.<br>
+<br>
+\paragraph{VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}<br>
+\label{sec:Device Types / Video Device / Device Operation / Device Operati=
on: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}<br>
+<br>
+Attach backing memory to a resource.<br>
+<br>
+The driver sends this command with<br>
+\field{struct virtio_video_resource_attach_backing}:<br>
+<br>
+\begin{lstlisting}<br>
+#define VIRTIO_VIDEO_QUEUE_TYPE_INPUT=C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
+#define VIRTIO_VIDEO_QUEUE_TYPE_OUTPUT=C2=A0 =C2=A0 =C2=A0 1<br>
+<br>
+struct virtio_video_resource_attach_backing {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 cmd_type; /* VIRTIO_VIDEO_CMD_RESOURCE_AT=
TACH_BACKING */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stream_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 queue_type; /* VIRTIO_VIDEO_QUEUE_TYPE_* =
*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 resource_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 union virtio_video_resource resources[];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{stream_id}]<br>
+=C2=A0 is the ID of a valid stream.<br>
+\item[\field{queue_type}]<br>
+=C2=A0 is the direction of the queue.<br>
+\item[\field{resource_id}]<br>
+=C2=A0 is the ID of the resource to be attached to.<br>
+\item[\field{resources}]<br>
+=C2=A0 specifies memory regions to attach.<br>
+% TODO add number of resources?<br>
+\end{description}<br>
+<br>
+The union \field{virtio_video_resource} is defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+union virtio_video_resource {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_resource_sg_list sg_list;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_video_resource_object object;<br=
>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{sg_list}]<br>
+=C2=A0 represents a scatter-gather list. This variant can be used when the=
<br>
+=C2=A0 \field{mem_type} member of the \field{virtio_video_param_resources}=
<br>
+=C2=A0 corresponding to the queue is set to<br>
+=C2=A0 VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES, see<br>
+=C2=A0 \ref{sec:Device Types / Video Device / Device Operation / Device Op=
eration: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.<br>
+\item[\field{object}]<br>
+=C2=A0 represents an object exported from another virtio device as defined=
 in<br>
+=C2=A0 \ref{sec:Basic Facilities of a Virtio Device / Exporting Objects}.<=
br>
+=C2=A0 This variant can be used when the \field{mem_type} member of the<br=
>
+=C2=A0 \field{virtio_video_param_resources} corresponding to the queue is =
set<br>
+=C2=A0 to VIRTIO_VIDEO_MEM_TYPE_VIRTIO_OBJECT, see<br>
+=C2=A0 \ref{sec:Device Types / Video Device / Device Operation / Device Op=
eration: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.<br>
+\end{description}<br>
+<br>
+The struct \field{virtio_video_resource_sg_list} is defined as follows:<br=
>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_resource_sg_entry {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le64 addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 length;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+};<br>
+<br>
+struct virtio_video_resource_sg_list {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 num_entries;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Followed by num_entries instances of<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_video_resource_sg_entry */=
<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+Within \field{struct virtio_video_resource_sg_entry}:<br>
+<br>
+\begin{description}<br>
+\item[\field{addr}]<br>
+=C2=A0 is a guest physical address to the start of the SG entry. Must be<b=
r>
+=C2=A0 aligned to the size of physical guest pages.<br>
+\item[\field{length}]<br>
+=C2=A0 is the length of the SG entry in bytes. Must be aligned to the size=
<br>
+=C2=A0 of physical guest pages.<br>
+\end{description}<br>
+<br>
+Finally, for \field{struct virtio_video_resource_sg_list}:<br>
+<br>
+\begin{description}<br>
+\item[\field{num_entries}]<br>
+=C2=A0 is the number of \field{struct virtio_video_resource_sg_entry} inst=
ances<br>
+=C2=A0 that follow.<br>
+\end{description}<br>
+<br>
+\field{struct virtio_video_resource_object} is defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_resource_object {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 uuid[16];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[uuid]<br>
+=C2=A0 is a version 4 UUID specified by \hyperref[intro:rfc4122]{[RFC4122]=
}.<br>
+\end{description}<br>
+<br>
+The device responds with<br>
+\field{struct virtio_video_resource_attach_backing_resp}:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_resource_attach_backing_resp {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 result; /* VIRTIO_VIDEO_RESULT_* */<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{result}]<br>
+=C2=A0 is<br>
+<br>
+=C2=A0 \begin{description}<br>
+=C2=A0 \item[VIRTIO_VIDEO_RESULT_OK]<br>
+=C2=A0 =C2=A0 if the operation succeeded,<br>
+=C2=A0 \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID]<br>
+=C2=A0 =C2=A0 if the mentioned stream does not exist,<br>
+=C2=A0 \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_RESOURCE_ID]<br>
+=C2=A0 =C2=A0 if the mentioned resource does not exist,<br>
+=C2=A0 \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_ARGUMENT]<br>
+=C2=A0 =C2=A0 if \field{queue_type} or \field{resources} have an invalid v=
alue,<br>
+=C2=A0 \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION]<br>
+=C2=A0 =C2=A0 if the operation is performed at a time when it is not valid=
.<br>
+=C2=A0 \end{description}<br>
+\end{description}<br>
+<br>
+VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING can only be called during<br>
+the following times:<br>
+<br>
+\begin{itemize}<br>
+\item<br>
+=C2=A0 AFTER a VIRTIO_VIDEO_CMD_STREAM_CREATE and BEFORE invoking<br>
+=C2=A0 VIRTIO_VIDEO_CMD_RESOURCE_QUEUE for the first time on the<br>
+=C2=A0 resource,<br>
+\item<br>
+=C2=A0 AFTER successfully changing the \field{virtio_video_param_resources=
}<br>
+=C2=A0 parameter corresponding to the queue and BEFORE<br>
+=C2=A0 VIRTIO_VIDEO_CMD_RESOURCE_QUEUE is called again on the resource.<br=
>
+\end{itemize}<br>
+<br>
+This is to ensure that the device can rely on the fact that a given<br>
+resource will always point to the same memory for as long as it may be<br>
+used by the video device. For instance, a decoder may use returned<br>
+decoded frames as reference for future frames and won&#39;t overwrite the<=
br>
+backing resource of a frame that is being referenced. It is only before<br=
>
+a stream is started and after a Dynamic Parameters Change event has<br>
+occurred that we can be sure that all resources won&#39;t be used in that<=
br>
+way.<br>
+<br>
+% TODO add a requirement for the driver or the device to handle a case<br>
+% when a still referenced frame is queued again. So that it is less likely=
<br>
+% to be forgotten.<br>
+<br>
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}{=
Device Types / Video Device / Device Operation / Device Operation: Resource=
 Commands / VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}<br>
+<br>
+At any time other than the times valid for calling this command, the<br>
+device MUST return VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION.<br>
+<br>
+\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}{=
Device Types / Video Device / Device Operation / Device Operation: Resource=
 Commands / VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}<br>
+<br>
+\field{stream_id} MUST be set to a valid stream ID previously returned<br>
+by VIRTIO_VIDEO_CMD_STREAM_CREATE.<br>
+<br>
+\field{queue_type} MUST be set to a valid queue type.<br>
+<br>
+\field{resource_id} MUST be an integer inferior to the number of<br>
+resources currently allocated for the queue.<br>
+<br>
+The length of the \field{resources} array of<br>
+\field{struct virtio_video_resource_attach_backing} MUST be equal to the<b=
r>
+number of resources required by the format currently set on the queue,<br>
+as described in<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.<br>
+<br>
+\paragraph{VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}<br>
+\label{sec:Device Types / Video Device / Device Operation / Device Operati=
on: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}<br>
+<br>
+Add a resource to the device&#39;s queue.<br>
+<br>
+\begin{lstlisting}<br>
+#define VIRTIO_VIDEO_MAX_PLANES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 8<br>
+<br>
+#define VIRTIO_VIDEO_ENQUEUE_FLAG_FORCE_KEY_FRAME=C2=A0 (1 &lt;&lt; 0)<br>
+<br>
+struct virtio_video_resource_queue {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 cmd_type; /* VIRTIO_VIDEO_CMD_RESOURCE_QU=
EUE */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 stream_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 queue_type; /* VIRTIO_VIDEO_QUEUE_TYPE_* =
*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 resource_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 flags; /* Bitmask of VIRTIO_VIDEO_ENQUEUE=
_FLAG_* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le64 timestamp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 offsets[VIRTIO_VIDEO_MAX_PLANES];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 data_sizes[VIRTIO_VIDEO_MAX_PLANES];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{stream_id}]<br>
+=C2=A0 is the ID of a valid stream.<br>
+\item[\field{queue_type}]<br>
+=C2=A0 is the direction of the queue.<br>
+\item[\field{resource_id}]<br>
+=C2=A0 is the ID of the resource to be queued.<br>
+\item[\field{flags}]<br>
+=C2=A0 is a bitmask of VIRTIO_VIDEO_ENQUEUE_FLAG_* values.<br>
+<br>
+=C2=A0 \begin{description}<br>
+=C2=A0 \item[\field{VIRTIO_VIDEO_ENQUEUE_FLAG_FORCE_KEY_FRAME}]<br>
+=C2=A0 =C2=A0 The submitted frame is to be encoded as a key frame. Only va=
lid for the<br>
+=C2=A0 =C2=A0 encoder&#39;s INPUT queue.<br>
+=C2=A0 \end{description}<br>
+\item[\field{timestamp}]<br>
+=C2=A0 is an abstract sequence counter that can be used on the INPUT queue=
 for<br>
+=C2=A0 synchronization. Resources produced on the output queue will carry =
the<br>
+=C2=A0 \field{timestamp} of the first input resource they have been produc=
ed<br>
+=C2=A0 from.<br>
+% TODO take note about timestamps from V4L2 spec<br>
+\item[\field{offsets}]<br>
+=C2=A0 is the starting offset for the data in the buffer for each plane.<b=
r>
+=C2=A0 The number of planes depends on the format. Set by the driver for i=
nput<br>
+=C2=A0 resources.<br>
+\item[\field{data_sizes}]<br>
+=C2=A0 is number of data bytes used for each plane. Set by the driver for =
input<br>
+=C2=A0 resources.<br>
+\end{description}<br>
+<br>
+The device responds as described in<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Command Virtqueue}<br>
+and puts the resource in the selected queue for background processing.<br>
+<br>
+When the background processing of the resource is completed the device sen=
ds<br>
+the VIRTIO_VIDEO_DELAYED_RESP_RESOURCE_QUEUE delayed response, see<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Event Virtqueue}.<br>
+<br>
+The command-specific delayed response<br>
+\field{struct virtio_video_resource_queue_delayed_resp} is defined<br>
+as follows:<br>
+<br>
+\begin{lstlisting}<br>
+#define VIRTIO_VIDEO_DEQUEUE_FLAG_ERR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 0)<br>
+/* Encoder only */<br>
+#define VIRTIO_VIDEO_DEQUEUE_FLAG_KEY_FRAME=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt;=
 1)<br>
+#define VIRTIO_VIDEO_DEQUEUE_FLAG_P_FRAME=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt=
;&lt; 2)<br>
+#define VIRTIO_VIDEO_DEQUEUE_FLAG_B_FRAME=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt=
;&lt; 3)<br>
+<br>
+struct virtio_video_resource_queue_delayed_resp {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 queue_type; /* VIRTIO_VIDEO_QUEUE_TYPE_* =
*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 resource_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le64 timestamp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 offsets[VIRTIO_VIDEO_MAX_PLANES];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 data_sizes[VIRTIO_VIDEO_MAX_PLANES];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{queue_type}]<br>
+=C2=A0 is the direction of the queue.<br>
+\item[\field{resource_id}]<br>
+=C2=A0 is the ID of the dequeued resource.<br>
+\item[\field{flags}]<br>
+=C2=A0 is a bitmask of VIRTIO_VIDEO_DEQUEUE_FLAG_* flags.<br>
+<br>
+=C2=A0 \begin{description}<br>
+=C2=A0 \item[VIRTIO_VIDEO_DEQUEUE_FLAG_ERR]<br>
+=C2=A0 =C2=A0 is set on resources when a non-fatal processing error has ha=
ppened and<br>
+=C2=A0 =C2=A0 the data contained by the resource is likely to be corrupted=
,<br>
+=C2=A0 \item[VIRTIO_VIDEO_DEQUEUE_FLAG_KEY_FRAME]<br>
+=C2=A0 =C2=A0 is set on output resources when the resource contains an enc=
oded key<br>
+=C2=A0 =C2=A0 frame (only for encoders).<br>
+=C2=A0 \item[VIRTIO_VIDEO_DEQUEUE_FLAG_P_FRAME]<br>
+=C2=A0 =C2=A0 is set on output resources when the resource contains only d=
ifferences<br>
+=C2=A0 =C2=A0 to a previous key frame (only for encoders).<br>
+=C2=A0 \item[VIRTIO_VIDEO_DEQUEUE_FLAG_B_FRAME]<br>
+=C2=A0 =C2=A0 is set on output resources when the resource contains only t=
he<br>
+=C2=A0 =C2=A0 differences between the current frame and both the preceding=
 and<br>
+=C2=A0 =C2=A0 following key frames (only for encoders).<br>
+=C2=A0 \end{description}<br>
+\item[\field{timestamp}]<br>
+=C2=A0 is set on output resources to the \field{timestamp} value of the in=
put<br>
+=C2=A0 resource that produced the resource.<br>
+\item[\field{offsets}]<br>
+=C2=A0 is set on output resources to the starting offset for the data in t=
he<br>
+=C2=A0 buffer for each plane.<br>
+\item[\field{data_sizes}]<br>
+=C2=A0 is set on output resources to the amount of data written by the dev=
ice,<br>
+=C2=A0 for each plane.<br>
+\end{description}<br>
+<br>
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}{Device Ty=
pes / Video Device / Device Operation / Device Operation: Resource Commands=
 / VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}<br>
+<br>
+The device MUST return VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION if<br>
+VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING has not been<br>
+successfully called on the resource prior to queueing it or for an<br>
+attempt to queue a resources that is still processed in background.<br>
+<br>
+The device MUST mark resources that might contain corrupted content due to=
<br>
+an error with the VIRTIO_VIDEO_BUFFER_FLAG_ERR flag.<br>
+<br>
+For output resources, the device MUST copy the \field{timestamp}<br>
+parameter of the input resource that produced it into its response.<br>
+% TODO rephrase?<br>
+<br>
+In case of encoder, the device MUST mark each output resource with one<br>
+of VIRTIO_VIDEO_DEQUEUE_FLAG_KEY_FRAME,<br>
+VIRTIO_VIDEO_DEQUEUE_FLAG_P_FRAME, or<br>
+VIRTIO_VIDEO_DEQUEUE_FLAG_B_FRAME.<br>
+<br>
+If the processing of a resource was stopped due to a stream event, a<br>
+VIRTIO_VIDEO_CMD_STREAM_RESET, or a VIRTIO_VIDEO_CMD_STREAM_DESTROY,<br>
+the device MUST send the corresponding delayed responses with<br>
+VIRTIO_VIDEO_EVENT_FLAG_CANCELED flag set.<br>
+<br>
+\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}{Device Ty=
pes / Video Device / Device Operation / Device Operation: Resource Commands=
 / VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}<br>
+<br>
+\field{stream_id} MUST be set to a valid stream ID previously returned<br>
+by VIRTIO_VIDEO_CMD_STREAM_CREATE.<br>
+<br>
+\field{queue_type} MUST be set to a valid queue type.<br>
+<br>
+\field{resource_id} MUST be an integer inferior to the number of<br>
+resources currently allocated for the queue.<br>
+<br>
+The driver MUST account for the fact that the response to this command<br>
+might come out-of-order (i.e. after other commands sent to the device),<br=
>
+and that it can be interrupted.<br>
+<br>
+% TODO acourbot: The driver and device MUST follow requirements about<br>
+% buffer ownership explained in<br>
+% \ref{sec:Device Types / Video Device / Device Operation / Buffer lifecyc=
le}.<br>
+<br>
+\subsubsection{Device Operation: Standalone Events}<br>
+\label{sec:Device Types / Video Device / Device Operation / Device Operati=
on: Standalone Events}<br>
+<br>
+These events are caused by state changes in the device, not as a delayed<b=
r>
+response to any command.<br>
+<br>
+\paragraph{Error Event}<br>
+\label{sec:Device Types / Video Device / Device Operation / Device Operati=
on: Standalone Events / Error Event}<br>
+<br>
+The error event is sent by the device when an unrecoverable error occurs<b=
r>
+during processing a stream. The device operation is exactly the same as wh=
en<br>
+it receives a VIRTIO_VIDEO_CMD_STREAM_DESTROY command, see<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DESTROY}.<br>
+Note that this is different from dequeued resources carrying the<br>
+VIRTIO_VIDEO_DEQUEUE_FLAG_ERR flag. This flag indicates that the<br>
+particular output frame might be corrupted, but the stream still exists<br=
>
+and can recover.<br>
+<br>
+\paragraph{Dynamic Parameters Change Event}<br>
+\label{sec:Device Types / Video Device / Device Operation / Device Operati=
on: Standalone Events / Dynamic Parameters Change Event}<br>
+<br>
+A Dynamic Parameters Change (or DPC) event is sent by a decoder device whe=
n it<br>
+detects that the parameters of the stream being decoded have changed.<br>
+The device operation is exactly the same as when it receives an in band<br=
>
+VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS command at the exact same point in the<=
br>
+stream, that changes OUTPUT queue parameters, see<br>
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation=
: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.<br>
+<br>
+% TODO add QoS events and overall think about quotas. Codecs are normally<=
br>
+% limited by bandwidth. How can we accommodate this?<br>
+<br>
+\subsection{Codec-specific parameters}<br>
+\label{sec:Device Types / Video Device / Codec-specific parameters}<br>
+<br>
+The codec-specific controls follow V4L2 controls definitions, that can be<=
br>
+found in \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+Human-readable descriptions for the codec-specific V4L2 controls can be fo=
und<br>
+in \hyperref[intro:V4L2 codec controls]{V4L2 documentation}.<br>
+<br>
+\subsubsection{MPEG2}<br>
+<br>
+MPEG2 capabilities are defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+#define VIRTIO_VIDEO_MPEG2_PARAM_PROFILE=C2=A0 1=C2=A0 /* Same as V4L2_CID=
_MPEG_VIDEO_MPEG2_PROFILE */<br>
+#define VIRTIO_VIDEO_MPEG2_PARAM_LEVEL=C2=A0 =C2=A0 2=C2=A0 /* Same as V4L=
2_CID_MPEG_VIDEO_MPEG2_LEVEL */<br>
+<br>
+struct virtio_video_mpeg2_caps {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 mpeg2_params_bitmask; /* Bitmask of MASK(=
VIRTIO_VIDEO_MPEG2_PARAM_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 mpeg2_profiles_bitmask; /* Bitmask of MAS=
K(V4L2_MPEG_VIDEO_MPEG2_PROFILE_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 mpeg2_levels_bitmask; /* Bitmask of MASK(=
V4L2_MPEG_VIDEO_MPEG2_LEVEL_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{mpeg2_params_bitmask}]<br>
+=C2=A0 is a bitmask of supported MPEG2 codec parameters.<br>
+\item[\field{mpeg2_profiles_bitmask}]<br>
+=C2=A0 is a bitmask of supported MPEG2 profiles used as bit numbers, see<b=
r>
+=C2=A0 \field{enum v4l2_mpeg_video_mpeg2_profile} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\item[\field{mpeg2_levels_bitmask}]<br>
+=C2=A0 is a bitmask of supported MPEG2 levels used as bit numbers, see<br>
+=C2=A0 \field{enum v4l2_mpeg_video_mpeg2_level} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\end{description}<br>
+<br>
+MPEG2 parameters are defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_mpeg2_params {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 mpeg2_params_bitmask; /* Bitmask of MASK(=
VIRTIO_VIDEO_MPEG2_PARAM_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 mpeg2_profile; /* V4L2_MPEG_VIDEO_MPEG2_P=
ROFILE_* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 mpeg2_level; /* V4L2_MPEG_VIDEO_MPEG2_LEV=
EL_* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{mpeg2_params_bitmask}]<br>
+=C2=A0 is a bitmask of supported MPEG2 codec parameters.<br>
+\item[\field{mpeg2_profile}]<br>
+=C2=A0 is one of the supported MPEG2 profiles, see<br>
+=C2=A0 \field{enum v4l2_mpeg_video_mpeg2_profile} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\item[\field{mpeg2_level}]<br>
+=C2=A0 is one of the supported MPEG2 levels, see<br>
+=C2=A0 \field{enum v4l2_mpeg_video_mpeg2_level} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\end{description}<br>
+<br>
+\subsubsection{MPEG4}<br>
+<br>
+MPEG4 capabilities are defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+#define VIRTIO_VIDEO_MPEG4_PARAM_PROFILE=C2=A0 1=C2=A0 /* Same as V4L2_CID=
_MPEG_VIDEO_MPEG4_PROFILE */<br>
+#define VIRTIO_VIDEO_MPEG4_PARAM_LEVEL=C2=A0 =C2=A0 2=C2=A0 /* Same as V4L=
2_CID_MPEG_VIDEO_MPEG4_LEVEL */<br>
+<br>
+struct virtio_video_mpeg4_caps {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 mpeg4_params_bitmask; /* Bitmask of MASK(=
VIRTIO_VIDEO_MPEG4_PARAM_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 mpeg4_profiles_bitmask; /* Bitmask of MAS=
K(V4L2_MPEG_VIDEO_MPEG4_PROFILE_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 mpeg4_levels_bitmask; /* Bitmask of MASK(=
V4L2_MPEG_VIDEO_MPEG4_LEVEL_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{mpeg4_params_bitmask}]<br>
+=C2=A0 is a bitmask of supported MPEG4 codec parameters.<br>
+\item[\field{mpeg4_profiles_bitmask}]<br>
+=C2=A0 is a bitmask of supported MPEG4 profiles used as bit numbers, see<b=
r>
+=C2=A0 \field{enum v4l2_mpeg_video_mpeg4_profile} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\item[\field{mpeg4_levels_bitmask}]<br>
+=C2=A0 is a bitmask of supported MPEG4 levels used as bit numbers, see<br>
+=C2=A0 \field{enum v4l2_mpeg_video_mpeg4_level} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\end{description}<br>
+<br>
+MPEG4 parameters are defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_mpeg4_params {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 mpeg4_params_bitmask; /* Bitmask of MASK(=
VIRTIO_VIDEO_MPEG4_PARAM_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 mpeg4_profile; /* V4L2_MPEG_VIDEO_MPEG4_P=
ROFILE_* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 mpeg4_level; /* V4L2_MPEG_VIDEO_MPEG4_LEV=
EL_* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{mpeg4_params_bitmask}]<br>
+=C2=A0 is a bitmask of supported MPEG4 codec parameters.<br>
+\item[\field{mpeg4_profile}]<br>
+=C2=A0 is one of the supported MPEG4 profiles, see<br>
+=C2=A0 \field{enum v4l2_mpeg_video_mpeg4_profile} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\item[\field{mpeg4_level}]<br>
+=C2=A0 is one of the supported MPEG4 levels, see<br>
+=C2=A0 \field{enum v4l2_mpeg_video_mpeg4_level} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\end{description}<br>
+<br>
+\subsubsection{H.264}<br>
+<br>
+H.264 capabilities are defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+#define VIRTIO_VIDEO_H264_PARAM_PROFILE=C2=A0 1=C2=A0 /* Same as V4L2_CID_=
MPEG_VIDEO_H264_PROFILE */<br>
+#define VIRTIO_VIDEO_H264_PARAM_LEVEL=C2=A0 =C2=A0 2=C2=A0 /* Same as V4L2=
_CID_MPEG_VIDEO_H264_LEVEL */<br>
+<br>
+struct virtio_video_h264_caps {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 h264_params_bitmask; /* Bitmask of MASK(V=
IRTIO_VIDEO_H264_PARAM_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 h264_profiles_bitmask; /* Bitmask of MASK=
(V4L2_MPEG_VIDEO_H264_PROFILE_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 h264_levels_bitmask; /* Bitmask of MASK(V=
4L2_MPEG_VIDEO_H264_LEVEL_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{h264_params_bitmask}]<br>
+=C2=A0 is a bitmask of supported H.264 codec parameters.<br>
+\item[\field{h264_profiles_bitmask}]<br>
+=C2=A0 is a bitmask of supported H.264 profiles used as bit numbers, see<b=
r>
+=C2=A0 \field{enum v4l2_mpeg_video_h264_profile} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\item[\field{h264_levels_bitmask}]<br>
+=C2=A0 is a bitmask of supported H.264 levels used as bit numbers, see<br>
+=C2=A0 \field{enum v4l2_mpeg_video_h264_level} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\end{description}<br>
+<br>
+H.264 parameters are defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_h264_params {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 h264_params_bitmask; /* Bitmask of MASK(V=
IRTIO_VIDEO_H264_PARAM_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 h264_profile; /* V4L2_MPEG_VIDEO_H264_PRO=
FILE_* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 h264_level; /* V4L2_MPEG_VIDEO_H264_LEVEL=
_* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{h264_params_bitmask}]<br>
+=C2=A0 is a bitmask of supported H.264 codec parameters.<br>
+\item[\field{h264_profile}]<br>
+=C2=A0 is one of the supported H.264 profiles, see<br>
+=C2=A0 \field{enum v4l2_mpeg_video_h264_profile} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\item[\field{h264_level}]<br>
+=C2=A0 is one of the supported H.264 levels, see<br>
+=C2=A0 \field{enum v4l2_mpeg_video_h264_level} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\end{description}<br>
+<br>
+\subsubsection{HEVC}<br>
+<br>
+HEVC capabilities are defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+#define VIRTIO_VIDEO_HEVC_PARAM_PROFILE=C2=A0 1=C2=A0 /* Same as V4L2_CID_=
MPEG_VIDEO_HEVC_PROFILE */<br>
+#define VIRTIO_VIDEO_HEVC_PARAM_LEVEL=C2=A0 =C2=A0 2=C2=A0 /* Same as V4L2=
_CID_MPEG_VIDEO_HEVC_LEVEL */<br>
+<br>
+struct virtio_video_hevc_caps {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 hevc_params_bitmask; /* Bitmask of MASK(V=
IRTIO_VIDEO_HEVC_PARAM_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 hevc_profiles_bitmask; /* Bitmask of MASK=
(V4L2_MPEG_VIDEO_HEVC_PROFILE_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 hevc_levels_bitmask; /* Bitmask of MASK(V=
4L2_MPEG_VIDEO_HEVC_LEVEL_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{hevc_params_bitmask}]<br>
+=C2=A0 is a bitmask of supported HEVC codec parameters.<br>
+\item[\field{hevc_profiles_bitmask}]<br>
+=C2=A0 is a bitmask of supported HEVC profiles used as bit numbers, see<br=
>
+=C2=A0 \field{enum v4l2_mpeg_video_hevc_profile} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\item[\field{hevc_levels_bitmask}]<br>
+=C2=A0 is a bitmask of supported HEVC levels used as bit numbers, see<br>
+=C2=A0 \field{enum v4l2_mpeg_video_hevc_level} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\end{description}<br>
+<br>
+HEVC parameters are defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_hevc_params {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 hevc_params_bitmask; /* Bitmask of MASK(V=
IRTIO_VIDEO_HEVC_PARAM_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 hevc_profile; /* V4L2_MPEG_VIDEO_HEVC_PRO=
FILE_* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 hevc_level; /* V4L2_MPEG_VIDEO_HEVC_LEVEL=
_* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{hevc_params_bitmask}]<br>
+=C2=A0 is a bitmask of supported HEVC codec parameters.<br>
+\item[\field{hevc_profile}]<br>
+=C2=A0 is one of the supported HEVC profiles, see<br>
+=C2=A0 \field{enum v4l2_mpeg_video_hevc_profile} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\item[\field{hevc_level}]<br>
+=C2=A0 is one of the supported HEVC levels, see<br>
+=C2=A0 \field{enum v4l2_mpeg_video_hevc_level} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\end{description}<br>
+<br>
+\subsubsection{VP8}<br>
+<br>
+VP8 capabilities are defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+#define VIRTIO_VIDEO_VP8_PARAM_PROFILE=C2=A0 1=C2=A0 /* Same as V4L2_CID_M=
PEG_VIDEO_VP8_PROFILE */<br>
+<br>
+struct virtio_video_vp8_caps {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 vp8_params_bitmask; /* Bitmask of MASK(VI=
RTIO_VIDEO_VP8_PARAM_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 vp8_profiles_bitmask; /* Bitmask of MASK(=
V4L2_MPEG_VIDEO_VP8_PROFILE_*) */<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{vp8_params_bitmask}]<br>
+=C2=A0 is a bitmask of supported VP8 codec parameters.<br>
+\item[\field{vp8_profiles_bitmask}]<br>
+=C2=A0 is a bitmask of supported VP8 profiles used as bit numbers, see<br>
+=C2=A0 \field{enum v4l2_mpeg_video_vp8_profile} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\end{description}<br>
+<br>
+VP8 parameters are defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_vp8_params {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 vp8_params_bitmask; /* Bitmask of MASK(VI=
RTIO_VIDEO_VP8_PARAM_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 vp8_profile; /* V4L2_MPEG_VIDEO_VP8_PROFI=
LE_* */<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{vp8_params_bitmask}]<br>
+=C2=A0 is a bitmask of supported VP8 codec parameters.<br>
+\item[\field{vp8_profile}]<br>
+=C2=A0 is one of the supported VP8 profiles, see<br>
+=C2=A0 \field{enum v4l2_mpeg_video_vp8_profile} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\end{description}<br>
+<br>
+\subsubsection{VP9}<br>
+<br>
+VP9 capabilities are defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+#define VIRTIO_VIDEO_VP9_PARAM_PROFILE=C2=A0 1=C2=A0 /* Same as V4L2_CID_M=
PEG_VIDEO_VP9_PROFILE */<br>
+#define VIRTIO_VIDEO_VP9_PARAM_LEVEL=C2=A0 =C2=A0 2=C2=A0 /* Same as V4L2_=
CID_MPEG_VIDEO_VP9_LEVEL */<br>
+<br>
+struct virtio_video_vp9_caps {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 vp9_params_bitmask; /* Bitmask of MASK(VI=
RTIO_VIDEO_VP9_PARAM_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 vp9_profiles_bitmask; /* Bitmask of MASK(=
V4L2_MPEG_VIDEO_VP9_PROFILE_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 vp9_levels_bitmask; /* Bitmask of MASK(V4=
L2_MPEG_VIDEO_VP9_LEVEL_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{vp9_params_bitmask}]<br>
+=C2=A0 is a bitmask of supported VP9 codec parameters.<br>
+\item[\field{vp9_profiles_bitmask}]<br>
+=C2=A0 is a bitmask of supported VP9 profiles used as bit numbers, see<br>
+=C2=A0 \field{enum v4l2_mpeg_video_vp9_profile} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\item[\field{vp9_levels_bitmask}]<br>
+=C2=A0 is a bitmask of supported VP9 levels used as bit numbers, see<br>
+=C2=A0 \field{enum v4l2_mpeg_video_vp9_level} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\end{description}<br>
+<br>
+VP9 parameters are defined as follows:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_video_vp9_params {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 vp9_params_bitmask; /* Bitmask of MASK(VI=
RTIO_VIDEO_VP9_PARAM_*) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 vp9_profile; /* V4L2_MPEG_VIDEO_VP9_PROFI=
LE_* */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le32 vp9_level; /* V4L2_MPEG_VIDEO_VP9_LEVEL_*=
 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 padding[4];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+\begin{description}<br>
+\item[\field{vp9_params_bitmask}]<br>
+=C2=A0 is a bitmask of supported VP9 codec parameters.<br>
+\item[\field{vp9_profile}]<br>
+=C2=A0 is one of the supported VP9 profiles, see<br>
+=C2=A0 \field{enum v4l2_mpeg_video_vp9_profile} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\item[\field{vp9_level}]<br>
+=C2=A0 is one of the supported VP9 levels, see<br>
+=C2=A0 \field{enum v4l2_mpeg_video_vp9_level} in<br>
+=C2=A0 \hyperref[intro:V4L2 controls]{V4L2 controls header}.<br>
+\end{description}<br>
diff --git a/device-types/video/device-conformance.tex b/device-types/video=
/device-conformance.tex<br>
new file mode 100644<br>
index 0000000..8aaf744<br>
--- /dev/null<br>
+++ b/device-types/video/device-conformance.tex<br>
@@ -0,0 +1,22 @@<br>
+\conformance{\subsection}{Video Device Conformance}<br>
+\label{sec:Conformance / Device Conformance / Video Device Conformance}<br=
>
+<br>
+A video device MUST conform to the following normative statements:<br>
+<br>
+\begin{itemize}<br>
+\item \ref{devicenormative:Device Types / Video Device / Feature bits}<br>
+\item \ref{devicenormative:Device Types / Video Device / Device configurat=
ion layout}<br>
+\item \ref{devicenormative:Device Types / Video Device / Device Operation =
/ Device Operation: Command Virtqueue}<br>
+\item \ref{devicenormative:Device Types / Video Device / Device Operation =
/ Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}<b=
r>
+\item \ref{devicenormative:Device Types / Video Device / Device Operation =
/ Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / =
VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Format dependencies}<br>
+\item \ref{devicenormative:Device Types / Video Device / Device Operation =
/ Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / =
VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format capabilities}<br>
+\item \ref{devicenormative:Device Types / Video Device / Device Operation =
/ Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / =
VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Resource capabilities}<br>
+\item \ref{devicenormative:Device Types / Video Device / Device Operation =
/ Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / =
VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Bitrates}<br>
+\item \ref{devicenormative:Device Types / Video Device / Device Operation =
/ Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_CREATE}<br>
+\item \ref{devicenormative:Device Types / Video Device / Device Operation =
/ Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DESTROY}<br>
+\item \ref{devicenormative:Device Types / Video Device / Device Operation =
/ Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}<b=
r>
+\item \ref{devicenormative:Device Types / Video Device / Device Operation =
/ Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DRAIN}<br>
+\item \ref{devicenormative:Device Types / Video Device / Device Operation =
/ Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_RESET}<br>
+\item \ref{devicenormative:Device Types / Video Device / Device Operation =
/ Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BA=
CKING}<br>
+\item \ref{devicenormative:Device Types / Video Device / Device Operation =
/ Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}<br=
>
+\end{itemize}<br>
diff --git a/device-types/video/driver-conformance.tex b/device-types/video=
/driver-conformance.tex<br>
new file mode 100644<br>
index 0000000..1fe8473<br>
--- /dev/null<br>
+++ b/device-types/video/driver-conformance.tex<br>
@@ -0,0 +1,16 @@<br>
+\conformance{\subsection}{Video Driver Conformance}<br>
+\label{sec:Conformance / Driver Conformance / Video Driver Conformance}<br=
>
+<br>
+A video driver MUST conform to the following normative statements:<br>
+<br>
+\begin{itemize}<br>
+\item \ref{drivernormative:Device Types / Video Device / Feature bits}<br>
+\item \ref{drivernormative:Device Types / Video Device / Device Operation =
/ Device Operation: Command Virtqueue}<br>
+\item \ref{drivernormative:Device Types / Video Device / Device Operation =
/ Device Operation: Event Virtqueue}<br>
+\item \ref{drivernormative:Device Types / Video Device / Device Operation =
/ Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DESTROY}<br>
+\item \ref{drivernormative:Device Types / Video Device / Device Operation =
/ Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}<b=
r>
+\item \ref{drivernormative:Device Types / Video Device / Device Operation =
/ Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DRAIN}<br>
+\item \ref{drivernormative:Device Types / Video Device / Device Operation =
/ Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_RESET}<br>
+\item \ref{drivernormative:Device Types / Video Device / Device Operation =
/ Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BA=
CKING}<br>
+\item \ref{drivernormative:Device Types / Video Device / Device Operation =
/ Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}<br=
>
+\end{itemize}<br>
diff --git a/introduction.tex b/introduction.tex<br>
index b7155bf..b378883 100644<br>
--- a/introduction.tex<br>
+++ b/introduction.tex<br>
@@ -101,6 +101,15 @@ \section{Normative References}\label{sec:Normative Ref=
erences}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \phantomsection\label{intro:SEC1}\textbf{[SEC1]=
} &amp;<br>
=C2=A0 =C2=A0 =C2=A0Standards for Efficient Cryptography Group(SECG), ``SEC=
1: Elliptic Cureve Cryptography&#39;&#39;, Version 1.0, September 2000.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \newline\url{<a href=3D"https://www.secg.org/se=
c1-v2.pdf" rel=3D"noreferrer" target=3D"_blank">https://www.secg.org/sec1-v=
2.pdf</a>}\\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0\phantomsection\label{intro:V4L2}\textbf{[V4L2]=
} &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0Linux V4L2 interface.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0\newline\url{<a href=3D"https://git.kernel.org/=
pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/videode=
v2.h" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/pub/scm/l=
inux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/videodev2.h</a>}=
\\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0\phantomsection\label{intro:V4L2 controls}\text=
bf{[V4L2 Controls]} &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0Linux V4L2 controls definitions.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0\newline\url{<a href=3D"https://git.kernel.org/=
pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/v4l2-co=
ntrols.h" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/pub/s=
cm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/v4l2-control=
s.h</a>}\\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0\phantomsection\label{intro:DRM formats}\textbf=
{[DRM Formats]} &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0Linux DRM format definitions.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0\newline\url{<a href=3D"https://git.kernel.org/=
pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/drm/drm_fourc=
c.h" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/pub/scm/li=
nux/kernel/git/torvalds/linux.git/tree/include/uapi/drm/drm_fourcc.h</a>}\\=
<br>
<br>
=C2=A0\end{longtable}<br>
<br>
@@ -110,6 +119,18 @@ \section{Non-Normative References}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \phantomsection\label{intro:Virtio PCI Draft}\t=
extbf{[Virtio PCI Draft]} &amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Virtio PCI Draft Specification<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \newline\url{<a href=3D"http://ozlabs.org/~rust=
y/virtio-spec/virtio-0.9.5.pdf" rel=3D"noreferrer" target=3D"_blank">http:/=
/ozlabs.org/~rusty/virtio-spec/virtio-0.9.5.pdf</a>}\\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0\phantomsection\label{intro:V4L2 compressed}\te=
xtbf{[V4L2 compressed formats]} &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0Detailed descriptions of V4L2 compressed format=
s<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0\newline\url{<a href=3D"https://git.kernel.org/=
pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/userspace-ap=
i/media/v4l/pixfmt-compressed.rst" rel=3D"noreferrer" target=3D"_blank">htt=
ps://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Docume=
ntation/userspace-api/media/v4l/pixfmt-compressed.rst</a>}\\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0\phantomsection\label{intro:V4L2 RGB}\textbf{[V=
4L2 RGB formats]} &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0Detailed descriptions of V4L2 RGB formats<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0\newline\url{<a href=3D"https://git.kernel.org/=
pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/userspace-ap=
i/media/v4l/pixfmt-rgb.rst" rel=3D"noreferrer" target=3D"_blank">https://gi=
t.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation=
/userspace-api/media/v4l/pixfmt-rgb.rst</a>}\\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0\phantomsection\label{intro:V4L2 YUV}\textbf{[V=
4L2 planar YUV formats]} &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0Detailed descriptions of V4L2 planar YUV format=
s<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0\newline\url{<a href=3D"https://git.kernel.org/=
pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/userspace-ap=
i/media/v4l/pixfmt-yuv-planar.rst" rel=3D"noreferrer" target=3D"_blank">htt=
ps://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Docume=
ntation/userspace-api/media/v4l/pixfmt-yuv-planar.rst</a>}\\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0\phantomsection\label{intro:V4L2 codec controls=
}\textbf{[V4L2 codec controls]} &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0Detailed descriptions of V4L2 controls<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0\newline\url{<a href=3D"https://git.kernel.org/=
pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/userspace-ap=
i/media/v4l/ext-ctrls-codec.rst" rel=3D"noreferrer" target=3D"_blank">https=
://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Document=
ation/userspace-api/media/v4l/ext-ctrls-codec.rst</a>}\\<br>
=C2=A0\end{longtable}<br>
<br>
=C2=A0\section{Terminology}\label{Terminology}<br>
-- <br>
2.34.1<br></blockquote><div><br></div><div>BR,</div><div>Albert=C2=A0</div>=
</div></div>

--0000000000009988fb05ffd2c581--

