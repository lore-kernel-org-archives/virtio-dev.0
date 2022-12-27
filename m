Return-Path: <virtio-dev-return-10374-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CA2C4986320
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Dec 2022 07:31:24 +0000 (UTC)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org> <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com>
In-Reply-To: <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Tue, 27 Dec 2022 16:31:07 +0900
Message-ID: <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
Subject: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset="UTF-8"
To: Alexander Gordeev <alexander.gordeev@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=C3=B6ll?= <Matti.Moell@opensynergy.com>, Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Bart=C5=82omiej_Grzesik?= <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Alexander,


On Tue, Dec 20, 2022 at 1:59 AM Alexander Gordeev
<alexander.gordeev@opensynergy.com> wrote:
>
> Hello Alexandre,
>
> Thanks for the update. Please check my comments below.
> I'm new to the virtio video spec development, so I may lack some
> historic perspective. I would gladly appreciate pointing me to some
> older emails explaining decisions, that I might not understand. I hope
> to read through all of them later. Overall I have a lot of experience in
> the video domain and in virtio video device development in Opsy, so I
> hope, that my comments are relevant and useful.

Cornelia provided links to the previous versions (thanks!). Through
these revisions we tried different approaches, and the more we
progress the closer we are getting to the V4L2 stateful
decoder/encoder interface.

This is actually the point where I would particularly be interested in
having your feedback, since you probably have noticed the similarity.
What would you think about just using virtio as a transport for V4L2
ioctls (virtio-fs does something similar with FUSE), and having the
host emulate a V4L2 decoder or encoder device in place of this (long)
specification? I am personally starting to think this is could be a
better and faster way to get us to a point where both spec and guest
drivers are merged. Moreover this would also open the way to support
other kinds of V4L2 devices like simple cameras - we would just need
to allocate new device IDs for these and would be good to go.

This probably means a bit more work on the device side, since this
spec is tailored for the specific video codec use-case and V4L2 is
more generic, but also less spec to maintain and more confidence that
things will work as we want in the real world. On the other hand, the
device would also become simpler by the fact that responses to
commands could not come out-of-order as they currently do. So at the
end of the day I'm not even sure this would result in a more complex
device.

> > +\begin{lstlisting}
> > +/* Device */
> > +#define VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS       0x100
> > +
> > +/* Stream */
> > +#define VIRTIO_VIDEO_CMD_STREAM_CREATE           0x200
> > +#define VIRTIO_VIDEO_CMD_STREAM_DESTROY          0x201
>
> Is this gap in numbers intentional? It would be great to remove it to
> simplify boundary checks.

This is to allow commands of the same family to stay close to one
another. I'm not opposed to removing the gap, it just means that
commands may end up being a bit all over the place if we extend the
protocol.

> > +VIRTIO\_VIDEO\_RESULT\_OK.
> > +
> > +\subsubsection{Device Operation: Device Commands}\label{sec:Device Types / Video Device / Device Operation / Device Operation: Device Commands}
> > +
> > +Device capabilities are retrieved using the
> > +VIRTIO\_VIDEO\_CMD\_DEVICE\_QUERY\_CAPS command, which returns arrays of
> > +formats supported by the input and output queues.
> > +
> > +\paragraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}\label{sec:Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}
> > +
> > +Retrieve device capabilities.
> > +
> > +The driver sends this command with
> > +\field{struct virtio_video_device_query_caps}:
> > +
> > +\begin{lstlisting}
> > +struct virtio_video_device_query_caps {
> > +        le32 cmd_type; /* VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS */
> > +};
> > +\end{lstlisting}
> > +
> > +The device responds with
> > +\field{struct virtio_video_device_query_caps_resp}:
> > +
> > +\begin{lstlisting}
> > +struct virtio_video_device_query_caps_resp {
> > +        le32 result; /* VIRTIO_VIDEO_RESULT_* */
> > +        le32 num_bitstream_formats;
> > +        le32 num_image_formats;
> > +        /**
> > +         * Followed by
> > +         * struct virtio_video_bitstream_format_desc bitstream_formats[num_bitstream_formats];
> > +         */
> > +        /**
> > +         * Followed by
> > +         * struct virtio_video_image_format_desc image_formats[num_image_formats]
> > +         */
> > +};
>
> struct virtio_video_bitstream_format_desc and struct
> virtio_video_image_format_desc are not declared anywhere.

Oops, nice catch.

> > +\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_DRAIN}{Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DRAIN}
> > +
> > +\field{cmd_type} MUST be set to VIRTIO\_VIDEO\_CMD\_STREAM\_DRAIN by the
> > +driver.
> > +
> > +\field{stream_id} MUST be set to a valid stream ID previously returned
> > +by VIRTIO\_VIDEO\_CMD\_STREAM\_CREATE.
> > +
> > +The driver MUST keep queueing output resources until it gets the
> > +response to this command. Failure to do so may result in the device
> > +stalling as it waits for output resources to write into.
> > +
> > +The driver MUST account for the fact that the response to this command
> > +might come out-of-order (i.e.~after other commands sent to the device),
> > +and that it can be interrupted.
>
> The driver MUST send a DRAIN command when it doesn't have any input,
> right? Otherwise, there is no way to receive all the decoded buffers
> back, if the codec just keeps some of them waiting for more input.

Good point, a DRAIN should be mandatory to ensure all the submitted
work has been processed and the output made available by the device.

> > +
> > +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_DRAIN}{Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DRAIN}
> > +
> > +Before the device sends the response, it MUST process and respond to all
> > +the VIRTIO\_VIDEO\_CMD\_RESOURCE\_QUEUE commands on the INPUT queue that
> > +were sent before the drain command, and make all the corresponding
> > +output resources available to the driver by responding to their
> > +VIRTIO\_VIDEO\_CMD\_RESOURCE\_QUEUE command.
>
> Unfortunately I don't see much details about the OUTPUT queue. What if
> the driver queues new output buffers, as it must do, fast enough? Looks
> like a valid implementation of the DRAIN command might never send a
> response in this case, because the only thing it does is replying to
> VIRTIO_VIDEO_CMD_RESOURCE_QUEUE commands on the OUTPUT queue. I guess,
> it is better to specify what happens. I think the device should respond
> to a certain amount of OUTPUT QUEUE commands until there is an end of
> stream condition. Then it should respond to DRAIN command. What happens
> with the remaining queued output buffers is a question to me: should
> they be cancelled or not?

If I understand correctly this should not be a problem. Replies to
commands can come out-of-order, so the reply to DRAIN can come as soon
as the command is completed, regardless of how many output buffers we
have queued at that moment. The queued output buffers can also remain
queued in prediction for the next sequence, if any - if it has the
same resolution as the previous one, then the queued output buffers
can be used. If it doesn't then a resolution change event will be
produced and the driver will process it.

> > +
> > +While the device is processing the command, it MUST return
> > +VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_OPERATION to the
> > +VIRTIO\_VIDEO\_CMD\_STREAM\_DRAIN command.
>
> Should the device stop accepting input too?

There should be no problem with the device accepting (and even
processing) input for the next sequence, as long as it doesn't make
its result available before the response to the DRAIN command.

> > +
> > +If the command is interrupted due to a VIRTIO\_VIDEO\_CMD\_STREAM\_STOP
> > +or VIRTIO\_VIDEO\_CMD\_STREAM\_DESTROY operation, the device MUST
> > +respond with VIRTIO\_VIDEO\_RESULT\_ERR\_CANCELED.
> > +
> > +\paragraph{VIRTIO_VIDEO_CMD_STREAM_STOP}\label{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_STOP}
> > +
>
> I don't like this command to be called "stop". When I see a "stop"
> command, I expect to see a "start" command as well. My personal
> preference would be "flush" or "reset".

Fair enough, let me rename this to RESET (which was the name used in a
previous revision for a somehow-similar command).

> > +};
> > +\end{lstlisting}
> > +
> > +\begin{description}
> > +\item[\field{result}]
> > +is
> > +
> > +\begin{description}
> > +\item[VIRTIO\_VIDEO\_RESULT\_OK]
> > +if the operation succeeded,
> > +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_STREAM\_ID]
> > +if the requested stream does not exist,
> > +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_ARGUMENT]
> > +if the \field{param_type} argument is invalid for the device,
> > +\end{description}
> > +\item[\field{param}]
> > +is the value of the requested parameter, if \field{result} is
> > +VIRTIO\_VIDEO\_RESULT\_OK.
> > +\end{description}
> > +
> > +\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_GET_PARAM}{Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_GET_PARAM}
> > +
> > +\field{cmd_type} MUST be set to VIRTIO\_VIDEO\_CMD\_STREAM\_GET\_PARAM
> > +by the driver.
> > +
> > +\field{stream_id} MUST be set to a valid stream ID previously returned
> > +by VIRTIO\_VIDEO\_CMD\_STREAM\_CREATE.
> > +
> > +\field{param_type} MUST be set to a parameter type that is valid for the
> > +device.
>
> The device requirements are missing for GET_PARAMS.

There aren't any beyond returning the requested parameter or an error code.

> > +
> > +\paragraph{VIRTIO_VIDEO_CMD_STREAM_SET_PARAM}\label{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAM}
> > +
> > +Write the value of a parameter of the given stream, and return the value
> > +actually set by the device. Available parameters depend on the device
> > +type and are listed in
> > +\ref{sec:Device Types / Video Device / Parameters}.
> > +
> > +\begin{lstlisting}
> > +struct virtio_video_stream_set_param {
> > +        le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_SET_PARAM */
> > +        le32 stream_id;
> > +        le32 param_type; /* VIRTIO_VIDEO_PARAMS_* */
> > +        u8 padding[4];
> > +        union virtio_video_stream_params param;
> > +}
> > +\end{lstlisting}
> > +
> > +\begin{description}
> > +\item[\field{stream_id}]
> > +is the ID of the stream we want to set a parameter for.
> > +\item[\field{param_type}]
> > +is one of the VIRTIO\_VIDEO\_PARAMS\_* values indicating the parameter
> > +we want to set.
> > +\end{description}
> > +
> > +The device responds with \field{struct virtio_video_stream_param_resp}:
> > +
> > +\begin{lstlisting}
> > +struct virtio_video_stream_param_resp {
> > +        le32 result; /* VIRTIO_VIDEO_RESULT_* */
> > +        union virtio_video_stream_params param;
>
> I'd prefer to have param_type in the response too for safety.

Done.

> > +};
> > +\end{lstlisting}
> > +
> > +Within \field{struct virtio_video_resource_sg_entry}:
> > +
> > +\begin{description}
> > +\item[\field{addr}]
> > +is a guest physical address to the start of the SG entry.
> > +\item[\field{length}]
> > +is the length of the SG entry.
> > +\end{description}
>
> I think having explicit page alignment requirements here would be great.

This may be host-dependent, maybe we should have a capability field so
it can provide this information?

> > +
> > +Finally, for \field{struct virtio_video_resource_sg_list}:
> > +
> > +\begin{description}
> > +\item[\field{num_entries}]
> > +is the number of \field{struct virtio_video_resource_sg_entry} instances
> > +that follow.
> > +\end{description}
> > +
> > +\field{struct virtio_video_resource_object} is defined as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_video_resource_object {
> > +        u8 uuid[16];
> > +};
> > +\end{lstlisting}
> > +
> > +\begin{description}
> > +\item[uuid]
> > +is a version 4 UUID specified by \hyperref[intro:rfc4122]{[RFC4122]}.
> > +\end{description}
> > +
> > +The device responds with
> > +\field{struct virtio_video_resource_attach_backing_resp}:
> > +
> > +\begin{lstlisting}
> > +struct virtio_video_resource_attach_backing_resp {
> > +        le32 result; /* VIRTIO_VIDEO_RESULT_* */
> > +};
> > +\end{lstlisting}
> > +
> > +\begin{description}
> > +\item[\field{result}]
> > +is
> > +
> > +\begin{description}
> > +\item[VIRTIO\_VIDEO\_RESULT\_OK]
> > +if the operation succeeded,
> > +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_STREAM\_ID]
> > +if the mentioned stream does not exist,
> > +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_ARGUMENT]
> > +if \field{queue_type}, \field{resource_id}, or \field{resources} have an
> > +invalid value,
> > +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_OPERATION]
> > +if the operation is performed at a time when it is non-valid.
> > +\end{description}
> > +\end{description}
> > +
> > +VIRTIO\_VIDEO\_CMD\_RESOURCE\_ATTACH\_BACKING can only be called during
> > +the following times:
> > +
> > +\begin{itemize}
> > +\item
> > +  AFTER a VIRTIO\_VIDEO\_CMD\_STREAM\_CREATE and BEFORE invoking
> > +  VIRTIO\_VIDEO\_CMD\_RESOURCE\_QUEUE for the first time on the
> > +  resource,
> > +\item
> > +  AFTER successfully changing the \field{virtio_video_params_resources}
> > +  parameter corresponding to the queue and BEFORE
> > +  VIRTIO\_VIDEO\_CMD\_RESOURCE\_QUEUE is called again on the resource.
> > +\end{itemize}
> > +
> > +This is to ensure that the device can rely on the fact that a given
> > +resource will always point to the same memory for as long as it may be
> > +used by the video device. For instance, a decoder may use returned
> > +decoded frames as reference for future frames and won't overwrite the
> > +backing resource of a frame that is being referenced. It is only before
> > +a stream is started and after a Dynamic Resolution Change event has
> > +occurred that we can be sure that all resources won't be used in that
> > +way.
>
> The mentioned scenario about the referenced frames looks
> somewhatreasonable, but I wonder how exactly would that work in practice.

Basically the guest need to make sure the backing memory remains
available and unwritten until the conditions mentioned above are met.
Or is there anything unclear in this description?

> > +
> > +\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}{Device Types / Video Device / Device Operation / Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}
> > +
> > +\field{cmd_type} MUST be set to
> > +VIRTIO\_VIDEO\_CMD\_RESOURCE\_ATTACH\_BACKING by the driver.
> > +
> > +\field{stream_id} MUST be set to a valid stream ID previously returned
> > +by VIRTIO\_VIDEO\_CMD\_STREAM\_CREATE.
> > +
> > +\field{queue_type} MUST be set to a valid queue type.
> > +
> > +\field{resource_id} MUST be an integer inferior to the number of
> > +resources currently allocated for the queue.
> > +
> > +The length of the \field{resources} array of
> > +\field{struct virtio_video_resource_attach_backing} MUST be equal to the
> > +number of resources required by the format currently set on the queue,
> > +as described in
> > +\ref{sec:Device Types / Video Device / Supported formats}.
> > +
> > +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}{Device Types / Video Device / Device Operation / Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}
> > +
> > +At any time other than the times valid for calling this command, the
> > +device MUST return VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_OPERATION.
> > +
> > +\paragraph{VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}\label{sec:Device Types / Video Device / Device Operation / Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}
> > +
> > +Add a resource to the device's queue.
> > +
> > +\begin{lstlisting}
> > +#define VIRTIO_VIDEO_MAX_PLANES                    8
> > +
> > +#define VIRTIO_VIDEO_ENQUEUE_FLAG_FORCE_KEY_FRAME  (1 << 0)
> > +
> > +struct virtio_video_resource_queue {
> > +        le32 cmd_type; /* VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING */
>
> s/VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING/VIRTIO_VIDEO_CMD_RESOURCE_QUEUE/
>
>
> > +        le32 stream_id;
> > +        le32 queue_type; /* VIRTIO_VIDEO_QUEUE_TYPE_* */
> > +        le32 resource_id;
> > +        le32 flags; /* Bitmask of VIRTIO_VIDEO_ENQUEUE_FLAG_* */
> > +        u8 padding[4];
> > +        le64 timestamp;
> > +        le32 data_sizes[VIRTIO_VIDEO_MAX_PLANES];
> > +};
> > +\end{lstlisting}
> > +
> > +\begin{description}
> > +\item[\field{stream_id}]
> > +is the ID of a valid stream.
> > +\item[\field{queue_type}]
> > +is the direction of the queue.
> > +\item[\field{resource_id}]
> > +is the ID of the resource to be queued.
> > +\item[\field{flags}]
> > +is a bitmask of VIRTIO\_VIDEO\_ENQUEUE\_FLAG\_* values.
> > +
> > +\begin{description}
> > +\item[\field{VIRTIO_VIDEO_ENQUEUE_FLAG_FORCE_KEY_FRAME}]
> > +The submitted frame is to be encoded as a key frame. Only valid for the
> > +encoder's INPUT queue.
> > +\end{description}
> > +\item[\field{timestamp}]
> > +is an abstract sequence counter that can be used on the INPUT queue for
> > +synchronization. Resources produced on the output queue will carry the
> > +\field{timestamp} of the input resource they have been produced from.
>
> I think this is quite misleading. Implementers may assume, that it is ok
> to assume a 1-to-1 mapping between input and output buffers and no
> reordering, right? But this is not the case usually:
>
> 1. In the end of the spec H.264 and HEVC are defined to always have a
> single NAL unit per resource. Well, there are many types of NAL units,
> that do not represent any video data. Like SEI NAL units or delimiters.
>
> 2. We may assume that the SEI and delimiter units are filtered before
> queuing, but there still is also other codec-specific data that can't be
> filtered, like SPS and PPS NAL units. There has to be some special handling.
>
> 3. All of this means more codec-specific code in the driver or client
> applications.
>
> 4. This spec says that the device may skip to a next key frame after a
> seek. So the driver has to account for this too.
>
> 5. For example, in H.264 a single key frame may by coded by several NAL
> units. In fact all VCL NAL units are called slices because of this. What
> happens when the decoder sees several NAL units with different
> timestamps coding the same output frame? Which timestamp will it choose?
> I'm not sure it is defined anywhere. Probably it will just take the
> first timestamp. The driver/client applications have to be ready for
> this too.
>
> 6. I saw almost the same scenario with CSD units too. Imagine SPS with
> timestamp 0, then PPS with 1, and then an IDR with 2. These three might
> be combined in a single input buffer together by the vendor-provided
> decoding software. Then the timestamp of the resulting frame is
> naturally 0. But the driver/client application already doesn't expect to
> get any response with timestamps 0 and 1, because they are known to be
> belonging to CSD. And it expects an output buffer with ts 2. So there
> will be a problem. (This is a real world example actually.)
>
> 7. Then there is H.264 High profile, for example. It has different
> decoding and presentation order because frames may depend on future
> frames. I think all the modern codecs have a mode like this. The input
> frames are usually provided in the decoding order. Should the output
> frames timestamps just be copied from input frames, they have been
> produced from as this paragraph above says? This resembles decoder order
> then. Well, this can work, if the container has correct DTS and PTS, and
> the client software creates a mapping between these timestamps and the
> virtio video timestamp. But this is not always the case. For example,
> simple H.264 bitstream doesn't have any timestamps. And still it can be
> easily played by ffmpeg/gstreamer/VLC/etc. There is no way to make this
> work with a decoder following this spec, I think.
>
> My suggestion is to not think about the timestamp as an abstract
> counter, but give some freedom to the device by providing the available
> information from the container, be it DTS, PTR or only FPS (through
> PARAMS). Also the input and output queues should indeed be completely
> separated. There should be no assumption of a 1-to-1 mapping of buffers.

The beginning of the "Device Operation" section tries to make it clear
that the input and output queues are operating independently and that
no mapping or ordering should be expected by the driver, but maybe
this is worth repeating here.

Regarding the use of timestamp, a sensible use would indeed be for the
driver to set it to some meaningful information retrieved from the
container (which the driver would itself obtain from user-space),
probably the PTS if that is available. In the case of H.264 non-VCL
NAL units would not produce any output, so their timestamp would
effectively be ignored. For frames that are made of several slices,
the first timestamp should be the one propagated to the output frame.
(and this here is why I prefer VP8/VP9 ^_^;)

In fact most users probably won't care about this field. In the worst
case, even if no timestamp is available, operation can still be done
reliably since decoded frames are made available in presentation
order. This fact was not obvious in the spec, so I have added a
sentence in the "Device Operation" section to clarify.

I hope this answers your concerns, but please let me know if I didn't
address something in particular.

> > +\item[\field{planes}]
> > +is the format description of each individual plane making this format.
> > +The number of planes is dependent on the \field{fourcc} and detailed in
> > +\ref{sec:Device Types / Video Device / Supported formats / Image formats}.
> > +
> > +\begin{description}
> > +\item[\field{buffer_size}]
> > +is the minimum size of the buffers that will back resources to be
> > +queued.
> > +\item[\field{stride}]
> > +is the distance in bytes between two lines of data.
> > +\item[\field{offset}]
> > +is the starting offset for the data in the buffer.
>
> It is not quite clear to me how to use the offset during SET_PARAMS. I
> think it is much more reasonable to have per plane offsets in struct
> virtio_video_resource_queue and struct virtio_video_resource_queue_resp.

This is supposed to describe where in a given buffer the host can find
the beginning of a given plane (mostly useful for multi-planar/single
buffer formats). This typically does not change between frames, so
having it as a parameter seems appropriate to me?

> > +encode at the requested format and resolution.
>
> It is not defined when changing these parameters is allowed. Also there
> is an issue: changing width, height, format, buffer_size should probably
> detach all the currently attached buffers. But changing crop shouldn't
> affect the output buffers in any way, right? So maybe it is better to
> split them?

If the currently attached buffers are large enough to support the new
format, there should not be any need to detach them (if they are not,
the SET_PARAM command should fail). So even if we only change the
crop, the device can perform the full validation on the format and
keep going with the current buffers if possible.

Indeed the timing for setting this parameter should be better defined.
In particular the input format for a decoder (or output format for an
encoder) will probably remain static through the session.

> > +\item[\field{YU12}]
> > +one Y plane followed by one Cb plane, followed by one Cr plane, in a
> > +single buffer. 4:2:0 subsampling.
> > +\item[\field{YM12}]
> > +same as \field{YU12} but using three separate buffers for the Y, U and V
> > +planes.
> > +\end{description}
>
> This looks like V4L2 formats. Maybe add a V4L2 reference? At least the
> V4L2 documentation has a nice description of exact plane layouts.
> Otherwise it would be nice to have these layouts in the spec IMO.

I've linked to the relevant V4L2 pages, indeed they describe the
formats and layouts much better.

Thanks for all the feedback. We can continue on this basis, or I can
try to build a small prototype of that V4L2-over-virtio idea if you
agree this looks like a good idea. The guest driver would mostly be
forwarding the V4L2 ioctls as-is to the host, it would be interesting
to see how small we can make it with this design.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

