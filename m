Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org> <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
 <CAK8P3a0jRnxz6-WTmWyA04H2B+KP0AQ_7G6RyBqecKa8Xp37rA@mail.gmail.com> <CAKohponTstJF108wtSpGWYy0xETh6AzGaesjREGDKav5Yyy06g@mail.gmail.com>
In-Reply-To: <CAKohponTstJF108wtSpGWYy0xETh6AzGaesjREGDKav5Yyy06g@mail.gmail.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 16 Jul 2021 18:19:11 +0200
Message-ID: <CAK8P3a1G3OO19nnL19B1sU5PBgRpk3eGPZKXz7j55=X+ngNggg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH V5 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 16, 2021 at 5:17 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On Fri, 16 Jul 2021 at 14:33, Arnd Bergmann <arnd@kernel.org> wrote:
> > On Fri, Jul 16, 2021 at 9:39 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > +\subsubsection{Device Operation: IRQ Type}\label{sec:Device Types / GPIO Device / Device Operation / IRQ Type }
> > > +
> > > +The driver initiates this message to request the device to set the IRQ trigger
> > > +type to one of the \field{VIRTIO_GPIO_IRQ_TYPE_*} values, for a line configured
> > > +for input.
> > > +
> > > +This request is only allowed if the \field{VIRTIO_GPIO_F_IRQ} feature is
> > > +supported by the device.
> >
> > Is there a way for the driver to know which trigger types are supported on
> > a given line? If not, would that be useful, or do we assume that this
> > knowledge exists in the place that sets the trigger type based on e.g.
> > device tree data?
>
> I think it would be better to not send data partially via DT, as it may not be
> available for all the use cases.
>
> So, if something is needed, then it should be made available over the protocol
> itself.
>
> I assumed that we can take it for granted that all trigger types are supported,
> but maybe not.

What I meant is that the guest OS kernel would only ever set a trigger
type that makes sense based on what the device on the other end of
the GPIO line needs, and this would be encoded in the interrupt-cells.

> FWIW, I also took reference from another GPIO protocol developed for greybus:
>
> https://github.com/projectara/greybus-spec/blob/master/source/bridged_phy.rst#gpio-protocol
>
> and it also assumed all interrupt types would be supported.
>
> I am fine with adding a field for that in the configuration structure,
> if you think it would make sense.

Let's see what the gpio maintainers think

> > > +\subsubsection{Device Operation: IRQ Event}\label{sec:Device Types / GPIO Device / Device Operation / IRQ Event }
> > > +
> > > +The device initiates this message to notify the driver of an IRQ event on a line
> > > +previously configured for interrupt.
> > > +
> > > +This request is only allowed if the \field{VIRTIO_GPIO_F_IRQ} feature is
> > > +supported by the device.
> > > +
> > > +This is the only message which is initiated by the device and not the driver.
> > > +
> > > +\begin{tabular}{ |l||l|l|l| }
> > > +\hline
> > > +Fields & \field{type} & \field{gpio} & \field{value} \\
> > > +\hline
> > > +Message & \field{VIRTIO_GPIO_MSG_IRQ_EVENT} & line number & 0 \\
> > > +\hline
> > > +Response & \field{VIRTIO_GPIO_MSG_IRQ_EVENT} \newline | \field{VIRTIO_GPIO_MSG_RESPONSE} & line number & 0 = success, \newline or -errno = failure \\
> > > +\hline
> > > +\end{tabular}
> >
> > Can you clarify what "initiated by the device" means here?
>
> I meant the initial message is sent by the device (host) and the driver (guest)
> responds with success/failure.
>
> > Do you mean
> > the driver has to pre-fill the rxq with message buffers and the
> > device picks one of them?
>
> This is how it works technically I think. AFAIU, the driver needs to keep
> the buffers filled (even for the responses to the messages initiated
> at the driver).
>
> > In this case I would not call it "initiated by
> > the device", unless that terminology is what the virtio spec calls the same
> > thing elsewhere.
>
> I am not sure what that should be called as either, maybe virtio-spec
> maintainers can share the preferred way.
>
> Cornelia, Michael?

Ok, let's see what they think. I would have found this less confusing if
you just describe what message the driver sends and how the device
responds to it.

> > > +\item The driver prepares a buffer of type \field{struct virtio_gpio_msg} and
> > > +      sets its \field{type} field to (\field{VIRTIO_GPIO_MSG_IRQ_EVENT} |
> > > +      \field{VIRTIO_GPIO_MSG_RESPONSE}), \field{gpio} field with \field{gpio} of
> > > +      the received buffer, and \field{value} to message defined value.
>
> This is the response message that the driver sends on receiving an
> interrupt, this isn't pre-filled and is sent on txq instead of rxq.

> > Ah, ok. So the driver does have to fill in a request for an irq event on this
> > particular line first for the rxq, not just a generic "send me
> > something" request.
>
> Yes, and the driver also needs to add buffers here for receiving response to
> the messages initiated by the driver.

Ok, I think that needs to be made clearer here. I'm still not sure I have
understood exactly what messages you

> > I'm missing a bit here to explain how edge vs level interrupts are handled.
> > In particular:
> >
> > - for an edge interrupt, what happens when a new event comes between
> >   the VIRTIO_GPIO_MSG_IRQ_EVENT message and the new buffer
> >   getting queued? Will the device send another irq-event message, does
> >   it not send one, or is this implementation defined?
>
> The device MUST not send another irq request for the same GPIO line, until
> the time it has received a response from the driver. Once the response has
> arrived at the device, it can raise the interrupt again if the level
> interrupt is still active.

The part about not sending another interrupt is the easy part. What I mean is
what happens if another edge event comes into the gpio controller before the
driver responds. Does the device immediately send another interrupt message
or does it skip that?

> We should see it like how interrupts are handled in kernel, once an interrupt
> comes we disable it until the time the handler has got a chance to run, and the
> handler here is at the driver.

> > - for level triggered interrupts, how does the driver know that the
> >   event response has been received by the device? Does this not require
> >   a more complicated handshake?
>
> Okay, maybe there is something I need to improve here if this isn't clear..
>
> Every virtio-gpio transfer has two parts, a message is sent (maybe I should call
> it Request instead as I did earlier) by the sender, and receiver sends
> a response after processing the message.
>
> The device (host) is sender for the irq-message, and it will wait
> until a response
> is received from the driver (guest) for the same. That can be seen as returning
> from an irq-handler in kernel for example, at which point interrupt gets enabled
> again.
>
> Was I able to clarify it ?

I'm not sure it's helpful to describe the protocol as symmetric when neither
the virtqueue below it nor the idea of a gpio controller is symmetric.

I think a better way to describe it would be request/response pairs where
the driver asks for something to be done and it gets an immediate response,
as opposed to long-running event notifications where the driver queues
up a descriptor and it only completes when an interrupt happens.

       Arnd

