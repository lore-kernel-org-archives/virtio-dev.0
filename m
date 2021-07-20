Return-Path: <viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V6 1/2] virtio-gpio: Add the device specification
Date: Tue, 20 Jul 2021 20:58:32 +0530
Message-Id: <199c624bd735782dd5d4a51e376f466f5c38ef2c.1626794843.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1626794843.git.viresh.kumar@linaro.org>
References: <cover.1626794843.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

virtio-gpio is a virtual GPIO controller. It provides a way to flexibly
communicate with the host GPIO controllers from the guest.

This patch adds the specification for it.

Based on the initial work posted by:
"Enrico Weigelt, metux IT consult" <lkml@metux.net>.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/110
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 conformance.tex |  28 +++-
 content.tex     |   1 +
 virtio-gpio.tex | 369 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 394 insertions(+), 4 deletions(-)
 create mode 100644 virtio-gpio.tex

diff --git a/conformance.tex b/conformance.tex
index 94d7a06db899..c52f1a40be2d 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -30,8 +30,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Driver Conformance / IOMMU Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / Sound Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
-\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance} or
-\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance}.
+\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance},
+\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance} or
+\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance}.
 
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -54,8 +55,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Device Conformance / IOMMU Device Conformance},
 \ref{sec:Conformance / Device Conformance / Sound Device Conformance},
 \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
-\ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance} or
-\ref{sec:Conformance / Device Conformance / SCMI Device Conformance}.
+\ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance},
+\ref{sec:Conformance / Device Conformance / SCMI Device Conformance} or
+\ref{sec:Conformance / Device Conformance / GPIO Device Conformance}.
 
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -301,6 +303,15 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / SCMI Device / Device Operation / Setting Up eventq Buffers}
 \end{itemize}
 
+\conformance{\subsection}{GPIO Driver Conformance}\label{sec:Conformance / Driver Conformance / GPIO Driver Conformance}
+
+A General Purpose Input/Output (GPIO) driver MUST conform to the following
+normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / GPIO Device / requestq Operation}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
 A device MUST conform to the following normative statements:
@@ -550,6 +561,15 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Device Types / SCMI Device / Device Operation / Shared Memory Operation}
 \end{itemize}
 
+\conformance{\subsection}{GPIO Device Conformance}\label{sec:Conformance / Device Conformance / GPIO Device Conformance}
+
+A General Purpose Input/Output (GPIO) device MUST conform to the following
+normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / GPIO Device / requestq Operation}
+\end{itemize}
+
 \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
diff --git a/content.tex b/content.tex
index 5c70a3c415a3..511f2071959d 100644
--- a/content.tex
+++ b/content.tex
@@ -6583,6 +6583,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 \input{virtio-mem.tex}
 \input{virtio-i2c.tex}
 \input{virtio-scmi.tex}
+\input{virtio-gpio.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/virtio-gpio.tex b/virtio-gpio.tex
new file mode 100644
index 000000000000..fa48780a29db
--- /dev/null
+++ b/virtio-gpio.tex
@@ -0,0 +1,369 @@
+\section{GPIO Device}\label{sec:Device Types / GPIO Device}
+
+The Virtio GPIO device is a virtual General Purpose Input/Output device that
+supports a variable number of named I/O lines, which can be configured in input
+mode or in output mode with logical level low (0) or high (1).
+
+\subsection{Device ID}\label{sec:Device Types / GPIO Device / Device ID}
+41
+
+\subsection{Virtqueues}\label{sec:Device Types / GPIO Device / Virtqueues}
+
+\begin{description}
+\item[0] requestq
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / GPIO Device / Feature bits}
+
+None currently defined.
+
+\subsection{Device configuration layout}\label{sec:Device Types / GPIO Device / Device configuration layout}
+
+GPIO device uses the following configuration structure layout:
+
+\begin{lstlisting}
+struct virtio_gpio_config {
+    le16 ngpio;
+    u8 padding[2];
+    le32 gpio_names_size;
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{ngpio}] is the total number of GPIO lines supported by the device.
+
+\item[\field{padding}] has no meaning and is reserved for future use. This
+    MUST be set to zero by the device.
+
+\item[\field{gpio_names_size}] is the size of the gpio-names memory block in
+    bytes, which can be fetched by the driver using the
+    \field{VIRTIO_GPIO_MSG_GET_NAMES} message. The device MUST set this to 0 if
+    it doesn't support names for the GPIO lines.
+\end{description}
+
+
+\subsection{Device Initialization}\label{sec:Device Types / GPIO Device / Device Initialization}
+
+\begin{itemize}
+\item The driver MUST configure and initialize the \field{requestq} virtqueue.
+\end{itemize}
+
+\subsection{Device Operation: requestq}\label{sec:Device Types / GPIO Device / requestq Operation}
+
+The driver uses the \field{requestq} virtqueue to send messages to the device.
+The driver sends a pair of buffers, request (filled by driver) and response (to
+be filled by device later), to the device. The device in turn fills the response
+buffer and sends it back to the driver.
+
+\begin{lstlisting}
+struct virtio_gpio_request {
+    le16 type;
+    le16 gpio;
+    le32 value;
+};
+\end{lstlisting}
+
+All the fields of this structure are set by the driver and read by the device.
+
+\begin{description}
+\item[\field{type}] is the GPIO message type, i.e. one of
+    \field{VIRTIO_GPIO_MSG_*} values.
+
+\item[\field{gpio}] is the GPIO line number, i.e. 0 <= \field{gpio} <
+    \field{ngpio}.
+
+\item[\field{value}] is a message specific value.
+\end{description}
+
+\begin{lstlisting}
+struct virtio_gpio_response {
+    u8 status;
+    u8 value[N];
+};
+
+/* Possible values of the status field */
+#define VIRTIO_GPIO_STATUS_OK                   0x0
+#define VIRTIO_GPIO_STATUS_ERR                  0x1
+\end{lstlisting}
+
+All the fields of this structure are set by the device and read by the driver.
+
+\begin{description}
+\item[\field{status}] of the GPIO message,
+    \field{VIRTIO_GPIO_STATUS_OK} on success and \field{VIRTIO_GPIO_STATUS_ERR}
+    on failure.
+
+\item[\field{value}] is a message specific defined value. The value of N (i.e.
+    size of the \field{value} buffer in bytes) is 1 for most of the messages,
+    except \field{VIRTIO_GPIO_MSG_GET_NAMES}, where it is set to the value of
+    \field{gpio_names_size} field.
+\end{description}
+
+Following is the list of messages supported by the virtio gpio specification.
+
+\begin{lstlisting}
+/* GPIO message types */
+#define VIRTIO_GPIO_MSG_GET_NAMES               0x0001
+#define VIRTIO_GPIO_MSG_ACTIVATE                0x0002
+#define VIRTIO_GPIO_MSG_DEACTIVATE              0x0003
+#define VIRTIO_GPIO_MSG_GET_DIRECTION           0x0004
+#define VIRTIO_GPIO_MSG_SET_DIRECTION_IN        0x0005
+#define VIRTIO_GPIO_MSG_SET_DIRECTION_OUT       0x0006
+#define VIRTIO_GPIO_MSG_GET_VALUE               0x0007
+#define VIRTIO_GPIO_MSG_SET_VALUE               0x0008
+\end{lstlisting}
+
+\subsubsection{requestq Operation: Get Names}\label{sec:Device Types / GPIO Device / requestq Operation / Get Names}
+
+The driver sends this message to receive a stream of zero-terminated strings,
+where each string represents the name of a GPIO line, present in increasing
+order of the GPIO line numbers. The GPIO line names must be unique within a GPIO
+Device and must not be an empty string.
+
+These names of the GPIO lines should be most meaningful producer names for the
+system, such as name indicating the usage. For example "MMC-CD", "Red LED Vdd"
+and "ethernet reset" are reasonable line names as they describe what the line is
+used for, while "GPIO0" is not a good name to give to a GPIO line.
+
+The device MUST set the \field{gpio_names_size} to a non-zero value if this
+message is supported by the device, else it must be set to zero.
+
+The driver must allocate the \field{value[N]} buffer in the \field{struct
+virtio_gpio_response} for N bytes, where N = \field{gpio_names_size}.
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_MSG_GET_NAMES} & 0 & 0 \\
+\hline
+\end{tabularx}
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Response} & \field{status} & \field{value[N]} & \field{Where N is} \\
+\hline
+& \field{VIRTIO_GPIO_STATUS_*} & gpio-names & \field{gpio_names_size} \\
+\hline
+\end{tabularx}
+
+\subsubsection{requestq Operation: Activate}\label{sec:Device Types / GPIO Device / requestq Operation / Activate}
+
+The driver sends this message to notify the device that one of its lines has
+been assigned for use.
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_MSG_ACTIVATE} & line number & 0 \\
+\hline
+\end{tabularx}
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Response} & \field{status} & \field{value[N]} & \field{Where N is} \\
+\hline
+& \field{VIRTIO_GPIO_STATUS_*} & 0 & 1 \\
+\hline
+\end{tabularx}
+
+\subsubsection{requestq Operation: Deactivate}\label{sec:Device Types / GPIO Device / requestq Operation / Deactivate}
+
+The driver sends this message to notify the device that a previously requested
+line has been unassigned and can be deactivated.
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_MSG_DEACTIVATE} & line number & 0 \\
+\hline
+\end{tabularx}
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Response} & \field{status} & \field{value[N]} & \field{Where N is} \\
+\hline
+& \field{VIRTIO_GPIO_STATUS_*} & 0 & 1 \\
+\hline
+\end{tabularx}
+
+\subsubsection{requestq Operation: Get Direction}\label{sec:Device Types / GPIO Device / requestq Operation / Get Direction}
+
+The driver sends this message to request the device to return a line's
+configured direction.
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_MSG_GET_DIRECTION} & line number & 0 \\
+\hline
+\end{tabularx}
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Response} & \field{status} & \field{value[N]} & \field{Where N is} \\
+\hline
+& \field{VIRTIO_GPIO_STATUS_*} & 0 = output, 1 = input & 1 \\
+\hline
+\end{tabularx}
+
+\subsubsection{requestq Operation: Set Direction In}\label{sec:Device Types / GPIO Device / requestq Operation / Set Direction In}
+
+The driver sends this message to request the device to configure a line for
+input.
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_MSG_SET_DIRECTION_IN} & line number & 0 \\
+\hline
+\end{tabularx}
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Response} & \field{status} & \field{value[N]} & \field{Where N is} \\
+\hline
+& \field{VIRTIO_GPIO_STATUS_*} & 0 & 1 \\
+\hline
+\end{tabularx}
+
+\subsubsection{requestq Operation: Set Direction Out}\label{sec:Device Types / GPIO Device / requestq Operation / Set Direction Out}
+
+The driver sends this message to request the device to configure a line for
+output, and set its initial output value.
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_MSG_SET_DIRECTION_OUT} & line number & 0 = low, 1 = high \\
+\hline
+\end{tabularx}
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Response} & \field{status} & \field{value[N]} & \field{Where N is} \\
+\hline
+& \field{VIRTIO_GPIO_STATUS_*} & 0 & 1 \\
+\hline
+\end{tabularx}
+
+\subsubsection{requestq Operation: Get Value}\label{sec:Device Types / GPIO Device / requestq Operation / Get Value}
+
+The driver sends this message to request the device to return current value
+sensed on a line configured for input.
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_MSG_GET_VALUE} & line number & 0 \\
+\hline
+\end{tabularx}
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Response} & \field{status} & \field{value[N]} & \field{Where N is} \\
+\hline
+& \field{VIRTIO_GPIO_STATUS_*} & 0 = low, 1 = high & 1 \\
+\hline
+\end{tabularx}
+
+\subsubsection{requestq Operation: Set Value}\label{sec:Device Types / GPIO Device / requestq Operation / Set Value}
+
+The driver sends this message to request the device to set the value of a line
+configured for output.
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_MSG_SET_VALUE} & line number & 0 = low, 1 = high \\
+\hline
+\end{tabularx}
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Response} & \field{status} & \field{value[N]} & \field{Where N is} \\
+\hline
+& \field{VIRTIO_GPIO_STATUS_*} & 0 & 1 \\
+\hline
+\end{tabularx}
+
+\subsubsection{requestq Operation: Message Flow}\label{sec:Device Types / GPIO Device / requestq Operation / Message Flow}
+
+\begin{itemize}
+\item The driver queues \field{struct virtio_gpio_request} and
+    \field{virtio_gpio_response} buffers to the \field{requestq} virtqueue,
+    after filling all fields of the \field{struct virtio_gpio_request} buffer as
+    defined by the specific message type.
+
+\item The driver notifies the device of the presence of buffers on the
+    \field{requestq} virtqueue.
+
+\item The device, after receiving the message from the driver, processes it and
+    fills all the fields of the \field{struct virtio_gpio_response} buffer
+    (received from the driver). The \field{status} must be set to
+    \field{VIRTIO_GPIO_STATUS_OK} on success and \field{VIRTIO_GPIO_STATUS_ERR}
+    on failure.
+
+\item The device puts the buffers back on the \field{requestq} virtqueue and
+    notifies the driver of the same.
+
+\item The driver fetches the buffers and processes the response received in the
+    \field{virtio_gpio_response} buffer.
+
+\item The driver can now send another message for the same GPIO line.
+\end{itemize}
+
+\drivernormative{\subsubsection}{requestq Operation}{Device Types / GPIO Device / requestq Operation}
+
+\begin{itemize}
+\item The driver MUST send messages on the \field{requestq} virtqueue.
+
+\item The driver MUST queue both \field{struct virtio_gpio_request} and
+    \field{virtio_gpio_response} for every message sent to the device.
+
+\item The \field{struct virtio_gpio_request} buffer MUST be filled by the driver
+    and MUST be read-only for the device.
+
+\item The \field{struct virtio_gpio_response} buffer MUST be filled by the
+    device and MUST be writable by the device.
+
+\item The driver MUST NOT set value of a GPIO line configured for input.
+
+\item The driver MUST NOT get value of a GPIO line configured for output.
+
+\item The driver MAY send messages for different GPIO lines in parallel.
+
+\item The driver MUST NOT send another message, of any type, for a GPIO line
+    before receiving a response from the device for the previously sent message
+    for the same GPIO line.
+\end{itemize}
+
+\devicenormative{\subsubsection}{requestq Operation}{Device Types / GPIO Device / requestq Operation}
+
+\begin{itemize}
+\item The device MUST set all the fields of the \field{struct
+    virtio_gpio_response} before sending it back to the driver.
+
+\item The device MUST set all the fields of the \field{struct
+    virtio_gpio_config} on receiving a configuration request from the driver.
+
+\item The device MUST set the \field{gpio_names_size} field as zero in the
+    \field{struct virtio_gpio_config}, if it doesn't implement names for
+    individual GPIO lines.
+
+\item The device MUST set the \field{gpio_names_size} field, in the
+    \field{struct virtio_gpio_config}, with the size of gpio-names memory block
+    in bytes, if the device implements names for individual GPIO lines. The
+    strings MUST be zero-terminated and an unique and a valid string MUST be
+    added for each supported GPIO line.
+
+\item The device MAY process messages out of order and in parallel and MAY send
+    message's response to the driver out of order.
+\end{itemize}
-- 
2.31.1.272.g89b43f80a514

