Return-Path: virtio-return-2855-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 30 Jan 2018 18:45:57 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180130184309-mutt-send-email-mst@kernel.org>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
 <1516665617-30748-8-git-send-email-mst@redhat.com>
 <20180130071641.miuqgxblqubewsra@debian-xvivbkq.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130071641.miuqgxblqubewsra@debian-xvivbkq.sh.intel.com>
Subject: [virtio] Re: [virtio-dev] [PATCH v7 08/11] packed virtqueues: more efficient
 virtqueue layout
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 30, 2018 at 03:16:41PM +0800, Tiwei Bie wrote:
> On Tue, Jan 23, 2018 at 02:01:07AM +0200, Michael S. Tsirkin wrote:
> [...]
> > +\subsection{Available and Used Ring Wrap Counters}
> > +\label{sec:Packed Virtqueues / Available and Used Ring Wrap Counters}
> > +Each of the driver and the device are expected to maintain,
> > +internally, a single-bit ring wrap counter initialized to 1.
> > +
> > +The counter maintained by the driver is called the Available
> > +Ring Wrap Counter. Driver changes the value of this counter
> > +each time it makes available the
> > +last descriptor in the ring (after making the last descriptor
> > +available).
> > +
> > +The counter maintained by the device is called the Used Ring Wrap
> > +Counter.  Device changes the value of this counter
> > +each time it uses the last descriptor in
> > +the ring (after marking the last descriptor used).
> > +
> > +It is easy to see that the Available Ring Wrap Counter in the driver matches
> > +the Used Ring Wrap Counter in the device when both are processing the same
> > +descriptor, or when all available descriptors have been used.
> > +
> > +To mark a descriptor as available and used, both driver and
> > +device use the following two flags:
> > +\begin{lstlisting}
> > +#define VIRTQ_DESC_F_AVAIL     7
> > +#define VIRTQ_DESC_F_USED      15
> 
> I think above two definitions are not consistent with
> below definitions:
> 
> #define VIRTQ_DESC_F_NEXT       1
> #define VIRTQ_DESC_F_WRITE      2
> #define VIRTQ_DESC_F_INDIRECT   4
> 
> Maybe it'd be better to define them as:
> 
> #define VIRTQ_DESC_F_AVAIL(b)     (b << 7)
> #define VIRTQ_DESC_F_USED(b)      (b << 15)

Good catch, thanks a lot!

> > +\end{lstlisting}
> > +
> > +To mark a descriptor as available, driver sets the
> > +VIRTQ_DESC_F_AVAIL bit in Flags to match the internal Available
> > +Ring Wrap Counter.  It also sets the VIRTQ_DESC_F_USED bit to match the
> > +\emph{inverse} value.
> > +
> > +To mark a descriptor as used, device sets the
> > +VIRTQ_DESC_F_USED bit in Flags to match the internal Used
> > +Ring Wrap Counter.  It also sets the VIRTQ_DESC_F_AVAIL bit to match the
> > +\emph{same} value.
> > +
> > +Thus VIRTQ_DESC_F_AVAIL and VIRTQ_DESC_F_USED bits are different
> > +for an available descriptor and equal for a used descriptor.
> > +
> > +\subsection{Polling of available and used descriptors}
> > +\label{sec:Packed Virtqueues / Polling of available and used descriptors}
> > +
> > +Writes of device and driver descriptors can generally be
> > +reordered, but each side (driver and device) are only required to
> > +poll (or test) a single location in memory: next device descriptor after
> > +the one they processed previously, in circular order.
> > +
> > +Sometimes device needs to only write out a single used descriptor
> > +after processing a batch of multiple available descriptors.  As
> > +described in more detail below, this can happen when using
> > +descriptor chaining or with in-order
> > +use of descriptors.  In this case, device writes out a used
> > +descriptor with buffer id of the last descriptor in the group.
> > +After processing the used descriptor, both device and driver then
> > +skip forward in the ring the number of the remaining descriptors
> > +in the group until processing (reading for the driver and writing
> > +for the device) the next used descriptor.
> > +
> > +\subsection{Write Flag}
> > +\label{sec:Packed Virtqueues / Write Flag}
> > +
> > +In an available descriptor, VIRTQ_DESC_F_WRITE bit within Flags
> > +is used to mark a descriptor as corresponding to a write-only or
> > +read-only element of a buffer.
> > +
> > +\begin{lstlisting}
> > +/* This marks a buffer as device write-only (otherwise device read-only). */
> > +#define VIRTQ_DESC_F_WRITE     2
> > +\end{lstlisting}
> > +
> > +In a used descriptor, this bit it used to specify whether any
> 
> Typo: s/it used/is used/
> 
> > +data has been written by the device into any parts of the buffer.
> [...]
> > +\subsection{Next Flag: Descriptor Chaining}
> > +\label{sec:Packed Virtqueues / Next Flag: Descriptor Chaining}
> > +
> > +The VIRTIO_F_LIST_DESC feature allows driver to supply
> > +a scatter/gather list to the device
> > +by using multiple descriptors, and setting the VIRTQ_DESC_F_NEXT in
> > +Flags for all but the last available descriptor.
> > +
> > +\begin{lstlisting}
> > +/* This marks a buffer as continuing. */
> > +#define VIRTQ_DESC_F_NEXT   1
> > +\end{lstlisting}
> > +
> > +Buffer ID is included in the last descriptor in the list.
> > +
> > +The driver always makes the the first descriptor in the list
> > +available
> 
> Typo: s/the the/the/
> 
> The driver always and only makes the first descriptor in the list
> available?

No - it makes all of them available - the head
of the list is made available the last.

> If my above understanding is correct (i.e. only the
> first desc in a desc list will be made available by
> driver -- update the VIRTQ_DESC_F_AVAIL/USED flags),
> I think it would be better to make the description
> more explicit.

I'll try to be more explicit.

> Besides, does driver just need to set or clear the
> VIRTQ_DESC_F_WRITE bit for the first desc in a list?

No because a list includes a mix of write and read descriptors.

> > after the rest of the list has been written out into
> > +the ring. This guarantees that the device will never observe a
> > +partial scatter/gather list in the ring.
> > +
> > +Device only writes out a single used descriptor for the whole
> > +list. It then skips forward according to the number of
> > +descriptors in the list. Driver needs to keep track of the size
> > +of the list corresponding to each buffer ID, to be able to skip
> > +to where the next used descriptor is written by the device.
> > +
> > +For example, if descriptors are used in the same order in which
> > +they are made available, this will result in the used descriptor
> > +overwriting the first available descriptor in the list, the used
> > +descriptor for the next list overwriting the first available
> > +descriptor in the next list, etc.
> > +
> > +VIRTQ_DESC_F_NEXT is reserved in used descriptors, and
> > +should be ignored by drivers.
> > +
> [...]
> > +\subsubsection{Implementation Example}\label{sec:Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Implementation Example}
> > +
> > +Below is an example driver code. It does not attempt to reduce
> > +the number of device interrupts, neither does it support
> > +the VIRTIO_F_RING_EVENT_IDX feature.
> > +
> > +\begin{lstlisting}
> > +
> > +first = vq->next_avail;
> > +id = alloc_id(vq);
> > +
> > +for (each buffer element b) {
> > +        vq->desc[vq->next_avail].address = get_addr(b);
> > +        vq->desc[vq->next_avail].len = get_len(b);
> > +        init_desc(vq->next_avail, b);
> > +        avail = vq->avail_wrap_count;
> > +        used = !vq->avail_wrap_count;
> > +        f = get_flags(b) | (avail << VIRTQ_DESC_F_AVAIL) | (used << VIRTQ_DESC_F_USED);
> > +	/* Don't mark the 1st descriptor available until all of them are ready. */
> > +        if (vq->next_avail == first) {
> > +                flags = f;
> > +        } else {
> > +                vq->desc[vq->next_avail].flags = f;
> > +        }
> > +
> > +	vq->next_avail++;
> > +
> > +	if (vq->next_avail > vq->size) {
> 
> Typo: vq->next_avail >= vq->size

True.

> > +		vq->next_avail = 0;
> > +		vq->avail_wrap_count \^= 1;
> > +	}
> > +
> > +
> > +}
> > +vq->desc[vq->next_avail].id = id;
> 
> I think if we need to update desc.id then the desc.id
> needs to be updated for each desc in the loop.

You are right. Will fix.

> > +write_memory_barrier();
> > +vq->desc[first].flags = flags;
> > +
> > +memory_barrier();
> > +
> > +if (vq->device_event.flags != 0x2) {
> > +        notify_device(vq, vq->next_avail, vq->avail_wrap_count);
> > +}
> > +
> > +\end{lstlisting}
> > +
> > +
> > +\drivernormative{\paragraph}{Notifying The Device}{Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Notifying The Device}
> > +The driver MUST perform a suitable memory barrier before reading
> > +the Driver Event Suppression structure, to avoid missing a notification.
> > +
> > +\subsection{Receiving Used Buffers From The Device}\label{sec:Basic Facilities of a Virtio Device / Packed Virtqueues / Receiving Used Buffers From The Device}
> > +
> > +Once the device has used buffers referred to by a descriptor (read from or written to them, or
> > +parts of both, depending on the nature of the virtqueue and the
> > +device), it interrupts the driver
> > +as detailed in section \ref{sec:Basic
> > +Facilities of a Virtio Device / Packed Virtqueues / Event
> > +Suppression Structure Format}.
> > +
> > +\begin{note}
> > +For optimal performance, a driver MAY disable interrupts while processing
> > +the used buffers, but beware the problem of missing interrupts between
> > +emptying the ring and reenabling interrupts.  This is usually handled by
> > +re-checking for more used buffers after interrups are re-enabled:
> > +\end{note}
> > +
> > +\begin{lstlisting}
> > +vq->driver_event.flags = 0x2;
> > +
> > +for (;;) {
> > +        struct virtq_desc *d = vq->desc[vq->next_used];
> > +
> > +        flags = d->flags;
> > +        bool avail = flags & (1 << VIRTQ_DESC_F_AVAIL);
> > +        bool used = flags & (1 << VIRTQ_DESC_F_USED);
> > +
> > +        if (avail != used) {
> > +                vq->driver_event.flags = 0x1;
> > +                memory_barrier();
> > +
> > +                flags = d->flags;
> > +                bool avail = flags & (1 << VIRTQ_DESC_F_AVAIL);
> > +                bool used = flags & (1 << VIRTQ_DESC_F_USED);
> > +                if (avail != used) {
> > +                        break;
> > +                }
> > +
> > +                vq->driver_event.flags = 0x2;
> > +        }
> > +
> > +	read_memory_barrier();
> > +        process_buffer(d);
> > +        vq->next_used++;
> > +        if (vq->next_used > vq->size) {
> 
> Typo: vq->next_used >= vq->size

True.

> > +                vq->next_used = 0;
> > +        }
> > +}
> > +\end{lstlisting}
> > -- 
> > MST
> > 
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

