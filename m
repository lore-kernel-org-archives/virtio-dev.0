Return-Path: <virtio-dev-return-10720-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD2AE98636C
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Feb 2023 14:12:58 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com>
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com>
 <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com>
 <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com>
Date: Mon, 06 Feb 2023 15:12:51 +0100
Message-ID: <87cz6mnaqk.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification
Content-Type: text/plain
To: Alexander Gordeev <alexander.gordeev@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Marcin Wojtas <mwojtas@google.com>, Matti =?utf-8?Q?M=C3=B6ll?= <Matti.Moell@opensynergy.com>, Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, =?utf-8?Q?Bart=C5=82omiej?= Grzesik <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>, Daniel Almeida <daniel.almeida@collabora.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 19 2023, Alexander Gordeev <alexander.gordeev@opensynergy.com> wrote:

> Hi Alexandre,
>
> On 12.01.23 07:39, Alexandre Courbot wrote:
>> On Thu, Jan 12, 2023 at 3:42 AM Alexander Gordeev
>> <alexander.gordeev@opensynergy.com> wrote:

>>> Well, on the one hand mimicking v4l2 looks like an easy solution from
>>> virtio-video spec writing perspective. (But the implementers will have
>>> to read the V4L2 API instead AFAIU, which is probably longer...)
>> It should not necessarily be much longer as the parts we are
>> interested in have their own dedicated pages:
>>
>> https://docs.kernel.org/userspace-api/media/v4l/dev-decoder.html  <https://docs.kernel.org/userspace-api/media/v4l/dev-decoder.html>https://docs.kernel.org/userspace-api/media/v4l/dev-encoder.html  <https://docs.kernel.org/userspace-api/media/v4l/dev-encoder.html>
>>
>> Besides, the decoding and encoding processes are described with more
>> precision, not that we couldn't do that here but it would make the
>> spec grow longer than I am comfortable with...
>
> I read the references carefully, thanks. I am somewhat familiar with the
> stateful decoder API, but the stateless one still needs exploring.
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
>
> 2. There is already a way to bypass the subsystem completely. I'm not
> aware of that.
>
> 3. user-space <-> v4l2 subsystem API is already the same or very close
> to v4l2 subsystem <-> v4l2 driver API. I believe this is not the case
> even with stateful decoder/encoder. Even more with stateless decoders
> because I can see, that v4l2 subsystem actually stores some state in
> this case as well. Which is quite reasonable I think.
>
> So I think what we need to reference here is v4l2 subsystem <-> v4l2
> driver API. Do you have this reference? Well, I know there is some
> documentation, but still I doubt that. AFAIR kernel internal APIs are
> never fixed. Right?

So, I'm not that familiar with v4l2, but if that's indeed the case,
depending on some kernel internal APIs is a no-go. First, because
in-kernel APIs are not stable, and second, because we want something
that's BSD-licenced (as opposed to GPLv2-licenced) to point to. The
kernel<->userspace API would work (BSD-licenced header and stable); I
had the impression that we wanted to reuse the various #defines in
there -- did I misunderstand?

(...)

>> Let me try to summarize the case for using V4L2 over Virtio (I'll call
>> it virtio-v4l2 to differentiate it from the current spec).
>>
>> There is the argument that virtio-video turns out to be a recreation
>> of the stateful V4L2 decoder API, which itself works similarly to
>> other high-level decoder APIs. So it's not like we could or should
>> come with something very different. In parallel, virtio-camera is also
>> currently using V4L2 as its model. While this is subject to change, I
>> am starting to see a pattern here. :)
>>
>> Transporting V4L2 over virtio would considerably shorten the length of
>> this spec, as we would just need to care about the transport aspect
>> and minor amendments to the meaning of some V4L2 structure members,
>> and leave the rest to V4L2 which is properly documented and for which
>> there is a large collection of working examples.
>>
>> This would work very well for codec devices, but as a side-effect
>> would also enable other kinds of devices that may be useful to
>> virtualize, like image processors, DVB cards, and cameras. This
>> doesn't mean virtio-v4l2 should be the *only* way to support cameras
>> over virtio. It is a nice bonus of encapsulating V4L2, it may be
>> sufficient for simple (most?) use-cases, but also doesn't forbid more
>> specialized virtual devices for complex camera pipelines to be added
>> later. virtio-v4l2 would just be the generic virtual video device that
>> happens to be sufficient for our accelerated video needs - and if your
>> host camera is a USB UVC one, well feel free to use that too.
>>
>> In other words, I see an opportunity to enable a whole class of
>> devices instead of a single type for the same effort and think we
>> should seriously consider this.
>>
>> I have started to put down what a virtio-v4l2 transport might look
>> like, and am also planning on putting together a small
>> proof-of-concept. If I can get folks here to warm up to the idea, I
>> believe we should be able to share a spec and prototype in a month or
>> so.
>
> Thanks for the detailed explanation. Please check my comments above. I'd
> like to resolve the mentioned issue first.

I hope we can sort this out soon -- I guess I'm not the only one who is
anxious about this spec moving forward :) Please let me know if I can
help in any way.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

