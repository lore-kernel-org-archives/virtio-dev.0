Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1627469463.git.viresh.kumar@linaro.org> <0dac5ab26a5fcc94ec530dbf83247788922123d7.1627469463.git.viresh.kumar@linaro.org>
 <CAK8P3a0x5OcQu1FuhhbEbcmvw1VDLQGR9-WFkA24nJTeDZtErw@mail.gmail.com> <20210729054055.m4wloacr7qz4ylit@vireshk-i7>
In-Reply-To: <20210729054055.m4wloacr7qz4ylit@vireshk-i7>
From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 29 Jul 2021 09:45:15 +0200
Message-ID: <CAK8P3a374rcCEY6pGX0_F3PoFVaVzqPQ7QMM_rmOEvzNhHzqpQ@mail.gmail.com>
Subject: Re: [PATCH V7 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jul 29, 2021 at 7:40 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 28-07-21, 14:05, Arnd Bergmann wrote:
>
> > > +The device MUST mask the interrupt for a GPIO line, if the trigger type is set
> > > +to \field{VIRTIO_GPIO_IRQ_TYPE_NONE} and also discard any latched interrupt
> > > +status associated with the line. The device MUST unmask the interrupt for any
> > > +other value of the trigger type.
> >
> > I think the last sentence here is somewhat ambiguous, I'm not sure
> > what it actually means to unmask a level triggered line if the driver
> > has not queued an event request for that line.
>
> (For everyone to follow, device == host, driver == guest)
>
> There are two different situation where the interrupt can come and I
> believe the behavior should be different.
>
> - The driver has requested for the trigger-type to be set and
>   unmasking of the interrupt. The device MUST unmask the interrupt
>   even if the buffer isn't queued over eventq, and so it must latch
>   the interrupt value and report it as soon as the buffer is made
>   available.
>
>   This behavior should be same for both edge or level interrupts.

I think they are fundamentally different here, see below:

> - Once the interrupt is reported by the device, by returning the
>   buffer over the eventq, the _level_ interrupt must be masked by the
>   device until the time the buffer is re-queued by the driver, else it
>   will end up reporting the same interrupt again as the line would
>   have stayed at the same level until the interrupt handler had a
>   chance to run and service the interrupt.
>
>   This is not the case for edge interrupt of course, where we need to
>   latch value as that counts for a new interrupt.
>
> > For an edge triggered interrupt, I think it makes sense to unmask the
> > interrupt at the device level and latch any incoming events until a
> > request gets queued on the eventq.
>
> I think the same holds true for level interrupts too.

Wouldn't that cause the virtio-gpio device to send a second spurious
interrupt reply for every hardware event?

During probe time, the level may be active if the device connected to the
gpio has latched an event itself. When that device gets initialized, its
driver would clear the status and bring the line to 'inactive' state before
enabling interrupts. If the virtio-gpio device latches the state of the line
having been active in the past, you get a first spurious reply. The driver
will know how to deal with it, but it can be avoided.

For the later operation, the gpio client device signals an event by
making the line active again, at this point the virtio-gpio device (in
the host) gets signaled and queues the reply. If it then looks at the
line, it is still active, so with your model it would have to latch another
event. The gpio slave driver in the guest then processes the event
and deactivates the line in order to not get woken up again until
something new happens.

If the virtio-gpio device has already latched another event, this
logic fails and you get woken up again directly at the end-of-interrupt
(i.e. requeueing the eventq message) even if the line is currently
inactive.

> > > +\item The driver MUST set the IRQ trigger type to
> > > +    \field{VIRTIO_GPIO_IRQ_TYPE_NONE} once it is done using the GPIO line,
> > > +    previously configured for a different trigger type.
> > >  \end{itemize}
> >
> > I'm not entirely sure why this "MUST" be done. Can't the device clean up the
> > irq when the  line is set back to direction=none or the queues are shut down?
>
> Yes we can infer that from direction=none as well, but even then the
> device needs to return the unused buffers over the eventq. And I
> thought it maybe better to explicitly mark this to be done and not mix
> with other operations like direction=none.
>
> For the queues being shut case, I see that as a crash or hard stop.
> The device may want to handle things in that case by its own way, but
> the spec must try to avoid that case entirely and not encourage people
> to do things that way :)

This still sounds like a "SHOULD" instead of "MUST" to me though,
but I don't remember the exact definitions of these.

> > > +\item The driver queues a pair of buffers, interrupt-request and
> > > +    interrupt-response, to the \field{eventq} virtqueue for the GPIO line.
> > > +
> > > +\item The driver notifies the device of the presence of new buffers on the
> > > +    \field{eventq} virtqueue.
> > > +
> > > +\item The driver sends the \field{VIRTIO_GPIO_MSG_SET_IRQ_TYPE} message over the
> > > +    \field{requestq} virtqueue and the device configures the GPIO line for the
> > > +    requested trigger type and unmasks the interrupt.
> >
> > Ah, I guess that explains the flow. I was expecting the reverse order (first
> > set-irq-type, then queue event request), but I suppose it works either way.
>
> Whatever the flow is here at the driver, the device may observe these
> differently as these are two different virtqueues here. The device
> should always provide the buffer before requesting the device to
> enable to interrupt IMO.

Fair enough, I don't care too much about this one, I was just thinking we'd
expect it to do it the other way round since that is more consistent with the
continued operation after the interrupts remain enabled and we go back and
forth requeing new eventq requests without turning them off again.

       Arnd

