Return-Path: virtio-return-3013-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 14 Mar 2018 15:46:12 +0000
Message-Id: <20180314154618.13069-2-stefanha@redhat.com>
In-Reply-To: <20180314154618.13069-1-stefanha@redhat.com>
References: <20180314154618.13069-1-stefanha@redhat.com>
Subject: [virtio] [PATCH 1/7] packed-ring: add missing articles to sentences
To: virtio@lists.oasis-open.org
Cc: virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, Cornelia Huck <cohuck@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

There are several sentence structures used throughout the text where an
article is missing.  For example:

  ... allocated by driver.

or

  Driver then notifies the device.

Standards documents normally use complete sentences so this patch adds
the missing articles required before the noun ("driver"):

  ... allocated by the driver.

or

  The driver then notifies the device.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 packed-ring.tex | 90 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/packed-ring.tex b/packed-ring.tex
index 4b3d9d9..211a989 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -10,7 +10,7 @@ feature bit.
 Packed virtqueues support up to $2^{15}$ entries each.
 
 With current transports, virtqueues are located in guest memory
-allocated by driver.
+allocated by the driver.
 Each packed virtqueue consists of three parts:
 
 \begin{itemize}
@@ -19,7 +19,7 @@ Each packed virtqueue consists of three parts:
 \item Device Event Suppression - occupies the Device Area
 \end{itemize}
 
-Where Descriptor Ring in turn consists of descriptors,
+Where the Descriptor Ring in turn consists of descriptors,
 and where each descriptor can contain the following parts:
 
 \begin{itemize}
@@ -39,35 +39,35 @@ the buffer into the Descriptor Ring.  The descriptor(s) are
 associated with a buffer by means of a Buffer ID stored within
 the descriptor.
 
-Driver then notifies the device. When the device has finished
+The driver then notifies the device. When the device has finished
 processing the buffer, it writes a used device descriptor
 including the Buffer ID into the Descriptor Ring (overwriting a
 driver descriptor previously made available), and sends an
 interrupt.
 
-Descriptor Ring is used in a circular manner: driver writes
-descriptors into the ring in order. After reaching end of ring,
-the next descriptor is placed at head of the ring.  Once ring is
-full of driver descriptors, driver stops sending new requests and
-waits for device to start processing descriptors and to write out
+The Descriptor Ring is used in a circular manner: the driver writes
+descriptors into the ring in order. After reaching the end of the ring,
+the next descriptor is placed at the head of the ring.  Once the ring is
+full of driver descriptors, the driver stops sending new requests and
+waits for the device to start processing descriptors and to write out
 some used descriptors before making new driver descriptors
 available.
 
-Similarly, device reads descriptors from the ring in order and
+Similarly, the device reads descriptors from the ring in order and
 detects that a driver descriptor has been made available.  As
 processing of descriptors is completed used descriptors are
 written by the device back into the ring.
 
 Note: after reading driver descriptors and starting their
-processing in order, device might complete their processing out
+processing in order, the device might complete their processing out
 of order.  Used device descriptors are written in the order
 in which their processing is complete.
 
-Device Event Suppression data structure is write-only by the
+The Device Event Suppression data structure is write-only by the
 device. It includes information for reducing the number of
 device events - i.e. driver notifications to device.
 
-Driver Event Suppression data structure is read-only by the
+The Driver Event Suppression data structure is read-only by the
 device. It includes information for reducing the number of
 driver events - i.e. device interrupts to driver.
 
@@ -77,13 +77,13 @@ Each of the driver and the device are expected to maintain,
 internally, a single-bit ring wrap counter initialized to 1.
 
 The counter maintained by the driver is called the Driver
-Ring Wrap Counter. Driver changes the value of this counter
+Ring Wrap Counter. The driver changes the value of this counter
 each time it makes available the
 last descriptor in the ring (after making the last descriptor
 available).
 
 The counter maintained by the device is called the Device Ring Wrap
-Counter.  Device changes the value of this counter
+Counter.  The device changes the value of this counter
 each time it uses the last descriptor in
 the ring (after marking the last descriptor used).
 
@@ -91,20 +91,20 @@ It is easy to see that the Driver Ring Wrap Counter in the driver matches
 the Device Ring Wrap Counter in the device when both are processing the same
 descriptor, or when all available descriptors have been used.
 
-To mark a descriptor as available and used, both driver and
-device use the following two flags:
+To mark a descriptor as available and used, both the driver and
+the device use the following two flags:
 \begin{lstlisting}
 #define VIRTQ_DESC_F_AVAIL     (1 << 7)
 #define VIRTQ_DESC_F_USED      (1 << 15)
 \end{lstlisting}
 
-To mark a descriptor as available, driver sets the
+To mark a descriptor as available, the driver sets the
 VIRTQ_DESC_F_AVAIL bit in Flags to match the internal Driver
 Ring Wrap Counter.  It also sets the VIRTQ_DESC_F_USED bit to match the
 \emph{inverse} value (i.e. to not match the internal Driver Ring
 Wrap Counter).
 
-To mark a descriptor as used, device sets the
+To mark a descriptor as used, the device sets the
 VIRTQ_DESC_F_USED bit in Flags to match the internal Device
 Ring Wrap Counter.  It also sets the VIRTQ_DESC_F_AVAIL bit to match the
 \emph{same} value.
@@ -126,15 +126,15 @@ possible.
 
 Writes of device and driver descriptors can generally be
 reordered, but each side (driver and device) are only required to
-poll (or test) a single location in memory: next device descriptor after
+poll (or test) a single location in memory: the next device descriptor after
 the one they processed previously, in circular order.
 
-Sometimes device needs to only write out a single used descriptor
+Sometimes the device needs to only write out a single used descriptor
 after processing a batch of multiple available descriptors.  As
 described in more detail below, this can happen when using
 descriptor chaining or with in-order
-use of descriptors.  In this case, device writes out a used
-descriptor with buffer id of the last descriptor in the group.
+use of descriptors.  In this case, the device writes out a used
+descriptor with the buffer id of the last descriptor in the group.
 After processing the used descriptor, both device and driver then
 skip forward in the ring the number of the remaining descriptors
 in the group until processing (reading for the driver and writing
@@ -143,7 +143,7 @@ for the device) the next used descriptor.
 \subsection{Write Flag}
 \label{sec:Packed Virtqueues / Write Flag}
 
-In an available descriptor, VIRTQ_DESC_F_WRITE bit within Flags
+In an available descriptor, the VIRTQ_DESC_F_WRITE bit within Flags
 is used to mark a descriptor as corresponding to a write-only or
 read-only element of a buffer.
 
@@ -198,9 +198,9 @@ size.
 \subsection{Next Flag: Descriptor Chaining}
 \label{sec:Packed Virtqueues / Next Flag: Descriptor Chaining}
 
-The packed ring format allows driver to supply
+The packed ring format allows the driver to supply
 a scatter/gather list to the device
-by using multiple descriptors, and setting the VIRTQ_DESC_F_NEXT in
+by using multiple descriptors, and setting the VIRTQ_DESC_F_NEXT bit in
 Flags for all but the last available descriptor.
 
 \begin{lstlisting}
@@ -219,9 +219,9 @@ Note: all flags, including VIRTQ_DESC_F_AVAIL, VIRTQ_DESC_F_USED,
 VIRTQ_DESC_F_WRITE must be set/cleared correctly in all
 descriptors in the list, not just the first one.
 
-Device only writes out a single used descriptor for the whole
+The device only writes out a single used descriptor for the whole
 list. It then skips forward according to the number of
-descriptors in the list. Driver needs to keep track of the size
+descriptors in the list. The driver needs to keep track of the size
 of the list corresponding to each buffer ID, to be able to skip
 to where the next used descriptor is written by the device.
 
@@ -240,7 +240,7 @@ should be ignored by drivers.
 Some devices benefit by concurrently dispatching a large number
 of large requests. The VIRTIO_F_INDIRECT_DESC feature allows this. To increase
 ring capacity the driver can store a (read-only by the device) table of indirect
-descriptors anywhere in memory, and insert a descriptor in main
+descriptors anywhere in memory, and insert a descriptor in the main
 virtqueue (with \field{Flags} bit VIRTQ_DESC_F_INDIRECT on) that refers to
 a buffer element
 containing this indirect descriptor table; \field{addr} and \field{len}
@@ -262,9 +262,9 @@ struct pvirtq_indirect_descriptor_table {
 };
 \end{lstlisting}
 
-The first descriptor is located at start of the indirect
+The first descriptor is located at the start of the indirect
 descriptor table, additional indirect descriptors come
-immediately afterwards. \field{Flags} bit VIRTQ_DESC_F_WRITE is the
+immediately afterwards. The VIRTQ_DESC_F_WRITE \field{flags} bit is the
 only valid flag for descriptors in the indirect table. Others
 are reserved and are ignored by the device.
 Buffer ID is also reserved and is ignored by the device.
@@ -282,8 +282,8 @@ devices to notify the use of a batch of buffers to the driver by
 only writing out a single used descriptor with the Buffer ID
 corresponding to the last descriptor in the batch.
 
-Device then skips forward in the ring according to the size of
-the batch. Driver needs to look up the used Buffer ID and
+The device then skips forward in the ring according to the size of
+the batch. The driver needs to look up the used Buffer ID and
 calculate the batch size to be able to advance to where the next
 used descriptor will be written by the device.
 
@@ -312,13 +312,13 @@ in the ring.
 In many systems driver and device notifications involve
 significant overhead. To mitigate this overhead,
 each virtqueue includes two identical structures used for
-controlling notifications between device and driver.
+controlling notifications between the device and the driver.
 
-Driver Event Suppression structure is read-only by the
+The Driver Event Suppression structure is read-only by the
 device and controls the events sent by the device
 to the driver (e.g. interrupts).
 
-Device Event Suppression structure is read-only by
+The Device Event Suppression structure is read-only by
 the driver and controls the events sent by the driver
 to the device (e.g. IO).
 
@@ -352,9 +352,9 @@ matches this value and a descriptor is
 made available/used respectively.
 \end{description}
 
-After writing out some descriptors, both device and driver
+After writing out some descriptors, both the device and the driver
 are expected to consult the relevant structure to find out
-whether interrupt/notification should be sent.
+whether an interrupt/notification should be sent.
 
 \subsubsection{Structure Size and Alignment}
 \label{sec:Packed Virtqueues / Structure Size and Alignment}
@@ -385,7 +385,7 @@ part of the virtqueue.
 
 Queue Size corresponds to the maximum number of descriptors in the
 virtqueue\footnote{For example, if Queue Size is 4 then at most 4 buffers
-can be queued at any given time.}.  Queue Size value does not
+can be queued at any given time.}.  The Queue Size value does not
 have to be a power of 2 unless enforced by the transport.
 
 \drivernormative{\subsection}{Virtqueues}{Basic Facilities of a
@@ -400,7 +400,7 @@ The device MUST start processing driver descriptors in the order
 in which they appear in the ring.
 The device MUST start writing device descriptors into the ring in
 the order in which they complete.
-Device MAY reorder descriptor writes once they are started.
+The device MAY reorder descriptor writes once they are started.
 
 \subsection{The Virtqueue Descriptor Format}\label{sec:Basic
 Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue
@@ -449,16 +449,16 @@ struct pvirtq_event_suppress {
 A device MUST NOT write to a device-readable buffer, and a device SHOULD NOT
 read a device-writable buffer.
 A device MUST NOT use a descriptor unless it observes
-VIRTQ_DESC_F_AVAIL bit in its \field{flags} being changed
+the VIRTQ_DESC_F_AVAIL bit in its \field{flags} being changed
 (e.g. as compared to the initial zero value).
 A device MUST NOT change a descriptor after changing it's
-VIRTQ_DESC_F_USED bit in its \field{flags}.
+the VIRTQ_DESC_F_USED bit in its \field{flags}.
 
 \drivernormative{\subsection}{The Virtqueue Descriptor Table}{Basic Facilities of a Virtio Device / PAcked Virtqueues / The Virtqueue Descriptor Table}
 A driver MUST NOT change a descriptor unless it observes
-VIRTQ_DESC_F_USED bit in its \field{flags} being changed.
+the VIRTQ_DESC_F_USED bit in its \field{flags} being changed.
 A driver MUST NOT change a descriptor after changing
-VIRTQ_DESC_F_AVAIL bit in its \field{flags}.
+the VIRTQ_DESC_F_AVAIL bit in its \field{flags}.
 When notifying the device, driver MUST set
 \field{next_off} and
 \field{next_wrap} to match the next descriptor
@@ -549,8 +549,8 @@ For each buffer element, b:
 \item Calculate the flags as follows:
 \begin{enumerate}
 \item If b is device-writable, set the VIRTQ_DESC_F_WRITE bit to 1, otherwise 0
-\item Set VIRTQ_DESC_F_AVAIL bit to the current value of the Driver Ring Wrap Counter
-\item Set VIRTQ_DESC_F_USED bit to inverse value
+\item Set the VIRTQ_DESC_F_AVAIL bit to the current value of the Driver Ring Wrap Counter
+\item Set the VIRTQ_DESC_F_USED bit to inverse value
 \end{enumerate}
 \item Perform a memory barrier to ensure that the descriptor has
       been initialized
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

