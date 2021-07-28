Return-Path: <viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V7 2/2] virtio-gpio: Add support for interrupts
Date: Wed, 28 Jul 2021 16:41:22 +0530
Message-Id: <0dac5ab26a5fcc94ec530dbf83247788922123d7.1627469463.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1627469463.git.viresh.kumar@linaro.org>
References: <cover.1627469463.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, stratos-dev@op-lists.linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

This patch adds support for interrupts to the virtio-gpio specification.
This uses the feature bit 0 for the same.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/110
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 conformance.tex |   2 +
 virtio-gpio.tex | 191 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 192 insertions(+), 1 deletion(-)

diff --git a/conformance.tex b/conformance.tex
index c52f1a40be2d..64bcc12d1199 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -310,6 +310,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 
 \begin{itemize}
 \item \ref{drivernormative:Device Types / GPIO Device / requestq Operation}
+\item \ref{drivernormative:Device Types / GPIO Device / eventq Operation}
 \end{itemize}
 
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
@@ -568,6 +569,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 
 \begin{itemize}
 \item \ref{devicenormative:Device Types / GPIO Device / requestq Operation}
+\item \ref{devicenormative:Device Types / GPIO Device / eventq Operation}
 \end{itemize}
 
 \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
diff --git a/virtio-gpio.tex b/virtio-gpio.tex
index 67f1e04e8047..ffc89b98f34e 100644
--- a/virtio-gpio.tex
+++ b/virtio-gpio.tex
@@ -11,11 +11,17 @@ \subsection{Virtqueues}\label{sec:Device Types / GPIO Device / Virtqueues}
 
 \begin{description}
 \item[0] requestq
+\item[1] eventq
 \end{description}
 
+The \field{eventq} virtqueue is available only if the \field{VIRTIO_GPIO_F_IRQ}
+feature is enabled by the device.
+
 \subsection{Feature bits}\label{sec:Device Types / GPIO Device / Feature bits}
 
-None currently defined.
+\begin{description}
+\item[VIRTIO_GPIO_F_IRQ (0)] The device supports interrupts on GPIO lines.
+\end{description}
 
 \subsection{Device configuration layout}\label{sec:Device Types / GPIO Device / Device configuration layout}
 
@@ -46,6 +52,15 @@ \subsection{Device Initialization}\label{sec:Device Types / GPIO Device / Device
 
 \begin{itemize}
 \item The driver MUST configure and initialize the \field{requestq} virtqueue.
+
+\item The driver MUST check the presence of \field{VIRTIO_GPIO_F_IRQ} feature
+    before initiating any IRQ messages.
+
+\item The driver MUST configure and initialize the \field{eventq} virtqueue if
+    the \field{VIRTIO_GPIO_F_IRQ} feature is enabled by the device.
+
+\item If the \field{VIRTIO_GPIO_F_IRQ} feature is supported, then the interrupt
+    for all GPIO lines must be in \field{VIRTIO_GPIO_IRQ_TYPE_NONE} state.
 \end{itemize}
 
 \subsection{Device Operation: requestq}\label{sec:Device Types / GPIO Device / requestq Operation}
@@ -108,11 +123,20 @@ \subsection{Device Operation: requestq}\label{sec:Device Types / GPIO Device / r
 #define VIRTIO_GPIO_MSG_SET_DIRECTION           0x0003
 #define VIRTIO_GPIO_MSG_GET_VALUE               0x0004
 #define VIRTIO_GPIO_MSG_SET_VALUE               0x0005
+#define VIRTIO_GPIO_MSG_SET_IRQ_TYPE            0x0006
 
 /* GPIO Direction types */
 #define VIRTIO_GPIO_DIRECTION_NONE              0x00
 #define VIRTIO_GPIO_DIRECTION_OUT               0x01
 #define VIRTIO_GPIO_DIRECTION_IN                0x02
+
+/* GPIO interrupt types */
+#define VIRTIO_GPIO_IRQ_TYPE_NONE               0x00
+#define VIRTIO_GPIO_IRQ_TYPE_EDGE_RISING        0x01
+#define VIRTIO_GPIO_IRQ_TYPE_EDGE_FALLING       0x02
+#define VIRTIO_GPIO_IRQ_TYPE_EDGE_BOTH          0x03
+#define VIRTIO_GPIO_IRQ_TYPE_LEVEL_HIGH         0x04
+#define VIRTIO_GPIO_IRQ_TYPE_LEVEL_LOW          0x08
 \end{lstlisting}
 
 \subsubsection{requestq Operation: Get Line Names}\label{sec:Device Types / GPIO Device / requestq Operation / Get Line Names}
@@ -262,6 +286,36 @@ \subsubsection{requestq Operation: Set Value}\label{sec:Device Types / GPIO Devi
 \hline
 \end{tabularx}
 
+\subsubsection{requestq Operation: Set IRQ Type}\label{sec:Device Types / GPIO Device / requestq Operation / Set IRQ Type}
+
+The driver sends this message to request the device to set the IRQ trigger type,
+to one of the \field{VIRTIO_GPIO_IRQ_TYPE_*} values, for a line configured for
+input.
+
+This request is only allowed if the \field{VIRTIO_GPIO_F_IRQ} feature is
+enabled by the device.
+
+The device MUST mask the interrupt for a GPIO line, if the trigger type is set
+to \field{VIRTIO_GPIO_IRQ_TYPE_NONE} and also discard any latched interrupt
+status associated with the line. The device MUST unmask the interrupt for any
+other value of the trigger type.
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_MSG_SET_IRQ_TYPE} & line number & one of \field{VIRTIO_GPIO_IRQ_TYPE_*} \\
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
 \subsubsection{requestq Operation: Message Flow}\label{sec:Device Types / GPIO Device / requestq Operation / Message Flow}
 
 \begin{itemize}
@@ -305,6 +359,16 @@ \subsubsection{requestq Operation: Message Flow}\label{sec:Device Types / GPIO D
 
 \item The driver MAY send multiple messages for same or different GPIO lines in
     parallel.
+
+\item The driver MUST NOT send IRQ messages for a GPIO line configured for
+    output.
+
+\item The driver MUST NOT send IRQ messages if the \field{VIRTIO_GPIO_F_IRQ}
+    feature is not enabled by the device.
+
+\item The driver MUST set the IRQ trigger type to
+    \field{VIRTIO_GPIO_IRQ_TYPE_NONE} once it is done using the GPIO line,
+    previously configured for a different trigger type.
 \end{itemize}
 
 \devicenormative{\subsubsection}{requestq Operation}{Device Types / GPIO Device / requestq Operation}
@@ -337,3 +401,128 @@ \subsubsection{requestq Operation: Message Flow}\label{sec:Device Types / GPIO D
     line, once the driver has requested to set its direction to
     \field{VIRTIO_GPIO_DIRECTION_NONE}.
 \end{itemize}
+
+\subsection{Device Operation: eventq}\label{sec:Device Types / GPIO Device / eventq Operation}
+
+The \field{eventq} virtqueue is used for sending interrupt events from the
+device to the driver. The driver queues a separate pair of buffers,
+interrupt-request (filled by driver) and interrupt-response (to be filled by
+device later), to the \field{eventq} virtqueue for each GPIO line. The device,
+on sensing an interrupt, returns the pair of buffers of the respective GPIO line
+for which the interrupt is sensed.
+
+\begin{lstlisting}
+struct virtio_gpio_irq_request {
+    le16 gpio;
+};
+\end{lstlisting}
+
+This structure is filled by the driver and read by the device.
+
+\begin{description}
+\item[\field{gpio}] is the GPIO line number, i.e. 0 <= \field{gpio} <
+    \field{ngpio}.
+\end{description}
+
+\begin{lstlisting}
+struct virtio_gpio_irq_response {
+    u8 status;
+};
+
+/* Possible values of the interrupt status field */
+#define VIRTIO_GPIO_IRQ_STATUS_INVALID          0x0
+#define VIRTIO_GPIO_IRQ_STATUS_VALID            0x1
+\end{lstlisting}
+
+This structure is filled by the device and read by the driver.
+
+\begin{description}
+\item[\field{status}] of the interrupt event, \field{VIRTIO_GPIO_IRQ_VALID} on
+    valid interrupt and \field{VIRTIO_GPIO_IRQ_INVALID} otherwise on returning
+    the buffer back to the driver without an interrupt.
+\end{description}
+
+\subsubsection{eventq Operation: Message Flow}\label{sec:Device Types / GPIO Device / eventq Operation / Message Flow}
+
+\begin{itemize}
+\item The driver is requested by a user to enable interrupt for a GPIO and
+    configure it for a particular trigger type.
+
+\item The driver queues a pair of buffers, interrupt-request and
+    interrupt-response, to the \field{eventq} virtqueue for the GPIO line.
+
+\item The driver notifies the device of the presence of new buffers on the
+    \field{eventq} virtqueue.
+
+\item The driver sends the \field{VIRTIO_GPIO_MSG_SET_IRQ_TYPE} message over the
+    \field{requestq} virtqueue and the device configures the GPIO line for the
+    requested trigger type and unmasks the interrupt.
+
+\item The interrupt is fully configured at this point.
+
+\item The device, on sensing an interrupt on a GPIO line, finds the matching
+    buffers (based on GPIO line number) from the \field{eventq} virtqueue and
+    fills its \field{struct virtio_gpio_irq_response} buffer's \field{status}
+    with \field{VIRTIO_GPIO_IRQ_VALID} and returns the pair of buffers to the
+    device.
+
+\item The device notifies the driver of the presence of new buffers on the
+    \field{eventq} virtqueue.
+
+\item If the GPIO line is configured for Level interrupts, the device MUST mask
+    the interrupts for this GPIO line, until the time the buffers are made
+    available again by the driver.
+
+\item If the GPIO line is configured for Edge interrupts, the device MUST latch
+    the latest interrupt received for this GPIO line, until the time the buffers
+    are made available again by the driver. At that point, the device can again
+    return the buffers for the line if an interrupt was received while the
+    device was waiting for the buffers to be made available by the driver.
+
+\item The driver on receiving the notification from the device, processes the
+    interrupt. The driver may try to update the trigger-type of the interrupt
+    for the GPIO line over the \field{requestq} virtqueue.
+
+\item The driver may again queue, same or new, pair of buffers for that GPIO
+    line and notify the device.
+
+\item The driver may send the \field{VIRTIO_GPIO_MSG_SET_IRQ_TYPE} message, with
+    \field{VIRTIO_GPIO_IRQ_TYPE_NONE} trigger type, over the \field{requestq}
+    virtqueue, once it no longer wants to receive the interrupts for a GPIO
+    line.
+
+\item The device must return the unused pair of buffers for that GPIO line, over
+    the \field{eventq} virtqueue, by setting the \field{status} field with
+    \field{VIRTIO_GPIO_IRQ_INVALID}.
+
+\item The driver can then free the associated buffer and remove it from the
+    \field{eventq} virtqueue.
+\end{itemize}
+
+\drivernormative{\subsubsection}{eventq Operation}{Device Types / GPIO Device / eventq Operation}
+
+\begin{itemize}
+\item The driver MUST queue a separate pair of buffers, interrupt-request and
+    interrupt-response, to the \field{eventq} virtqueue for each GPIO line for
+    which it is expecting an interrupt from the device.
+
+\item The driver MUST not queue a pair of buffers for a GPIO line which it is
+    not going to use as interrupt source, otherwise the buffer may never get
+    freed by the device (as no set trigger type request will follow from the
+    driver).
+
+\item The driver MUST NOT add multiple pairs of buffers for the same GPIO line
+    on the \field{eventq} virtqueue. So there can only be one interrupt event
+    for each GPIO line at any point of time.
+
+\item The pair of buffers for any GPIO line can either be owned by the device or
+    the driver at any particular point of time, but not both.
+\end{itemize}
+
+\devicenormative{\subsubsection}{eventq Operation}{Device Types / GPIO Device / eventq Operation}
+
+\begin{itemize}
+\item The device can send an interrupt event for a GPIO line to the driver, only
+    if a buffer for that GPIO line is provided by the driver in the first place
+    on the \field{eventq} virtqueue.
+\end{itemize}
-- 
2.31.1.272.g89b43f80a514

