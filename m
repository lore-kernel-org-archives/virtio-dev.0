Return-Path: virtio-dev-return-3109-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Date: Tue, 30 Jan 2018 14:07:22 +0100
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20180130130722.aesgnvmh3fcikh7p@dhcp-192-241.str.redhat.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
 <1516665617-30748-8-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1516665617-30748-8-git-send-email-mst@redhat.com>
Subject: Re: [virtio-dev] [PATCH v7 08/11] packed virtqueues: more efficient
 virtqueue layout
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 23, 2018 at 02:01:07AM +0200, Michael S. Tsirkin wrote:
[...]
>+
>+With current transports, virtqueues are located in guest memory
>+allocated by driver.
>+Each packed virtqueue consists of three parts:
>+
>+\begin{itemize}
>+\item Descriptor Ring - occupies the Descriptor Area
>+\item Driver Event Suppression - occupies the Driver Area
>+\item Device Event Suppression - occupies the Device Area
>+\end{itemize}
>+
>+Where Descriptor Ring in turn consists of descriptors,
>+and where each descriptor can contain the following parts:
>+
>+\begin{itemize}
>+\item Buffer ID
>+\item Buffer Address
>+\item Buffer Length
>+\item Flags
>+\end{itemize}
>+
>+A buffer consists of zero or more device-readable physically-contiguous
>+elements followed by zero or more physically-contiguous
>+device-writable elements (each buffer has at least one element).
>+
>+When the driver wants to send such a buffer to the device, it
>+writes at least one available descriptor describing elements of
>+the buffer into the Descriptor Ring.  The descriptor(s) are
>+associated with a buffer by means of a Buffer ID stored within
>+the descriptor.
>+
>+Driver then notifies the device. When the device has finished
>+processing the buffer, it writes a used device descriptor
>+including the Buffer ID into the Descriptor Ring (overwriting a
>+driver descriptor previously made available), and sends an
>+interrupt.
>+
>+Descriptor Ring is used in a circular manner: driver writes
>+descriptors into the ring in order. After reaching end of ring,
>+the next descriptor is placed at head of the ring.  Once ring is
>+full of driver descriptors, driver stops sending new requests and
>+waits for device to start processing descriptors and to write out
>+some used descriptors before making new driver descriptors
>+available.
>+
>+Similarly, device reads descriptors from the ring in order and
>+detects that a driver descriptor has been made available.  As
>+processing of descriptors is completed used descriptors are
>+written by the device back into the ring.
>+
>+Note: after reading driver descriptors and starting their
>+processing in order, device might complete their processing out
>+of order.  Used device descriptors are written in the order
>+in which their processing is complete.
>+
>+Device Event Suppression data structure is write-only by the
>+device. It includes information for reducing the number of
>+device events - i.e. driver notifications to device.
>+
>+Driver Event Suppression data structure is read-only by the
>+device. It includes information for reducing the number of
>+driver events - i.e. device interrupts to driver.
>+
>+\subsection{Available and Used Ring Wrap Counters}
>+\label{sec:Packed Virtqueues / Available and Used Ring Wrap Counters}
>+Each of the driver and the device are expected to maintain,
>+internally, a single-bit ring wrap counter initialized to 1.
>+
>+The counter maintained by the driver is called the Available
>+Ring Wrap Counter. Driver changes the value of this counter
>+each time it makes available the
>+last descriptor in the ring (after making the last descriptor
>+available).
>+
>+The counter maintained by the device is called the Used Ring Wrap
>+Counter.  Device changes the value of this counter
>+each time it uses the last descriptor in
>+the ring (after marking the last descriptor used).
>+
>+It is easy to see that the Available Ring Wrap Counter in the driver matches
>+the Used Ring Wrap Counter in the device when both are processing the same
>+descriptor, or when all available descriptors have been used.
>+
>+To mark a descriptor as available and used, both driver and
>+device use the following two flags:
>+\begin{lstlisting}
>+#define VIRTQ_DESC_F_AVAIL     7
>+#define VIRTQ_DESC_F_USED      15
>+\end{lstlisting}
>+
>+To mark a descriptor as available, driver sets the
>+VIRTQ_DESC_F_AVAIL bit in Flags to match the internal Available
>+Ring Wrap Counter.  It also sets the VIRTQ_DESC_F_USED bit to match the
>+\emph{inverse} value.
>+
>+To mark a descriptor as used, device sets the
>+VIRTQ_DESC_F_USED bit in Flags to match the internal Used
>+Ring Wrap Counter.  It also sets the VIRTQ_DESC_F_AVAIL bit to match the
>+\emph{same} value.
>+
>+Thus VIRTQ_DESC_F_AVAIL and VIRTQ_DESC_F_USED bits are different
>+for an available descriptor and equal for a used descriptor.
>+
>+\subsection{Polling of available and used descriptors}
>+\label{sec:Packed Virtqueues / Polling of available and used descriptors}
>+
>+Writes of device and driver descriptors can generally be
>+reordered, but each side (driver and device) are only required to
>+poll (or test) a single location in memory: next device descriptor after
>+the one they processed previously, in circular order.
>+
>+Sometimes device needs to only write out a single used descriptor
>+after processing a batch of multiple available descriptors.  As
>+described in more detail below, this can happen when using
>+descriptor chaining or with in-order
>+use of descriptors.  In this case, device writes out a used
>+descriptor with buffer id of the last descriptor in the group.
>+After processing the used descriptor, both device and driver then
>+skip forward in the ring the number of the remaining descriptors
>+in the group until processing (reading for the driver and writing
>+for the device) the next used descriptor.
>+
>+\subsection{Write Flag}
>+\label{sec:Packed Virtqueues / Write Flag}
>+
>+In an available descriptor, VIRTQ_DESC_F_WRITE bit within Flags
>+is used to mark a descriptor as corresponding to a write-only or
>+read-only element of a buffer.
>+
>+\begin{lstlisting}
>+/* This marks a buffer as device write-only (otherwise device read-only). */
>+#define VIRTQ_DESC_F_WRITE     2
>+\end{lstlisting}
>+
>+In a used descriptor, this bit it used to specify whether any
>+data has been written by the device into any parts of the buffer.
>+
>+
>+\subsection{Buffer Address and Length}
>+\label{sec:Packed Virtqueues / Buffer Address and Length}
>+
>+In an available descriptor, Buffer Address corresponds to the
>+physical address of the buffer. The length of the buffer assumed
>+to be physically contigious is stored in Buffer Length.
>+
>+In a used descriptor, Buffer Address is unused. Buffer Length
>+specifies the length of the buffer that has been initialized
>+(written to) by the device.
>+
>+Buffer length is reserved for used descriptors without the
>+VIRTQ_DESC_F_WRITE flag, and is ignored by drivers.
>+
>+\subsection{Scatter-Gather Support}
>+\label{sec:Packed Virtqueues / Scatter-Gather Support}
>+
>+Some drivers need an ability to supply a list of multiple buffer
>+elements (also known as a scatter/gather list) with a request.
>+Two optional features support this: descriptor
>+chaining and indirect descriptors.
>+
>+If neither feature has been negotiated, each buffer is
>+physically-contigious, either read-only or write-only and is
>+described completely by a single descriptor.
>+
>+While unusual (most implementations either create all lists
>+solely using non-indirect descriptors, or always use a single
>+indirect element), if both features have been negotiated, mixing
>+direct and direct descriptors in a ring is valid, as long as each
>+list only contains descriptors of a given type.
>+
>+Scatter/gather lists only apply to available descriptors. A
>+single used descriptor corresponds to the whole list.
>+
>+The device limits the number of descriptors in a list through a
>+transport-specific and/or device-specific value. If not limited,
>+the maximum number of descriptors in a list is the virt queue
>+size.
>+
>+\subsection{Next Flag: Descriptor Chaining}
>+\label{sec:Packed Virtqueues / Next Flag: Descriptor Chaining}
>+
>+The VIRTIO_F_LIST_DESC feature allows driver to supply
>+a scatter/gather list to the device
>+by using multiple descriptors, and setting the VIRTQ_DESC_F_NEXT in
>+Flags for all but the last available descriptor.
>+
>+\begin{lstlisting}
>+/* This marks a buffer as continuing. */
>+#define VIRTQ_DESC_F_NEXT   1
>+\end{lstlisting}
>+
>+Buffer ID is included in the last descriptor in the list.
>+
>+The driver always makes the the first descriptor in the list
>+available after the rest of the list has been written out into
>+the ring. This guarantees that the device will never observe a
>+partial scatter/gather list in the ring.
>+
>+Device only writes out a single used descriptor for the whole
>+list. It then skips forward according to the number of
>+descriptors in the list. Driver needs to keep track of the size
>+of the list corresponding to each buffer ID, to be able to skip
>+to where the next used descriptor is written by the device.
>+
>+For example, if descriptors are used in the same order in which
>+they are made available, this will result in the used descriptor
>+overwriting the first available descriptor in the list, the used
>+descriptor for the next list overwriting the first available
>+descriptor in the next list, etc.
>+
>+VIRTQ_DESC_F_NEXT is reserved in used descriptors, and
>+should be ignored by drivers.
>+
>+\subsection{Indirect Flag: Scatter-Gather Support}
>+\label{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Support}
>+
>+Some devices benefit by concurrently dispatching a large number
>+of large requests. The VIRTIO_F_INDIRECT_DESC feature allows this. To increase
>+ring capacity the driver can store a (read-only by the device) table of indirect
>+descriptors anywhere in memory, and insert a descriptor in main
>+virtqueue (with \field{Flags} bit VIRTQ_DESC_F_INDIRECT on) that refers to
>+a memory buffer
>+containing this indirect descriptor table; \field{addr} and \field{len}
>+refer to the indirect table address and length in bytes,
>+respectively.
>+\begin{lstlisting}
>+/* This means the buffer contains a table of buffer descriptors. */
>+#define VIRTQ_DESC_F_INDIRECT   4
>+\end{lstlisting}
>+
>+The indirect table layout structure looks like this
>+(\field{len} is the Buffer Length of the descriptor that refers to this table,
>+which is a variable, so this code won't compile):

It is pseudo-code, so I'm not sure if this remark is necessary. 

>+
>+\begin{lstlisting}
>+struct indirect_descriptor_table {
>+        /* The actual descriptor structures (struct Desc each) */
>+        struct Desc desc[len / sizeof(struct Desc)];
>+};
>+\end{lstlisting}
>+
>+The first descriptor is located at start of the indirect
>+descriptor table, additional indirect descriptors come
>+immediately afterwards. \field{Flags} bit VIRTQ_DESC_F_WRITE is the
>+only valid flag for descriptors in the indirect table. Others
>+are reserved and are ignored by the device.
>+Buffer ID is also reserved and is ignored by the device.
>+
>+In Descriptors with VIRTQ_DESC_F_INDIRECT set VIRTQ_DESC_F_WRITE
>+is reserved and is ignored by the device.
>+
>+\subsection{Multi-buffer requests}
>+\label{sec:Packed Virtqueues / Multi-descriptor batches}
>+Some devices combine multiple buffers as part of processing of a
>+single request.  These devices always make the first
>+descriptor in the request available after the rest of the request

maybe I don't understand it correctly, but how about "mark the first
descriptor as used after the rest.."

>+has been written out request the ring. 

I can parse this sentence. Should probably be "written out to the
ring"?


regards,
Jens 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

