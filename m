Return-Path: <usama.arif@bytedance.com>
Message-ID: <8ca61a46-de7c-54b3-5bdb-0aa9b325dd57@bytedance.com>
Date: Thu, 11 Aug 2022 11:05:16 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] vhost-user: add vhost-user device type
References: <20220330152105.3770439-1-usama.arif@bytedance.com>
 <20220330152105.3770439-5-usama.arif@bytedance.com>
 <20220809154852-mutt-send-email-mst@kernel.org>
From: Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <20220809154852-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, stefanha@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 09/08/2022 21:06, Michael S. Tsirkin wrote:
> On Wed, Mar 30, 2022 at 04:21:05PM +0100, Usama Arif wrote:
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
> 
> Sorry about the delay in review.
> 
> 

Hi,

No worries, Thanks for the review!

I had sent a v2 
(https://lists.oasis-open.org/archives/virtio-dev/202204/msg00022.html) 
of the patch in April to address Stefans' comments, so it might be good 
to review that. I have replied inline below to the comments.

> 
> 
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
> 
> 
> So backend might disconnect by the time we check it's UP again?
> Seems racy, I suspect you need a handshake not unlike handshake.
> 

I am assuming over here you mean when vhost-user frontend disconnects.

I realized that there is no need for VIRTIO_VHOST_USER_STATUS_BACKEND_UP 
to be cleared when the frontend disconnects.
The backend driver can just stay connected to the backend device when 
the frontend disconnect. In the next revision, I can change the above 
paragraph to:

"When the vhost-user frontend disconnects, 
VIRTIO_VHOST_USER_STATUS_FRONTEND_UP is cleared by the device." (Nothing 
is done with VIRTIO_VHOST_USER_STATUS_BACKEND_UP)

I might have misunderstood, but I don't see a race condition or the 
advantage of a handshake connection when changed to above.
Do you mean handshake connection between the backend driver and backend 
device, or between the frontend and the backend device? Will there still 
be a race condition if we dont disconnect the backend driver when the 
frontend disconnects?


>> +
>> +\item[\field{max_vhost_queues}] is the maximum number of vhost-user queues
>> +    supported by this device.  This field is always greater than 0.
>> +
>> +\item[\field{uuid}] is the Universally Unique Identifier (UUID) for this
>> +    device. If the device has no UUID then this field contains the nil
>> +    UUID (all zeroes).  The UUID allows vhost-user backend programs to identify a
>> +    specific vhost-user device backend among many without relying on bus
>> +    addresses.
> 
> Why UUID specifically? Is there a need for them to be globally unique
> and not just within a VM? These are annoying to generate and maintain
> ...
> 
> 

That makes sense, no need for UUID, just need an ID unique within a VM. 
I will change it to just ID in next version.

> 
> 
>> +\end{description}
> 
> So feel this basically means that for frontend driver to attack to device
> backend driver must be up and responding to messages.
> I wonder whether we can make things a bit more robust
> by having backend driver send at least basic device
> config and feature bits to the vhost-user device
> at boot.
> 
> Of course device can request these itself if it wants to -
> so we do not need to change the spec for this, but maybe
> add an implementation note explaining this idea.
> 
> 

Yes, for the frontend to connect to backend device, the backend driver 
must be up.


In the prototype as well, the backend driver in DPDK does check if the 
virtio features are OK during init.

I will change the Device Initialization section below to:

The driver checks if the virtio features supported by it are provided by 
the device, initializes the rxq/txq virtqueues and then sets 
VIRTIO_VHOST_USER_STATUS_BACKEND_UP to the status field of the device 
configuration structure.

if that makes things better?

> 
> 
> 
> 
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
> 
> 
> I wonder how clear this is to the reader.
> 
> I feel maybe being more explicit is called for.
> For example explain that "u64" should be interpreted as "le64".
> 
> 

Will change to:
"all message fields are little-endian instead of the native byte order 
normally used by the protocol, i.e. u64 message fields are interpreted 
as le64"

if thats better?

> 
> 
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
>> +Shared Memory Regions}.
>> +
>> +The size of this shared memory region exported by the device MUST be at least
>> +as much as the sum of the sizes of all the memory regions reported by the
>> +vhost-user frontend.
>> +
>> +The memory regions exported by the device MUST be laid out in the same order
>> +in which they are reported by the frontend with vhost-user messages.
> 
> This is vague. The driver is the front end here, isn't it?
> Are you talking about the "Memory regions description" section
> in the vhost-user spec?
> 
> 

This section changed in v2, when Stefan suggested that this doesn't take 
into account VHOST_USER_ADD_MEM_REG/VHOST_USER_REM_MEM_REG. So might be 
better to re-review in v2.

In the document there are references to 3 things, the frontend (which is 
the same as the the frontend in vhost-user spec), the backend driver and 
the backend device. I see that I have just written driver/device in many 
places in this doc without prefixing with backend which might make 
things vague? I will prefix all driver/device instances in the doc with 
backend if it makes it better.

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
>> +
>> +\subsubsection{Availability of Additional Resources}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources / Availability of Additional Resources}
>> +
>> +The following vhost-user protocol messages convey access to additional device
>> +resources:
>> +
>> +\begin{description}
>> +\item[VHOST_USER_SET_MEM_TABLE] Contents of vhost-user memory regions are
>> +available to the driver as device memory. Region contents are laid out in the
>> +same order as the vhost-user memory region list.
>> +\item[VHOST_USER_SET_LOG_BASE] Contents of the log memory region are available
>> +to the driver as device memory.
>> +\item[VHOST_USER_SET_LOG_FD] The log device auxiliary notification is available to the driver.
>> +Writes to the log device auxiliary notification before this message is received produce no effect.
>> +\item[VHOST_USER_SET_VRING_KICK] The vring kick notification for this queue is
>> +available to the driver. The first notification may occur before the driver has
>> +processed this message.
>> +\item[VHOST_USER_SET_VRING_CALL] The vring call device auxiliary notification for this queue is
>> +available to the driver. Writes to the vring call device auxiliary notification before this message
>> +is received produce no effect.
>> +\item[VHOST_USER_SET_VRING_ERR] The vring err device auxiliary notification for this queue is
>> +available to the driver. Writes to the vring err device auxiliary notification before this message
>> +is received produce no effect.
>> +\item[VHOST_USER_SET_SLAVE_REQ_FD] The driver may send vhost-user protocol
>> +backend messages on txq. Backend-initiated messages put onto txq before this
>> +message is received are discarded by the device.
> 
> What about VHOST_USER_GET_INFLIGHT_FD?
> 
> Generally I worry that new versions of the protocol
> add new features without regard for this reuse.
> 
> Do we want to refer to a specific version of the spec maybe?
> 
> 

I think it would be a good idea to link to a specific version of 
vhost-user spec.

I didn't take into account VHOST_USER_GET_INFLIGHT_FD. From reading 
about it on the vhost-user spec now, it looks like another region is 
needed in shared memory layout for this.

The access to additional device resources will look the same for both 
get/set inflight_fd.

\item[VHOST_USER_GET_INFLIGHT_FD] Contents of the inflight memory region 
are available to the backend driver as backend device memory.
\item[VHOST_USER_SET_INFLIGHT_FD] Contents of the inflight memory region 
are available to the backend driver as backend device memory.

and we will need to add another region shared memory when referencing 
the v2 patch. i.e.

\begin{description}
\item[0] Vhost-user memory region 0
\item[1] Vhost-user memory region 1
\item[\ldots]
\item[M-2] Vhost-user memory region M-1
\item[M-1] Log memory region
\item[M] Inflight memory region
\end{description}


I will send these changes in v3 of the patch if this and the above 
comments look good.

Thanks!

> 
>> +\end{description}
>> -- 
>> 2.25.1
> 

