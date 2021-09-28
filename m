Return-Path: <xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
message-id: <1632797250.0032172-1-xuanzhuo@linux.alibaba.com>
subject: Re: [virtio-dev] [PATCH v3 1/2] virtio: introduce virtqueue reset as
 basic facility
date: Tue, 28 Sep 2021 10:47:30 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
in-reply-to: <87v92mccev.fsf@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 27 Sep 2021 16:37:28 +0200, Cornelia Huck <cohuck@redhat.com> wrote:
> On Mon, Sep 27 2021, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> > This patch allows the driver to reset a queue individually.
> >
> > This is very common on general network equipment. By disabling a queue,
> > you can quickly reclaim the buffer currently on the queue. If necessary,
> > we can reinitialize the queue separately.
> >
> > For example, when virtio-net implements support for AF_XDP, we need to
> > disable a queue to release all the original buffers when AF_XDP setup.
> > And quickly release all the AF_XDP buffers that have been placed in the
> > queue when AF_XDP exits.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  content.tex | 41 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/content.tex b/content.tex
> > index 37c45d3..603b1f1 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -407,6 +407,43 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
> >  types. It is RECOMMENDED that devices generate version 4
> >  UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
> >
> > +\section{Virtqueue Reset}\label{sec:Virtqueues / Virtqueue Reset}
> > +
> > +When VIRTIO_F_RING_RESET is negotiated, the driver can reset a virtqueue
> > +individually. The way to reset the virtqueue is transport specific.
> > +
> > +Virtqueue reset is divided into two parts. The driver MUST reset stop a queue
> > +first, and then re-enable the queue. The re-enable part is optional.
>
> 'MUST' is only for use within normative sections. Also, I'm not sure
> 'reset stop' is a good term; I think 'reset' and 're-enable' already pair
> well enough.
>
> > +
> > +\devicenormative{\subsection}{Virtqueue Reset Stop}{Virtqueues / Virtqueue Reset}
> > +The device MUST not executes the requests from this virtqueue, and notify the
> > +driver.
>
> "After a queue has been reset by the driver, the device MUST NOT execute
> any requests from that virtqueue, or notify the driver for it."
>
> ?

Thanks, this is better.

>
> > +
> > +And the device MUST initialize all states of this virtqueue, including the
> > +available state and the used state.
>
> "The device MUST re-initialize any state of a virtqueue that has been
> reset, including available and used state."
>
> ?

Thanks, this is better.
>
> > +
> > +\drivernormative{\subsection}{Virtqueue Reset Stop}{Virtqueues / Virtqueue Reset}
> > +
> > +The driver MUST first notify the device and confirm that we have successfully
> > +stopped a queue.
>
> I don't quite understand that sentence... do you mean that the driver
> must
> - tell the device to reset a queue
> - and then verify that the queue has actually been reset (similar to a
>   full device reset)?
>
> > +
> > +Then the driver can release all the resources occupied by this virtqueue.
> > +And reinitialize the state of this queue.
>
> "After the queue has been successfully reset, the driver MAY release any
> resource associated with that virtqueue."
>
> ?

Thanks, this is better.

>
> > +
> > +\devicenormative{\subsection}{Virtqueue Reset Re-enable}{Virtqueues / Virtqueue Reset}
> > +
> > +This process is the same as the initialization process of a single queue during
> > +the initialization of the entire device. After the device has accepted all the
> > +configuration from the driver, it will start working under the notification of the
> > +driver.
> > +
> > +\drivernormative{\subsection}{Virtqueue Reset Re-enable}{Virtqueues / Virtqueue Reset}
> > +
> > +This process is the same as the initialization process of a single queue during
> > +the entire device initialization process. After the driver allocates resources
> > +and completes the configuration of the queue status, it notifies the device to
> > +start working.
>
> Those two statements don't really read normative, more descriptive. I
> would rather expect some statements as to what the device MUST do when
> the driver does certain things etc. (and have a description of the
> process outside of the normative sections.)

OK.

>
> Are the queue characteristics the same when a queue has been reset and
> is now re-enabled? I.e. may the device change things like the maximum
> queue size while a queue is disabled? I assume the driver may use a
> different size for the queue when it re-enables it?

These features can be modified when re-enable. I will explain this in the next
version.

Thanks very much.

>
> > +
> >  \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
> >
> >  We start with an overview of device initialization, then expand on the
> > @@ -6673,6 +6710,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> >    transport specific.
> >    For more details about driver notifications over PCI see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
> >
> > +  \item[VIRTIO_F_RING_RESET(40)] This feature indicates
> > +  that the driver can reset a queue individually.
> > +  See \ref{sec:Virtqueues / Virtqueue Reset}.
> > +
> >  \end{description}
> >
> >  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

