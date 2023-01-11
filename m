Return-Path: <virtio-dev-return-10558-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 45C739863B3
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Jan 2023 18:42:34 +0000 (UTC)
Message-ID: <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com>
Date: Wed, 11 Jan 2023 19:42:24 +0100
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com>
 <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video device
 specification
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Alexandre Courbot <acourbot@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=c3=b6ll?= <Matti.Moell@opensynergy.com>, Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Bart=c5=82omiej_Grzesik?= <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Alexandre,

On 27.12.22 08:31, Alexandre Courbot wrote:
> Hi Alexander,
>
>
> On Tue, Dec 20, 2022 at 1:59 AM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>> Hello Alexandre,
>>
>> Thanks for the update. Please check my comments below.
>> I'm new to the virtio video spec development, so I may lack some
>> historic perspective. I would gladly appreciate pointing me to some
>> older emails explaining decisions, that I might not understand. I hope
>> to read through all of them later. Overall I have a lot of experience in
>> the video domain and in virtio video device development in Opsy, so I
>> hope, that my comments are relevant and useful.
> Cornelia provided links to the previous versions (thanks!). Through
> these revisions we tried different approaches, and the more we
> progress the closer we are getting to the V4L2 stateful
> decoder/encoder interface.
>
> This is actually the point where I would particularly be interested in
> having your feedback, since you probably have noticed the similarity.
> What would you think about just using virtio as a transport for V4L2
> ioctls (virtio-fs does something similar with FUSE), and having the
> host emulate a V4L2 decoder or encoder device in place of this (long)
> specification? I am personally starting to think this is could be a
> better and faster way to get us to a point where both spec and guest
> drivers are merged. Moreover this would also open the way to support
> other kinds of V4L2 devices like simple cameras - we would just need
> to allocate new device IDs for these and would be good to go.
>
> This probably means a bit more work on the device side, since this
> spec is tailored for the specific video codec use-case and V4L2 is
> more generic, but also less spec to maintain and more confidence that
> things will work as we want in the real world. On the other hand, the
> device would also become simpler by the fact that responses to
> commands could not come out-of-order as they currently do. So at the
> end of the day I'm not even sure this would result in a more complex
> device.

Sorry for the delay. I tried to gather data about how the spec has
evolved in the old emails.

Well, on the one hand mimicking v4l2 looks like an easy solution from
virtio-video spec writing perspective. (But the implementers will have
to read the V4L2 API instead AFAIU, which is probably longer...)

On the other hand v4l2 has a lot of history. It started as a camera API
and gained the codec support later, right? So it definitely has just to
much stuff irrelevant for codecs. Here we have an option to design from
scratch taking the best ideas from v4l2.

Also I have concerns about the virtio-video spec development. This seems
like a big change. It seems to me that after so many discussions and
versions of the spec, the process should be coming to something by now.
But this is still a moving target...

There were arguments against adding camera support for security and
complexity reasons during discussions about virtio-video spec v1. Were
these concerns addressed somehow? Maybe I missed a followup discussion?


>>> +\begin{lstlisting}
>>> +/* Device */
>>> +#define VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS       0x100
>>> +
>>> +/* Stream */
>>> +#define VIRTIO_VIDEO_CMD_STREAM_CREATE           0x200
>>> +#define VIRTIO_VIDEO_CMD_STREAM_DESTROY          0x201
>> Is this gap in numbers intentional? It would be great to remove it to
>> simplify boundary checks.
> This is to allow commands of the same family to stay close to one
> another. I'm not opposed to removing the gap, it just means that
> commands may end up being a bit all over the place if we extend the
> protocol.

Actually there is a gap between 0x201 and 0x203. Sorry for not being
clear here.


>>> +
>>> +\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_DRAIN}{Device =
Types / Video Device / Device Operation / Device Operation: Stream commands=
 / VIRTIO_VIDEO_CMD_STREAM_DRAIN}
>>> +
>>> +Before the device sends the response, it MUST process and respond to a=
ll
>>> +the VIRTIO\_VIDEO\_CMD\_RESOURCE\_QUEUE commands on the INPUT queue th=
at
>>> +were sent before the drain command, and make all the corresponding
>>> +output resources available to the driver by responding to their
>>> +VIRTIO\_VIDEO\_CMD\_RESOURCE\_QUEUE command.
>> Unfortunately I don't see much details about the OUTPUT queue. What if
>> the driver queues new output buffers, as it must do, fast enough? Looks
>> like a valid implementation of the DRAIN command might never send a
>> response in this case, because the only thing it does is replying to
>> VIRTIO_VIDEO_CMD_RESOURCE_QUEUE commands on the OUTPUT queue. I guess,
>> it is better to specify what happens. I think the device should respond
>> to a certain amount of OUTPUT QUEUE commands until there is an end of
>> stream condition. Then it should respond to DRAIN command. What happens
>> with the remaining queued output buffers is a question to me: should
>> they be cancelled or not?
> If I understand correctly this should not be a problem. Replies to
> commands can come out-of-order, so the reply to DRAIN can come as soon
> as the command is completed, regardless of how many output buffers we
> have queued at that moment. The queued output buffers can also remain
> queued in prediction for the next sequence, if any - if it has the
> same resolution as the previous one, then the queued output buffers
> can be used. If it doesn't then a resolution change event will be
> produced and the driver will process it.

Ok, thanks, this makes sense to me.


>>> +
>>> +While the device is processing the command, it MUST return
>>> +VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_OPERATION to the
>>> +VIRTIO\_VIDEO\_CMD\_STREAM\_DRAIN command.
>> Should the device stop accepting input too?
> There should be no problem with the device accepting (and even
> processing) input for the next sequence, as long as it doesn't make
> its result available before the response to the DRAIN command.

Hmm, maybe it is worth to add this requirement in the spec. WDYT?


>>> +
>>> +If the command is interrupted due to a VIRTIO\_VIDEO\_CMD\_STREAM\_STO=
P
>>> +or VIRTIO\_VIDEO\_CMD\_STREAM\_DESTROY operation, the device MUST
>>> +respond with VIRTIO\_VIDEO\_RESULT\_ERR\_CANCELED.
>>> +
>>> +\paragraph{VIRTIO_VIDEO_CMD_STREAM_STOP}\label{sec:Device Types / Vide=
o Device / Device Operation / Device Operation: Stream commands / VIRTIO_VI=
DEO_CMD_STREAM_STOP}
>>> +
>> I don't like this command to be called "stop". When I see a "stop"
>> command, I expect to see a "start" command as well. My personal
>> preference would be "flush" or "reset".
> Fair enough, let me rename this to RESET (which was the name used in a
> previous revision for a somehow-similar command).

Great.


>>> +};
>>> +\end{lstlisting}
>>> +
>>> +\begin{description}
>>> +\item[\field{result}]
>>> +is
>>> +
>>> +\begin{description}
>>> +\item[VIRTIO\_VIDEO\_RESULT\_OK]
>>> +if the operation succeeded,
>>> +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_STREAM\_ID]
>>> +if the requested stream does not exist,
>>> +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_ARGUMENT]
>>> +if the \field{param_type} argument is invalid for the device,
>>> +\end{description}
>>> +\item[\field{param}]
>>> +is the value of the requested parameter, if \field{result} is
>>> +VIRTIO\_VIDEO\_RESULT\_OK.
>>> +\end{description}
>>> +
>>> +\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_GET_PARAM}{Dev=
ice Types / Video Device / Device Operation / Device Operation: Stream comm=
ands / VIRTIO_VIDEO_CMD_STREAM_GET_PARAM}
>>> +
>>> +\field{cmd_type} MUST be set to VIRTIO\_VIDEO\_CMD\_STREAM\_GET\_PARAM
>>> +by the driver.
>>> +
>>> +\field{stream_id} MUST be set to a valid stream ID previously returned
>>> +by VIRTIO\_VIDEO\_CMD\_STREAM\_CREATE.
>>> +
>>> +\field{param_type} MUST be set to a parameter type that is valid for t=
he
>>> +device.
>> The device requirements are missing for GET_PARAMS.
> There aren't any beyond returning the requested parameter or an error cod=
e.

Ok.


>>> +};
>>> +\end{lstlisting}
>>> +
>>> +Within \field{struct virtio_video_resource_sg_entry}:
>>> +
>>> +\begin{description}
>>> +\item[\field{addr}]
>>> +is a guest physical address to the start of the SG entry.
>>> +\item[\field{length}]
>>> +is the length of the SG entry.
>>> +\end{description}
>> I think having explicit page alignment requirements here would be great.
> This may be host-dependent, maybe we should have a capability field so
> it can provide this information?

I mean there is already a VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES feature
bit. This suggests, that these addresses always point to pages, right?
If not, there is some inconsistency here IMO.

In our setup I think it is just always the case, that they are page
aligned. Probably non page aligned addresses would require copying on
CPU on all our platforms. So I think, yes, there should be a way to
indicate (if not require) this.


>>> +
>>> +Finally, for \field{struct virtio_video_resource_sg_list}:
>>> +
>>> +\begin{description}
>>> +\item[\field{num_entries}]
>>> +is the number of \field{struct virtio_video_resource_sg_entry} instanc=
es
>>> +that follow.
>>> +\end{description}
>>> +
>>> +\field{struct virtio_video_resource_object} is defined as follows:
>>> +
>>> +\begin{lstlisting}
>>> +struct virtio_video_resource_object {
>>> +        u8 uuid[16];
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +\begin{description}
>>> +\item[uuid]
>>> +is a version 4 UUID specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>>> +\end{description}
>>> +
>>> +The device responds with
>>> +\field{struct virtio_video_resource_attach_backing_resp}:
>>> +
>>> +\begin{lstlisting}
>>> +struct virtio_video_resource_attach_backing_resp {
>>> +        le32 result; /* VIRTIO_VIDEO_RESULT_* */
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +\begin{description}
>>> +\item[\field{result}]
>>> +is
>>> +
>>> +\begin{description}
>>> +\item[VIRTIO\_VIDEO\_RESULT\_OK]
>>> +if the operation succeeded,
>>> +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_STREAM\_ID]
>>> +if the mentioned stream does not exist,
>>> +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_ARGUMENT]
>>> +if \field{queue_type}, \field{resource_id}, or \field{resources} have =
an
>>> +invalid value,
>>> +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_OPERATION]
>>> +if the operation is performed at a time when it is non-valid.
>>> +\end{description}
>>> +\end{description}
>>> +
>>> +VIRTIO\_VIDEO\_CMD\_RESOURCE\_ATTACH\_BACKING can only be called durin=
g
>>> +the following times:
>>> +
>>> +\begin{itemize}
>>> +\item
>>> +  AFTER a VIRTIO\_VIDEO\_CMD\_STREAM\_CREATE and BEFORE invoking
>>> +  VIRTIO\_VIDEO\_CMD\_RESOURCE\_QUEUE for the first time on the
>>> +  resource,
>>> +\item
>>> +  AFTER successfully changing the \field{virtio_video_params_resources=
}
>>> +  parameter corresponding to the queue and BEFORE
>>> +  VIRTIO\_VIDEO\_CMD\_RESOURCE\_QUEUE is called again on the resource.
>>> +\end{itemize}
>>> +
>>> +This is to ensure that the device can rely on the fact that a given
>>> +resource will always point to the same memory for as long as it may be
>>> +used by the video device. For instance, a decoder may use returned
>>> +decoded frames as reference for future frames and won't overwrite the
>>> +backing resource of a frame that is being referenced. It is only befor=
e
>>> +a stream is started and after a Dynamic Resolution Change event has
>>> +occurred that we can be sure that all resources won't be used in that
>>> +way.
>> The mentioned scenario about the referenced frames looks
>> somewhatreasonable, but I wonder how exactly would that work in practice=
.
> Basically the guest need to make sure the backing memory remains
> available and unwritten until the conditions mentioned above are met.
> Or is there anything unclear in this description?

Ok, I read the discussions about whether to allow the device to have
read access after response to QUEUE or not. Since this comes from v4l2,
then this should not be a problem, I think. I didn't know that v4l2
expects the user-space to never write to CAPTURE buffers after they
dequeued. I wonder if it is enforced in drivers.


>>> +        le32 stream_id;
>>> +        le32 queue_type; /* VIRTIO_VIDEO_QUEUE_TYPE_* */
>>> +        le32 resource_id;
>>> +        le32 flags; /* Bitmask of VIRTIO_VIDEO_ENQUEUE_FLAG_* */
>>> +        u8 padding[4];
>>> +        le64 timestamp;
>>> +        le32 data_sizes[VIRTIO_VIDEO_MAX_PLANES];
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +\begin{description}
>>> +\item[\field{stream_id}]
>>> +is the ID of a valid stream.
>>> +\item[\field{queue_type}]
>>> +is the direction of the queue.
>>> +\item[\field{resource_id}]
>>> +is the ID of the resource to be queued.
>>> +\item[\field{flags}]
>>> +is a bitmask of VIRTIO\_VIDEO\_ENQUEUE\_FLAG\_* values.
>>> +
>>> +\begin{description}
>>> +\item[\field{VIRTIO_VIDEO_ENQUEUE_FLAG_FORCE_KEY_FRAME}]
>>> +The submitted frame is to be encoded as a key frame. Only valid for th=
e
>>> +encoder's INPUT queue.
>>> +\end{description}
>>> +\item[\field{timestamp}]
>>> +is an abstract sequence counter that can be used on the INPUT queue fo=
r
>>> +synchronization. Resources produced on the output queue will carry the
>>> +\field{timestamp} of the input resource they have been produced from.
>> I think this is quite misleading. Implementers may assume, that it is ok
>> to assume a 1-to-1 mapping between input and output buffers and no
>> reordering, right? But this is not the case usually:
>>
>> 1. In the end of the spec H.264 and HEVC are defined to always have a
>> single NAL unit per resource. Well, there are many types of NAL units,
>> that do not represent any video data. Like SEI NAL units or delimiters.
>>
>> 2. We may assume that the SEI and delimiter units are filtered before
>> queuing, but there still is also other codec-specific data that can't be
>> filtered, like SPS and PPS NAL units. There has to be some special handl=
ing.
>>
>> 3. All of this means more codec-specific code in the driver or client
>> applications.
>>
>> 4. This spec says that the device may skip to a next key frame after a
>> seek. So the driver has to account for this too.
>>
>> 5. For example, in H.264 a single key frame may by coded by several NAL
>> units. In fact all VCL NAL units are called slices because of this. What
>> happens when the decoder sees several NAL units with different
>> timestamps coding the same output frame? Which timestamp will it choose?
>> I'm not sure it is defined anywhere. Probably it will just take the
>> first timestamp. The driver/client applications have to be ready for
>> this too.
>>
>> 6. I saw almost the same scenario with CSD units too. Imagine SPS with
>> timestamp 0, then PPS with 1, and then an IDR with 2. These three might
>> be combined in a single input buffer together by the vendor-provided
>> decoding software. Then the timestamp of the resulting frame is
>> naturally 0. But the driver/client application already doesn't expect to
>> get any response with timestamps 0 and 1, because they are known to be
>> belonging to CSD. And it expects an output buffer with ts 2. So there
>> will be a problem. (This is a real world example actually.)
>>
>> 7. Then there is H.264 High profile, for example. It has different
>> decoding and presentation order because frames may depend on future
>> frames. I think all the modern codecs have a mode like this. The input
>> frames are usually provided in the decoding order. Should the output
>> frames timestamps just be copied from input frames, they have been
>> produced from as this paragraph above says? This resembles decoder order
>> then. Well, this can work, if the container has correct DTS and PTS, and
>> the client software creates a mapping between these timestamps and the
>> virtio video timestamp. But this is not always the case. For example,
>> simple H.264 bitstream doesn't have any timestamps. And still it can be
>> easily played by ffmpeg/gstreamer/VLC/etc. There is no way to make this
>> work with a decoder following this spec, I think.
>>
>> My suggestion is to not think about the timestamp as an abstract
>> counter, but give some freedom to the device by providing the available
>> information from the container, be it DTS, PTR or only FPS (through
>> PARAMS). Also the input and output queues should indeed be completely
>> separated. There should be no assumption of a 1-to-1 mapping of buffers.
> The beginning of the "Device Operation" section tries to make it clear
> that the input and output queues are operating independently and that
> no mapping or ordering should be expected by the driver, but maybe
> this is worth repeating here.
>
> Regarding the use of timestamp, a sensible use would indeed be for the
> driver to set it to some meaningful information retrieved from the
> container (which the driver would itself obtain from user-space),
> probably the PTS if that is available. In the case of H.264 non-VCL
> NAL units would not produce any output, so their timestamp would
> effectively be ignored. For frames that are made of several slices,
> the first timestamp should be the one propagated to the output frame.
> (and this here is why I prefer VP8/VP9 ^_^;)

Did they manage to avoid the same thing with VP9 SVC? :)

The phrase "Resources produced on the output queue will carry the
\field{timestamp} of the input resource they have been produced from."
still sounds misleading to me. It doesn't cover for all these cases of
no 1 to 1 mapping. Also what if there are timestamps for some of the
frames, but not for all?


> In fact most users probably won't care about this field. In the worst
> case, even if no timestamp is available, operation can still be done
> reliably since decoded frames are made available in presentation
> order. This fact was not obvious in the spec, so I have added a
> sentence in the "Device Operation" section to clarify.
>
> I hope this answers your concerns, but please let me know if I didn't
> address something in particular.

Indeed the order of output frames was not obvious from the spec. I think
there might be use-cases, when you want the decoded frames as early as
possible. Like when you have to transmit the frames over some (slow)
medium. If the decoder outputs in presentation order, the frames might
come out in batches. This is not good for latency then. WDYT?


>>> +\item[\field{planes}]
>>> +is the format description of each individual plane making this format.
>>> +The number of planes is dependent on the \field{fourcc} and detailed i=
n
>>> +\ref{sec:Device Types / Video Device / Supported formats / Image forma=
ts}.
>>> +
>>> +\begin{description}
>>> +\item[\field{buffer_size}]
>>> +is the minimum size of the buffers that will back resources to be
>>> +queued.
>>> +\item[\field{stride}]
>>> +is the distance in bytes between two lines of data.
>>> +\item[\field{offset}]
>>> +is the starting offset for the data in the buffer.
>> It is not quite clear to me how to use the offset during SET_PARAMS. I
>> think it is much more reasonable to have per plane offsets in struct
>> virtio_video_resource_queue and struct virtio_video_resource_queue_resp.
> This is supposed to describe where in a given buffer the host can find
> the beginning of a given plane (mostly useful for multi-planar/single
> buffer formats). This typically does not change between frames, so
> having it as a parameter seems appropriate to me?

The plane sizes don't change either, right? I think it is just usual way
to put the plane offsets and sizes together. I saw this pattern in
gstreamer. I think, in DRM and V4L2 as well. For me it is quite reasonable.


>>> +encode at the requested format and resolution.
>> It is not defined when changing these parameters is allowed. Also there
>> is an issue: changing width, height, format, buffer_size should probably
>> detach all the currently attached buffers. But changing crop shouldn't
>> affect the output buffers in any way, right? So maybe it is better to
>> split them?
> If the currently attached buffers are large enough to support the new
> format, there should not be any need to detach them (if they are not,
> the SET_PARAM command should fail). So even if we only change the
> crop, the device can perform the full validation on the format and
> keep going with the current buffers if possible.
>
> Indeed the timing for setting this parameter should be better defined.
> In particular the input format for a decoder (or output format for an
> encoder) will probably remain static through the session.

Ok.


>>> +\item[\field{YU12}]
>>> +one Y plane followed by one Cb plane, followed by one Cr plane, in a
>>> +single buffer. 4:2:0 subsampling.
>>> +\item[\field{YM12}]
>>> +same as \field{YU12} but using three separate buffers for the Y, U and=
 V
>>> +planes.
>>> +\end{description}
>> This looks like V4L2 formats. Maybe add a V4L2 reference? At least the
>> V4L2 documentation has a nice description of exact plane layouts.
>> Otherwise it would be nice to have these layouts in the spec IMO.
> I've linked to the relevant V4L2 pages, indeed they describe the
> formats and layouts much better.
>
> Thanks for all the feedback. We can continue on this basis, or I can
> try to build a small prototype of that V4L2-over-virtio idea if you
> agree this looks like a good idea. The guest driver would mostly be
> forwarding the V4L2 ioctls as-is to the host, it would be interesting
> to see how small we can make it with this design.

Let's discuss the idea.


--
Alexander Gordeev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0 - 88
Fax: +49 (30) 60 98 54 0 - 99
EMail: alexander.gordeev@opensynergy.com

www.opensynergy.com

Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616=
B
Gesch=C3=A4ftsf=C3=BChrer/Managing Director: R=C3=A9gis Adjamah


Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

