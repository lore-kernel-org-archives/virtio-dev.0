Return-Path: virtio-dev-return-2686-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 33D6058191AB
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Nov 2017 02:44:36 -0800 (PST)
From: Lars Ganrot <lga@napatech.com>
Date: Thu, 16 Nov 2017 10:44:07 +0000
Message-ID: <d0a6a292458d4a0584c5b06b22e24e14@napatech.com>
References: <20171108141659-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171108141659-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] [PATCH RFC] packed ring layout spec v4
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Michael,

Added comments inline labeled [#lga#].

BR,

-Lars

> -----Original Message-----
> From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-open=
.org]
> On Behalf Of Michael S. Tsirkin
> Sent: 8. november 2017 13:28
> To: virtio-dev@lists.oasis-open.org
> Subject: [virtio-dev] [PATCH RFC] packed ring layout spec v4
>=20
> Below is an attempt at a formal write-up of the latest proposal with some
> modifications. Will reply with a pdf version as well.
>=20
> This is reasonably complete functionally, from spec point of view we need
> - more conformance statements
> - pseudo-code
> - discussion of memory barriers
> - rearrange existing (1.0) layout discussion to make it fit
>   in a single chapter
>=20
> ----
>=20
> \section{Packed Virtqueues}\label{sec:Basic Facilities of a Virtio Device=
 / Packed
> Virtqueues}
>=20
> Packed virtqueues is an alternative compact virtqueue layout using read-w=
rite
> memory, that is memory that is both read and written by both host and gue=
st.
>=20
> This layout is enabled by negotiating a VIRTIO_F_PACKED_VIRTQUEUE feature=
.

[#lga#] A non-technical concern: By making this a feature bit, means v1.1 s=
upports both descriptor structures in parallel: Could that not slow the ado=
ption of the new ring structure? Another way would be to make Virtio v1.1 e=
xclusively ring-based, and first let the device and driver negotiate the hi=
ghest revision of the standard they both support, followed by negotiating t=
he optional features within the agreed revision. Are there use-cases where =
the ring would under-perform relative the current structure?

>=20
> Packed virtqueues support up to $2^14$ queues, with up to $2^15$ entries =
each.

[#lga#] What limits the number of queues to 2^14?

>=20
> Each packed virtqueue consists of three parts:
>=20
> \begin{itemize}
> \item Descriptor Ring
> \item Device Event Suppression
> \item Driver Event Suppression
> \end{itemize}
>=20
> Where Descriptor Ring in turn consists of descriptors, and where each des=
criptor
> can contain the following parts:
>=20
> \begin{itemize}
> \item Buffer ID
> \item Buffer Address
> \item Buffer Length
> \item Flags
> \end{itemize}
>=20
> A buffer consists of zero or more device-readable physically-contiguous
> elements followed by zero or more physically-contiguous device-writable
> elements (each buffer has at least one element).
>=20
> When the driver wants to send such a buffer to the device, it writes at l=
east one
> available descriptor describing elements of the buffer into the Descripto=
r Ring.
> The descriptor(s) are associated with a buffer by means of a Buffer ID st=
ored
> within the descriptor.

[#lga#]  Only a single descriptor per buffer will have a valid BufferID, ri=
ght? Thus chained or indirect descriptors may/will not have a valid BufferI=
D within them

>=20
> Driver then notifies the device. When the device has finished processing =
the
> buffer, it writes a used device descriptor including the Buffer ID into t=
he
> Descriptor Ring (overwriting a driver descriptor previously made availabl=
e), and
> sends an interrupt.
>=20
> Descriptor Ring is used in a circular manner: driver writes descriptors i=
nto the
> ring in order. After reaching end of ring, the next descriptor is placed =
at head of
> the ring.  Once ring is full of driver descriptors, driver stops sending =
new requests
> and waits for device to start processing descriptors and to write out som=
e used
> descriptors before making new driver descriptors available.
>=20
> Similarly, device reads descriptors from the ring in order and detects th=
at a
> driver descriptor has been made available.  As processing of descriptors =
is
> completed used descriptors are written by the device back into the ring.
>=20
> Note: after reading driver descriptors and starting their processing in o=
rder,
> device might complete their processing out of order.  Used device descrip=
tors
> are written in the order in which their processing is complete.
>=20
> Device Event suppression data structure is read-only by the device. It in=
cludes
> information for reducing the number of device interrupts to driver.
>=20
> Driver Event suppression data structure is write-only by the device. It i=
ncludes
> information for reducing the number of driver notifications to device.
>=20
> \subsection{Available and Used Ring Full Counters} \label{sec:Packed Virt=
queues
> / Available and Used Ring Wrap Counters} Each of the driver and the devic=
e are
> expected to maintain, internally, a single-bit ring wrap counter initiali=
zed to 1.
>=20
> The counter maintained by the driver is called the Available Ring Full Co=
unter.
> Driver changes its value each time it makes available the last descriptor=
 in the
> ring (after making the last descriptor available).
>=20
> The counter maintained by the device is called the Used Ring Wrap Counter=
.
> Device changes its value each time it uses the last descriptor in the rin=
g (after
> marking the last descriptor used).
>=20
> It is easy to see that the Availablering Wrap Counter in the driver match=
es the
> Used Ring Wrap Counter in the device when both are processing the same
> descriptor, or when all available descriptors have been used.

[#lga#] How can a driver and a device process the same descriptor (at the s=
ame time)?=20

>=20
> To mark a descriptor as available and used, both driver and device use th=
e
> following two flags:
> \begin{lstlisting}
> #define VIRTQ_DESC_F_AVAIL     7
> #define VIRTQ_DESC_F_USED      15
> \end{lstlisting}
>=20
> To mark a descriptor as available, driver sets the VIRTQ_DESC_F_AVAIL bit=
 in
> Flags to match the internal Available Ring Wrap Counter.  It also sets th=
e
> VIRTQ_DESC_F_USED bit to match the \emph{inverse} value.
>=20
> To mark a descriptor as used, device sets the VIRTQ_DESC_F_USED bit in Fl=
ags
> to match the internal Used Ring Wrap Counter.  It also sets the
> VIRTQ_DESC_F_AVAIL bit to match the \emph{same} value.
>=20
> Thus VIRTQ_DESC_F_AVAIL and VIRTQ_DESC_F_USED bits are different for an
> available descriptor and equal for a used descriptor.
>=20
> \subsection{Polling of available and used descriptors} \label{sec:Packed
> Virtqueues / Polling of available and used descriptors}
>=20
> Writes of device and driver descriptors can generally be reordered, but e=
ach side
> (driver and device) are only required to poll a single location in memory=
: next
> device descriptor after the one they processed previously, in circular or=
der.

[#lga#] The poll location is not straight-forward for batch-used descriptor=
s, and could use a little more elaboration.

>=20
> Sometimes device needs to only write out a single used descriptor after
> processing a batch of multiple available descriptors.  As described in mo=
re detail
> below, this can happen when using descriptor chaining or with in-order us=
e of
> descriptors.  In this case, device writes out a used descriptor with buff=
er id of the
> last descriptor in the group.
> After processing the used descriptor, both device and driver then skip fo=
rward in
> the ring the number of the remaining descriptors in the group until proce=
ssing
> (reading for the driver and writing for the device) the next used descrip=
tor.
>=20
> \subsection{Write Flag}
> \label{sec:Packed Virtqueues / Write Flag}
>=20
> In an available descriptor, VIRTQ_DESC_F_WRITE bit within Flags is used t=
o mark
> a descriptor as corresponding to a write-only or read-only element of a b=
uffer.
>=20
> \begin{lstlisting}
> /* This marks a buffer as device write-only (otherwise device read-only).=
 */
> #define VIRTQ_DESC_F_WRITE     2
> \end{lstlisting}
>=20
> In a used descriptor, this bit it used to specify whether any data has be=
en written
> by the device into any parts of the buffer.

[#lga#] I assume "any parts of the buffer"  is to handle batch-used descrip=
tor writes, however since a used device-write-only descriptor can only cont=
ain a single length value, this can only mean starting from the address of =
the first device-write-only descriptor of the batch. Thus it is not "any pa=
rt" but a very specific part that has must have been written. If multiple d=
evice-write-only elements are part of the buffer, they may need to be non-b=
atch-used to correctly reflect the parts written in the buffer.

>=20
>=20
> \subsection{Buffer Address and Length}
> \label{sec:Packed Virtqueues / Buffer Address and Length}
>=20
> In an available descriptor, Buffer Address corresponds to the physical ad=
dress of
> the buffer. The length of the buffer assumed to be physically contigious =
is stored
> in Buffer Length.
>=20
> In a used descriptor, Buffer Address is unused. Buffer Length specifies t=
he length
> of the buffer that has been initialized (written to) by the device.
>=20
> Buffer length is reserved for used descriptors without the VIRTQ_DESC_F_W=
RITE
> flag, and is ignored by drivers.
>=20
> \subsection{Scatter-Gather Support}
> \label{sec:Packed Virtqueues / Scatter-Gather Support}
>=20
> Some drivers need an ability to supply a list of multiple buffer elements=
 (also
> known as a scatter/gather list) with a request.

[#lga#] "list of multiple buffer elements ... with a request" is another wa=
y of saying "multiple descriptors ... for a buffer"?

> Two optional features support this: descriptor chaining and indirect desc=
riptors.
>=20
> If neither feature has been negotiated, each buffer is physically-contigi=
ous,
> either read-only or write-only and is described completely by a single de=
scriptor.
>=20
> While unusual (most implementations either create all lists solely using =
non-
> indirect descriptors, or always use a single indirect element), if both f=
eatures
> have been negotiated, mixing direct and direct descriptors in a ring is v=
alid, as
> long as each list only contains descriptors of a given type.
>=20
> Scatter/gather lists only apply to available descriptors. A single used d=
escriptor
> corresponds to the whole list.
>=20
> The device limits the number of descriptors in a list through a bus-speci=
fic and/or
> device-specific value. If not limited, the maximum number of descriptors =
in a list
> is the virt queue size.
>=20
> \subsection{Next Flag: Descriptor Chaining} \label{sec:Packed Virtqueues =
/ Next
> Flag: Descriptor Chaining}
>=20
> The VIRTIO_F_LIST_DESC feature allows driver to do this by using multiple
> descriptors, and setting the VIRTQ_DESC_F_NEXT in Flags for all but the l=
ast
> available descriptor.
>=20
> \begin{lstlisting}
> /* This marks a buffer as continuing. */
> #define VIRTQ_DESC_F_NEXT   1
> \end{lstlisting}
>=20
> Buffer ID is included in the last descriptor in the list.
>=20
> The driver always makes the the first descriptor in the list available af=
ter the rest
> of the list has been written out into the ring. This guarantees that the =
device will
> never observe a partial scatter/gather list in the ring.
>=20
> Device only writes out a single used descriptor for the whole list. It th=
en skips
> forward according to the number of descriptors in the list. Driver needs =
to keep
> track of the size of the list corresponding to each buffer ID, to be able=
 to skip to
> where the next used descriptor is written by the device.
>=20

[#lga#] Regarding this side structure for keeping track of descriptor chain=
ing, addresses, etc. The driver needs to reference it to process used descr=
iptors correctly. Is there a risk that the v1.0 avail/used cache misses are=
 just traded for side structure cache misses in v1.1?

> For example, if descriptors are used in the same order in which they are =
made
> available, this will result in the used descriptor overwriting the first =
available
> descriptor in the list, the used descriptor for the next list overwriting=
 the first
> available descriptor in the next list, etc.
>=20
> VIRTQ_DESC_F_NEXT is reserved in used descriptors, and should be ignored =
by
> drivers.
>=20
> \subsection{Indirect Flag: Scatter-Gather Support} \label{sec:Packed Virt=
queues
> / Indirect Flag: Scatter-Gather Support}
>=20
> Some devices benefit by concurrently dispatching a large number of large
> requests. The VIRTIO_F_INDIRECT_DESC feature allows this. To increase rin=
g
> capacity the driver can store  (read-only by the device) table of indirec=
t
> descriptors anywhere in memory, and insert a descriptor in main virtqueue=
 (with
> \field{Flags}\&VIRTQ_DESC_F_INDIRECT on) that refers to a memory buffer
> containing this indirect descriptor table; \field{addr} and \field{len} r=
efer to the
> indirect table address and length in bytes, respectively.
> \begin{lstlisting}
> /* This means the buffer contains a table of buffer descriptors. */
> #define VIRTQ_DESC_F_INDIRECT   4
> \end{lstlisting}
>=20
> The indirect table layout structure looks like this (\field{len} is the B=
uffer Length
> of the descriptor that refers to this table, which is a variable, so this=
 code won't
> compile):
>=20
> \begin{lstlisting}
> struct indirect_descriptor_table {
>         /* The actual descriptor structures (struct Desc each) */
>         struct Desc desc[len / sizeof(struct Desc)]; }; \end{lstlisting}
>=20
> The first descriptor is located at start of the indirect descriptor table=
, additional
> indirect descriptors come immediately afterwards. \field{Flags}
> \&VIRTQ_DESC_F_WRITE is the only valid flag for descriptors in the indire=
ct
> table. Others are reserved are ignored by the device.
> Buffer ID is also reserved and is ignored by the device.
>=20
> In Descriptors with VIRTQ_DESC_F_INDIRECT set VIRTQ_DESC_F_WRITE is
> reserved and is ignored by the device.
>=20
> \subsection{In-order use of descriptors} \label{sec:Packed Virtqueues / I=
n-order
> use of descriptors}
>=20
> Some devices always use descriptors in the same order in which they have =
been
> made available. These devices can offer the VIRTIO_F_IN_ORDER feature. If
> negotiated, this knowledge allows devices to notify the use of a batch of=
 buffers
> to the driver by only writing out a single used descriptor with the Buffe=
r ID
> corresponding to the last descriptor in the batch.
>=20
> Device then skips forward in the ring according to the size of the the ba=
tch.
> Driver needs to look up the used Buffer ID and calculate the batch size t=
o be able
> to advance to where the next used descriptor will be written by the devic=
e.
>=20
> This will result in the used descriptor overwriting the first available d=
escriptor in
> the batch, the used descriptor for the next batch overwriting the first a=
vailable
> descriptor in the next batch, etc.
>=20
> The skipped buffers (for which no used descriptor was written) are assume=
d to
> have been used (read or written) by the device completely.
>=20
> \subsection{Multi-buffer requests}
> \label{sec:Packed Virtqueues / Multi-descriptor batches} Some devices com=
bine
> multiple buffers as part of processing a single request.  These devices a=
lways
> makes the the first descriptor in the request available after the rest of=
 the
> request has been written out request the ring. This guarantees that the d=
river
> will never observe a partial request in the ring.
>=20
>=20
> \subsection{Driver and Device Event Suppression} \label{sec:Packed Virtqu=
eues /
> Driver and Device Event Suppression} In many systems driver and device
> notifications involve significant overhead. To mitigate this overhead, ea=
ch
> virtqueue includes two identical structures used for controlling notifica=
tions
> between device and driver.
>=20
> Driver Event Suppression structure is read-only by the device and control=
s the
> events sent by the device (e.g. interrupts).
>=20
> Device Event Suppression structure is read-only by the driver and control=
s the
> events sent by the driver (e.g. IO).
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
> \item 10b enable events for a specific descriptor (as specified by Descri=
ptor
> Event Offset/Wrap Counter).
> \end{itemize}
> \item [Descriptor Event Offset] If Event Flags set to descriptor specific=
 event:
> offset within the ring (in units of descriptor size). Event will only tri=
gger when
> this descriptor is made available/used respectively.

[#lga#] If it relates to a specific index in the ring, why not add a driver=
-notification-flag in the descriptor, such that the driver can adjust on wh=
ich descriptor is wants a notification. This would eliminate the need for a=
 separate driver notification structure. With regards to the device events,=
 wouldn't a threshold of available descriptors or total size of available b=
uffers be more natural than a fixed index in the ring?

> \item [Descriptor Event Wrap Counter]If Event Flags set to descriptor spe=
cific
> event: offset within the ring (in units of descriptor size). Event will o=
nly trigger
> when Ring Wrap Counter matches this value and a descriptor is made
> available/used respectively.

[#lga#] Is the idea with the "Event Wrap Counter" to reduce notifications t=
o every other ring-wrap? How/when is this used?

> \end{description}
>=20
> After writing out some descriptors, both device and driver are expected t=
o
> consult the relevant structure to find out whether interrupt should be se=
nt. As
> this access to shared memory involves overhead for some transports, the
> following additional field is present:
>=20
> \begin{description}
> \item [Structure Change Event Flags] Enable/disable sending an event
> notification when the other side changes its own Event Suppression struct=
ure.
> \end{description}
>=20
> when enabled through this field, device and driver send an event notifica=
tion
> whenever they change the driver and device event suppression structure
> respectively.
>=20
>=20
> \subsubsection{Driver notifications}
> \label{sec:Packed Virtqueues / Driver notifications} Some devices benefit=
 from
> ability to find out the number of available descriptors in the ring, and =
whether to
> send interrupts to drivers without accessing ring memory:
> for efficiency or as a debugging aid.
>=20
> To help with these optimizations, driver notifications to the device incl=
ude the
> following information:
>=20
> \begin{itemize}
> \item VQ number
> \item Flags - set to 00b
> \item Offset (in units of descriptor size) within the ring
>       where the next available descriptor will be written \item Available=
 Ring Wrap
> Counter \end{itemize}
>=20
> Whenever driver notifies device about a Device Event Suppression Structur=
e
> change (if enabled through Structure Change Event Flags in Driver Event
> Suppression Structure), it sends a copy of the up-to-date Event Suppressi=
on
> Structure:
>=20
> \begin{itemize}
> \item VQ number
> \item Descriptor Event Flags
> \item Descriptor Event Offset
> \item Descriptor Event Wrap Counter
> \end{itemize}
>=20
>=20
> \subsubsection{Structure Size and Alignment} \label{sec:Packed Virtqueues=
 /
> Structure Size and Alignment}
>=20
> Each part of the virtqueue is physically-contiguous in guest memory, and =
has
> different alignment requirements.
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
> The Alignment column gives the minimum alignment for each part of the
> virtqueue.
>=20
> The Size column gives the total number of bytes for each part of the virt=
queue.
>=20
> Queue Size corresponds to the maximum number of descriptors in the
> virtqueue\footnote{For example, if Queue Size is 4 then at most 4 buffers=
 can be
> queued at any given time.}.  Queue Size value does not have to be a power=
 of 2
> unless enforced by the transport.
>=20
> \drivernormative{\subsection}{Virtqueues}{Basic Facilities of a Virtio De=
vice /
> Packed Virtqueues} The driver MUST ensure that the physical address of th=
e first
> byte of each virtqueue part is a multiple of the specified alignment valu=
e in the
> above table.
>=20
> \devicenormative{\subsection}{Virtqueues}{Basic Facilities of a Virtio De=
vice /
> Packed Virtqueues} The device MUST start processing driver descriptors in=
 the
> order in which they appear in the ring.
> The device MUST start writing device descriptors into the ring in the ord=
er in
> which they complete.
> Device MAY reorder descriptor writes once they are started.
>=20
> \subsection{The Virtqueue Descriptor Format}\label{sec:Basic Facilities o=
f a
> Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Format}
>=20
> The available descriptor refers to the buffers the driver is sending to t=
he device.
> \field{addr} is a physical address, and the descriptor is identified with=
 a buffer
> using the \field{id} field.
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
> \subsection{Event Suppression Structure Format}\label{sec:Basic Facilitie=
s of a
> Virtio Device / Packed Virtqueues / Event Suppression Structure Format}
>=20
> The following structure is used to reduce the number of notifications sen=
t
> between driver and device.
>=20
> \begin{lstlisting}
> __le16 desc_event_off : 15; /* Descriptor Event Offset */
> int    desc_event_wrap : 1; /* Descriptor Event Wrap Counter */
> __le16 desc_event_flags : 2; /* Descriptor Event Flags */
> __le16 structure_change_flags : 1; /* Structure Change Event Flags */
> \end{lstlisting}
>=20
> \subsection{Driver Notification Format}\label{sec:Basic Facilities of a V=
irtio
> Device / Packed Virtqueues / Driver Notification Format}
>=20
> The following structure is used to notify device of available descriptors=
 and of
> event suppression structure changes:
>=20
> \begin{lstlisting}
> __le16 vqn : 14;
> __le16 desc_event_flags : 2;
> __le16 desc_event_off : 15;
> int    desc_event_wrap : 1;
> \end{lstlisting}
>=20
> \devicenormative{\subsubsection}{The Virtqueue Descriptor Table}{Basic
> Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Tab=
le} A
> device MUST NOT write to a device-readable buffer, and a device SHOULD NO=
T
> read a device-writable buffer.
> A device MUST NOT use a descriptor unless it observes VIRTQ_DESC_F_AVAIL =
bit
> in its \field{flags} being changed.
> A device MUST NOT change a descriptor after changing it's
> VIRTQ_DESC_F_USED bit in its \field{flags}.
>=20
> \drivernormative{\subsubsection}{The Virtqueue Descriptor Table}{Basic
> Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Tab=
le} A
> driver MUST NOT change a descriptor unless it observes VIRTQ_DESC_F_USED
> bit in its \field{flags} being changed.
> A driver MUST NOT change a descriptor after changing VIRTQ_DESC_F_USED bi=
t
> in its \field{flags}.
>=20
> \drivernormative{\paragraph}{Scatter-Gather Support}{Basic Facilities of =
a Virtio
> Device / Packed Virtqueues / Scatter-Gather Support} The driver MUST NOT =
set
> the DESC_F_LIST_NEXT flag unless the VIRTIO_F_LIST_DESC feature was
> negotiated.
>=20
> A driver MUST NOT create a descriptor list longer than allowed by the dev=
ice.
>=20
> A driver MUST NOT create a descriptor list longer than the Queue Size.
>=20
> This implies that loops in the descriptor list are forbidden!
>=20
> The driver MUST place any device-writable descriptor elements after any d=
evice-
> readable descriptor elements.
>=20
> A driver MUST NOT depend on the device to use more descriptors to be able=
 to
> write out all descriptors in a list. A driver MUST make sure there's enou=
gh space
> in the ring for the whole list before making any of the descriptors avail=
able to
> the device.
>=20
> A driver MUST NOT make the first descriptor in the list available before
> initializing the rest of the descriptors.
>=20
> \devicenormative{\paragraph}{Scatter-Gather Support}{Basic Facilities of =
a
> Virtio Device / Packed Virtqueues / Scatter-Gather Support} The device MU=
ST
> use descriptors in a list chained by the VIRTQ_DESC_F_NEXT flag in the sa=
me
> order that they were made available by the driver.

[#lga#] Ambiguity with regards to "order ... made available". It is not in =
the order the driver set the "available" flag, since the first descriptor m=
ust have its flag set last (per previous section). More correct to say: "in=
 ring order"?

>=20
> The device MAY limit the number of buffers it will allow in a list.
>=20
> \drivernormative{\paragraph}{Indirect Descriptors}{Basic Facilities of a =
Virtio
> Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descripto=
rs} The
> driver MUST NOT set the DESC_F_INDIRECT flag unless the
> VIRTIO_F_INDIRECT_DESC feature was negotiated.   The driver MUST NOT
> set any flags except DESC_F_WRITE within an indirect descriptor.
>=20
> A driver MUST NOT create a descriptor chain longer than allowed by the de=
vice.
>=20
> A driver MUST NOT write direct descriptors with DESC_F_INDIRECT set in a
> scatter-gather list linked by VIRTQ_DESC_F_NEXT.
> \field{flags}.
>=20

[#lga#] Is batch-used possible for an indirect buffer, by setting the WRITE=
 flag and length in the used ring descriptor? That way the device does not =
have to write to the indirect descriptors at all (and the driver not read t=
hem). If the WRITE-flag in the used ring descriptor is not set, and the ind=
irect descriptor list contains device-writable elements, then the device mu=
st update the indirect descriptors and the driver must read them. Can a dev=
ice do batch-used within an indirect descriptor-list?

>=20
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

