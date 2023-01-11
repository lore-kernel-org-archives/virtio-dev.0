Return-Path: <virtio-dev-return-10536-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AF6D3986364
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Jan 2023 08:45:52 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <CAPBb6MWyRTNPg4G5WQLVxeGi6M+pZRnzR5NEYjjGbq+YjsKUkg@mail.gmail.com>
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <87bkoehrds.fsf@redhat.com>
 <CAPBb6MWyRTNPg4G5WQLVxeGi6M+pZRnzR5NEYjjGbq+YjsKUkg@mail.gmail.com>
Date: Wed, 11 Jan 2023 09:45:41 +0100
Message-ID: <871qo1xxvu.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [RFC PATCH v6] virtio-video: Add virtio video
 device specification
Content-Type: text/plain
To: Alexandre Courbot <acourbot@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Marcin Wojtas <mwojtas@google.com>, Matti =?utf-8?Q?M=C3=B6ll?= <Matti.Moell@opensynergy.com>, Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, =?utf-8?Q?Bart=C5=82omiej?= Grzesik <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Dec 27 2022, Alexandre Courbot <acourbot@chromium.org> wrote:

> Hi Cornelia, thanks for the feedback! I have directly reported the
> comments snipped from this answer to the source document.
>
> On Fri, Dec 9, 2022 at 12:01 AM Cornelia Huck <cohuck@redhat.com> wrote:
>>
>> On Thu, Dec 08 2022, Alexandre Courbot <acourbot@chromium.org> wrote:
>>
>> > Add the specification of the video decoder and encoder devices, which
>> > can be used to provide host-accelerated video operations to the guest.
>> >
>> > Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
>> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
>> > --
>> > Here is the long-overdue new revision of the virtio-video RFC. This
>> > version reorganizes the specification quite a bit and tries to simplify
>> > the protocol further. Nonetheless, it still results in a rather long (17
>> > pages) specification for just these devices, even though the spec is not
>> > fully complete (I want to rethink the formats descriptions, and some
>> > parameters need to be added for the encoder device).
>> >
>> > I would like to get some high-level feedback on this version and maybe
>> > propose to do things a bit differently before people invest too much
>> > time reviewing this in depth. While rewriting this document, it became
>> > more and more obvious that this is just a different, and maybe a bit
>> > simpler, reimplementation of the V4L2 stateless decoder protocol [1]. I
>> > am now wondering whether it would not make more sense to rewrite this
>> > specification as just a way to transport V4L2 requests over virtio,
>> > similarly to how virtio-fs does with the FUSE protocol [2].
>> >
>> > At the time we started writing this implementation, the V4L2 protocols
>> > for decoders and encoders were not set in stone yet, but now that they
>> > are it might make sense to reconsider. Switching to this solution would
>> > greatly shorten the virtio-video device spec, and also provide a way to
>> > support other kind of V4L2 devices like cameras or image processors at
>> > no extra cost.
>> >
>> > Note that doing so would not require that either the host or guest uses
>> > V4L2 - the virtio video device would just emulate a V4L2 device over
>> > virtio. A few adaptations would need to be done regarding how memory
>> > types work, but otherwise I believe most of V4L2 could be used as-is.
>> >
>> > Please share your thoughts about this, and I will either explore this
>> > idea further with a prototype, or keep moving the present spec forward,
>> > hopefully at a faster pace.
>>
>> In principle, reusing an existing interface that does the job might be a
>> good idea. I see that the Linux headers are dual-licenced as 3-clause
>> BSD, and if the interface has indeed stabilized, it might be a good idea
>> to rely on it. The main question is: Is the interface sufficiently
>> independent from Linux specialities (i.e. can others implement it
>> without issue?)
>
> From what I can infer after looking at the sequence of ioctls that
> would be necessary to decode a stream, I believe this would work with
> only minor arrangements.

Great.

>
>> > +\end{description}
>> > +
>> > +\subsection{Feature bits}\label{sec:Device Types / Video Device / Feature bits}
>> > +
>> > +\begin{description}
>> > +\item[VIRTIO\_VIDEO\_F\_RESOURCE\_GUEST\_PAGES (0)]
>>
>> Side note: you should get the correct output even without escaping the
>> underscores (although your editor might still be confused...)
>
> Actually this LaTeX document has been generated from a Markdown file
> passed through a Pandoc filter (this makes it simpler to write for me
> vs. writing the LaTeX directly). I'll see if I can remove these escape
> sequences using the filter or sed.

If you could make it work, that would be good for consistency reasons.

>
>> > +
>> > +\begin{lstlisting}
>> > +struct virtio_video_config {
>> > +        le32 version;
>> > +        le32 caps_length;
>> > +};
>> > +\end{lstlisting}
>> > +
>> > +\begin{description}
>> > +\item[\field{version}]
>> > +is the protocol version that the device understands.
>> > +\item[\field{caps_length}]
>> > +is the minumum length in bytes that a device-writable buffer must have
>> > +in order to receive the response to
>> > +VIRTIO\_VIDEO\_CMD\_DEVICE\_QUERY\_CAPS.
>> > +\end{description}
>> > +
>> > +\devicenormative{\subsubsection}{Device configuration layout}{Device Types / Video Device / Device configuration layout}
>> > +
>> > +As there is currently only one version of the protocol, the device MUST
>> > +set the \field{version} field to 0.
>>
>> In what way would you want to change the protocol so that it becomes
>> incompatible? Extensions should be easy to handle via extra
>> capabilities, and if we don't expect the protocol to change often, a
>> feature bit for a new format might be sufficient.
>>
>> If we stick with the version field, maybe start at 1 and make 0 invalid?
>> Probably easier to spot errors that way.
>
> You are right, this is probably not needed. I guess in the early days
> we wanted to handle the case where the protocol would evolve in
> incompatible ways, but we'd better not consider that route at all if
> only for the complexity that would be added to the spec. I'll remove
> the version field.

Sounds good.

>
>>
>> > +
>> > +The device MUST set the \field{caps_length} field to a value equal to
>> > +the response size of VIRTIO\_VIDEO\_CMD\_DEVICE\_QUERY\_CAPS.
>>
>> Could the device also support a minimum response size that only supports
>> a subset of the caps to be returned? Otherwise, I think caps_length is
>> the maximum (or fixed?) length of the query caps response?
>
> I think this can be replaced by a fixed-size call for getting only one
> format at a time. The guest would have to make several of these in
> order to obtain the whole set of supported formats, but it would be
> easier to parse compared to the large result returned by QUERY_CAP and
> simpler overall.

How would you implement this? Would the driver do the call repeatedly
until no more formats remain (requires the device to track state, and
needs a specification on what happens if the driver continues doing the
call?) Or would the driver pass in an index, and the device only needs
to check for out-of-range?

>
>> > +
>> > +\subsubsection{Device Operation: Stream commands}\label{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands}
>> > +
>> > +Stream commands allow the creation, destruction, and flow control of a
>> > +stream.
>> > +
>> > +\paragraph{VIRTIO_VIDEO_CMD_STREAM_CREATE}\label{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_CREATE}
>> > +
>> > +Create a new stream using the device.
>> > +
>> > +The driver sends this command with
>> > +\field{struct virtio_video_stream_create}:
>> > +
>> > +\begin{lstlisting}
>> > +struct virtio_video_stream_create {
>> > +        le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_CREATE */
>> > +};
>> > +\end{lstlisting}
>> > +
>> > +The device responds with \field{struct virtio_video_stream_create_resp}:
>> > +
>> > +\begin{lstlisting}
>> > +struct virtio_video_stream_create_resp {
>> > +        le32 result; /* VIRTIO_VIDEO_RESULT_* */
>> > +        le32 stream_id;
>> > +};
>> > +\end{lstlisting}
>> > +
>> > +\begin{description}
>> > +\item[\field{result}]
>> > +is
>> > +
>> > +\begin{description}
>> > +\item[VIRTIO\_VIDEO\_RESULT\_OK]
>> > +if the operation succeeded,
>> > +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_OUT\_OF\_MEMORY]
>> > +if the limit of simultaneous streams has been reached by the device and
>> > +no more can be created.
>> > +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_COMMAND]
>> > +if the stream cannot be created due to an unexpected device issue.
>>
>> Is it an "unexpected device issue" or "the driver send something it
>> should not have"? It might be a good idea to distinguish the two?
>
> This error code should not be ambiguous as the input of the command is
> its type. Therefore this error code can only be returned in case of a
> library or hardware error on the host side.

Ok.

>
>> > +
>> > +\field{stream_id} MUST be set to a valid stream ID previously returned
>> > +by VIRTIO\_VIDEO\_CMD\_STREAM\_CREATE.
>> > +
>> > +\field{param_type} MUST be set to a parameter type that is valid for the
>> > +device.
>> > +
>> > +\paragraph{VIRTIO_VIDEO_CMD_STREAM_SET_PARAM}\label{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAM}
>> > +
>> > +Write the value of a parameter of the given stream, and return the value
>> > +actually set by the device. Available parameters depend on the device
>> > +type and are listed in
>> > +\ref{sec:Device Types / Video Device / Parameters}.
>> > +
>> > +\begin{lstlisting}
>> > +struct virtio_video_stream_set_param {
>> > +        le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_SET_PARAM */
>> > +        le32 stream_id;
>> > +        le32 param_type; /* VIRTIO_VIDEO_PARAMS_* */
>> > +        u8 padding[4];
>> > +        union virtio_video_stream_params param;
>> > +}
>> > +\end{lstlisting}
>> > +
>> > +\begin{description}
>> > +\item[\field{stream_id}]
>> > +is the ID of the stream we want to set a parameter for.
>> > +\item[\field{param_type}]
>> > +is one of the VIRTIO\_VIDEO\_PARAMS\_* values indicating the parameter
>> > +we want to set.
>> > +\end{description}
>> > +
>> > +The device responds with \field{struct virtio_video_stream_param_resp}:
>> > +
>> > +\begin{lstlisting}
>> > +struct virtio_video_stream_param_resp {
>> > +        le32 result; /* VIRTIO_VIDEO_RESULT_* */
>> > +        union virtio_video_stream_params param;
>> > +};
>> > +\end{lstlisting}
>> > +
>> > +\begin{description}
>> > +\item[\field{result}]
>> > +is
>> > +
>> > +\begin{description}
>> > +\item[VIRTIO\_VIDEO\_RESULT\_OK]
>> > +if the operation succeeded,
>> > +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_STREAM\_ID]
>> > +if the requested stream does not exist,
>> > +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_ARGUMENT]
>> > +if the \field{param_type} argument is invalid for the device,
>> > +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_OPERATION]
>> > +if the requested parameter cannot be modified at this moment.
>> > +\end{description}
>> > +\item[\field{param}]
>> > +is the actual value of the parameter set by the device, if
>> > +\field{result} is VIRTIO\_VIDEO\_RESULT\_OK. The value set by the device
>> > +may differ from the requested value depending on the device's
>> > +capabilities.
>> > +\end{description}
>> > +
>> > +Outside of the error cases described above, setting a parameter does not
>> > +fail. If the device cannot apply the parameter as requested, it will
>> > +adjust it to the closest setting it supports, and return that value to
>> > +the driver. It is then up to the driver to decide whether it can work
>> > +within the range of parameters supported by the device.
>>
>> Does the driver need a way to discover which parameters are supported?
>> Or is that depending on the context?
>
> The set of valid parameters should be evident from the current codec,
> but there may be cases (notably with the encoder) where some
> parameters are optional. I guess that's another case where leveraging
> V4L2 would help as it features ways to list valid parameters (or
> "controls" in V4L2-speak).

Yes, that would be a good way to handle that.

>
>> > +
>> > +\drivernormative{\paragraph}{Format parameters}{Device Types / Video Device / Parameters / Format parameters}
>> > +
>> > +When setting a format parameter, the driver MUST check the adjusted
>> > +returned value and comply with it, or try to set a different one if it
>> > +cannot.
>> > +
>> > +\subsubsection{Encoder parameters}\label{sec:Device Types / Video Device / Parameters / Encoder parameters}
>> > +
>> > +\begin{lstlisting}
>> > +struct virtio_video_params_bitrate {
>> > +    le32 min_bitrate;
>> > +    le32 max_bitrate;
>> > +    le32 bitrate;
>> > +    u8 padding[4];
>> > +}
>> > +\end{lstlisting}
>> > +
>> > +\begin{description}
>> > +\item[\field{min_bitrate}]
>> > +is the minimum bitrate supported by the encoder for the current
>> > +settings. Ignored when setting the parameter.
>> > +\item[\field{max_bitrate}]
>> > +is the maximum bitrate supported by the encoder for the current
>> > +settings. Ignored when setting the parameter.
>> > +\item[\field{bitrate_}]
>> > +is the current desired bitrate for the encoder.
>> > +\end{description}
>> > +
>> > +\subsection{Supported formats}\label{sec:Device Types / Video Device / Supported formats}
>> > +
>> > +Bitstream and image formats are identified by their fourcc code, which
>> > +is a four-bytes ASCII sequence uniquely identifying the format and its
>> > +properties.
>> > +
>> > +\subsubsection{Bitstream formats}\label{sec:Device Types / Video Device / Supported formats / Bitstream formats}
>> > +
>> > +The fourcc code of each supported bitstream format is given, as well as
>> > +the unit of data requested in each input resource for the decoder, or
>> > +produced in each output resource for the encoder.
>> > +
>> > +\begin{description}
>> > +\item[\field{MPG2}]
>> > +MPEG2 encoded stream. One Access Unit per resource.
>> > +\item[\field{H264}]
>> > +H.264 encoded stream. One NAL unit per resource.
>> > +\item[\field{HEVC}]
>> > +HEVC encoded stream. One NAL unit per resource.
>> > +\item[\field{VP80}]
>> > +VP8 encoded stream. One frame per resource.
>> > +\item[\field{VP90}]
>> > +VP9 encoded stream. One frame per resource.
>> > +\end{description}
>> > +
>> > +\subsubsection{Image formats}\label{sec:Device Types / Video Device / Supported formats / Image formats}
>> > +
>> > +The fourcc code of each supported image format is given, as well as its
>> > +number of planes, physical buffers, and eventual subsampling.
>> > +
>> > +\begin{description}
>> > +\item[\field{RGB3}]
>> > +one RGB plane where each component takes one byte, i.e.~3 bytes per
>> > +pixel.
>> > +\item[\field{NV12}]
>> > +one Y plane followed by interleaved U and V data, in a single buffer.
>> > +4:2:0 subsampling.
>> > +\item[\field{NV12}]
>> > +same as \field{NV12} but using two separate buffers for the Y and UV
>> > +planes.
>> > +\item[\field{YU12}]
>> > +one Y plane followed by one Cb plane, followed by one Cr plane, in a
>> > +single buffer. 4:2:0 subsampling.
>> > +\item[\field{YM12}]
>> > +same as \field{YU12} but using three separate buffers for the Y, U and V
>> > +planes.
>> > +\end{description}
>>
>> Can we assume that implementers know what all of those fourcc codes
>> mean? (I don't really know anything about this.) Is there some kind of
>> normative reference we should add?
>
> As Alexander pointed out, these are taken directly from V4L2, so I
> will add a reference to the source.

Sounds good.

>
>> Generally, I don't see anything fundamentally wrong with this approach
>> (mostly some smaller nits.) Feedback from someone familiar with this
>> subject would be great, though.
>
> Thanks, that's encouraging! There are still a few bits missing, and we
> may switch to something different if we decide to piggyback V4L2, but
> the core mechanisms will remain similar so it is great to see that
> there isn't any hard blocker.

Let's see how we can move this forward to something that can be
included in the spec, always good to see a new, useful device!


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

