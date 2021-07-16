Return-Path: <viresh.kumar@linaro.org>
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org> <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
 <CAK8P3a0jRnxz6-WTmWyA04H2B+KP0AQ_7G6RyBqecKa8Xp37rA@mail.gmail.com>
In-Reply-To: <CAK8P3a0jRnxz6-WTmWyA04H2B+KP0AQ_7G6RyBqecKa8Xp37rA@mail.gmail.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 16 Jul 2021 20:47:48 +0530
Message-ID: <CAKohponTstJF108wtSpGWYy0xETh6AzGaesjREGDKav5Yyy06g@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH V5 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 16 Jul 2021 at 14:33, Arnd Bergmann <arnd@kernel.org> wrote:
> On Fri, Jul 16, 2021 at 9:39 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +\subsubsection{Device Operation: IRQ Type}\label{sec:Device Types / GPIO Device / Device Operation / IRQ Type }
> > +
> > +The driver initiates this message to request the device to set the IRQ trigger
> > +type to one of the \field{VIRTIO_GPIO_IRQ_TYPE_*} values, for a line configured
> > +for input.
> > +
> > +This request is only allowed if the \field{VIRTIO_GPIO_F_IRQ} feature is
> > +supported by the device.
>
> Is there a way for the driver to know which trigger types are supported on
> a given line? If not, would that be useful, or do we assume that this
> knowledge exists in the place that sets the trigger type based on e.g.
> device tree data?

I think it would be better to not send data partially via DT, as it may not be
available for all the use cases.

So, if something is needed, then it should be made available over the protocol
itself.

I assumed that we can take it for granted that all trigger types are supported,
but maybe not.

FWIW, I also took reference from another GPIO protocol developed for greybus:

https://github.com/projectara/greybus-spec/blob/master/source/bridged_phy.rst#gpio-protocol

and it also assumed all interrupt types would be supported.

I am fine with adding a field for that in the configuration structure,
if you think it
would make sense.

> > +\subsubsection{Device Operation: IRQ Event}\label{sec:Device Types / GPIO Device / Device Operation / IRQ Event }
> > +
> > +The device initiates this message to notify the driver of an IRQ event on a line
> > +previously configured for interrupt.
> > +
> > +This request is only allowed if the \field{VIRTIO_GPIO_F_IRQ} feature is
> > +supported by the device.
> > +
> > +This is the only message which is initiated by the device and not the driver.
> > +
> > +\begin{tabular}{ |l||l|l|l| }
> > +\hline
> > +Fields & \field{type} & \field{gpio} & \field{value} \\
> > +\hline
> > +Message & \field{VIRTIO_GPIO_MSG_IRQ_EVENT} & line number & 0 \\
> > +\hline
> > +Response & \field{VIRTIO_GPIO_MSG_IRQ_EVENT} \newline | \field{VIRTIO_GPIO_MSG_RESPONSE} & line number & 0 = success, \newline or -errno = failure \\
> > +\hline
> > +\end{tabular}
>
> Can you clarify what "initiated by the device" means here?

I meant the initial message is sent by the device (host) and the driver (guest)
responds with success/failure.

> Do you mean
> the driver has to pre-fill the rxq with message buffers and the
> device picks one of them?

This is how it works technically I think. AFAIU, the driver needs to keep
the buffers filled (even for the responses to the messages initiated
at the driver).

> In this case I would not call it "initiated by
> the device", unless that terminology is what the virtio spec calls the same
> thing elsewhere.

I am not sure what that should be called as either, maybe virtio-spec
maintainers
can share the preferred way.

Cornelia, Michael?

> > +\item The driver prepares a buffer of type \field{struct virtio_gpio_msg} and
> > +      sets its \field{type} field to (\field{VIRTIO_GPIO_MSG_IRQ_EVENT} |
> > +      \field{VIRTIO_GPIO_MSG_RESPONSE}), \field{gpio} field with \field{gpio} of
> > +      the received buffer, and \field{value} to message defined value.

This is the response message that the driver sends on receiving an
interrupt, this
isn't pre-filled and is sent on txq instead of rxq.

> Ah, ok. So the driver does have to fill in a request for an irq event on this
> particular line first for the rxq, not just a generic "send me
> something" request.

Yes, and the driver also needs to add buffers here for receiving response to
the messages initiated by the driver.

> I think that makes sense, but I find the way you describe it confusing, so this
> should be explained a little better in the "Device Operation: IRQ Event"
> subsubsection, even if you end up repeating yourself here.

Okay.

> I'm missing a bit here to explain how edge vs level interrupts are handled.
> In particular:
>
> - for an edge interrupt, what happens when a new event comes between
>   the VIRTIO_GPIO_MSG_IRQ_EVENT message and the new buffer
>   getting queued? Will the device send another irq-event message, does
>   it not send one, or is this implementation defined?

The device MUST not send another irq request for the same GPIO line, until
the time it has received a response from the driver. Once the response has
arrived at the device, it can raise the interrupt again if the level
interrupt is
still active.

We should see it like how interrupts are handled in kernel, once an interrupt
comes we disable it until the time the handler has got a chance to run, and the
handler here is at the driver.

> - for level triggered interrupts, how does the driver know that the
>   event response has been received by the device? Does this not require
>   a more complicated handshake?

Okay, maybe there is something I need to improve here if this isn't clear..

Every virtio-gpio transfer has two parts, a message is sent (maybe I should call
it Request instead as I did earlier) by the sender, and receiver sends
a response
after processing the message.

The device (host) is sender for the irq-message, and it will wait
until a response
is received from the driver (guest) for the same. That can be seen as returning
from an irq-handler in kernel for example, at which point interrupt gets enabled
again.

Was I able to clarify it ?

--
viresh

