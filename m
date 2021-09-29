Return-Path: <virtio-dev-return-8745-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BA23A9864C9
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Sep 2021 16:24:42 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <CACGkMEsUJPNxLPY8WRozbnQcWu6Wh74TuJdH7BOnsB+YeOM-hA@mail.gmail.com>
References: <87a6jx581i.fsf@redhat.com>
 <1632880874.5102866-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsUJPNxLPY8WRozbnQcWu6Wh74TuJdH7BOnsB+YeOM-hA@mail.gmail.com>
Date: Wed, 29 Sep 2021 18:24:34 +0200
Message-ID: <87wnmz4af1.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH v4 1/3] virtio: introduce virtqueue
 reset as basic facility
Content-Type: text/plain
To: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Sep 29 2021, Jason Wang <jasowang@redhat.com> wrote:

> On Wed, Sep 29, 2021 at 10:01 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>>
>> On Tue, 28 Sep 2021 12:06:01 +0200, Cornelia Huck <cohuck@redhat.com> wrote:
>> > On Tue, Sep 28 2021, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>> >
>> > > This patch allows the driver to reset a queue individually.
>> > >
>> > > This is very common on general network equipment. By disabling a queue,
>> > > you can quickly reclaim the buffer currently on the queue. If necessary,
>> > > we can reinitialize the queue separately.
>> > >
>> > > For example, when virtio-net implements support for AF_XDP, we need to
>> > > disable a queue to release all the original buffers when AF_XDP setup.
>> > > And quickly release all the AF_XDP buffers that have been placed in the
>> > > queue when AF_XDP exits.
>> > >
>> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> > > ---
>> > >  content.tex | 45 +++++++++++++++++++++++++++++++++++++++++++++
>> > >  1 file changed, 45 insertions(+)
>> > >
>> > > diff --git a/content.tex b/content.tex
>> > > index 37c45d3..05b05ba 100644
>> > > --- a/content.tex
>> > > +++ b/content.tex
>> > > @@ -407,6 +407,47 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
>> > >  types. It is RECOMMENDED that devices generate version 4
>> > >  UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>> > >
>
> Btw, we need to add this into the section of "Virtqueues"


Hm, isn't it already?

>
>> > > +\section{Virtqueue Reset}\label{sec:Virtqueues / Virtqueue Reset}
>> > > +
>> > > +When VIRTIO_F_RING_RESET is negotiated, the driver can reset a virtqueue
>> > > +individually. The way to reset the virtqueue is transport specific.
>> > > +
>> > > +Virtqueue reset is divided into two parts. The driver reset a queue
>> > > +first, and then re-enable the queue. The re-enable part is optional.
>> >
>> > Maybe
>> >
>> > "The driver first resets a queue and can afterwards optionally re-enable
>> > it."
>> >
>> > ?
>> >
>> > > +
>> > > +\subsection{Virtqueue Reset}\label{sec:Virtqueues / Virtqueue Reset / Virtqueue Reset}
>> > > +
>> > > +\devicenormative{\subsubsection}{Virtqueue Reset}{Virtqueues / Virtqueue Reset / Virtqueue Reset}
>> > > +
>> > > +After a queue has been reset by the driver, the device MUST NOT execute
>> > > +any requests from that virtqueue, or notify the driver for it.
>> > > +
>> > > +The device MUST re-initialize any state of a virtqueue that has been
>> > > +reset, including available and used state.
>
> Maybe "The device must reset any state..."

"reset to defaults"? Otherwise, it seems a bit redundant.

>
>> > > +
>> > > +\drivernormative{\subsubsection}{Virtqueue Reset}{Virtqueues / Virtqueue Reset / Virtqueue Reset}
>> > > +
>> > > +After the driver tell the device to reset a queue, the driver MUST verify that
>> >
>> > s/tell/tells/ (may have been my typo...)
>> >
>> > > +the queue has actually been reset.
>> > > +
>> > > +After the queue has been successfully reset, the driver MAY release any
>> > > +resource associated with that virtqueue.
>> > > +
>> > > +\subsection{Virtqueue Re-enable}\label{sec:Virtqueues / Virtqueue Reset / Virtqueue Re-enable}
>> > > +
>> > > +This process is the same as the initialization process of a single queue during
>> > > +the initialization of the entire device.
>> > > +
>> > > +\devicenormative{\subsubsection}{Virtqueue Re-enable}{Virtqueues / Virtqueue Reset / Virtqueue Re-enable}
>> > > +
>> > > +The device MUST receive the new configuration from the driver. (i.e. the maximum
>> > > +Queue Size.)
>> >
>> > Maybe
>> >
>> > "The device MUST observe any queue configuration that may have been
>> > changed by the driver, like the maximum queue size."
>> >
>> > Although I'm not sure about 'observe'. Anybody have a better term?
>
> I wonder if this is implied in the queue_enable or we need to explain
> the semantics of "queue_enable" instead of here. Considering we list
> queue reset and basic facility, we need to explicitly add queue enable
> into the basic facility first.

I'm wondering whether we need to clarify explicitly that the driver may
re-enable the queue with different parameters?

>
>> >
>> > > +
>> > > +\drivernormative{\subsubsection}{Virtqueue Re-enable}{Virtqueues / Virtqueue Reset / Virtqueue Re-enable}
>> > > +
>> > > +The driver MUST apply for resources, set new configuration to the device, and
>> > > +finally activate the device.
>> >
>> > Maybe
>> >
>> > "When re-enabling a queue, the driver MUST configure the queue resources
>> > as during initial virtqueue discovery, but optionally with different
>> > parameters."
>> >
>> > ?
>
> If we make the queue enablement as a subsection, we can move this
> there. Then we don't need to differ enable and re-enable.

Yes, I notice we are a bit light on details about queue
discovery/enablement. It's basically all in the transport-specific sections.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

