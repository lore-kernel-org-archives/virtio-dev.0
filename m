Return-Path: <virtio-dev-return-8933-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4148E98646D
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 Nov 2021 09:37:42 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210120083143.766189-1-acourbot@chromium.org>
References: <20210120083143.766189-1-acourbot@chromium.org>
Date: Wed, 10 Nov 2021 10:37:01 +0100
Message-ID: <874k8k9wsi.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [RFC PATCH v5] virtio-video: Add virtio video
 device specification
Content-Type: text/plain
To: Alexandre Courbot <acourbot@chromium.org>, virtio-dev@lists.oasis-open.org
Cc: linux-media@vger.kernel.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, dstaessens@chromium.org, egranata@google.com, kraxel@redhat.com, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com, kiran.pawar@opensynergy.com, enric.balletbo@collabora.com, alex.bennee@linaro.org, Matti.Moell@opensynergy.com, Keiichi Watanabe <keiichiw@chromium.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 20 2021, Alexandre Courbot <acourbot@chromium.org> wrote:

> From: Keiichi Watanabe <keiichiw@chromium.org>
>
> The virtio video encoder and decoder devices are virtual devices that
> support video encoding and decoding respectively. Although they are
> different devices, they use the same protocol.
>
> Signed-off-by: Dmitry Sepp <dmitry.sepp@opensynergy.com>
> Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
> Here is the new revision of the virtio-video specification. Compared to
> v4 some extra simplification work has been performed, and all stream
> settings are now consolidated under the parameters. Hopefully this can
> be used as the basis to write a new version of the Linux driver and
> virtual device, or maybe even to drop that RFC tag! :)

It seems that there has not been any followup on this, has there?

I assume that there is still interest (after all, the ids have already
been reservered); let me add some quick comments from the spec pov (I
don't really know anything about how video is supposed to work here.)

>
> Full PDF: https://drive.google.com/file/d/1Lqjpcntj6ydLtrHPhbMbvq0oVIevGatj/view?usp=sharing
> Only video section: https://drive.google.com/file/d/1dGzYGCV-xrO-AYqMbMsHBrJh_CvLDLMA/view?usp=sharing
>
>  content.tex                       |    1 +
>  images/video-buffer-lifecycle.dot |   15 +
>  make-setup-generated.sh           |    9 +
>  virtio-video.tex                  | 1308 +++++++++++++++++++++++++++++
>  4 files changed, 1333 insertions(+)
>  create mode 100644 images/video-buffer-lifecycle.dot
>  create mode 100644 virtio-video.tex
>

(...)

> diff --git a/virtio-video.tex b/virtio-video.tex
> new file mode 100644
> index 0000000..9adac0d
> --- /dev/null
> +++ b/virtio-video.tex
> @@ -0,0 +1,1308 @@
> +\section{Video Device}\label{sec:Device Types / Video Device}
> +
> +The virtio video encoder and decoder devices are virtual devices that support
> +video encoding and decoding, respectively. Despite being different devices, they
> +use the same protocol.
> +
> +% TODO: be more precise about the sync or async nature of commands/responses.

Should that go into this section, or rather into the operation section below?

> +
> +\subsection{Device ID}
> +\label{sec:Device Types / Video Device / Device ID}
> +
> +\begin{description}
> +\item[30] encoder device
> +\item[31] decoder device
> +\end{description}
> +
> +\subsection{Virtqueues}
> +\label{sec:Device Types / Video Device / Virtqueues}
> +
> +\begin{description}
> +\item[0] commandq - queue for driver commands and device responses to these
> +  commands.
> +\item[1] eventq - queue for events sent by the device to the driver.
> +\end{description}
> +
> +\subsection{Feature bits}
> +\label{sec:Device Types / Video Device / Feature bits}
> +
> +\begin{description}
> +\item[VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES (0)] Guest pages can be used as the
> +  backing memory of video buffers.
> +\item[VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG (1)] The device can use non-contiguous
> +  memory for video buffers. Without this flag, the driver and device MUST use
> +  video buffers that are contiguous for the device.

MUST and friends are not supposed to be used outside of normative
sections; statements that the driver and the device MUST use contiguous
buffers need to go into a driver and a device normative section,
respectively.

Also, any normative statements need to be referenced in conformance.tex.

> +\item[VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT (2)] Objects exported by another
> +  virtio device can be used as the backing memory of video buffers.
> +\end{description}
> +
> +The device MUST present at least one of VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES or
> +VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT, since the absence of both bits would mean
> +that no memory can be used at all for buffers.

This should go into a device normative section for device
intitialization; there probably also should be a driver normative
statement that the driver needs to negotiate at least one of those
features (I assume they are not mutually exclusive?)

> +
> +\subsection{Device configuration layout}
> +\label{sec:Device Types / Video Device / Device configuration layout}
> +
> +Video device configuration uses the following layout structure:
> +
> +\begin{lstlisting}
> +struct virtio_video_config {
> +        le32 version;
> +        le32 caps_length;
> +};
> +\end{lstlisting}
> +\begin{description}
> +\item[\field{version}] is the protocol version that the device understands. The
> +  device MUST set this to 0.

The MUST statement needs to go into a device normative section.

Also, is this supposed to be read-only by the driver?

> +\item[\field{caps_length}] is the length in bytes of a device-writable
> +  descriptor that can receive the response of
> +  VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS. The device MUST set it to a sufficiently
> +  large value.

Same here.

> +\end{description}
> +
> +\subsection{Device Initialization}
> +\label{sec:Device Types / Video Device / Device Initialization}
> +
> +\devicenormative{\subsubsection}{Device Initialization}{Device Types /
> +  Video Device / Device Initialization}
> +
> +The driver SHOULD query the device capabilities using the
> +VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS command.

The device initialization section should probably be a bit more detailed
(i.e. negotiate features -> set up commandq/eventq -> read caps length
from config space -> query capabilities) outside of the normantive
section.

> +
> +\subsection{General Device Operation}
> +\label{sec:Device Types / Video Device / Device Operation}

Maybe start with a sentence that the driver sends commands via the
commandq, just to be a bit more explicit?

> +
> +The driver requests a new stream to be created using
> +VIRTIO_VIDEO_CMD_STREAM_CREATE.
> +
> +It then invokes VIRTIO_VIDEO_CMD_STREAM_GET_PARAMS to retrieve the default
> +parameters of the stream, modifies them to fit its needs using the device
> +capabilities information queried during initialization, and calls
> +VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS to apply them. The device might change the
> +requested parameters to suit its own limitation, so the driver MUST check that
> +the applied parameters are still acceptable, and keep adjusting them with
> +subsequent calls to VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS until a mutually
> +satisfying configuration is found.
> +
> +Each stream has one input and one output queue. The input queue accepts buffers
> +in the configured input format (e.g. bitstream format for a decoder) and returns
> +them once they are done being processed. The output queue accepts buffers in the
> +configured output format (e.g. image format for a decoder) and will write the
> +result of the decoding or encoding operation to them, i.e. a frame for a
> +decoder, or a chunk of encoded stream for an encoder. There is no direct 1:1
> +relationship between input and output buffers, meaning that queueing one input
> +buffer can result in zero, one, or more output buffers to be emitted. The driver
> +can think of the queues as operating independently from each other.
> +
> +Once the stream is configured, the driver attaches backing memory to buffer
> +resources using VIRTIO_VIDEO_CMD_RESOURCE_ATTACH, and queues them using
> +VIRTIO_VIDEO_CMD_RESOURCE_QUEUE. The device will respond once the buffer is
> +processed, which then allows the driver to queue that buffer again.
> +
> +The driver has control over the stream: it can request for all queued input
> +buffers so far to be processed and receive a notification when they are (useful
> +at the end of a stream) using VIRTIO_VIDEO_CMD_STREAM_DRAIN, or abandon all
> +pending operations (in order to, say, seek to a different point) with
> +VIRTIO_VIDEO_CMD_STREAM_QUEUE_CLEAR.
> +
> +Sometimes the device will detect events that require intervention from the
> +driver and signal them. One such event is

"signal them via the eventq." ?

> +VIRTIO_VIDEO_EVENT_DECODER_RESOLUTION_CHANGED for a decoder, meaning that the
> +resolution of the stream has changed, and that the driver might need to
> +reallocate the backing memory for its buffers.
> +
> +Once a stream is completed, it can be closed using
> +VIRTIO_VIDEO_CMD_STREAM_DESTROY.
> +
> +The remainder of this section describes all the commands and events mentioned
> +above.
> +
> +\subsubsection{Command Virtqueue}
> +
> +The command virtqueue is used for the driver to send commands to the device, and
> +receive the device's response. Commands MUST be written by the driver and their
> +responses MUST be written by the device in the next device-writable descriptor.

Ah, here is the statement I had been looking for. Maybe reorder this a
bit?

Also, the MUST statement needs to be in a normative section.

> +
> +Different structure layouts are used for each command and response. A command
> +structure starts with the requested command code, defined as follows:
> +\begin{lstlisting}
> +enum virtio_video_cmd_type {
> +        /* Global */
> +        VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS = 0x100,
> +
> +        /* Stream */
> +        VIRTIO_VIDEO_CMD_STREAM_CREATE = 0x200,
> +        VIRTIO_VIDEO_CMD_STREAM_DESTROY,
> +        VIRTIO_VIDEO_CMD_STREAM_GET_PARAMS,
> +        VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS,
> +        VIRTIO_VIDEO_CMD_STREAM_DRAIN,
> +
> +        /* Queue */
> +        VIRTIO_VIDEO_CMD_QUEUE_CLEAR = 0x300,
> +
> +        /* Resource*/
> +        VIRTIO_VIDEO_CMD_RESOURCE_ATTACH = 0x400,
> +        VIRTIO_VIDEO_CMD_RESOURCE_QUEUE,
> +};
> +\end{lstlisting}

I think all those enums need to be explicit #defines (we don't define
what 'enum's are supposed to look like).

> +
> +A response structure starts with the result of the requested command, defined as
> +follows:
> +\begin{lstlisting}
> +enum virtio_video_result {
> +         /* Success */
> +         VIRTIO_VIDEO_RESULT_OK = 0x000,
> +
> +         /* Error */
> +         VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION = 0x100,
> +         VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID,
> +         VIRTIO_VIDEO_RESULT_ERR_INVALID_RESOURCE_ID,
> +         VIRTIO_VIDEO_RESULT_ERR_INVALID_ARGUMENT,
> +         VIRTIO_VIDEO_RESULT_ERR_CANCELED,
> +         VIRTIO_VIDEO_RESULT_ERR_OUT_OF_MEMORY,
> +};
> +\end{lstlisting}

Same here.

> +
> +For response structures carrying an error code, the rest of the structure is
> +considered invalid and must be ignored by the driver. Only response structures
> +carrying VIRTIO_VIDEO_RESULT_OK shall be examined further.
> +

(...)

I'll stop here for now.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

