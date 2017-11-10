Return-Path: virtio-dev-return-2671-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 9905B5818F40
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Nov 2017 03:40:30 -0800 (PST)
Date: Fri, 10 Nov 2017 11:40:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171110114022.GF31658@stefanha-x1.localdomain>
References: <20171108141659-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qftxBdZWiueWNAVY"
Content-Disposition: inline
In-Reply-To: <20171108141659-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] [PATCH RFC] packed ring layout spec v4
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 02:28:10PM +0200, Michael S. Tsirkin wrote:
> Below is an attempt at a formal write-up of the latest proposal
> with some modifications. Will reply with a pdf version
> as well.
>=20
> This is reasonably complete functionally, from spec point of
> view we need
> - more conformance statements
> - pseudo-code
> - discussion of memory barriers
> - rearrange existing (1.0) layout discussion to make it fit
>   in a single chapter
>=20
> ----
>=20
> \section{Packed Virtqueues}\label{sec:Basic Facilities of a
> Virtio Device / Packed Virtqueues}
>=20
> Packed virtqueues is an alternative compact virtqueue layout using
> read-write memory, that is memory that is both read and written
> by both host and guest.
>=20
> This layout is enabled by negotiating a VIRTIO_F_PACKED_VIRTQUEUE
> feature.
>=20
> Packed virtqueues support up to $2^14$ queues, with up to $2^15$
> entries each.
>=20
> Each packed virtqueue consists of three parts:
>=20
> \begin{itemize}
> \item Descriptor Ring
> \item Device Event Suppression
> \item Driver Event Suppression
> \end{itemize}
>=20
> Where Descriptor Ring in turn consists of descriptors,
> and where each descriptor can contain the following parts:
>=20
> \begin{itemize}
> \item Buffer ID
> \item Buffer Address
> \item Buffer Length
> \item Flags
> \end{itemize}
>=20
> A buffer consists of zero or more device-readable physically-contiguous
> elements followed by zero or more physically-contiguous
> device-writable elements (each buffer has at least one element).

For clarity I suggest:

  A buffer consists of zero or more device-readable elements followed by
  zero or more device-writable elements.  Each buffer has at least one
  element.  Each element is a physically-contiguous range of memory.

By moving the "physically-contiguous" bit into a separate sentence it
becomes clear that successive elements don't have to be
physically-contiguous with respect to one another.

>=20
> When the driver wants to send such a buffer to the device, it
> writes at least one available descriptor describing elements of
> the buffer into the Descriptor Ring.  The descriptor(s) are
> associated with a buffer by means of a Buffer ID stored within
> the descriptor.
>=20
> Driver then notifies the device. When the device has finished
> processing the buffer, it writes a used device descriptor
> including the Buffer ID into the Descriptor Ring (overwriting a
> driver descriptor previously made available), and sends an
> interrupt.
>=20
> Descriptor Ring is used in a circular manner: driver writes
> descriptors into the ring in order. After reaching end of ring,
> the next descriptor is placed at head of the ring.  Once ring is
> full of driver descriptors, driver stops sending new requests and
> waits for device to start processing descriptors and to write out
> some used descriptors before making new driver descriptors
> available.
>=20
> Similarly, device reads descriptors from the ring in order and
> detects that a driver descriptor has been made available.  As
> processing of descriptors is completed used descriptors are

s/completed used/completed, used/

> written by the device back into the ring.
>=20
> Note: after reading driver descriptors and starting their
> processing in order, device might complete their processing out
> of order.  Used device descriptors are written in the order
> in which their processing is complete.
>=20
> Device Event suppression data structure is read-only by the
> device. It includes information for reducing the number of
> device interrupts to driver.
>=20
> Driver Event suppression data structure is write-only by the
> device. It includes information for reducing the number of
> driver notifications to device.

Existing terminology:
Device Event =3D=3D interrupts
Driver Event =3D=3D notifications

I suggest calling it "Interrupt Suppression Data" to make the
device->driver direction of the event obvious.  To me "Device Event
Suppression Data" isn't immediately obvious.

"Notification Suppression Data" is driver->device.  Again, clearer than
"Driver Event Suppression Data".

>=20
> \subsection{Available and Used Ring Full Counters}
> \label{sec:Packed Virtqueues / Available and Used Ring Wrap Counters}

"Full" and "Wrap" are used interchangeably?

A "full" ring usually refers to the situation where a producer is unable
to add elements.  That's not the same meaning as "wrap" (passing the end
of the ring and starting at the beginning again).

Use just "wrap" for consistency?

> Each of the driver and the device are expected to maintain,
> internally, a single-bit ring wrap counter initialized to 1.
>=20
> The counter maintained by the driver is called the Available
> Ring Full Counter. Driver changes its value each time it makes available =
the
> last descriptor in the ring (after making the last descriptor
> available).
>=20
> The counter maintained by the device is called the Used Ring Wrap
> Counter.  Device changes its value each time it uses the last descriptor =
in
> the ring (after marking the last descriptor used).
>=20
> It is easy to see that the Availablering Wrap Counter in the driver match=
es

s/Availablering/Available Ring/

> the Used Ring Wrap Counter in the device when both are processing the same
> descriptor, or when all available descriptors have been used.
>=20
> To mark a descriptor as available and used, both driver and
> device use the following two flags:
> \begin{lstlisting}
> #define VIRTQ_DESC_F_AVAIL     7
> #define VIRTQ_DESC_F_USED      15
> \end{lstlisting}
>=20
> To mark a descriptor as available, driver sets the
> VIRTQ_DESC_F_AVAIL bit in Flags to match the internal Available
> Ring Wrap Counter.  It also sets the VIRTQ_DESC_F_USED bit to match the
> \emph{inverse} value.
>=20
> To mark a descriptor as used, device sets the
> VIRTQ_DESC_F_USED bit in Flags to match the internal Used
> Ring Wrap Counter.  It also sets the VIRTQ_DESC_F_AVAIL bit to match the
> \emph{same} value.
>=20
> Thus VIRTQ_DESC_F_AVAIL and VIRTQ_DESC_F_USED bits are different
> for an available descriptor and equal for a used descriptor.
>=20
> \subsection{Polling of available and used descriptors}
> \label{sec:Packed Virtqueues / Polling of available and used descriptors}
>=20
> Writes of device and driver descriptors can generally be
> reordered, but each side (driver and device) are only required to
> poll a single location in memory: next device descriptor after
> the one they processed previously, in circular order.
>=20
> Sometimes device needs to only write out a single used descriptor
> after processing a batch of multiple available descriptors.  As
> described in more detail below, this can happen when using
> descriptor chaining or with in-order
> use of descriptors.  In this case, device writes out a used
> descriptor with buffer id of the last descriptor in the group.
> After processing the used descriptor, both device and driver then
> skip forward in the ring the number of the remaining descriptors
> in the group until processing (reading for the driver and writing
> for the device) the next used descriptor.

This paragraph isn't self-contained because it refers to batching and
in-order use of descriptors.  It would be more useful to move it where
these features are described.

>=20
> \subsection{Write Flag}
> \label{sec:Packed Virtqueues / Write Flag}
>=20
> In an available descriptor, VIRTQ_DESC_F_WRITE bit within Flags
> is used to mark a descriptor as corresponding to a write-only or

It's critical to mention which side write-only refers to:

s/write-only/device write-only/

> read-only element of a buffer.
>=20
> \begin{lstlisting}
> /* This marks a buffer as device write-only (otherwise device read-only).=
 */
> #define VIRTQ_DESC_F_WRITE     2
> \end{lstlisting}
>=20
> In a used descriptor, this bit it used to specify whether any
> data has been written by the device into any parts of the buffer.
>=20
>=20
> \subsection{Buffer Address and Length}
> \label{sec:Packed Virtqueues / Buffer Address and Length}
>=20
> In an available descriptor, Buffer Address corresponds to the
> physical address of the buffer. The length of the buffer assumed
> to be physically contigious is stored in Buffer Length.
>=20
> In a used descriptor, Buffer Address is unused. Buffer Length
> specifies the length of the buffer that has been initialized
> (written to) by the device.
>=20
> Buffer length is reserved for used descriptors without the
> VIRTQ_DESC_F_WRITE flag, and is ignored by drivers.
>=20
> \subsection{Scatter-Gather Support}
> \label{sec:Packed Virtqueues / Scatter-Gather Support}
>=20
> Some drivers need an ability to supply a list of multiple buffer
> elements (also known as a scatter/gather list) with a request.
> Two optional features support this: descriptor
> chaining and indirect descriptors.
>=20
> If neither feature has been negotiated, each buffer is
> physically-contigious, either read-only or write-only and is
> described completely by a single descriptor.
>=20
> While unusual (most implementations either create all lists
> solely using non-indirect descriptors, or always use a single
> indirect element), if both features have been negotiated, mixing
> direct and direct descriptors in a ring is valid, as long as each
> list only contains descriptors of a given type.
>=20
> Scatter/gather lists only apply to available descriptors. A
> single used descriptor corresponds to the whole list.
>=20
> The device limits the number of descriptors in a list through a
> bus-specific and/or device-specific value. If not limited,
> the maximum number of descriptors in a list is the virt queue
> size.
>=20
> \subsection{Next Flag: Descriptor Chaining}
> \label{sec:Packed Virtqueues / Next Flag: Descriptor Chaining}
>=20
> The VIRTIO_F_LIST_DESC feature allows driver to do this
> by using multiple descriptors, and setting the VIRTQ_DESC_F_NEXT in
> Flags for all but the last available descriptor.
>=20
> \begin{lstlisting}
> /* This marks a buffer as continuing. */
> #define VIRTQ_DESC_F_NEXT   1
> \end{lstlisting}
>=20
> Buffer ID is included in the last descriptor in the list. =20

Please make this statement stronger so all implementations behave the
same way:

  Buffer ID is reserved and must be zero in all descriptors that have
  VIRTQ_DESC_F_NEXT set.

This ensures that devices don't accidentally use the first descriptor's
Buffer ID if they are only tested against drivers that happen to set
Buffer ID in all descriptors.

>=20
> The driver always makes the the first descriptor in the list
> available after the rest of the list has been written out into
> the ring. This guarantees that the device will never observe a
> partial scatter/gather list in the ring.
>=20
> Device only writes out a single used descriptor for the whole
> list. It then skips forward according to the number of
> descriptors in the list. Driver needs to keep track of the size
> of the list corresponding to each buffer ID, to be able to skip
> to where the next used descriptor is written by the device.
>=20
> For example, if descriptors are used in the same order in which
> they are made available, this will result in the used descriptor
> overwriting the first available descriptor in the list, the used
> descriptor for the next list overwriting the first available
> descriptor in the next list, etc.
>=20
> VIRTQ_DESC_F_NEXT is reserved in used descriptors, and
> should be ignored by drivers.
>=20
> \subsection{Indirect Flag: Scatter-Gather Support}
> \label{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Support}
>=20
> Some devices benefit by concurrently dispatching a large number
> of large requests. The VIRTIO_F_INDIRECT_DESC feature allows this. To inc=
rease
> ring capacity the driver can store  (read-only by the device) table of in=
direct
> descriptors anywhere in memory, and insert a descriptor in main
> virtqueue (with \field{Flags}\&VIRTQ_DESC_F_INDIRECT on) that refers to

s/main virtqueue/Descriptor Ring/

> a memory buffer
> containing this indirect descriptor table; \field{addr} and \field{len}
> refer to the indirect table address and length in bytes,
> respectively.
> \begin{lstlisting}
> /* This means the buffer contains a table of buffer descriptors. */
> #define VIRTQ_DESC_F_INDIRECT   4
> \end{lstlisting}
>=20
> The indirect table layout structure looks like this
> (\field{len} is the Buffer Length of the descriptor that refers to this t=
able,
> which is a variable, so this code won't compile):
>=20
> \begin{lstlisting}
> struct indirect_descriptor_table {
>         /* The actual descriptor structures (struct Desc each) */
>         struct Desc desc[len / sizeof(struct Desc)];

s/struct Desc/struct virtq_desc/

> };
> \end{lstlisting}
>=20
> The first descriptor is located at start of the indirect
> descriptor table, additional indirect descriptors come
> immediately afterwards. \field{Flags} \&VIRTQ_DESC_F_WRITE is the
> only valid flag for descriptors in the indirect table. Others
> are reserved are ignored by the device.=20
> Buffer ID is also reserved and is ignored by the device.
>=20
> In Descriptors with VIRTQ_DESC_F_INDIRECT set VIRTQ_DESC_F_WRITE
> is reserved and is ignored by the device.
>=20
> \subsection{In-order use of descriptors}
> \label{sec:Packed Virtqueues / In-order use of descriptors}
>=20
> Some devices always use descriptors in the same order in which
> they have been made available. These devices can offer the
> VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge allows
> devices to notify the use of a batch of buffers to the driver by
> only writing out a single used descriptor with the Buffer ID
> corresponding to the last descriptor in the batch.
>=20
> Device then skips forward in the ring according to the size of
> the the batch. Driver needs to look up the used Buffer ID and
> calculate the batch size to be able to advance to where the next
> used descriptor will be written by the device.
>=20
> This will result in the used descriptor overwriting the first
> available descriptor in the batch, the used descriptor for the
> next batch overwriting the first available descriptor in the next
> batch, etc.
>=20
> The skipped buffers (for which no used descriptor was written)
> are assumed to have been used (read or written) by the
> device completely.

This is an important detail :).  I think it should be mentioned
alongside the in-order processing requirement.  Otherwise people will
try to use this feature only to realize partway through
design/implementation that it doesn't work because they need
VIRTQ_DESC_F_WRITE descriptors where the device's Buffer Length response
matters.

>=20
> \subsection{Multi-buffer requests}
> \label{sec:Packed Virtqueues / Multi-descriptor batches}

Confusing subsection vs label name.  "Requests" seems to mean multiple
buffers that form a unit.  "multi-descriptor batches" does not imply a
unit, just that a notification is made for multiple buffers.

> Some devices combine multiple buffers as part of processing a
> single request.  These devices always makes the the first

s/makes the the/make the/

> descriptor in the request available after the rest of the request
> has been written out request the ring. This guarantees that the
> driver will never observe a partial request in the ring.

Interesting, I've never seen a VIRTIO device that uses multiple buffers
as a single request unit before.

Does this mean that devices must only poll the current available
location?  If devices poll further ahead then multi-descriptor batching
doesn't work (of course VIRTIO_F_LIST_DESC would also have to be
disabled).

> \subsection{Driver and Device Event Suppression}
> \label{sec:Packed Virtqueues / Driver and Device Event Suppression}
> In many systems driver and device notifications involve
> significant overhead. To mitigate this overhead,
> each virtqueue includes two identical structures used for
> controlling notifications between device and driver.
>=20
> Driver Event Suppression structure is read-only by the
> device and controls the events sent by the device
> (e.g. interrupts).
>=20
> Device Event Suppression structure is read-only by
> the driver and controls the events sent by the driver
> (e.g. IO).
>=20
>=20
> Each of these structures includes the following fields:
>=20
> \begin{description}
> \item [Descriptor Event Flags] Takes values:
> \begin{itemize}
> \item 00b reserved
> \item 01b enable events
> \item 11b disable events
> \item 10b enable events for a specific descriptor
> (as specified by Descriptor Event Offset/Wrap Counter).
> \end{itemize}
> \item [Descriptor Event Offset] If Event Flags set to descriptor
> specific event: offset within the ring (in units of descriptor
> size). Event will only trigger when this descriptor is
> made available/used respectively.

"offset within the ring (in units of descriptor size)"

Does this simply mean "ring index"?  The term is clearer because the
units don't need to be explained.  So this field would be called
"Descriptor Ring Index".

> \item [Descriptor Event Wrap Counter]If Event Flags set to descriptor
> specific event: offset within the ring (in units of descriptor

"offset within the ring (in units of descriptor size)"

Copy-paste mistake?

> size). Event will only trigger when Ring Wrap Counter
> matches this value and a descriptor is
> made available/used respectively.

Just to be clear that there is no single "Ring Wrap Counter":

s/when Ring Wrap Counter/when the respective Available or Used Ring Wrap
Counter/

> \end{description}
>=20
> After writing out some descriptors, both device and driver
> are expected to consult the relevant structure to find out
> whether interrupt should be sent. As this access to

Perhaps it's clearer to talk about "raising an event" instead of
"notifications"/"interrupts" because they have specific meanings
elsewhere.

> shared memory involves overhead for some transports,
> the following additional field is present:
>=20
> \begin{description}
> \item [Structure Change Event Flags] Enable/disable sending an
> event notification when the other side changes its own Event
> Suppression structure.
> \end{description}
>=20
> when enabled through this field, device and driver send an event
> notification whenever they change the driver and device event
> suppression structure respectively.
>=20
>=20
> \subsubsection{Driver notifications}
> \label{sec:Packed Virtqueues / Driver notifications}
> Some devices benefit from ability to find out the number of
> available descriptors in the ring, and whether to send
> interrupts to drivers without accessing ring memory:
> for efficiency or as a debugging aid.
>=20
> To help with these optimizations, driver notifications
> to the device include the following information:
>=20
> \begin{itemize}
> \item VQ number
> \item Flags - set to 00b
> \item Offset (in units of descriptor size) within the ring
>       where the next available descriptor will be written

Is this a Descriptor Ring index?

> \item Available Ring Wrap Counter
> \end{itemize}
>=20
> Whenever driver notifies device about a Device Event Suppression
> Structure change (if enabled through Structure Change Event Flags
> in Driver Event Suppression Structure), it sends a copy
> of the up-to-date Event Suppression Structure:
>=20
> \begin{itemize}
> \item VQ number
> \item Descriptor Event Flags
> \item Descriptor Event Offset
> \item Descriptor Event Wrap Counter
> \end{itemize}

I'm confused about the word "internally" that was previously used to
describe how wrap counters are used:

  Each of the driver and the device are expected to maintain,
  internally, a single-bit ring wrap counter initialized to 1.

I thought "internally" meant that the other side cannot see the value,
but this section says that the wrap counter is sent to the other side.

> \subsubsection{Structure Size and Alignment}
> \label{sec:Packed Virtqueues / Structure Size and Alignment}
>=20
> Each part of the virtqueue is physically-contiguous in guest memory,
> and has different alignment requirements.

Please move this below the table that shows the "parts" of the
virtqueue.  That way the reader knows what the parts are.

>=20
> The memory aligment and size requirements, in bytes, of each part of the
> virtqueue are summarized in the following table:
>=20
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
>=20
> The Alignment column gives the minimum alignment for each part
> of the virtqueue.
>=20
> The Size column gives the total number of bytes for each
> part of the virtqueue.
>=20
> Queue Size corresponds to the maximum number of descriptors in the
> virtqueue\footnote{For example, if Queue Size is 4 then at most 4 buffers
> can be queued at any given time.}.  Queue Size value does not
> have to be a power of 2 unless enforced by the transport.
>=20
> \drivernormative{\subsection}{Virtqueues}{Basic Facilities of a
> Virtio Device / Packed Virtqueues}
> The driver MUST ensure that the physical address of the first byte
> of each virtqueue part is a multiple of the specified alignment value
> in the above table.
>=20
> \devicenormative{\subsection}{Virtqueues}{Basic Facilities of a
> Virtio Device / Packed Virtqueues}
> The device MUST start processing driver descriptors in the order
> in which they appear in the ring.
> The device MUST start writing device descriptors into the ring in
> the order in which they complete.
> Device MAY reorder descriptor writes once they are started.
>=20
> \subsection{The Virtqueue Descriptor Format}\label{sec:Basic
> Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue
> Descriptor Format}
>=20
> The available descriptor refers to the buffers the driver is sending
> to the device. \field{addr} is a physical address, and the
> descriptor is identified with a buffer using the \field{id} field.
>=20
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
>=20
> The descriptor ring is zero-initialized.
>=20
> \subsection{Event Suppression Structure Format}\label{sec:Basic
> Facilities of a Virtio Device / Packed Virtqueues / Event Suppression Str=
ucture
> Format}
>=20
> The following structure is used to reduce the number of
> notifications sent between driver and device.
>=20
> \begin{lstlisting}
> __le16 desc_event_off : 15; /* Descriptor Event Offset */
> int    desc_event_wrap : 1; /* Descriptor Event Wrap Counter */
> __le16 desc_event_flags : 2; /* Descriptor Event Flags */
> __le16 structure_change_flags : 1; /* Structure Change Event Flags */
> \end{lstlisting}
>=20
> \subsection{Driver Notification Format}\label{sec:Basic
> Facilities of a Virtio Device / Packed Virtqueues / Driver Notification F=
ormat}
>=20
> The following structure is used to notify device of available
> descriptors and of event suppression structure changes:
>=20
> \begin{lstlisting}
> __le16 vqn : 14;
> __le16 desc_event_flags : 2;
> __le16 desc_event_off : 15;
> int    desc_event_wrap : 1;
> \end{lstlisting}
>=20
> \devicenormative{\subsubsection}{The Virtqueue Descriptor Table}{Basic Fa=
cilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table}
> A device MUST NOT write to a device-readable buffer, and a device SHOULD =
NOT
> read a device-writable buffer.
> A device MUST NOT use a descriptor unless it observes
> VIRTQ_DESC_F_AVAIL bit in its \field{flags} being changed.
> A device MUST NOT change a descriptor after changing it's
> VIRTQ_DESC_F_USED bit in its \field{flags}.
>=20
> \drivernormative{\subsubsection}{The Virtqueue Descriptor Table}{Basic Fa=
cilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table}
> A driver MUST NOT change a descriptor unless it observes
> VIRTQ_DESC_F_USED bit in its \field{flags} being changed.
> A driver MUST NOT change a descriptor after changing
> VIRTQ_DESC_F_USED bit in its \field{flags}.
>=20
> \drivernormative{\paragraph}{Scatter-Gather Support}{Basic Facilities of a
> Virtio Device / Packed Virtqueues / Scatter-Gather Support}
> The driver MUST NOT set the DESC_F_LIST_NEXT flag unless the
> VIRTIO_F_LIST_DESC feature was negotiated.
>=20
> A driver MUST NOT create a descriptor list longer than allowed
> by the device.
>=20
> A driver MUST NOT create a descriptor list longer than the Queue
> Size.
>=20
> This implies that loops in the descriptor list are forbidden!
>=20
> The driver MUST place any device-writable descriptor elements after
> any device-readable descriptor elements.
>=20
> A driver MUST NOT depend on the device to use more descriptors
> to be able to write out all descriptors in a list. A driver
> MUST make sure there's enough space in the ring
> for the whole list before making any of the
> descriptors available to the device.
>=20
> A driver MUST NOT make the first descriptor in the list
> available before initializing the rest of the descriptors.
>=20
> \devicenormative{\paragraph}{Scatter-Gather Support}{Basic Facilities of a
> Virtio Device / Packed Virtqueues / Scatter-Gather Support}
> The device MUST use descriptors in a list chained by the
> VIRTQ_DESC_F_NEXT flag in the same order that they
> were made available by the driver.
>=20
> The device MAY limit the number of buffers it will allow in a
> list.
>=20
> \drivernormative{\paragraph}{Indirect Descriptors}{Basic Facilities of a =
Virtio Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Desc=
riptors}
> The driver MUST NOT set the DESC_F_INDIRECT flag unless the
> VIRTIO_F_INDIRECT_DESC feature was negotiated.   The driver MUST NOT
> set any flags except DESC_F_WRITE within an indirect descriptor.
>=20
> A driver MUST NOT create a descriptor chain longer than allowed
> by the device.
>=20
> A driver MUST NOT write direct descriptors with
> DESC_F_INDIRECT set in a scatter-gather list linked by
> VIRTQ_DESC_F_NEXT.
> \field{flags}.
>=20
>=20
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20

--qftxBdZWiueWNAVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaBZAmAAoJEJykq7OBq3PIQ8kIALn0BKocyFM1ZeaJdgBFAXla
FCz+TrGwvL/WlBuJ1AW0RsPqMZRXhc32CzP3rq0IDRqG/Y4kuzD3oNsa3QAmbvHr
76ZaXJh/QgBHCN5VBa71RnSFzP90v5aP5qErSDf7ADFJmN/FY8H8o4Um4n+Lp5K8
Ph4WiumvrsT+dOyfvLKVjZ3AJljseKSGDB0HVLpUpbByeLlsQllwmwvw56srEV/7
+f8fYfq/QBGxDbEORkF1X0CDRcj6M1IDPnfzkHZnzay4uON3cmm95l2r3ExErhz1
VqL7/cDgtTUejb2WcVS7wBE40+iDgmCgV3fqUVdOwDwQVdl3gqFCGJnXQF4mfdg=
=eqZb
-----END PGP SIGNATURE-----

--qftxBdZWiueWNAVY--
