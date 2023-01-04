Return-Path: <wintera@linux.ibm.com>
Message-ID: <ea002d31-5a17-faba-afe0-799c29644953@linux.ibm.com>
Date: Wed, 4 Jan 2023 14:29:04 +0100
MIME-Version: 1.0
From: Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] virtio-ism: introduce new device virtio-ism
References: <20221223081939.26506-1-xuanzhuo@linux.alibaba.com>
 <20221223081939.26506-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20221223081939.26506-2-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-comment@lists.oasis-open.org
Cc: hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, jasowang@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, hca@linux.ibm.com, twinkler@linux.ibm.com, raspl@linux.ibm.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



On 23.12.22 09:19, Xuan Zhuo wrote:
> The virtio ism device provides and manages many memory ism regions in
> host. These ism regions can be alloc/attach/detach by driver. Every
> ism region can be shared by token with other VM after allocation.
> The driver obtains the memory region on the host through the memory on
> the device.
> 
> |-------------------------------------------------------------------------------------------------------------|
> | |------------------------------------------------|       |------------------------------------------------| |
> | | Guest                                          |       | Guest                                          | |
> | |                                                |       |                                                | |
> | |   ----------------                             |       |   ----------------                             | |
> | |   |    driver    |     [M1]   [M2]   [M3]      |       |   |    driver    |             [M2]   [M3]     | |
> | |   ----------------       |      |      |       |       |   ----------------               |      |      | |
> | |    |cq|                  |map   |map   |map    |       |    |cq|                          |map   |map   | |
> | |    |  |                  |      |      |       |       |    |  |                          |      |      | |
> | |    |  |                -------------------     |       |    |  |                --------------------    | |
> | |----|--|----------------|  device memory  |-----|       |----|--|----------------|  device memory   |----| |
> | |    |  |                -------------------     |       |    |  |                --------------------    | |
> | |                                |               |       |                               |                | |
> | |                                |               |       |                               |                | |
> | | Qemu                           |               |       | Qemu                          |                | |
> | |--------------------------------+---------------|       |-------------------------------+----------------| |
> |                                  |                                                       |                  |
> |                                  |                                                       |                  |
> |                                  |------------------------------+------------------------|                  |
> |                                                                 |                                           |
> |                                                                 |                                           |
> |                                                   --------------------------                                |
> |                                                    | M1 |   | M2 |   | M3 |                                 |
> |                                                   --------------------------                                |
> |                                                                                                             |
> | HOST                                                                                                        |
> ---------------------------------------------------------------------------------------------------------------
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
> Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
> Signed-off-by: Helin Guo <helinguo@linux.alibaba.com>
> Signed-off-by: Hans Zhang <hans@linux.alibaba.com>
> Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
> ---
>  conformance.tex |  24 +++
>  content.tex     |   1 +
>  virtio-ism.tex  | 472 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 497 insertions(+)
>  create mode 100644 virtio-ism.tex
> 
> diff --git a/conformance.tex b/conformance.tex
> index c3c1d3e..7c3cbc3 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -335,6 +335,15 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{drivernormative:Device Types / PMEM Device / Device Initialization}
>  \end{itemize}
>  
> +\conformance{\subsection}{ISM Driver Conformance}\label{sec:Conformance / Driver Conformance / ISM Driver Conformance}
> +
> +A ISM driver MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{drivernormative:Device Types / ISM Device / Device Initialization}
> +\item \ref{drivernormative:Device Types / ISM Device / Device Operation / Alloc ISM Region}
> +\end{itemize}
> +
>  \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
>  
>  A device MUST conform to the following normative statements:
> @@ -621,6 +630,21 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue return}
>  \end{itemize}
>  
> +\conformance{\subsection}{ISM Device Conformance}\label{sec:Conformance / Device Conformance / ISM Device Conformance}
> +
> +A ISM device MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / ISM Device / Device configuration layout}
> +\item \ref{devicenormative:Device Types / ISM Device / Device Initialization}
> +\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Alloc ISM Region}
> +\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Attach ISM Region}
> +\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Detach ISM Region}
> +\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Grant ISM Region}
> +\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Inform Event IRQ Vector}
> +\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Event Filter}
> +\end{itemize}
> +
>  \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
>  A conformant implementation MUST be either transitional or
>  non-transitional, see \ref{intro:Legacy
> diff --git a/content.tex b/content.tex
> index 96f4723..fe02aec 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -7545,6 +7545,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>  \input{virtio-scmi.tex}
>  \input{virtio-gpio.tex}
>  \input{virtio-pmem.tex}
> +\input{virtio-ism.tex}
>  
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>  
> diff --git a/virtio-ism.tex b/virtio-ism.tex
> new file mode 100644
> index 0000000..7f09c43
> --- /dev/null
> +++ b/virtio-ism.tex
> @@ -0,0 +1,472 @@
> +\section{ISM Device}\label{sec:Device Types / ISM Device}
> +
> +\begin{lstlisting}
> +|-------------------------------------------------------------------------------------------------------------|
> +| |------------------------------------------------|    |------------------------------------------------|    |
> +| | VM                      [M1]   [M2]   [M3]     |    | VM                             [M2]   [M3]     |    |
> +| |                          |      |      |       |    |                                 |      |       |    |
> +| |   -----------------------|------|------|---    |    |   ------------------------------|------|---    |    |
> +| |   |             driver   |      |      |  |    |    |   |             driver          |      |  |    |    |
> +| |   -----------------------|------|------|---    |    |   ------------------------------|------|---    |    |
> +| |    |cq|                  |map   |map   |map    |    |    |cq|                         |map   |map    |    |
> +| |    |  |                  |      |      |       |    |    |  |                         |      |       |    |
> +| |    |  |                -------------------     |    |    |  |                -------------------     |    |
> +| |----|--|----------------|  device memory  |-----|    |----|--|----------------|  device memory  |-----|    |
> +| |    |  |                -------------------     |    |    |  |                -------------------     |    |
> +| |                                |               |    |                                |               |    |
> +| |                                |               |    |                                |               |    |
> +| |                                |               |    |                                |               |    |
> +| |--------------------------------+---------------|    |--------------------------------+---------------|    |
> +|                                  |                                                       |                  |
> +|                                  |                                                       |                  |
> +|                                  |------------------------------+------------------------|                  |
> +|                                                                 |                                           |
> +|                                                                 |                                           |
> +|                                                   --------------------------                                |
> +|                                                    | M1 |   | M2 |   | M3 |                                 |
> +|                                                   --------------------------                                |
> +|                                                                                                             |
> +|                                                                                                             |
> +|-------------------------------------------------------------------------------------------------------------|
> +\end{lstlisting}
> +
> +ISM(Internal Shared Memory) device provides the ability to share memory between
> +different VMs launched from the same entity. A vm's memory got from ISM device
> +can be shared with multiple peers at the same time. This shared relationship can
> +be dynamically created and released.
> +
> +The contiguous shared memory obtained from the device is divided into multiple

Can we drop the requirement to be contiguous?

> +ism regions for share.
> +
> +ISM device provides a mechanism to notify other ism region referrers of events.
> +
> +
> +\subsection{Device ID}\label{sec:Device Types / ISM Device / Device ID}
> +	44
> +
> +\subsection{Virtqueues}\label{sec:Device Types / ISM Device / Virtqueues}
> +\begin{description}
> +\item[0] controlq
> +\item[1] eventq
> +\end{description}
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / ISM Device / Device configuration layout}
> +
> +\begin{lstlisting}
> +struct virtio_ism_config {
> +	le64 gid;
> +	le64 devid;
> +	le64 chunk_size;
> +	le64 notify_size;
> +};
> +\end{lstlisting> +
> +\begin{description}
> +    \item[\field{gid}] \field{gid} is used to identify different entity that
> +        launches the VMs. Only the ism devices with the same \field{gid} can
> +        share the ism regions. Therefore, this value is unique in the
> +        world-wide.
> +
> +    \item[\field{devid}] the device id is used to identify different ism devices
> +        on the same entity.
> +

In SMC-D the GID uniquely identifies the device so it would equal to your gid+devid.
This could be very confusing, could you chose another term for the hypervisor ID?
Instead of a Hipervisor ID that needs to be equal, ISM devices offer an operation to
query reachability of a remote GID. That could be a more generic option for virtio-ism as well.


> +    \item[\field{chunk_size}] the size of the every ism chunk.
> +        Large shared memories are divided into multiple chunks, and one time
> +        will take up at least one chunk.

Do you need to define maximum amount of chunks per region as well?

> +
> +    \item[\field{notify_size}] the size of the notify address.
> +\end{description}
> +
> +\devicenormative{\subsubsection}{Device configuration layout}{Device Types / ISM Device / Device configuration layout}
> +
> +The device MUST ensure that the \field{gid} on the same entity i
> +same and different from the \field{gid} on other entity.
> +

I am not sure I understand what you mean here. I think you say that the hipervisor ID
of this hipervisor must be different from the hipervisor ID of another hipervisor. Is that correct?

See also my comment above about SMC GID.

> +On the same entity, the device MUST ensure that the \field{devid} is unique.
> +
> +\field{chunk_size} MUST be a power of two.
> +
> +\subsection{Event}\label{sec:Device Types / Network Device / Device Operation / Event}


This subsection is labelled 'Device Types / Network Device / ' instead of 'Device Types / ISM Device / ',
is that intentional?

> +
> +\begin{lstlisting}
> +#define   VIRTIO_ISM_EVENT_UPDATE (1 << 0)
> +#define   VIRTIO_ISM_EVENT_ATTACH (1 << 1)
> +#define   VIRTIO_ISM_EVENT_DETACH (1 << 2)
> +\end{lstlisting}
> +
> +\begin{description}
> +    \item[VIRTIO_ISM_EVENT_UPDATE]
> +        The driver kick the notify area to notify other peers of the update
> +        event of the ism region content.
> +
> +    \item[VIRTIO_ISM_EVENT_ATTACH] A new device attaches the ism region.
> +    \item[VIRTIO_ISM_EVENT_DETACH] A device detaches the ism region.
> +\end{description}
> +
> +The ism device supports event notification of the ism region. When a device
> +kick/attach/detach a region, other ism region referrers may receive related
> +events.
> +
> +A buffer received from eventq can contain multiple event structures.
> +
> +\begin{lstlisting}
> +struct virtio_ism_event_update {
> +	le64 ev_type;
> +	le64 offset;
> +	le64 devid;
> +};
> +
> +struct virtio_ism_event_attach_detach {
> +	le64 ev_type;
> +	le64 offset;
> +	le64 devid;
> +	le64 peers;
> +};
> +
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{ev_type}] The type of event, the driver can get the size of the
> +    structure based on this.
> +
> +\item[\field{offset}] The offset of ism regions with the event.

Can we say that each region is identified by a token?
The offset inside a contiguous memory area can be one implementation of such a token,
but there may be other implementations, as long as it is unique per owner device.

Further down in 'Alloc ISM Region', you define that each region is identified by a token.
I assume the users identify it by token, is that correct?
These events are also delivered to the useres, correct? Then don't you
rather need the token, than the offset?

> +
> +\item[\field{devid}] \field{devid} of the device that generated events.
> +\item[\field{peers}] The number of the ism region referres (does not include the
> +    device that receiving this event)> +
> +\end{description}
> +
> +
> +\subsection{Permissions}\label{sec:Device Types / Network Device / Device Operation / Permission}

This subsection is labelled 'Device Types / Network Device / ' instead of 'Device Types / ISM Device / ',
is that intentional?

> +
> +The permissions of a ism region determine whether this ism region can be
> +attached and the read and write permissions after attach.
> +
> +The driver can set the default permissions, or set permissions for some certain
> +devices.

This sentence is not fully clear to me, see comment below.

> +
> +When a driver has the management permission of the ism region, then it can
> +modify the permissions of this ism region. By default, only the device that
> +allocated the ism region has this permission.
> +

Do I understand correctly, that you mean: 'The driver of the device that owns
the region (allocated the region), can set permissions for user devices
to attach, read or write to that region'?


> +\subsection{Device Initialization}\label{sec:Device Types / ISM Device / Device Initialization}
> +
> +\devicenormative{\subsubsection}{Device Initialization}{Device Types / ISM Device / Device Initialization}
> +
> +The device MUST generate a \field{devid}. \field{devid} remains unchanged
> +during reset. \field{devid} MUST NOT be 0.
> +
> +The device shares memory to the driver based on shared memory regions
> +\ref{sec:Basic Facilities of a Virtio Device / Shared Memory Regions}.
> +However, it does not need to allocate physical memory during initialization.
> +
> +The \field{shmid} of a region MUST be one of the following
> +\begin{lstlisting}
> +enum virtio_ism_shm_id {
> +	VIRTIO_ISM_SHM_ID_UNDEFINED = 0,
> +	VIRTIO_ISM_SHM_ID_REGIONS   = 1,
> +	VIRTIO_ISM_SHM_ID_NOTIFY    = 2,
> +};
> +\end{lstlisting}
> +
> +The shared memory whose shmid is VIRTIO_ISM_SHM_ID_REGIONS is used to implement
> +ism regions. If there are multiple shared memories whose shmid is
> +VIRTIO_ISM_SHM_ID_REGIONS, they are used as contiguous memory in the order of
> +acquisition.
> +
> +The device MUST also provides a shared memory with VIRTIO_ISM_SHM_ID_NOTIFY to
> +the driver. This memory area is used for notify, and each ism region MUST have a
> +corresponding notify address inside this area, and the size of the notify
> +address is \field{notify_size};
> +
> +\drivernormative{\subsubsection}{Device Initialization}{Device Types / ISM Device / Device Initialization}
> +
> +The driver MUST query all shared memory regions supported by the device.
> +(see \ref{sec:Basic Facilities of a Virtio Device / Shared Memory Regions})
> +
> +
> +\subsection{Control Virtqueue}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue}
> +
> +The driver uses the control virtqueue send commands to implement operations on
> +the ism region and some global configurations.
> +
> +All commands are of the following form:
> +\begin{lstlisting}
> +struct virtio_ism_ctrl {
> +	u8 class;
> +	u8 command;
> +	u8 command_specific_data[];
> +	u8 ack;
> +	u8 command_specific_data_reply[];
> +};
> +
> +/* ack values */
> +#define VIRTIO_ISM_OK      0
> +#define VIRTIO_ISM_ERR     255
> +
> +#define VIRTIO_ISM_ENOENT  2
> +#define VIRTIO_ISM_E2BIG   7
> +#define VIRTIO_ISM_ENOMEM  12
> +#define VIRTIO_ISM_ENOSPEC 28
> +
> +#define VIRTIO_ISM_PERM_EATTACH 100
> +#define VIRTIO_ISM_PERM_EREAD   101
> +#define VIRTIO_ISM_PERM_EWRITE  102
> +\end{lstlisting}
> +
> +The \field{class}, \field{command} and command-specific-data are set by the
> +driver, and the device sets the \field{ack} byte and optionally
> +\field{command-specific-data-reply}.
> +
> +\subsection{Device Operation}  \label{sec:Device Types / ISM Driver / Device Operation}
> +
> +\subsubsection{Alloc ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Alloc ISM Region}
> +
> +Based on controlq, the driver can request an ism region to be allocated.
> +
> +The ism region obtained from the device will carry a token, which can be passed
> +to other VMs for attaching to this ism region.
> +
> +\begin{lstlisting}
> +struct virtio_ism_area {
> +	le64 offset;
> +	le64 size;
> +}
> +
> +struct virtio_ism_ctrl_alloc {
> +	le64 size;
> +};
> +
> +struct virtio_ism_ctrl_alloc_reply {
> +	le64 token;
> +	le64 num;
> +    struct virtio_ism_area area[];
> +};
> +
> +#define VIRTIO_ISM_CTRL_ALLOC  0
> +	#define VIRTIO_ISM_CTRL_ALLOC_REGION 0
> +\end{lstlisting}
> +
> +
> +\devicenormative{\subparagraph}{Alloc ISM Region}{Device Types / ISM Device / Device Operation / Alloc ISM Region}
> +
> +The device sets \field{ack} to VIRTIO_ISM_OK after successfully assigning the
> +physical ism region. At the same time, a new token MUST be dynamically created
> +for this ism region. \field{offset} is the location of this ism region in shared
> +memory.
> +
> +If there is no free chunk, the device MUST set \field{ack} to VIRTIO_ISM_NOSPEC.
> +
> +If new physical memory cannot be allocated, the device MUST set
> +\field{ack} to VIRTIO_ISM_NOMEM.
> +
> +The device MUST clear the new ism region before committing to the driver.
> +
> +If \field{size} is greater than \field{chunk_size}, this time the distribution
> +may occupy multiple chunks, then the device fills the offset and size of each
> +chunk into \field {offset} \field {size}.
> +
> +If \field{size} is smaller than \field{chunk_size}, the ism region also
> +occupies one chunk in the shared memory space.
> +
> +\field{num} is the number of the array \field{offset} and \field{size}.
> +
> +If virtio_ism_ctrl_alloc_reply is not enough, the device MUST set the \field{ack}
> +to VIRTIO_ISM_E2BIG.
> +
> +\drivernormative{\subparagraph}{Alloc ISM Region}{Device Types / ISM Device / Device Operation / Alloc ISM Region}
> +
> +After the alloc request is successful, the driver MUST only use the range
> +\field{offset} to \field{offset} + \field{size} - 1.
> +
> +\subsubsection{Attach ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Attach ISM Region}
> +
> +Based on controlq, the driver can request to attach an ism region with a
> +specified token.
> +
> +\begin{lstlisting}
> +struct virtio_ism_ctrl_attach {
> +	le64 token;
> +	le64 rw_perm;
> +};
> +
> +struct virtio_ism_ctrl_attach_reply {
> +	le64 num;
> +    struct virtio_ism_area area[];
> +};
> +
> +#define VIRTIO_ISM_CTRL_ATTACH  1
> +	#define VIRTIO_ISM_CTRL_ATTACH_REGION 0
> +\end{lstlisting}
> +\devicenormative{\subparagraph}{Attach ISM Region}{Device Types / ISM Device / Device Operation / Attach ISM Region}
> +
> +The device sets \field{ack} to VIRTIO_ISM_OK after successfully finding and
> +assigning the physical ism region. \field{offset} is the location of this ism
> +region in shared memory.
> +
> +If there is no free chunk, the device MUST set \field{ack} to VIRTIO_ISM_NOSPEC.
> +
> +If the ism region specified by \field{token} does not exist, the device MUST set
> +\field{ack} to VIRTIO_ISM_ENOENT.
> +
> +If the device does not has the VIRTIO_ISM_PERM_ATTACH, the device MUST set
> +\field{ack} to VIRTIO_ISM_PERM_EATTACH.
> +
> +If \field{rw_perm} include VIRTIO_ISM_PERM_READ, but the device does not
> + has the VIRTIO_ISM_PERM_READ for this region, the device MUST set \field{ack}
> + to VIRTIO_ISM_PERM_EREAD.
> +
> +If \field{rw_perm} include VIRTIO_ISM_PERM_WRITE, but the device does not
> + has the VIRTIO_ISM_PERM_WRITE for this region, the device MUST set \field{ack}
> + to VIRTIO_ISM_PERM_EWRITE.
> +
> +The device MUST set the read and write permissions of the physical memory based on
> +\field{rw_perm}.
> +
> +If \field{size} is greater than \field{chunk_size}, this time the distribution
> +may occupy multiple chunks, and the offset and size of each chunk fill in
> +\field {offset} \field {size}.
> +
> +If \field{size} is smaller than \field{chunk_size}, the ism region also
> +occupies \field{chunk_size} in the shared memory space.
> +
> +\field{num} is the number of the array \field{offset} and \field{size}.
> +
> +If virtio_ism_ctrl_alloc_reply is not enough, the device MUST set the \field{ack}
> +to VIRTIO_ISM_E2BIG and set the \field{num} for next request.
> +
> +\subsubsection{Detach ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Detach ISM Region}
> +Based on controlq, the device can release references to the ism region.
> +
> +\begin{lstlisting}
> +struct virtio_ism_ctrl_detach {
> +	le64 token;
> +};
> +
> +#define VIRTIO_ISM_CTRL_DETACH  2
> +	#define VIRTIO_ISM_CTRL_DETACH_REGION 0
> +\end{lstlisting}
> +
> +\devicenormative{\subparagraph}{Detach ISM Region}{Device Types / ISM Device / Device Operation / Detach ISM Region}
> +
> +If the ism region specified by \field{token} is not attached, the device MUST set
> +\field{ack} to VIRTIO_ISM_ENOENT.
> +
> +The device MUST release the physical memory of this ism region.
> +
> +\subsubsection{Grant ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Grant ISM Region}
> +Based on controlq, the driver can set the permissions for each ism
> +region.
> +
> +\begin{lstlisting}
> +struct virtio_ism_ctrl_grant_default {
> +	le64 token;
> +	le64 permissions;
> +};
> +
> +struct virtio_ism_ctrl_grant {
> +	le64 token;
> +	le64 permissions;
> +	le64 peer_devid;
> +};
> +
> +#define VIRTIO_ISM_CTRL_GRANT  3
> +	#define VIRTIO_ISM_CTRL_GRANT_SET_DEFAULT    0
> +	#define VIRTIO_ISM_CTRL_GRANT_SET_FOR_DEVICE 1
> +
> +#define VIRTIO_ISM_PERM_READ       (1 << 0)
> +#define VIRTIO_ISM_PERM_WRITE      (1 << 1)
> +
> +#define VIRTIO_ISM_PERM_ATTACH     (1 << 2)
> +
> +#define VIRTIO_ISM_PERM_MANAGE     (1 << 3)
> +#define VIRTIO_ISM_PERM_CLEAN_DEFAULT     (1 << 4)
> +
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[VIRTIO_ISM_PERM_READ] read permission
> +\item[VIRTIO_ISM_PERM_WRITE] write permission
> +\item[VIRTIO_ISM_PERM_ATTACH] attach permission
> +
> +\item[VIRTIO_ISM_PERM_MANAGE] Management permission, the device with this
> +	permission can modify the permission of this ism region. By default, only
> +	the device that allocated the region has this permission.
> +
> +\item[VIRTIO_ISM_PERM_DENY_DEFAULT] Clean all permissions of default, just used
> +    with VIRTIO_ISM_CTRL_GRANT_SET_FOR_DEVICE.
> +
> +\end{description}
> +
> +Permission control is divided into two categories, one is the permission for the
> +specified device, and the other is the default permission.
> +
> +\devicenormative{\subparagraph}{Grant ISM Region}{Device Types / ISM Device / Device Operation / Grant ISM Region}
> +
> +If the ism region specified by \field{token} is not attached, the device MUST set
> +\field{ack} to VIRTIO_ISM_ENOENT.
> +
> +The device MUST respond to the driver's request based on the permissions the
> +device has.
> +
> +The default permissions of the newly allocated ism region MUST be VIRTIO_ISM_PERM_READ | VIRTIO_ISM_PERM_WRITE | VIRTIO_ISM_PERM_ATTACH.
> +The device that allocated the ism region MUST has the perm (VIRTIO_ISM_PERM_READ | VIRTIO_ISM_PERM_WRITE | VIRTIO_ISM_PERM_ATTACH | VIRTIO_ISM_PERM_MANAGE) for this region.
> +
> +\subsubsection{Inform Update Event IRQ Vector}\label{sec:Device Types / ISM Device / Device Operation / Inform Update Event IRQ Vector}
> +
> +For the region update event, the driver can choose to bind a interrupt for
> +region. If successful, then this region's update event will no longer pass
> +through eventq, but the interrupt of the binding is directly triggered.
> +
> +\begin{lstlisting}
> +struct virtio_ism_ctrl_irq_vector {
> +	le64 token;
> +	le64 vector;
> +};
> +
> +#define VIRTIO_ISM_CTRL_EVENT_VECTOR  4
> +	#define VIRTIO_ISM_CTRL_EVENT_VECTOR_SET 0
> +\end{lstlisting}
> +
> +
> +\devicenormative{\subparagraph}{Inform Event IRQ Vector}{Device Types / ISM Device / Device Operation / Inform Event IRQ Vector}
> +
> +The device MUST record the relationship between the ism region and the vector
> +notified by the driver, and notify the update event of this region to driver
> +by the corresponding vector.
> +
> +
> +\subsubsection{Events Filter}\label{sec:Device Types / ISM Device / Device Operation / Event Filter}
> +
> +The driver can filter the event to choose which events to receive. The driver
> +can set the default filter for all regions, or set filter for some specified ism
> +regions.
> +
> +\begin{lstlisting}
> +struct virtio_ism_ctrl_events_filter_def {
> +	le64 ev_type;
> +};
> +
> +struct virtio_ism_ctrl_events_filter {
> +	le64 ev_type;
> + 	le64 token;
> +};
> +
> +#define VIRTIO_ISM_CTRL_EVENTS_FILTER  5
> +	#define VIRTIO_ISM_CTRL_EVENTS_FILTER_SET_DEFAULT 0
> +	#define VIRTIO_ISM_CTRL_EVENTS_FILTER_SET_REGION  1
> +\end{lstlisting}
> +
> +The \field{ev_type} is a bitmask. See \ref{sec:Device Types / Network Device / Device Operation / Event}
> +
> +\devicenormative{\subparagraph}{Events Filter}{Device Types / ISM Device / Device Operation / Event Filter}
> +
> +After initialization of reset, the default \field{ev_type} MUST be VIRTIO_ISM_EVENT_UPDATE.
> +
> +The modification of the driver for the default events filter MUST NOT affect the region
> +with a separate events filter.
> +
> +
> +
> +

