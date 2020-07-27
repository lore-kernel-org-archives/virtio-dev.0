Return-Path: virtio-dev-return-7620-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1EB34985C74
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Jul 2020 18:59:39 +0000 (UTC)
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-2-ndragazis@arrikto.com> <87v9inv26c.fsf@linaro.org>
 <20200717092635.GB128195@stefanha-x1.localdomain>
 <20200724103627-mutt-send-email-mst@kernel.org>
 <f6e7491b-127e-30e3-99ca-de1aa8c6527e@arrikto.com>
 <20200727122521.GA386429@stefanha-x1.localdomain>
From: Nikos Dragazis <ndragazis@arrikto.com>
Message-ID: <21ded3b5-1337-960b-b8ee-bdf6dea4eb93@arrikto.com>
Date: Mon, 27 Jul 2020 21:59:36 +0300
MIME-Version: 1.0
In-Reply-To: <20200727122521.GA386429@stefanha-x1.localdomain>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v5 01/10] vhost-user: add vhost-user device
 type
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 27/7/20 3:25 =CE=BC.=CE=BC., Stefan Hajnoczi wrote:

> On Fri, Jul 24, 2020 at 08:31:48PM +0300, Nikos Dragazis wrote:
>> On 24/7/20 5:41 =CE=BC.=CE=BC., Michael S. Tsirkin wrote:
>>> On Fri, Jul 17, 2020 at 10:26:35AM +0100, Stefan Hajnoczi wrote:
>>> So how about XXX notifications for both of these things?
>>> Where XXX explains what is the reason for triggering each
>>> type of notification.
>> I guess Stefan introduced the term "doorbell" because it is a widely
>> used term (e.g., in NVMe devices) and I think it is a pretty good
>> term. However, I agree that the vague term "notification" may cause
>> confusion.
>>
>> Replacing "doorbells" and "notifications" with "XXX notifications"
>> sounds good. I can't think of some good terms for XXX right now.
>> Feel free to propose.
> Device-specific notifications and device-specific doorbells?
>
> I think these concepts should be part of the core VIRTIO device model so
> that other devices can also define device-specific
> notifications/doorbells in the future.
>
> Stefan

I think that Michael is OK with standardizing these resources, but he is
not really happy with the term "doorbell".

 From the one hand, using the term "XXX notification" would be more
consistent with the virtio spec, since virtio already uses the term
"notification" for driver-to-device signaling regarding the virtqueues.

On the other hand, I can't find something for XXX that would sound
better than "doorbell".

But let's see what Michael has to say.

Nikos

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

