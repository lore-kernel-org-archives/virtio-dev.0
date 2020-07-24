Return-Path: virtio-dev-return-7618-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 105A6985E8D
	for <virtio-dev@lists.oasis-open.org>; Fri, 24 Jul 2020 17:31:52 +0000 (UTC)
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-2-ndragazis@arrikto.com> <87v9inv26c.fsf@linaro.org>
 <20200717092635.GB128195@stefanha-x1.localdomain>
 <20200724103627-mutt-send-email-mst@kernel.org>
From: Nikos Dragazis <ndragazis@arrikto.com>
Message-ID: <f6e7491b-127e-30e3-99ca-de1aa8c6527e@arrikto.com>
Date: Fri, 24 Jul 2020 20:31:48 +0300
MIME-Version: 1.0
In-Reply-To: <20200724103627-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v5 01/10] vhost-user: add vhost-user device
 type
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 24/7/20 5:41 =CE=BC.=CE=BC., Michael S. Tsirkin wrote:

> On Fri, Jul 17, 2020 at 10:26:35AM +0100, Stefan Hajnoczi wrote:
>>>> +The following additional resources exist:
>>>> +\begin{description}
>>>> +  \item[Doorbells] The driver signals the vhost-user master through d=
oorbells.  The signal does not carry any data, it is purely an event.
>>>> +  \item[Notifications] The vhost-user master signals the driver for e=
vents besides virtqueue activity and configuration changes by sending notif=
ications.
>>> What is the difference between a doorbell and a notification?
>> Doorbells allow the driver to signal the device (i.e. device hardware
>> registers that the driver writes to).
>>
>> Notifications allow the driver to be signalled by the device (i.e. MSI-X
>> interrupts that the driver handles).
>>
>> The more abstract "doorbell" and "notification" terms are used instead
>> of hardware registers and interrupts because transports other than PCI
>> may want to support these features too.
> I think notification and doorbell are a bit too generic of a name.
>
> What we have is:
> available buffer notifications, used buffer
> notifications, configuration change notifications.

The problem with the virtio-vhost-user device is that it must be able to
exchange notifications (with the driver) that have nothing to do with
the notification types that you mentioned. Specifically, the
virtio-vhost-user device must be able to send/receive notifications
regarding activity on the vhost-user virtqueues.

The vhost-user virtqueues are not processed by the virtio-vhost-user
device and they have nothing to do with the RX/TX virtqueues of the
virtio-vhost-user device. I think this is the main reason why we don't
want to use the existing registers that we use for virtqueue
notifications.

So, my point is that we could extend the notion of a "notification".
A notification could be either one of the following:

1. available buffer notification
2. used buffer notification
3. configuration change notification
4. driver-to-device notification for other purposes
5. device-to-driver notification for other purposes

>
>
> So how about XXX notifications for both of these things?
> Where XXX explains what is the reason for triggering each
> type of notification.

I guess Stefan introduced the term "doorbell" because it is a widely
used term (e.g., in NVMe devices) and I think it is a pretty good
term. However, I agree that the vague term "notification" may cause
confusion.

Replacing "doorbells" and "notifications" with "XXX notifications"
sounds good. I can't think of some good terms for XXX right now.
Feel free to propose.

>
> It says "besides virtqueue activity and configuration changes" -
> what exactly is there?
>

As I said above, it is about available buffers on the vhost-user
virtqueues. But the vhost-user virtqueues are not related by any means
with the virtio-vhost-user device, so a notification resource in the
virtio-vhost-user device does not fit in the current definition of a
notification in virtio. It is something completely different.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

