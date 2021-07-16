Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org> <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
In-Reply-To: <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 16 Jul 2021 11:02:46 +0200
Message-ID: <CAK8P3a0jRnxz6-WTmWyA04H2B+KP0AQ_7G6RyBqecKa8Xp37rA@mail.gmail.com>
Subject: Re: [PATCH V5 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 16, 2021 at 9:39 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> +\subsubsection{Device Operation: IRQ Type}\label{sec:Device Types / GPIO Device / Device Operation / IRQ Type }
> +
> +The driver initiates this message to request the device to set the IRQ trigger
> +type to one of the \field{VIRTIO_GPIO_IRQ_TYPE_*} values, for a line configured
> +for input.
> +
> +This request is only allowed if the \field{VIRTIO_GPIO_F_IRQ} feature is
> +supported by the device.

Is there a way for the driver to know which trigger types are supported on
a given line? If not, would that be useful, or do we assume that this
knowledge exists in the place that sets the trigger type based on e.g.
device tree data?

> +\subsubsection{Device Operation: IRQ Event}\label{sec:Device Types / GPIO Device / Device Operation / IRQ Event }
> +
> +The device initiates this message to notify the driver of an IRQ event on a line
> +previously configured for interrupt.
> +
> +This request is only allowed if the \field{VIRTIO_GPIO_F_IRQ} feature is
> +supported by the device.
> +
> +This is the only message which is initiated by the device and not the driver.
> +
> +\begin{tabular}{ |l||l|l|l| }
> +\hline
> +Fields & \field{type} & \field{gpio} & \field{value} \\
> +\hline
> +Message & \field{VIRTIO_GPIO_MSG_IRQ_EVENT} & line number & 0 \\
> +\hline
> +Response & \field{VIRTIO_GPIO_MSG_IRQ_EVENT} \newline | \field{VIRTIO_GPIO_MSG_RESPONSE} & line number & 0 = success, \newline or -errno = failure \\
> +\hline
> +\end{tabular}

Can you clarify what "initiated by the device" means here? Do you mean
the driver has to pre-fill the rxq with message buffers and the
device picks one of them? In this case I would not call it "initiated by
the device", unless that terminology is what the virtio spec calls the same
thing elsewhere.

For the 'errno' value, see my comments on patch 1/2.

> +\subsubsection{Device Interrupts}\label{sec:Device Types / GPIO Device / Message Flow / Interrupts}
> +
> +The \field{VIRTIO_GPIO_MSG_IRQ_EVENT} message type can only be initiated by the
> +device and sent to the driver over the \field{rxq} virtqueue.
> +
> +\begin{itemize}
> +\item The device, on sensing an interrupt for a GPIO line, prepares a buffer of
> +      type \field{struct virtio_gpio_msg} and sets its \field{type} to
> +      \field{VIRTIO_GPIO_MSG_IRQ_EVENT}, \field{gpio} field with a GPIO line
> +      number, and \field{value} field to 0.
> +
> +\item The device sends the buffer to the driver over the \field{rxq} virtqueue.
> +
> +\item The device MUST NOT initiate another interrupt request for the same GPIO
> +      line before receiving a response from the driver.
> +
> +\item The driver, after receiving the buffer from the driver, handles the
> +      interrupt.
> +
> +\item The driver at this point may initiate a new request (like masking of the
> +      IRQ line) and send it over to the device over the \field{txq} virtqueue.
> +      The device must respond to them, without waiting for a response to the
> +      IRQ itself.
> +
> +\item The driver prepares a buffer of type \field{struct virtio_gpio_msg} and
> +      sets its \field{type} field to (\field{VIRTIO_GPIO_MSG_IRQ_EVENT} |
> +      \field{VIRTIO_GPIO_MSG_RESPONSE}), \field{gpio} field with \field{gpio} of
> +      the received buffer, and \field{value} to message defined value.

Ah, ok. So the driver does have to fill in a request for an irq event on this
particular line first for the rxq, not just a generic "send me
something" request.
I think that makes sense, but I find the way you describe it confusing, so this
should be explained a little better in the "Device Operation: IRQ Event"
subsubsection, even if you end up repeating yourself here.

I'm missing a bit here to explain how edge vs level interrupts are handled.
In particular:

- for an edge interrupt, what happens when a new event comes between
  the VIRTIO_GPIO_MSG_IRQ_EVENT message and the new buffer
  getting queued? Will the device send another irq-event message, does
  it not send one, or is this implementation defined?

- for level triggered interrupts, how does the driver know that the
  event response has been received by the device? Does this not require
  a more complicated handshake?

       Arnd

