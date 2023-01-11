Return-Path: <virtio-dev-return-10560-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C17C9865AA
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Jan 2023 20:20:04 +0000 (UTC)
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com>
 <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 11 Jan 2023 20:13:03 +0000
In-reply-to: <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com>
Message-ID: <87sfggn7rj.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Gordeev <alexander.gordeev@opensynergy.com>
Cc: Alexandre Courbot <acourbot@chromium.org>, virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, Marcin Wojtas <mwojtas@google.com>, Matti =?utf-8?Q?M=C3=B6ll?= <Matti.Moell@opensynergy.com>, Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, =?utf-8?Q?Bart=C5=82omiej?= Grzesik <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>


Alexander Gordeev <alexander.gordeev@opensynergy.com> writes:

> Hi Alexandre,
>
> On 27.12.22 08:31, Alexandre Courbot wrote:
>> Hi Alexander,
>>
>>
>> On Tue, Dec 20, 2022 at 1:59 AM Alexander Gordeev
>> <alexander.gordeev@opensynergy.com> wrote:
>>> Hello Alexandre,
>>>
>>> Thanks for the update. Please check my comments below.
>>> I'm new to the virtio video spec development, so I may lack some
>>> historic perspective. I would gladly appreciate pointing me to some
>>> older emails explaining decisions, that I might not understand. I hope
>>> to read through all of them later. Overall I have a lot of experience i=
n
>>> the video domain and in virtio video device development in Opsy, so I
>>> hope, that my comments are relevant and useful.
>> Cornelia provided links to the previous versions (thanks!). Through
>> these revisions we tried different approaches, and the more we
>> progress the closer we are getting to the V4L2 stateful
>> decoder/encoder interface.
<snip>
>> This probably means a bit more work on the device side, since this
>> spec is tailored for the specific video codec use-case and V4L2 is
>> more generic, but also less spec to maintain and more confidence that
>> things will work as we want in the real world. On the other hand, the
>> device would also become simpler by the fact that responses to
>> commands could not come out-of-order as they currently do. So at the
>> end of the day I'm not even sure this would result in a more complex
>> device.
>
> Sorry for the delay. I tried to gather data about how the spec has
> evolved in the old emails.
>
> Well, on the one hand mimicking v4l2 looks like an easy solution from
> virtio-video spec writing perspective. (But the implementers will have
> to read the V4L2 API instead AFAIU, which is probably longer...)
>
> On the other hand v4l2 has a lot of history. It started as a camera API
> and gained the codec support later, right? So it definitely has just to
> much stuff irrelevant for codecs. Here we have an option to design from
> scratch taking the best ideas from v4l2.

We definitely don't want to bake in Linux APIs into the VirtIO spec
which is meant to be host/guest agnostic if we can help it.

>
> Also I have concerns about the virtio-video spec development. This seems
> like a big change. It seems to me that after so many discussions and
> versions of the spec, the process should be coming to something by now.
> But this is still a moving target...
>
> There were arguments against adding camera support for security and
> complexity reasons during discussions about virtio-video spec v1. Were
> these concerns addressed somehow? Maybe I missed a followup
> discussion?

I think adding camera support would introduce a lot of potential
complexity to the spec - c.f. projects like libcamera and the fact most
modern cameras are more than providing a stream of images. It probably
warrants having its own device specification that is designed from the
outset with cameras in mind.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

