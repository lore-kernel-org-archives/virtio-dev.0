Return-Path: <virtio-dev-return-9407-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EFED9986522
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Apr 2022 17:57:02 +0000 (UTC)
Message-ID: <ff8f0d82-d77e-560d-116b-67a8fa54d860@bytedance.com>
Date: Fri, 8 Apr 2022 18:56:59 +0100
MIME-Version: 1.0
References: <20220330152659.3780600-1-usama.arif@bytedance.com>
 <20220330152659.3780600-5-usama.arif@bytedance.com>
 <YkrtJy9dF/b5BtPR@stefanha-x1.localdomain>
From: Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <YkrtJy9dF/b5BtPR@stefanha-x1.localdomain>
Subject: [virtio-dev] Re: [PATCH 4/4] vhost-user: add vhost-user device type
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 04/04/2022 14:05, Stefan Hajnoczi wrote:
> On Wed, Mar 30, 2022 at 04:26:59PM +0100, Usama Arif wrote:
>> The vhost-user device backend facilitates vhost-user device emulation
>> through vhost-user protocol exchanges and access to shared memory.
>> Software-defined networking, storage, and other I/O appliances can
>> provide services through this device.
>>
>> This device is based on Wei Wang's vhost-pci work.  The virtio
>> vhost-user device differs from vhost-pci because it is a single virtio
>> device type that exposes the vhost-user protocol instead of a family of
>> new virtio device types, one for each vhost-user device type.
>>
>> This device supports vhost-user backend and vhost-user frontend
>> reconnection. It also contains a UUID so that vhost-user backend programs
>> can identify a specific device among many without using bus addresses.
>>
>> virtio-vhost-user makes use of additional resources introduced in earlier
>> patches including device aux. notifications, driver aux. notifications,
>> as well as shared memory.
>>
>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
>> ---
>>   conformance.tex       |  27 ++++-
>>   content.tex           |   3 +
>>   introduction.tex      |   3 +
>>   virtio-vhost-user.tex | 259 ++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 288 insertions(+), 4 deletions(-)
>>   create mode 100644 virtio-vhost-user.tex
>>
>> diff --git a/conformance.tex b/conformance.tex
>> index cddaf75..fab49c3 100644
>> --- a/conformance.tex
>> +++ b/conformance.tex
>> @@ -32,8 +32,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>   \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
>>   \ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance},
>>   \ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},
>> -\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance} or
>> -\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
>> +\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance},
>> +\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance} or
>> +\ref{sec:Conformance / Driver Conformance / Vhost-user Backend Driver Conformance}.
>>   
>>       \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
>>     \end{itemize}
>> @@ -58,8 +59,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>   \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
>>   \ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance},
>>   \ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
>> -\ref{sec:Conformance / Device Conformance / GPIO Device Conformance} or
>> -\ref{sec:Conformance / Device Conformance / PMEM Device Conformance}.
>> +\ref{sec:Conformance / Device Conformance / GPIO Device Conformance},
>> +\ref{sec:Conformance / Device Conformance / PMEM Device Conformance} or
>> +\ref{sec:Conformance / Device Conformance / Vhost-user Backend Device Conformance}.
>>   
>>       \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
>>     \end{itemize}
>> @@ -324,6 +326,15 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>   \item \ref{drivernormative:Device Types / PMEM Device / Device Initialization}
>>   \end{itemize}
>>   
>> +\conformance{\subsection}{Vhost-user Backend Driver Conformance}\label{sec:Conformance / Driver Conformance / Vhost-user Backend Driver Conformance}
>> +
>> +A vhost-user backend driver MUST conform to the following normative statements:
>> +
>> +\begin{itemize}
>> +\item \ref{drivernormative:Device Types / Vhost-user Device Backend / Device configuration layout}
>> +\item \ref{drivernormative:Device Types / Vhost-user Device Backend / Device Initialization}
>> +\end{itemize}
>> +
>>   \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
>>   
>>   A device MUST conform to the following normative statements:
>> @@ -595,6 +606,14 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>   \item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue return}
>>   \end{itemize}
>>   
>> +\conformance{\subsection}{Vhost-user Backend Device Conformance}\label{sec:Conformance / Device Conformance / Vhost-user Backend Device Conformance}
>> +
>> +A Vhost-user backend device MUST conform to the following normative statements:
>> +
>> +\begin{itemize}
>> +\item \ref{devicenormative:Device Types / Vhost-user Device Backend / Additional Device Resources / Shared Memory layout}
>> +\end{itemize}
>> +
>>   \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
>>   A conformant implementation MUST be either transitional or
>>   non-transitional, see \ref{intro:Legacy
>> diff --git a/content.tex b/content.tex
>> index 0fc50c4..8bf114d 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -3122,6 +3122,8 @@ \chapter{Device Types}\label{sec:Device Types}
>>   \hline
>>   42         &   RDMA device \\
>>   \hline
>> +43         &   vhost-user device backend \ \\
>> +\hline
>>   \end{tabular}
>>   
>>   Some of the devices above are unspecified by this document,
>> @@ -6878,6 +6880,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>>   \input{virtio-scmi.tex}
>>   \input{virtio-gpio.tex}
>>   \input{virtio-pmem.tex}
>> +\input{virtio-vhost-user.tex}
>>   
>>   \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>   
>> diff --git a/introduction.tex b/introduction.tex
>> index 6d52717..5bd1b95 100644
>> --- a/introduction.tex
>> +++ b/introduction.tex
>> @@ -79,6 +79,9 @@ \section{Normative References}\label{sec:Normative References}
>>   	\phantomsection\label{intro:SCMI}\textbf{[SCMI]} &
>>   	Arm System Control and Management Interface, DEN0056,
>>   	\newline\url{https://developer.arm.com/docs/den0056/c}, version C and any future revisions\\
>> +	\phantomsection\label{intro:Vhost-user Protocol}\textbf{[Vhost-user Protocol]}
>> +	& Vhost-user Protocol,
>> +	\newline\url{https://qemu.readthedocs.io/en/latest/interop/vhost-user.html}\\
>>   
>>   \end{longtable}
>>   
>> diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
>> new file mode 100644
>> index 0000000..303054f
>> --- /dev/null
>> +++ b/virtio-vhost-user.tex
>> @@ -0,0 +1,259 @@
>> +\section{Vhost-user Device Backend}\label{sec:Device Types / Vhost-user Device
>> +Backend}
>> +
>> +The vhost-user device backend facilitates vhost-user device emulation through
>> +vhost-user protocol exchanges and access to shared memory. Software-defined
>> +networking, storage, and other I/O appliances can provide services through this
>> +device.
>> +
>> +This section relies on definitions from the \hyperref[intro:Vhost-user
>> +Protocol]{Vhost-user Protocol}.  Knowledge of the vhost-user protocol is a
>> +prerequisite for understanding this device.
>> +
>> +The \hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol} was originally
>> +designed for processes on a single system communicating over UNIX domain
>> +sockets. The virtio vhost-user device backend allows the vhost-user backend to
>> +communicate with the vhost-user frontend over the device instead of a UNIX domain
>> +socket. This allows the backend and frontend to run on two separate systems such
>> +as a virtual machine and a hypervisor.
>> +
>> +The vhost-user backend program exchanges vhost-user protocol messages with the
>> +vhost-user frontend through this device. How the device implementation
>> +communicates with the vhost-user frontend is beyond the scope of this
>> +specification.  One possible device implementation uses a UNIX domain socket to
>> +relay messages to a vhost-user frontend process running on the same host.
>> +
>> +Existing vhost-user backend programs that communicate over UNIX domain sockets
>> +can support the virtio vhost-user device backend without invasive changes
>> +because the pre-existing vhost-user wire protocol is used.
>> +
>> +\subsection{Device ID}\label{sec:Device Types / Vhost-user Device Backend / Device ID}
>> +  43
>> +
>> +\subsection{Virtqueues}\label{sec:Device Types / Vhost-user Device Backend / Virtqueues}
>> +
>> +\begin{description}
>> +\item[0] rxq (device-to-driver vhost-user protocol messages)
>> +\item[1] txq (driver-to-device vhost-user protocol messages)
>> +\end{description}
>> +
>> +\subsection{Feature bits}\label{sec:Device Types / Vhost-user Device Backend / Feature bits}
>> +
>> +No feature bits are defined at this time.
>> +
>> +\subsection{Device configuration layout}\label{sec:Device Types / Vhost-user Device Backend / Device configuration layout}
>> +
>> +  All fields of this configuration are always available.
>> +
>> +\begin{lstlisting}
>> +struct virtio_vhost_user_config {
>> +        le32 status;
>> +#define VIRTIO_VHOST_USER_STATUS_BACKEND_UP (1 << 0)
>> +#define VIRTIO_VHOST_USER_STATUS_FRONTEND_UP (1 << 1)
>> +        le32 max_vhost_queues;
>> +        u8 uuid[16];
>> +};
>> +\end{lstlisting}
>> +
>> +\begin{description}
>> +\item[\field{status}] contains the vhost-user operational status.  The default
>> +    value of this field is 0.
>> +
>> +    The driver sets VIRTIO_VHOST_USER_STATUS_BACKEND_UP to indicate readiness for
>> +    the vhost-user frontend to connect.  The vhost-user frontend cannot connect
>> +    unless the driver has set this bit first.
>> +
>> +    The device sets VIRTIO_VHOST_USER_STATUS_FRONTEND_UP to indicate that the
>> +    vhost-user frontend is connected.
>> +
>> +    When the driver clears VIRTIO_VHOST_USER_STATUS_BACKEND_UP while the
>> +    vhost-user frontend is connected, the vhost-user frontend is disconnected.
>> +
>> +    When the vhost-user frontend disconnects, both
>> +    VIRTIO_VHOST_USER_STATUS_BACKEND_UP and VIRTIO_VHOST_USER_STATUS_FRONTEND_UP
>> +    are cleared by the device.  Communication can be restarted by the driver
>> +    setting VIRTIO_VHOST_USER_STATUS_BACKEND_UP again.
>> +
>> +    A configuration change notification is sent when the device changes
>> +    this field, unless a write to the field by the driver caused the change.
>> +
>> +\item[\field{max_vhost_queues}] is the maximum number of vhost-user queues
>> +    supported by this device.  This field is always greater than 0.
>> +
>> +\item[\field{uuid}] is the Universally Unique Identifier (UUID) for this
>> +    device. If the device has no UUID then this field contains the nil
>> +    UUID (all zeroes).  The UUID allows vhost-user backend programs to identify a
>> +    specific vhost-user device backend among many without relying on bus
>> +    addresses.
>> +\end{description}
>> +
>> +\drivernormative{\subsubsection}{Device configuration layout}{Device Types / Vhost-user Device Backend / Device configuration layout}
>> +
>> +The driver MUST NOT write to device configuration fields other than \field{status}.
>> +
>> +The driver MUST NOT set undefined bits in the \field{status} configuration field.
>> +
>> +\subsection{Device Initialization}\label{sec:Device Types / Vhost-user Device Backend / Device Initialization}
>> +
>> +The driver initializes the rxq/txq virtqueues and then it sets
>> +VIRTIO_VHOST_USER_STATUS_BACKEND_UP to the \field{status} field of the device
>> +configuration structure.
>> +
>> +\drivernormative{\subsubsection}{Device Initialization}{Device Types / Vhost-user Device Backend / Device Initialization}
>> +
>> +The driver SHOULD check the \field{max_vhost_queues} configuration field to
>> +determine how many queues the vhost-user backend will be able to support.
>> +
>> +The driver SHOULD fetch the \field{uuid} configuration field to allow
>> +vhost-user backend programs to identify a specific device among many.
>> +
>> +The driver SHOULD place at least one buffer in rxq before setting the
>> +VIRTIO_VHOST_USER_STATUS_BACKEND_UP bit in the \field{status} configuration field.
>> +
>> +The driver MUST handle rxq virtqueue notifications that occur before the
>> +configuration change notification.  It is possible that a vhost-user protocol
>> +message from the vhost-user frontend arrives before the driver has seen the
>> +configuration change notification for the VIRTIO_VHOST_USER_STATUS_FRONTEND_UP
>> +\field{status} change.
>> +
>> +\subsection{Device Operation}\label{sec:Device Types / Vhost-user Device Backend / Device Operation}
>> +
>> +Device operation consists of operating request queues and response queues.
>> +
>> +\subsubsection{Device Operation: Request Queues}\label{sec:Device Types / Vhost-user Device Backend / Device Operation / Device Operation: RX/TX Queues}
>> +
>> +The driver receives vhost-user protocol messages from the vhost-user frontend on
>> +rxq. The driver sends responses to the vhost-user frontend on txq.
>> +
>> +The driver sends backend-initiated requests on txq. The driver receives
>> +responses from the vhost-user frontend on rxq.
>> +
>> +All virtqueues offer in-order guaranteed delivery semantics for vhost-user
>> +protocol messages.
>> +
>> +Each buffer is a vhost-user protocol message as defined by the
>> +\hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol}.  In order to enable
>> +cross-endian communication, all message fields are little-endian instead of the
>> +native byte order normally used by the protocol.
>> +
>> +The appropriate size of rxq buffers is at least as large as the largest message
>> +defined by the \hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol}
>> +standard version that the driver supports.  If the vhost-user frontend sends a
>> +message that is too large for an rxq buffer, then DEVICE_NEEDS_RESET is set and
>> +the driver must reset the device.
>> +
>> +File descriptor passing is handled differently by the vhost-user device
>> +backend. When a frontend-initiated message is received that carries one or more file
>> +descriptors according to the vhost-user protocol, additional device resources
>> +become available to the driver.
>> +
>> +\subsection{Additional Device Resources}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources}
>> +
>> +The vhost-user device backend uses the following facilities from virtio device
>> +\ref{sec:Basic Facilities of a Virtio Device} for the vhost-user frontend and
>> +backend to exchange notifications and data through the device:
>> +
>> +\begin{description}
>> +  \item[Device auxiliary notification] \ref{sec:Basic Facilities of a Virtio Device / Notifications}
>> +The driver signals the vhost-user frontend through device auxiliary notifications. The signal does not
>> +carry any data, it is purely an event.
>> +  \item[Driver auxiliary notification] \ref{sec:Basic Facilities of a Virtio Device / Notifications}
>> +The vhost-user frontend signals the driver for events besides virtqueue activity
>> +and configuration changes by sending driver auxiliary notification.
>> +  \item[Shared memory] \ref{sec:Basic Facilities of a Virtio Device / Shared Memory Regions}
>> +The vhost-user frontend gives access to memory that can be mapped by the driver.
>> +\end{description}
>> +
>> +\subsubsection{Device auxiliary notifications}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources / Device auxiliary notifications}
>> +
>> +The vhost-user device backend provides all (or part) of the following device auxiliary notifications:
>> +
>> +\begin{description}
>> +\item[0] Vring call for vhost-user queue 0
>> +\item[\ldots]
>> +\item[N-1] Vring call for vhost-user queue N-1
>> +\item[N] Vring err for vhost-user queue 0
>> +\item[\ldots]
>> +\item[2N-1] Vring err for vhost-user queue N-1
>> +\item[2N] Log
>> +\end{description}
>> +
>> +where N is the number of the vhost-user virtqueues.
>> +
>> +\subsubsection{Driver auxiliary notifications}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources / Driver auxiliary notifications}
>> +
>> +The vhost-user device backend provides all (or part) of the following driver auxiliary notifications:
>> +
>> +\begin{description}
>> +\item[0] Vring kick for vhost-user queue 0
>> +\item[\ldots]
>> +\item[N-1] Vring kick for vhost-user queue N-1
>> +\end{description}
>> +
>> +where N is the number of the vhost-user virtqueues.
>> +
>> +\subsubsection{Shared Memory}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources / Shared Memory}
>> +
>> +The vhost-user device backend provides all (or part) of the following shared memory regions:
>> +
>> +\begin{description}
>> +\item[0] Vhost-user memory region 0
>> +\item[1] Vhost-user memory region 1
>> +\item[\ldots]
>> +\item[M-1] Vhost-user memory region M-1
>> +\item[M] Log memory region
>> +\end{description}
>> +
>> +where M is the total number of memory regions shared.
>> +
>> +\devicenormative{\paragraph}{Shared Memory layout}{Device Types / Vhost-user Device Backend / Additional Device Resources / Shared Memory layout}
>> +
>> +The device exports all memory regions reported by the vhost-user frontend as a
>> +single shared memory region \ref{sec:Basic Facilities of a Virtio Device /
>> +Shared Memory Regions} >
> This seems to contradict the list above where it shows "Vhost-user memory
> region 0", "Vhost-user memory region 1", etc as separate shared memory
> regions. Is it a single shared memory region or not?
> 


The shared memory section in v1 was unclear, I have hopefully improved 
the description in v2.
VHOST_USER_SET_MEM_TABLE has an array of memory regions that need to be 
mapped. In the case of VHOST_USER_SET_MEM_TABLE a single Shared Memory 
region exists in which the M-1 vhost-user memory region are 
consecutively mmaped.

I thought about the approach of using multiple shared memories, i.e. a 
shared-memory per vhost-user memory region and if it might be better to 
switch to that. However, I think this could not be practically 
implemented in PCI. Just adding the reasons here incase needed in future:
As the config space is 0x100, out of which, 0x40 is header space, it 
doesn't leave enough space for having a shared-memory capability per 
vhost-user memory region. After taking into account all the capabilities 
excluding shared-memory, i.e. ISR, device/driver aux. notification, 
device configuration, etc, there is only space for 4 virtio pci 
capabilities in the config space. This is much less than the 
VHOST_MEMORY_MAX_NREGIONS (8) and VHOST_USER_MAX_RAM_SLOTS (32) values 
currently in qemu.



>> +
>> +The size of this shared memory region exported by the device MUST be at least
>> +as much as the sum of the sizes of all the memory regions reported by the
>> +vhost-user frontend.
>> +
>> +The memory regions exported by the device MUST be laid out in the same order
>> +in which they are reported by the frontend with vhost-user messages.
>> +
>> +The offsets in which the memory regions are mapped inside the shared memory
>> +region MUST be the following:
>> +
>> +\begin{description}
>> +\item[0] Offset for vhost-user memory region 0
>> +\item[SIZE0] Offset for vhost-user memory region 1
>> +\item[\ldots]
>> +\item[SIZE0 + SIZE1 + \ldots] Offset for vhost-user memory region M
>> +\end{description}
>> +
>> +where SIZEi is the size of the vhost-user memory region i.
> 
> It's unclear to me how vhost-user's
> VHOST_USER_ADD_MEM_REG/VHOST_USER_REM_MEM_REG messages are handled. They
> are dynamic.
> 


I have made an attempt on adding about 
VHOST_USER_ADD_MEM_REG/VHOST_USER_REM_MEM_REG in v2.

I have tried to split it into when when 
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS is present and is not present:
- When the memory regions are mapped into the backend using the single 
VHOST_USER_SET_MEM_TABLE message, i.e. 
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS feature is not present, the 
same approach as v1 is used, i.e. the memory regions are consecutively 
available to the driver in the format

\begin{description}
     \item[0] Offset for vhost-user memory region 0
     \item[SIZE0] Offset for vhost-user memory region 1
     \item[\ldots]
     \item[SIZE0 + SIZE1 + \ldots] Offset for vhost-user memory region M - 1
     \end{description}

- When the memory regions are being mapped/unmapped using 
VHOST_USER_ADD_MEM_REG/VHOST_USER_REM_MEM_REG message, i.e. 
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS feature is negotiated a single 
  shared memory region is still used, however, the size as you said 
would  be dynamic.
I think there possibly could be multiple ways that the device and driver 
could deal with this?
I have mentioned in v2 how the device and driver would operate the 
shared memory in memory compaction. I have added this in the shared 
memory subsection but not in the devicenormative as maybe there might be 
multiple ways of dealing with fragmentation
that comes up and how its dealt with shouldn't be enforced in spec?

>> +
>> +\subsubsection{Availability of Additional Resources}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources / Availability of Additional Resources}
>> +
>> +The following vhost-user protocol messages convey access to additional device
>> +resources:
>> +
>> +\begin{description}
>> +\item[VHOST_USER_SET_MEM_TABLE] Contents of vhost-user memory regions are
>> +available to the driver as device memory. Region contents are laid out in the
> 
> s/as device memory/in Shared Memory Regions/ here and throughout this
> section. Let's use the spec's terminology instead of the more vague
> "device memory".
> 

Thanks, changed in v2 for both VHOST_USER_SET_MEM_TABLE and 
VHOST_USER_SET_LOG_BASE.

>> +same order as the vhost-user memory region list.
> 
> This refers to VHOST_USER_SET_MEM_TABLE but doesn't cover the
> VHOST_USER_ADD_MEM_REG/VHOST_USER_REM_MEM_REG messages >
I have added infromation about this in v2.

>> +\item[VHOST_USER_SET_LOG_BASE] Contents of the log memory region are available
>> +to the driver as device memory.
>> +\item[VHOST_USER_SET_LOG_FD] The log device auxiliary notification is available to the driver.
>> +Writes to the log device auxiliary notification before this message is received produce no effect.
>> +\item[VHOST_USER_SET_VRING_KICK] The vring kick notification for this queue is
>> +available to the driver. The first notification may occur before the driver has
>> +processed this message.
> 
> Maybe the spec can suggest how drivers should handle kicks that arrive
> before the corresponding VHOST_USER_SET_VRING_KICK message has been
> processed? Perhaps the vhost-user backend should ignore the unknown kick
> and peek at the vring when VHOST_USER_SET_VRING_ENABLE is processed.
> That way no kicks are lost.

Thanks! added this in v2.


Regards,
Usama

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

