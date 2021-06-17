Return-Path: virtio-comment-return-1905-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Date: Thu, 17 Jun 2021 11:41:22 +0200
Message-Id: <20210617094122.1627-2-info@metux.net>
In-Reply-To: <20210617094122.1627-1-info@metux.net>
References: <20210617094122.1627-1-info@metux.net>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH] virtio-gpio: add formal specification
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

This patch adds specification for attaching general purpose IO (gpio) devic=
es
via virtio. The protocol is specifically designed to be easily implemented =
in
software (e.g. hypervisors) as well as low end hardware (eg. silicon, FPGA,
tiny MCUs) and allows future extensions while retaining full backwards
compatibility.

Implementations for driver (Linux kernel) and device (Qemu) are publically
available and field tested since late 2020. Hardware implementations also
exist (but proprietary, cannot be published yet).

Device type ID 41 has been allocated by TC vote #3632.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 conformance.tex |  28 +++++-
 content.tex     |   3 +
 virtio-gpio.tex | 259 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 286 insertions(+), 4 deletions(-)
 create mode 100644 virtio-gpio.tex

diff --git a/conformance.tex b/conformance.tex
index a164cbb..e5956f4 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -29,8 +29,9 @@ \section{Conformance Targets}\label{sec:Conformance / Con=
formance Targets}
 \ref{sec:Conformance / Driver Conformance / IOMMU Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / Sound Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
-\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance=
} or
-\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance}.
+\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance=
},
+\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance} or
+\ref{sec:Conformance / Driver Conformance / General Purpose IO Driver Conf=
ormance}.
=20
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Dev=
ice and Transitional Driver Conformance}.
   \end{itemize}
@@ -52,8 +53,9 @@ \section{Conformance Targets}\label{sec:Conformance / Con=
formance Targets}
 \ref{sec:Conformance / Device Conformance / IOMMU Device Conformance},
 \ref{sec:Conformance / Device Conformance / Sound Device Conformance},
 \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
-\ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance=
} or
-\ref{sec:Conformance / Device Conformance / SCMI Device Conformance}.
+\ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance=
},
+\ref{sec:Conformance / Device Conformance / SCMI Device Conformance} or
+\ref{sec:Conformance / Device Conformance / General Purpose IO Device Conf=
ormance}.
=20
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Dev=
ice and Transitional Driver Conformance}.
   \end{itemize}
@@ -288,6 +290,15 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \item \ref{drivernormative:Device Types / SCMI Device / Device Operation /=
 Setting Up eventq Buffers}
 \end{itemize}
=20
+\conformance{\subsection}{General Purpose IO Driver Conformance}\label{sec=
:Conformance / Driver Conformance / General Purpose IO Driver Conformance}
+
+An General Purpose IO driver MUST conform to the following normative state=
ments:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / General Purpose IO / Virtqueues}
+\item \ref{devicenormative:Device Types / General Purpose IO / Data flow}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device =
Conformance}
=20
 A device MUST conform to the following normative statements:
@@ -527,6 +538,15 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}
 \item \ref{devicenormative:Device Types / SCMI Device / Device Operation /=
 Shared Memory Operation}
 \end{itemize}
=20
+\conformance{\subsection}{General Purpose IO Device Conformance}\label{sec=
:Conformance / Device Conformance / General Purpose IO Device Conformance}
+
+An General Purpose IO device MUST conform to the following normative state=
ments:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / General Purpose IO / Virtqueues}
+\item \ref{devicenormative:Device Types / General Purpose IO / Data flow}
+\end{itemize}
+
 \conformance{\section}{Legacy Interface: Transitional Device and Transitio=
nal Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitio=
nal Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
diff --git a/content.tex b/content.tex
index 90685fc..3e9d1a1 100644
--- a/content.tex
+++ b/content.tex
@@ -2876,6 +2876,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 40         &   Bluetooth device \\
 \hline
+41         &   General Purpose IO device \\
+\hline
 \end{tabular}
=20
 Some of the devices above are unspecified by this document,
@@ -6581,6 +6583,7 @@ \subsubsection{Legacy Interface: Framing Requirements=
}\label{sec:Device
 \input{virtio-mem.tex}
 \input{virtio-i2c.tex}
 \input{virtio-scmi.tex}
+\input{virtio-gpio.tex}
=20
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
=20
diff --git a/virtio-gpio.tex b/virtio-gpio.tex
new file mode 100644
index 0000000..6ab0307
--- /dev/null
+++ b/virtio-gpio.tex
@@ -0,0 +1,259 @@
+\section{General Purpose IO Device}\label{sec:Device Types / General Purpo=
se IO}
+
+The virtio gpio device is a general purpose IO device that supports a vari=
able
+number of named IO lines that may be switched either as input or output an=
d
+in logical level 0 or 1.
+
+\subsection{Device ID}\label{sec:Device Types / General Purpose IO / Devic=
e ID}
+  41
+
+\subsection{Version}\label{sec:Device Types / General Purpose IO / Version=
}
+  1
+
+\subsection{Device configuration layout}\label{sec:Device Types / General =
Purpose IO / Device configuration layout}
+
+General purpose IO configuration uses the following layout structure:
+
+\begin{tabular}{|l|l|l|}
+    \hline
+    \textbf{Offset} & \textbf{Type} & \textbf{Description} \\
+    \hline
+    0x00   & u8           & version \\
+    0x02   & u16 LE       & number of GPIO lines \\
+    0x04   & u32 LE       & size of gpio name block \\
+    0x20   & char$[$32$]$ & device name (0-terminated) \\
+    0x40   & char$[$$]$   & line names block \\
+    \hline
+\end{tabular}
+
+\begin{itemize}
+    \item for \field{version} field currently only value 1 supported.
+    \item the \field{line names block} holds a stream of zero-terminated s=
trings,
+        containing the individual line names in ASCII. line names must uni=
que.
+    \item unspecified fields are reserved for future use and should be zer=
o.
+    \item future versions may extend this configuration space by additiona=
l fields.
+\end{itemize}
+
+\subsection{Virtqueues}\label{sec:Device Types / General Purpose IO / Virt=
queues}
+\begin{description}
+\item[0] rx (device to CPU)
+\item[1] tx (CPU to device)
+\end{description}
+
+The virtqueues transport messages of the type struct virtio_gpio_msg from =
device to CPU or CPU to device.
+
+\subsubsection{Virtqueues}\label{sec:Device Types / General Purpose IO / V=
irtqueues / Message format}
+
+The queues transport messages of the struct virtio_gpio_msg:
+
+\begin{tabular}{|l|l|l|}
+    \hline
+    \textbf{Offset} & \textbf{Type} & \textbf{Description} \\
+    \hline
+    0x00   & uint16 LE & message type  \\
+    0x02   & uint16 LE & line id       \\
+    0x04   & uint32 LE & value         \\
+    \hline
+\end{tabular}
+
+\subsubsection{Message types}\label{sec:Device Types / General Purpose IO =
/ Virtqueues / Message types}
+
+\begin{tabular}{|l|ll|}
+    \hline
+    \textbf{Code} & \textbf{Symbol} & \\
+    \hline
+    0x0001        & VIRTIO_GPIO_MSG_CPU_REQUEST            & request gpio =
line           \\
+    0x0002        & VIRTIO_GPIO_MSG_CPU_DIRECTION_INPUT    & set direction=
 to input      \\
+    0x0003        & VIRTIO_GPIO_MSG_CPU_DIRECTION_OUTPUT   & set direction=
 to output     \\
+    0x0004        & VIRTIO_GPIO_MSG_CPU_GET_DIRECTION      & read current =
direction      \\
+    0x0005        & VIRTIO_GPIO_MSG_CPU_GET_LEVEL          & read current =
level          \\
+    0x0006        & VIRTIO_GPIO_MSG_CPU_SET_LEVEL          & set current (=
out) level     \\
+    0x0011        & VIRTIO_GPIO_MSG_DEVICE_LEVEL           & level changed=
 (device->CPU) \\
+    \hline
+    0x8000        & VIRTIO_GPIO_MSG_REPLY                  & device reply =
mask           \\
+    \hline
+\end{tabular}
+
+\devicenormative{\subsubsection}{Virtqueues}{Device Types / General Purpos=
e IO / Virtqueues}
+
+The device MUST read from the tx queue and write to rx queue.
+
+The device MUST NOT write to the tx queue.
+
+\drivernormative{\subsubsection}{Virtqueues}{Device Types / General Purpos=
e IO / Virtqueues}
+
+The device MUST read from the rx queue and write to tx queue.
+
+The device MUST NOT write to the rx queue.
+
+\subsection{Data flow}\label{sec:Device Types / General Purpose IO / Data =
flow}
+
+\begin{itemize}
+    \item all operations, except \field{VIRTIO_GPIO_MSG_DEVICE_LEVEL}, are=
 initiated by CPU (tx queue)
+    \item device replies with the orinal \field{type} value OR'ed with \fi=
eld{VIRTIO_GPIO_MSG_REPLY} (rx queue)
+    \item requests are processed and replied in the they had been sent
+    \item async notifications by the device may be interleaved with reques=
t responses
+    \item VIRTIO_GPIO_MSG_DEVICE_LEVEL is only sent asynchronously from de=
vice to CPU
+    \item in replies, a negative \field{value} field denotes an Unix-style=
 / POSIX errno code
+    \item the actual error values \textit{(despite being negative or not)}=
 is only of informational
+          nature -- a device or vm host \textit{may} report more detailed =
error cause but is not required to.
+    \item valid direction values are: 0 =3D output, 1 =3D input
+    \item valid line level values are: 0 =3D inactive, 1 =3D active
+    \item CPU should not send messages with unspecified \field{type} value
+    \item CPU should ignore ignore messages with unspecified \field{type} =
value
+\end{itemize}
+
+
+\subsubsection{VIRTIO_GPIO_MSG_CPU_REQUEST}\label{sec:Device Types / Gener=
al Purpose IO / Data flow / VIRTIO_GPIO_MSG_CPU_REQUEST}
+
+Notify the device that given line number is going to be used.
+
+\begin{tabular}{ll}
+    \hline
+    \textbf{request:} & \\
+    \hline
+    \field{line}  field: & logical line number \\
+    \field{value} field: & unused (should be zero) \\
+    \textbf{reply:} & \\
+    \hline
+    \field{value} field: & POSIX errno code (0 =3D success, non-zero =3D e=
rror) \\
+    \hline
+\end{tabular}
+
+\subsubsection{VIRTIO_GPIO_MSG_CPU_DIRECTION_INPUT}\label{sec:Device Types=
 / General Purpose IO / Data flow / VIRTIO_GPIO_MSG_CPU_DIRECTION_INPUT}
+
+Set line line direction to input.
+
+\begin{tabular}{ll}
+    \hline
+    \textbf{request:} \\
+    \hline
+    \field{line}  field: & logical line number \\
+    \field{value} field: & unused (should be zero) \\
+    \hline
+    \textbf{reply:} & \\
+    \hline
+    \field{value} field: & POSIX errno code (0 =3D success, non-zero =3D e=
rror) \\
+    \hline
+\end{tabular}
+
+\subsubsection{VIRTIO_GPIO_MSG_CPU_DIRECTION_OUTPUT}\label{sec:Device Type=
s / General Purpose IO / Data flow / VIRTIO_GPIO_MSG_CPU_DIRECTION_OUTPUT}
+
+Set line direction to output and given line level.
+
+\begin{tabular}{ll}
+    \hline
+    \textbf{request:} \\
+    \hline
+    \field{line}  field: & logical line number \\
+    \field{value} field: & output level (0=3Dinactive, 1=3Dactive) \\
+    \hline
+    \textbf{reply:} & \\
+    \hline
+    \field{value} field: & POSIX errno code (0 =3D success, non-zero =3D e=
rror) \\
+    \hline
+\end{tabular}
+
+\subsubsection{VIRTIO_GPIO_MSG_CPU_GET_DIRECTION}\label{sec:Device Types /=
 General Purpose IO / Data flow / VIRTIO_GPIO_MSG_CPU_GET_DIRECTION}
+
+Retrieve line direction.
+
+\begin{tabular}{ll}
+    \hline
+    \textbf{request:} & \\
+    \hline
+    \field{line}  field: & logical line number \\
+    \field{value} field: & unused (should be zero) \\
+    \hline
+    \textbf{reply:} & \\
+    \hline
+    \field{value} field: & direction (0=3Doutput, 1=3Dinput) or POSIX errn=
o code \\
+    \hline
+\end{tabular}
+
+\subsubsection{VIRTIO_GPIO_MSG_CPU_GET_LEVEL}\label{sec:Device Types / Gen=
eral Purpose IO / Data flow / VIRTIO_GPIO_MSG_CPU_GET_LEVEL}
+
+Retrieve line level.
+
+\begin{tabular}{ll}
+    \hline
+    \textbf{request:} & \\
+    \hline
+    \field{line}  field: & logical line number \\
+    \field{value} field: & unused (should be zero) \\
+    \hline
+    \textbf{reply:} & \\
+    \hline
+    \field{value} field: & line level (0=3Dinactive, 1=3Dactive) or errno =
code \\
+    \hline
+\end{tabular}
+
+\subsubsection{VIRTIO_GPIO_MSG_CPU_SET_LEVEL}\label{sec:Device Types / Gen=
eral Purpose IO / Data flow / VIRTIO_GPIO_MSG_CPU_SET_LEVEL}
+
+Set line level (output only)
+
+\begin{tabular}{ll}
+    \hline
+    \textbf{request:} & \\
+    \hline
+    \field{line}  field: & logical line number \\
+    \field{value} field: & line level (0=3Dinactive, 1=3Dactive) \\
+    \hline
+    \textbf{reply:} & \\
+    \hline
+    \field{value} field: & new line level or (negative) POSIX errno code \=
\
+    \hline
+\end{tabular}
+
+\subsubsection{VIRTIO_GPIO_MSG_DEVICE_LEVEL}\label{sec:Device Types / Gene=
ral Purpose IO / Data flow / VIRTIO_GPIO_MSG_DEVICE_LEVEL}
+
+Async notification from device to CPU: line level changed
+
+\begin{tabular}{ll}
+    \hline
+    \textbf{request:} & \\
+    \hline
+    \field{line}  field: & logical line number \\
+    \field{value} field: & unused (should be zero) \\
+    \hline
+    \textbf{reply:} & \\
+    \field{value} field: & line level (0=3Dinactive, 1=3Dactive) \\
+    \hline
+\end{tabular}
+
+\devicenormative{\subsubsection}{Data flow}{Device Types / General Purpose=
 IO / Data flow}
+
+The device MUST reply to all driver requests in they had been sent.
+
+The device MUST copy the \field{line} field from the request to its reply.
+
+Except for async notification, the device MUST reply the orignal message t=
ype, but with the highest bit set
+(or'ed with VIRTIO_GPIO_MSG_REPLY)
+
+In case of error the device MUST fill an negative value into the \field{va=
lue} field, it SHOULD use
+an fitting POSIX / Unix errno value when applicable.
+
+On switching to output, the device SHOULD set internal output level before=
 switching the line to output.
+
+The device SHOULD send VIRTIO_GPIO_MSG_DEVICE_LEVEL message for a particul=
ar line when it is in input
+direction and line level changes.
+
+\drivernormative{\subsubsection}{Data flow}{Device Types / General Purpose=
 IO / Data flow}
+
+The driver MUST NOT send VIRTIO_GPIO_MSG_DEVICE_LEVEL and MUST NOT set the=
 highest bit in the message type.
+
+The driver MUST NOT send messages with types not defined in this specifica=
tion.
+
+\subsection{Future versions}\label{sec:Device Types / General Purpose IO /=
 Future versions}
+
+\begin{itemize}
+    \item future versions must increment the ``version`` value
+    \item the basic data structures (config space, message format) should =
remain
+          backwards compatible, but may increased in size or use reserved =
fields
+    \item device needs to support commands in older versions
+    \item CPU should not send commands of newer versions that the device d=
oesn't support
+\end{itemize}
+
+\subsection{Feature bits}\label{sec:Device Types / General Purpose IO / Fe=
ature bits}
+
+There are currently no feature bits defined for this device, but may be ad=
ded in future versions.
--=20
2.20.1


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

