Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1627469463.git.viresh.kumar@linaro.org> <0dac5ab26a5fcc94ec530dbf83247788922123d7.1627469463.git.viresh.kumar@linaro.org>
 <CAK8P3a0x5OcQu1FuhhbEbcmvw1VDLQGR9-WFkA24nJTeDZtErw@mail.gmail.com> <20210729105957.zem2tbhixoxuxry6@vireshk-i7>
In-Reply-To: <20210729105957.zem2tbhixoxuxry6@vireshk-i7>
From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 29 Jul 2021 13:39:40 +0200
Message-ID: <CAK8P3a0KER4NFXkv1OXSqD-9Khip+-u=H+4_fkQmVz3so6V1=A@mail.gmail.com>
Subject: Re: [PATCH V7 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jul 29, 2021 at 12:59 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 28-07-21, 14:05, Arnd Bergmann wrote:
> > I think the last sentence here is somewhat ambiguous, I'm not sure
> > what it actually means to unmask a level triggered line if the driver has not
> > queued an event request for that line.
>
> I think I now understand what you meant by this, I wasn't thinking of
> fasteoi earlier :)
>
> What about following diff over this patch:
>
>  The device MUST mask the interrupt for a GPIO line, if the trigger type is set
>  to \field{VIRTIO_GPIO_IRQ_TYPE_NONE} and also discard any latched interrupt
> -status associated with the line. The device MUST unmask the interrupt for any
> -other value of the trigger type.
> +event associated with the line. The device MUST NOT notify the driver of an
> +interrupt event if the trigger type is set to \field{VIRTIO_GPIO_IRQ_TYPE_NONE}
> +for the GPIO line.

I actually thought that setting VIRTIO_GPIO_IRQ_TYPE_NONE would
return the buffer to the driver, with status indicating that no event
has happened.

> +For level trigger type, the device only reports an interrupt if the
> +corresponding interrupt level was sensed when the buffers are received.

I think you mean the right thing, but this part is very misleading: we
clearly want
to be notified if the line was active when the buffer is received and also as
soon as it becomes active afterwards, just not when it was active in the past.

> +\item The driver sends the \field{VIRTIO_GPIO_MSG_SET_IRQ_TYPE} message over the
> +    \field{requestq} virtqueue and the device configures the GPIO line for the
> +    requested trigger type and unmasks the interrupt.
> +
>  \item The driver queues a pair of buffers, interrupt-request and
>      interrupt-response, to the \field{eventq} virtqueue for the GPIO line.
>
>  \item The driver notifies the device of the presence of new buffers on the
>      \field{eventq} virtqueue.
>
> -\item The driver sends the \field{VIRTIO_GPIO_MSG_SET_IRQ_TYPE} message over the
> -    \field{requestq} virtqueue and the device configures the GPIO line for the
> -    requested trigger type and unmasks the interrupt.
> -
>  \item The interrupt is fully configured at this point.
>
>  \item The device, on sensing an interrupt on a GPIO line, finds the matching
> @@ -469,19 +483,29 @@ \subsubsection{eventq Operation: Message Flow}\label{sec:Device Types / GPIO Dev
>  \item The device notifies the driver of the presence of new buffers on the
>      \field{eventq} virtqueue.
>
> -\item If the GPIO line is configured for Level interrupts, the device MUST mask
> -    the interrupts for this GPIO line, until the time the buffers are made
> -    available again by the driver.
> +\item If the GPIO line is configured for level interrupts, the device MUST
> +    ignore the interrupts for this GPIO line, until the time the buffers are

Maybe change

s/the interrupts for/an active interrupt signaled on/

> +    made available again by the driver. Once the buffers are available again,
> +    and the interrupt on the line is still active, the device can again notify
> +    the driver of an interrupt event.
>
> -\item If the GPIO line is configured for Edge interrupts, the device MUST latch
> +\item If the GPIO line is configured for edge interrupts, the device MUST latch
>      the latest interrupt received for this GPIO line, until the time the buffers
>      are made available again by the driver. At that point, the device can again
> -    return the buffers for the line if an interrupt was received while the
> -    device was waiting for the buffers to be made available by the driver.
> +    notify the driver if an interrupt was received while the device was waiting
> +    for the buffers to be made available by the driver.

I think this needs to be

s/the device can/the device MUST/

signaling the interrupt is not optional ;-)

The rest looks good to me now, but it's a little hard to read in diff form.
Are you able to post the driver soon? I think our understanding of how this
should work has converged enough that I'd review that next.

       Arnd

