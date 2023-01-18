Return-Path: <virtio-dev-return-10639-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E4DE29863B4
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Jan 2023 23:06:14 +0000 (UTC)
Message-ID: <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com>
Date: Thu, 19 Jan 2023 00:06:04 +0100
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com>
 <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com>
 <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Alexandre Courbot <acourbot@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=c3=b6ll?= <Matti.Moell@opensynergy.com>, Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Bart=c5=82omiej_Grzesik?= <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>, Daniel Almeida <daniel.almeida@collabora.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Alexandre,

On 12.01.23 07:39, Alexandre Courbot wrote:
> On Thu, Jan 12, 2023 at 3:42 AM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>> Hi Alexandre,
>>
>> On 27.12.22 08:31, Alexandre Courbot wrote:
>>> Hi Alexander,
>>>
>>>
>>> Cornelia provided links to the previous versions (thanks!). Through
>>> these revisions we tried different approaches, and the more we
>>> progress the closer we are getting to the V4L2 stateful
>>> decoder/encoder interface.
>>>
>>> This is actually the point where I would particularly be interested in
>>> having your feedback, since you probably have noticed the similarity.
>>> What would you think about just using virtio as a transport for V4L2
>>> ioctls (virtio-fs does something similar with FUSE), and having the
>>> host emulate a V4L2 decoder or encoder device in place of this (long)
>>> specification? I am personally starting to think this is could be a
>>> better and faster way to get us to a point where both spec and guest
>>> drivers are merged. Moreover this would also open the way to support
>>> other kinds of V4L2 devices like simple cameras - we would just need
>>> to allocate new device IDs for these and would be good to go.
>>>
>>> This probably means a bit more work on the device side, since this
>>> spec is tailored for the specific video codec use-case and V4L2 is
>>> more generic, but also less spec to maintain and more confidence that
>>> things will work as we want in the real world. On the other hand, the
>>> device would also become simpler by the fact that responses to
>>> commands could not come out-of-order as they currently do. So at the
>>> end of the day I'm not even sure this would result in a more complex
>>> device.
>> Sorry for the delay. I tried to gather data about how the spec has
>> evolved in the old emails.
> If has been a bit all over the place as we tried different approaches,
> sorry about that. >_<

No worries, this is totally understandable.


>> Well, on the one hand mimicking v4l2 looks like an easy solution from
>> virtio-video spec writing perspective. (But the implementers will have
>> to read the V4L2 API instead AFAIU, which is probably longer...)
> It should not necessarily be much longer as the parts we are
> interested in have their own dedicated pages:
>
> https://docs.kernel.org/userspace-api/media/v4l/dev-decoder.html  <https:=
//docs.kernel.org/userspace-api/media/v4l/dev-decoder.html>https://docs.ker=
nel.org/userspace-api/media/v4l/dev-encoder.html  <https://docs.kernel.org/=
userspace-api/media/v4l/dev-encoder.html>
>
> Besides, the decoding and encoding processes are described with more
> precision, not that we couldn't do that here but it would make the
> spec grow longer than I am comfortable with...

I read the references carefully, thanks. I am somewhat familiar with the
stateful decoder API, but the stateless one still needs exploring.

There is one serious issue with these references IMO: they represent
guest user-space <-> v4l2 subsystem API, not v4l2 subsystem <->
virtio-video driver API. Just to make sure we're on the same page:

guest user-space <-> v4l2 kernel subsystem <-> virtio-video driver <-
virtio-video protocol -> virtio-video device.

I believe this is how it is supposed to work, right? So I thought, that
your intention is to simplify virtio-video driver and virtio-video
protocol by reusing the v4l2 subsystem <-> v4l2 driver API. But having
these references I can assume, that you want to use user-space <-> v4l2
subsystem API, right? Well, I think this cannot happen and therefore
these references cannot be used directly unless:

1. You suggest that virtio-video driver should not use v4l2 subsystem,
but should mimic its user-space API in every detail. Probably not a good
idea.

2. There is already a way to bypass the subsystem completely. I'm not
aware of that.

3. user-space <-> v4l2 subsystem API is already the same or very close
to v4l2 subsystem <-> v4l2 driver API. I believe this is not the case
even with stateful decoder/encoder. Even more with stateless decoders
because I can see, that v4l2 subsystem actually stores some state in
this case as well. Which is quite reasonable I think.

So I think what we need to reference here is v4l2 subsystem <-> v4l2
driver API. Do you have this reference? Well, I know there is some
documentation, but still I doubt that. AFAIR kernel internal APIs are
never fixed. Right?

Besides that I can see, that this version of the spec indeed comes
closer to v4l2 user-space API, but it doesn't borrow all the legacy. I
think, this is fine. It is definitely more lightweight. I like that.

>> On the other hand v4l2 has a lot of history. It started as a camera API
>> and gained the codec support later, right? So it definitely has just to
>> much stuff irrelevant for codecs. Here we have an option to design from
>> scratch taking the best ideas from v4l2.
> That's also what we were thinking initially, but as we try to
> implement our new and optimized designs, we end up hitting a wall and
> redoing things like V4L2 did. There are small exceptions, like how
> STOP/RESET is implemented here which is slightly simpler than the V4L2
> equivalent, but I don't think these justify reinventing the remaining
> 95% quasi-identically.

I like this simplicity. If the user-space API can be reused, and this
makes things easier somehow, then maybe you're right. So looking forward
for you response to my comment above.


> V4L2 supports much more than video codecs, but if you want to
> implement a decoder you don't need to support anything more than what
> the decoder spec says you should. And that subset happens to map very
> well to the decoder use-case - it's not like the V4L2 folks tried to
> shoehorn codecs into something that is inadequate for them.

Actually I think that having only a single timestamp might be the result
of the evolution from an API for cameras, where you don't have this
tricky ordering stuff.


>> Also I have concerns about the virtio-video spec development. This seems
>> like a big change. It seems to me that after so many discussions and
>> versions of the spec, the process should be coming to something by now.
>> But this is still a moving target...
> I agree and apologize for the slow progress of this project, but let's
> not fall for the sunk cost fallacy if it turns out the
> V4L2-over-virtio solution fits the bill better and for less effort.

Ok. I just think that at this point this has to be very well justified.


>> There were arguments against adding camera support for security and
>> complexity reasons during discussions about virtio-video spec v1. Were
>> these concerns addressed somehow? Maybe I missed a followup discussion?
> The conclusion was that cameras should be their own specification as
> the virtio-video spec is too specialized for the codec use-case. There
> is actually an ongoing project for this:
>
> https://gitlab.collabora.com/collabora/virtio-camera
>
> ... which states in its README: "For now it is almost directly based
> on V4L2 Linux driver UAPI."
>
> That makes me think, if virtio-video is going to ressemble V4L2
> closely, and virtio-camera ends up heading in the same direction, why
> don't we just embrace the underlying reality that we are reinventing
> V4L2?

As I wrote earlier I only welcome taking the best ideas from V4L2. And
as I wrote above AFAIU we can't reinvent and we're not reinventing V4L2
UAPI.


>>>>> +
>>>>> +Finally, for \field{struct virtio_video_resource_sg_list}:
>>>>> +
>>>>> +\begin{description}
>>>>> +\item[\field{num_entries}]
>>>>> +is the number of \field{struct virtio_video_resource_sg_entry} insta=
nces
>>>>> +that follow.
>>>>> +\end{description}
>>>>> +
>>>>> +\field{struct virtio_video_resource_object} is defined as follows:
>>>>> +
>>>>> +\begin{lstlisting}
>>>>> +struct virtio_video_resource_object {
>>>>> +        u8 uuid[16];
>>>>> +};
>>>>> +\end{lstlisting}
>>>>> +
>>>>> +\begin{description}
>>>>> +\item[uuid]
>>>>> +is a version 4 UUID specified by \hyperref[intro:rfc4122]{[RFC4122]}=
.
>>>>> +\end{description}
>>>>> +
>>>>> +The device responds with
>>>>> +\field{struct virtio_video_resource_attach_backing_resp}:
>>>>> +
>>>>> +\begin{lstlisting}
>>>>> +struct virtio_video_resource_attach_backing_resp {
>>>>> +        le32 result; /* VIRTIO_VIDEO_RESULT_* */
>>>>> +};
>>>>> +\end{lstlisting}
>>>>> +
>>>>> +\begin{description}
>>>>> +\item[\field{result}]
>>>>> +is
>>>>> +
>>>>> +\begin{description}
>>>>> +\item[VIRTIO\_VIDEO\_RESULT\_OK]
>>>>> +if the operation succeeded,
>>>>> +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_STREAM\_ID]
>>>>> +if the mentioned stream does not exist,
>>>>> +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_ARGUMENT]
>>>>> +if \field{queue_type}, \field{resource_id}, or \field{resources} hav=
e an
>>>>> +invalid value,
>>>>> +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_OPERATION]
>>>>> +if the operation is performed at a time when it is non-valid.
>>>>> +\end{description}
>>>>> +\end{description}
>>>>> +
>>>>> +VIRTIO\_VIDEO\_CMD\_RESOURCE\_ATTACH\_BACKING can only be called dur=
ing
>>>>> +the following times:
>>>>> +
>>>>> +\begin{itemize}
>>>>> +\item
>>>>> +  AFTER a VIRTIO\_VIDEO\_CMD\_STREAM\_CREATE and BEFORE invoking
>>>>> +  VIRTIO\_VIDEO\_CMD\_RESOURCE\_QUEUE for the first time on the
>>>>> +  resource,
>>>>> +\item
>>>>> +  AFTER successfully changing the \field{virtio_video_params_resourc=
es}
>>>>> +  parameter corresponding to the queue and BEFORE
>>>>> +  VIRTIO\_VIDEO\_CMD\_RESOURCE\_QUEUE is called again on the resourc=
e.
>>>>> +\end{itemize}
>>>>> +
>>>>> +This is to ensure that the device can rely on the fact that a given
>>>>> +resource will always point to the same memory for as long as it may =
be
>>>>> +used by the video device. For instance, a decoder may use returned
>>>>> +decoded frames as reference for future frames and won't overwrite th=
e
>>>>> +backing resource of a frame that is being referenced. It is only bef=
ore
>>>>> +a stream is started and after a Dynamic Resolution Change event has
>>>>> +occurred that we can be sure that all resources won't be used in tha=
t
>>>>> +way.
>>>> The mentioned scenario about the referenced frames looks
>>>> somewhatreasonable, but I wonder how exactly would that work in practi=
ce.
>>> Basically the guest need to make sure the backing memory remains
>>> available and unwritten until the conditions mentioned above are met.
>>> Or is there anything unclear in this description?
>> Ok, I read the discussions about whether to allow the device to have
>> read access after response to QUEUE or not. Since this comes from v4l2,
>> then this should not be a problem, I think. I didn't know that v4l2
>> expects the user-space to never write to CAPTURE buffers after they
>> dequeued. I wonder if it is enforced in drivers.

Actually I have more on this. I'd prefer if there is a requirement for
the driver or the device to handle a case when a still referenced frame
is queued again. So that it is less likely to be forgotten.


>>>>> +        le32 stream_id;
>>>>> +        le32 queue_type; /* VIRTIO_VIDEO_QUEUE_TYPE_* */
>>>>> +        le32 resource_id;
>>>>> +        le32 flags; /* Bitmask of VIRTIO_VIDEO_ENQUEUE_FLAG_* */
>>>>> +        u8 padding[4];
>>>>> +        le64 timestamp;
>>>>> +        le32 data_sizes[VIRTIO_VIDEO_MAX_PLANES];
>>>>> +};
>>>>> +\end{lstlisting}
>>>>> +
>>>>> +\begin{description}
>>>>> +\item[\field{stream_id}]
>>>>> +is the ID of a valid stream.
>>>>> +\item[\field{queue_type}]
>>>>> +is the direction of the queue.
>>>>> +\item[\field{resource_id}]
>>>>> +is the ID of the resource to be queued.
>>>>> +\item[\field{flags}]
>>>>> +is a bitmask of VIRTIO\_VIDEO\_ENQUEUE\_FLAG\_* values.
>>>>> +
>>>>> +\begin{description}
>>>>> +\item[\field{VIRTIO_VIDEO_ENQUEUE_FLAG_FORCE_KEY_FRAME}]
>>>>> +The submitted frame is to be encoded as a key frame. Only valid for =
the
>>>>> +encoder's INPUT queue.
>>>>> +\end{description}
>>>>> +\item[\field{timestamp}]
>>>>> +is an abstract sequence counter that can be used on the INPUT queue =
for
>>>>> +synchronization. Resources produced on the output queue will carry t=
he
>>>>> +\field{timestamp} of the input resource they have been produced from=
.
>>>> I think this is quite misleading. Implementers may assume, that it is =
ok
>>>> to assume a 1-to-1 mapping between input and output buffers and no
>>>> reordering, right? But this is not the case usually:
>>>>
>>>> 1. In the end of the spec H.264 and HEVC are defined to always have a
>>>> single NAL unit per resource. Well, there are many types of NAL units,
>>>> that do not represent any video data. Like SEI NAL units or delimiters=
.
>>>>
>>>> 2. We may assume that the SEI and delimiter units are filtered before
>>>> queuing, but there still is also other codec-specific data that can't =
be
>>>> filtered, like SPS and PPS NAL units. There has to be some special han=
dling.
>>>>
>>>> 3. All of this means more codec-specific code in the driver or client
>>>> applications.
>>>>
>>>> 4. This spec says that the device may skip to a next key frame after a
>>>> seek. So the driver has to account for this too.
>>>>
>>>> 5. For example, in H.264 a single key frame may by coded by several NA=
L
>>>> units. In fact all VCL NAL units are called slices because of this. Wh=
at
>>>> happens when the decoder sees several NAL units with different
>>>> timestamps coding the same output frame? Which timestamp will it choos=
e?
>>>> I'm not sure it is defined anywhere. Probably it will just take the
>>>> first timestamp. The driver/client applications have to be ready for
>>>> this too.
>>>>
>>>> 6. I saw almost the same scenario with CSD units too. Imagine SPS with
>>>> timestamp 0, then PPS with 1, and then an IDR with 2. These three migh=
t
>>>> be combined in a single input buffer together by the vendor-provided
>>>> decoding software. Then the timestamp of the resulting frame is
>>>> naturally 0. But the driver/client application already doesn't expect =
to
>>>> get any response with timestamps 0 and 1, because they are known to be
>>>> belonging to CSD. And it expects an output buffer with ts 2. So there
>>>> will be a problem. (This is a real world example actually.)
>>>>
>>>> 7. Then there is H.264 High profile, for example. It has different
>>>> decoding and presentation order because frames may depend on future
>>>> frames. I think all the modern codecs have a mode like this. The input
>>>> frames are usually provided in the decoding order. Should the output
>>>> frames timestamps just be copied from input frames, they have been
>>>> produced from as this paragraph above says? This resembles decoder ord=
er
>>>> then. Well, this can work, if the container has correct DTS and PTS, a=
nd
>>>> the client software creates a mapping between these timestamps and the
>>>> virtio video timestamp. But this is not always the case. For example,
>>>> simple H.264 bitstream doesn't have any timestamps. And still it can b=
e
>>>> easily played by ffmpeg/gstreamer/VLC/etc. There is no way to make thi=
s
>>>> work with a decoder following this spec, I think.
>>>>
>>>> My suggestion is to not think about the timestamp as an abstract
>>>> counter, but give some freedom to the device by providing the availabl=
e
>>>> information from the container, be it DTS, PTR or only FPS (through
>>>> PARAMS). Also the input and output queues should indeed be completely
>>>> separated. There should be no assumption of a 1-to-1 mapping of buffer=
s.
>>> The beginning of the "Device Operation" section tries to make it clear
>>> that the input and output queues are operating independently and that
>>> no mapping or ordering should be expected by the driver, but maybe
>>> this is worth repeating here.
>>>
>>> Regarding the use of timestamp, a sensible use would indeed be for the
>>> driver to set it to some meaningful information retrieved from the
>>> container (which the driver would itself obtain from user-space),
>>> probably the PTS if that is available. In the case of H.264 non-VCL
>>> NAL units would not produce any output, so their timestamp would
>>> effectively be ignored. For frames that are made of several slices,
>>> the first timestamp should be the one propagated to the output frame.
>>> (and this here is why I prefer VP8/VP9 ^_^;)
>> Did they manage to avoid the same thing with VP9 SVC? :)
>>
>> The phrase "Resources produced on the output queue will carry the
>> \field{timestamp} of the input resource they have been produced from."
>> still sounds misleading to me. It doesn't cover for all these cases of
>> no 1 to 1 mapping. Also what if there are timestamps for some of the
>> frames, but not for all?
> This shouldn't matter - a timestamp of 0 is still a timestamp and will
> be carried over to the corresponding frames.

I really like the table of all possible cases from the reference, that
you provided above:
https://docs.kernel.org/userspace-api/media/v4l/dev-decoder.html#decoding

I'd prefer to have it here as well. Maybe it could be shorter.


>>> In fact most users probably won't care about this field. In the worst
>>> case, even if no timestamp is available, operation can still be done
>>> reliably since decoded frames are made available in presentation
>>> order. This fact was not obvious in the spec, so I have added a
>>> sentence in the "Device Operation" section to clarify.
>>>
>>> I hope this answers your concerns, but please let me know if I didn't
>>> address something in particular.
>> Indeed the order of output frames was not obvious from the spec. I think
>> there might be use-cases, when you want the decoded frames as early as
>> possible. Like when you have to transmit the frames over some (slow)
>> medium. If the decoder outputs in presentation order, the frames might
>> come out in batches. This is not good for latency then. WDYT?
> Who would be in charge of reordering then? If that burden falls to the
> guest user-space, then it probably wants to use a stateless API.
> That's not something covered by this spec (and covering it would
> require adding many more per-codec structures for SPS/PPS, VP8
> headers, etc.), but can be supported with V4L2 FWIW. Supporting this
> API however would add dozens more pages just to document the
> codec-specific structures necessary to decode a frame. See for
> instance what would be needed for H.264:
> https://www.kernel.org/doc/html/v5.5/media/uapi/v4l/ext-ctrls-codec.html#=
c.v4l2_ctrl_h264_sps.
>
> Or a client that *really* wants decoding order for latency reasons
> could hack the stream a bit to change the presentation order and
> perform QUEUE/DRAIN sequences for each frame. That would not be more
> complex than supporting a stateless API anyway.

I agree to some extent. It is just that I see this as a limitation of
stateful V4L2 UAPI. If we consider virtio-video V4L2 driver as the only
virtio-video driver implementation out there, then yes, we can safely
bake this limitation in. If V4L2 APIs change, the spec can be updated
too. If other implementations are expected and they need the decoding
order, then this might be a problem. Reordering could be done in the
virtio video V4L2 driver. Anyway for me this is a low priority issue for
now.


>>>>> +\item[\field{YU12}]
>>>>> +one Y plane followed by one Cb plane, followed by one Cr plane, in a
>>>>> +single buffer. 4:2:0 subsampling.
>>>>> +\item[\field{YM12}]
>>>>> +same as \field{YU12} but using three separate buffers for the Y, U a=
nd V
>>>>> +planes.
>>>>> +\end{description}
>>>> This looks like V4L2 formats. Maybe add a V4L2 reference? At least the
>>>> V4L2 documentation has a nice description of exact plane layouts.
>>>> Otherwise it would be nice to have these layouts in the spec IMO.
>>> I've linked to the relevant V4L2 pages, indeed they describe the
>>> formats and layouts much better.
>>>
>>> Thanks for all the feedback. We can continue on this basis, or I can
>>> try to build a small prototype of that V4L2-over-virtio idea if you
>>> agree this looks like a good idea. The guest driver would mostly be
>>> forwarding the V4L2 ioctls as-is to the host, it would be interesting
>>> to see how small we can make it with this design.
>> Let's discuss the idea.
> Let me try to summarize the case for using V4L2 over Virtio (I'll call
> it virtio-v4l2 to differentiate it from the current spec).
>
> There is the argument that virtio-video turns out to be a recreation
> of the stateful V4L2 decoder API, which itself works similarly to
> other high-level decoder APIs. So it's not like we could or should
> come with something very different. In parallel, virtio-camera is also
> currently using V4L2 as its model. While this is subject to change, I
> am starting to see a pattern here. :)
>
> Transporting V4L2 over virtio would considerably shorten the length of
> this spec, as we would just need to care about the transport aspect
> and minor amendments to the meaning of some V4L2 structure members,
> and leave the rest to V4L2 which is properly documented and for which
> there is a large collection of working examples.
>
> This would work very well for codec devices, but as a side-effect
> would also enable other kinds of devices that may be useful to
> virtualize, like image processors, DVB cards, and cameras. This
> doesn't mean virtio-v4l2 should be the *only* way to support cameras
> over virtio. It is a nice bonus of encapsulating V4L2, it may be
> sufficient for simple (most?) use-cases, but also doesn't forbid more
> specialized virtual devices for complex camera pipelines to be added
> later. virtio-v4l2 would just be the generic virtual video device that
> happens to be sufficient for our accelerated video needs - and if your
> host camera is a USB UVC one, well feel free to use that too.
>
> In other words, I see an opportunity to enable a whole class of
> devices instead of a single type for the same effort and think we
> should seriously consider this.
>
> I have started to put down what a virtio-v4l2 transport might look
> like, and am also planning on putting together a small
> proof-of-concept. If I can get folks here to warm up to the idea, I
> believe we should be able to share a spec and prototype in a month or
> so.

Thanks for the detailed explanation. Please check my comments above. I'd
like to resolve the mentioned issue first.


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

