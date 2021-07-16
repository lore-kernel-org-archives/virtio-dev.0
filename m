Return-Path: <viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 1/2] virtio-gpio: Add the device specification
Date: Fri, 16 Jul 2021 13:09:18 +0530
Message-Id: <4bb66b16dc261acf9d40517c8b7961a52212086b.1626418779.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1626418779.git.viresh.kumar@linaro.org>
References: <cover.1626418779.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

virtio-gpio is a virtual GPIO controller. It provides a way to flexibly
communicate with the host GPIO controllers from the guest.

This patch adds the specification for it.

Based on the initial work posted by:
"Enrico Weigelt, metux IT consult" <lkml@metux.net>.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/110
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 conformance.tex |  26 +++-
 content.tex     |   3 +-
 virtio-gpio.tex | 317 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 341 insertions(+), 5 deletions(-)
 create mode 100644 virtio-gpio.tex

diff --git a/conformance.tex b/conformance.tex
index 94d7a06db899..9cc2d229d801 100644
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
+\ref{sec:Conformance / Driver Conformance / General Purpose IO Driver Conformance}.
 
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
+\ref{sec:Conformance / Device Conformance / General Purpose IO Device Conformance}.
 
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -301,6 +303,14 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / SCMI Device / Device Operation / Setting Up eventq Buffers}
 \end{itemize}
 
+\conformance{\subsection}{General Purpose IO Driver Conformance}\label{sec:Conformance / Driver Conformance / General Purpose IO Driver Conformance}
+
+An General Purpose IO driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / GPIO Device / Device Operation}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
 A device MUST conform to the following normative statements:
@@ -550,6 +560,14 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Device Types / SCMI Device / Device Operation / Shared Memory Operation}
 \end{itemize}
 
+\conformance{\subsection}{General Purpose IO Device Conformance}\label{sec:Conformance / Device Conformance / General Purpose IO Device Conformance}
+
+An General Purpose IO device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / GPIO Device / Device Operation}
+\end{itemize}
+
 \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
diff --git a/content.tex b/content.tex
index 5c70a3c415a3..a8c9167b3e50 100644
--- a/content.tex
+++ b/content.tex
@@ -2876,7 +2876,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 40         &   Bluetooth device \\
 \hline
-41         &   GPIO device \\
+41         &   General Purpose IO (GPIO) device \\
 \hline
 \end{tabular}
 
@@ -6583,6 +6583,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 \input{virtio-mem.tex}
 \input{virtio-i2c.tex}
 \input{virtio-scmi.tex}
+\input{virtio-gpio.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/virtio-gpio.tex b/virtio-gpio.tex
new file mode 100644
index 000000000000..40020620d714
--- /dev/null
+++ b/virtio-gpio.tex
@@ -0,0 +1,317 @@
+\section{General Purpose IO Device}\label{sec:Device Types / GPIO Device}
+
+The Virtio GPIO device is a virtual general purpose IO device that supports a
+variable number of named IO lines, which can be configured in input mode or in
+output mode with logical level low (0) or high (1).
+
+\subsection{Device ID}\label{sec:Device Types / GPIO Device / Device ID}
+41
+
+\subsection{Virtqueues}\label{sec:Device Types / GPIO Device / Virtqueues}
+
+\begin{description}
+\item[0] txq (driver to device)
+\item[1] rxq (device to driver)
+\end{description}
+
+The \field{txq} virtqueue is used by the driver to send messages to the device
+and the \field{rxq} virtqueue is used by the device to send messages to the
+driver.
+
+\subsection{Feature bits}\label{sec:Device Types / GPIO Device / Feature bits}
+
+None currently defined.
+
+\subsection{Device configuration layout}\label{sec:Device Types / GPIO Device / Device configuration layout}
+
+GPIO device uses the following structure layout for configuration:
+
+\begin{lstlisting}
+struct virtio_gpio_config {
+    u8 name[32];
+    le16 ngpio;
+    le16 names_offset;
+    le32 names_size;
+
+    /* at offset defined by names_offset field */
+    u8 gpio_names[];
+};
+\end{lstlisting}
+
+All fields of this structure, except \field{gpio_names}, must always be set by
+the device and all fields are read-only for the driver.
+
+\begin{description}
+\item[\field{name}] is a zero-terminated string that represents the name of the
+    GPIO device. The unused bytes in the string must be initialized to zero by
+    the device.
+
+\item[\field{ngpio}] is the total number of GPIO lines supported by the device.
+
+\item[\field{names_offset}] is the offset of the \field{gpio_names} field from
+    the base address of the \field{struct virtio_gpio_config}. The device must
+    set its value to 40 for current version of the specification. In future this
+    value may change if the \field {struct virtio_gpio_config} is expanded by
+    adding more fields to it.
+
+\item[\field{names_size}] is the size of the \field{gpio_names} memory block.
+    The device must set it to the size, in bytes, of the \field{gpio_names}
+    field. The device must set this to zero, if the \field{gpio_names} field
+    isn't implemented by the device.
+
+\item[\field{gpio_names}] field is optional for a device to implement. If this
+    field isn't implemented by the device, then the device must set the
+    \field{names_size} field to zero. If this field is implemented by the
+    device, then it must contain a stream of \field{ngpio} zero-terminated
+    strings, where each string represents the name of a GPIO line, present in
+    increasing order of the GPIO line numbers. The GPIO line names must
+    be unique within a GPIO Device and must not be empty string.
+
+\end{description}
+
+
+\subsection{Device Initialization}\label{sec:Device Types / GPIO Device / Device Initialization}
+
+\begin{itemize}
+\item The driver MUST configure and initialize both the virtqueues.
+
+\item The driver MUST read device configuration.
+
+\item The driver MUST populate the \field{rxq} virtqueue with \field{struct
+      virtio_gpio_msg} buffer.
+\end{itemize}
+
+\subsection{Device Operation}\label{sec:Device Types / GPIO Device / Device Operation}
+
+The communication between device and driver takes place using a pair of request
+and response messages, both of which are represented by \field{struct
+virtio_gpio_msg}.
+
+\begin{lstlisting}
+struct virtio_gpio_msg {
+        le16 type;
+        le16 gpio;
+        le32 value;
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{type}] is the GPIO message type.
+\item[\field{gpio}] is the GPIO line number.
+\item[\field{value}] is a message specific value.
+\end{description}
+
+A request is initiated by the sender by adding a buffer of type \field{struct
+virtio_gpio_msg} to its respective virtqueue, after setting all fields of the
+message and \field{type} field with one of the message types from
+\field{VIRTIO_GPIO_MSG_*}.
+
+In response, the receiver adds a copy of the same buffer on its respective
+virtqueue, after performing a logical OR operation to the \field{type} field
+with VIRTIO_GPIO_MSG_RESPONSE mask and updating the \field{value} field based on
+message type.
+
+For the current version of the specification, the sender is always the driver
+and receiver is always the device.
+
+\begin{lstlisting}
+/* GPIO message types: driver -> device */
+#define VIRTIO_GPIO_MSG_REQUEST                 0x0001
+#define VIRTIO_GPIO_MSG_FREE                    0x0002
+#define VIRTIO_GPIO_MSG_GET_DIRECTION           0x0003
+#define VIRTIO_GPIO_MSG_SET_DIRECTION_IN        0x0004
+#define VIRTIO_GPIO_MSG_SET_DIRECTION_OUT       0x0005
+#define VIRTIO_GPIO_MSG_GET_VALUE               0x0006
+#define VIRTIO_GPIO_MSG_SET_VALUE               0x0007
+
+/* GPIO response mask, to be Or'ed with one of the above */
+#define VIRTIO_GPIO_MSG_RESPONSE                    0x8000
+\end{lstlisting}
+
+The response messages may contain error codes (in the \field{value} field) on
+failures, they must be read as negative POSIX errno codes, unless stated
+otherwise, i.e. 0 as success, and negative value as POSIX error code, positive
+values as invalid, unless stated otherwise.
+
+\subsubsection{Device Operation: Request}\label{sec:Device Types / GPIO Device / Device Operation / Request }
+
+The driver initiates this message to notify the device that one of its lines has
+been assigned for use.
+
+\begin{tabular}{ |l||l|l|l| }
+\hline
+Fields & \field{type} & \field{gpio} & \field{value} \\
+\hline
+Message & \field{VIRTIO_GPIO_MSG_REQUEST} & line number & 0 \\
+\hline
+Response & \field{VIRTIO_GPIO_MSG_REQUEST} \newline | \field{VIRTIO_GPIO_MSG_RESPONSE} & line number & 0 = success, \newline or -errno = failure \\
+\hline
+\end{tabular}
+
+\subsubsection{Device Operation: Free}\label{sec:Device Types / GPIO Device / Device Operation / Free }
+
+The driver initiates this message to notify the device that a previously
+requested line has been unassigned and can be deactivated.
+
+\begin{tabular}{ |l||l|l|l| }
+\hline
+Fields & \field{type} & \field{gpio} & \field{value} \\
+\hline
+Message & \field{VIRTIO_GPIO_MSG_FREE} & line number & 0 \\
+\hline
+Response & \field{VIRTIO_GPIO_MSG_FREE} \newline | \field{VIRTIO_GPIO_MSG_RESPONSE} & line number & 0 = success, \newline or -errno = failure \\
+\hline
+\end{tabular}
+
+\subsubsection{Device Operation: Get Direction}\label{sec:Device Types / GPIO Device / Device Operation / Get Direction }
+
+The driver initiates this message to request the device to return a line's
+configured direction.
+
+\begin{tabular}{ |l||l|l|l| }
+\hline
+Fields & \field{type} & \field{gpio} & \field{value} \\
+\hline
+Message & \field{VIRTIO_GPIO_MSG_GET_DIRECTION} & line number & 0 \\
+\hline
+Response & \field{VIRTIO_GPIO_MSG_GET_DIRECTION} \newline | \field{VIRTIO_GPIO_MSG_RESPONSE} & line number & 0 = output, 1 = input, \newline or -errno = failure \\
+\hline
+\end{tabular}
+
+\subsubsection{Device Operation: Direction In}\label{sec:Device Types / GPIO Device / Device Operation / Direction In }
+
+The driver initiates this message to request the device to configure a line for
+input.
+
+\begin{tabular}{ |l||l|l|l| }
+\hline
+Fields & \field{type} & \field{gpio} & \field{value} \\
+\hline
+Message & \field{VIRTIO_GPIO_MSG_SET_DIRECTION_IN} & line number & 0 \\
+\hline
+Response & \field{VIRTIO_GPIO_MSG_SET_DIRECTION_IN} \newline | \field{VIRTIO_GPIO_MSG_RESPONSE} & line number & 0 = success, \newline or -errno = failure \\
+\hline
+\end{tabular}
+
+\subsubsection{Device Operation: Direction Out}\label{sec:Device Types / GPIO Device / Device Operation / Direction Out }
+
+The driver initiates this message to request the device to configure a line for
+output, and set its initial output value.
+
+\begin{tabular}{ |l||l|l|l| }
+\hline
+Fields & \field{type} & \field{gpio} & \field{value} \\
+\hline
+    Message & \field{VIRTIO_GPIO_MSG_SET_DIRECTION_OUT} & line number & 0 = low, 1 = high \\
+\hline
+Response & \field{VIRTIO_GPIO_MSG_SET_DIRECTION_OUT} \newline | \field{VIRTIO_GPIO_MSG_RESPONSE} & line number & 0 = success, \newline or -errno = failure \\
+\hline
+\end{tabular}
+
+\subsubsection{Device Operation: Get Value}\label{sec:Device Types / GPIO Device / Device Operation / Get Value }
+
+The driver initiates this message to request the device to return current value
+sensed on a line configured for input.
+
+\begin{tabular}{ |l||l|l|l| }
+\hline
+Fields & \field{type} & \field{gpio} & \field{value} \\
+\hline
+Message & \field{VIRTIO_GPIO_MSG_GET_VALUE} & line number & 0 \\
+\hline
+Response & \field{VIRTIO_GPIO_MSG_GET_VALUE} \newline | \field{VIRTIO_GPIO_MSG_RESPONSE} & line number & 0 = low, 1 = high, \newline or -errno = failure \\
+\hline
+\end{tabular}
+
+\subsubsection{Device Operation: Set Value}\label{sec:Device Types / GPIO Device / Device Operation / Set Value }
+
+The driver initiates this message to request the device to set the value of a
+line configured for output.
+
+\begin{tabular}{ |l||l|l|l| }
+\hline
+Fields & \field{type} & \field{gpio} & \field{value} \\
+\hline
+Message & \field{VIRTIO_GPIO_MSG_SET_VALUE} & line number & 0 = low, 1 = high \\
+\hline
+Response & \field{VIRTIO_GPIO_MSG_SET_VALUE} \newline | \field{VIRTIO_GPIO_MSG_RESPONSE} & line number & 0 = success, \newline or -errno = failure \\
+\hline
+\end{tabular}
+
+\drivernormative{\subsubsection}{Device Operation}{Device Types / GPIO Device / Device Operation}
+
+\begin{itemize}
+\item The driver MUST only send messages on the \field{txq} virtqueue.
+
+\item The driver MUST set all the fields of the \field{struct virtio_gpio_msg}
+      before sending it to the device.
+
+\item The driver MUST NOT set value of a GPIO line configured for input.
+
+\item The driver MUST NOT get value of a GPIO line configured for output.
+
+\item The driver MUST NOT initiate another message for a GPIO line, before
+      response to the previously sent message is received for the same line.
+\end{itemize}
+
+\devicenormative{\subsubsection}{Device Operation}{Device Types / GPIO Device / Device Operation}
+
+\begin{itemize}
+\item The device MUST only send messages on the \field{rxq} virtqueue.
+
+\item The device MUST set all the fields of the \field{struct virtio_gpio_msg}
+      before sending it to the driver.
+
+\item The device MUST set all the fields of the \field{struct
+      virtio_gpio_config} on receiving a request from the driver.
+
+\item The device MUST set the \field{names_size} field as zero in the
+      \field{struct virtio_gpio_config}, if it doesn't implement the
+      \field{gpio_names} field.
+
+  \item The device MUST set the \field{names_size} field, in the \field{struct
+      virtio_gpio_config}, with the size of \field{gpio_names} memory block in
+      bytes, if it implements the \field{gpio_names} field.
+
+\item If the device implements the \field{gpio_names} field, then the strings in
+      that field MUST be zero-terminated and an unique and valid string MUST be
+      added for each supported GPIO line.
+\end{itemize}
+
+\subsection{Message flow}\label{sec:Device Types / GPIO Device / Message Flow}
+
+This section describe how the messages flow between device and driver.
+
+\subsubsection{Driver Requests}\label{sec:Device Types / GPIO Device / Message Flow / Requests}
+
+All the messages, except \field{VIRTIO_GPIO_MSG_IRQ_EVENT}, are initiated by the
+driver and sent to the device over the \field{txq} virtqueue.
+
+\begin{itemize}
+\item The driver prepares a buffer of type \field{struct virtio_gpio_msg} and
+      sets its \field{type} to one of the message types from
+      \field{VIRTIO_GPIO_MSG_*} (except \field{VIRTIO_GPIO_MSG_IRQ_EVENT}),
+      \field{gpio} field with a GPIO line number, and \field{value} to message
+      defined value.
+
+\item The driver sends the buffer to the device over the \field{txq} virtqueue.
+
+\item The driver MUST NOT initiate another request for the same GPIO line before
+      receiving a response from the device for the line.
+
+\item The device, after receiving the buffer from the driver, processes it and
+      prepares a buffer of type \field{struct virtio_gpio_msg} and sets its
+      \field{type} field to the \field{type} field of the received buffer OR'ed
+      with \field{VIRTIO_GPIO_MSG_RESPONSE}, \field{gpio} field with
+      \field{gpio} field of the received buffer, and \field{value} to a message
+      defined value.
+
+\item The device sends the buffer to the driver over the \field{rxq} virtqueue.
+
+\item The driver receives and processes the buffer.
+
+\item The driver can now initiate another request for the same GPIO line.
+
+\item The driver can initiate an request for a different GPIO line before
+      receiving response for a previous request for another line.
+\end{itemize}
-- 
2.31.1.272.g89b43f80a514

