Return-Path: <viresh.kumar@linaro.org>
Date: Thu, 29 Jul 2021 16:29:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V7 2/2] virtio-gpio: Add support for interrupts
Message-ID: <20210729105957.zem2tbhixoxuxry6@vireshk-i7>
References: <cover.1627469463.git.viresh.kumar@linaro.org>
 <0dac5ab26a5fcc94ec530dbf83247788922123d7.1627469463.git.viresh.kumar@linaro.org>
 <CAK8P3a0x5OcQu1FuhhbEbcmvw1VDLQGR9-WFkA24nJTeDZtErw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0x5OcQu1FuhhbEbcmvw1VDLQGR9-WFkA24nJTeDZtErw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 28-07-21, 14:05, Arnd Bergmann wrote:
> I think the last sentence here is somewhat ambiguous, I'm not sure
> what it actually
> means to unmask a level triggered line if the driver has not queued an
> event request
> for that line.

I think I now understand what you meant by this, I wasn't thinking of
fasteoi earlier :)

What about following diff over this patch:

diff --git a/virtio-gpio.tex b/virtio-gpio.tex
index ffc89b98f34e..0085708151d7 100644
--- a/virtio-gpio.tex
+++ b/virtio-gpio.tex
@@ -288,17 +288,31 @@ \subsubsection{requestq Operation: Set Value}\label{sec:Device Types / GPIO Devi

 \subsubsection{requestq Operation: Set IRQ Type}\label{sec:Device Types / GPIO Device / requestq Operation / Set IRQ Type}

+This request is only allowed if the \field{VIRTIO_GPIO_F_IRQ} feature is enabled
+by the device.
+
 The driver sends this message to request the device to set the IRQ trigger type,
 to one of the \field{VIRTIO_GPIO_IRQ_TYPE_*} values, for a line configured for
 input.

-This request is only allowed if the \field{VIRTIO_GPIO_F_IRQ} feature is
-enabled by the device.
+The device notifies the driver of an interrupt event using the per GPIO line
+buffers provided by the driver on the \field{eventq} virtqueue.

 The device MUST mask the interrupt for a GPIO line, if the trigger type is set
 to \field{VIRTIO_GPIO_IRQ_TYPE_NONE} and also discard any latched interrupt
-status associated with the line. The device MUST unmask the interrupt for any
-other value of the trigger type.
+event associated with the line. The device MUST NOT notify the driver of an
+interrupt event if the trigger type is set to \field{VIRTIO_GPIO_IRQ_TYPE_NONE}
+for the GPIO line.
+
+The device MUST unmask the interrupt for any other value of the trigger type and
+notify the driver of an interrupt event once the corresponding buffers are
+available.
+
+For edge trigger type, the device MUST latch the interrupt event from this point
+onward and report it to the driver as soon as a buffers are available.
+
+For level trigger type, the device only reports an interrupt if the
+corresponding interrupt level was sensed when the buffers are received.

 \begin{tabularx}{\textwidth}{ |l||X|X|X| }
 \hline
@@ -366,7 +380,7 @@ \subsubsection{requestq Operation: Message Flow}\label{sec:Device Types / GPIO D
 \item The driver MUST NOT send IRQ messages if the \field{VIRTIO_GPIO_F_IRQ}
     feature is not enabled by the device.

-\item The driver MUST set the IRQ trigger type to
+\item The driver SHOULD set the IRQ trigger type to
     \field{VIRTIO_GPIO_IRQ_TYPE_NONE} once it is done using the GPIO line,
     previously configured for a different trigger type.
 \end{itemize}
@@ -445,19 +459,19 @@ \subsection{Device Operation: eventq}\label{sec:Device Types / GPIO Device / eve
 \subsubsection{eventq Operation: Message Flow}\label{sec:Device Types / GPIO Device / eventq Operation / Message Flow}

 \begin{itemize}
-\item The driver is requested by a user to enable interrupt for a GPIO and
+\item The driver is requested by a client to enable interrupt for a GPIO and
     configure it for a particular trigger type.

+\item The driver sends the \field{VIRTIO_GPIO_MSG_SET_IRQ_TYPE} message over the
+    \field{requestq} virtqueue and the device configures the GPIO line for the
+    requested trigger type and unmasks the interrupt.
+
 \item The driver queues a pair of buffers, interrupt-request and
     interrupt-response, to the \field{eventq} virtqueue for the GPIO line.

 \item The driver notifies the device of the presence of new buffers on the
     \field{eventq} virtqueue.

-\item The driver sends the \field{VIRTIO_GPIO_MSG_SET_IRQ_TYPE} message over the
-    \field{requestq} virtqueue and the device configures the GPIO line for the
-    requested trigger type and unmasks the interrupt.
-
 \item The interrupt is fully configured at this point.

 \item The device, on sensing an interrupt on a GPIO line, finds the matching
@@ -469,19 +483,29 @@ \subsubsection{eventq Operation: Message Flow}\label{sec:Device Types / GPIO Dev
 \item The device notifies the driver of the presence of new buffers on the
     \field{eventq} virtqueue.

-\item If the GPIO line is configured for Level interrupts, the device MUST mask
-    the interrupts for this GPIO line, until the time the buffers are made
-    available again by the driver.
+\item If the GPIO line is configured for level interrupts, the device MUST
+    ignore the interrupts for this GPIO line, until the time the buffers are
+    made available again by the driver. Once the buffers are available again,
+    and the interrupt on the line is still active, the device can again notify
+    the driver of an interrupt event.

-\item If the GPIO line is configured for Edge interrupts, the device MUST latch
+\item If the GPIO line is configured for edge interrupts, the device MUST latch
     the latest interrupt received for this GPIO line, until the time the buffers
     are made available again by the driver. At that point, the device can again
-    return the buffers for the line if an interrupt was received while the
-    device was waiting for the buffers to be made available by the driver.
+    notify the driver if an interrupt was received while the device was waiting
+    for the buffers to be made available by the driver.

 \item The driver on receiving the notification from the device, processes the
     interrupt. The driver may try to update the trigger-type of the interrupt
-    for the GPIO line over the \field{requestq} virtqueue.
+    for the GPIO line over the \field{requestq} virtqueue at this point.
+
+\item In a typical guest operating system kernel, the virtio-gpio driver
+    notifies the client driver that is associated with this gpio line to process
+    the event.
+
+\item In the case of a level triggered interrupt, the client driver must fully
+    process and acknowledge the event at its source to return the line to its
+    inactive state.

 \item The driver may again queue, same or new, pair of buffers for that GPIO
     line and notify the device.

