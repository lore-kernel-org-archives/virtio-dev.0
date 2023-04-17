Return-Path: <virtio-dev-return-12258-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09AAC77B70
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 14:43:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DC40A7AF05
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 14:43:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C0A64986353
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 14:43:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AB96698632B; Mon, 17 Apr 2023 14:43:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 99BB698634A
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Apr 2023 14:43:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: pa2-3mjhOeyBKrfOhscqLA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Alexander Gordeev <alexander.gordeev@opensynergy.com>, Alexandre Courbot
 <acourbot@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Keiichi Watanabe
 <keiichiw@chromium.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Marcin
 Wojtas <mwojtas@google.com>, Matti =?utf-8?Q?M=C3=B6ll?=
 <Matti.Moell@opensynergy.com>,
 Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata
 <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>,
 Peter Griffin <peter.griffin@linaro.org>, =?utf-8?Q?Bart=C5=82omiej?=
 Grzesik
 <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, Enric Balletbo i Serra
 <eballetb@redhat.com>, Albert Esteve <aesteve@redhat.com>
In-Reply-To: <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com>
Organization: Red Hat GmbH
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com>
 <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com>
 <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com>
 <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com>
 <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com>
 <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com>
 <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 17 Apr 2023 16:43:19 +0200
Message-ID: <87o7nmk1rs.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On Mon, Apr 17 2023, Alexander Gordeev <alexander.gordeev@opensynergy.com> =
wrote:

> Hi Alexandre,
>
> Thanks for you letter! Sorry, it took me some time to write an answer.
>
> First of all I'd like to describe my perspective a little bit because it
> seems, that in many cases we (and other people writing their feedbacks)
> simply have very different priorities and background.

Thank you for describing the environment you want to use this in, this
helps to understand the different use cases.

>
> OpenSynergy, the company that I work for, develops a proprietary
> hypervisor called COQOS mainly for automotive and aerospace domains. We
> have our proprietary device implementations, but overall our goal is to
> bring open standards into these quite closed domains and we're betting
> big on virtio. The idea is to run safety-critical functions like cockpit
> controller alongside with multimedia stuff in different VMs on the same
> physical board. Right now they have it on separate physical devices. So
> they already have maximum isolation. And we're trying to make this
> equally safe on a single board. The benefit is the reduced costs and
> some additional features. Of course, we also need features here, but at
> the same time security and ease of certification are among the top of
> our priorities. Nobody wants cars or planes to have security problems,
> right? Also nobody really needs DVB and even more exotic devices in cars
> and planes AFAIK.
>
> For the above mentioned reasons our COQOS hypervisor is running on bare
> metal. Also memory management for the guests is mostly static. It is
> possible to make a shared memory region between a device and a driver
> managed by device in advance. But definitely no mapping of random host
> pages on the fly is supported.
>
> AFAIU crosvm is about making Chrome OS more secure by putting every app
> in its own virtualized environment, right? Both the host and guest are
> linux. In this case I totally understand why V4L2 UAPI pass-through
> feels like a right move. I guess, you'd like to make the switch to
> virtualized apps as seemless as possible for your users. If they can't
> use their DVBs anymore, they complain. And adding the virtualization
> makes the whole thing more secure anyway. So I understand the desire to
> have the range of supported devices as broad as possible. It is also
> understandable that priorities are different with desktop
> virtualization. Also I'm not trying to diminish the great work, that you
> have done. It is just that from my perspective this looks like a step in
> the wrong direction because of the mentioned concerns. So I'm going to
> continue being a skeptic here, sorry.
>
> Of course, I don't expect that you continue working on the old approach
> now as you have put that many efforts into the V4L2 UAPI pass-through.
> So I think it is best to do the evolutionary changes in scope of virtio
> video device specification, and create a new device specification
> (virtio-v4l2 ?) for the revolutionary changes. Then I'd be glad to
> continue the virtio-video development. In fact I already started making
> draft v7 of the spec according to the comments. I hope it will be ready
> for review soon.
>
> I hope this approach will also help fix issues with virtio-video spec
> and driver development misalignment as well as V4L2 compliance issues
> with the driver. I believe the problems were caused partly by poor
> communication between us and by misalignment of our development cycles,
> not by the driver complexity.
>
> So in my opinion it is OK to have different specs with overlapping
> functionality for some time. My only concern is if this would be
> accepted by the community and the committee. How the things usually go
> here: preferring features and tolerating possible security issues or the
> other way around? Also how acceptable is having linux-specific protocols
> at all?

My main question is: What would be something that we can merge as a
spec, that would either cover the different use cases already, or that
could be easily extended to cover the use cases it does not handle
initially?

For example, can some of the features that would be useful in crosvm be
tucked behind some feature bit(s), so that the more restricted COQOS
hypervisor would simply not offer them? (Two feature bits covering two
different mechanisms, like the current approach and the v4l2 approach,
would also be good, as long as there's enough common ground between the
two.)

If a staged approach (adding features controled by feature bits) would
be possible, that would be my preferred way to do it.

Regarding the protocol: I think Linux-originating protocols (that can be
implemented on non-Linux setups) are fine, Linux-only protocols probably
not so much.

>
> Also I still have concerns about memory management with V4L2 UAPI
> pass-through. Please see below.
>
> On 17.03.23 08:24, Alexandre Courbot wrote:
>> Hi Alexander,
>>
>> On Thu, Mar 16, 2023 at 7:13=E2=80=AFPM Alexander Gordeev
>> <alexander.gordeev@opensynergy.com> wrote:
>>> Hi Alexandre,
>>>
>>> On 14.03.23 06:06, Alexandre Courbot wrote:
>>>> The spec should indeed be considerably lighter. I'll wait for more
>>>> feedback, but if the concept appeals to other people as well, I may
>>>> give the spec a try soon.
>>> Did you receive an email I sent on February 7? There was some feedback
>>> there. It has been already established, that V4L2 UAPI pass-through is
>>> technically possible. But I had a couple of points why it is not
>>> desirable. Unfortunately I haven't received a reply. I also don't see
>>> most of these points addressed in any subsequent emails from you.
>>>
>>> I have more to say now, but I'd like to make sure that you're intereste=
d
>>> in the discussion first.
>> Sorry about that, I dived head first into the code to see how viable
>> the idea would be and forgot to come back to you. Let me try to answer
>> your points now that I have a better idea of how this would work.
>>
>>>> If we find out that there is a benefit in going through the V4L2
>>>> subsystem (which I cannot see for now), rebuilding the UAPI structures
>>>> to communicate with the device is not different from building
>>>> virtio-video specific structures like what we are currently doing.
>>> Well, the V4L2 subsystem is there for a reason, right? It does some
>>> important things too. I'm going to check all the v4l2_ioctl_ops
>>> callbacks in the current virtio-video driver to make the list. Also if
>>> you have some PoC spec/implementations, that would be nice to review. I=
t
>>> is always better to see the actual implementation, of course.
>>>
>>> I have these points so far:
>>>
>>> 1. Overall the V4L2 stateful decoder API looks significantly more
>>> complex to me. Looks like you're a V4L2 expert, so this might not be
>>> visible to you that much.
>> V4L2 is more generic than virtio-video, so as a result specific uses
>> tend to require a bit more operations. I would argue the mental
>> overhead of working with it is less than significant, and most of it
>> consists in not forgetting to call STREAMON on a queue after some
>> operations. Things like format, resolution and buffer management do
>> not get more complex (and V4L2 is actually more complete than our
>> previous proposal on these).
>>
>> The counterpart of this marginal extra complexity is that you can
>> virtualize more kinds of devices, and even within virtio-video support
>> more formats than what has been specified so far. If your guest is
>> Linux, the same kernel driver can be used to expose any kind of device
>> supported by V4L2, and the driver is also much simpler than
>> virtio-video, so you are actually reducing complexity significantly
>> here. Even if you are not Linux, you can share the V4L2 structures
>> definitions and low-layer code that sends V4L2 commands to the host
>> between drivers. So while it is true that some specifics become
>> slightly more complex, there is a lot of potential simplification when
>> you look at the whole picture.
>>
>> It's an opinionated proposal, and it comes with a few compromises if
>> you are mostly interested in codecs alone. But looking at the guest
>> driver convinces me that this is the better approach when you look at
>> the whole picture.
>
> Sorry, I just see it differently as I tried to describe above. The
> problem is that we don't yet see the whole picture with the V4L2 UAPI
> pass-through. I reviewed the code briefly. It is great, that you already
> implemented the MMAP mode and host allocations already. But I would
> argue, that this is the simplest case. Do you agree? Also this mode of
> operation is not supported in our hypervisor for reasons mentioned
> above. So in our case this PoC doesn't yet prove anything unfortunately.
> I think the real complexity is yet to come.
>
>
>>>     a. So V4L2 subsystem and the current virtio-video driver are alread=
y
>>> reducing the complexity. And this seems as the right place to do this,
>>> because the complexity is caused by the amount of V4L2 use cases and it=
s
>>> legacy. If somebody wants to use virtio-video in a Windows guest, they
>>> would prefer a simpler API, right? I think this use-case is not purely
>>> abstract at all.
>> The V4L2 subsystem is there to factorize code that can be shared
>> between drivers and manage their internal state. Our target is the
>> V4L2 UAPI, so a Windows driver needs not be concerned about these
>> details - it does what it would have done with virtio-video, and just
>> uses the V4L2 structures to communicate with the host instead of the
>> virtio-video ones.
>
> It can also reuse the virtio-video structures. So I think despite the
> ability to reuse V4L2 structures, having to implement a linux-specific
> interface would still be a bigger pain.

Hm. Do the v4l2 structures drag in too many adjacent things that need to
be implemented? Can we match the video-video structures from the current
proposal with some v4l2 structures and extract a common wrapper for
those that match, with a feature-bit controlled backend? It would be
fine if any of those backends supported a slightly different subset of
the common parts, as long as the parts implemented by both would be
enough to implement a working device. (Mostly thinking out loud here.)

>
>
>>>     b. Less complex API is better from a security point of view too. Wh=
en
>>> V4L2 was developed, not many people were concerned with malicious USB
>>> devices probably. At least exploiting a malicious USB device usually
>>> requires physical access. With virtual devices and multiple VMs the
>>> stakes are higher, I believe.
>> That's probably true, but I fail to see how the fact we are using
>> struct v4l2_buffer instead of struct virtio_video_buffer can have an
>> impact on that?
>>
>> V4L2 has a larger UAPI surface because it manages more kinds of
>> devices, but drivers only need to implement the ioctls they need. For
>> the rest, they just return -ENOTTY, and evil actors are hopefully kept
>> at bay.
>
> Still there are definitely more ways to do things wrong. It would be
> harder to audit a larger API surface.
>
>
>>> 2. We have a working virtio-video driver. So we need very good reasons
>>> to start from scratch. You name two reasons AFAIR: simplicity and
>>> possible use of cameras. Did I miss something else?
>>>
>>>     a. The simplicity is there only in case all the interfaces are V4L2=
,
>>> both in the backend and in the guest. Otherwise the complexity is just
>>> moved to backends. I haven't seen V4L2 in our setups so far, only some
>>> proprietary OMX libraries. So from my point of view, this is not
>>> simplicity in general, but an optimization for a specific narrow use ca=
se.
>> V4L2 is not a narrow use-case when it comes to video devices on Linux
>> - basically every user space application involving cameras or codecs
>> can use it. Even the virtio-video driver exposes a V4L2 device, so
>> unless you are using a different driver and proprietary userspace apps
>> specifically written to interact with that driver, V4L2 is involved in
>> your setup at some point.
>
> Sorry, I mean narrow use-case if we look into other possibilities:
>
> 1. Stateless V4L2 on the host.
> 2. Any other interface on the host.
> 3. Any other guest except Linux.
>
> Our targets are several popular embedded SoCs. Unfortunately we don't
> have the luxury of simply having normal V4L2 devices there. And it
> doesn't look like this is going to change.
>
>
>> The guest driver that I wrote is, I think, a good example of the
>> complexity you can expect in terms of guest driver size (as it is
>> pretty functional already with its 1000 and some LoCs). For the UAPI
>> complexity, the host device basically unpacks the information it needs
>> and rebuilds the V4L2 structures before calling into the host device,
>> and I don't see this process as more complex that the unpacking of
>> virtio-video structs which we also did in crosvm.
>
> Unfortunately our hypervisor doesn't support mapping random host pages
> in the guest. Static allocations of shared memory regions are possible.
> But then we have to tell V4L2 to allocate buffers there. Then we'll need
> a region per virtual device. This is just very tedious and inflexible.
> That's why we're mainly interested in having the guest pages sharing in
> the virtio video spec.

This really sounds like you'll want a different approach -- two
mechanisms covered by two feature bits might indeed be the way to go.

>
>
>>>     b. For modern cameras the V4L2 interface is not enough anyway. This
>>> was already discussed AFAIR. There is a separate virtio-camera
>>> specification, that indeed is based on V4L2 UAPI as you said. But
>>> combining these two specs is certainly not future proof, right? So I
>>> think it is best to let the virtio-camera spec to be developed
>>> independently.
>> I don't know if virtio-camera has made progress that they have not
>> published yet, but from what I have seen virtio-v4l2 can cover
>> everything that the currently published driver does (I could not find
>> a specification, but please point me to it if it exists), so there
>> would be no conflict to resolve.
>>
>> V4L2 with requests support should be capable of handling complex
>> camera configurations, but the effort indeed seems to have switched to
>> KCAM when it comes to supporting complex native cameras natively. That
>> being said:
>>
>> * KCAM is not merged yet, is probably not going to be for some time
>> (https://lwn.net/Articles/904776/), and we don't know how we can
>> handle virtualization with it,
>> * The fact that the camera is complex on the host does not mean that
>> all that complexity needs to be exposed to the guest. I don't know how
>> the camera folks want to manage this, but one can imagine that the
>> host could expose a simpler model for the virtual camera, with only
>> the required knobs, while the host takes care of doing all the complex
>> configuration.
>> * The counter argument can be made that simple camera devices do not
>> need a complex virtualization solution, so one can also invoke
>> simplicity here to advocate for virtio-v4l2.
>>
>> My point is not to say that all other camera virtualization efforts
>> should be abandoned - if indeed there is a need for something more
>> specific, then nothing prevents us from having a virtio-camera
>> specification added. However, we are nowhere close to this at the
>> moment, and right now there is no official solution for camera
>> virtualization, so I see no reason to deny the opportunity to support
>> simple camera devices since its cost would just be to add "and cameras
>> device" in the paragraph of the spec that explains what devices are
>> supported.
>
> Well, for reasons described above it still seems perfectly fine to me to
> have separate devices. Ok, the argument, that this approach also seems
> more future-proof, is not a strong one.
>
>
>>> 3. More specifically I can see, that around 95% V4L2 drivers use
>>> videobuf2. This includes the current virtio-video driver. Bypassing the
>>> V4L2 subsystem means that vb2 can't be used, right? In various
>>> discussions vb2 popped up as a thing, that would be hard to avoid. What
>>> do you think about this? How are you going to deal with various V4L2
>>> memory types (V4L2_MEMORY_MMAP, V4L2_MEMORY_DMABUF, etc), for example?
>>> I'll try to dive deeper myself too...
>> VB2 is entirely avoided in the current driver, but my understanding is
>> that its helpers could be used if needed.
>>
>> In virtio-v4l2, MMAP means that the host is responsible for managing
>> the buffers, so vb2 is entirely avoided. USERPTR means the guest
>> passes a SG list of guest physical addresses as mapping memory. VB2
>> may or may not be involved in managing this memory, but most likely
>> not if that memory comes from the guest userspace. DMABUF means the
>> guest passes a virtio object as the backing memory of the buffer.
>> There again there is no particular management to be done on the guest
>> side.
>>
>> I bypassed VB2 for the current driver, and the cost of doing this is
>> that I had to write my own mmap() function.
>
> The cost of it as of now is also that:
>
> 1. Only guest user-space applications, that use V4L2_MEMORY_MMAP, are
> supported AFAIU.
> 2. There is no flexibility to choose whatever way of memory management
> host and guest would like to use. Now the guest user-space application
> selects this.
>
> The latter makes the solution much less flexible IMO. For example, this
> won't work well with our hypervisor. There might other special needs in
> other use-cases. Like sharing these object UUIDs. Probably this can
> handled by mapping, for example, V4L2_MEMORY_USERPTR to guest-pages
> sharing, V4L2_MEMORY_DMABUF to the UUIDs (which is not quite correct
> IMHO). So this already means querying the device for supported sharing
> methods, rewriting the flow of V4L2 UAPI calls on the fly, ensuring
> consistency, etc. This already looks hackish to me. Do you have a better
> plan? Also this limits us to only 3 methods, right? And what if there
> are more than 3 methods in the future?
>
> I think this inflexibility is a major problem with this approach.
>
>
>>>> Actually I don't think this is even something we need to think about -
>>>> in its simplest form the V4L2 guest driver just needs to act as a
>>>> proxy for the device. So which decoder API is used by the host is
>>>> completely irrelevant to the guest driver - it can support a decoder,
>>>> an encoder, or a camera - it doesn't even need to be aware of what
>>>> kind of device it is exposing and that simplicity is another thing
>>>> that I like with this design.
>>> As I wrote above the design would be indeed simple only in case the
>>> actual hardware is exposed to a backend through V4L2 too. Otherwise the
>>> complexity is just moved to backends.
>> Yes, and while I acknowledge that, this is not really more complex
>> that what you would have to do with a virtio-video device which also
>> needs to manage its own state and drive the hardware through backends.
>> I say that based on the experience working on the virtio-video device
>> in crosvm which follows that design too.
>
> As I wrote above we have a different use-case. And I see the current
> state of virtio video as a good common ground for different parties and
> use-cases. Unfortunately I don't see any upsides for our use-cases from
> the V4L2 UAPI proposal, only downsides.
>
>
>>>> This simplicity goes away if the guest device does not use V4L2 as its
>>>> user-space interface (e.g. Windows?). In this case we would be in the
>>>> exact same scenario as the current virtio-video spec, where we need to
>>>> build device-specific structures from the guest driver's internal
>>>> state.
>>> IMO this is not quite correct. The scenario would not be not the same,
>>> because the V4L2 stateful decoder API is more complex in comparison to
>>> any virtio-video spec draft version. Probably it would be great to have
>>> a list of differences. I hope to find some time for this later...
>> There is not much difference between the V4L2 stateful decoder spec
>> and the virtio-video spec. Actually that's the very reason why I am
>> proposing to just virtualize V4L2, we were redoing the same thing.
>>
>> I have quickly parsed the V4L2 decoder spec and here are the
>> differences I have found:
>>
>> * VIDIOC_STREAMON needs to be called on both queues to start decoding.
>> * Frame crop is obtained using VIDIOC_G_SELECTION instead of being
>> available alongside the format parameter.
>> * End of drain requires to send the V4L2_DEC_CMD_START and call
>> VIDIOC_STREAMON again.
>> * Seeking is done by calling VIDIOC_STREAMOFF followed by
>> VIDIOC_STREAMON on the OUTPUT queue instead of having a dedicated
>> command.
>>
>> ... and that's basically it! Do we really need a new spec just to
>> smoothen these differences?
>
> If we look deeper there are more differences. I'm still preparing the
> list. Sorry, it takes time.
>
>
>> I hope I have somehow addressed your points. The main point here is to
>> discuss whether the V4L2 UAPI is a suitable transport for guest/host
>> accelerated codec work, regardless of what the guest or host
>> ultimately uses as UAPI. The goal of the PoC is to demonstrate that
>> this is a viable solution. This PoC is largely simplified by the fact
>> that V4L2 is used all along the way, but this is irrelevant - yes,
>> actual devices will likely talk to other APIs and maintain more state,
>> like a virtio-video device would do. What I want to demonstrate is
>> that we can send encoding work and receive a valid stream, and that it
>> is not costly, and only marginally more complex than our virtio-video
>> spec attempts.
>>
>> ... and we can support cameras too, but that's just a convenient
>> side-effect, not the ultimate solution to the camera virtualization
>> problem (that's for the camera folks to decide).
>
> Thanks for your answer!

Thanks everyone -- do you think the "two feature bits to cover different
approaches, but using a common infrastructure" idea could work? If yes,
I think that's the direction we should take. If we can implement this
with just one feature bit, that might also be a good route to extend it
later, but I'm not familiar enough with the whole infrastructure to make
any judgement here.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

