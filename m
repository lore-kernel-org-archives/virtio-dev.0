Return-Path: <virtio-dev-return-8750-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC0189865E9
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Sep 2021 11:02:44 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <CACGkMEt9KMvQW9JU3+4PNdDgZ09tuSmi1+=jqhL02ZYz1fUJfw@mail.gmail.com>
References: <87a6jx581i.fsf@redhat.com>
 <1632880874.5102866-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsUJPNxLPY8WRozbnQcWu6Wh74TuJdH7BOnsB+YeOM-hA@mail.gmail.com>
 <87wnmz4af1.fsf@redhat.com>
 <CACGkMEt9KMvQW9JU3+4PNdDgZ09tuSmi1+=jqhL02ZYz1fUJfw@mail.gmail.com>
Date: Thu, 30 Sep 2021 13:02:37 +0200
Message-ID: <87o88a4982.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH v4 1/3] virtio: introduce virtqueue
 reset as basic facility
Content-Type: text/plain
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 30 2021, Jason Wang <jasowang@redhat.com> wrote:

> On Thu, Sep 30, 2021 at 12:24 AM Cornelia Huck <cohuck@redhat.com> wrote:
>>
>> On Wed, Sep 29 2021, Jason Wang <jasowang@redhat.com> wrote:
>>
>> > On Wed, Sep 29, 2021 at 10:01 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>> >>
>> >> On Tue, 28 Sep 2021 12:06:01 +0200, Cornelia Huck <cohuck@redhat.com> wrote:
>> >> > On Tue, Sep 28 2021, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>> >> > > @@ -407,6 +407,47 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
>> >> > >  types. It is RECOMMENDED that devices generate version 4
>> >> > >  UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>> >> > >
>> >
>> > Btw, we need to add this into the section of "Virtqueues"
>>
>>
>> Hm, isn't it already?
>
> Looks not, this follows the section of "Exporting Objects".

Ah, now I see. Yes, this needs to be moved.

>> >> > > +\devicenormative{\subsubsection}{Virtqueue Re-enable}{Virtqueues / Virtqueue Reset / Virtqueue Re-enable}
>> >> > > +
>> >> > > +The device MUST receive the new configuration from the driver. (i.e. the maximum
>> >> > > +Queue Size.)
>> >> >
>> >> > Maybe
>> >> >
>> >> > "The device MUST observe any queue configuration that may have been
>> >> > changed by the driver, like the maximum queue size."
>> >> >
>> >> > Although I'm not sure about 'observe'. Anybody have a better term?
>> >
>> > I wonder if this is implied in the queue_enable or we need to explain
>> > the semantics of "queue_enable" instead of here. Considering we list
>> > queue reset and basic facility, we need to explicitly add queue enable
>> > into the basic facility first.
>>
>> I'm wondering whether we need to clarify explicitly that the driver may
>> re-enable the queue with different parameters?
>
> I think we need, my understanding is that at least the driver can set
> a different queue address etc.

Yes, that seems fundamental.

Maybe we can move that to the individual transports, and note there for
the individual fields that they may be populated by different values
after a queue reset? Although I do not like that very much. However, I'm
struggling a bit with a good wording here.

>
>>
>> >
>> >> >
>> >> > > +
>> >> > > +\drivernormative{\subsubsection}{Virtqueue Re-enable}{Virtqueues / Virtqueue Reset / Virtqueue Re-enable}
>> >> > > +
>> >> > > +The driver MUST apply for resources, set new configuration to the device, and
>> >> > > +finally activate the device.
>> >> >
>> >> > Maybe
>> >> >
>> >> > "When re-enabling a queue, the driver MUST configure the queue resources
>> >> > as during initial virtqueue discovery, but optionally with different
>> >> > parameters."
>> >> >
>> >> > ?
>> >
>> > If we make the queue enablement as a subsection, we can move this
>> > there. Then we don't need to differ enable and re-enable.
>>
>> Yes, I notice we are a bit light on details about queue
>> discovery/enablement. It's basically all in the transport-specific sections.
>>
>
> Yes.
> Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

