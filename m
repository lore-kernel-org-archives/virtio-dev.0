Return-Path: <virtio-dev-return-8305-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B516F9864BE
	for <virtio-dev@lists.oasis-open.org>; Fri, 16 Jul 2021 07:40:03 +0000 (UTC)
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 16 Jul 2021 13:09:19 +0530
Message-Id: <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1626418779.git.viresh.kumar@linaro.org>
References: <cover.1626418779.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH V5 2/2] virtio-gpio: Add support for interrupts
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

This patch adds support for interrupts to the virtio-gpio specification.
This uses the feature bit 0 for the same.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 virtio-gpio.tex | 153 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 150 insertions(+), 3 deletions(-)

diff --git a/virtio-gpio.tex b/virtio-gpio.tex
index 40020620d714..56e0bde4d986 100644
--- a/virtio-gpio.tex
+++ b/virtio-gpio.tex
@@ -20,7 +20,9 @@ \subsection{Virtqueues}\label{sec:Device Types / GPIO Dev=
ice / Virtqueues}
=20
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
@@ -79,6 +81,12 @@ \subsection{Device Initialization}\label{sec:Device Type=
s / GPIO Device / Device
=20
 \item The driver MUST populate the \field{rxq} virtqueue with \field{struc=
t
       virtio_gpio_msg} buffer.
+
+\item The driver MUST check the presence of \field{VIRTIO_GPIO_F_IRQ} feat=
ure
+      before initiating any IRQ messages.
+
+\item The device MUST mask interrupts on all the GPIO lines, if the
+      \field{VIRTIO_GPIO_F_IRQ} feature is supported.
 \end{itemize}
=20
 \subsection{Device Operation}\label{sec:Device Types / GPIO Device / Devic=
e Operation}
@@ -111,8 +119,12 @@ \subsection{Device Operation}\label{sec:Device Types /=
 GPIO Device / Device Oper
 with VIRTIO_GPIO_MSG_RESPONSE mask and updating the \field{value} field ba=
sed on
 message type.
=20
-For the current version of the specification, the sender is always the dri=
ver
-and receiver is always the device.
+The device is the sender only for the messages of type
+\field{VIRTIO_GPIO_MSG_IRQ_EVENT} and the device sends it over the \field{=
rxq}
+virtqueue.
+
+The driver is the sender for all other message types and send them over
+\field{txq} virtqueue.
=20
 \begin{lstlisting}
 /* GPIO message types: driver -> device */
@@ -123,11 +135,27 @@ \subsection{Device Operation}\label{sec:Device Types =
/ GPIO Device / Device Oper
 #define VIRTIO_GPIO_MSG_SET_DIRECTION_OUT       0x0005
 #define VIRTIO_GPIO_MSG_GET_VALUE               0x0006
 #define VIRTIO_GPIO_MSG_SET_VALUE               0x0007
+#define VIRTIO_GPIO_MSG_IRQ_TYPE                0x0008
+#define VIRTIO_GPIO_MSG_IRQ_MASK                0x0009
+#define VIRTIO_GPIO_MSG_IRQ_UNMASK              0x000a
+
+/* GPIO message type: from device -> driver */
+#define VIRTIO_GPIO_MSG_IRQ_EVENT               0x000b
=20
 /* GPIO response mask, to be Or'ed with one of the above */
 #define VIRTIO_GPIO_MSG_RESPONSE                    0x8000
 \end{lstlisting}
=20
+\begin{lstlisting}
+/* GPIO interrupt type */
+#define VIRTIO_GPIO_IRQ_TYPE_NONE               0x00
+#define VIRTIO_GPIO_IRQ_TYPE_EDGE_RISING        0x01
+#define VIRTIO_GPIO_IRQ_TYPE_EDGE_FALLING       0x02
+#define VIRTIO_GPIO_IRQ_TYPE_EDGE_BOTH          0x03
+#define VIRTIO_GPIO_IRQ_TYPE_LEVEL_HIGH         0x04
+#define VIRTIO_GPIO_IRQ_TYPE_LEVEL_LOW          0x08
+\end{lstlisting}
+
 The response messages may contain error codes (in the \field{value} field)=
 on
 failures, they must be read as negative POSIX errno codes, unless stated
 otherwise, i.e. 0 as success, and negative value as POSIX error code, posi=
tive
@@ -238,6 +266,81 @@ \subsubsection{Device Operation: Set Value}\label{sec:=
Device Types / GPIO Device
 \hline
 \end{tabular}
=20
+\subsubsection{Device Operation: IRQ Type}\label{sec:Device Types / GPIO D=
evice / Device Operation / IRQ Type }
+
+The driver initiates this message to request the device to set the IRQ tri=
gger
+type to one of the \field{VIRTIO_GPIO_IRQ_TYPE_*} values, for a line confi=
gured
+for input.
+
+This request is only allowed if the \field{VIRTIO_GPIO_F_IRQ} feature is
+supported by the device.
+
+\begin{tabular}{ |l||l|l|l| }
+\hline
+Fields & \field{type} & \field{gpio} & \field{value} \\
+\hline
+Message & \field{VIRTIO_GPIO_MSG_IRQ_TYPE} & line number & one of \field{V=
IRTIO_GPIO_IRQ_TYPE_*} \\
+\hline
+Response & \field{VIRTIO_GPIO_MSG_IRQ_TYPE} \newline | \field{VIRTIO_GPIO_=
MSG_RESPONSE} & line number & 0 =3D success, \newline or -errno =3D failure=
 \\
+\hline
+\end{tabular}
+
+\subsubsection{Device Operation: IRQ Mask}\label{sec:Device Types / GPIO D=
evice / Device Operation / IRQ Mask }
+
+The driver initiates this message to request the device to mask IRQ on a G=
PIO
+line configured for input.
+
+This request is only allowed if the \field{VIRTIO_GPIO_F_IRQ} feature is
+supported by the device.
+
+\begin{tabular}{ |l||l|l|l| }
+\hline
+Fields & \field{type} & \field{gpio} & \field{value} \\
+\hline
+Message & \field{VIRTIO_GPIO_MSG_IRQ_MASK} & line number & 0 \\
+\hline
+Response & \field{VIRTIO_GPIO_MSG_IRQ_MASK} \newline | \field{VIRTIO_GPIO_=
MSG_RESPONSE} & line number & 0 =3D success, \newline or -errno =3D failure=
 \\
+\hline
+\end{tabular}
+
+\subsubsection{Device Operation: IRQ Unmask}\label{sec:Device Types / GPIO=
 Device / Device Operation / IRQ Unmask }
+
+The driver initiates this message to request the device to unmask IRQ on a=
 GPIO
+line configured for input.
+
+This request is only allowed if the \field{VIRTIO_GPIO_F_IRQ} feature is
+supported by the device.
+
+\begin{tabular}{ |l||l|l|l| }
+\hline
+Fields & \field{type} & \field{gpio} & \field{value} \\
+\hline
+Message & \field{VIRTIO_GPIO_MSG_IRQ_UNMASK} & line number & 0 \\
+\hline
+Response & \field{VIRTIO_GPIO_MSG_IRQ_UNMASK} \newline | \field{VIRTIO_GPI=
O_MSG_RESPONSE} & line number & 0 =3D success, \newline or -errno =3D failu=
re \\
+\hline
+\end{tabular}
+
+\subsubsection{Device Operation: IRQ Event}\label{sec:Device Types / GPIO =
Device / Device Operation / IRQ Event }
+
+The device initiates this message to notify the driver of an IRQ event on =
a line
+previously configured for interrupt.
+
+This request is only allowed if the \field{VIRTIO_GPIO_F_IRQ} feature is
+supported by the device.
+
+This is the only message which is initiated by the device and not the driv=
er.
+
+\begin{tabular}{ |l||l|l|l| }
+\hline
+Fields & \field{type} & \field{gpio} & \field{value} \\
+\hline
+Message & \field{VIRTIO_GPIO_MSG_IRQ_EVENT} & line number & 0 \\
+\hline
+Response & \field{VIRTIO_GPIO_MSG_IRQ_EVENT} \newline | \field{VIRTIO_GPIO=
_MSG_RESPONSE} & line number & 0 =3D success, \newline or -errno =3D failur=
e \\
+\hline
+\end{tabular}
+
 \drivernormative{\subsubsection}{Device Operation}{Device Types / GPIO Dev=
ice / Device Operation}
=20
 \begin{itemize}
@@ -252,6 +355,11 @@ \subsubsection{Device Operation: Set Value}\label{sec:=
Device Types / GPIO Device
=20
 \item The driver MUST NOT initiate another message for a GPIO line, before
       response to the previously sent message is received for the same lin=
e.
+
+\item The driver MUST NOT send IRQ messages for a GPIO line configured for=
 output.
+
+\item The driver MUST NOT initiate IRQ messages if the \field{VIRTIO_GPIO_=
F_IRQ}
+      feature is not supported by the device.
 \end{itemize}
=20
 \devicenormative{\subsubsection}{Device Operation}{Device Types / GPIO Dev=
ice / Device Operation}
@@ -315,3 +423,42 @@ \subsubsection{Driver Requests}\label{sec:Device Types=
 / GPIO Device / Message F
 \item The driver can initiate an request for a different GPIO line before
       receiving response for a previous request for another line.
 \end{itemize}
+
+\subsubsection{Device Interrupts}\label{sec:Device Types / GPIO Device / M=
essage Flow / Interrupts}
+
+The \field{VIRTIO_GPIO_MSG_IRQ_EVENT} message type can only be initiated b=
y the
+device and sent to the driver over the \field{rxq} virtqueue.
+
+\begin{itemize}
+\item The device, on sensing an interrupt for a GPIO line, prepares a buff=
er of
+      type \field{struct virtio_gpio_msg} and sets its \field{type} to
+      \field{VIRTIO_GPIO_MSG_IRQ_EVENT}, \field{gpio} field with a GPIO li=
ne
+      number, and \field{value} field to 0.
+
+\item The device sends the buffer to the driver over the \field{rxq} virtq=
ueue.
+
+\item The device MUST NOT initiate another interrupt request for the same =
GPIO
+      line before receiving a response from the driver.
+
+\item The driver, after receiving the buffer from the driver, handles the
+      interrupt.
+
+\item The driver at this point may initiate a new request (like masking of=
 the
+      IRQ line) and send it over to the device over the \field{txq} virtqu=
eue.
+      The device must respond to them, without waiting for a response to t=
he
+      IRQ itself.
+
+\item The driver prepares a buffer of type \field{struct virtio_gpio_msg} =
and
+      sets its \field{type} field to (\field{VIRTIO_GPIO_MSG_IRQ_EVENT} |
+      \field{VIRTIO_GPIO_MSG_RESPONSE}), \field{gpio} field with \field{gp=
io} of
+      the received buffer, and \field{value} to message defined value.
+
+\item The driver sends the buffer to the device over the \field{txq} virtq=
ueue.
+
+\item The device receives and processes the buffer.
+
+\item The device can initiate another IRQ request for the same GPIO line n=
ow.
+
+\item The driver can initiate an IRQ request for a different GPIO line bef=
ore
+      receiving response for a previous IRQ request for another line.
+\end{itemize}
--=20
2.31.1.272.g89b43f80a514


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

