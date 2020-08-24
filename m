Return-Path: virtio-dev-return-7719-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 143F498432C
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Aug 2020 14:43:50 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-2-ndragazis@arrikto.com> <87v9inv26c.fsf@linaro.org>
 <20200717092635.GB128195@stefanha-x1.localdomain>
 <20200724103627-mutt-send-email-mst@kernel.org>
 <f6e7491b-127e-30e3-99ca-de1aa8c6527e@arrikto.com>
 <20200727122521.GA386429@stefanha-x1.localdomain>
 <21ded3b5-1337-960b-b8ee-bdf6dea4eb93@arrikto.com>
 <20200729094956-mutt-send-email-mst@kernel.org>
 <ea1dc7aa-80bf-21aa-c275-1e9f48f2360c@arrikto.com>
Message-ID: <ad14769b-4cf1-3ddf-3cb1-92a88d9fd60b@arrikto.com>
Date: Mon, 24 Aug 2020 17:43:47 +0300
MIME-Version: 1.0
In-Reply-To: <ea1dc7aa-80bf-21aa-c275-1e9f48f2360c@arrikto.com>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v5 01/10] vhost-user: add vhost-user device
 type
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 30/7/20 12:05 =CF=80.=CE=BC., Nikos Dragazis wrote:

> On 29/7/20 4:52 =CE=BC.=CE=BC., Michael S. Tsirkin wrote:
>
>> On Mon, Jul 27, 2020 at 09:59:36PM +0300, Nikos Dragazis wrote:
>>> On 27/7/20 3:25 =CE=BC.=CE=BC., Stefan Hajnoczi wrote:
>>>
>>>> On Fri, Jul 24, 2020 at 08:31:48PM +0300, Nikos Dragazis wrote:
>>>>> On 24/7/20 5:41 =CE=BC.=CE=BC., Michael S. Tsirkin wrote:
>>>>>> On Fri, Jul 17, 2020 at 10:26:35AM +0100, Stefan Hajnoczi wrote:
>>>>>> So how about XXX notifications for both of these things?
>>>>>> Where XXX explains what is the reason for triggering each
>>>>>> type of notification.
>>>>> I guess Stefan introduced the term "doorbell" because it is a widely
>>>>> used term (e.g., in NVMe devices) and I think it is a pretty good
>>>>> term. However, I agree that the vague term "notification" may cause
>>>>> confusion.
>>>>>
>>>>> Replacing "doorbells" and "notifications" with "XXX notifications"
>>>>> sounds good. I can't think of some good terms for XXX right now.
>>>>> Feel free to propose.
>>>> Device-specific notifications and device-specific doorbells?
>> Um. What does this mean exactly?
>> Really I am guessing you are notifying about some kind of event.
>> So let's call it according to this event then.
>
> It's for available and used buffer notifications on the vhost-user
> virtqueues. We don't want to use this name because it refers to a very
> specific use case and, hence, it is too restrictive. What we want is to
> introduce new types of notifications that will be generic enough so that
> other future devices will be able to use them as well.
>
>>>> I think these concepts should be part of the core VIRTIO device model =
so
>>>> that other devices can also define device-specific
>>>> notifications/doorbells in the future.
>>>>
>>>> Stefan
>>> I think that Michael is OK with standardizing these resources, but he i=
s
>>> not really happy with the term "doorbell".
>>>
>>> =C2=A0From the one hand, using the term "XXX notification" would be mor=
e
>>> consistent with the virtio spec, since virtio already uses the term
>>> "notification" for driver-to-device signaling regarding the virtqueues.
>>>
>>> On the other hand, I can't find something for XXX that would sound
>>> better than "doorbell".
>>>
>>> But let's see what Michael has to say.
>>>
>>> Nikos
>> "doorbells" is generally like available buffer notifications that we
>> have in virtio. I am still not sure what does it mean in this context.
>>
>
> "doorbells" is more generic than available buffer notifications. It will
> refer to any type of driver-to-device notification that will not be an
> available buffer notification.
>
> Think about the vendor-specific capabilities in PCI. They are there so
> that a device manufacturer can implement non-standardized capabilities.
> Similarly, doorbells will be there so that a device can support
> driver-to-device notifications for other things except for available
> buffers.
>
> As an alternative to:
>
> - device-specific doorbells
> - device-specific notifications
>
> I would also put the following names on the table:
>
> - device-specific driver-to-device notifications
> - device-specific device-to-driver notifications
>
> but I like Stefan's better.
>
> Nikos
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

I sent a separate patch for doorbells and notifications. Let's move the
discussion on that thread.

Nikos


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

