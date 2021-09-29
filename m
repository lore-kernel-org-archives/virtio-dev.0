Return-Path: <virtio-dev-return-8746-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D96CC98650B
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Sep 2021 16:33:46 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <1632883462.8908377-1-xuanzhuo@linux.alibaba.com>
References: <1632883462.8908377-1-xuanzhuo@linux.alibaba.com>
Date: Wed, 29 Sep 2021 18:33:41 +0200
Message-ID: <87tui349zu.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v4 2/3] virtio: pci support virtqueue reset
Content-Type: text/plain
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Sep 29 2021, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> On Tue, 28 Sep 2021 12:20:46 +0200, Cornelia Huck <cohuck@redhat.com> wrote:
>> On Tue, Sep 28 2021, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>> > +The device MUST reset the queue when 1 is written to \field{queue_reset}, and
>> > +present a 1 in \field{queue_reset} after the queue has been reset, until the
>> > +driver re-enables the queue via \field{queue_enable}. (see \ref{sec:Virtqueues / Virtqueue Reset}).
>>
>> "...or the device is reset." ?
>>
>
>     The device MUST reset the queue when 1 is written to \field{queue_reset}, and
>     present a 1 in \field{queue_reset} after the queue has been reset, until the
>     driver re-enables the queue via \field{queue_enable} or the device is reset. (see \ref{sec:Virtqueues / Virtqueue Reset}).
>
> Is that so? Doesn't it feel necessary?

Is queue_reset supposed to persist across device reset? That feels a bit
odd to me.

>
>
>> Maybe also
>>
>> "The device MAY change the value of \field{queue_size} if the queue has
>> been reset." ?
>>
>> Should it always set that field to the currently maximum supported queue
>> size (assuming that can change dynamically)? Do we need some kind of
>> synchronization for those changes?
>
> When the queue is reset, all states of this queue MUST be modified to the
> initial value. For example, queue_size MUST be reset to the maximum value
> supported by the device. Because in the last reset queue or the entire device
> reset process, the driver will modify the queue_size of the device so that its
> value may be less than the maximum value.

I think the question is whether the device may choose a different
initial maximum value once the queue has been reset. If it does change
the value, there may be a race where the driver has reset the queue,
read queue_reset back, read the max queue size, and the device only then
changing the max queue size. Maybe I'm overthinking this.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

