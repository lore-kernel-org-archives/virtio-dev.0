Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <eaf88f9c-8b51-7758-90c0-c1a92df35061@nvidia.com>
Date: Thu, 13 Jan 2022 19:07:53 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-3-mgurtovoy@nvidia.com>
 <20220113102218-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220113102218-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 1/13/2022 5:33 PM, Michael S. Tsirkin wrote:
> On Thu, Jan 13, 2022 at 04:51:00PM +0200, Max Gurtovoy wrote:
>> These new features are parallel to VIRTIO_F_INDIRECT_DESC and
>> VIRTIO_F_IN_ORDER. Some devices might support these features only for
>> admin virtqueues and some might support them for both admin virtqueues
>> and request virtqueues or only for non-admin virtqueues. Some
>> optimization can be made for each type of virtqueue, thus we separate
>> these features for the different virtqueue types.
>>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> That seems vague as motivation.
> Why do we need to optimize admin queues? Aren't they
> fundamentally a control path feature?
> Why would we want to special-case these features specifically?
> Should we allow control of features per VQ generally?

We would like to allow executing admins commands out of order and IO 
requests in order for efficiency.

And also the other way around.

IO cmds and admin cmds have different considerations in many cases.

>
>
>> ---
>>   content.tex     | 47 +++++++++++++++++++++++++++++++++++++++--------
>>   packed-ring.tex | 26 +++++++++++++-------------
>>   split-ring.tex  | 35 +++++++++++++++++++++++------------
>>   3 files changed, 75 insertions(+), 33 deletions(-)
>>
>> diff --git a/content.tex b/content.tex
>> index c524fab..cc3e648 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>>   \begin{description}
>>   \item[0 to 23] Feature bits for the specific device type
>>   
>> -\item[24 to 41] Feature bits reserved for extensions to the queue and
>> +\item[24 to 43] Feature bits reserved for extensions to the queue and
>>     feature negotiation mechanisms
>>   
>> -\item[42 and above] Feature bits reserved for future extensions.
>> +\item[44 and above] Feature bits reserved for future extensions.
>>   \end{description}
>>   
>>   \begin{note}
>> @@ -318,8 +318,9 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
>>   
>>   Some devices always use descriptors in the same order in which
>>   they have been made available. These devices can offer the
>> -VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge
>> -might allow optimizations or simplify driver and/or device code.
>> +VIRTIO_F_IN_ORDER and/or VIRTIO_F_ADMIN_VQ_IN_ORDER features.
>> +If negotiated, this knowledge might allow optimizations or
>> +simplify driver and/or device code.
>>   
>>   Each virtqueue can consist of up to 3 parts:
>>   \begin{itemize}
>> @@ -6768,7 +6769,7 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>   Device / Virtqueues / The Virtqueue Descriptor Table / Indirect
>>   Descriptors}~\nameref{sec:Basic Facilities of a Virtio Device /
>>   Virtqueues / The Virtqueue Descriptor Table / Indirect
>> -Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Support}~\nameref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Support}.
>> +Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Support}~\nameref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Support}. This excluding the descriptors sent via the admin virtqueue.
>>     \item[VIRTIO_F_EVENT_IDX(29)] This feature enables the \field{used_event}
>>     and the \field{avail_event} fields as described in
>>   \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}, \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Used Ring} and \ref{sec:Packed Virtqueues / Driver and Device Event Suppression}.
>> @@ -6800,8 +6801,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>     support for the packed virtqueue layout as described in
>>     \ref{sec:Basic Facilities of a Virtio Device / Packed Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Packed Virtqueues}.
>>     \item[VIRTIO_F_IN_ORDER(35)] This feature indicates
>> -  that all buffers are used by the device in the same
>> -  order in which they have been made available.
>> +  that all buffers are used by the device, excluding buffers used by
>> +  the admin virtqueue, in the same order in which they have been made
>> +  available.
>>     \item[VIRTIO_F_ORDER_PLATFORM(36)] This feature indicates
>>     that memory accesses by the driver and the device are ordered
>>     in a way described by the platform.
>> @@ -6852,6 +6854,18 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>     \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that
>>     the device supports administration virtqueue negotiation.
>>   
>> +  \item[VIRTIO_F_ADMIN_VQ_INDIRECT_DESC (42)] Negotiating this feature
>> +  indicates that the driver can use descriptors with the VIRTQ_DESC_F_INDIRECT
>> +  flag set, as described in \ref{sec:Basic Facilities of a Virtio
>> +Device / Virtqueues / The Virtqueue Descriptor Table / Indirect
>> +Descriptors}~\nameref{sec:Basic Facilities of a Virtio Device /
>> +Virtqueues / The Virtqueue Descriptor Table / Indirect
>> +Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Support}~\nameref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Support}. This refers to descriptors sent via the admin
>> +  virtqueue and excluding the descriptors that sent via other virtqueues.
>> +  \item[VIRTIO_F_ADMIN_VQ_IN_ORDER (43)] This feature indicates
>> +  that all buffers are used by the admin virtqueue of the device in
>> +  the same order in which they have been made available.
>> +
>>   \end{description}
>>   
>>   \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
>> @@ -6888,6 +6902,12 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>   
>>   A driver SHOULD accept VIRTIO_F_NOTIF_CONFIG_DATA if it is offered.
>>   
>> +A driver MAY accept VIRTIO_F_ADMIN_VQ_INDIRECT_DESC only if it accepts
>> +VIRTIO_F_ADMIN_VQ.
>> +
>> +A driver MAY accept VIRTIO_F_ADMIN_VQ_IN_ORDER only if it accepts
>> +VIRTIO_F_ADMIN_VQ.
>> +
>>   \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
>>   
>>   A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
>> @@ -6902,7 +6922,12 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>   accepted.
>>   
>>   If VIRTIO_F_IN_ORDER has been negotiated, a device MUST use
>> -buffers in the same order in which they have been available.
>> +buffers in the same order in which they have been available. This refers
>> +to buffers that are used by virtqueue that is not the admin virtqueue.
>> +
>> +If VIRTIO_F_ADMIN_VQ_IN_ORDER has been negotiated, a device MUST use
>> +buffers in the same order in which they have been available. This refers
>> +only for buffers that are used by the admin virtqueue.
>>   
>>   A device MAY fail to operate further if
>>   VIRTIO_F_ORDER_PLATFORM is offered but not accepted.
>> @@ -6917,6 +6942,12 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>   and presents a PCI SR-IOV capability structure, otherwise
>>   it MUST NOT offer VIRTIO_F_SR_IOV.
>>   
>> +A device MAY offer VIRTIO_F_ADMIN_VQ_INDIRECT_DESC only if it offers
>> +VIRTIO_F_ADMIN_VQ.
>> +
>> +A device MAY offer VIRTIO_F_ADMIN_VQ_IN_ORDER only if it offers
>> +VIRTIO_F_ADMIN_VQ.
>> +
>>   \section{Legacy Interface: Reserved Feature Bits}\label{sec:Reserved Feature Bits / Legacy Interface: Reserved Feature Bits}
>>   
>>   Transitional devices MAY offer the following:
>> diff --git a/packed-ring.tex b/packed-ring.tex
>> index a9e6c16..ef1dbc2 100644
>> --- a/packed-ring.tex
>> +++ b/packed-ring.tex
>> @@ -240,13 +240,12 @@ \subsection{Indirect Flag: Scatter-Gather Support}
>>   \label{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Support}
>>   
>>   Some devices benefit by concurrently dispatching a large number
>> -of large requests. The VIRTIO_F_INDIRECT_DESC feature allows this. To increase
>> -ring capacity the driver can store a (read-only by the device) table of indirect
>> -descriptors anywhere in memory, and insert a descriptor in the main
>> -virtqueue (with \field{Flags} bit VIRTQ_DESC_F_INDIRECT on) that refers to
>> -a buffer element
>> -containing this indirect descriptor table; \field{addr} and \field{len}
>> -refer to the indirect table address and length in bytes,
>> +of large requests. The VIRTIO_F_INDIRECT_DESC and VIRTIO_F_ADMIN_VQ_INDIRECT_DESC
>> +features allows this. To increase ring capacity the driver can store a (read-only
>> +by the device) table of indirect descriptors anywhere in memory, and insert a
>> +descriptor in the main virtqueue (with \field{Flags} bit VIRTQ_DESC_F_INDIRECT on)
>> +that refers to a buffer element containing this indirect descriptor table;
>> +\field{addr} and \field{len} refer to the indirect table address and length in bytes,
>>   respectively.
>>   \begin{lstlisting}
>>   /* This means the element contains a table of descriptors. */
>> @@ -279,10 +278,11 @@ \subsection{In-order use of descriptors}
>>   
>>   Some devices always use descriptors in the same order in which
>>   they have been made available. These devices can offer the
>> -VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge allows
>> -devices to notify the use of a batch of buffers to the driver by
>> -only writing out a single used descriptor with the Buffer ID
>> -corresponding to the last descriptor in the batch.
>> +VIRTIO_F_IN_ORDER and/or VIRTIO_F_ADMIN_VQ_IN_ORDER features.
>> +If negotiated, this knowledge allows devices to notify the use of
>> +a batch of buffers to the driver by only writing out a single used
>> +descriptor with the Buffer ID corresponding to the last descriptor
>> +in the batch.
>>   
>>   The device then skips forward in the ring according to the size of
>>   the batch. The driver needs to look up the used Buffer ID and
>> @@ -500,8 +500,8 @@ \subsection{Event Suppression Structure Format}\label{sec:Basic
>>   
>>   \drivernormative{\subsection}{Indirect Descriptors}{Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}
>>   The driver MUST NOT set the DESC_F_INDIRECT flag unless the
>> -VIRTIO_F_INDIRECT_DESC feature was negotiated.   The driver MUST NOT
>> -set any flags except DESC_F_WRITE within an indirect descriptor.
>> +VIRTIO_F_INDIRECT_DESC or VIRTIO_F_ADMIN_VQ_INDIRECT_DESC features were negotiated.
>> +The driver MUST NOT set any flags except DESC_F_WRITE within an indirect descriptor.
>>   
>>   A driver MUST NOT create a descriptor chain longer than allowed
>>   by the device.
>> diff --git a/split-ring.tex b/split-ring.tex
>> index de94038..cd53840 100644
>> --- a/split-ring.tex
>> +++ b/split-ring.tex
>> @@ -208,6 +208,10 @@ \subsection{The Virtqueue Descriptor Table}\label{sec:Basic Facilities of a Virt
>>   descriptors in ring order: starting from offset 0 in the table,
>>   and wrapping around at the end of the table.
>>   
>> +If VIRTIO_F_ADMIN_VQ_IN_ORDER has been negotiated, driver uses
>> +descriptors in admin virtqueue ring order: starting from offset 0 in the
>> +table, and wrapping around at the end of the table.
>> +
>>   \begin{note}
>>   The legacy \hyperref[intro:Virtio PCI Draft]{[Virtio PCI Draft]}
>>   referred to this structure as vring_desc, and the constants as
>> @@ -223,16 +227,18 @@ \subsection{The Virtqueue Descriptor Table}\label{sec:Basic Facilities of a Virt
>>   Drivers MUST NOT add a descriptor chain longer than $2^{32}$ bytes in total;
>>   this implies that loops in the descriptor chain are forbidden!
>>   
>> -If VIRTIO_F_IN_ORDER has been negotiated, and when making a
>> -descriptor with VRING_DESC_F_NEXT set in \field{flags} at offset
>> -$x$ in the table available to the device, driver MUST set
>> +If VIRTIO_F_ADMIN_VQ_IN_ORDER and/or VIRTIO_F_IN_ORDER has been negotiated,
>> +and when making a descriptor with VRING_DESC_F_NEXT set in \field{flags} at
>> +offset $x$ in the table available to the device, driver MUST set
>>   \field{next} to $0$ for the last descriptor in the table
>>   (where $x = queue\_size - 1$) and to $x + 1$ for the rest of the descriptors.
>> +This refers to admin virtqueue descriptors and rest other virtqueues types descriptors respectively.
>>   
>>   \subsubsection{Indirect Descriptors}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}
>>   
>>   Some devices benefit by concurrently dispatching a large number
>> -of large requests. The VIRTIO_F_INDIRECT_DESC feature allows this (see \ref{sec:virtio-queue.h}~\nameref{sec:virtio-queue.h}). To increase
>> +of large requests. The VIRTIO_F_INDIRECT_DESC and VIRTIO_F_ADMIN_VQ_INDIRECT_DESC
>> +features allows this (see \ref{sec:virtio-queue.h}~\nameref{sec:virtio-queue.h}). To increase
>>   ring capacity the driver can store a table of indirect
>>   descriptors anywhere in memory, and insert a descriptor in main
>>   virtqueue (with \field{flags}\&VIRTQ_DESC_F_INDIRECT on) that refers to memory buffer
>> @@ -258,15 +264,19 @@ \subsubsection{Indirect Descriptors}\label{sec:Basic Facilities of a Virtio Devi
>>   A single indirect descriptor
>>   table can include both device-readable and device-writable descriptors.
>>   
>> -If VIRTIO_F_IN_ORDER has been negotiated, indirect descriptors
>> -use sequential indices, in-order: index 0 followed by index 1
>> +If VIRTIO_F_IN_ORDER has been negotiated, indirect descriptors,
>> +for non admin virtqueue, use sequential indices, in-order: index 0 followed
>> +by index 1 followed by index 2, etc.
>> +
>> +If VIRTIO_F_ADMIN_VQ_IN_ORDER has been negotiated, admin virtqueue indirect
>> +descriptors use sequential indices, in-order: index 0 followed by index 1
>>   followed by index 2, etc.
>>   
>>   \drivernormative{\paragraph}{Indirect Descriptors}{Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}
>>   The driver MUST NOT set the VIRTQ_DESC_F_INDIRECT flag unless the
>> -VIRTIO_F_INDIRECT_DESC feature was negotiated.   The driver MUST NOT
>> -set the VIRTQ_DESC_F_INDIRECT flag within an indirect descriptor (ie. only
>> -one table per descriptor).
>> +VIRTIO_F_INDIRECT_DESC and/or VIRTIO_F_ADMIN_VQ_INDIRECT_DESC features were negotiated.
>> +The driver MUST NOT set the VIRTQ_DESC_F_INDIRECT flag within an indirect
>> +descriptor (ie. only one table per descriptor).
>>   
>>   A driver MUST NOT create a descriptor chain longer than the Queue Size of
>>   the device.
>> @@ -274,9 +284,10 @@ \subsubsection{Indirect Descriptors}\label{sec:Basic Facilities of a Virtio Devi
>>   A driver MUST NOT set both VIRTQ_DESC_F_INDIRECT and VIRTQ_DESC_F_NEXT
>>   in \field{flags}.
>>   
>> -If VIRTIO_F_IN_ORDER has been negotiated, indirect descriptors
>> -MUST appear sequentially, with \field{next} taking the value
>> -of 1 for the 1st descriptor, 2 for the 2nd one, etc.
>> +If VIRTIO_F_ADMIN_VQ_IN_ORDER and/or VIRTIO_F_IN_ORDER has been negotiated,
>> +indirect descriptors MUST appear sequentially, with \field{next} taking the
>> +value of 1 for the 1st descriptor, 2 for the 2nd one, etc for admin virtqueue
>> +and rest other virtqueues types respectively.
>>   
>>   \devicenormative{\paragraph}{Indirect Descriptors}{Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}
>>   The device MUST ignore the write-only flag (\field{flags}\&VIRTQ_DESC_F_WRITE) in the descriptor that refers to an indirect table.
>> -- 
>> 2.21.0

