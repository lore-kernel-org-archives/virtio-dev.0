Return-Path: virtio-dev-return-3269-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Date: Sat, 24 Feb 2018 13:17:08 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180224051706.fjemv3etmswgyqjz@debian>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
 <20180216092412-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180216092412-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v8 08/16] packed virtqueues: more efficient virtqueue
 layout
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 16, 2018 at 09:24:12AM +0200, Michael S. Tsirkin wrote:
[...]
> +\subsection{Scatter-Gather Support}
> +\label{sec:Packed Virtqueues / Scatter-Gather Support}
> +
> +Some drivers need an ability to supply a list of multiple buffer
> +elements (also known as a scatter/gather list) with a request.
> +Two optional features support this: descriptor
> +chaining and indirect descriptors.
> +
> +If neither feature has been negotiated, each buffer is
> +physically-contigious, either read-only or write-only and is
> +described completely by a single descriptor.

Based on the updates in "Descriptor Chaining" section
and the below note in cover letter:

- dropped _F_DESC_LIST, 1.0 includes this unconditionally, we
  can do same

Descriptor chaining is always available.

> +
[...]
> +\subsection{Event Suppression Structure Format}\label{sec:Basic
> +Facilities of a Virtio Device / Packed Virtqueues / Event Suppression Structure
> +Format}
> +
> +The following structure is used to reduce the number of
> +notifications sent between driver and device.
> +
> +\begin{lstlisting}
> +__le16 desc_event_off : 15; /* Descriptor Event Offset */
> +int    desc_event_wrap : 1; /* Descriptor Event Wrap Counter */

Is this `int` a typo?

> +__le16 desc_event_flags : 2; /* Descriptor Event Flags */
> +\end{lstlisting}
[...]
> +\subsubsection{Implementation Example}\label{sec:Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Implementation Example}
> +
> +Below is an example driver code. It does not attempt to reduce
> +the number of device interrupts, neither does it support
> +the VIRTIO_F_RING_EVENT_IDX feature.
> +
> +\begin{lstlisting}
> +
> +first = vq->next_avail;
> +id = alloc_id(vq);
> +
> +for (each buffer element b) {
> +        vq->desc[vq->next_avail].address = get_addr(b);
> +        vq->desc[vq->next_avail].len = get_len(b);
> +        init_desc(vq->next_avail, b);
> +        avail = vq->avail_wrap_count;
> +        used = !vq->avail_wrap_count;
> +        f = get_flags(b) | (avail << VIRTQ_DESC_F_AVAIL) | (used << VIRTQ_DESC_F_USED);

In this version, above two flags are defined as:

#define VIRTQ_DESC_F_AVAIL     (1 << 7)
#define VIRTQ_DESC_F_USED      (1 << 15)

So we couldn't use them to shift the bit like this.

> +	/* Don't mark the 1st descriptor available until all of them are ready. */
> +        if (vq->next_avail == first) {
> +                flags = f;
> +        } else {
> +                vq->desc[vq->next_avail].flags = f;
> +        }
> +
> +	vq->next_avail++;
> +
> +	if (vq->next_avail >= vq->size) {
> +		vq->next_avail = 0;
> +		vq->avail_wrap_count \^= 1;
> +	}

Maybe it's better to not mix using tab and space in
this example code.

> +
> +
> +}
> +/* ID included in the last descriptor in the list */
> +vq->desc[vq->next_avail].id = id;

Maybe it should be something like this:

vq->desc[prev].id = id;

Otherwise, the other fields (e.g. flags) of this desc (the
vq->desc[vq->next_avail]) also need to be updated.

> +write_memory_barrier();
> +vq->desc[first].flags = flags;
> +
> +memory_barrier();
> +
> +if (vq->device_event.flags != 0x2) {

Maybe it should be:

if (vq->device_event.flags != 0x1) {

As the flags definitions in this version are:

00b enable events
01b disable events
10b enable events for a specific descriptor
    (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
    Only valid if VIRTIO_F_RING_EVENT_IDX has been negotiated.
11b reserved

> +        notify_device(vq);
> +}
> +
> +\end{lstlisting}
> +
> +
> +\drivernormative{\paragraph}{Notifying The Device}{Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Notifying The Device}
> +The driver MUST perform a suitable memory barrier before reading
> +the Driver Event Suppression structure, to avoid missing a notification.
> +
> +\subsection{Receiving Used Buffers From The Device}\label{sec:Basic Facilities of a Virtio Device / Packed Virtqueues / Receiving Used Buffers From The Device}
> +
> +Once the device has used buffers referred to by a descriptor (read from or written to them, or
> +parts of both, depending on the nature of the virtqueue and the
> +device), it interrupts the driver
> +as detailed in section \ref{sec:Basic
> +Facilities of a Virtio Device / Packed Virtqueues / Event
> +Suppression Structure Format}.
> +
> +\begin{note}
> +For optimal performance, a driver MAY disable interrupts while processing
> +the used buffers, but beware the problem of missing interrupts between
> +emptying the ring and reenabling interrupts.  This is usually handled by
> +re-checking for more used buffers after interrups are re-enabled:
> +\end{note}
> +
> +\begin{lstlisting}
> +vq->driver_event.flags = 0x2;

If my understanding is correct, this is to disable interrupt.
So maybe it should be:

vq->driver_event.flags = 0x1;

> +
> +for (;;) {
> +        struct virtq_desc *d = vq->desc[vq->next_used];
> +
> +        flags = d->flags;
> +        bool avail = flags & (1 << VIRTQ_DESC_F_AVAIL);
> +        bool used = flags & (1 << VIRTQ_DESC_F_USED);

We couldn't use them to shift the bit like this in this version.

> +
> +        if (avail != used) {
> +                vq->driver_event.flags = 0x1;

If my understanding is correct, this is to enable interrupt.
So maybe it should be:

vq->driver_event.flags = 0x0;

> +                memory_barrier();
> +
> +                flags = d->flags;
> +                bool avail = flags & (1 << VIRTQ_DESC_F_AVAIL);
> +                bool used = flags & (1 << VIRTQ_DESC_F_USED);

We couldn't use them to shift the bit like this in this version.

> +                if (avail != used) {
> +                        break;
> +                }
> +
> +                vq->driver_event.flags = 0x2;

If my understanding is correct, this is to disable interrupt.
So maybe it should be:

vq->driver_event.flags = 0x1;

> +        }
> +
> +	read_memory_barrier();
> +        process_buffer(d);
> +        vq->next_used++;
> +        if (vq->next_used >= vq->size) {
> +                vq->next_used = 0;
> +        }
> +}
> +\end{lstlisting}
> -- 
> MST
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

