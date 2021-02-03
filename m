Return-Path: virtio-comment-return-1706-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
Date: Wed,  3 Feb 2021 00:40:58 -0800
Message-Id: <20210203084058.1910930-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH] virtio-dmabuf: Add specification details for this device
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com, Vivek Kasireddy <vivek.kasireddy@intel.com>, Dongwon Kim <dongwon.kim@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The virtio dmabuf device provides a way to share a page backed dmabuf
created in the Guest with the Host. The actual sharing is accomplished
by recreating the dmabuf on the Host using the page metadata shared by
the guest.

Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 conformance.tex    |  30 ++++++++++--
 content.tex        |   3 ++
 virtio-vdmabuf.tex | 120 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+), 4 deletions(-)
 create mode 100644 virtio-vdmabuf.tex

diff --git a/conformance.tex b/conformance.tex
index e78adfd..1f972ae 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -28,8 +28,9 @@ \section{Conformance Targets}\label{sec:Conformance / Con=
formance Targets}
 \ref{sec:Conformance / Driver Conformance / RPMB Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / IOMMU Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / Sound Driver Conformance}
-\ref{sec:Conformance / Driver Conformance / Memory Driver Conformance} or
-\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance=
}.
+\ref{sec:Conformance / Driver Conformance / Memory Driver Conformance}
+\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance=
} or
+\ref{sec:Conformance / Driver Conformance / Dmabuf Driver Conformance}.
=20
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Dev=
ice and Transitional Driver Conformance}.
   \end{itemize}
@@ -50,8 +51,9 @@ \section{Conformance Targets}\label{sec:Conformance / Con=
formance Targets}
 \ref{sec:Conformance / Device Conformance / RPMB Device Conformance},
 \ref{sec:Conformance / Device Conformance / IOMMU Device Conformance},
 \ref{sec:Conformance / Device Conformance / Sound Device Conformance}
-\ref{sec:Conformance / Device Conformance / Memory Device Conformance} or
-\ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance=
}.
+\ref{sec:Conformance / Device Conformance / Memory Device Conformance}
+\ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance=
} or
+\ref{sec:Conformance / Driver Conformance / Dmabuf Driver Conformance}.
=20
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Dev=
ice and Transitional Driver Conformance}.
   \end{itemize}
@@ -276,6 +278,16 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \item \ref{drivernormative:Device Types / I2C Adapter Device / Device Oper=
ation}
 \end{itemize}
=20
+\conformance{\subsection}{Dmabuf Driver Conformance}\label{sec:Conformance=
 / Driver Conformance / Dmabuf Driver Conformance}
+
+A Dmabuf driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Dmabuf Device / Device Operation=
 / VM ID}
+\item \ref{drivernormative:Device Types / Dmabuf Device / Device Operation=
 / Export}
+\item \ref{drivernormative:Device Types / Dmabuf Device / Device Operation=
 / Release}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device =
Conformance}
=20
 A device MUST conform to the following normative statements:
@@ -503,6 +515,16 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \item \ref{devicenormative:Device Types / I2C Adapter Device / Device Oper=
ation}
 \end{itemize}
=20
+\conformance{\subsection}{Dmabuf Device Conformance}\label{sec:Conformance=
 / Device Conformance / Dmabuf Device Conformance}
+
+A Dmabuf device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Dmabuf Device / Device Operation=
 / VM ID}
+\item \ref{drivernormative:Device Types / Dmabuf Device / Device Operation=
 / Export}
+\item \ref{drivernormative:Device Types / Dmabuf Device / Device Operation=
 / Release}
+\end{itemize}
+
 \conformance{\section}{Legacy Interface: Transitional Device and Transitio=
nal Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitio=
nal Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
diff --git a/content.tex b/content.tex
index 1ca24c1..b6ea383 100644
--- a/content.tex
+++ b/content.tex
@@ -2846,6 +2846,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 35         &   Watchdog \\
 \hline
+36         &   Dmabuf device \\
+\hline
 \end{tabular}
=20
 Some of the devices above are unspecified by this document,
@@ -6508,6 +6510,7 @@ \subsubsection{Legacy Interface: Framing Requirements=
}\label{sec:Device
 \input{virtio-sound.tex}
 \input{virtio-mem.tex}
 \input{virtio-i2c.tex}
+\input{virtio-vdmabuf.tex}
=20
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
=20
diff --git a/virtio-vdmabuf.tex b/virtio-vdmabuf.tex
new file mode 100644
index 0000000..18a4e2c
--- /dev/null
+++ b/virtio-vdmabuf.tex
@@ -0,0 +1,120 @@
+\section{Dmabuf Device}\label{sec:Device Types / Dmabuf Device}
+
+The virtio dmabuf device is a virtual dmabuf transfer device that provides
+a way to share a page-backed dmabuf created in the Guest with the device.
+Once shared, the driver and the device would use the same underlying memor=
y
+associated with the original dmabuf but not at the same time.
+
+\subsection{Device ID}\label{sec:Device Types / Dmabuf Device / Device ID}
+  36
+
+\subsection{Virtqueues}\label{sec:Device Types / Dmabuf Device / Virtqueue=
s}
+\begin{description}
+\item[0] recv
+\item[1] send
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / Dmabuf Device / Feature=
 bits}
+
+No specific feature bits defined for this device.
+
+\subsection{Device configuration layout}\label{sec:Device Types / Dmabuf D=
evice / Device configuration layout}
+
+No specific layout defined for this device.
+
+\subsection{Device Initialization}\label{sec:Device Types / Dmabuf Device =
/ Device Initialization}
+
+\begin{enumerate}
+\item Both the send and recv virtqueues are initialized to handle messages=
.
+\end{enumerate}
+
+\subsection{Device Operation}\label{sec:Device Types / Dmabuf Device / Dev=
ice Operation}
+
+Messages that are sent or received are of the following format:
+
+\begin{lstlisting}
+struct virtio_vdmabuf_msg {
+        le32 cmd;
+        le32 op[64];
+};
+\end{lstlisting}
+
+The field \field{cmd} is initialized with one of the following:
+
+\begin{lstlisting}
+enum virtio_vdmabuf_cmd {
+        VIRTIO_VDMABUF_CMD_NEED_VMID =3D 1,
+        VIRTIO_VDMABUF_CMD_EXPORT =3D 2,
+        VIRTIO_VDMABUF_CMD_DMABUF_REL =3D3,
+};
+\end{lstlisting}
+
+Based on the field \field{cmd}, the 256 bytes represented by the field
+\field{op} are either zeroed out or contain metadata. They are zeroed out
+if \field{cmd} is VIRTIO_VDMABUF_CMD_NEED_VMID. In other cases, the metada=
ta
+is formatted as below.
+
+The first 16 bytes contains a unique 128-bit Identifier of the following
+format:
+\begin{lstlisting}
+struct virtio_vdmabuf_buf_id_t{
+        le64 id;
+        le32 rng_key[2];
+};
+\end{lstlisting}
+
+The first 4 bytes of \field{id} contain an ID associated with the device a=
nd
+the other 4 bytes contain a counter. The last 8 bytes of the above structu=
re
+represented by \field{rng_key} contain random data to ensure that the 128-=
bit
+identifier is indeed unique at any given time.
+
+The remaining 240 bytes contain private data shared between the driver and
+the device.
+
+\subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Dmabuf Dev=
ice / Device Operation / Virtqueue Flow Control}
+
+The send virtqueue carries messages initiated by an application running in=
 the
+Guest and responses to previously sent messages. The recv virtqueue carrie=
s
+messages initiated by the device.
+
+\subsubsection{VM ID}\label{sec:Device Types / Dmabuf Device / Device Oper=
ation / VM ID}
+
+The driver sends a VM ID message to the device via the send virtqueue
+after setting the \field{cmd} to VIRTIO_VDMABUF_CMD_NEED_VMID.
+
+In response, the device would queue up a message on the recv virtqueue wit=
h
+the \field{cmd} set to VIRTIO_VDMABUF_CMD_NEED_VMID and the first 4 bytes =
of
+\field{op} containing the ID associated with the device.
+
+\drivernormative{\paragraph}{Device Operation: VM ID}{Device Types / Dmabu=
f Device / Device Operation / VM ID}
+
+The rest of the message MUST be zeroed out.
+
+\subsubsection{Export}\label{sec:Device Types / Dmabuf Device / Device Ope=
ration / Export}
+
+The driver sends an Export message to the device via the send virtqueue
+after populating the message as follows:
+
+\drivernormative{\paragraph}{Device Operation: Export}{Device Types / Dmab=
uf Device / Device Operation / Export}
+
+The driver MUST set \field{cmd} to VIRTIO_VDMABUF_CMD_EXPORT.
+
+The driver MUST set the first 16 bytes of \field{op} to a new unique ID.
+
+The driver MUST populate the next 20 bytes of \field{op} with valid meta d=
ata
+associated with the buffer represented by the ID.
+
+\subsubsection{Release}\label{sec:Device Types / Dmabuf Device / Device Op=
eration / Release}
+
+The device sends a Release message to the driver via the recv virtqueue
+after populating the message as follows:
+
+\drivernormative{\paragraph}{Device Operation: Release}{Device Types / Dma=
buf Device / Device Operation / Release}
+
+The device MUST set \field{cmd} to VIRTIO_VDMABUF_CMD_RELEASE.
+
+The device MUST set the first 16 bytes of \field{op} to a valid unique ID
+that was previously shared by the driver.
+
+The device must zero out the remaining part of the message.
+
--=20
2.26.2


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

