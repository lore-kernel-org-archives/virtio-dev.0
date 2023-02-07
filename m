Return-Path: <virtio-dev-return-10736-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A4BFB98643E
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Feb 2023 10:57:16 +0000 (UTC)
Message-ID: <634cb1dd-3b2c-e416-b972-23f47b233feb@opensynergy.com>
Date: Tue, 7 Feb 2023 11:57:05 +0100
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com>
 <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com>
 <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com>
 <CAPBb6MXHWzTN=aR4fV+NFpjKh8WORVh9fvXowr+6RcFr06uVjg@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MXHWzTN=aR4fV+NFpjKh8WORVh9fvXowr+6RcFr06uVjg@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Alexandre Courbot <acourbot@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=c3=b6ll?= <Matti.Moell@opensynergy.com>, Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Bart=c5=82omiej_Grzesik?= <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>, Daniel Almeida <daniel.almeida@collabora.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 07.02.23 07:51, Alexandre Courbot wrote:
> On Thu, Jan 19, 2023 at 8:06 AM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>>>> Well, on the one hand mimicking v4l2 looks like an easy solution from
>>>> virtio-video spec writing perspective. (But the implementers will have
>>>> to read the V4L2 API instead AFAIU, which is probably longer...)
>>> It should not necessarily be much longer as the parts we are
>>> interested in have their own dedicated pages:
>>>
>>> https://docs.kernel.org/userspace-api/media/v4l/dev-decoder.html
>>> https://docs.kernel.org/userspace-api/media/v4l/dev-encoder.html
>>>
>>> Besides, the decoding and encoding processes are described with more
>>> precision, not that we couldn't do that here but it would make the
>>> spec grow longer than I am comfortable with...
>> I read the references carefully, thanks. I am somewhat familiar with the
>> stateful decoder API, but the stateless one still needs exploring.
> Note that the stateful API is the one covering the current
> virtio-video spec, and the one I would recommend to implement a
> virtual video device. A stateless device could be implemented by
> people who really need it, but I personally don't see a huge benefit
> in doing so except maybe in some corner cases.
>
>> There is one serious issue with these references IMO: they represent
>> guest user-space <-> v4l2 subsystem API, not v4l2 subsystem <->
>> virtio-video driver API. Just to make sure we're on the same page:
>>
>> guest user-space <-> v4l2 kernel subsystem <-> virtio-video driver <-
>> virtio-video protocol -> virtio-video device.
>>
>> I believe this is how it is supposed to work, right? So I thought, that
>> your intention is to simplify virtio-video driver and virtio-video
>> protocol by reusing the v4l2 subsystem <-> v4l2 driver API. But having
>> these references I can assume, that you want to use user-space <-> v4l2
>> subsystem API, right? Well, I think this cannot happen and therefore
>> these references cannot be used directly unless:
>>
>> 1. You suggest that virtio-video driver should not use v4l2 subsystem,
>> but should mimic its user-space API in every detail. Probably not a good
>> idea.
> Can you elaborate on why you think this would be a bad idea? V4L2 has
> some legacy stuff that we definitely will not want to add to the spec
> (hence I don't think it should mimic it "in every detail"), but for
> the most part the UAPI works very similarly to the current
> virtio-video specification.

This was an attempt to imagine a situation, where v4l2 subsystem is not
used at all, completely. Like not even added into the kernel build. Just
for the sake of listing all the available options. Sorry for the confusion.


>> 2. There is already a way to bypass the subsystem completely. I'm not
>> aware of that.
> A V4L2 driver needs to implement v4l2_ioctl_ops, which provides it
> with the UAPI structures as submitted by user-space. Most drivers then
> call V4L2 subsystem functions from these hooks, but it is perfectly ok
> to not do so and thus bypass the subsystem completely.

True. Thanks for pointing this out. Indeed, this is technically possible
and this approach seems well upstreamable.


> If we find out that there is a benefit in going through the V4L2
> subsystem (which I cannot see for now), rebuilding the UAPI structures
> to communicate with the device is not different from building
> virtio-video specific structures like what we are currently doing.

Well, the V4L2 subsystem is there for a reason, right? It does some
important things too. I'm going to check all the v4l2_ioctl_ops
callbacks in the current virtio-video driver to make the list. Also if
you have some PoC spec/implementations, that would be nice to review. It
is always better to see the actual implementation, of course.

I have these points so far:

1. Overall the V4L2 stateful decoder API looks significantly more
complex to me. Looks like you're a V4L2 expert, so this might not be
visible to you that much.

   a. So V4L2 subsystem and the current virtio-video driver are already
reducing the complexity. And this seems as the right place to do this,
because the complexity is caused by the amount of V4L2 use cases and its
legacy. If somebody wants to use virtio-video in a Windows guest, they
would prefer a simpler API, right? I think this use-case is not purely
abstract at all.

   b. Less complex API is better from a security point of view too. When
V4L2 was developed, not many people were concerned with malicious USB
devices probably. At least exploiting a malicious USB device usually
requires physical access. With virtual devices and multiple VMs the
stakes are higher, I believe.

2. We have a working virtio-video driver. So we need very good reasons
to start from scratch. You name two reasons AFAIR: simplicity and
possible use of cameras. Did I miss something else?

   a. The simplicity is there only in case all the interfaces are V4L2,
both in the backend and in the guest. Otherwise the complexity is just
moved to backends. I haven't seen V4L2 in our setups so far, only some
proprietary OMX libraries. So from my point of view, this is not
simplicity in general, but an optimization for a specific narrow use case.

   b. For modern cameras the V4L2 interface is not enough anyway. This
was already discussed AFAIR. There is a separate virtio-camera
specification, that indeed is based on V4L2 UAPI as you said. But
combining these two specs is certainly not future proof, right? So I
think it is best to let the virtio-camera spec to be developed
independently.

3. More specifically I can see, that around 95% V4L2 drivers use
videobuf2. This includes the current virtio-video driver. Bypassing the
V4L2 subsystem means that vb2 can't be used, right? In various
discussions vb2 popped up as a thing, that would be hard to avoid. What
do you think about this? How are you going to deal with various V4L2
memory types (V4L2_MEMORY_MMAP, V4L2_MEMORY_DMABUF, etc), for example?
I'll try to dive deeper myself too...


>> 3. user-space <-> v4l2 subsystem API is already the same or very close
>> to v4l2 subsystem <-> v4l2 driver API. I believe this is not the case
>> even with stateful decoder/encoder. Even more with stateless decoders
>> because I can see, that v4l2 subsystem actually stores some state in
>> this case as well. Which is quite reasonable I think.
> Actually I don't think this is even something we need to think about -
> in its simplest form the V4L2 guest driver just needs to act as a
> proxy for the device. So which decoder API is used by the host is
> completely irrelevant to the guest driver - it can support a decoder,
> an encoder, or a camera - it doesn't even need to be aware of what
> kind of device it is exposing and that simplicity is another thing
> that I like with this design.

As I wrote above the design would be indeed simple only in case the
actual hardware is exposed to a backend through V4L2 too. Otherwise the
complexity is just moved to backends.


> This simplicity goes away if the guest device does not use V4L2 as its
> user-space interface (e.g. Windows?). In this case we would be in the
> exact same scenario as the current virtio-video spec, where we need to
> build device-specific structures from the guest driver's internal
> state.

IMO this is not quite correct. The scenario would not be not the same,
because the V4L2 stateful decoder API is more complex in comparison to
any virtio-video spec draft version. Probably it would be great to have
a list of differences. I hope to find some time for this later...


>> So I think what we need to reference here is v4l2 subsystem <-> v4l2
>> driver API. Do you have this reference? Well, I know there is some
>> documentation, but still I doubt that. AFAIR kernel internal APIs are
>> never fixed. Right?
> Correct, but since they are not being considered for the spec this
> should not matter, thankfully.

Ack.


>> Besides that I can see, that this version of the spec indeed comes
>> closer to v4l2 user-space API, but it doesn't borrow all the legacy. I
>> think, this is fine. It is definitely more lightweight. I like that.
> We definitely don't want to borrow all the legacy. Actually most
> modern V4L2 drivers also do not support the oldest V4L2 features, so
> it is perfectly fine if the virtio-video guest driver does the same.
> We will just need to mention explicitly in the spec which parts of
> V4L2 are out-of-scope.

Hmm, good. It would be nice to see this in practice. Looks like it is
best to wait for the PoC then.


>>>> On the other hand v4l2 has a lot of history. It started as a camera AP=
I
>>>> and gained the codec support later, right? So it definitely has just t=
o
>>>> much stuff irrelevant for codecs. Here we have an option to design fro=
m
>>>> scratch taking the best ideas from v4l2.
>>> That's also what we were thinking initially, but as we try to
>>> implement our new and optimized designs, we end up hitting a wall and
>>> redoing things like V4L2 did. There are small exceptions, like how
>>> STOP/RESET is implemented here which is slightly simpler than the V4L2
>>> equivalent, but I don't think these justify reinventing the remaining
>>> 95% quasi-identically.
>> I like this simplicity. If the user-space API can be reused, and this
>> makes things easier somehow, then maybe you're right. So looking forward
>> for you response to my comment above.
> I believe the user-space API can be reused and hope to demonstrate it
> with a small PoC soon. But if you see something that would make this
> unworkable, now is a good time to elaborate. :)

Unfortunately I don't have enough knowledge of V4L2 internals at the
moment to be certain about that. But I'll definitely spend some time on
this as the approach now looks technically possible. So I have only the
mentioned above higher level concerns at the moment.


>>> V4L2 supports much more than video codecs, but if you want to
>>> implement a decoder you don't need to support anything more than what
>>> the decoder spec says you should. And that subset happens to map very
>>> well to the decoder use-case - it's not like the V4L2 folks tried to
>>> shoehorn codecs into something that is inadequate for them.
>> Actually I think that having only a single timestamp might be the result
>> of the evolution from an API for cameras, where you don't have this
>> tricky ordering stuff.
> IIUC frames from camera devices do get a real-time timestamp affixed
> to them though. What is new with codec devices is that the timestamp
> is copied from an input buffer to the corresponding output buffers.

Yes, that's what I mean. The frames from cameras have to be timestamped,
but nobody really expects reordering, right? Then codecs are added and
now reordering of output frames is a normal use case. So I imagine the
V4L2 folks had a choice:

1. replace a single timestamp with PTS and DTS in all the APIs and
potentially break some user-space apps or

2. simply require presentation ordering for the new class of devices.


>>>>>>> +
>>>>>>> +Finally, for \field{struct virtio_video_resource_sg_list}:
>>>>>>> +
>>>>>>> +\begin{description}
>>>>>>> +\item[\field{num_entries}]
>>>>>>> +is the number of \field{struct virtio_video_resource_sg_entry} ins=
tances
>>>>>>> +that follow.
>>>>>>> +\end{description}
>>>>>>> +
>>>>>>> +\field{struct virtio_video_resource_object} is defined as follows:
>>>>>>> +
>>>>>>> +\begin{lstlisting}
>>>>>>> +struct virtio_video_resource_object {
>>>>>>> +        u8 uuid[16];
>>>>>>> +};
>>>>>>> +\end{lstlisting}
>>>>>>> +
>>>>>>> +\begin{description}
>>>>>>> +\item[uuid]
>>>>>>> +is a version 4 UUID specified by \hyperref[intro:rfc4122]{[RFC4122=
]}.
>>>>>>> +\end{description}
>>>>>>> +
>>>>>>> +The device responds with
>>>>>>> +\field{struct virtio_video_resource_attach_backing_resp}:
>>>>>>> +
>>>>>>> +\begin{lstlisting}
>>>>>>> +struct virtio_video_resource_attach_backing_resp {
>>>>>>> +        le32 result; /* VIRTIO_VIDEO_RESULT_* */
>>>>>>> +};
>>>>>>> +\end{lstlisting}
>>>>>>> +
>>>>>>> +\begin{description}
>>>>>>> +\item[\field{result}]
>>>>>>> +is
>>>>>>> +
>>>>>>> +\begin{description}
>>>>>>> +\item[VIRTIO\_VIDEO\_RESULT\_OK]
>>>>>>> +if the operation succeeded,
>>>>>>> +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_STREAM\_ID]
>>>>>>> +if the mentioned stream does not exist,
>>>>>>> +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_ARGUMENT]
>>>>>>> +if \field{queue_type}, \field{resource_id}, or \field{resources} h=
ave an
>>>>>>> +invalid value,
>>>>>>> +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_OPERATION]
>>>>>>> +if the operation is performed at a time when it is non-valid.
>>>>>>> +\end{description}
>>>>>>> +\end{description}
>>>>>>> +
>>>>>>> +VIRTIO\_VIDEO\_CMD\_RESOURCE\_ATTACH\_BACKING can only be called d=
uring
>>>>>>> +the following times:
>>>>>>> +
>>>>>>> +\begin{itemize}
>>>>>>> +\item
>>>>>>> +  AFTER a VIRTIO\_VIDEO\_CMD\_STREAM\_CREATE and BEFORE invoking
>>>>>>> +  VIRTIO\_VIDEO\_CMD\_RESOURCE\_QUEUE for the first time on the
>>>>>>> +  resource,
>>>>>>> +\item
>>>>>>> +  AFTER successfully changing the \field{virtio_video_params_resou=
rces}
>>>>>>> +  parameter corresponding to the queue and BEFORE
>>>>>>> +  VIRTIO\_VIDEO\_CMD\_RESOURCE\_QUEUE is called again on the resou=
rce.
>>>>>>> +\end{itemize}
>>>>>>> +
>>>>>>> +This is to ensure that the device can rely on the fact that a give=
n
>>>>>>> +resource will always point to the same memory for as long as it ma=
y be
>>>>>>> +used by the video device. For instance, a decoder may use returned
>>>>>>> +decoded frames as reference for future frames and won't overwrite =
the
>>>>>>> +backing resource of a frame that is being referenced. It is only b=
efore
>>>>>>> +a stream is started and after a Dynamic Resolution Change event ha=
s
>>>>>>> +occurred that we can be sure that all resources won't be used in t=
hat
>>>>>>> +way.
>>>>>> The mentioned scenario about the referenced frames looks
>>>>>> somewhatreasonable, but I wonder how exactly would that work in prac=
tice.
>>>>> Basically the guest need to make sure the backing memory remains
>>>>> available and unwritten until the conditions mentioned above are met.
>>>>> Or is there anything unclear in this description?
>>>> Ok, I read the discussions about whether to allow the device to have
>>>> read access after response to QUEUE or not. Since this comes from v4l2=
,
>>>> then this should not be a problem, I think. I didn't know that v4l2
>>>> expects the user-space to never write to CAPTURE buffers after they
>>>> dequeued. I wonder if it is enforced in drivers.
>> Actually I have more on this. I'd prefer if there is a requirement for
>> the driver or the device to handle a case when a still referenced frame
>> is queued again. So that it is less likely to be forgotten.
> With the stateful API, the driver/device is in charge of making sure
> submitted reference frames are not overwritten as long as there is a
> reference to them. I.e. the driver or device firmware will reorder to
> frames to avoid that, so there is indeed the requirement you describe.
>
> With the stateless API, user-space is in charge of reference frames
> reordering and the driver is only an executor - if user-space does
> something damaging to itself, it will get corrupted frames.
>
> I hope this clarifies things a bit - let's go to the bottom of any
> remaining concern to make sure we make the right call here.

This was a note about the virtio-video draft v6. I hope it is still on
the table to discuss. :) Of course, discussions about moving to V4L2
UAPI is of higher priority.


Regards,
Alexander

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

