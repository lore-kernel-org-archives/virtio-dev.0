Return-Path: <viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V9] virtio-gpio: Add support for interrupts
Date: Tue, 12 Oct 2021 12:46:06 +0530
Message-Id: <ed36fcb94f33cf27106b6ea0a555f71400d27ade.1634022690.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, stratos-dev@op-lists.linaro.org, Kent Gibson <warthog618@gmail.com>, Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <virtio-dev.lists.oasis-open.org>

This patch adds support for interrupts to the virtio-gpio specification.
This uses the feature bit 0 for the same.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/114
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V8 -> V9:
- The patch for base GPIO specification is already merged, sending this
  separately now.

- Differentiate properly between enabling/disabling and masking/unmasking of the
  interrupt.

- Specify how a trigger type should be changed, i.e. by disabling interrupt
  first.

- No fixed sequence for enabling/unmasking of the interrupt, any of them can be
  done first. The interrupt is only delivered once it is enabled and unmasked.

- Use normative text only in normative sections.

- Guest side Linux driver's IRQ implementation:

  https://lore.kernel.org/linux-gpio/96223fb8143a4eaa9b183d376ff46e5cd8ef54b4.1628590591.git.viresh.kumar@linaro.org/

 conformance.tex |   2 +
 virtio-gpio.tex | 248 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 249 insertions(+), 1 deletion(-)

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
index 3c614ec97b92..fba7ec400bb3 100644
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
 
@@ -46,6 +52,14 @@ \subsection{Device Initialization}\label{sec:Device Types / GPIO Device / Device
 
 \begin{itemize}
 \item The driver configures and initializes the \field{requestq} virtqueue.
+
+\item The driver checks the presence of \field{VIRTIO_GPIO_F_IRQ} feature
+    before initiating any IRQ related messages.
+
+\item The driver configures and initializes the \field{eventq} virtqueue.
+
+\item The device configures all GPIO lines in \field{VIRTIO_GPIO_IRQ_TYPE_NONE}
+    trigger type state.
 \end{itemize}
 
 \subsection{Device Operation: requestq}\label{sec:Device Types / GPIO Device / requestq Operation}
@@ -105,11 +119,20 @@ \subsection{Device Operation: requestq}\label{sec:Device Types / GPIO Device / r
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
@@ -270,6 +293,74 @@ \subsubsection{requestq Operation: Set Value}\label{sec:Device Types / GPIO Devi
 \hline
 \end{tabularx}
 
+\subsubsection{requestq Operation: Set IRQ Type}\label{sec:Device Types / GPIO Device / requestq Operation / Set IRQ Type}
+
+This request is allowed only if the \field{VIRTIO_GPIO_F_IRQ} feature is enabled
+by the device.
+
+The interrupt configuration is divided into two steps, enabling or disabling of
+the interrupt at the device and masking or unmasking of the interrupt for
+delivery at the driver. This request only pertains to enabling or disabling of
+the interrupt at the device, the masking and unmasking of the interrupt is
+handled by a separate request that takes place over the \field{eventq}
+virtqueue.
+
+The driver sends the \field{VIRTIO_GPIO_MSG_SET_IRQ_TYPE} message over the
+\field{requestq} virtqueue to enable or disable interrupt for a GPIO line at
+the device.
+
+The driver sends this message with trigger type set to any valid value other
+than \field{VIRTIO_GPIO_IRQ_TYPE_NONE}, to enable the interrupt for a GPIO line,
+this doesn't unmask the interrupt for delivery at the driver though. For edge
+trigger type, the device should latch the interrupt events from this point
+onward and notify it to the driver once the interrupt is unmasked. For level
+trigger type, the device should notify the driver once the interrupt signal on a
+line is sensed and the interrupt is unmasked for the line.
+
+The driver sends this message with trigger type set to
+\field{VIRTIO_GPIO_IRQ_TYPE_NONE}, to disable the interrupt for a GPIO line. The
+device should discard any latched interrupt event associated with it. In order
+to change the trigger type of an already enabled interrupt, the driver should
+first disable the interrupt and then re-enable it with appropriate trigger type.
+
+The interrupts are masked at initialization and the driver unmasks them by
+queuing a pair of buffers, of type \field{virtio_gpio_irq_request} and
+\field{virtio_gpio_irq_response}, over the \field{eventq} virtqueue for a GPIO
+line. A separate pair of buffers must be queued for each GPIO line, the driver
+wants to configure for interrupts. Once the interrupt is unmasked by the driver
+and the interrupt is also enabled at the device, the device can notify the
+driver of an active interrupt signal on the GPIO line. This is done by updating
+the \field{struct virtio_gpio_irq_response} buffer's \field{status} with
+\field{VIRTIO_GPIO_IRQ_STATUS_VALID} and returning the updated buffers to the
+driver. The interrupt is masked automatically at this point until the buffers
+are available again at the device.
+
+When the interrupt is disabled by the driver, by setting the trigger type to
+\field{VIRTIO_GPIO_IRQ_TYPE_NONE}, the device should return any unused pair of
+buffers for the GPIO line, over the \field{eventq} virtqueue, after setting the
+\field{status} field to \field{VIRTIO_GPIO_IRQ_STATUS_INVALID}. This also masks
+the interrupt.
+
+The driver can enable and unmask the interrupt in any order, i.e. it can enable
+the interrupt first and then queue the buffers or queue the buffers first and
+then enable the interrupt.
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_MSG_SET_IRQ_TYPE} & line number & one of \field{VIRTIO_GPIO_IRQ_TYPE_*} \\
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
 \subsubsection{requestq Operation: Message Flow}\label{sec:Device Types / GPIO Device / requestq Operation / Message Flow}
 
 \begin{itemize}
@@ -313,6 +404,20 @@ \subsubsection{requestq Operation: Message Flow}\label{sec:Device Types / GPIO D
 
 \item The driver MAY send multiple messages for same or different GPIO lines in
     parallel.
+
+\item The driver MUST NOT send IRQ messages if the \field{VIRTIO_GPIO_F_IRQ}
+    feature is not enabled by the device.
+
+\item The driver MUST NOT send IRQ messages for a GPIO line configured for
+    output.
+
+\item The driver MUST set the IRQ trigger type to
+    \field{VIRTIO_GPIO_IRQ_TYPE_NONE} once it is done using the GPIO line
+    configured for interrupts.
+
+\item In order to change the trigger type of an already enabled interrupt, the
+    driver MUST first disable the interrupt and then re-enable it with
+    appropriate trigger type.
 \end{itemize}
 
 \devicenormative{\subsubsection}{requestq Operation}{Device Types / GPIO Device / requestq Operation}
@@ -344,4 +449,145 @@ \subsubsection{requestq Operation: Message Flow}\label{sec:Device Types / GPIO D
 \item The device MUST discard all state information corresponding to a GPIO
     line, once the driver has requested to set its direction to
     \field{VIRTIO_GPIO_DIRECTION_NONE}.
+
+\item The device MUST latch an edge interrupt if the interrupt is enabled but
+    still masked.
+
+\item The device MUST NOT latch an level interrupt if the interrupt is enabled
+    but still masked.
+
+\item The device MUST discard any latched interrupt for a GPIO line, once
+    interrupt is disabled for the same.
+\end{itemize}
+
+\subsection{Device Operation: eventq}\label{sec:Device Types / GPIO Device / eventq Operation}
+
+The \field{eventq} virtqueue is used by the driver to unmask the interrupts and
+used by the device to notify the driver of newly sensed interrupts. In order to
+unmask interrupt on a GPIO line, the driver queues a pair of buffers,
+\field{struct virtio_gpio_irq_request} (filled by driver) and \field{struct
+virtio_gpio_irq_response} (to be filled by device later), to the \field{eventq}
+virtqueue. A separate pair of buffers must be queued for each GPIO line, the
+driver wants to configure for interrupts. The device, on sensing an interrupt,
+returns the pair of buffers for the respective GPIO line, which also masks the
+interrupts. The driver can queue the buffers again to unmask the interrupt.
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
+\item[\field{status}] of the interrupt event,
+    \field{VIRTIO_GPIO_IRQ_STATUS_VALID} on interrupt and
+    \field{VIRTIO_GPIO_IRQ_STATUS_INVALID} to return the buffers back to the
+    driver after interrupt is disabled.
+\end{description}
+
+\subsubsection{eventq Operation: Message Flow}\label{sec:Device Types / GPIO Device / eventq Operation / Message Flow}
+
+\begin{itemize}
+\item The virtio-gpio driver is requested by a client driver to enable interrupt
+    for a GPIO line and configure it to a particular trigger type.
+
+\item The driver sends the \field{VIRTIO_GPIO_MSG_SET_IRQ_TYPE} message, over
+    the \field{requestq} virtqueue, and the device configures the GPIO line for
+    the requested trigger type and enables the interrupt. The interrupt is still
+    masked for delivery though. The device shall latch the interrupt from now
+    onward for edge trigger type.
+
+\item The driver unmasks the interrupt by queuing a pair of buffers to the
+    \field{eventq} virtqueue for the GPIO line. The driver can do this before
+    enabling the interrupt as well, though the interrupt must be both unmasked
+    and enabled to get delivered at the driver.
+
+\item The driver notifies the device of the presence of new buffers on the
+    \field{eventq} virtqueue. The interrupt is fully configured at this point.
+
+\item The device, on sensing an active interrupt on the GPIO line, finds the
+    matching buffers (based on GPIO line number) from the \field{eventq}
+    virtqueue and update its \field{struct virtio_gpio_irq_response} buffer's
+    \field{status} with \field{VIRTIO_GPIO_IRQ_STATUS_VALID} and returns the
+    pair of buffers to the device. This results in masking the interrupt as
+    well.
+
+\item The device notifies the driver of the presence of returned buffers on the
+    \field{eventq} virtqueue.
+
+\item If the GPIO line is configured for level interrupts, the device ignores
+    any further interrupt signals on this GPIO line, until the interrupt is
+    unmasked again by the driver by making the buffers available to the device.
+    Once the interrupt is unmasked again and the interrupt on the line is still
+    active, the device shall notify the driver again.
+
+\item If the GPIO line is configured for edge interrupts, the device latches
+    the interrupt received for this GPIO line, until the interrupt is unmasked
+    again by the driver by making the buffers available to the device. Once the
+    interrupt is unmasked again and an interrupt was latched earlier, the
+    device shall notify the driver again.
+
+\item The driver on receiving the notification from the device, processes the
+    interrupt. The interrupt is masked at the device until the buffers are
+    queued again by the driver.
+
+\item In a typical guest operating system kernel, the virtio-gpio driver
+    notifies the client driver, that is associated with this GPIO line, to
+    process the event. In the case of a level triggered interrupt, the client
+    driver shall fully process and acknowledge the event at its source to return
+    the line to its inactive state before the interrupt is unmasked again to
+    avoid a spurious interrupt.
+
+\item Once the interrupt is handled, the driver may queue a pair of buffers for
+    the GPIO line to unmask the interrupt again.
+
+\item The driver can also disable the interrupt by sending the
+    \field{VIRTIO_GPIO_MSG_SET_IRQ_TYPE} message, with
+    \field{VIRTIO_GPIO_IRQ_TYPE_NONE} trigger type. In that case, the device
+    shall return the unused pair of buffers for the GPIO line after setting the
+    \field{status} field with \field{VIRTIO_GPIO_IRQ_STATUS_INVALID}.
+\end{itemize}
+
+\drivernormative{\subsubsection}{eventq Operation}{Device Types / GPIO Device / eventq Operation}
+
+\begin{itemize}
+\item The driver MUST both enable and unmask the interrupt in order to get
+    notified for the same.
+
+\item To unmask the interrupt, the driver MUST queue a separate pair of buffers
+    to the \field{eventq} virtqueue for each GPIO line.
+
+\item The driver MUST NOT add multiple pairs of buffers for the same GPIO line
+    on the \field{eventq} virtqueue.
+\end{itemize}
+
+\devicenormative{\subsubsection}{eventq Operation}{Device Types / GPIO Device / eventq Operation}
+
+\begin{itemize}
+\item The device CAN ONLY send an interrupt event to the driver for a GPIO line,
+    if the interrupt is both unmasked and enabled by the driver.
+
+\item On receiving \field{VIRTIO_GPIO_MSG_SET_IRQ_TYPE} message, with
+    \field{VIRTIO_GPIO_IRQ_TYPE_NONE} trigger type, the device MUST return the
+    buffers, if they were received earlier, after setting the \field{status}
+    field to \field{VIRTIO_GPIO_IRQ_STATUS_INVALID}.
 \end{itemize}
-- 
2.31.1.272.g89b43f80a514

