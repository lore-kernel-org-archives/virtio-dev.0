Return-Path: <virtio-dev-return-8356-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F215D986505
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Jul 2021 15:28:44 +0000 (UTC)
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 20 Jul 2021 20:58:33 +0530
Message-Id: <8ebe189f12f8f46b17f92f9e2fc3f49e2e3de0a2.1626794843.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1626794843.git.viresh.kumar@linaro.org>
References: <cover.1626794843.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH V6 2/2] virtio-gpio: Add support for interrupts
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

This patch adds support for interrupts to the virtio-gpio specification.
This uses the feature bit 0 for the same.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 conformance.tex |   2 +
 virtio-gpio.tex | 241 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 242 insertions(+), 1 deletion(-)

diff --git a/conformance.tex b/conformance.tex
index c52f1a40be2d..64bcc12d1199 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -310,6 +310,7 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
=20
 \begin{itemize}
 \item \ref{drivernormative:Device Types / GPIO Device / requestq Operation=
}
+\item \ref{drivernormative:Device Types / GPIO Device / eventq Operation}
 \end{itemize}
=20
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device =
Conformance}
@@ -568,6 +569,7 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
=20
 \begin{itemize}
 \item \ref{devicenormative:Device Types / GPIO Device / requestq Operation=
}
+\item \ref{devicenormative:Device Types / GPIO Device / eventq Operation}
 \end{itemize}
=20
 \conformance{\section}{Legacy Interface: Transitional Device and Transitio=
nal Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitio=
nal Device and Transitional Driver Conformance}
diff --git a/virtio-gpio.tex b/virtio-gpio.tex
index fa48780a29db..f432a3f3ad0d 100644
--- a/virtio-gpio.tex
+++ b/virtio-gpio.tex
@@ -11,11 +11,17 @@ \subsection{Virtqueues}\label{sec:Device Types / GPIO D=
evice / Virtqueues}
=20
 \begin{description}
 \item[0] requestq
+\item[1] eventq
 \end{description}
=20
+The \field{eventq} virtqueue is available only if the \field{VIRTIO_GPIO_F=
_IRQ}
+feature is enabled by the device.
+
 \subsection{Feature bits}\label{sec:Device Types / GPIO Device / Feature b=
its}
=20
-None currently defined.
+\begin{description}
+\item[VIRTIO_GPIO_F_IRQ (0)] The device supports interrupts on GPIO lines.
+\end{description}
=20
 \subsection{Device configuration layout}\label{sec:Device Types / GPIO Dev=
ice / Device configuration layout}
=20
@@ -46,6 +52,15 @@ \subsection{Device Initialization}\label{sec:Device Type=
s / GPIO Device / Device
=20
 \begin{itemize}
 \item The driver MUST configure and initialize the \field{requestq} virtqu=
eue.
+
+\item The driver MUST check the presence of \field{VIRTIO_GPIO_F_IRQ} feat=
ure
+    before initiating any IRQ messages.
+
+\item The driver MUST configure and initialize the \field{eventq} virtqueu=
e if
+    the \field{VIRTIO_GPIO_F_IRQ} feature is enabled by the device.
+
+\item The device MUST have interrupts on all the GPIO lines masked, if the
+    \field{VIRTIO_GPIO_F_IRQ} feature is supported.
 \end{itemize}
=20
 \subsection{Device Operation: requestq}\label{sec:Device Types / GPIO Devi=
ce / requestq Operation}
@@ -111,6 +126,19 @@ \subsection{Device Operation: requestq}\label{sec:Devi=
ce Types / GPIO Device / r
 #define VIRTIO_GPIO_MSG_SET_DIRECTION_OUT       0x0006
 #define VIRTIO_GPIO_MSG_GET_VALUE               0x0007
 #define VIRTIO_GPIO_MSG_SET_VALUE               0x0008
+#define VIRTIO_GPIO_MSG_IRQ_TYPE                0x0009
+#define VIRTIO_GPIO_MSG_IRQ_MASK                0x000a
+#define VIRTIO_GPIO_MSG_IRQ_UNMASK              0x000b
+\end{lstlisting}
+
+\begin{lstlisting}
+/* GPIO interrupt types */
+#define VIRTIO_GPIO_IRQ_TYPE_NONE               0x00
+#define VIRTIO_GPIO_IRQ_TYPE_EDGE_RISING        0x01
+#define VIRTIO_GPIO_IRQ_TYPE_EDGE_FALLING       0x02
+#define VIRTIO_GPIO_IRQ_TYPE_EDGE_BOTH          0x03
+#define VIRTIO_GPIO_IRQ_TYPE_LEVEL_HIGH         0x04
+#define VIRTIO_GPIO_IRQ_TYPE_LEVEL_LOW          0x08
 \end{lstlisting}
=20
 \subsubsection{requestq Operation: Get Names}\label{sec:Device Types / GPI=
O Device / requestq Operation / Get Names}
@@ -294,6 +322,79 @@ \subsubsection{requestq Operation: Set Value}\label{se=
c:Device Types / GPIO Devi
 \hline
 \end{tabularx}
=20
+\subsubsection{requestq Operation: IRQ Type}\label{sec:Device Types / GPIO=
 Device / requestq Operation / IRQ Type}
+
+The driver initiates this message to request the device to set the IRQ tri=
gger
+type, to one of the \field{VIRTIO_GPIO_IRQ_TYPE_*} values, for a line conf=
igured
+for input.
+
+This request is only allowed if the \field{VIRTIO_GPIO_F_IRQ} feature is
+enabled by the device.
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_MSG_IRQ_TYPE} & line number & one of \field{VIRTIO_GP=
IO_IRQ_TYPE_*} \\
+\hline
+\end{tabularx}
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Response} & \field{status} & \field{value[N]} & \field{Where N is}=
 \\
+\hline
+& \field{VIRTIO_GPIO_STATUS_*} & 0 & 1 \\
+\hline
+\end{tabularx}
+
+\subsubsection{requestq Operation: IRQ Mask}\label{sec:Device Types / GPIO=
 Device / requestq Operation / IRQ Mask}
+
+The driver initiates this message to request the device to mask IRQ on a G=
PIO
+line configured for input.
+
+This request is only allowed if the \field{VIRTIO_GPIO_F_IRQ} feature is
+enabled by the device.
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_MSG_IRQ_MASK} & line number & 0 \\
+\hline
+\end{tabularx}
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Response} & \field{status} & \field{value[N]} & \field{Where N is}=
 \\
+\hline
+& \field{VIRTIO_GPIO_STATUS_*} & 0 & 1 \\
+\hline
+\end{tabularx}
+
+\subsubsection{requestq Operation: IRQ Unmask}\label{sec:Device Types / GP=
IO Device / requestq Operation / IRQ Unmask}
+
+The driver initiates this message to request the device to unmask IRQ on a=
 GPIO
+line configured for input.
+
+This request is only allowed if the \field{VIRTIO_GPIO_F_IRQ} feature is
+enabled by the device.
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
+\hline
+& \field{VIRTIO_GPIO_MSG_IRQ_UNMASK} & line number & 0 \\
+\hline
+\end{tabularx}
+
+\begin{tabularx}{\textwidth}{ |l||X|X|X| }
+\hline
+\textbf{Response} & \field{status} & \field{value[N]} & \field{Where N is}=
 \\
+\hline
+& \field{VIRTIO_GPIO_STATUS_*} & 0 & 1 \\
+\hline
+\end{tabularx}
+
 \subsubsection{requestq Operation: Message Flow}\label{sec:Device Types / =
GPIO Device / requestq Operation / Message Flow}
=20
 \begin{itemize}
@@ -343,6 +444,17 @@ \subsubsection{requestq Operation: Message Flow}\label=
{sec:Device Types / GPIO D
 \item The driver MUST NOT send another message, of any type, for a GPIO li=
ne
     before receiving a response from the device for the previously sent me=
ssage
     for the same GPIO line.
+
+\item The driver MUST NOT send IRQ messages for a GPIO line configured for
+    output.
+
+\item The driver MUST NOT initiate IRQ messages if the \field{VIRTIO_GPIO_=
F_IRQ}
+    feature is not enabled by the device.
+
+\item If the driver has sent the \field{VIRTIO_GPIO_MSG_IRQ_UNMASK} messag=
e
+    earlier for a GPIO line, then it MUST send the
+    \field{VIRTIO_GPIO_MSG_IRQ_MASK} message over the \field{requestq}
+    virtqueue, if it no longer wants to receive interrupts from the device=
.
 \end{itemize}
=20
 \devicenormative{\subsubsection}{requestq Operation}{Device Types / GPIO D=
evice / requestq Operation}
@@ -367,3 +479,130 @@ \subsubsection{requestq Operation: Message Flow}\labe=
l{sec:Device Types / GPIO D
 \item The device MAY process messages out of order and in parallel and MAY=
 send
     message's response to the driver out of order.
 \end{itemize}
+
+\subsection{Device Operation: eventq}\label{sec:Device Types / GPIO Device=
 / eventq Operation}
+
+The \field{eventq} virtqueue is used for sending interrupt events from the
+device to the driver. The driver queues a separate pair of buffers,
+interrupt-request (filled by driver) and interrupt-response (to be filled =
by
+device later), to the \field{eventq} virtqueue for each GPIO line. The dev=
ice,
+on sensing an interrupt, returns the pair of buffers of the respective GPI=
O line
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
+\item[\field{gpio}] is the GPIO line number, i.e. 0 <=3D \field{gpio} <
+    \field{ngpio}.
+\end{description}
+
+\begin{lstlisting}
+struct virtio_gpio_irq_response {
+    u8 status;
+};
+
+/* Possible values of the interrupt status field */
+#define VIRTIO_GPIO_IRQ_INVALID                 0x0
+#define VIRTIO_GPIO_IRQ_VALID                   0x1
+\end{lstlisting}
+
+This structure is filled by the device and read by the driver.
+
+\begin{description}
+\item[\field{status}] of the interrupt event, \field{VIRTIO_GPIO_IRQ_VALID=
} on
+    valid interrupt and \field{VIRTIO_GPIO_IRQ_INVALID} otherwise on retur=
ning
+    the buffer back to the driver without an interrupt.
+\end{description}
+
+\subsubsection{eventq Operation: Message Flow}\label{sec:Device Types / GP=
IO Device / eventq Operation / Message Flow}
+
+\begin{itemize}
+\item The driver is requested by a user to enable interrupt for a GPIO and
+    configure it to a particular type.
+
+\item The driver sends the \field{VIRTIO_GPIO_MSG_IRQ_TYPE} message over t=
he
+    \field{requestq} virtqueue and the device configures the GPIO line for=
 the
+    same and responds.
+
+\item The driver queues a pair of buffers, interrupt-request and
+    interrupt-response, to the \field{eventq} virtqueue for the GPIO line.
+
+\item The driver notifies the device of the presence of new buffers on the
+    \field{eventq} virtqueue.
+
+\item The driver sends the \field{VIRTIO_GPIO_MSG_IRQ_UNMASK} message over=
 the
+    \field{requestq} virtqueue and the device configures the GPIO line for=
 the
+    same and responds.
+
+\item The interrupt is fully configured at this point.
+
+\item The device, on sensing an interrupt on a GPIO line, finds the matchi=
ng
+    buffers (based on GPIO line number) from the \field{eventq} virtqueue =
and
+    fills its \field{struct virtio_gpio_irq_response} buffer's \field{stat=
us}
+    with \field{VIRTIO_GPIO_IRQ_VALID} and returns the pair of buffers to =
the
+    device.
+
+\item The device notifies the driver of the presence of new buffers on the
+    \field{eventq} virtqueue.
+
+\item If the GPIO line is configured for Level interrupts, the device MUST
+    ignore any further interrupts for the line, until the time the buffers=
 are
+    made available again by the driver.
+
+\item If the GPIO line is configured for Edge interrupts, the device MUST =
latch
+    the latest interrupt received for the line, until the time the buffers=
 are
+    made available again by the driver. At that point, the device can agai=
n
+    return the buffers for the line if an interrupt was received while the
+    device was waiting for the buffers to be made available by the driver.
+
+\item The driver on receiving the notification from the device, processes =
the
+    interrupt. The driver may try to mask/unmask the interrupts for the GP=
IO
+    line over the \field{requestq} virtqueue.
+
+\item The driver may again queue, same or new, pair of buffers for that GP=
IO
+    line and notify the device.
+
+\item The driver may send the \field{VIRTIO_GPIO_MSG_IRQ_MASK} message ove=
r the
+    \field{requestq} virtqueue, once it no longer wants to receive the
+    interrupts for a GPIO line.
+
+\item The device must return the unused pair of buffers for that GPIO line=
, over
+    the \field{eventq} virtqueue, by setting the \field{status} field with
+    \field{VIRTIO_GPIO_IRQ_INVALID}.
+
+\item The driver can then free the associated buffer and remove it from th=
e
+    \field{eventq} virtqueue.
+\end{itemize}
+
+\drivernormative{\subsubsection}{eventq Operation}{Device Types / GPIO Dev=
ice / eventq Operation}
+
+\begin{itemize}
+\item The driver MUST queue a separate pair of buffers, interrupt-request =
and
+    interrupt-response, to the \field{eventq} virtqueue for each GPIO line=
 for
+    which it is expecting an interrupt from the device.
+
+\item The driver MUST not queue a pair of buffers for a GPIO line which it=
 is
+    not going to use as interrupt source, otherwise the buffer may never b=
e
+    freed by the device (as no unmask request will follow from the driver)=
.
+
+\item The driver MUST NOT add multiple pairs of buffers for the same GPIO =
line
+    on the \field{eventq} virtqueue. And so there can only be one interrup=
t
+    event for each GPIO line at any point of time.
+
+\item The pair of buffers for any GPIO line can either be owned by the dev=
ice or
+    the driver at any particular point of time, but not both.
+\end{itemize}
+
+\devicenormative{\subsubsection}{eventq Operation}{Device Types / GPIO Dev=
ice / eventq Operation}
+
+\begin{itemize}
+\item The device can send an interrupt event for a GPIO line to the driver=
, only
+    if a buffer for that GPIO line is provided by the driver in the first =
place
+    on the \field{eventq} virtqueue.
+\end{itemize}
--=20
2.31.1.272.g89b43f80a514


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

