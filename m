Return-Path: <xuanzhuo@linux.alibaba.com>
Message-ID: <1673435333.1297436-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [virtio-dev] [PATCH v2 1/1] virtio-ism: introduce new device virtio-ism
Date: Wed, 11 Jan 2023 19:08:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221223081354.15026-1-xuanzhuo@linux.alibaba.com>
 <20221223081354.15026-2-xuanzhuo@linux.alibaba.com>
 <20230110233401.131cc97a.pasic@linux.ibm.com>
In-Reply-To: <20230110233401.131cc97a.pasic@linux.ibm.com>
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, jasowang@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, wintera@linux.ibm.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, hca@linux.ibm.com, twinkler@linux.ibm.com, raspl@linux.ibm.com, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 10 Jan 2023 23:34:01 +0100, Halil Pasic <pasic@linux.ibm.com> wrote:
> On Fri, 23 Dec 2022 16:13:54 +0800
> Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> > The virtio ism device provides and manages many memory ism regions in
> > host. These ism regions can be alloc/attach/detach by driver. Every
> [..]
>
> Hi Xuan Zhou!
>
> Some words in advance. While I'm supportive of the general idea, I find
> the proposed specification quite difficult to read, and I have the
> feeling I did not get the full picture. So my review will be a mix of
> feedback on the tactical and of questions on the strategic level. Please
> bear with me.

Any opinion is welcome. ^_^

>
> >
> > diff --git a/virtio-ism.tex b/virtio-ism.tex
> > new file mode 100644
> > index 0000000..7f09c43
> > --- /dev/null
> > +++ b/virtio-ism.tex
> > @@ -0,0 +1,472 @@
> > +\section{ISM Device}\label{sec:Device Types / ISM Device}
> > +
> > +\begin{lstlisting}
> > +|-------------------------------------------------------------------------------------------------------------|
> > +| |------------------------------------------------|    |------------------------------------------------|    |
> > +| | VM                      [M1]   [M2]   [M3]     |    | VM                             [M2]   [M3]     |    |
> > +| |                          |      |      |       |    |                                 |      |       |    |
> > +| |   -----------------------|------|------|---    |    |   ------------------------------|------|---    |    |
> > +| |   |             driver   |      |      |  |    |    |   |             driver          |      |  |    |    |
> > +| |   -----------------------|------|------|---    |    |   ------------------------------|------|---    |    |
> > +| |    |cq|                  |map   |map   |map    |    |    |cq|                         |map   |map    |    |
> > +| |    |  |                  |      |      |       |    |    |  |                         |      |       |    |
> > +| |    |  |                -------------------     |    |    |  |                -------------------     |    |
> > +| |----|--|----------------|  device memory  |-----|    |----|--|----------------|  device memory  |-----|    |
> > +| |    |  |                -------------------     |    |    |  |                -------------------     |    |
> > +| |                                |               |    |                                |               |    |
> > +| |                                |               |    |                                |               |    |
> > +| |                                |               |    |                                |               |    |
> > +| |--------------------------------+---------------|    |--------------------------------+---------------|    |
> > +|                                  |                                                       |                  |
> > +|                                  |                                                       |                  |
> > +|                                  |------------------------------+------------------------|                  |
> > +|                                                                 |                                           |
> > +|                                                                 |                                           |
> > +|                                                   --------------------------                                |
> > +|                                                    | M1 |   | M2 |   | M3 |                                 |
> > +|                                                   --------------------------                                |
> > +|                                                                                                             |
> > +|                                                                                                             |
> > +|-------------------------------------------------------------------------------------------------------------|
> > +\end{lstlisting}
> > +
> > +ISM(Internal Shared Memory) device provides the ability to share memory between
> > +different VMs launched from the same entity.
>
> Launched by instead of from? Maybe introduce a catchy name for the
> "entity that launched the VMs" and prevent oversimplification by
> explaining any shortcomings of the name if any in one place. Host would
> be one candidate, VMM another.

Cornelia Huck wrote:

	Is there a way to avoid the term "host" (throughout this document)?
	IIUC, you need the uniqueness within the scope of the entity that
	launches the different instances that get shared access to the regions
	(which could conceivably a unit of hardware?)

And I think she is right, so I am trying to remove the term HOST.

Do you have better opinions? I think VMM is not particularly suitable.

>
> > A vm's memory got from ISM device
> > +can be shared with multiple peers at the same time. This shared relationship can
>
> s/at the same time/simultaneously/ ?

Yes

>
> > +be dynamically created and released.
>
> "This shared relationship" does not sound right, but I have no proposal
> out of the top of my head.
>
> > +
> > +The contiguous shared memory obtained from the device is divided into multiple
> > +ism regions for share.
>
> What does "for share" mean here? I don't quite understand this sentence.


Maybe s/for share//


>
> > +
> > +ISM device provides a mechanism to notify other ism region referrers of events.
> > +
> > +
> > +\subsection{Device ID}\label{sec:Device Types / ISM Device / Device ID}
> > +	44
> > +
> > +\subsection{Virtqueues}\label{sec:Device Types / ISM Device / Virtqueues}
> > +\begin{description}
> > +\item[0] controlq
> > +\item[1] eventq
> > +\end{description}
> > +
> > +\subsection{Device configuration layout}\label{sec:Device Types / ISM Device / Device configuration layout}
> > +
> > +\begin{lstlisting}
> > +struct virtio_ism_config {
> > +	le64 gid;
> > +	le64 devid;
> > +	le64 chunk_size;
> > +	le64 notify_size;
> > +};
> > +\end{lstlisting}
> > +
> > +\begin{description}
> > +    \item[\field{gid}] \field{gid} is used to identify different entity that
> > +        launches the VMs.
>
> What does gid stand for?
>
> s/different/the/ ?

Will fix.

>
> I can't figure out what is "different" supposed to mean here.
>
> >Only the ism devices with the same \field{gid} can
>
> s/the ism/ism/ ?

Will fix.

> > +        share the ism regions. Therefore, this value is unique in the
>
> /s/share the/share/ ?

Will fix.

>
> > +        world-wide.
>
> Makes no sense to me.
>
> We could call gid host_id.

Yes, this has been discussed in the discussion with Alexandra.

> We could also say that a host_id is
> world-wide unique in a sense that there must not be another host
> with the same host_id.
>
> That of course raises the question, how do the different implementations
> ensure that the gid (or hostid) remains unique. I guess therefore this
> specification needs to specify how such unique gids are generated.

Yes, we currently have several solutions. The most suitable may be to use UUID
and record it. In this way, all VMMs can use this UUID. But this requires that
the host_id is 128-bit.


>
> > +
> > +    \item[\field{devid}] the device id is used to identify different ism devices
>
> s/uniquely identify an ism device within the scope of the host. I.e.
> devices attached to VMs on the same host must have different
> \filed{devid} values, while devices attached to VMs that are hosted by
> different hosts may have the same \field{devid} values.

Will fix.

>
> > +        on the same entity.
> > +
> > +    \item[\field{chunk_size}] the size of the every ism chunk.
>
> What is a chunk? Fist introduced here. Please use consistent wording.

Will fix.

>
> > +        Large shared memories are divided into multiple chunks, and one time
>
> "Memories" sounds wrong here. I guess what you used to call "regions"
> you now call "chunks". But I may be wrong.

A ism region consists of multiple chunks. The size of each chunk is fixed.
The size of ism region is not fixed.

>
> > +        will take up at least one chunk.
> > +
> > +    \item[\field{notify_size}] the size of the notify address.
>
> The term "notify address" ain't properly introduced.

Will fix.

>
> > +\end{description}
> > +
> > +\devicenormative{\subsubsection}{Device configuration layout}{Device Types / ISM Device / Device configuration layout}
> > +
> > +The device MUST ensure that the \field{gid} on the same entity i
>
> s/i$/is$/

Will fix.


>
> > +same and different from the \field{gid} on other entity.
>
> How is the device supposed to know what is "the \field{gid} on other
> entity"? See my previous comment.

It is guaranteed by the algorithm. The use of a unified algorithm on the
implementation of VMM can be implemented. Considering that the VM of different
manufacturers may exchange Host-Id, we should define an algorithm that generates
the host-id in this standard.


>
> > +
> > +On the same entity, the device MUST ensure that the \field{devid} is unique.
> > +
> > +\field{chunk_size} MUST be a power of two.
> > +
> > +\subsection{Event}\label{sec:Device Types / Network Device / Device Operation / Event}
> > +
> > +\begin{lstlisting}
> > +#define   VIRTIO_ISM_EVENT_UPDATE (1 << 0)
> > +#define   VIRTIO_ISM_EVENT_ATTACH (1 << 1)
> > +#define   VIRTIO_ISM_EVENT_DETACH (1 << 2)
> > +\end{lstlisting}
> > +
> > +\begin{description}
> > +    \item[VIRTIO_ISM_EVENT_UPDATE]
> > +        The driver kick the notify area to notify other peers of the update
> > +        event of the ism region content.
> > +
> > +    \item[VIRTIO_ISM_EVENT_ATTACH] A new device attaches the ism region.
> > +    \item[VIRTIO_ISM_EVENT_DETACH] A device detaches the ism region.
> > +\end{description}
> > +
> > +The ism device supports event notification of the ism region. When a device
> > +kick/attach/detach a region, other ism region referrers may receive related
> > +events.
> > +
>
> Is "may" what we want to use here? This sounds like the referrers may
> not rely on receiving these events, because they don't have the
> guarantee they will receive any.


Will fix.

>
> > +A buffer received from eventq can contain multiple event structures.
> > +
> > +\begin{lstlisting}
> > +struct virtio_ism_event_update {
> > +	le64 ev_type;
> > +	le64 offset;
> > +	le64 devid;
> > +};
> > +
> > +struct virtio_ism_event_attach_detach {
> > +	le64 ev_type;
> > +	le64 offset;
> > +	le64 devid;
> > +	le64 peers;
> > +};
> > +
> > +\end{lstlisting}
> > +
> > +\begin{description}
> > +\item[\field{ev_type}] The type of event, the driver can get the size of the
> > +    structure based on this.
> > +
> > +\item[\field{offset}] The offset of ism regions with the event.
>
> Offset with respect to what?

Used to specify a region. Offset is the position of this ISM Region inside the
memory of Device.


>
> > +
> > +\item[\field{devid}] \field{devid} of the device that generated events.
> > +\item[\field{peers}] The number of the ism region referres (does not include the
> > +    device that receiving this event)
> > +
> > +\end{description}
> > +
> > +
> > +\subsection{Permissions}\label{sec:Device Types / Network Device / Device Operation / Permission}
> > +
> > +The permissions of a ism region determine whether this ism region can be
> > +attached and the read and write permissions after attach.
> > +
> > +The driver can set the default permissions, or set permissions for some certain
> > +devices.
>
> What does "default permissions" and "some certain devices" mean here?

"default permissions": This can be understood as the permissions for all devices.
"some certain devices": This is the permissions set for a specific device.

>
> > +
> > +When a driver has the management permission of the ism region, then it can
> > +modify the permissions of this ism region. By default, only the device that
> > +allocated the ism region has this permission.
> > +
> > +\subsection{Device Initialization}\label{sec:Device Types / ISM Device / Device Initialization}
> > +
> > +\devicenormative{\subsubsection}{Device Initialization}{Device Types / ISM Device / Device Initialization}
> > +
> > +The device MUST generate a \field{devid}. \field{devid} remains unchanged
> > +during reset. \field{devid} MUST NOT be 0.
> > +
> > +The device shares memory to the driver based on shared memory regions
> > +\ref{sec:Basic Facilities of a Virtio Device / Shared Memory Regions}.
> > +However, it does not need to allocate physical memory during initialization.
> > +
> > +The \field{shmid} of a region MUST be one of the following
> > +\begin{lstlisting}
> > +enum virtio_ism_shm_id {
> > +	VIRTIO_ISM_SHM_ID_UNDEFINED = 0,
> > +	VIRTIO_ISM_SHM_ID_REGIONS   = 1,
> > +	VIRTIO_ISM_SHM_ID_NOTIFY    = 2,
> > +};
> > +\end{lstlisting}
> > +
> > +The shared memory whose shmid is VIRTIO_ISM_SHM_ID_REGIONS is used to implement
> > +ism regions.
>
> Hm. AFAIU, these are supposed to be used for exchanging data between the
> VMs that are supposed to communicate with each other via ism.
>
> How does this relate to the following normative section:
> """
> 2.10.2 Device Requirements: Shared Memory Regions
>
> Shared memory regions MUST NOT expose shared memory regions which are used to control the operation of the device, nor to stream data.
> """

From https://lists.oasis-open.org/archives/virtio-comment/201906/msg00010.html

	I'm trying to find a way to say that people shouldn't side-step virtio
	queues by putting everything in a big blob of shared memory.

So I think this should not be conflict.

>
> > If there are multiple shared memories whose shmid is
> > +VIRTIO_ISM_SHM_ID_REGIONS, they are used as contiguous memory in the order of
> > +acquisition.
>
> Hm, I used to think that the shmid is an unique identifier for a shared
> memory region. How can multiple virtio shared memory regions have the
> same shmid?

Shmid is used to define what this sharing memory is used to do, not its unique
identifier.

This is the point that device provides multiple shared memory areas.
These memory areas are used to provide ISM Region.

>
> Can you have a look at the MMIO interface for virtio shared memory
> regions.

Is there any special attention?


>
> How far what ISM tries to do consistent with virtio shared memory. I
> mean, AFAIU once the shared memory is advertised, the  shared memory is
> supposed to be there and accessible by the driver for both writes and
> reads.

Before allocation, VMM did not allocate physical memory for it. Therefore, it
was illegal to read and write this memory.

> But for ISM there is this allocation and attach/detach and
> permissions.

Alloc/Attach is to let the device allocate or bind physical memory.

>
> What about "Memory consistency rules vary depending on the region and
> the device and they will be specified as required by each device." form
> "2.10 Shared Memory Regions".
>
> > +
> > +The device MUST also provides a shared memory with VIRTIO_ISM_SHM_ID_NOTIFY to
> > +the driver. This memory area is used for notify, and each ism region MUST have a
> > +corresponding notify address inside this area, and the size of the notify
> > +address is \field{notify_size};
> > +
> > +\drivernormative{\subsubsection}{Device Initialization}{Device Types / ISM Device / Device Initialization}
> > +
> > +The driver MUST query all shared memory regions supported by the device.
> > +(see \ref{sec:Basic Facilities of a Virtio Device / Shared Memory Regions})
> > +
> > +
> > +\subsection{Control Virtqueue}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue}
> > +
> > +The driver uses the control virtqueue send commands to implement operations on
> > +the ism region and some global configurations.
> > +
> > +All commands are of the following form:
> > +\begin{lstlisting}
> > +struct virtio_ism_ctrl {
> > +	u8 class;
> > +	u8 command;
> > +	u8 command_specific_data[];
> > +	u8 ack;
> > +	u8 command_specific_data_reply[];
> > +};
> > +
> > +/* ack values */
> > +#define VIRTIO_ISM_OK      0
> > +#define VIRTIO_ISM_ERR     255
> > +
> > +#define VIRTIO_ISM_ENOENT  2
> > +#define VIRTIO_ISM_E2BIG   7
> > +#define VIRTIO_ISM_ENOMEM  12
> > +#define VIRTIO_ISM_ENOSPEC 28
> > +
> > +#define VIRTIO_ISM_PERM_EATTACH 100
> > +#define VIRTIO_ISM_PERM_EREAD   101
> > +#define VIRTIO_ISM_PERM_EWRITE  102
> > +\end{lstlisting}
> > +
> > +The \field{class}, \field{command} and command-specific-data are set by the
> > +driver, and the device sets the \field{ack} byte and optionally
> > +\field{command-specific-data-reply}.
>
> Where are values and their semantic for \field{command} specified? I see
> no more references to \field{command}. Similarly I see no further
> references the fields \field{command-specific-data} and
> \field{command-specific-data-reply}.


Sorry, this is a common method for Virtio CVQ. I didn't write it particularly
clearly. I will try to write a little more in next version.

As far as "Alloc ISM Region" is concerned, there are these definitions.

	+struct virtio_ism_area {
	+	le64 offset;
	+	le64 size;
	+}
	+
	+struct virtio_ism_ctrl_alloc {
	+	le64 size;
	+};
	+
	+struct virtio_ism_ctrl_alloc_reply {
	+	le64 token;
	+	le64 num;
	+    struct virtio_ism_area area[];
	+};
	+
	+#define VIRTIO_ISM_CTRL_ALLOC  0
	+	#define VIRTIO_ISM_CTRL_ALLOC_REGION 0


class:                       VIRTIO_ISM_CTRL_ALLOC
command:                     VIRTIO_ISM_CTRL_ALLOC_REGION
command-specific-data:       virtio_ism_ctrl_alloc
command-specific-data-reply: virtio_ism_ctrl_alloc_reply



Look forward to your reply.

Regards,
Xuan


>
> [..]
>
> I will continue with the review from here. I didn't have the opportunity
> to look at the PoC implementation. Maybe it will be easier to get through
> the rest of this text once I have a better understanding of the part up
> till now.
>
> Regards,
> Halil

