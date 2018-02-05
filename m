Return-Path: virtio-return-2871-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
 <1516665617-30748-8-git-send-email-mst@redhat.com>
Date: Mon, 5 Feb 2018 23:57:03 +0100
MIME-Version: 1.0
In-Reply-To: <1516665617-30748-8-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <be450ae3-7669-d0fb-7ecf-70dd52dbe4df@linux.vnet.ibm.com>
Subject: [virtio] Re: [virtio-dev] [PATCH v7 08/11] packed virtqueues: more efficient
 virtqueue layout
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi! I've tried to not repeat the points raised by the other reviewers.
If I failed, please point me to the answer ;).


On 01/23/2018 01:01 AM, Michael S. Tsirkin wrote:
> Performance analysis of this is in my kvm forum 2016 presentation.  The
> idea is to have a r/w descriptor in a ring structure, replacing the used
> and available ring, index and descriptor buffer.
> 
> This is also easier for devices to implement than the 1.0 layout.
> Several more enhancements will be necessary to actually make this
> efficient for devices to use.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex     |  25 ++-
>  packed-ring.tex | 678 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 700 insertions(+), 3 deletions(-)
>  create mode 100644 packed-ring.tex
> 
> diff --git a/content.tex b/content.tex
> index 0f7c2b9..4d522cc 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -263,8 +263,17 @@ these parts (following \ref{sec:Basic Facilities of a Virtio Device / Split Virt
> 
>  \end{note}
> 
> +Two formats are supported: Split Virtqueues (see \ref{sec:Basic
> +Facilities of a Virtio Device / Split
> +Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device /
> +Split Virtqueues}) and Packed Virtqueues (see \ref{sec:Basic
> +Facilities of a Virtio Device / Packed
> +Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device /
> +Packed Virtqueues}).
> +

I guess, a driver which does not support packed remains a conforming
virtio (1.1) driver.

A complete device (that is a device and a driver pair) is using packed
layout for all the virtqueues iff VIRTIO_F_PACKED_RING was negotiated (that
is the device offered it and the driver accepted it. Otherwise split format
is used.

I could not find this specified explicitly. 
 
>  \input{split-ring.tex}
> 
> +\input{packed-ring.tex}
>  \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}

[..]

> new file mode 100644
> index 0000000..b6cb979
> --- /dev/null
> +++ b/packed-ring.tex
> @@ -0,0 +1,678 @@
> +\section{Packed Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Packed Virtqueues}
> +
> +Packed virtqueues is an alternative compact virtqueue layout using
> +read-write memory, that is memory that is both read and written
> +by both host and guest.
> +
> +Use of packed virtqueues is enabled by the VIRTIO_F_PACKED_RING
> +feature bit.

See above. Would prefer s/enabled by/negotiated via/

> +
> +Packed virtqueues support up to $2^{15}$ entries each.
> +
> +With current transports, virtqueues are located in guest memory
> +allocated by driver.
> +Each packed virtqueue consists of three parts:
> +
> +\begin{itemize}
> +\item Descriptor Ring - occupies the Descriptor Area
> +\item Driver Event Suppression - occupies the Driver Area
> +\item Device Event Suppression - occupies the Device Area
> +\end{itemize}
> +
> +Where Descriptor Ring in turn consists of descriptors,
> +and where each descriptor can contain the following parts:
> +
> +\begin{itemize}
> +\item Buffer ID

AFAIU this is on 'request' basis. That is, it corresponds to a
chain of descriptors (where chain length can be 1). Let's call
this one 'red buffer'. 

> +\item Buffer Address

This 'Buffer' as a different color. Here the 'buffer' stands
for 'buffer element'. That is corresponds to a single descriptor
and a single guest physically continuous chunk of memory.
Let's call this one 'blue buffer'.

> +\item Buffer Length

Same here.

> +\item Flags
> +\end{itemize}


> +
> +A buffer consists of zero or more device-readable physically-contiguous
     (that is 'red buffer')
> +elements followed by zero or more physically-contiguous
  (that is 'blue buffer')
> +device-writable elements (each buffer has at least one element).
                   (that is 'blue buffer')
> +
> +When the driver wants to send such a buffer to the device, it
> +writes at least one available descriptor describing elements of
> +the buffer into the Descriptor Ring.  The descriptor(s) are
> +associated with a buffer by means of a Buffer ID stored within
> +the descriptor.
> +
> +Driver then notifies the device. When the device has finished
> +processing the buffer, it writes a used device descriptor
> +including the Buffer ID into the Descriptor Ring (overwriting a
> +driver descriptor previously made available), and sends an
> +interrupt.
> +
> +Descriptor Ring is used in a circular manner: driver writes
> +descriptors into the ring in order. After reaching end of ring,
> +the next descriptor is placed at head of the ring.  Once ring is
> +full of driver descriptors, driver stops sending new requests and
> +waits for device to start processing descriptors and to write out
> +some used descriptors before making new driver descriptors
> +available.
> +
> +Similarly, device reads descriptors from the ring in order and
> +detects that a driver descriptor has been made available.  As
> +processing of descriptors is completed used descriptors are
> +written by the device back into the ring.
> +
> +Note: after reading driver descriptors and starting their
> +processing in order, device might complete their processing out
> +of order.  Used device descriptors are written in the order
> +in which their processing is complete.
> +
> +Device Event Suppression data structure is write-only by the
> +device. It includes information for reducing the number of
> +device events - i.e. driver notifications to device.
> +
> +Driver Event Suppression data structure is read-only by the
> +device. It includes information for reducing the number of
> +driver events - i.e. device interrupts to driver.
> +
> +\subsection{Available and Used Ring Wrap Counters}
> +\label{sec:Packed Virtqueues / Available and Used Ring Wrap Counters}

I find the names a bit unfortunate: it's clear that  it is a
available ring-wrap counter and not an available-ring wrap counter,
but still if I read available ring I kind of think of the available
ring at the moment (which does not exist for packed). 

Could we call these device's ring wrap counter and driver's
ring wrap counter?

> +Each of the driver and the device are expected to maintain,
> +internally, a single-bit ring wrap counter initialized to 1.
> +
> +The counter maintained by the driver is called the Available
> +Ring Wrap Counter. Driver changes the value of this counter
> +each time it makes available the
> +last descriptor in the ring (after making the last descriptor
> +available).
> +
> +The counter maintained by the device is called the Used Ring Wrap
> +Counter.  Device changes the value of this counter
> +each time it uses the last descriptor in
> +the ring (after marking the last descriptor used).
> +
> +It is easy to see that the Available Ring Wrap Counter in the driver matches
> +the Used Ring Wrap Counter in the device when both are processing the same
> +descriptor, or when all available descriptors have been used.
> +
> +To mark a descriptor as available and used, both driver and
> +device use the following two flags:
> +\begin{lstlisting}
> +#define VIRTQ_DESC_F_AVAIL     7
> +#define VIRTQ_DESC_F_USED      15
> +\end{lstlisting}
> +
> +To mark a descriptor as available, driver sets the
> +VIRTQ_DESC_F_AVAIL bit in Flags to match the internal Available
> +Ring Wrap Counter.  It also sets the VIRTQ_DESC_F_USED bit to match the
> +\emph{inverse} value.

I find inverse a bit problematic (as a half mathematician). Inverse is
defined in respect to an operation. If I think modulo arithmetic then
it does not add up. Maybe 'to not match'?

> +
> +To mark a descriptor as used, device sets the
> +VIRTQ_DESC_F_USED bit in Flags to match the internal Used
> +Ring Wrap Counter.  It also sets the VIRTQ_DESC_F_AVAIL bit to match the
> +\emph{same} value.
> +
> +Thus VIRTQ_DESC_F_AVAIL and VIRTQ_DESC_F_USED bits are different
> +for an available descriptor and equal for a used descriptor.

We cant' turn it around: VIRTQ_DESC_F_AVAIL and VIRTQ_DESC_F_USED
different is a necessary but not a sufficient pre-condition for
a descriptor being available; VIRTQ_DESC_F_AVAIL and VIRTQ_DESC_F_USED
equal is a necessary but not a sufficient pre-condition for
a descriptor being used. Right?


> +
> +\subsection{Polling of available and used descriptors}
> +\label{sec:Packed Virtqueues / Polling of available and used descriptors}
> +
> +Writes of device and driver descriptors can generally be
> +reordered, but each side (driver and device) are only required to
> +poll (or test) a single location in memory: next device descriptor after
> +the one they processed previously, in circular order.
> +
> +Sometimes device needs to only write out a single used descriptor
> +after processing a batch of multiple available descriptors.  As
> +described in more detail below, this can happen when using
> +descriptor chaining or with in-order
> +use of descriptors.  In this case, device writes out a used
> +descriptor with buffer id of the last descriptor in the group.
> +After processing the used descriptor, both device and driver then
> +skip forward in the ring the number of the remaining descriptors
> +in the group until processing (reading for the driver and writing
> +for the device) the next used descriptor.
> +
> +\subsection{Write Flag}
> +\label{sec:Packed Virtqueues / Write Flag}
> +
> +In an available descriptor, VIRTQ_DESC_F_WRITE bit within Flags
> +is used to mark a descriptor as corresponding to a write-only or
> +read-only element of a buffer.
> +
> +\begin{lstlisting}
> +/* This marks a buffer as device write-only (otherwise device read-only). */

Above you use 'element of the buffer', here (in the C-comment) you
use just 'buffer'.

> +#define VIRTQ_DESC_F_WRITE     2
> +\end{lstlisting}
> +
> +In a used descriptor, this bit it used to specify whether any
> +data has been written by the device into any parts of the buffer.
> +
> +
> +\subsection{Buffer Address and Length}
> +\label{sec:Packed Virtqueues / Buffer Address and Length}
> +
> +In an available descriptor, Buffer Address corresponds to the
> +physical address of the buffer. The length of the buffer assumed
> +to be physically contigious is stored in Buffer Length.

These 'buffer's are again 'blue buffers', that is buffer elements.

> +
> +In a used descriptor, Buffer Address is unused. Buffer Length
> +specifies the length of the buffer that has been initialized
> +(written to) by the device.

I'm confused here. Which color buffer is it now?

> +
> +Buffer length is reserved for used descriptors without the
> +VIRTQ_DESC_F_WRITE flag, and is ignored by drivers.
> +
> +\subsection{Scatter-Gather Support}

[Consistent wording] Both types of virtqueues support scatter-gather
but the term is used only for packed. Maybe we could unify the wording.

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
> +

This seems different than split where chaining support is mandatory.
Is there a reason for making both optional?

> +While unusual (most implementations either create all lists
> +solely using non-indirect descriptors, or always use a single
> +indirect element), if both features have been negotiated, mixing
> +direct and direct descriptors in a ring is valid, as long as each
> +list only contains descriptors of a given type.
> +
> +Scatter/gather lists only apply to available descriptors. A
> +single used descriptor corresponds to the whole list.
> +
> +The device limits the number of descriptors in a list through a
> +transport-specific and/or device-specific value. If not limited,
> +the maximum number of descriptors in a list is the virt queue
> +size.
> +
> +\subsection{Next Flag: Descriptor Chaining}
> +\label{sec:Packed Virtqueues / Next Flag: Descriptor Chaining}
> +
> +The VIRTIO_F_LIST_DESC feature allows driver to supply

This feature does not seem to appear anywhere else in the entire document.

> +a scatter/gather list to the device
> +by using multiple descriptors, and setting the VIRTQ_DESC_F_NEXT in
> +Flags for all but the last available descriptor.
> +
> +\begin{lstlisting}
> +/* This marks a buffer as continuing. */
> +#define VIRTQ_DESC_F_NEXT   1
> +\end{lstlisting}
> +
> +Buffer ID is included in the last descriptor in the list.
> +
> +The driver always makes the the first descriptor in the list
> +available after the rest of the list has been written out into
> +the ring. This guarantees that the device will never observe a
> +partial scatter/gather list in the ring.
> +
> +Device only writes out a single used descriptor for the whole
> +list. It then skips forward according to the number of
> +descriptors in the list. Driver needs to keep track of the size
> +of the list corresponding to each buffer ID, to be able to skip
> +to where the next used descriptor is written by the device.
> +
> +For example, if descriptors are used in the same order in which
> +they are made available, this will result in the used descriptor
> +overwriting the first available descriptor in the list, the used
> +descriptor for the next list overwriting the first available
> +descriptor in the next list, etc.
> +
> +VIRTQ_DESC_F_NEXT is reserved in used descriptors, and
> +should be ignored by drivers.
> +
> +\subsection{Indirect Flag: Scatter-Gather Support}
> +\label{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Support}
> +
> +Some devices benefit by concurrently dispatching a large number
> +of large requests. The VIRTIO_F_INDIRECT_DESC feature allows this. To increase
> +ring capacity the driver can store a (read-only by the device) table of indirect
> +descriptors anywhere in memory, and insert a descriptor in main
> +virtqueue (with \field{Flags} bit VIRTQ_DESC_F_INDIRECT on) that refers to
> +a memory buffer

This is again a blueish buffer.

> +containing this indirect descriptor table; \field{addr} and \field{len}
> +refer to the indirect table address and length in bytes,
> +respectively.
> +\begin{lstlisting}
> +/* This means the buffer contains a table of buffer descriptors. */

'a table of buffer descriptors' is a new term. 

> +#define VIRTQ_DESC_F_INDIRECT   4
> +\end{lstlisting}
> +
> +The indirect table layout structure looks like this
> +(\field{len} is the Buffer Length of the descriptor that refers to this table,
> +which is a variable, so this code won't compile):
> +
> +\begin{lstlisting}
> +struct indirect_descriptor_table {
> +        /* The actual descriptor structures (struct Desc each) */
> +        struct Desc desc[len / sizeof(struct Desc)];

Could not find struct Desc. Was it supposed to be  struct virtq_desc?


> +};
> +\end{lstlisting}
> +
> +The first descriptor is located at start of the indirect
> +descriptor table, additional indirect descriptors come
> +immediately afterwards. \field{Flags} bit VIRTQ_DESC_F_WRITE is the
> +only valid flag for descriptors in the indirect table. Others
> +are reserved and are ignored by the device.
> +Buffer ID is also reserved and is ignored by the device.
> +
> +In Descriptors with VIRTQ_DESC_F_INDIRECT set VIRTQ_DESC_F_WRITE
> +is reserved and is ignored by the device.
> +
> +\subsection{Multi-buffer requests}
> +\label{sec:Packed Virtqueues / Multi-descriptor batches}
> +Some devices combine multiple buffers as part of processing of a
> +single request.  These devices always make the first
> +descriptor in the request available after the rest of the request
> +has been written out request the ring. This guarantees that the
> +driver will never observe a partial request in the ring.
> +

Why does it have to be multiple buffers (I suppose red ones) then?

You are making a statement about devices (probably actually drivers
as we talk about 'making available') behavior AFAIU so I'm curious
how does this translate to split virtqueues?

> +
> +\subsection{Driver and Device Event Suppression}
> +\label{sec:Packed Virtqueues / Driver and Device Event Suppression}
> +In many systems driver and device notifications involve
> +significant overhead. To mitigate this overhead,
> +each virtqueue includes two identical structures used for
> +controlling notifications between device and driver.
> +
> +Driver Event Suppression structure is read-only by the
> +device and controls the events sent by the device
> +to the driver (e.g. interrupts).
> +
> +Device Event Suppression structure is read-only by
> +the driver and controls the events sent by the driver
> +to the device (e.g. IO).
> +
> +Each of these Event Suppression structures controls
> +both Descriptor Ring events and structure events, and
> +each includes the following fields:
> +
> +\begin{description}
> +\item [Descriptor Ring Change Event Flags] Takes values:
> +\begin{itemize}
> +\item 00b enable events
> +\item 01b disable events
> +\item 10b enable events for a specific descriptor
> +(as specified by Descriptor Ring Change Event Offset/Wrap Counter).
> +Only valid if VIRTIO_F_RING_EVENT_IDX has been negotiated.
> +\item 11b reserved
> +\end{itemize}
> +\item [Descriptor Ring Change Event Offset] If Event Flags set to descriptor
> +specific event: offset within the ring (in units of descriptor
> +size). Event will only trigger when this descriptor is
> +made available/used respectively.
> +\item [Descriptor Ring Change Event Wrap Counter] If Event Flags set to descriptor
> +specific event: offset within the ring (in units of descriptor
> +size). Event will only trigger when Ring Wrap Counter
> +matches this value and a descriptor is
> +made available/used respectively.
> +\end{description}
> +
> +After writing out some descriptors, both device and driver
> +are expected to consult the relevant structure to find out
> +whether interrupt/notification should be sent.
> +
> +\subsubsection{Driver notifications}
> +\label{sec:Packed Virtqueues / Driver notifications}
> +Whenever not suppressed by Device Event Suppression,
> +driver is required to notify the device after
> +making changes to the virtqueue.
> +
> +Some devices benefit from ability to find out the number of
> +available descriptors in the ring, and whether to send
> +interrupts to drivers without accessing virtqueue in memory:
> +for efficiency or as a debugging aid.
> +
> +To help with these optimizations, driver notifications
> +to the device include the following information:
> +
> +\begin{itemize}
> +\item VQ number
> +\item Offset (in units of descriptor size) within the ring
> +      where the next available descriptor will be written
> +\item Wrap Counter referring to the next available
> +      descriptor
> +\end{itemize}
> +
> +Note that driver can trigger multiple notifications even without
> +making any more changes to the ring. These would then have
> +identical \field{Offset} and \field{Wrap Counter} values.
> +
> +\subsubsection{Structure Size and Alignment}
> +\label{sec:Packed Virtqueues / Structure Size and Alignment}
> +
> +Each part of the virtqueue is physically-contiguous in guest memory,
> +and has different alignment requirements.
> +
> +The memory aligment and size requirements, in bytes, of each part of the
> +virtqueue are summarized in the following table:
> +
> +\begin{tabular}{|l|l|l|}
> +\hline
> +Virtqueue Part    & Alignment & Size \\
> +\hline \hline
> +Descriptor Ring  & 16        & $16 * $(Queue Size) \\
> +\hline
> +Device Event Suppression    & 4         & 4 \\
> + \hline
> +Driver Event Suppression         & 4         & 4 \\
> + \hline
> +\end{tabular}
> +
> +The Alignment column gives the minimum alignment for each part
> +of the virtqueue.
> +
> +The Size column gives the total number of bytes for each
> +part of the virtqueue.
> +
> +Queue Size corresponds to the maximum number of descriptors in the
> +virtqueue\footnote{For example, if Queue Size is 4 then at most 4 buffers
> +can be queued at any given time.}.  Queue Size value does not
> +have to be a power of 2 unless enforced by the transport.
> +
> +\drivernormative{\subsection}{Virtqueues}{Basic Facilities of a
> +Virtio Device / Packed Virtqueues}
> +The driver MUST ensure that the physical address of the first byte
> +of each virtqueue part is a multiple of the specified alignment value
> +in the above table.
> +
> +\devicenormative{\subsection}{Virtqueues}{Basic Facilities of a
> +Virtio Device / Packed Virtqueues}
> +The device MUST start processing driver descriptors in the order
> +in which they appear in the ring.
> +The device MUST start writing device descriptors into the ring in
> +the order in which they complete.
> +Device MAY reorder descriptor writes once they are started.
> +
> +\subsection{The Virtqueue Descriptor Format}\label{sec:Basic
> +Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue
> +Descriptor Format}
> +
> +The available descriptor refers to the buffers the driver is sending

Don't get the plural. This is a 'blue buffer' I guess.

> +to the device. \field{addr} is a physical address, and the
> +descriptor is identified with a buffer using the \field{id} field.

Reads strange. And this buffer is probably 'red buffer', but then it
does not make sense.

> +
> +\begin{lstlisting}
> +struct virtq_desc {
> +        /* Buffer Address. */
> +        le64 addr;
> +        /* Buffer Length. */
> +        le32 len;
> +        /* Buffer ID. */
> +        le16 id;
> +        /* The flags depending on descriptor type. */
> +        le16 flags;
> +};
> +\end{lstlisting}
> +
> +The descriptor ring is zero-initialized.
> +
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
> +__le16 desc_event_flags : 2; /* Descriptor Event Flags */
> +\end{lstlisting}
> +
> +\subsection{Driver Notification Format}\label{sec:Basic
> +Facilities of a Virtio Device / Packed Virtqueues / Driver Notification Format}
> +
> +The following structure is used to notify device of
> +device events - i.e. available descriptors:
> +
> +\begin{lstlisting}
> +__le16 vqn;
> +__le16 next_off : 15;
> +int    next_wrap : 1;
> +\end{lstlisting}
> +
> +\devicenormative{\subsection}{The Virtqueue Descriptor Table}{Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Table}

s/Descriptor Table/Descriptor Ring/ ?

> +A device MUST NOT write to a device-readable buffer, and a device SHOULD NOT
> +read a device-writable buffer.

These are again 'blue buffers' aka 'buffer elements'.

> +A device MUST NOT use a descriptor unless it observes
> +VIRTQ_DESC_F_AVAIL bit in its \field{flags} being changed.
> +A device MUST NOT change a descriptor after changing it's
> +VIRTQ_DESC_F_USED bit in its \field{flags}.
> +
> +\drivernormative{\subsection}{The Virtqueue Descriptor Table}{Basic Facilities of a Virtio Device / PAcked Virtqueues / The Virtqueue Descriptor Table}

s/Descriptor Table/Descriptor Ring/ ?

> +A driver MUST NOT change a descriptor unless it observes
> +VIRTQ_DESC_F_USED bit in its \field{flags} being changed.
> +A driver MUST NOT change a descriptor after changing
> +VIRTQ_DESC_F_USED bit in its \field{flags}.
> +When notifying the device, driver MUST set
> +\field{next_off} and
> +\field{next_wrap} to match the next descriptor
> +not yet made available to the device.
> +A driver MAY send multiple notifications without making
> +any new descriptors available to the device.
> +
> +\drivernormative{\subsection}{Scatter-Gather Support}{Basic Facilities of a
> +Virtio Device / Packed Virtqueues / Scatter-Gather Support}
> +A driver MUST NOT create a descriptor list longer than allowed
> +by the device.
> +
> +A driver MUST NOT create a descriptor list longer than the Queue
> +Size.
> +
> +This implies that loops in the descriptor list are forbidden!
> +
> +The driver MUST place any device-writable descriptor elements after
> +any device-readable descriptor elements.
> +
> +A driver MUST NOT depend on the device to use more descriptors
> +to be able to write out all descriptors in a list. A driver
> +MUST make sure there's enough space in the ring
> +for the whole list before making the first descriptor in the list
> +available to the device.
> +
> +A driver MUST NOT make the first descriptor in the list
> +available before initializing the rest of the descriptors.
> +
> +\devicenormative{\subsection}{Scatter-Gather Support}{Basic Facilities of a
> +Virtio Device / Packed Virtqueues / Scatter-Gather Support}
> +The device MUST use descriptors in a list chained by the
> +VIRTQ_DESC_F_NEXT flag in the same order that they
> +were made available by the driver.
> +
> +The device MAY limit the number of buffers it will allow in a
> +list.
> +
> +\drivernormative{\subsection}{Indirect Descriptors}{Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}

s/Descriptor Table/Descriptor Ring/ ?

> +The driver MUST NOT set the DESC_F_INDIRECT flag unless the
> +VIRTIO_F_INDIRECT_DESC feature was negotiated.   The driver MUST NOT
> +set any flags except DESC_F_WRITE within an indirect descriptor.
> +
> +A driver MUST NOT create a descriptor chain longer than allowed
> +by the device.
> +
> +A driver MUST NOT write direct descriptors with
> +DESC_F_INDIRECT set in a scatter-gather list linked by
> +VIRTQ_DESC_F_NEXT.
> +\field{flags}.
> +
> +\subsection{Virtqueue Operation}\label{sec:Basic Facilities of a Virtio Device / Packed Virtqueues / Virtqueue Operation}
> +
> +There are two parts to virtqueue operation: supplying new
> +available buffers to the device, and processing used buffers from
> +the device.
> +
> +What follows is the requirements of each of these two parts
> +when using the packed virtqueue format in more detail.
> +
> +\subsection{Supplying Buffers to The Device}\label{sec:Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device}
> +
> +The driver offers buffers to one of the device's virtqueues as follows:

This is probably a 'red buffer'

> +
> +\begin{enumerate}
> +\item The driver places the buffer into free descriptor in the Descriptor Ring.

What is a free descriptor? s/free/next?

This is probably a 'blue buffer' as a 'red buffer' is not necessarily expressible
by a single 'blue buffer'.

> +
> +\item The driver performs a suitable memory barrier to ensure that it updates
> +  the descriptor(s) before checking for notification suppression.
> +
> +\item If notifications are not suppressed, the driver notifies the device
> +    of the new available buffers.
> +\end{enumerate}
> +
> +What follows is the requirements of each stage in more detail.
> +
> +\subsubsection{Placing Available Buffers Into The Descriptor Ring}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Placing Available Buffers Into The Descriptor Ring}
> +
> +For each buffer element, b:
> +
> +\begin{enumerate}
> +\item Get the next descriptor table entry, d

s/descriptor table/descriptor ring/

> +\item Get the next free buffer id value
> +\item Set \field{d.addr} to the physical address of the start of b
> +\item Set \field{d.len} to the length of b.
> +\item Set \field{d.id} to the buffer id
> +\item Calculate the flags as follows:
> +\begin{enumerate}
> +\item If b is device-writable, set the VIRTQ_DESC_F_WRITE bit to 1, otherwise 0
> +\item Set VIRTQ_DESC_F_AVAIL bit to the current value of the Available Ring Wrap Counter
> +\item Set VIRTQ_DESC_F_USED bit to inverse value
> +\end{enumerate}
> +\item Perform a memory barrier to ensure that the descriptor has
> +      been initialized
> +\item Set \field{d.flags} to the calculated flags value
> +\item If d is the last descriptor in the ring, toggle the
> +      Available Ring Wrap Counter
> +\item Otherwise, increment d to point at the next descriptor
> +\end{enumerate}
> +
> +This makes a single descriptor buffer available. However, in
> +general the driver MAY make use of a batch of descriptors as part
> +of a single request. In that case, it defers updating
> +the descriptor flags for the first descriptor
> +(and the previous memory barrier) until after the rest of
> +the descriptors have been initialized.
> +
> +Once the descriptor \field{flags} is updated by the driver, this exposes the
> +descriptor and its contents.  The device MAY
> +access the descriptor and any following descriptors the driver created and the
> +memory they refer to immediately.
> +
> +\drivernormative{\paragraph}{Updating flags}{Basic Facilities of
> +a Virtio Device / Packed Virtqueues / Supplying Buffers to The
> +Device / Updating flags}
> +The driver MUST perform a suitable memory barrier before the
> +\field{flags} update, to ensure the
> +device sees the most up-to-date copy.

Necessary only for the first 'blue buffer' whose flags are set last?

> +
> +\subsubsection{Notifying The Device}\label{sec:Basic Facilities
> +of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Notifying The Device}
> +
> +The actual method of device notification is bus-specific, but generally
> +it can be expensive.  So the device MAY suppress such notifications if it
> +doesn't need them, using the Driver Event Suppression structure
> +as detailed in section \ref{sec:Basic
> +Facilities of a Virtio Device / Packed Virtqueues / Event
> +Suppression Structure Format}.
> +
> +The driver has to be careful to expose the new \field{flags}
> +value before checking if notifications are suppressed.
> +
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

What is init_desc? Can't find it elsewhere.

> +        avail = vq->avail_wrap_count;
> +        used = !vq->avail_wrap_count;
> +        f = get_flags(b) | (avail << VIRTQ_DESC_F_AVAIL) | (used << VIRTQ_DESC_F_USED);
> +	/* Don't mark the 1st descriptor available until all of them are ready. */
> +        if (vq->next_avail == first) {
> +                flags = f;
> +        } else {
> +                vq->desc[vq->next_avail].flags = f;
> +        }
> +
> +	vq->next_avail++;
> +
> +	if (vq->next_avail > vq->size) {
> +		vq->next_avail = 0;
> +		vq->avail_wrap_count \^= 1;
> +	}
> +
> +
> +}
> +vq->desc[vq->next_avail].id = id;
> +write_memory_barrier();
> +vq->desc[first].flags = flags;
> +
> +memory_barrier();
> +
> +if (vq->device_event.flags != 0x2) {
> +        notify_device(vq, vq->next_avail, vq->avail_wrap_count);
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
> +
> +for (;;) {
> +        struct virtq_desc *d = vq->desc[vq->next_used];
> +
> +        flags = d->flags;
> +        bool avail = flags & (1 << VIRTQ_DESC_F_AVAIL);
> +        bool used = flags & (1 << VIRTQ_DESC_F_USED);
> +
> +        if (avail != used) {
> +                vq->driver_event.flags = 0x1;
> +                memory_barrier();
> +
> +                flags = d->flags;
> +                bool avail = flags & (1 << VIRTQ_DESC_F_AVAIL);
> +                bool used = flags & (1 << VIRTQ_DESC_F_USED);
> +                if (avail != used) {
> +                        break;
> +                }
> +
> +                vq->driver_event.flags = 0x2;
> +        }
> +
> +	read_memory_barrier();
> +        process_buffer(d);
> +        vq->next_used++;
> +        if (vq->next_used > vq->size) {
> +                vq->next_used = 0;
> +        }
> +}

I would have expected avail_wrap_count showing up here somewhere. Was I
wrong?

> +\end{lstlisting}
> 

Pff, it ended up being a mix of me being petty about wording and
hopefully more productive complaints. I hope it's still bearable.

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

