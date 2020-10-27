Return-Path: virtio-comment-return-1472-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Jie Deng <jie.deng@intel.com>
Date: Tue, 27 Oct 2020 14:00:24 +0800
Message-Id: <5d3d8a27893734be954ebbe560f638fbafb3429c.1603778046.git.jie.deng@intel.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v3] virtio-i2c: add the device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, Jie Deng <jie.deng@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

virtio-i2c is a virtual I2C adapter device. It provides a way
to =EF=AC=82exibly communicate with the I2C slave devices from the guest.

This patch adds the specification for this device.

Signed-off-by: Jie Deng <jie.deng@intel.com>
---
 conformance.tex | 28 ++++++++++++++---
 content.tex     |  1 +
 virtio-i2c.tex  | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 119 insertions(+), 4 deletions(-)
 create mode 100644 virtio-i2c.tex

diff --git a/conformance.tex b/conformance.tex
index f1f23a8..12bce3a 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -27,8 +27,10 @@ \section{Conformance Targets}\label{sec:Conformance / Co=
nformance Targets}
 \ref{sec:Conformance / Driver Conformance / Socket Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / RPMB Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / IOMMU Driver Conformance},
-\ref{sec:Conformance / Driver Conformance / Sound Driver Conformance} or
-\ref{sec:Conformance / Driver Conformance / Memory Driver Conformance}.
+\ref{sec:Conformance / Driver Conformance / Sound Driver Conformance}
+\ref{sec:Conformance / Driver Conformance / Memory Driver Conformance} or
+\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance=
}.
+
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Dev=
ice and Transitional Driver Conformance}.
   \end{itemize}
 \item[Device] A device MUST conform to four conformance clauses:
@@ -47,8 +49,10 @@ \section{Conformance Targets}\label{sec:Conformance / Co=
nformance Targets}
 \ref{sec:Conformance / Device Conformance / Socket Device Conformance},=20
 \ref{sec:Conformance / Device Conformance / RPMB Device Conformance},
 \ref{sec:Conformance / Device Conformance / IOMMU Device Conformance},
-\ref{sec:Conformance / Device Conformance / Sound Device Conformance} or
-\ref{sec:Conformance / Device Conformance / Memory Device Conformance}.
+\ref{sec:Conformance / Device Conformance / Sound Device Conformance}
+\ref{sec:Conformance / Device Conformance / Memory Device Conformance} or
+\ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance=
}.
+
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Dev=
ice and Transitional Driver Conformance}.
   \end{itemize}
 \end{description}
@@ -261,6 +265,14 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \item \ref{drivernormative:Device Types / Memory Device / Device Operation=
 / STATE request}
 \end{itemize}
=20
+\conformance{\subsection}{I2C Adapter Driver Conformance}\label{sec:Confor=
mance / Driver Conformance / I2C Adapter Driver Conformance}
+
+An I2C Adapter driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / I2C Adapter Device / Device Oper=
ation}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device =
Conformance}
=20
 A device MUST conform to the following normative statements:
@@ -477,6 +489,14 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \item \ref{devicenormative:Device Types / Memory Device / Device Operation=
 / STATE request}
 \end{itemize}
=20
+\conformance{\subsection}{I2C Adapter Device Conformance}\label{sec:Confor=
mance / Device Conformance / I2C Adapter Device Conformance}
+
+An I2C Adapter device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / I2C Adapter Device / Device Oper=
ation}
+\end{itemize}
+
 \conformance{\section}{Legacy Interface: Transitional Device and Transitio=
nal Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitio=
nal Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
diff --git a/content.tex b/content.tex
index 91855b4..95e2ed8 100644
--- a/content.tex
+++ b/content.tex
@@ -6200,6 +6200,7 @@ \subsubsection{Legacy Interface: Framing Requirements=
}\label{sec:Device
 \input{virtio-iommu.tex}
 \input{virtio-sound.tex}
 \input{virtio-mem.tex}
+\input{virtio-i2c.tex}
=20
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
=20
diff --git a/virtio-i2c.tex b/virtio-i2c.tex
new file mode 100644
index 0000000..96c96bf
--- /dev/null
+++ b/virtio-i2c.tex
@@ -0,0 +1,94 @@
+\section{I2C Adapter Device}\label{sec:Device Types / I2C Adapter Device}
+
+virtio-i2c is a virtual I2C adapter device. It provides a way to flexibly
+organize and manage I2C slave devices from the guest. By attaching ACPI
+I2C slave nodes to the virtual I2C adapter device, the guest can
+communicate with them without changing or adding extra drivers for these
+slave I2C devices.=20
+
+\subsection{Device ID}\label{sec:Device Types / I2C Adapter Device / Devic=
e ID}
+34
+
+\subsection{Virtqueues}\label{sec:Device Types / I2C Adapter Device / Virt=
queues}
+
+\begin{description}
+\item[0] requestq
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / I2C Adapter Device / Fe=
ature bits}
+
+None currently defined.
+
+\subsection{Device configuration layout}\label{sec:Device Types / I2C Adap=
ter Device / Device configuration layout}
+
+None currently defined.
+
+\subsection{Device Initialization}\label{sec:Device Types / I2C Adapter De=
vice / Device Initialization}
+
+\begin{enumerate}
+\item The virtqueue is initialized.
+\end{enumerate}
+
+\subsection{Device Operation}\label{sec:Device Types / I2C Adapter Device =
/ Device Operation}
+
+The driver queues requests to the virtqueue, and they are used by the
+device. The request is the representation of one segment of an I2C
+transaction. Each request is of form:
+
+\begin{lstlisting}
+struct virtio_i2c_req {
+        le16 addr;
+        le16 flags;
+        le16 len;
+        u8 buf[];
+        u8 status;
+};
+\end{lstlisting}
+
+The \field{addr} is the address of the I2C slave device.
+
+The first bit of \field{flags} indicates whether it is a read or write req=
uest.
+It means a read request if the first bit of \field{flags} is set, otherwis=
e
+it is a write request. The rest bits of \field{flags} are reserved.
+
+The \field{len} is the number of data bytes in the \field{buf} being read =
from or
+written to the I2C slave address.
+
+The \field{buf} of the request contains one segment of an I2C transaction.
+If the first bit of \field{flags} is '1', the \field{buf} is written by th=
e
+device and it contains one segment of an I2C transaction being read from t=
he
+device. If the first bit of \field{flags} is '0', the \field{buf} is writt=
en
+by the driver and it contains one segment of an I2C transaction being writ=
ten
+to the the device.
+
+The final \field{status} byte is written by the device: either VIRTIO_I2C_=
MSG_OK
+for success or VIRTIO_I2C_MSG_ERR for error.
+
+\begin{lstlisting}
+#define VIRTIO_I2C_MSG_OK     0
+#define VIRTIO_I2C_MSG_ERR    1
+\end{lstlisting}
+
+\drivernormative{\subsubsection}{Device Operation}{Device Types / I2C Adap=
ter Device / Device Operation}
+
+A driver MUST set \field{addr}, \field{flags} and \field{len} before sendi=
ng
+the request.
+
+A driver MUST place one segment of an I2C transaction into \field{buf} if =
the
+first bit of \field{flags} is '0'.
+
+A driver MUST NOT use \field{addr}, \field{flags}, \field{len} and \field{=
buf}
+if the final \field{status} returned from the device is VIRTIO_I2C_MSG_ERR=
.
+
+A driver MUST queue the requests in order if multiple requests are going t=
o
+be sent at a time.
+
+\devicenormative{\subsubsection}{Device Operation}{Device Types / I2C Adap=
ter Device / Device Operation}
+
+A device MUST NOT change the value of \field{addr}, \field{flags} and \fie=
ld{len}.
+
+A device MUST place one segment of an I2C transaction into \field{buf} if =
the first
+bit of \field{flags} is '1'.
+
+A device MUST guarantee the requests being handled in order if multiple re=
quests
+are received.
--=20
2.7.4


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

