Return-Path: virtio-dev-return-2710-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id EC2FD581911B
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Nov 2017 19:26:48 -0800 (PST)
Date: Tue, 28 Nov 2017 05:26:14 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171127191239-mutt-send-email-mst@kernel.org>
References: <20171108141659-mutt-send-email-mst@kernel.org>
 <4DCA102C9749C849A7B61D9934ED625207A1A961@fmsmsx122.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DCA102C9749C849A7B61D9934ED625207A1A961@fmsmsx122.amr.corp.intel.com>
Subject: Re: [virtio-dev] [PATCH RFC] packed ring layout spec v5
To: "Dhanoa, Kully" <kully.dhanoa@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 24, 2017 at 10:00:39AM +0000, Dhanoa, Kully wrote:
> I've embedded my original comments in the text below for archiving purposes.
> 
> Michael, 
> I could not find your responses to my comments in the document.
> 
> If you could provide them, it would help me to understand the proposal better.
> 
> Thanks
> Kully
> 
> -----Original Message-----
> From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-open.org] On Behalf Of Michael S. Tsirkin
> Sent: Wednesday, November 22, 2017 2:56 PM
> To: virtio-dev@lists.oasis-open.org
> Subject: [virtio-dev] [PATCH RFC] packed ring layout spec v5
> 
> No functional changes since v4. Added some clarifications in response to questions by Kully.
> 
> This is reasonably complete functionally, from spec point of view we need
> - more conformance statements
> - pseudo-code
> - discussion of memory barriers
> - rearrange existing (1.0) layout discussion to make it fit
>   in a single chapter
> 
> Kully, you sent a PDF with what looks like more feature suggestions.  For example, a suggestion to use a separate memory location for used entries - which as was suggested is also helpful for RDMA.
> 
> Please post them to list in text format, for now I would like to know whether we can agree on the below and add more features on top gated by a feature bit.
> 
> ----
> 
> 
> \section{Packed Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Packed Virtqueues}
> 
> Packed virtqueues is an alternative compact virtqueue layout using read-write memory, that is memory that is both read and written by both host and guest.
> 
> Packed virtqueues support up to $2^14$ queues, with up to $2^15$ entries each.
> 
> With current transports, queues are located in guest memory allocated by driver.
> Each packed virtqueue consists of three parts:
> 
> \begin{itemize}
> \item Descriptor Ring
> \item Device Event Suppression
> \item Driver Event Suppression
> \end{itemize}
> 
> Where Descriptor Ring in turn consists of descriptors, and where each descriptor can contain the following parts:
> 
> \begin{itemize}
> \item Buffer ID
> \item Buffer Address
> \item Buffer Length
> \item Flags
> \end{itemize}
> 
> A buffer consists of zero or more device-readable physically-contiguous elements followed by zero or more physically-contiguous device-writable elements (each buffer has at least one element).
> 
> When the driver wants to send such a buffer to the device, it writes at least one available descriptor describing elements of the buffer into the Descriptor Ring.  The descriptor(s) are associated with a buffer by means of a Buffer ID stored within the descriptor.
> 
> Driver then notifies the device. When the device has finished processing the buffer, it writes a used device descriptor including the Buffer ID into the Descriptor Ring (overwriting a driver descriptor previously made available), and sends an interrupt.
> 
> Descriptor Ring is used in a circular manner: driver writes descriptors into the ring in order. After reaching end of ring, the next descriptor is placed at head of the ring.  Once ring is full of driver descriptors, driver stops sending new requests and waits for device to start processing descriptors and to write out some used descriptors before making new driver descriptors available.
> 
> Similarly, device reads descriptors from the ring in order and detects that a driver descriptor has been made available.  As processing of descriptors is completed used descriptors are written by the device back into the ring.
> 
> Note: after reading driver descriptors and starting their processing in order, device might complete their processing out of order.  Used device descriptors are written in the order in which their processing is complete.
> 
> Device Event Suppression data structure is read-only by the device. It includes information for reducing the number of device events - i.e. interrupts to driver.
> 
> [KSD] Where is this structure located? VM memory OR device memory? I presume VM memory but text should explicitly say so.
> Driver Event Suppression data structure is write-only by the device. It includes information for reducing the number of driver events - i.e. notifications to device.
> 
> [KSD] Similarly, where is this structure located? VM memory OR device memory? I presume VM memory but text should explicitly say so.
> 

A separate section dealing with memory barriers would be a good place to
include this.

We don't say this about 1.0 ring layout anywhere though, do we?

> \subsection{Available and Used Ring Full Counters} \label{sec:Packed Virtqueues / Available and Used Ring Wrap Counters} Each of the driver and the device are expected to maintain, internally, a single-bit ring wrap counter initialized to 1.
> 
> The counter maintained by the driver is called the Available Ring Full Counter. Driver changes its value each time it makes available the last descriptor in the ring (after making the last descriptor available).
> 
> The counter maintained by the device is called the Used Ring Wrap Counter.  Device changes its value each time it uses the last descriptor in the ring (after marking the last descriptor used).
> 
> It is easy to see that the Availablering Wrap Counter in the driver matches the Used Ring Wrap Counter in the device when both are processing the same descriptor, or when all available descriptors have been used.
> 
> To mark a descriptor as available and used, both driver and device use the following two flags:
> \begin{lstlisting}
> #define VIRTQ_DESC_F_AVAIL     7
> #define VIRTQ_DESC_F_USED      15
> \end{lstlisting}
> 
> To mark a descriptor as available, driver sets the VIRTQ_DESC_F_AVAIL bit in Flags to match the internal Available Ring Wrap Counter.  It also sets the VIRTQ_DESC_F_USED bit to match the \emph{inverse} value.
> 
> To mark a descriptor as used, device sets the VIRTQ_DESC_F_USED bit in Flags to match the internal Used Ring Wrap Counter.  It also sets the VIRTQ_DESC_F_AVAIL bit to match the \emph{same} value.
> 
> Thus VIRTQ_DESC_F_AVAIL and VIRTQ_DESC_F_USED bits are different for an available descriptor and equal for a used descriptor.
> 
> \subsection{Polling of available and used descriptors} \label{sec:Packed Virtqueues / Polling of available and used descriptors}
> 
> Writes of device and driver descriptors can generally be reordered, but each side (driver and device) are only required to poll a single location in memory: next device descriptor after the one they processed previously, in circular order.
> 
> [KSD] I think it would be highly unlikely that H/w would poll descriptors. It would rely on ring notification method so would only read descriptors that it knows are valid.

Knows is a strong word though. Unless we want to force strong memory
barriers (which are expensive, so I don't think we do), device
needs to test validity and re-read if not valid.
I will try to clarify that in the (missing) section on memory barriers.

> I would suggest adding text here to say that as well as polling the device can use another method (ring notification) to determine if there are valid descriptors available.

Maybe "read" would be better than "poll".

> Sometimes device needs to only write out a single used descriptor after processing a batch of multiple available descriptors.  As described in more detail below, this can happen when using descriptor chaining or with in-order use of descriptors.  In this case, device writes out a used descriptor with buffer id of the last descriptor in the group.
> After processing the used descriptor, both device and driver then skip forward in the ring the number of the remaining descriptors in the group until processing (reading for the driver and writing for the device) the next used descriptor.
> 
> [KSD] I suggest saying that a used Descriptor is written back to the
> same location it was read from the Descriptor Table (assuming in-order
> processing).

This is not the case if some descriptors are skipped, as described in
In-order use of descriptors.

> However, not all used Descriptors need be written back: -
> a packet comprising a batch of descriptors would only have the first
> descriptor of the batch written to.  - s/w may indicate that a
> descriptor does not need to be written back after use (to reduce
> amount of writes to Descriptor Table by device).

This idea is not included in the proposal since it does not map
to existing virtio APIs. It is of course a valid extension that
we can pursue separately.

Instead the proposal includes an option for device to skip
writing some descriptors on its own.

>  Although I like the
> general mechanism of only writing back certain descriptors, it creates
> a problem that if s/w is looking for a specific descriptor to be used
> but for some reason the device did not write it back, the whole system
> would just hang...... case for separate completion queue/used table.
> Is this a scenario that we should consider? Or do we say it's a bug
> and should never occur in a properly functioning system?

A separate queue seems to perform worse due to more cache misses.  At
some level if the last descriptor is skipped due to a device bug there's
always a chance things hang, so I am not at all sure it's worth
sacrificing performance for.


> \subsection{Write Flag}
> \label{sec:Packed Virtqueues / Write Flag}
> 
> In an available descriptor, VIRTQ_DESC_F_WRITE bit within Flags is used to mark a descriptor as corresponding to a write-only or read-only element of a buffer.
> 
> \begin{lstlisting}
> /* This marks a buffer as device write-only (otherwise device read-only). */
> #define VIRTQ_DESC_F_WRITE     2
> \end{lstlisting}
> 
> In a used descriptor, this bit it used to specify whether any data has been written by the device into any parts of the buffer.
> 
> 
> \subsection{Buffer Address and Length}
> \label{sec:Packed Virtqueues / Buffer Address and Length}
> 
> In an available descriptor, Buffer Address corresponds to the physical address of the buffer. The length of the buffer assumed to be physically contigious is stored in Buffer Length.
> 
> In a used descriptor, Buffer Address is unused. Buffer Length specifies the length of the buffer that has been initialized (written to) by the device.
> 
> Buffer length is reserved for used descriptors without the VIRTQ_DESC_F_WRITE flag, and is ignored by drivers.
> 
> \subsection{Scatter-Gather Support}
> \label{sec:Packed Virtqueues / Scatter-Gather Support}
> 
> Some drivers need an ability to supply a list of multiple buffer elements (also known as a scatter/gather list) with a request.
> Two optional features support this: descriptor chaining and indirect descriptors.
> 
> [KSD] Is descriptor chaining really an optional feature? Good idea if it is. I presume this is a change from 1.0 as there it seems to be mandatory (is my understanding correct?)

Yes.  Is it clear from the text?


> If neither feature has been negotiated, each buffer is physically-contigious, either read-only or write-only and is described completely by a single descriptor.
> 
> While unusual (most implementations either create all lists solely using non-indirect descriptors, or always use a single indirect element), if both features have been negotiated, mixing direct and direct descriptors in a ring is valid, as long as each list only contains descriptors of a given type.
> 
> Scatter/gather lists only apply to available descriptors. A single used descriptor corresponds to the whole list.
> 
> The device limits the number of descriptors in a list through a bus-specific and/or device-specific value. If not limited, the maximum number of descriptors in a list is the virt queue size.
> 
> \subsection{Next Flag: Descriptor Chaining} \label{sec:Packed Virtqueues / Next Flag: Descriptor Chaining}
> 
> The VIRTIO_F_LIST_DESC feature allows driver to do this by using multiple descriptors, and setting the VIRTQ_DESC_F_NEXT in Flags for all but the last available descriptor.
> 
> \begin{lstlisting}
> /* This marks a buffer as continuing. */
> #define VIRTQ_DESC_F_NEXT   1
> \end{lstlisting}
> 
> Buffer ID is included in the last descriptor in the list.  
> 
> The driver always makes the the first descriptor in the list available after the rest of the list has been written out into the ring. This guarantees that the device will never observe a partial scatter/gather list in the ring.
> 
> Device only writes out a single used descriptor for the whole list. It then skips forward according to the number of descriptors in the list. Driver needs to keep track of the size of the list corresponding to each buffer ID, to be able to skip to where the next used descriptor is written by the device.
> 
> For example, if descriptors are used in the same order in which they are made available, this will result in the used descriptor overwriting the first available descriptor in the list, the used descriptor for the next list overwriting the first available descriptor in the next list, etc.
> 
> VIRTQ_DESC_F_NEXT is reserved in used descriptors, and should be ignored by drivers.
> 
> \subsection{Indirect Flag: Scatter-Gather Support} \label{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Support}
> 
> Some devices benefit by concurrently dispatching a large number of large requests. The VIRTIO_F_INDIRECT_DESC feature allows this. To increase ring capacity the driver can store  (read-only by the device) table of indirect descriptors anywhere in memory, and insert a descriptor in main virtqueue (with \field{Flags}\&VIRTQ_DESC_F_INDIRECT on) that refers to a memory buffer containing this indirect descriptor table; \field{addr} and \field{len} refer to the indirect table address and length in bytes, respectively.
> \begin{lstlisting}
> /* This means the buffer contains a table of buffer descriptors. */
> #define VIRTQ_DESC_F_INDIRECT   4
> \end{lstlisting}
> 
> The indirect table layout structure looks like this (\field{len} is the Buffer Length of the descriptor that refers to this table, which is a variable, so this code won't compile):
> 
> \begin{lstlisting}
> struct indirect_descriptor_table {
>         /* The actual descriptor structures (struct Desc each) */
>         struct Desc desc[len / sizeof(struct Desc)]; }; \end{lstlisting}
> 
> The first descriptor is located at start of the indirect descriptor table, additional indirect descriptors come immediately afterwards. \field{Flags} \&VIRTQ_DESC_F_WRITE is the only valid flag for descriptors in the indirect table. Others are reserved are ignored by the device. 
> Buffer ID is also reserved and is ignored by the device.
> 
> In Descriptors with VIRTQ_DESC_F_INDIRECT set VIRTQ_DESC_F_WRITE is reserved and is ignored by the device.
> 
> \subsection{In-order use of descriptors} \label{sec:Packed Virtqueues / In-order use of descriptors}
> 
> Some devices always use descriptors in the same order in which they have been made available. These devices can offer the VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge allows devices to notify the use of a batch of buffers to the driver by only writing out a single used descriptor with the Buffer ID corresponding to the last descriptor in the batch.
> 
> Device then skips forward in the ring according to the size of the the batch. Driver needs to look up the used Buffer ID and calculate the batch size to be able to advance to where the next used descriptor will be written by the device.
> 
> This will result in the used descriptor overwriting the first available descriptor in the batch, the used descriptor for the next batch overwriting the first available descriptor in the next batch, etc.
> 
> The skipped buffers (for which no used descriptor was written) are assumed to have been used (read or written) by the device completely.
> 
> \subsection{Multi-buffer requests}
> \label{sec:Packed Virtqueues / Multi-descriptor batches} Some devices combine multiple buffers as part of processing a single request.  These devices always makes the the first descriptor in the request available after the rest of the request has been written out request the ring. This guarantees that the driver will never observe a partial request in the ring.
> 
> 
> \subsection{Driver and Device Event Suppression} \label{sec:Packed Virtqueues / Driver and Device Event Suppression} In many systems driver and device notifications involve significant overhead. To mitigate this overhead, each virtqueue includes two identical structures used for controlling notifications between device and driver.
> 
> Driver Event Suppression structure is read-only by the device and controls the events sent by the device (e.g. interrupts).
> 
> Device Event Suppression structure is read-only by the driver and controls the events sent by the driver (e.g. IO).
> 
> 
> Each of these Event Suppression structures controls both Descriptor Ring events and structure events, and each includes the following fields:
> 
> \begin{description}
> \item [Descriptor Ring Change Event Flags] Takes values:
> \begin{itemize}
> \item 00b reserved
> \item 01b enable events
> \item 11b disable events
> \item 10b enable events for a specific descriptor (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
> \end{itemize}
> 
> [KSD] Are these flags in each descriptor OR in the global (per VM) Driver Event Suppression structure?

Neither.  They are called descriptor ring flags so they are per ring.
Beginning of chapter says these structures are part of the queue.
It seems this point is not clear but I do not know how to make
it clearer. Ideas?


> 
> [KSD] As well as this offset value, I thought we had discussed in the past of  having a flag in each descriptor to indicate to the device to generate an interrupt and also a flag to indicate whether the device must write back the used descriptor to the Descriptor Table (flags would be set by VM guest driver)? Are we not supporting this?

This sounds like a useful feature but existing driver APIs do not map to
it. Thus I am focusing on a feature complete proposal that can do
everything existing layout can do with more efficiency.
We can add more features on top. Pls go ahead and write a
proposal.


> \item [Descriptor Ring Change Event Wrap Counter]If Event Flags set to descriptor specific event: offset within the ring (in units of descriptor size). Event will only trigger when Ring Wrap Counter matches this value and a descriptor is made available/used respectively.
> \end{description}
> 
> [KSD] What's the point of this,

This matches an existing mechanism that virtio 1.0 drivers use.

> if we can individually control which descriptors should trigger events (i.e. interrupts; descriptor writebacks)

I suspect you mean interrupts right now. But notice the same applies to
IO kicks.  By we do you mean the driver or the device? Drivers don't
control this right now. Devices can do it but past experiements show
that it is helpful for driver to give extra info to device.


> After writing out some descriptors, both device and driver are expected to consult the relevant structure to find out whether interrupt should be sent. As this access to shared memory involves overhead for some transports, the following additional field is present:
> 
> \begin{description}
> \item [Structure Change Event Flags] Enable/disable sending an event notification when the other side changes its own Event Suppression structure.
> \end{description}
> 
> when enabled through this field, device and driver send an event notification whenever they change the driver and device event suppression structure respectively.
> 
> 
> \subsubsection{Driver notifications}
> 
> [KSD] Is this notification structure located in the device memory? i.e. guest VM driver sends notification, it writes to a register in device memory? This is important for h/w implementation.

It has to be in RAM same as rest of the queue. Otherwise driver will
have to execute reads to synchronise e.g. an interrupt enable command
with ring updates by device.

> \label{sec:Packed Virtqueues / Driver notifications} Whenever not suppressed by Device Event Suppression, driver is required to notify the device after making changes to the virtqueue.
> 
> Some devices benefit from ability to find out the number of available descriptors in the ring, and whether to send interrupts to drivers without accessing virtqueue in memory:
> for efficiency or as a debugging aid.
> 
> To help with these optimizations, driver notifications to the device include the following information:
> 
> \begin{itemize}
> \item VQ number
> \item Flags - set to 00b
> \item Offset (in units of descriptor size) within the ring
>       where the next available descriptor will be written \item Available Ring Wrap Counter \end{itemize}
> 
> Whenever driver notifies device about a Device Event Suppression Structure change (if enabled through Structure Change Event Flags in Driver Event Suppression Structure), it sends a copy of the up-to-date Event Suppression Structure:
> 
> \begin{itemize}
> \item VQ number
> \item Descriptor Event Flags
> \item Descriptor Event Offset
> \item Descriptor Event Wrap Counter
> \end{itemize}
> 
> 
> \subsubsection{Structure Size and Alignment} \label{sec:Packed Virtqueues / Structure Size and Alignment}
> 
> Each part of the virtqueue is physically-contiguous in guest memory, and has different alignment requirements.
> 
> The memory aligment and size requirements, in bytes, of each part of the virtqueue are summarized in the following table:
> 
> \begin{tabular}{|l|l|l|}
> \hline
> Virtqueue Part    & Alignment & Size \\
> \hline \hline
> Descriptor Ring  & 16        & $16 * $(Queue Size) \\
> \hline
> Device Event Suppression    & 4         & 4 \\
>  \hline
> Driver Event Suppression         & 4         & 4 \\
>  \hline
> \end{tabular}
> 
> [KSD]  Why not start Descriptor Table on a 4K page boundary? 

Any artificial alignment requirements higher than a cache
line puts more pressure on the specific cache lines.


> [KSD]  Device Event and Driver Event Suppression structures: It would be easier to have them cache line aligned (i.e. 64B aligned as opposed to 4B).

Easier for PCI Express devices?
My only concern is it's a PCI Express
thing, is it possible that other transports will have higher
alignment requirements? Should we make this transport-dependent?

> Would it not be sensible to define their size as a cache line (with remaining 60B as reserved)?

It might be helpful if you explained by it's easier. Note that drivers
already tend to reserve it anyway. Is it a big deal to set byte enables?

> The Alignment column gives the minimum alignment for each part of the virtqueue.
> 
> The Size column gives the total number of bytes for each part of the virtqueue.
> 
> Queue Size corresponds to the maximum number of descriptors in the virtqueue\footnote{For example, if Queue Size is 4 then at most 4 buffers can be queued at any given time.}.  Queue Size value does not have to be a power of 2 unless enforced by the transport.
> 
> \drivernormative{\subsection}{Virtqueues}{Basic Facilities of a Virtio Device / Packed Virtqueues} The driver MUST ensure that the physical address of the first byte of each virtqueue part is a multiple of the specified alignment value in the above table.
> 
> \devicenormative{\subsection}{Virtqueues}{Basic Facilities of a Virtio Device / Packed Virtqueues} The device MUST start processing driver descriptors in the order in which they appear in the ring.
> The device MUST start writing device descriptors into the ring in the order in which they complete.
> Device MAY reorder descriptor writes once they are started.
> 
> \subsection{The Virtqueue Descriptor Format}\label{sec:Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Format}
> 
> The available descriptor refers to the buffers the driver is sending to the device. \field{addr} is a physical address, and the descriptor is identified with a buffer using the \field{id} field.
> 
> \begin{lstlisting}
> struct virtq_desc {
>         /* Buffer Address. */
>         le64 addr;
>         /* Buffer Length. */
>         le32 len;
>         /* Buffer ID. */
>         le16 id;
>         /* The flags depending on descriptor type. */
>         le16 flags;
> };
> \end{lstlisting}
> 
> The descriptor ring is zero-initialized.
> 
> \subsection{Event Suppression Structure Format}\label{sec:Basic Facilities of a Virtio Device / Packed Virtqueues / Event Suppression Structure Format}
> 
> The following structure is used to reduce the number of notifications sent between driver and device.
> 
> \begin{lstlisting}
> __le16 desc_event_off : 15; /* Descriptor Event Offset */
> int    desc_event_wrap : 1; /* Descriptor Event Wrap Counter */
> __le16 desc_event_flags : 2; /* Descriptor Event Flags */
> __le16 structure_change_flags : 1; /* Structure Change Event Flags */ \end{lstlisting}
> 
> \subsection{Driver Notification Format}\label{sec:Basic Facilities of a Virtio Device / Packed Virtqueues / Driver Notification Format}
> 
> The following structure is used to notify device of available descriptors and of event suppression structure changes:
> 
> \begin{lstlisting}
> __le16 vqn : 14;
> __le16 desc_event_flags : 2;
> __le16 desc_event_off : 15;
> int    desc_event_wrap : 1;
> \end{lstlisting}
> 
> \devicenormative{\subsubsection}{The Virtqueue Descriptor Table}{Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table} A device MUST NOT write to a device-readable buffer, and a device SHOULD NOT read a device-writable buffer.
> A device MUST NOT use a descriptor unless it observes VIRTQ_DESC_F_AVAIL bit in its \field{flags} being changed.
> A device MUST NOT change a descriptor after changing it's VIRTQ_DESC_F_USED bit in its \field{flags}.
> 
> \drivernormative{\subsubsection}{The Virtqueue Descriptor Table}{Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table} A driver MUST NOT change a descriptor unless it observes VIRTQ_DESC_F_USED bit in its \field{flags} being changed.
> A driver MUST NOT change a descriptor after changing VIRTQ_DESC_F_USED bit in its \field{flags}.
> 
> \drivernormative{\paragraph}{Scatter-Gather Support}{Basic Facilities of a Virtio Device / Packed Virtqueues / Scatter-Gather Support} The driver MUST NOT set the DESC_F_LIST_NEXT flag unless the VIRTIO_F_LIST_DESC feature was negotiated.
> 
> A driver MUST NOT create a descriptor list longer than allowed by the device.
> 
> A driver MUST NOT create a descriptor list longer than the Queue Size.
> 
> This implies that loops in the descriptor list are forbidden!
> 
> The driver MUST place any device-writable descriptor elements after any device-readable descriptor elements.
> 
> A driver MUST NOT depend on the device to use more descriptors to be able to write out all descriptors in a list. A driver MUST make sure there's enough space in the ring for the whole list before making any of the descriptors available to the device.
> 
> A driver MUST NOT make the first descriptor in the list available before initializing the rest of the descriptors.
> 
> \devicenormative{\paragraph}{Scatter-Gather Support}{Basic Facilities of a Virtio Device / Packed Virtqueues / Scatter-Gather Support} The device MUST use descriptors in a list chained by the VIRTQ_DESC_F_NEXT flag in the same order that they were made available by the driver.
> 
> The device MAY limit the number of buffers it will allow in a list.
> 
> \drivernormative{\paragraph}{Indirect Descriptors}{Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors} The driver MUST NOT set the DESC_F_INDIRECT flag unless the
> VIRTIO_F_INDIRECT_DESC feature was negotiated.   The driver MUST NOT
> set any flags except DESC_F_WRITE within an indirect descriptor.
> 
> A driver MUST NOT create a descriptor chain longer than allowed by the device.
> 
> A driver MUST NOT write direct descriptors with DESC_F_INDIRECT set in a scatter-gather list linked by VIRTQ_DESC_F_NEXT.
> \field{flags}.
> 
> 
> 
> 
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
> ---------------------------------------------------------------------
> Intel Corporation (UK) Limited
> Registered No. 1134945 (England)
> Registered Office: Pipers Way, Swindon SN3 1RJ
> VAT No: 860 2173 47
> 
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

