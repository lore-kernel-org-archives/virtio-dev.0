Return-Path: <virtio-dev-return-9377-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E59D8986717
	for <virtio-dev@lists.oasis-open.org>; Wed, 30 Mar 2022 15:27:13 +0000 (UTC)
From: Usama Arif <usama.arif@bytedance.com>
Date: Wed, 30 Mar 2022 16:26:59 +0100
Message-Id: <20220330152659.3780600-5-usama.arif@bytedance.com>
In-Reply-To: <20220330152659.3780600-1-usama.arif@bytedance.com>
References: <20220330152659.3780600-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 4/4] vhost-user: add vhost-user device type
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
reconnection. It also contains a UUID so that vhost-user backend programs
can identify a specific device among many without using bus addresses.

virtio-vhost-user makes use of additional resources introduced in earlier
patches including device aux. notifications, driver aux. notifications,
as well as shared memory.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 conformance.tex       |  27 ++++-
 content.tex           |   3 +
 introduction.tex      |   3 +
 virtio-vhost-user.tex | 259 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 288 insertions(+), 4 deletions(-)
 create mode 100644 virtio-vhost-user.tex

diff --git a/conformance.tex b/conformance.tex
index cddaf75..fab49c3 100644
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
@@ -58,8 +59,9 @@ \section{Conformance Targets}\label{sec:Conformance / Con=
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
@@ -324,6 +326,15 @@ \section{Conformance Targets}\label{sec:Conformance / =
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
@@ -595,6 +606,14 @@ \section{Conformance Targets}\label{sec:Conformance / =
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
index 0fc50c4..8bf114d 100644
--- a/content.tex
+++ b/content.tex
@@ -3122,6 +3122,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 42         &   RDMA device \\
 \hline
+43         &   vhost-user device backend \ \\
+\hline
 \end{tabular}
=20
 Some of the devices above are unspecified by this document,
@@ -6878,6 +6880,7 @@ \subsubsection{Legacy Interface: Framing Requirements=
}\label{sec:Device
 \input{virtio-scmi.tex}
 \input{virtio-gpio.tex}
 \input{virtio-pmem.tex}
+\input{virtio-vhost-user.tex}
=20
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
=20
diff --git a/introduction.tex b/introduction.tex
index 6d52717..5bd1b95 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -79,6 +79,9 @@ \section{Normative References}\label{sec:Normative Refere=
nces}
 =09\phantomsection\label{intro:SCMI}\textbf{[SCMI]} &
 =09Arm System Control and Management Interface, DEN0056,
 =09\newline\url{https://developer.arm.com/docs/den0056/c}, version C and a=
ny future revisions\\
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
index 0000000..303054f
--- /dev/null
+++ b/virtio-vhost-user.tex
@@ -0,0 +1,259 @@
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
+Protocol]{Vhost-user Protocol}.  Knowledge of the vhost-user protocol is a
+prerequisite for understanding this device.
+
+The \hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol} was original=
ly
+designed for processes on a single system communicating over UNIX domain
+sockets. The virtio vhost-user device backend allows the vhost-user backen=
d to
+communicate with the vhost-user frontend over the device instead of a UNIX=
 domain
+socket. This allows the backend and frontend to run on two separate system=
s such
+as a virtual machine and a hypervisor.
+
+The vhost-user backend program exchanges vhost-user protocol messages with=
 the
+vhost-user frontend through this device. How the device implementation
+communicates with the vhost-user frontend is beyond the scope of this
+specification.  One possible device implementation uses a UNIX domain sock=
et to
+relay messages to a vhost-user frontend process running on the same host.
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
+        u8 uuid[16];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{status}] contains the vhost-user operational status.  The def=
ault
+    value of this field is 0.
+
+    The driver sets VIRTIO_VHOST_USER_STATUS_BACKEND_UP to indicate readin=
ess for
+    the vhost-user frontend to connect.  The vhost-user frontend cannot co=
nnect
+    unless the driver has set this bit first.
+
+    The device sets VIRTIO_VHOST_USER_STATUS_FRONTEND_UP to indicate that =
the
+    vhost-user frontend is connected.
+
+    When the driver clears VIRTIO_VHOST_USER_STATUS_BACKEND_UP while the
+    vhost-user frontend is connected, the vhost-user frontend is disconnec=
ted.
+
+    When the vhost-user frontend disconnects, both
+    VIRTIO_VHOST_USER_STATUS_BACKEND_UP and VIRTIO_VHOST_USER_STATUS_FRONT=
END_UP
+    are cleared by the device.  Communication can be restarted by the driv=
er
+    setting VIRTIO_VHOST_USER_STATUS_BACKEND_UP again.
+
+    A configuration change notification is sent when the device changes
+    this field, unless a write to the field by the driver caused the chang=
e.
+
+\item[\field{max_vhost_queues}] is the maximum number of vhost-user queues
+    supported by this device.  This field is always greater than 0.
+
+\item[\field{uuid}] is the Universally Unique Identifier (UUID) for this
+    device. If the device has no UUID then this field contains the nil
+    UUID (all zeroes).  The UUID allows vhost-user backend programs to ide=
ntify a
+    specific vhost-user device backend among many without relying on bus
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
+The driver initializes the rxq/txq virtqueues and then it sets
+VIRTIO_VHOST_USER_STATUS_BACKEND_UP to the \field{status} field of the dev=
ice
+configuration structure.
+
+\drivernormative{\subsubsection}{Device Initialization}{Device Types / Vho=
st-user Device Backend / Device Initialization}
+
+The driver SHOULD check the \field{max_vhost_queues} configuration field t=
o
+determine how many queues the vhost-user backend will be able to support.
+
+The driver SHOULD fetch the \field{uuid} configuration field to allow
+vhost-user backend programs to identify a specific device among many.
+
+The driver SHOULD place at least one buffer in rxq before setting the
+VIRTIO_VHOST_USER_STATUS_BACKEND_UP bit in the \field{status} configuratio=
n field.
+
+The driver MUST handle rxq virtqueue notifications that occur before the
+configuration change notification.  It is possible that a vhost-user proto=
col
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
+\hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol}.  In order to en=
able
+cross-endian communication, all message fields are little-endian instead o=
f the
+native byte order normally used by the protocol.
+
+The appropriate size of rxq buffers is at least as large as the largest me=
ssage
+defined by the \hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol}
+standard version that the driver supports.  If the vhost-user frontend sen=
ds a
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
ce auxiliary notifications:
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
er auxiliary notifications:
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
ed memory regions:
+
+\begin{description}
+\item[0] Vhost-user memory region 0
+\item[1] Vhost-user memory region 1
+\item[\ldots]
+\item[M-1] Vhost-user memory region M-1
+\item[M] Log memory region
+\end{description}
+
+where M is the total number of memory regions shared.
+
+\devicenormative{\paragraph}{Shared Memory layout}{Device Types / Vhost-us=
er Device Backend / Additional Device Resources / Shared Memory layout}
+
+The device exports all memory regions reported by the vhost-user frontend =
as a
+single shared memory region \ref{sec:Basic Facilities of a Virtio Device /
+Shared Memory Regions}.
+
+The size of this shared memory region exported by the device MUST be at le=
ast
+as much as the sum of the sizes of all the memory regions reported by the
+vhost-user frontend.
+
+The memory regions exported by the device MUST be laid out in the same ord=
er
+in which they are reported by the frontend with vhost-user messages.
+
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
+   =20
+where SIZEi is the size of the vhost-user memory region i.
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
+\item[VHOST_USER_SET_MEM_TABLE] Contents of vhost-user memory regions are
+available to the driver as device memory. Region contents are laid out in =
the
+same order as the vhost-user memory region list.
+\item[VHOST_USER_SET_LOG_BASE] Contents of the log memory region are avail=
able
+to the driver as device memory.
+\item[VHOST_USER_SET_LOG_FD] The log device auxiliary notification is avai=
lable to the driver.
+Writes to the log device auxiliary notification before this message is rec=
eived produce no effect.
+\item[VHOST_USER_SET_VRING_KICK] The vring kick notification for this queu=
e is
+available to the driver. The first notification may occur before the drive=
r has
+processed this message.
+\item[VHOST_USER_SET_VRING_CALL] The vring call device auxiliary notificat=
ion for this queue is
+available to the driver. Writes to the vring call device auxiliary notific=
ation before this message
+is received produce no effect.
+\item[VHOST_USER_SET_VRING_ERR] The vring err device auxiliary notificatio=
n for this queue is
+available to the driver. Writes to the vring err device auxiliary notifica=
tion before this message
+is received produce no effect.
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

