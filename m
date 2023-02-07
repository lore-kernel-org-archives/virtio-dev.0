Return-Path: <virtio-dev-return-10731-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D83A8986434
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Feb 2023 06:51:48 +0000 (UTC)
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com> <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com> <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com>
In-Reply-To: <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Tue, 7 Feb 2023 15:51:31 +0900
Message-ID: <CAPBb6MXHWzTN=aR4fV+NFpjKh8WORVh9fvXowr+6RcFr06uVjg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Alexander Gordeev <alexander.gordeev@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=C3=B6ll?= <Matti.Moell@opensynergy.com>, Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Bart=C5=82omiej_Grzesik?= <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>, Daniel Almeida <daniel.almeida@collabora.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 19, 2023 at 8:06 AM Alexander Gordeev
<alexander.gordeev@opensynergy.com> wrote:
>
> Hi Alexandre,
>
> On 12.01.23 07:39, Alexandre Courbot wrote:
> > On Thu, Jan 12, 2023 at 3:42 AM Alexander Gordeev
> > <alexander.gordeev@opensynergy.com> wrote:
> >> Hi Alexandre,
> >>
> >> On 27.12.22 08:31, Alexandre Courbot wrote:
> >>> Hi Alexander,
> >>>
> >>>
> >>> Cornelia provided links to the previous versions (thanks!). Through
> >>> these revisions we tried different approaches, and the more we
> >>> progress the closer we are getting to the V4L2 stateful
> >>> decoder/encoder interface.
> >>>
> >>> This is actually the point where I would particularly be interested i=
n
> >>> having your feedback, since you probably have noticed the similarity.
> >>> What would you think about just using virtio as a transport for V4L2
> >>> ioctls (virtio-fs does something similar with FUSE), and having the
> >>> host emulate a V4L2 decoder or encoder device in place of this (long)
> >>> specification? I am personally starting to think this is could be a
> >>> better and faster way to get us to a point where both spec and guest
> >>> drivers are merged. Moreover this would also open the way to support
> >>> other kinds of V4L2 devices like simple cameras - we would just need
> >>> to allocate new device IDs for these and would be good to go.
> >>>
> >>> This probably means a bit more work on the device side, since this
> >>> spec is tailored for the specific video codec use-case and V4L2 is
> >>> more generic, but also less spec to maintain and more confidence that
> >>> things will work as we want in the real world. On the other hand, the
> >>> device would also become simpler by the fact that responses to
> >>> commands could not come out-of-order as they currently do. So at the
> >>> end of the day I'm not even sure this would result in a more complex
> >>> device.
> >> Sorry for the delay. I tried to gather data about how the spec has
> >> evolved in the old emails.
> > If has been a bit all over the place as we tried different approaches,
> > sorry about that. >_<
>
> No worries, this is totally understandable.
>
>
> >> Well, on the one hand mimicking v4l2 looks like an easy solution from
> >> virtio-video spec writing perspective. (But the implementers will have
> >> to read the V4L2 API instead AFAIU, which is probably longer...)
> > It should not necessarily be much longer as the parts we are
> > interested in have their own dedicated pages:
> >
> > https://docs.kernel.org/userspace-api/media/v4l/dev-decoder.html  <http=
s://docs.kernel.org/userspace-api/media/v4l/dev-decoder.html>https://docs.k=
ernel.org/userspace-api/media/v4l/dev-encoder.html  <https://docs.kernel.or=
g/userspace-api/media/v4l/dev-encoder.html>
> >
> > Besides, the decoding and encoding processes are described with more
> > precision, not that we couldn't do that here but it would make the
> > spec grow longer than I am comfortable with...
>
> I read the references carefully, thanks. I am somewhat familiar with the
> stateful decoder API, but the stateless one still needs exploring.

Note that the stateful API is the one covering the current
virtio-video spec, and the one I would recommend to implement a
virtual video device. A stateless device could be implemented by
people who really need it, but I personally don't see a huge benefit
in doing so except maybe in some corner cases.

>
> There is one serious issue with these references IMO: they represent
> guest user-space <-> v4l2 subsystem API, not v4l2 subsystem <->
> virtio-video driver API. Just to make sure we're on the same page:
>
> guest user-space <-> v4l2 kernel subsystem <-> virtio-video driver <-
> virtio-video protocol -> virtio-video device.
>
> I believe this is how it is supposed to work, right? So I thought, that
> your intention is to simplify virtio-video driver and virtio-video
> protocol by reusing the v4l2 subsystem <-> v4l2 driver API. But having
> these references I can assume, that you want to use user-space <-> v4l2
> subsystem API, right? Well, I think this cannot happen and therefore
> these references cannot be used directly unless:
>
> 1. You suggest that virtio-video driver should not use v4l2 subsystem,
> but should mimic its user-space API in every detail. Probably not a good
> idea.

Can you elaborate on why you think this would be a bad idea? V4L2 has
some legacy stuff that we definitely will not want to add to the spec
(hence I don't think it should mimic it "in every detail"), but for
the most part the UAPI works very similarly to the current
virtio-video specification.

> 2. There is already a way to bypass the subsystem completely. I'm not
> aware of that.

A V4L2 driver needs to implement v4l2_ioctl_ops, which provides it
with the UAPI structures as submitted by user-space. Most drivers then
call V4L2 subsystem functions from these hooks, but it is perfectly ok
to not do so and thus bypass the subsystem completely.

If we find out that there is a benefit in going through the V4L2
subsystem (which I cannot see for now), rebuilding the UAPI structures
to communicate with the device is not different from building
virtio-video specific structures like what we are currently doing.

> 3. user-space <-> v4l2 subsystem API is already the same or very close
> to v4l2 subsystem <-> v4l2 driver API. I believe this is not the case
> even with stateful decoder/encoder. Even more with stateless decoders
> because I can see, that v4l2 subsystem actually stores some state in
> this case as well. Which is quite reasonable I think.

Actually I don't think this is even something we need to think about -
in its simplest form the V4L2 guest driver just needs to act as a
proxy for the device. So which decoder API is used by the host is
completely irrelevant to the guest driver - it can support a decoder,
an encoder, or a camera - it doesn't even need to be aware of what
kind of device it is exposing and that simplicity is another thing
that I like with this design.

This simplicity goes away if the guest device does not use V4L2 as its
user-space interface (e.g. Windows?). In this case we would be in the
exact same scenario as the current virtio-video spec, where we need to
build device-specific structures from the guest driver's internal
state.

> So I think what we need to reference here is v4l2 subsystem <-> v4l2
> driver API. Do you have this reference? Well, I know there is some
> documentation, but still I doubt that. AFAIR kernel internal APIs are
> never fixed. Right?

Correct, but since they are not being considered for the spec this
should not matter, thankfully.

> Besides that I can see, that this version of the spec indeed comes
> closer to v4l2 user-space API, but it doesn't borrow all the legacy. I
> think, this is fine. It is definitely more lightweight. I like that.

We definitely don't want to borrow all the legacy. Actually most
modern V4L2 drivers also do not support the oldest V4L2 features, so
it is perfectly fine if the virtio-video guest driver does the same.
We will just need to mention explicitly in the spec which parts of
V4L2 are out-of-scope.

> >> On the other hand v4l2 has a lot of history. It started as a camera AP=
I
> >> and gained the codec support later, right? So it definitely has just t=
o
> >> much stuff irrelevant for codecs. Here we have an option to design fro=
m
> >> scratch taking the best ideas from v4l2.
> > That's also what we were thinking initially, but as we try to
> > implement our new and optimized designs, we end up hitting a wall and
> > redoing things like V4L2 did. There are small exceptions, like how
> > STOP/RESET is implemented here which is slightly simpler than the V4L2
> > equivalent, but I don't think these justify reinventing the remaining
> > 95% quasi-identically.
>
> I like this simplicity. If the user-space API can be reused, and this
> makes things easier somehow, then maybe you're right. So looking forward
> for you response to my comment above.

I believe the user-space API can be reused and hope to demonstrate it
with a small PoC soon. But if you see something that would make this
unworkable, now is a good time to elaborate. :)

> > V4L2 supports much more than video codecs, but if you want to
> > implement a decoder you don't need to support anything more than what
> > the decoder spec says you should. And that subset happens to map very
> > well to the decoder use-case - it's not like the V4L2 folks tried to
> > shoehorn codecs into something that is inadequate for them.
>
> Actually I think that having only a single timestamp might be the result
> of the evolution from an API for cameras, where you don't have this
> tricky ordering stuff.

IIUC frames from camera devices do get a real-time timestamp affixed
to them though. What is new with codec devices is that the timestamp
is copied from an input buffer to the corresponding output buffers.

> >> Also I have concerns about the virtio-video spec development. This see=
ms
> >> like a big change. It seems to me that after so many discussions and
> >> versions of the spec, the process should be coming to something by now=
.
> >> But this is still a moving target...
> > I agree and apologize for the slow progress of this project, but let's
> > not fall for the sunk cost fallacy if it turns out the
> > V4L2-over-virtio solution fits the bill better and for less effort.
>
> Ok. I just think that at this point this has to be very well justified.
>
>
> >> There were arguments against adding camera support for security and
> >> complexity reasons during discussions about virtio-video spec v1. Were
> >> these concerns addressed somehow? Maybe I missed a followup discussion=
?
> > The conclusion was that cameras should be their own specification as
> > the virtio-video spec is too specialized for the codec use-case. There
> > is actually an ongoing project for this:
> >
> > https://gitlab.collabora.com/collabora/virtio-camera
> >
> > ... which states in its README: "For now it is almost directly based
> > on V4L2 Linux driver UAPI."
> >
> > That makes me think, if virtio-video is going to ressemble V4L2
> > closely, and virtio-camera ends up heading in the same direction, why
> > don't we just embrace the underlying reality that we are reinventing
> > V4L2?
>
> As I wrote earlier I only welcome taking the best ideas from V4L2. And
> as I wrote above AFAIU we can't reinvent and we're not reinventing V4L2
> UAPI.
>
>
> >>>>> +
> >>>>> +Finally, for \field{struct virtio_video_resource_sg_list}:
> >>>>> +
> >>>>> +\begin{description}
> >>>>> +\item[\field{num_entries}]
> >>>>> +is the number of \field{struct virtio_video_resource_sg_entry} ins=
tances
> >>>>> +that follow.
> >>>>> +\end{description}
> >>>>> +
> >>>>> +\field{struct virtio_video_resource_object} is defined as follows:
> >>>>> +
> >>>>> +\begin{lstlisting}
> >>>>> +struct virtio_video_resource_object {
> >>>>> +        u8 uuid[16];
> >>>>> +};
> >>>>> +\end{lstlisting}
> >>>>> +
> >>>>> +\begin{description}
> >>>>> +\item[uuid]
> >>>>> +is a version 4 UUID specified by \hyperref[intro:rfc4122]{[RFC4122=
]}.
> >>>>> +\end{description}
> >>>>> +
> >>>>> +The device responds with
> >>>>> +\field{struct virtio_video_resource_attach_backing_resp}:
> >>>>> +
> >>>>> +\begin{lstlisting}
> >>>>> +struct virtio_video_resource_attach_backing_resp {
> >>>>> +        le32 result; /* VIRTIO_VIDEO_RESULT_* */
> >>>>> +};
> >>>>> +\end{lstlisting}
> >>>>> +
> >>>>> +\begin{description}
> >>>>> +\item[\field{result}]
> >>>>> +is
> >>>>> +
> >>>>> +\begin{description}
> >>>>> +\item[VIRTIO\_VIDEO\_RESULT\_OK]
> >>>>> +if the operation succeeded,
> >>>>> +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_STREAM\_ID]
> >>>>> +if the mentioned stream does not exist,
> >>>>> +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_ARGUMENT]
> >>>>> +if \field{queue_type}, \field{resource_id}, or \field{resources} h=
ave an
> >>>>> +invalid value,
> >>>>> +\item[VIRTIO\_VIDEO\_RESULT\_ERR\_INVALID\_OPERATION]
> >>>>> +if the operation is performed at a time when it is non-valid.
> >>>>> +\end{description}
> >>>>> +\end{description}
> >>>>> +
> >>>>> +VIRTIO\_VIDEO\_CMD\_RESOURCE\_ATTACH\_BACKING can only be called d=
uring
> >>>>> +the following times:
> >>>>> +
> >>>>> +\begin{itemize}
> >>>>> +\item
> >>>>> +  AFTER a VIRTIO\_VIDEO\_CMD\_STREAM\_CREATE and BEFORE invoking
> >>>>> +  VIRTIO\_VIDEO\_CMD\_RESOURCE\_QUEUE for the first time on the
> >>>>> +  resource,
> >>>>> +\item
> >>>>> +  AFTER successfully changing the \field{virtio_video_params_resou=
rces}
> >>>>> +  parameter corresponding to the queue and BEFORE
> >>>>> +  VIRTIO\_VIDEO\_CMD\_RESOURCE\_QUEUE is called again on the resou=
rce.
> >>>>> +\end{itemize}
> >>>>> +
> >>>>> +This is to ensure that the device can rely on the fact that a give=
n
> >>>>> +resource will always point to the same memory for as long as it ma=
y be
> >>>>> +used by the video device. For instance, a decoder may use returned
> >>>>> +decoded frames as reference for future frames and won't overwrite =
the
> >>>>> +backing resource of a frame that is being referenced. It is only b=
efore
> >>>>> +a stream is started and after a Dynamic Resolution Change event ha=
s
> >>>>> +occurred that we can be sure that all resources won't be used in t=
hat
> >>>>> +way.
> >>>> The mentioned scenario about the referenced frames looks
> >>>> somewhatreasonable, but I wonder how exactly would that work in prac=
tice.
> >>> Basically the guest need to make sure the backing memory remains
> >>> available and unwritten until the conditions mentioned above are met.
> >>> Or is there anything unclear in this description?
> >> Ok, I read the discussions about whether to allow the device to have
> >> read access after response to QUEUE or not. Since this comes from v4l2=
,
> >> then this should not be a problem, I think. I didn't know that v4l2
> >> expects the user-space to never write to CAPTURE buffers after they
> >> dequeued. I wonder if it is enforced in drivers.
>
> Actually I have more on this. I'd prefer if there is a requirement for
> the driver or the device to handle a case when a still referenced frame
> is queued again. So that it is less likely to be forgotten.

With the stateful API, the driver/device is in charge of making sure
submitted reference frames are not overwritten as long as there is a
reference to them. I.e. the driver or device firmware will reorder to
frames to avoid that, so there is indeed the requirement you describe.

With the stateless API, user-space is in charge of reference frames
reordering and the driver is only an executor - if user-space does
something damaging to itself, it will get corrupted frames.

I hope this clarifies things a bit - let's go to the bottom of any
remaining concern to make sure we make the right call here.

Cheers,
Alex.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

