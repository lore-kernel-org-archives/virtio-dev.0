Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1627627021.git.viresh.kumar@linaro.org> <33671b4e543557740acf85bc30ed8ad1ba9ef8aa.1627627021.git.viresh.kumar@linaro.org>
In-Reply-To: <33671b4e543557740acf85bc30ed8ad1ba9ef8aa.1627627021.git.viresh.kumar@linaro.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 30 Jul 2021 10:08:43 +0200
Message-ID: <CAK8P3a1G-TNkCxXg-FTAP6iqPyyJHU_gNGGF3ZqH8=5inASY5g@mail.gmail.com>
Subject: Re: [PATCH V8 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 30, 2021 at 8:45 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This patch adds support for interrupts to the virtio-gpio specification.
> This uses the feature bit 0 for the same.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>


I think the flow you describe now addresses all the important concerns I had.
I feel the text you use additional copy-editing, but I'm not a native English
speaker myself and not qualified for that. Hope someone else can help out
with that.

A few more comments on some details:

> +If the trigger type is set to \field{VIRTIO_GPIO_IRQ_TYPE_NONE}, the device MUST
> +mask the interrupt for the GPIO line and discard any latched interrupt event
> +associated with it. The device MUST also return any unused pair of buffers
> +for the GPIO line, over the \field{eventq} virtqueue, after setting the
> +\field{status} field to \field{VIRTIO_GPIO_IRQ_STATUS_INVALID}. If the driver
> +queues another pair of buffers, while the trigger type remains set as
> +\field{VIRTIO_GPIO_IRQ_TYPE_NONE}, the device MUST wait for another message of
> +type \field{VIRTIO_GPIO_MSG_SET_IRQ_TYPE} before using the newly queued buffers.

We discussed this last part before, and you had already said you
prefer this ordering,
but after you explain it here, the interaction of VIRTIO_GPIO_MSG_SET_IRQ_TYPE
with queued buffers still seems inconsistent to me: If setting the
type to none cancels
any outstanding eventq request, why do newly queued eventq request get added to
the queue? If we change the order to always require the type to be
enabled before
queuing any events, this inconsistency would go away. With the
behavior of the level
triggered interrupts changed to fasteoi, do you still see a need to
keep this ordering?

> +\subsubsection{eventq Operation: Message Flow}\label{sec:Device Types / GPIO Device / eventq Operation / Message Flow}
> +
> +\begin{itemize}
> +\item The driver is requested by a client driver to enable interrupt for a GPIO
> +    line and configure it to a particular trigger type.
> +
> +\item The driver sends the \field{VIRTIO_GPIO_MSG_SET_IRQ_TYPE} message over the
> +    \field{requestq} virtqueue and the device configures the GPIO line for the
> +    requested trigger type and unmasks the interrupt.
> +
> +\item The driver queues a pair of buffers, interrupt-request and
> +    interrupt-response, to the \field{eventq} virtqueue for the GPIO line.
> +
> +\item The driver notifies the device of the presence of new buffers on the
> +    \field{eventq} virtqueue.
> +
> +\item The interrupt is fully configured at this point.
> +
> +\item The device, on sensing an active interrupt on the GPIO line, finds the
> +    matching buffers (based on GPIO line number) from the \field{eventq}
> +    virtqueue and fills its \field{struct virtio_gpio_irq_response} buffer's
> +    \field{status} with \field{VIRTIO_GPIO_IRQ_STATUS_VALID} and returns the
> +    pair of buffers to the device.
> +
> +\item The device notifies the driver of the presence of returned buffers on the
> +    \field{eventq} virtqueue.
> +
> +\item If the GPIO line is configured for level interrupts, the device MUST

It would be nice to separate the normative text (using MUST etc) from the
section describing the message flow.

> +\item In a typical guest operating system kernel, the virtio-gpio driver
> +    notifies the client driver, that is associated with this gpio line, to
> +    process the event.
> +
> +\item In the case of a level triggered interrupt, the client driver must fully
> +    process and acknowledge the event at its source to return the line to its
> +    inactive state.
> +
> +\item The driver may again queue, same or new, pair of buffers for that GPIO
> +    line and notify the device.

I suggested this bit, but on second thought it still doesn't quite capture the
important bit that the 'level' line has to be set to low /before/ the new buffer
gets queued (to avoid a spurious notification). Otherwise there is no difference
between edge and level interrupts, obviously in both cases the interrupt
has to be processed eventually.

        Arnd

