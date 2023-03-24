Return-Path: <virtio-dev-return-11769-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225DEC6FD20
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 06:55:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7190A2AC82
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 06:55:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 65B50986486
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 06:55:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 59D84986460; Fri, 24 Mar 2023 06:55:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4684F986399;
	Fri, 24 Mar 2023 06:55:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0VeWiFUt_1679640893;
Message-ID: <1679639753.3011482-1-xuanzhuo@linux.alibaba.com>
Date: Fri, 24 Mar 2023 14:35:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>
Cc: hans@linux.alibaba.com,
 herongguang@linux.alibaba.com,
 zmlcc@linux.alibaba.com,
 dust.li@linux.alibaba.com,
 tonylu@linux.alibaba.com,
 zhenzao@linux.alibaba.com,
 helinguo@linux.alibaba.com,
 gerry@linux.alibaba.com,
 mst@redhat.com,
 cohuck@redhat.com,
 jasowang@redhat.com,
 Jan Kiszka <jan.kiszka@siemens.com>,
 wintera@linux.ibm.com,
 kgraul@linux.ibm.com,
 wenjia@linux.ibm.com,
 jaka@linux.ibm.com,
 hca@linux.ibm.com,
 twinkler@linux.ibm.com,
 raspl@linux.ibm.com,
 virtio-dev@lists.oasis-open.org,
 pasic@linux.ibm.com,
 virtio-comment@lists.oasis-open.org
References: <20230209033056.96657-1-xuanzhuo@linux.alibaba.com>
 <20230209033056.96657-2-xuanzhuo@linux.alibaba.com>
 <6ecabec0-0a17-f64a-b91c-115d65338bf2@nvidia.com>
In-Reply-To: <6ecabec0-0a17-f64a-b91c-115d65338bf2@nvidia.com>
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v3 1/1] virtio-ism: introduce new device virtio-ism

On Fri, 24 Mar 2023 00:51:13 -0400, Parav Pandit <parav@nvidia.com> wrote:
>
>
> On 2/8/2023 10:30 PM, Xuan Zhuo wrote:
> > An ISM(Internal Shared Memory) device provides the ability to access memory
> > shared between multiple devices. This allows low-overhead communication in
> > presence of such memory. For example, memory can be shared with guests of
> > multiple virtual machines running on the same host, with each virtual machine
>
> I am still learning this new memory sharing beast, so mostly cosmetics
> comments below.
>
> instead of guest of virtual machines is confusing.
> It can be just written as - can be shared between virtual machines
> running on same host ..
> > including an ism device and with the guests getting the shared memory by the ism
> > devices.
> >
> > An ism device can communicate with multiple peers simultaneously. This
> > communication can be dynamically started and ended.
> >
> multiple peers mean, multiple peer ism device?

Yes. multiple peer ism device.

Yes, we should use device, not VM or Guest.


> Or you meant multiple vms?
>
> > |-------------------------------------------------------------------------------------------------------------|
> > | |------------------------------------------------|       |------------------------------------------------| |
> > | | Guest                                          |       | Guest                                          | |
> > | |                                                |       |                                                | |
> instead of guest, naming it VM makes it consistent with the spec and
> description.

Yes

>
> > | |   ----------------                             |       |   ----------------                             | |
> > | |   |    driver    |     [M1]   [M2]   [M3]      |       |   |    driver    |             [M2]   [M3]     | |
> > | |   ----------------       |      |      |       |       |   ----------------               |      |      | |
> > | |    |cq|                  |map   |map   |map    |       |    |cq|                          |map   |map   | |
> > | |    |  |                  |      |      |       |       |    |  |                          |      |      | |
> > | |    |  |                -------------------     |       |    |  |                --------------------    | |
> > | |----|--|----------------|  device memory  |-----|       |----|--|----------------|  device memory   |----| |
> > | |    |  |                -------------------     |       |    |  |                --------------------    | |
> > | |                                |               |       |                               |                | |
> > | |                                |               |       |                               |                | |
> > | | Qemu                           |               |       | Qemu                          |                | |
> > | |--------------------------------+---------------|       |-------------------------------+----------------| |
> > |                                  |                                                       |                  |
> > |                                  |                                                       |                  |
> > |                                  |------------------------------+------------------------|                  |
> > |                                                                 |                                           |
> > |                                                                 |                                           |
> > |                                                   --------------------------                                |
> > |                                                    | M1 |   | M2 |   | M3 |                                 |
> > |                                                   --------------------------                                |
> > |                                                                                                             |
> > | HOST                                                                                                        |
> > ---------------------------------------------------------------------------------------------------------------
> >
> You might want to show the event q as well next to control q as its so
> fundamental for this whole operation.


Yes. I will try.


>
> > ---
> >   conformance.tex |  26 +++
> >   content.tex     |   1 +
> >   virtio-ism.tex  | 573 ++++++++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 600 insertions(+)
> >   create mode 100644 virtio-ism.tex
> >
> > diff --git a/conformance.tex b/conformance.tex
> > index c3c1d3e..0a1456a 100644
> > --- a/conformance.tex
> > +++ b/conformance.tex
> > @@ -335,6 +335,17 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> >   \item \ref{drivernormative:Device Types / PMEM Device / Device Initialization}
> >   \end{itemize}
> >
> > +\conformance{\subsection}{ISM Driver Conformance}\label{sec:Conformance / Driver Conformance / ISM Driver Conformance}
> > +
> > +A ISM driver MUST conform to the following normative statements:
> > +
> > +\begin{itemize}
> > +\item \ref{drivernormative:Device Types / ISM Device / Device Initialization}
> > +\item \ref{drivernormative:Device Types / ISM Device / Device Operation / Alloc ISM Region}
> > +\item \ref{drivernormative:Device Types / ISM Device / Device Operation / Attach ISM Region}
> > +\item \ref{drivernormative:Device Types / ISM Device / Device Operation / Detach ISM Region}
> > +\end{itemize}
> > +
> >   \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
> >
> >   A device MUST conform to the following normative statements:
> > @@ -621,6 +632,21 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> >   \item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue return}
> >   \end{itemize}
> >
> > +\conformance{\subsection}{ISM Device Conformance}\label{sec:Conformance / Device Conformance / ISM Device Conformance}
> > +
> > +A ISM device MUST conform to the following normative statements:
> > +
> > +\begin{itemize}
> > +\item \ref{devicenormative:Device Types / ISM Device / Device configuration layout}
> > +\item \ref{devicenormative:Device Types / ISM Device / Device Initialization}
> > +\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Alloc ISM Region}
> > +\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Query ISM Region}
> > +\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Attach ISM Region}
> > +\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Detach ISM Region}
> > +\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Grant ISM Region}
> > +\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Inform Event IRQ Vector}
> Though using control vq to configure irq is good idea, I guess
> queue_msix_vector can be used. It needs some more text that
> queue_msix_vector will not be used etc.


The irq is bind to virtio ism region not queue. So we use the control vq to
configure that.


>
> if the event queue create interface exists over ctrl vq than things tied
> up well. Else I think transport specific existing scheme more aligns to
> the spec.

The situation here is not within the scope of standardization.

Virtio ISM Region is a relatively special concept to virtio spec. It is a piece
of memory, not Queue. So there is no solution provided in the current
specification here. We share this Virtio Ism Region between multiple Device. The
interruption of the binding here is to inform the content of this memory is
updated, and it is used to notify  other devices


>
> > +\end{itemize}
> > +
> >   \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
> >   A conformant implementation MUST be either transitional or
> >   non-transitional, see \ref{intro:Legacy
> > diff --git a/content.tex b/content.tex
> > index 96f4723..fe02aec 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -7545,6 +7545,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
> >   \input{virtio-scmi.tex}
> >   \input{virtio-gpio.tex}
> >   \input{virtio-pmem.tex}
> > +\input{virtio-ism.tex}
> >
> >   \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> >
> > diff --git a/virtio-ism.tex b/virtio-ism.tex
> > new file mode 100644
> > index 0000000..a1720d8
> > --- /dev/null
> > +++ b/virtio-ism.tex
> > @@ -0,0 +1,573 @@
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
> Above line is misaligned.
>
> > +|                                                                 |                                           |
> > +|                                                   --------------------------                                |
> > +|                                                    | M1 |   | M2 |   | M3 |                                 |
> > +|                                                   --------------------------                                |
> > +|                                                                                                             |
> > +|                                                                                                             |
> > +|-------------------------------------------------------------------------------------------------------------|
> > +\end{lstlisting}
> > +
> > +An ISM(Internal Shared Memory) device provides the ability to access memory
> > +shared between multiple devices. This allows low-overhead communication in
> > +presence of such memory. For example, memory can be shared with guests of
> > +multiple virtual machines running on the same host, with each virtual machine
> > +including an ism device and with the guests getting the shared memory by the ism
> > +devices.
> > +
> > +An ism device can communicate with multiple peers simultaneously. This
> > +communication can be dynamically started and ended.
> > +
> > +All the devices with the ability to communicate with each other form a
> > +communication domain. Two devices from different communication domains can't
> > +communicate.
> > +
> > +The device memory of the ism device is divided into multiple chunks with the
> > +same size. Every ism region contains multiple chunks. When communicating between
> > +two devices, an ism region is used as a shared memory.
> > +
> > +The ism region is the basis for communication between ism devices.
> > +
> > +The process of communication between two drivers is that one driver allocates an
> > +ism region and obtains a token. Then the peer uses this token to attach the same
> The peer driver will make it more clear.

Yes

>
> > +ism region, the two drivers realize the memory(ism region) sharing. The driver
> > +can also notify peer by kick notify-address the ism region has been updated.
> > +
> > +An ism region can be referred by its \field{token}, or the \field{offset}.
> > +The \field{offset} is the offset of the first chunk inside the ism region
> > +starting from the device memory head.
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
> > +\subsection{Feature bits}\label{sec:Device Types / ISM Device / Feature bits}
> > +\begin{description}
> > +\item[VIRTIO_ISM_F_DEV_MEM(0)] Device provide memory for ism region, driver
> > +    don't need to provide memory for alloc/attach operation.
> > +
> > +\end{description}
> > +
> > +\subsection{Device configuration layout}\label{sec:Device Types / ISM Device / Device configuration layout}
> > +
> > +\begin{lstlisting}
> > +struct virtio_ism_config {
> > +	le128 cdid;
> le128 data type is not present in the spec.
> Better to define uuid data structure and refer here.
>
> struct uuid {..}
>
> struct uuid cdid;
> ...


will fix

> > +	le64 devid;
> > +	le64 chunk_size;
> > +	le64 notify_size;
> > +};
> > +\end{lstlisting}
> > +
> > +\begin{description}
> > +    \item[\field{cdid}] This is used to identify the communication domain. Only
> > +        ism devices with the same \field{cdid} can communicate. A \field{cdid}
> > +        is world-wide unique in a sense that there not be another communication
> > +        domain with the same \field{cdid}.
> > +
> > +    \item[\field{devid}] This is used to identify the ism device in the single
> > +        communication domain.
> > +
> > +    \item[\field{chunk_size}] This is the size of the ism chunk. The device
> > +        memory is divided into multiple chunks. Every ism chunk has the same
> > +        size.
> > +
> > +    \item[\field{notify_size}] This is the size of the ism notify-address. The
> > +        notify-address is used to notify the device that the content of the
> > +        ism region has been updated.
> > +
> > +\end{description}
> > +
> > +\devicenormative{\subsubsection}{Device configuration layout}{Device Types / ISM Device / Device configuration layout}
> > +
> > +The device MUST ensure that the \field{cdid} of the device on the same
> > +communication domain is same. The \field{cdid} MUST be a version 4 UUID as
> > +specified by \hyperref[intro:rfc4122]{[RFC4122]}.
> > +
> > +In the single communication domain, the device MUST ensure that the \field{devid}
> > +is unique.
> > +
> > +\field{chunk_size} MUST be a power of two.
> > +
> > +\subsection{Physical Memory}\label{sec:Device Types / ISM Device / Event}
> > +
> > +The ism region is on the device memory. It is a physical memory for driver, but
> > +it is not for device.
> If it is not physical memory, than what is it? May be you want to write
> that.


I originally wanted to express that this ISM Region is a physical memory for
the drive, but it is virtual memory for the device. But now I realize that this
sentence is meaningless. I will remove it in the next version.


>
> > The device has the ability to modify the physical memory
> > +corresponding to the device memory.
> > +
> Above sentence as continuation to physical memory implies that its RW
> for device and RO for driver.
> I likely misunderstood.
>
> > +If VIRTIO_ISM_F_DEV_MEM is not negotiated, physical memory comes from driver.
> > +The driver pass its memory to the device when alloc a new ism region. The
> The driver passes its memory to the device when allocating a new ism region.
>
> > +device map this physical memory into an ism region. If VIRTIO_ISM_F_DEV_MEM
> > +is negotiated, physical memory is provided by the device.
> > +
> > +For attach operation, if VIRTIO_ISM_F_DEV_MEM is not negotiated, the driver also
> > +provides memory to device. Under normal circumstances, this memory will not be
> > +used. This is to limit driver to take up too much memory based on attach
> > +operation.
> > +
> > +\subsection{Event}\label{sec:Device Types / ISM Device / Event}
> > +
> > +The ism device supports event notification of the ism region. When a device
> > +kick/attach/detach a region, other ism region referrers will receive related
> > +events.
> > +
> > +A buffer received from eventq can contain multiple event structures.
> > +
> > +\begin{lstlisting}
> > +#define   VIRTIO_ISM_EVENT_UPDATE (1 << 0)
> > +#define   VIRTIO_ISM_EVENT_ATTACH (1 << 1)
> > +#define   VIRTIO_ISM_EVENT_DETACH (1 << 2)
> > +#define   VIRTIO_ISM_EVENT_BUFFER_FREE (1 << 3)  // Only if VIRTIO_ISM_F_DEV_MEM is not negotiated
> > +\end{lstlisting}
> > +
> > +\begin{description}
> > +    \item[VIRTIO_ISM_EVENT_UPDATE] The driver kick the notify-address to notify
> > +        other peers of the update event of the ism region content.
> > +
> > +    \item[VIRTIO_ISM_EVENT_ATTACH] A new device attaches the ism region.
> > +    \item[VIRTIO_ISM_EVENT_DETACH] A device detaches the ism region.
> > +    \item[VIRTIO_ISM_EVENT_BUFFER_FREE] The buffer allocated by this driver has been free.
> > +\end{description}
> > +
> > +The event structures:
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
> > +struct virtio_ism_event_buffer_free {
> > +	le64 ev_type;
> > +    void *buffer;
> Is this a virtual address being shared between driver and device and in
> the cvq command?
> If so, do you need any attachment to process id or such abstract handle
> so that some day user process can also access it?
> or the use case is to only consume by the driver, hence only one VA?

Yes, I miss something. Maybe I should add an offset.

>
> > +};
> > + > +\end{lstlisting}
> > +
> > +\begin{description}
> > +\item[\field{ev_type}] The type of event, the driver can get the size of the
> > +    structure based on this.
> > +
> > +        If \field{ev_type} is VIRTIO_ISM_EVENT_UPDATE, the corresponding structure is struct virtio_ism_event_update.
> > +        If \field{ev_type} is VIRTIO_ISM_EVENT_ATTACH or VIRTIO_ISM_EVENT_DETACH, the corresponding structure struct virtio_ism_event_attach_detach.
> > +        If \field{ev_type} is VIRTIO_ISM_EVENT_BUFFER_FREE, the corresponding structure is struct virtio_ism_event_buffer_free.
> > +
> > +\item[\field{offset}] The offset of ism regions with the event.
> > +
> > +\item[\field{devid}] \field{devid} of the device that generated events.
> > +\item[\field{peers}] The number of the peers referring to this ism region. (does not include the
> > +    device that receiving this event)
> > +
> > +\item[\field{buffer}] The buffer passed to device when alloc/attach a new ism region.
> > +
> > +\end{description}
> > +
> > +\subsection{Permissions}\label{sec:Device Types / ISM Device / Permission}
> > +
> > +The permissions of an ism region determine whether this ism region can be
> > +attached and the read and write permissions after attach. The driver can set the
> > +default permissions for all devices, or set the dedicated permissions for a
> > +certain device. If there are dedicated permissions for a device, the default
> > +permissions are invalid for this device.
> > +
> > +For example, the driver can set the default permission of an ism region as
> > +read-only, and set the dedicated permissions as writable for a device with devid
> > +0xff. Then all devices except 0xff in such a communication domain can attach
> > +this ism region and only have read-only permission. And the device 0xff can
> > +write to the ism region after attaching.
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
> > +The device exposes memory to the driver based on Shared Memory Regions
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
> > +The device memory area with VIRTIO_ISM_SHM_ID_REGIONS is used to provide ism regions.
> > +
> > +The device MUST also provide a memory area with VIRTIO_ISM_SHM_ID_NOTIFY to the
> > +driver. This memory area is used to notify the device with update event, and
> > +each ism region MUST have a corresponding notify-address inside this area, and
> > +the size of the notify-address is \field{notify_size}.
> > +
> > +\drivernormative{\subsubsection}{Device Initialization}{Device Types / ISM Device / Device Initialization}
> > +
> > +The driver MUST NOT access any chunk before it is referred by one ism region.
> > +
> > +\subsection{Control Virtqueue}\label{sec:Device Types / ISM Device / Control Virtqueue}
> > +
> > +The driver uses the control virtqueue send commands to implement operations on
> control virtqueue to send commands
>
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
> > +
> > +\subsection{Device Operation}\label{sec:Device Types / ISM Driver / Device Operation}
> > +
> > +\subsubsection{Alloc ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Alloc ISM Region}
> > +
> > +Based on controlq, the driver can request to allocate an ism region.
> > +
> > +The reply from the device will carry a token, which can be passed
> > +to other driver for attaching to this ism region.
> > +
> > +The \field{command_specific_data} has the following format:
> > +\begin{lstlisting}
> > +struct virtio_ism_ctrl_alloc {
> > +	le64 size;
> > +    void *buffer; // Only if VIRTIO_ISM_F_DEV_MEM is not negotiated
> align void* and le64 to same.
>
> void * here and above doesnt define the exact data size.
> device will not be able to understand bit width of void* on 64-bit and
> 32-bit systems.
>
> please change to u64.
>
> Also I think spec follows /* */ comment style, instead of //.
>
> > +};
> > +\end{lstlisting}
> > +
> > +The \field{command_specific_data_reply} has the following format:
> > +\begin{lstlisting}
> > +struct virtio_ism_ctrl_alloc_reply {
> > +	le64 token;
> > +	le64 num;
> > +    le64 chunks[];
> > +};
> > +\end{lstlisting}
> > +
> > +The \field{class} and \field{command}:
> > +\begin{lstlisting}
> > +#define VIRTIO_ISM_CTRL_ALLOC  0
> > +	#define VIRTIO_ISM_CTRL_ALLOC_REGION 0
> > +\end{lstlisting}
> > +
> > +
> > +\devicenormative{\subparagraph}{Alloc ISM Region}{Device Types / ISM Device / Device Operation / Alloc ISM Region}
> > +
> > +For the command VIRTIO_ISM_CTRL_ALLOC_REGION, the device MUST first look for the
> > +free chunks from the device memory. And the physical memory is mapped to these
> > +chunks in order. If VIRTIO_ISM_F_DEV_MEM is negotiated, then the device MUST
> > +provide physical memory by itself. Otherwise, the memory provided by the driver
> > +will be used. If there is no enough free chunk, the device MUST set \field{ack}
> > +to VIRTIO_ISM_NOSPEC. If new physical memory cannot be allocated by the device,
> > +the device MUST set \field{ack} to VIRTIO_ISM_NOMEM.
> > +
> > +The device sets \field{ack} to VIRTIO_ISM_OK after successfully allocating the
> > +ism region. A new token MUST be dynamically created for this ism region
> > +simultaneously. The token MUST be unique inside this communication domain. And
> > +the device MUST fill \filed{chunks} with the offset of each chunk. \field{num}
> > +is the number of the chunks.
> > +
> > +The device MUST clear the memory of this ism region before committing to the
> > +driver.
> > +
> > +If \field{size} is smaller than \field{chunk_size}, the ism region also
> > +occupies one chunk.
> > +
> > +If virtio_ism_ctrl_alloc_reply is not enough, the device MUST set the \field{ack}
> > +to VIRTIO_ISM_E2BIG.
> > +
> > +\drivernormative{\subparagraph}{Alloc ISM Region}{Device Types / ISM Device / Device Operation / Alloc ISM Region}
> > +
> > +If VIRTIO_ISM_F_DEV_MEM is not negotiated, the driver MUST provide the buffer
> > +with \field{buffer}. The size of the buffer MUST equal to the size of the ism
> > +region that we want to allocate.
> > +
> > +\subsubsection{Query ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Query ISM Region}
> > +Based on controlq, the driver can query the information of an ism region.
> > +
> > +The \field{command_specific_data} has the following format:
> > +\begin{lstlisting}
> > +struct virtio_ism_ctrl_query {
> > +	le64 token;
> > +};
> > +\end{lstlisting}
> > +
> > +The \field{command_specific_data_reply} has the following format:
> > +\begin{lstlisting}
> > +struct virtio_ism_ctrl_query_reply {
> > +	le64 size;
> > +	le64 permissions;
> Better to define the decoding of the permissions here.
> Also below you have field rw_perm. May be rename both to sama name.


Will fix.

Thanks.


>
> > +};
> > +\end{lstlisting}
> > +
> > +The \field{class} and \field{command}:
> > +\begin{lstlisting}
> > +#define VIRTIO_ISM_CTRL_QUERY  1
> > +	#define VIRTIO_ISM_CTRL_QUERY_INFO 0
> > +\end{lstlisting}
> > +
> > +\devicenormative{\subparagraph}{Query ISM Region}{Device Types / ISM Device / Device Operation / Query ISM Region}
> > +
> > +If the ism region specified by \field{token} does not exist, the device MUST set
> > +\field{ack} to VIRTIO_ISM_ENOENT. Otherwise, the device MUST fill the
> > +\field{size} with the size of the ism region. The device MUST get the
> > +permissions of this ism region for the device-self, then fill in the
> > +\field{permissions}.
> > +
> > +\subsubsection{Attach ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Attach ISM Region}
> > +
> > +Based on controlq, the driver can request to attach an ism region with a
> > +specified token.
> > +
> > +The \field{command_specific_data} has the following format:
> > +\begin{lstlisting}
> > +struct virtio_ism_ctrl_attach {
> > +	le64 token;
> > +	le64 rw_perm;
> > +    void *buffer; // Only if VIRTIO_ISM_F_DEV_MEM is not negotiated
> > +};
> > +\end{lstlisting}
> > +
> > +The \field{command_specific_data_reply} has the following format:
> > +\begin{lstlisting}
> > +struct virtio_ism_ctrl_attach_reply {
> > +	le64 size;
> > +	le64 num;
> > +    le64 chunks[];
> > +};
> > +\end{lstlisting}
> > +
> > +The \field{class} and \field{command}:
> > +\begin{lstlisting}
> > +#define VIRTIO_ISM_CTRL_ATTACH  2
> > +	#define VIRTIO_ISM_CTRL_ATTACH_REGION 0
> > +\end{lstlisting}
> > +
> > +\devicenormative{\subparagraph}{Attach ISM Region}{Device Types / ISM Device / Device Operation / Attach ISM Region}
> > +
> > +If the ism region specified by \field{token} does not exist, the device MUST set
> > +\field{ack} to VIRTIO_ISM_ENOENT.
> > +
> > +The device MUST first look for the free chunks from the device memory. And the
> > +physical memory of the ism region is mapped to these chunks in order. If there is
> > +no enough free chunk, the device MUST set \field{ack} to VIRTIO_ISM_NOSPEC.
> > +The device MUST fill \filed{chunks} with the offset of each chunk. \field{num}
> > +is the number of the chunks. \field{size} is the size of this ism region.
> > +
> > +The device MUST set \field{ack} to VIRTIO_ISM_OK after successfully finding and
> > +assigning the physical memory of this ism region into the device memory.
> > +
> > +If the device does not have the VIRTIO_ISM_PERM_ATTACH permission for this ism
> > +region, the device MUST set \field{ack} to VIRTIO_ISM_PERM_EATTACH. If
> > +\field{rw_perm} include VIRTIO_ISM_PERM_READ, but the device does not have the
> > +VIRTIO_ISM_PERM_READ permission for this region, the device MUST set \field{ack}
> > +to VIRTIO_ISM_PERM_EREAD. If \field{rw_perm} include VIRTIO_ISM_PERM_WRITE, but
> > +the device does not have the VIRTIO_ISM_PERM_WRITE permission for this region,
> > +the device MUST set \field{ack} to VIRTIO_ISM_PERM_EWRITE.
> > +
> > +The device MUST set the read and write permissions of the physical memory inside
> > +the device memory based on \field{rw_perm}.
> > +
> > +If virtio_ism_ctrl_alloc_reply is not enough, the device MUST set the \field{ack}
> > +to VIRTIO_ISM_E2BIG and set the \field{num} for next request.
> > +
> > +The device MUST generate a VIRTIO_ISM_EVENT_ATTACH event to other peers.
> > +
> > +\drivernormative{\subparagraph}{Attach ISM Region}{Device Types / ISM Device / Device Operation / Attach ISM Region}
> > +
> > +If VIRTIO_ISM_F_DEV_MEM is not negotiated, the driver MUST provide the buffer
> > +with \field{buffer}. The size of the buffer MUST equal to the size of the ism
> > +region that we w

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

