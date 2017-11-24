Return-Path: virtio-dev-return-2707-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 60E185818D8A
	for <virtio-dev@lists.oasis-open.org>; Fri, 24 Nov 2017 02:00:44 -0800 (PST)
From: "Dhanoa, Kully" <kully.dhanoa@intel.com>
Date: Fri, 24 Nov 2017 10:00:39 +0000
Message-ID: <4DCA102C9749C849A7B61D9934ED625207A1A961@fmsmsx122.amr.corp.intel.com>
References: <20171108141659-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171108141659-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: RE: [virtio-dev] [PATCH RFC] packed ring layout spec v5
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

I've embedded my original comments in the text below for archiving purposes.

Michael, =

I could not find your responses to my comments in the document.

If you could provide them, it would help me to understand the proposal bett=
er.

Thanks
Kully

-----Original Message-----
From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-open.o=
rg] On Behalf Of Michael S. Tsirkin
Sent: Wednesday, November 22, 2017 2:56 PM
To: virtio-dev@lists.oasis-open.org
Subject: [virtio-dev] [PATCH RFC] packed ring layout spec v5

No functional changes since v4. Added some clarifications in response to qu=
estions by Kully.

This is reasonably complete functionally, from spec point of view we need
- more conformance statements
- pseudo-code
- discussion of memory barriers
- rearrange existing (1.0) layout discussion to make it fit
  in a single chapter

Kully, you sent a PDF with what looks like more feature suggestions.  For e=
xample, a suggestion to use a separate memory location for used entries - w=
hich as was suggested is also helpful for RDMA.

Please post them to list in text format, for now I would like to know wheth=
er we can agree on the below and add more features on top gated by a featur=
e bit.

----


\section{Packed Virtqueues}\label{sec:Basic Facilities of a Virtio Device /=
 Packed Virtqueues}

Packed virtqueues is an alternative compact virtqueue layout using read-wri=
te memory, that is memory that is both read and written by both host and gu=
est.

Packed virtqueues support up to $2^14$ queues, with up to $2^15$ entries ea=
ch.

With current transports, queues are located in guest memory allocated by dr=
iver.
Each packed virtqueue consists of three parts:

\begin{itemize}
\item Descriptor Ring
\item Device Event Suppression
\item Driver Event Suppression
\end{itemize}

Where Descriptor Ring in turn consists of descriptors, and where each descr=
iptor can contain the following parts:

\begin{itemize}
\item Buffer ID
\item Buffer Address
\item Buffer Length
\item Flags
\end{itemize}

A buffer consists of zero or more device-readable physically-contiguous ele=
ments followed by zero or more physically-contiguous device-writable elemen=
ts (each buffer has at least one element).

When the driver wants to send such a buffer to the device, it writes at lea=
st one available descriptor describing elements of the buffer into the Desc=
riptor Ring.  The descriptor(s) are associated with a buffer by means of a =
Buffer ID stored within the descriptor.

Driver then notifies the device. When the device has finished processing th=
e buffer, it writes a used device descriptor including the Buffer ID into t=
he Descriptor Ring (overwriting a driver descriptor previously made availab=
le), and sends an interrupt.

Descriptor Ring is used in a circular manner: driver writes descriptors int=
o the ring in order. After reaching end of ring, the next descriptor is pla=
ced at head of the ring.  Once ring is full of driver descriptors, driver s=
tops sending new requests and waits for device to start processing descript=
ors and to write out some used descriptors before making new driver descrip=
tors available.

Similarly, device reads descriptors from the ring in order and detects that=
 a driver descriptor has been made available.  As processing of descriptors=
 is completed used descriptors are written by the device back into the ring.

Note: after reading driver descriptors and starting their processing in ord=
er, device might complete their processing out of order.  Used device descr=
iptors are written in the order in which their processing is complete.

Device Event Suppression data structure is read-only by the device. It incl=
udes information for reducing the number of device events - i.e. interrupts=
 to driver.

[KSD] Where is this structure located? VM memory OR device memory? I presum=
e VM memory but text should explicitly say so.

Driver Event Suppression data structure is write-only by the device. It inc=
ludes information for reducing the number of driver events - i.e. notificat=
ions to device.

[KSD] Similarly, where is this structure located? VM memory OR device memor=
y? I presume VM memory but text should explicitly say so.


\subsection{Available and Used Ring Full Counters} \label{sec:Packed Virtqu=
eues / Available and Used Ring Wrap Counters} Each of the driver and the de=
vice are expected to maintain, internally, a single-bit ring wrap counter i=
nitialized to 1.

The counter maintained by the driver is called the Available Ring Full Coun=
ter. Driver changes its value each time it makes available the last descrip=
tor in the ring (after making the last descriptor available).

The counter maintained by the device is called the Used Ring Wrap Counter. =
 Device changes its value each time it uses the last descriptor in the ring=
 (after marking the last descriptor used).

It is easy to see that the Availablering Wrap Counter in the driver matches=
 the Used Ring Wrap Counter in the device when both are processing the same=
 descriptor, or when all available descriptors have been used.

To mark a descriptor as available and used, both driver and device use the =
following two flags:
\begin{lstlisting}
#define VIRTQ_DESC_F_AVAIL     7
#define VIRTQ_DESC_F_USED      15
\end{lstlisting}

To mark a descriptor as available, driver sets the VIRTQ_DESC_F_AVAIL bit i=
n Flags to match the internal Available Ring Wrap Counter.  It also sets th=
e VIRTQ_DESC_F_USED bit to match the \emph{inverse} value.

To mark a descriptor as used, device sets the VIRTQ_DESC_F_USED bit in Flag=
s to match the internal Used Ring Wrap Counter.  It also sets the VIRTQ_DES=
C_F_AVAIL bit to match the \emph{same} value.

Thus VIRTQ_DESC_F_AVAIL and VIRTQ_DESC_F_USED bits are different for an ava=
ilable descriptor and equal for a used descriptor.

\subsection{Polling of available and used descriptors} \label{sec:Packed Vi=
rtqueues / Polling of available and used descriptors}

Writes of device and driver descriptors can generally be reordered, but eac=
h side (driver and device) are only required to poll a single location in m=
emory: next device descriptor after the one they processed previously, in c=
ircular order.

[KSD] I think it would be highly unlikely that H/w would poll descriptors. =
It would rely on ring notification method so would only read descriptors th=
at it knows are valid. I would suggest adding text here to say that as well=
 as polling the device can use another method (ring notification) to determ=
ine if there are valid descriptors available.

Sometimes device needs to only write out a single used descriptor after pro=
cessing a batch of multiple available descriptors.  As described in more de=
tail below, this can happen when using descriptor chaining or with in-order=
 use of descriptors.  In this case, device writes out a used descriptor wit=
h buffer id of the last descriptor in the group.
After processing the used descriptor, both device and driver then skip forw=
ard in the ring the number of the remaining descriptors in the group until =
processing (reading for the driver and writing for the device) the next use=
d descriptor.

[KSD] I suggest saying that a used Descriptor is written back to the same l=
ocation it was read from the Descriptor Table (assuming in-order processing=
). However, not all used Descriptors need be written back:
           - a packet comprising a batch of descriptors would only have the=
 first descriptor of the batch written to.
           - s/w may indicate that a descriptor does not need to be written=
 back after use (to reduce amount of writes to Descriptor Table by device).
          Although I like the general mechanism of only writing back certai=
n descriptors, it creates a problem that if s/w is looking for a specific d=
escriptor to be used but for some reason the device did not write it back, =
the whole system would just hang...... case for separate completion queue/u=
sed table.
          Is this a scenario that we should consider? Or do we say it's a b=
ug and should never occur in a properly functioning system?

\subsection{Write Flag}
\label{sec:Packed Virtqueues / Write Flag}

In an available descriptor, VIRTQ_DESC_F_WRITE bit within Flags is used to =
mark a descriptor as corresponding to a write-only or read-only element of =
a buffer.

\begin{lstlisting}
/* This marks a buffer as device write-only (otherwise device read-only). */
#define VIRTQ_DESC_F_WRITE     2
\end{lstlisting}

In a used descriptor, this bit it used to specify whether any data has been=
 written by the device into any parts of the buffer.


\subsection{Buffer Address and Length}
\label{sec:Packed Virtqueues / Buffer Address and Length}

In an available descriptor, Buffer Address corresponds to the physical addr=
ess of the buffer. The length of the buffer assumed to be physically contig=
ious is stored in Buffer Length.

In a used descriptor, Buffer Address is unused. Buffer Length specifies the=
 length of the buffer that has been initialized (written to) by the device.

Buffer length is reserved for used descriptors without the VIRTQ_DESC_F_WRI=
TE flag, and is ignored by drivers.

\subsection{Scatter-Gather Support}
\label{sec:Packed Virtqueues / Scatter-Gather Support}

Some drivers need an ability to supply a list of multiple buffer elements (=
also known as a scatter/gather list) with a request.
Two optional features support this: descriptor chaining and indirect descri=
ptors.

[KSD] Is descriptor chaining really an optional feature? Good idea if it is=
. I presume this is a change from 1.0 as there it seems to be mandatory (is=
 my understanding correct?)

If neither feature has been negotiated, each buffer is physically-contigiou=
s, either read-only or write-only and is described completely by a single d=
escriptor.

While unusual (most implementations either create all lists solely using no=
n-indirect descriptors, or always use a single indirect element), if both f=
eatures have been negotiated, mixing direct and direct descriptors in a rin=
g is valid, as long as each list only contains descriptors of a given type.

Scatter/gather lists only apply to available descriptors. A single used des=
criptor corresponds to the whole list.

The device limits the number of descriptors in a list through a bus-specifi=
c and/or device-specific value. If not limited, the maximum number of descr=
iptors in a list is the virt queue size.

\subsection{Next Flag: Descriptor Chaining} \label{sec:Packed Virtqueues / =
Next Flag: Descriptor Chaining}

The VIRTIO_F_LIST_DESC feature allows driver to do this by using multiple d=
escriptors, and setting the VIRTQ_DESC_F_NEXT in Flags for all but the last=
 available descriptor.

\begin{lstlisting}
/* This marks a buffer as continuing. */
#define VIRTQ_DESC_F_NEXT   1
\end{lstlisting}

Buffer ID is included in the last descriptor in the list.  =


The driver always makes the the first descriptor in the list available afte=
r the rest of the list has been written out into the ring. This guarantees =
that the device will never observe a partial scatter/gather list in the rin=
g.

Device only writes out a single used descriptor for the whole list. It then=
 skips forward according to the number of descriptors in the list. Driver n=
eeds to keep track of the size of the list corresponding to each buffer ID,=
 to be able to skip to where the next used descriptor is written by the dev=
ice.

For example, if descriptors are used in the same order in which they are ma=
de available, this will result in the used descriptor overwriting the first=
 available descriptor in the list, the used descriptor for the next list ov=
erwriting the first available descriptor in the next list, etc.

VIRTQ_DESC_F_NEXT is reserved in used descriptors, and should be ignored by=
 drivers.

\subsection{Indirect Flag: Scatter-Gather Support} \label{sec:Packed Virtqu=
eues / Indirect Flag: Scatter-Gather Support}

Some devices benefit by concurrently dispatching a large number of large re=
quests. The VIRTIO_F_INDIRECT_DESC feature allows this. To increase ring ca=
pacity the driver can store  (read-only by the device) table of indirect de=
scriptors anywhere in memory, and insert a descriptor in main virtqueue (wi=
th \field{Flags}\&VIRTQ_DESC_F_INDIRECT on) that refers to a memory buffer =
containing this indirect descriptor table; \field{addr} and \field{len} ref=
er to the indirect table address and length in bytes, respectively.
\begin{lstlisting}
/* This means the buffer contains a table of buffer descriptors. */
#define VIRTQ_DESC_F_INDIRECT   4
\end{lstlisting}

The indirect table layout structure looks like this (\field{len} is the Buf=
fer Length of the descriptor that refers to this table, which is a variable=
, so this code won't compile):

\begin{lstlisting}
struct indirect_descriptor_table {
        /* The actual descriptor structures (struct Desc each) */
        struct Desc desc[len / sizeof(struct Desc)]; }; \end{lstlisting}

The first descriptor is located at start of the indirect descriptor table, =
additional indirect descriptors come immediately afterwards. \field{Flags} =
\&VIRTQ_DESC_F_WRITE is the only valid flag for descriptors in the indirect=
 table. Others are reserved are ignored by the device. =

Buffer ID is also reserved and is ignored by the device.

In Descriptors with VIRTQ_DESC_F_INDIRECT set VIRTQ_DESC_F_WRITE is reserve=
d and is ignored by the device.

\subsection{In-order use of descriptors} \label{sec:Packed Virtqueues / In-=
order use of descriptors}

Some devices always use descriptors in the same order in which they have be=
en made available. These devices can offer the VIRTIO_F_IN_ORDER feature. I=
f negotiated, this knowledge allows devices to notify the use of a batch of=
 buffers to the driver by only writing out a single used descriptor with th=
e Buffer ID corresponding to the last descriptor in the batch.

Device then skips forward in the ring according to the size of the the batc=
h. Driver needs to look up the used Buffer ID and calculate the batch size =
to be able to advance to where the next used descriptor will be written by =
the device.

This will result in the used descriptor overwriting the first available des=
criptor in the batch, the used descriptor for the next batch overwriting th=
e first available descriptor in the next batch, etc.

The skipped buffers (for which no used descriptor was written) are assumed =
to have been used (read or written) by the device completely.

\subsection{Multi-buffer requests}
\label{sec:Packed Virtqueues / Multi-descriptor batches} Some devices combi=
ne multiple buffers as part of processing a single request.  These devices =
always makes the the first descriptor in the request available after the re=
st of the request has been written out request the ring. This guarantees th=
at the driver will never observe a partial request in the ring.


\subsection{Driver and Device Event Suppression} \label{sec:Packed Virtqueu=
es / Driver and Device Event Suppression} In many systems driver and device=
 notifications involve significant overhead. To mitigate this overhead, eac=
h virtqueue includes two identical structures used for controlling notifica=
tions between device and driver.

Driver Event Suppression structure is read-only by the device and controls =
the events sent by the device (e.g. interrupts).

Device Event Suppression structure is read-only by the driver and controls =
the events sent by the driver (e.g. IO).


Each of these Event Suppression structures controls both Descriptor Ring ev=
ents and structure events, and each includes the following fields:

\begin{description}
\item [Descriptor Ring Change Event Flags] Takes values:
\begin{itemize}
\item 00b reserved
\item 01b enable events
\item 11b disable events
\item 10b enable events for a specific descriptor (as specified by Descript=
or Ring Change Event Offset/Wrap Counter).
\end{itemize}

[KSD] Are these flags in each descriptor OR in the global (per VM) Driver E=
vent Suppression structure?

\item [Descriptor Ring Change Event Offset] If Event Flags set to descripto=
r specific event: offset within the ring (in units of descriptor size). Eve=
nt will only trigger when this descriptor is made available/used respective=
ly.

[KSD] As well as this offset value, I thought we had discussed in the past =
of  having a flag in each descriptor to indicate to the device to generate =
an interrupt and also a flag to indicate whether the device must write back=
 the used descriptor to the Descriptor Table (flags would be set by VM gues=
t driver)? Are we not supporting this?

\item [Descriptor Ring Change Event Wrap Counter]If Event Flags set to desc=
riptor specific event: offset within the ring (in units of descriptor size)=
. Event will only trigger when Ring Wrap Counter matches this value and a d=
escriptor is made available/used respectively.
\end{description}

[KSD] What's the point of this, if we can individually control which descri=
ptors should trigger events (i.e. interrupts; descriptor writebacks)

After writing out some descriptors, both device and driver are expected to =
consult the relevant structure to find out whether interrupt should be sent=
. As this access to shared memory involves overhead for some transports, th=
e following additional field is present:

\begin{description}
\item [Structure Change Event Flags] Enable/disable sending an event notifi=
cation when the other side changes its own Event Suppression structure.
\end{description}

when enabled through this field, device and driver send an event notificati=
on whenever they change the driver and device event suppression structure r=
espectively.


\subsubsection{Driver notifications}

[KSD] Is this notification structure located in the device memory? i.e. gue=
st VM driver sends notification, it writes to a register in device memory? =
This is important for h/w implementation.

\label{sec:Packed Virtqueues / Driver notifications} Whenever not suppresse=
d by Device Event Suppression, driver is required to notify the device afte=
r making changes to the virtqueue.

Some devices benefit from ability to find out the number of available descr=
iptors in the ring, and whether to send interrupts to drivers without acces=
sing virtqueue in memory:
for efficiency or as a debugging aid.

To help with these optimizations, driver notifications to the device includ=
e the following information:

\begin{itemize}
\item VQ number
\item Flags - set to 00b
\item Offset (in units of descriptor size) within the ring
      where the next available descriptor will be written \item Available R=
ing Wrap Counter \end{itemize}

Whenever driver notifies device about a Device Event Suppression Structure =
change (if enabled through Structure Change Event Flags in Driver Event Sup=
pression Structure), it sends a copy of the up-to-date Event Suppression St=
ructure:

\begin{itemize}
\item VQ number
\item Descriptor Event Flags
\item Descriptor Event Offset
\item Descriptor Event Wrap Counter
\end{itemize}


\subsubsection{Structure Size and Alignment} \label{sec:Packed Virtqueues /=
 Structure Size and Alignment}

Each part of the virtqueue is physically-contiguous in guest memory, and ha=
s different alignment requirements.

The memory aligment and size requirements, in bytes, of each part of the vi=
rtqueue are summarized in the following table:

\begin{tabular}{|l|l|l|}
\hline
Virtqueue Part    & Alignment & Size \\
\hline \hline
Descriptor Ring  & 16        & $16 * $(Queue Size) \\
\hline
Device Event Suppression    & 4         & 4 \\
 \hline
Driver Event Suppression         & 4         & 4 \\
 \hline
\end{tabular}

[KSD]  Why not start Descriptor Table on a 4K page boundary? =

[KSD]  Device Event and Driver Event Suppression structures: It would be ea=
sier to have them cache line aligned (i.e. 64B aligned as opposed to 4B). W=
ould it not be sensible to define their size as a cache line (with remainin=
g 60B as reserved)?

The Alignment column gives the minimum alignment for each part of the virtq=
ueue.

The Size column gives the total number of bytes for each part of the virtqu=
eue.

Queue Size corresponds to the maximum number of descriptors in the virtqueu=
e\footnote{For example, if Queue Size is 4 then at most 4 buffers can be qu=
eued at any given time.}.  Queue Size value does not have to be a power of =
2 unless enforced by the transport.

\drivernormative{\subsection}{Virtqueues}{Basic Facilities of a Virtio Devi=
ce / Packed Virtqueues} The driver MUST ensure that the physical address of=
 the first byte of each virtqueue part is a multiple of the specified align=
ment value in the above table.

\devicenormative{\subsection}{Virtqueues}{Basic Facilities of a Virtio Devi=
ce / Packed Virtqueues} The device MUST start processing driver descriptors=
 in the order in which they appear in the ring.
The device MUST start writing device descriptors into the ring in the order=
 in which they complete.
Device MAY reorder descriptor writes once they are started.

\subsection{The Virtqueue Descriptor Format}\label{sec:Basic Facilities of =
a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Format}

The available descriptor refers to the buffers the driver is sending to the=
 device. \field{addr} is a physical address, and the descriptor is identifi=
ed with a buffer using the \field{id} field.

\begin{lstlisting}
struct virtq_desc {
        /* Buffer Address. */
        le64 addr;
        /* Buffer Length. */
        le32 len;
        /* Buffer ID. */
        le16 id;
        /* The flags depending on descriptor type. */
        le16 flags;
};
\end{lstlisting}

The descriptor ring is zero-initialized.

\subsection{Event Suppression Structure Format}\label{sec:Basic Facilities =
of a Virtio Device / Packed Virtqueues / Event Suppression Structure Format}

The following structure is used to reduce the number of notifications sent =
between driver and device.

\begin{lstlisting}
__le16 desc_event_off : 15; /* Descriptor Event Offset */
int    desc_event_wrap : 1; /* Descriptor Event Wrap Counter */
__le16 desc_event_flags : 2; /* Descriptor Event Flags */
__le16 structure_change_flags : 1; /* Structure Change Event Flags */ \end{=
lstlisting}

\subsection{Driver Notification Format}\label{sec:Basic Facilities of a Vir=
tio Device / Packed Virtqueues / Driver Notification Format}

The following structure is used to notify device of available descriptors a=
nd of event suppression structure changes:

\begin{lstlisting}
__le16 vqn : 14;
__le16 desc_event_flags : 2;
__le16 desc_event_off : 15;
int    desc_event_wrap : 1;
\end{lstlisting}

\devicenormative{\subsubsection}{The Virtqueue Descriptor Table}{Basic Faci=
lities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table} A =
device MUST NOT write to a device-readable buffer, and a device SHOULD NOT =
read a device-writable buffer.
A device MUST NOT use a descriptor unless it observes VIRTQ_DESC_F_AVAIL bi=
t in its \field{flags} being changed.
A device MUST NOT change a descriptor after changing it's VIRTQ_DESC_F_USED=
 bit in its \field{flags}.

\drivernormative{\subsubsection}{The Virtqueue Descriptor Table}{Basic Faci=
lities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table} A =
driver MUST NOT change a descriptor unless it observes VIRTQ_DESC_F_USED bi=
t in its \field{flags} being changed.
A driver MUST NOT change a descriptor after changing VIRTQ_DESC_F_USED bit =
in its \field{flags}.

\drivernormative{\paragraph}{Scatter-Gather Support}{Basic Facilities of a =
Virtio Device / Packed Virtqueues / Scatter-Gather Support} The driver MUST=
 NOT set the DESC_F_LIST_NEXT flag unless the VIRTIO_F_LIST_DESC feature wa=
s negotiated.

A driver MUST NOT create a descriptor list longer than allowed by the devic=
e.

A driver MUST NOT create a descriptor list longer than the Queue Size.

This implies that loops in the descriptor list are forbidden!

The driver MUST place any device-writable descriptor elements after any dev=
ice-readable descriptor elements.

A driver MUST NOT depend on the device to use more descriptors to be able t=
o write out all descriptors in a list. A driver MUST make sure there's enou=
gh space in the ring for the whole list before making any of the descriptor=
s available to the device.

A driver MUST NOT make the first descriptor in the list available before in=
itializing the rest of the descriptors.

\devicenormative{\paragraph}{Scatter-Gather Support}{Basic Facilities of a =
Virtio Device / Packed Virtqueues / Scatter-Gather Support} The device MUST=
 use descriptors in a list chained by the VIRTQ_DESC_F_NEXT flag in the sam=
e order that they were made available by the driver.

The device MAY limit the number of buffers it will allow in a list.

\drivernormative{\paragraph}{Indirect Descriptors}{Basic Facilities of a Vi=
rtio Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descri=
ptors} The driver MUST NOT set the DESC_F_INDIRECT flag unless the
VIRTIO_F_INDIRECT_DESC feature was negotiated.   The driver MUST NOT
set any flags except DESC_F_WRITE within an indirect descriptor.

A driver MUST NOT create a descriptor chain longer than allowed by the devi=
ce.

A driver MUST NOT write direct descriptors with DESC_F_INDIRECT set in a sc=
atter-gather list linked by VIRTQ_DESC_F_NEXT.
\field{flags}.






---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

