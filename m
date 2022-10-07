Return-Path: <virtio-dev-return-10004-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4C66D986708
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Oct 2022 16:57:06 +0000 (UTC)
From: Usama Arif <usama.arif@bytedance.com>
Date: Fri,  7 Oct 2022 17:56:43 +0100
Message-Id: <20221007165643.3920613-5-usama.arif@bytedance.com>
In-Reply-To: <20221007165643.3920613-1-usama.arif@bytedance.com>
References: <20221007165643.3920613-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 4/4] vhost-user: add vhost-user device type
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, stefanha@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com, Usama Arif <usama.arif@bytedance.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The vhost-user device backend facilitates vhost-user device emulation
through vhost-user protocol exchanges and access to shared memory.
Software-defined networking, storage, and other I/O appliances can
provide services through this device.

This device is based on Wei Wang's vhost-pci work.  The virtio
vhost-user device differs from vhost-pci because it is a single virtio
device type that exposes the vhost-user protocol instead of a family of
new virtio device types, one for each vhost-user device type.

This device supports vhost-user backend and vhost-user frontend
reconnection. It also contains an ID so that vhost-user backend programs
can identify a specific device among many without using bus addresses.

virtio-vhost-user makes use of additional resources introduced in earlier
patches including device aux. notifications, driver aux. notifications,
as well as shared memory.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 conformance.tex       |  27 +++-
 content.tex           |   3 +
 introduction.tex      |   3 +
 virtio-vhost-user.tex | 309 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 338 insertions(+), 4 deletions(-)
 create mode 100644 virtio-vhost-user.tex

diff --git a/conformance.tex b/conformance.tex
index f6914b0..434cde3 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -32,8 +32,9 @@ \section{Conformance Targets}\label{sec:Conformance / Con=
formance Targets}
 \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance=
},
 \ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},
-\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance} or
-\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
+\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance},
+\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance} or
+\ref{sec:Conformance / Driver Conformance / Vhost-user Backend Driver Conf=
ormance}.
=20
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Dev=
ice and Transitional Driver Conformance}.
   \end{itemize}
@@ -59,8 +60,9 @@ \section{Conformance Targets}\label{sec:Conformance / Con=
formance Targets}
 \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
 \ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance=
},
 \ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
-\ref{sec:Conformance / Device Conformance / GPIO Device Conformance} or
-\ref{sec:Conformance / Device Conformance / PMEM Device Conformance}.
+\ref{sec:Conformance / Device Conformance / GPIO Device Conformance},
+\ref{sec:Conformance / Device Conformance / PMEM Device Conformance} or
+\ref{sec:Conformance / Device Conformance / Vhost-user Backend Device Conf=
ormance}.
=20
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Dev=
ice and Transitional Driver Conformance}.
   \end{itemize}
@@ -335,6 +337,15 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \item \ref{drivernormative:Device Types / PMEM Device / Device Initializat=
ion}
 \end{itemize}
=20
+\conformance{\subsection}{Vhost-user Backend Driver Conformance}\label{sec=
:Conformance / Driver Conformance / Vhost-user Backend Driver Conformance}
+
+A vhost-user backend driver MUST conform to the following normative statem=
ents:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Vhost-user Device Backend / Devi=
ce configuration layout}
+\item \ref{drivernormative:Device Types / Vhost-user Device Backend / Devi=
ce Initialization}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device =
Conformance}
=20
 A device MUST conform to the following normative statements:
@@ -623,6 +634,14 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \item \ref{devicenormative:Device Types / PMEM Device / Device Operation /=
 Virtqueue return}
 \end{itemize}
=20
+\conformance{\subsection}{Vhost-user Backend Device Conformance}\label{sec=
:Conformance / Device Conformance / Vhost-user Backend Device Conformance}
+
+A Vhost-user backend device MUST conform to the following normative statem=
ents:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / Vhost-user Device Backend / Addi=
tional Device Resources / Shared Memory layout}
+\end{itemize}
+
 \conformance{\section}{Legacy Interface: Transitional Device and Transitio=
nal Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitio=
nal Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
diff --git a/content.tex b/content.tex
index 8968fcd..5627ba1 100644
--- a/content.tex
+++ b/content.tex
@@ -3167,6 +3167,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 42         &   RDMA device \\
 \hline
+43         &   vhost-user device backend \ \\
+\hline
 \end{tabular}
=20
 Some of the devices above are unspecified by this document,
@@ -7028,6 +7030,7 @@ \subsubsection{Legacy Interface: Framing Requirements=
}\label{sec:Device
 \input{virtio-scmi.tex}
 \input{virtio-gpio.tex}
 \input{virtio-pmem.tex}
+\input{virtio-vhost-user.tex}
=20
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
=20
diff --git a/introduction.tex b/introduction.tex
index 287c5fc..c10f39c 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -98,6 +98,9 @@ \section{Normative References}\label{sec:Normative Refere=
nces}
 =09\phantomsection\label{intro:SEC1}\textbf{[SEC1]} &
     Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cur=
eve Cryptography'', Version 1.0, September 2000.
 =09\newline\url{https://www.secg.org/sec1-v2.pdf}\\
+=09\phantomsection\label{intro:Vhost-user Protocol}\textbf{[Vhost-user Pro=
tocol]}
+=09& Vhost-user Protocol,
+=09\newline\url{https://qemu.readthedocs.io/en/latest/interop/vhost-user.h=
tml}\\
=20
 \end{longtable}
=20
diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
new file mode 100644
index 0000000..9677760
--- /dev/null
+++ b/virtio-vhost-user.tex
@@ -0,0 +1,309 @@
+\section{Vhost-user Device Backend}\label{sec:Device Types / Vhost-user De=
vice
+Backend}
+
+The vhost-user device backend facilitates vhost-user device emulation thro=
ugh
+vhost-user protocol exchanges and access to shared memory. Software-define=
d
+networking, storage, and other I/O appliances can provide services through=
 this
+device.
+
+This section relies on definitions from the \hyperref[intro:Vhost-user
+Protocol]{Vhost-user Protocol}. Knowledge of the vhost-user protocol is a
+prerequisite for understanding this device.
+
+The \hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol} was original=
ly
+designed for processes on a single system communicating over UNIX domain
+sockets. The virtio vhost-user backend device and vhost-user backend
+driver together serve to implement the vhost-user backend. The backend dri=
ver
+communicates with the frontend via the backend device rather than using
+the UNIX domain socket directly. This allows the backend and frontend to r=
un on
+two separate systems such as a virtual machine and a hypervisor.
+
+Existing vhost-user backend programs that communicate over UNIX domain soc=
kets
+can support the virtio vhost-user device backend without invasive changes
+because the pre-existing vhost-user wire protocol is used.
+
+\subsection{Device ID}\label{sec:Device Types / Vhost-user Device Backend =
/ Device ID}
+  43
+
+\subsection{Virtqueues}\label{sec:Device Types / Vhost-user Device Backend=
 / Virtqueues}
+
+\begin{description}
+\item[0] rxq (device-to-driver vhost-user protocol messages)
+\item[1] txq (driver-to-device vhost-user protocol messages)
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / Vhost-user Device Backe=
nd / Feature bits}
+
+No feature bits are defined at this time.
+
+\subsection{Device configuration layout}\label{sec:Device Types / Vhost-us=
er Device Backend / Device configuration layout}
+
+  All fields of this configuration are always available.
+
+\begin{lstlisting}
+struct virtio_vhost_user_config {
+        le32 status;
+#define VIRTIO_VHOST_USER_STATUS_BACKEND_UP (1 << 0)
+#define VIRTIO_VHOST_USER_STATUS_FRONTEND_UP (1 << 1)
+        le32 max_vhost_queues;
+        u8 id[16];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{status}] contains the vhost-user operational status. The defa=
ult
+    value of this field is 0.
+
+    The driver sets VIRTIO_VHOST_USER_STATUS_BACKEND_UP to indicate readin=
ess for
+    the vhost-user frontend to connect. The vhost-user frontend cannot con=
nect
+    unless the driver has set this bit first.
+
+    When the vhost-user frontend connects, the device sets VIRTIO_VHOST_US=
ER_STATUS_FRONTEND_UP
+    to indicate it.
+
+    When the driver clears VIRTIO_VHOST_USER_STATUS_BACKEND_UP while the
+    vhost-user frontend is connected, the vhost-user frontend is disconnec=
ted.
+
+    When the vhost-user frontend disconnects, both
+    VIRTIO_VHOST_USER_STATUS_BACKEND_UP and VIRTIO_VHOST_USER_STATUS_FRONT=
END_UP
+    are cleared by the device. Communication can be restarted by the drive=
r
+    setting VIRTIO_VHOST_USER_STATUS_BACKEND_UP again.
+
+    A configuration change notification is sent when the device changes
+    this field, unless a write to the field by the driver caused the chang=
e.
+
+\item[\field{max_vhost_queues}] is the maximum number of vhost-user queues
+    supported by this device. This field is always greater than 0.
+
+\item[\field{id}] is the identifier for this device. If the device has no =
ID
+    then this field contains all zeroes. The ID allows vhost-user backend =
programs
+    to identify a specific vhost-user device backend among many without re=
lying on bus
+    addresses.
+\end{description}
+
+\drivernormative{\subsubsection}{Device configuration layout}{Device Types=
 / Vhost-user Device Backend / Device configuration layout}
+
+The driver MUST NOT write to device configuration fields other than \field=
{status}.
+
+The driver MUST NOT set undefined bits in the \field{status} configuration=
 field.
+
+\subsection{Device Initialization}\label{sec:Device Types / Vhost-user Dev=
ice Backend / Device Initialization}
+
+The driver checks if the virtio features supported by it are provided by t=
he device,
+initializes the rxq/txq virtqueues and then sets VIRTIO_VHOST_USER_STATUS_=
BACKEND_UP to
+the \field{status} field of the device configuration structure.
+
+\drivernormative{\subsubsection}{Device Initialization}{Device Types / Vho=
st-user Device Backend / Device Initialization}
+
+The driver SHOULD check the \field{max_vhost_queues} configuration field t=
o
+determine how many queues the vhost-user backend will be able to support.
+
+The driver SHOULD fetch the \field{id} configuration field to allow
+vhost-user backend programs to identify a specific device among many.
+
+The driver SHOULD place at least one buffer in rxq before setting the
+VIRTIO_VHOST_USER_STATUS_BACKEND_UP bit in the \field{status} configuratio=
n field.
+
+The driver MUST handle rxq virtqueue notifications that occur before the
+configuration change notification. It is possible that a vhost-user protoc=
ol
+message from the vhost-user frontend arrives before the driver has seen th=
e
+configuration change notification for the VIRTIO_VHOST_USER_STATUS_FRONTEN=
D_UP
+\field{status} change.
+
+\subsection{Device Operation}\label{sec:Device Types / Vhost-user Device B=
ackend / Device Operation}
+
+Device operation consists of operating request queues and response queues.
+
+\subsubsection{Device Operation: Request Queues}\label{sec:Device Types / =
Vhost-user Device Backend / Device Operation / Device Operation: RX/TX Queu=
es}
+
+The driver receives vhost-user protocol messages from the vhost-user front=
end on
+rxq. The driver sends responses to the vhost-user frontend on txq.
+
+The driver sends backend-initiated requests on txq. The driver receives
+responses from the vhost-user frontend on rxq.
+
+All virtqueues offer in-order guaranteed delivery semantics for vhost-user
+protocol messages.
+
+Each buffer is a vhost-user protocol message as defined by the
+\hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol}.
+
+The appropriate size of rxq buffers is at least as large as the largest me=
ssage
+defined by the \hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol}
+standard version that the driver supports. If the vhost-user frontend send=
s a
+message that is too large for an rxq buffer, then DEVICE_NEEDS_RESET is se=
t and
+the driver must reset the device.
+
+File descriptor passing is handled differently by the vhost-user device
+backend. When a frontend-initiated message is received that carries one or=
 more file
+descriptors according to the vhost-user protocol, additional device resour=
ces
+become available to the driver.
+
+\subsection{Additional Device Resources}\label{sec:Device Types / Vhost-us=
er Device Backend / Additional Device Resources}
+
+The vhost-user device backend uses the following facilities from virtio de=
vice
+\ref{sec:Basic Facilities of a Virtio Device} for the vhost-user frontend =
and
+backend to exchange notifications and data through the device:
+
+\begin{description}
+  \item[Device auxiliary notification] \ref{sec:Basic Facilities of a Virt=
io Device / Notifications}
+The driver signals the vhost-user frontend through device auxiliary notifi=
cations. The signal does not
+carry any data, it is purely an event.
+  \item[Driver auxiliary notification] \ref{sec:Basic Facilities of a Virt=
io Device / Notifications}
+The vhost-user frontend signals the driver for events besides virtqueue ac=
tivity
+and configuration changes by sending driver auxiliary notification.
+  \item[Shared memory] \ref{sec:Basic Facilities of a Virtio Device / Shar=
ed Memory Regions}
+The vhost-user frontend gives access to memory that can be mapped by the d=
river.
+\end{description}
+
+\subsubsection{Device auxiliary notifications}\label{sec:Device Types / Vh=
ost-user Device Backend / Additional Device Resources / Device auxiliary no=
tifications}
+
+The vhost-user device backend provides all (or part) of the following devi=
ce
+auxiliary notifications:
+
+\begin{description}
+\item[0] Vring call for vhost-user queue 0
+\item[\ldots]
+\item[N-1] Vring call for vhost-user queue N-1
+\item[N] Vring err for vhost-user queue 0
+\item[\ldots]
+\item[2N-1] Vring err for vhost-user queue N-1
+\item[2N] Log
+\end{description}
+
+where N is the number of the vhost-user virtqueues.
+
+\subsubsection{Driver auxiliary notifications}\label{sec:Device Types / Vh=
ost-user Device Backend / Additional Device Resources / Driver auxiliary no=
tifications}
+
+The vhost-user device backend provides all (or part) of the following driv=
er
+auxiliary notifications:
+
+\begin{description}
+\item[0] Vring kick for vhost-user queue 0
+\item[\ldots]
+\item[N-1] Vring kick for vhost-user queue N-1
+\end{description}
+
+where N is the number of the vhost-user virtqueues.
+
+\subsubsection{Shared Memory}\label{sec:Device Types / Vhost-user Device B=
ackend / Additional Device Resources / Shared Memory}
+
+The vhost-user device backend provides all (or part) of the following shar=
ed memory.
+The device MUST assign shmids' as per the following table:
+
+\begin{tabular}{|l|l|}
+  \hline
+  Virtio Vhost-user shared memory region & Virtio shmid \\
+  \hline \hline
+  Reserved (invalid) & 0 \\
+  \hline
+  Vhost-user memory & 1 \\
+  \hline
+  Log memory & 2 \\
+  \hline
+  Inflight memory & 3 \\
+  \hline
+  Reserved for future use & 4 and greater \\
+  \hline
+\end{tabular}
+
+The log memory is only available if VHOST_USER_PROTOCOL_F_LOG_SHMFD has be=
en
+been negotiated between the frontend and backend. Similarly, inflight memo=
ry
+is only available if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD has been negotia=
ted.
+
+When the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS protocol feature is not
+present, the vhost-user device backend provides the following vhost-user
+memory regions as a single shared memory region with shmid 1:
+
+\begin{description}
+\item[0] Vhost-user memory region 0
+\item[1] Vhost-user memory region 1
+\item[\ldots]
+\item[M-1] Vhost-user memory region M-1
+\end{description}
+
+where M is the total number of vhost-user memory regions that can be mappe=
d
+by the driver using the VHOST_USER_SET_MEM_TABLE protocol message.
+
+When the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS protocol feature has be=
en
+negotiated, the vhost-user device backend still provides all the vhost-use=
r
+memory regions as a single shared memory, however the number of vhost-user
+memory regions exported in the single shared memory is dynamic, i.e.
+VHOST_USER_ADD_MEM_REG message adds a vhost-user memory regions to the
+shared memory that can be mapped by the driver and VHOST_USER_REM_MEM_REG
+removes the region from the shared memory.
+One possible method the shared memory could be managed with is memory
+compaction. In this method, the device would remove the vhost-user memory
+region from the shared memory when VHOST_USER_REM_MEM_REG is received for =
the
+specific vhost-user memory region. When VHOST_USER_ADD_MEM_REG protocol
+message is received, the device would run memory compaction on the shared =
memory
+to remove any fragmentation caused by previously received VHOST_USER_REM_M=
EM_REG
+protocol messages before adding the new vhost-user memory region to the
+shared memory. The driver would then make the corresponding shifts in the =
mmap
+addresses of the shifted memory regions.
+
+\devicenormative{\paragraph}{Shared Memory layout}{Device Types / Vhost-us=
er Device Backend / Additional Device Resources / Shared Memory layout}
+
+The device exports all memory regions reported by the vhost-user frontend =
as a
+single shared memory\ref{sec:Basic Facilities of a Virtio Device /
+Shared Memory Regions}.
+
+The size of this shared memory exported by the device MUST be at least
+as much as the sum of the sizes of all the memory regions reported by the
+vhost-user frontend.
+
+When the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS protocol feature is not
+present, the vhost-user memory regions exported by the device MUST be laid=
 out
+contiguously in the same order in which they are reported by the frontend =
with
+vhost-user messages.
+The offsets in which the memory regions are mapped inside the shared memor=
y
+region MUST be the following:
+
+\begin{description}
+\item[0] Offset for vhost-user memory region 0
+\item[SIZE0] Offset for vhost-user memory region 1
+\item[\ldots]
+\item[SIZE0 + SIZE1 + \ldots] Offset for vhost-user memory region M
+\end{description}
+
+where SIZEi is the size of the vhost-user memory region i.
+
+When the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS protocol feature has be=
en
+negotiated, the memory regions exported by the device might not be contigu=
ously
+laid out.
+
+\subsubsection{Availability of Additional Resources}\label{sec:Device Type=
s / Vhost-user Device Backend / Additional Device Resources / Availability =
of Additional Resources}
+
+The following vhost-user protocol messages convey access to additional dev=
ice
+resources:
+
+\begin{description}
+\item[VHOST_USER_SET_MEM_TABLE] Contents of vhost-user memory regions are =
made
+available to the driver in the Shared Memory Region. Region contents are l=
aid out
+in the same order as the vhost-user memory region list.
+\item[VHOST_USER_ADD_MEM_REG] Contents of the vhost-user memory region are=
 made
+available to the driver in the Shared Memory Region.
+\item[VHOST_USER_REM_MEM_REG] Contents of the vhost-user memory region are=
 no
+longer available to the driver in the Shared Memory Region.
+\item[VHOST_USER_SET_LOG_BASE] Contents of the log memory region are avail=
able
+to the driver in the Shared Memory Region.
+\item[VHOST_USER_SET_LOG_FD] The log doorbell is available to the driver.
+Writes to the log doorbell before this message is received produce no effe=
ct.
+\item[VHOST_USER_GET_INFLIGHT_FD] Contents of the inflight memory region a=
re available
+in the Shared Memory Region.
+\item[VHOST_USER_SET_VRING_KICK] The vring kick notification for this queu=
e is
+available to the driver. The first notification may occur before the drive=
r has
+processed this message. If a kick arrives before the corresponding
+VHOST_USER_SET_VRING_KICK message has been processed, the vhost-user backe=
nd
+should ignore the unknown kick and peek at the vring when
+VHOST_USER_SET_VRING_ENABLE is processed.
+\item[VHOST_USER_SET_VRING_CALL] The vring call device auxiliary notificat=
ion
+for this queue is available to the driver. Writes to the vring call device
+auxiliary notification before this message is received produce no effect.
+\item[VHOST_USER_SET_VRING_ERR] The vring err device auxiliary notificatio=
n for
+this queue is available to the driver. Writes to the vring err device auxi=
liary
+notification before this message is received produce no effect.
+\item[VHOST_USER_SET_SLAVE_REQ_FD] The driver may send vhost-user protocol
+backend messages on txq. Backend-initiated messages put onto txq before th=
is
+message is received are discarded by the device.
+\end{description}
--=20
2.25.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

