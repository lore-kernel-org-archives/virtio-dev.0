Return-Path: virtio-dev-return-7575-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 976D8986080
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Jul 2020 16:45:52 +0000 (UTC)
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-2-ndragazis@arrikto.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20200518203721.7625-2-ndragazis@arrikto.com>
Date: Thu, 16 Jul 2020 17:45:47 +0100
Message-ID: <87v9inv26c.fsf@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v5 01/10] vhost-user: add vhost-user device
 type
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


Nikos Dragazis <ndragazis@arrikto.com> writes:

> From: Stefan Hajnoczi <stefanha@redhat.com>
>
> The vhost-user device backend facilitates vhost-user device emulation
> through vhost-user protocol exchanges and access to shared memory.
> Software-defined networking, storage, and other I/O appliances can
> provide services through this device.
>
> This device is based on Wei Wang's vhost-pci work.  The virtio
> vhost-user device differs from vhost-pci because it is a single virtio
> device type that exposes the vhost-user protocol instead of a family of
> new virtio device types, one for each vhost-user device type.
>
> This device supports vhost-user slave and vhost-user master
> reconnection.  It also contains a UUID so that vhost-user slave programs
> can identify a specific device among many without using bus addresses.
>
> It is somewhat unconventional for a virtio device because it makes use
> of additional resources called doorbells, notifications, and shared
> memory.  A mapping of these resources to the virtio PCI transport is
> provided.  Other transports, such as CCW may not be able to support
> this device.
>
> Cc: Wei Wang <wei.w.wang@intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  content.tex           |   3 +
>  introduction.tex      |   1 +
>  virtio-vhost-user.tex | 292 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 296 insertions(+)
>  create mode 100644 virtio-vhost-user.tex
>
> diff --git a/content.tex b/content.tex
> index 91735e3..9f3e86d 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2801,6 +2801,8 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  31         &   Video decoder device \\
>  \hline
> +28         &   vhost-user device backend \\
> +\hline
>  \end{tabular}
> =20
>  Some of the devices above are unspecified by this document,
> @@ -6062,6 +6064,7 @@ \subsubsection{Legacy Interface: Framing Requiremen=
ts}\label{sec:Device
>  \input{virtio-fs.tex}
>  \input{virtio-rpmb.tex}
>  \input{virtio-iommu.tex}
> +\input{virtio-vhost-user.tex}
> =20
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> =20
> diff --git a/introduction.tex b/introduction.tex
> index 33da3ec..9ef0aa7 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -66,6 +66,7 @@ \section{Normative References}\label{sec:Normative Refe=
rences}
>          \phantomsection\label{intro:eMMC}\textbf{[eMMC]} &
>          eMMC Electrical Standard (5.1), JESD84-B51,
>          \newline\url{http://www.jedec.org/sites/default/files/docs/JESD8=
4-B51.pdf}\\
> +=09\phantomsection\label{intro:Vhost-user Protocol}\textbf{[Vhost-user P=
rotocol]} & Vhost-user Protocol, \newline\url{https://git.qemu.org/?p=3Dqem=
u.git;a=3Dblob_plain;f=3Ddocs/interop/vhost-user.rst;hb=3DHEAD}, and any fu=
ture revisions\\
> =20
>  \end{longtable}
> =20
> diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
> new file mode 100644
> index 0000000..ac96dc2
> --- /dev/null
> +++ b/virtio-vhost-user.tex
> @@ -0,0 +1,292 @@
> +\section{Vhost-user Device Backend}\label{sec:Device Types / Vhost-user =
Device Backend}
> +
> +The vhost-user device backend facilitates vhost-user device emulation th=
rough
> +vhost-user protocol exchanges and access to shared memory.  Software-def=
ined
> +networking, storage, and other I/O appliances can provide services throu=
gh this
> +device.
> +
> +This section relies on definitions from the \hyperref[intro:Vhost-user
> +Protocol]{Vhost-user Protocol}.  Knowledge of the vhost-user protocol is=
 a
> +prerequisite for understanding this device.
> +
> +The \hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol} was origin=
ally
> +designed for processes on a single system communicating over UNIX domain
> +sockets.  The virtio vhost-user device backend allows the vhost-user sla=
ve to
> +communicate with the vhost-user master over the device instead of a UNIX=
 domain
> +socket.  This allows the slave and master to run on two separate
> systems such

I realise we already have the terms master/slave baked into the
vhost-user spec but perhaps we could find better wording? The vhost
documentation describes thing in terms of who owns the virtqueues (the
drive) and who processes the requests (the device). There may be better
terminology to use.

> +as a virtual machine and a hypervisor.

This implies type-2 setups, depending on where you define the
hypervisor. Could the language be extended: " or device in one virtual
machine with the driver operating in another"?

> +
> +The vhost-user slave program exchanges vhost-user protocol messages with=
 the
> +vhost-user master through this device.  How the device implementation
> +communicates with the vhost-user master is beyond the scope of this
> +specification.  One possible device implementation uses a UNIX domain so=
cket to
> +relay messages to a vhost-user master process running on the same host.
> +
> +Existing vhost-user slave programs that communicate over UNIX domain soc=
kets
> +can support the virtio vhost-user device backend without invasive change=
s
> +because the pre-existing vhost-user wire protocol is used.
> +
> +\subsection{Device ID}\label{sec:Device Types / Vhost-user Device Backen=
d / Device ID}
> +  28
> +
> +\subsection{Virtqueues}\label{sec:Device Types / Vhost-user Device Backe=
nd / Virtqueues}
> +
> +\begin{description}
> +\item[0] rxq (device-to-driver vhost-user protocol messages)
> +\item[1] txq (driver-to-device vhost-user protocol messages)
> +\end{description}
> +
> +\subsection{Feature bits}\label{sec:Device Types / Vhost-user Device Bac=
kend / Feature bits}
> +
> +No feature bits are defined at this time.
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / Vhost-=
user Device Backend / Device configuration layout}
> +
> +  All fields of this configuration are always available.
> +
> +\begin{lstlisting}
> +struct virtio_vhost_user_config {
> +        le32 status;
> +#define VIRTIO_VHOST_USER_STATUS_SLAVE_UP 0
> +#define VIRTIO_VHOST_USER_STATUS_MASTER_UP 1
> +        le32 max_vhost_queues;
> +        u8 uuid[16];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{status}] contains the vhost-user operational status.  The d=
efault
> +    value of this field is 0.
> +
> +    The driver sets VIRTIO_VHOST_USER_STATUS_SLAVE_UP to indicate readin=
ess for
> +    the vhost-user master to connect.  The vhost-user master cannot conn=
ect
> +    unless the driver has set this bit first.

I suspect some deployment diagrams are going to help here. Does this
imply that there is something in userspace connected to the slave kernel
ready to process messages or just that the driver in the kernel is ready
to accept messages?

> +
> +    When the driver clears VIRTIO_VHOST_USER_SLAVE_UP while the vhost-us=
er
> +    master is connected, the vhost-user master is disconnected.

What happens to messages in flight? Do they stay in the queues until
there is a re-connection?

> +
> +    When the vhost-user master disconnects, both
> +    VIRTIO_VHOST_USER_STATUS_SLAVE_UP and VIRTIO_VHOST_USER_STATUS_MASTE=
R_UP
> +    are cleared by the device.  Communication can be restarted by the dr=
iver
> +    setting VIRTIO_VHOST_USER_STATUS_SLAVE_UP again.
> +
> +    A configuration change notification is sent when the device changes
> +    this field unless a write to the field by the driver caused the chan=
ge.
> +
> +\item[\field{max_vhost_queues}] is the maximum number of vhost-user queu=
es
> +    supported by this device.  This field is always greater than 0.
> +
> +\item[\field{uuid}] is the Universally Unique Identifier (UUID) for this
> +    device.  If the device has no UUID then this field contains the nil
> +    UUID (all zeroes).  The UUID allows vhost-user slave programs to ide=
ntify a
> +    specific vhost-user device backend among many without relying on bus
> +    addresses.
> +\end{description}
> +
> +\drivernormative{\subsubsection}{Device configuration layout}{Device Typ=
es / Vhost-user Device Backend / Device configuration layout}
> +
> +The driver MUST NOT write to device configuration fields other than
> +\field{status}.
> +
> +The driver MUST NOT set undefined bits in the \field{status} configurati=
on field.
> +
> +\devicenormative{\subsection}{Device Initialization}{Device Types / Vhos=
t-user Device Backend / Device Initialization}
> +
> +The driver SHOULD check the \field{max_vhost_queues} configuration field=
 to
> +determine how many queues the vhost-user slave will be able to support.
> +
> +The driver SHOULD fetch the \field{uuid} configuration field to allow
> +vhost-user slave programs to identify a specific device among many.
> +
> +The driver SHOULD place at least one buffer in rxq before setting the
> +VIRTIO_VHOST_USER_SLAVE_UP bit in the \field{status} configuration
> field.

This is a buffer for use - not an initial message?

> +
> +The driver MUST handle rxq virtqueue notifications that occur before the
> +configuration change notification.  It is possible that a vhost-user pro=
tocol
> +message from the vhost-user master arrives before the driver has seen th=
e
> +configuration change notification for the VIRTIO_VHOST_USER_STATUS_MASTE=
R_UP
> +\field{status} change.
> +
> +\subsection{Device Operation}\label{sec:Device Types / Vhost-user Device=
 Backend / Device Operation}
> +
> +Device operation consists of operating request queues and response queue=
s.
> +
> +\subsubsection{Device Operation: Request Queues}\label{sec:Device Types =
/ Vhost-user Device Backend / Device Operation / Device Operation: Request =
Queues}
> +
> +The driver receives vhost-user protocol messages from the vhost-user mas=
ter on
> +rxq.  The driver sends responses to the vhost-user master on txq.
> +
> +The driver sends slave-initiated requests on txq.  The driver receives
> +responses from the vhost-user master on rxq.
> +
> +All virtqueues offer in-order guaranteed delivery semantics for vhost-us=
er
> +protocol messages.
> +
> +Each buffer is a vhost-user protocol message as defined by the
> +\hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol}.  In order to =
enable
> +cross-endian communication, all message fields are little-endian instead=
 of the
> +native byte order normally used by the protocol.
> +
> +The appropriate size of rxq buffers is at least as large as the largest =
message
> +defined by the \hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol}
> +standard version that the driver supports.  If the vhost-user master sen=
ds a
> +message that is too large for an rxq buffer then DEVICE_NEEDS_RESET is s=
et and
> +the driver must reset the device.
> +
> +File descriptor passing is handled differently by the vhost-user device
> +backend.  When a message is received that carries one or more file descr=
iptors
> +according to the vhost-user protocol, additional device resources become
> +available to the driver.
> +
> +\subsection{Additional Device Resources over PCI}\label{sec:Device Types=
 / Vhost-user Device Backend / Additional Device Resources over PCI}
> +
> +The vhost-user device backend contains additional device resources beyon=
d
> +configuration space and virtqueues.  The nature of these resources is
> +transport-specific and therefore only virtio transports that provide the=
se
> +resources support the vhost-user device backend.
> +
> +The following additional resources exist:
> +\begin{description}
> +  \item[Doorbells] The driver signals the vhost-user master through door=
bells.  The signal does not carry any data, it is purely an event.
> +  \item[Notifications] The vhost-user master signals the driver for even=
ts besides virtqueue activity and configuration changes by sending notifica=
tions.

What is the difference between a doorbell and a notification?

> +  \item[Shared memory] The vhost-user master gives access to memory that=
 can be mapped by the driver.
> +\end{description}
> +
> +\subsubsection{Doorbell Numbering}\label{sec:Device Types / Vhost-user D=
evice Backend / Additional Device Resources over PCI / Doorbell Numbering}
> +
> +Doorbells are laid out as follows:
> +
> +\begin{description}
> +\item[0] Vring call for vhost-user queue 0
> +\item[\ldots]
> +\item[N] Vring err for vhost-user queue 0
> +\item[\ldots]
> +\item[2N] Log
> +\end{description}
> +
> +\subsubsection{Notifications}\label{sec:Device Types / Vhost-user Device=
 Backend / Additional Device Resources over PCI / Notifications}
> +
> +Notifications are laid out as follows:
> +
> +\begin{description}
> +\item[0] Vring kick for vhost-user queue 0
> +\item[\ldots]
> +\item[N-1] Vring kick for vhost-user queue N-1
> +\end{description}
> +
> +\subsubsection{Shared Memory Layout}\label{sec:Device Types /
> Vhost-user Device Backend / Additional Device Resources over PCI /
> Shared Memory Layout}

These subsections seem to get renamed later in the series.

> +
> +Shared memory is laid out as follows:
> +
> +\begin{description}
> +\item[0] Vhost memory region 0
> +\item[SIZE0] Vhost memory region 1
> +\item[\ldots]
> +\item[SIZE0 + SIZE1 + \ldots] Log
> +\end{description}
> +
> +The size of vhost memory region 0 is \field{SIZE0}, the size of vhost me=
mory
> +region 1 is \field{SIZE1}, and so on.
> +
> +\subsubsection{Availability of Additional Resources}\label{sec:Device Ty=
pes / Vhost-user Device Backend / Additional Device Resources over PCI / Av=
ailability of Additional Resources}
> +
> +The following vhost-user protocol messages convey access to additional d=
evice
> +resources:
> +
> +\begin{description}
> +\item[VHOST_USER_SET_MEM_TABLE] Contents of vhost memory regions are ava=
ilable to the driver in shared memory.  Region contents are laid out in the=
 same order as the vhost memory region list.
> +\item[VHOST_USER_SET_LOG_BASE] Contents of the log are available to the =
driver in shared memory.
> +\item[VHOST_USER_SET_LOG_FD] The log doorbell is available to the driver=
.  Writes to the log doorbell before this message is received produce no ef=
fect.
> +\item[VHOST_USER_SET_VRING_KICK] The vring kick notification for this qu=
eue is available to the driver.  The first notification may occur before th=
e driver has processed this message.
> +\item[VHOST_USER_SET_VRING_CALL] The vring call doorbell for this queue =
is available to the driver.  Writes to the vring call doorbell before this =
message is received produce no effect.
> +\item[VHOST_USER_SET_VRING_ERR] The vring err doorbell for this queue is=
 available to the driver.  Writes to the vring err doorbell before this mes=
sage is received produce no effect.
> +\item[VHOST_USER_SET_SLAVE_REQ_FD] The driver may send vhost-user protoc=
ol slave messages on txq.  Buffers put onto txq before this message is rece=
ived are discarded by the device.
> +\end{description}
> +
> +Additional resources are configured on the virtio PCI transport by the f=
ollowing \field{struct virtio_pci_cap.cfg_type} values:
> +
> +\begin{lstlisting}
> +#define VIRTIO_PCI_CAP_DOORBELL_CFG 6
> +#define VIRTIO_PCI_CAP_NOTIFICATION_CFG 7
> +#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
> +\end{lstlisting}
> +
> +\subsubsection{Doorbell structure layout}\label{sec:Device Types / Vhost=
-user Device Backend / Additional Device Resources over PCI / Doorbell capa=
bility}
> +
> +The doorbell location is found using the VIRTIO_PCI_CAP_DOORBELL_CFG
> +capability.  This capability is immediately followed by an additional
> +field, like so:
> +
> +\begin{lstlisting}
> +struct virtio_pci_doorbell_cap {
> +        struct virtio_pci_cap cap;
> +        le32 doorbell_off_multiplier;
> +};
> +\end{lstlisting}

OK stuff is disappearing in later patches. Maybe it shouldn't be
introduced in the first place?

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

