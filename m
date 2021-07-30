Return-Path: <viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V8 1/2] virtio-gpio: Add the device specification
Date: Fri, 30 Jul 2021 12:15:02 +0530
Message-Id: <3e801cbef0a46d5c4f82d46debd3a72811becd4c.1627627021.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1627627021.git.viresh.kumar@linaro.org>
References: <cover.1627627021.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, stratos-dev@op-lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-ID: <virtio-dev.lists.oasis-open.org>

virtio-gpio is a virtual GPIO controller. It provides a way to flexibly
communicate with the host GPIO controllers from the guest.

Note that the current implementation doesn't provide atomic APIs for
GPIO configurations. i.e. the driver (guest) would need to implement
sleep-able versions of the APIs as the guest will respond asynchronously
over the virtqueue.

This patch adds the specification for it.

Based on the initial work posted by:
"Enrico Weigelt, metux IT consult" <lkml@metux.net>.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/110
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 conformance.tex |  28 +++-
 content.tex     |   1 +
 virtio-gpio.tex | 346 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 371 insertions(+), 4 deletions(-)
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
index 31b02e1dca0e..0008727a80df 100644
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
index 000000000000..1d1ac672db37
--- /dev/null
+++ b/virtio-gpio.tex
@@ -0,0 +1,346 @@
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
+    \field{VIRTIO_GPIO_MSG_GET_LINE_NAMES} message. The device MUST set this to
+    0 if it doesn't support names for the GPIO lines.
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
+    u8 value;
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
+\item[\field{value}] is a message specific value.
+\end{description}
+
+Following is the list of messages supported by the virtio gpio specification.
+
+\begin{lstlisting}
+/* GPIO message types */
+#define VIRTIO_GPIO_MSG_GET_LINE_NAMES          0x0001
+#define VIRTIO_GPIO_MSG_GET_DIRECTION           0x0002
+#define VIRTIO_GPIO_MSG_SET_DIRECTION           0x0003
+#define VIRTIO_GPIO_MSG_GET_VALUE               0x0004
+#define VIRTIO_GPIO_MSG_SET_VALUE               0x0005
+
+/* GPIO Direction types */
+#define VIRTIO_GPIO_DIRECTION_NONE              0x00
+#define VIRTIO_GPIO_DIRECTION_OUT               0x01
+#define VIRTIO_GPIO_DIRECTION_IN                0x02
+\end{lstlisting}
+
+\subsubsection{requestq Operation: Get Line Names}\label{sec:Device Types / GPIO Device / requestq Operation / Get Line Names}
+
+The driver sends this message to receive a stream of zero-terminated strings,
+where each string represents the name of a GPIO line, present in increasing
+order of the GPIO line numbers. The names of the GPIO lines are optional and may
+be present only for a subset of GPIO lines. If missing, then a zero-byte must be
+present for the GPIO line. If present, the name string must be zero-terminated
+and the name must be unique within a GPIO Device.
+
+These names of the GPIO lines should be most meaningful producer names for the
+system, such as name indicating the usage. For example "MMC-CD", "Red LED Vdd"
+and "ethernet reset" are reasonable line names as they describe what the line is
+used for, while "GPIO0" is not a good name to give to a GPIO line.
+
+Here is an example of how the gpio names memory block may look like for a GPIO
+device with 10 GPIO lines, where line names are provided only for lines 0
+("MMC-CD"), 5 ("Red LED Vdd") and 7 ("ethernet reset").
+
+\begin{lstlisting}
+u8 gpio_names[] = {
+    'M', 'M', 'C', '-', 'C', 'D', 0,
+    0,
+    0,
+    0,
+    0,
+    'R', 'e', 'd', ' ', 'L', 'E', 'D', ' ', 'V', 'd', 'd', 0,
+    0,
+    'E', 't', 'h', 'e', 'r', 'n', 'e', 't', ' ', 'r', 'e', 's', 'e', 't', 0,
+    0,
+    0
+};
+\end{lstlisting}
+
+The device MUST set the \field{gpio_names_size} to a non-zero value if this
+message is supported by the device, else it must be set to zero.
+
+This message type uses different layout for the response structure, as the
+device needs to return the \field{gpio_names} array.
+
+\begin{lstlisting}
+struct virtio_gpio_response_N {
+    u8 status;
+    u8 value[N];
+};
+\end{lstlisting}
+
+The driver must allocate the \field{value[N]} buffer in the \field{struct
+virtio_gpio_response_N} for N bytes, where N = \field{gpio_names_size}.
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_MSG_GET_LINE_NAMES} & 0 & 0 \\
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
+\begin{tabularx}{\textwidth}{ |l||X|X| }
+\hline
+\textbf{Response} & \field{status} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_STATUS_*} & 0 = none, 1 = output, 2 = input \\
+\hline
+\end{tabularx}
+
+\subsubsection{requestq Operation: Set Direction}\label{sec:Device Types / GPIO Device / requestq Operation / Set Direction}
+
+The driver sends this message to request the device to configure a line's
+direction. The driver can either set the direction to
+\field{VIRTIO_GPIO_DIRECTION_IN} or \field{VIRTIO_GPIO_DIRECTION_OUT}, which
+also activates the line, or to \field{VIRTIO_GPIO_DIRECTION_NONE}, which
+deactivates the line.
+
+The driver MUST set the value of the GPIO line, using the
+\field{VIRTIO_GPIO_MSG_SET_VALUE} message, before setting the direction of the
+line to output.
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_MSG_SET_DIRECTION} & line number & 0 = none, 1 = output, 2 = input \\
+\hline
+\end{tabularx}
+
+\begin{tabularx}{\textwidth}{ |l||X|X| }
+\hline
+\textbf{Response} & \field{status} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_STATUS_*} & 0 \\
+\hline
+\end{tabularx}
+
+\subsubsection{requestq Operation: Get Value}\label{sec:Device Types / GPIO Device / requestq Operation / Get Value}
+
+The driver sends this message to request the device to return current value
+sensed on a line.
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_MSG_GET_VALUE} & line number & 0 \\
+\hline
+\end{tabularx}
+
+\begin{tabularx}{\textwidth}{ |l||X|X| }
+\hline
+\textbf{Response} & \field{status} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_STATUS_*} & 0 = low, 1 = high \\
+\hline
+\end{tabularx}
+
+\subsubsection{requestq Operation: Set Value}\label{sec:Device Types / GPIO Device / requestq Operation / Set Value}
+
+The driver sends this message to request the device to set the value of a line.
+The line may already be configured for output or may get configured to output
+later, at which point this output value must be used by the device for the line.
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_MSG_SET_VALUE} & line number & 0 = low, 1 = high \\
+\hline
+\end{tabularx}
+
+\begin{tabularx}{\textwidth}{ |l||X|X| }
+\hline
+\textbf{Response} & \field{status} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_STATUS_*} & 0 \\
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
+\item The driver can send multiple messages in parallel for same or different
+    GPIO line.
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
+\item The driver MAY send multiple messages for same or different GPIO lines in
+    parallel.
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
+    strings MUST be zero-terminated and an unique (if available) within the GPIO
+    device.
+
+\item The device MUST process multiple messages, for the same GPIO line,
+    sequentially and respond to them in the order they were received on the
+    virtqueue.
+
+\item The device MAY process messages, for different GPIO lines, out of order
+    and in parallel, and MAY send message's response to the driver out of order.
+
+\item The device MUST discard all state information corresponding to a GPIO
+    line, once the driver has requested to set its direction to
+    \field{VIRTIO_GPIO_DIRECTION_NONE}.
+\end{itemize}
-- 
2.31.1.272.g89b43f80a514

