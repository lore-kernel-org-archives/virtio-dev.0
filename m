Return-Path: <viresh.kumar@linaro.org>
Date: Thu, 29 Jul 2021 14:15:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V7 2/2] virtio-gpio: Add support for interrupts
Message-ID: <20210729084531.lev7joaghqszjf47@vireshk-i7>
References: <cover.1627469463.git.viresh.kumar@linaro.org>
 <0dac5ab26a5fcc94ec530dbf83247788922123d7.1627469463.git.viresh.kumar@linaro.org>
 <CAK8P3a0x5OcQu1FuhhbEbcmvw1VDLQGR9-WFkA24nJTeDZtErw@mail.gmail.com>
 <20210729054055.m4wloacr7qz4ylit@vireshk-i7>
 <CAK8P3a374rcCEY6pGX0_F3PoFVaVzqPQ7QMM_rmOEvzNhHzqpQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a374rcCEY6pGX0_F3PoFVaVzqPQ7QMM_rmOEvzNhHzqpQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 29-07-21, 09:45, Arnd Bergmann wrote:
> Wouldn't that cause the virtio-gpio device to send a second spurious
> interrupt reply for every hardware event?
> 
> During probe time, the level may be active if the device connected to the
> gpio has latched an event itself.

At this time the trigger type should be set to NONE by default and no
latching of the line's value must be performed by the device. The
device should look for interrupts only after the interrupt is
explicitly unmasked (irq-type set to non-NONE value) by the driver.

> When that device gets initialized, its
> driver would clear the status and bring the line to 'inactive' state before
> enabling interrupts. If the virtio-gpio device latches the state of the line
> having been active in the past, you get a first spurious reply.

And so this shouldn't happen.

> The driver
> will know how to deal with it, but it can be avoided.
> 
> For the later operation, the gpio client device signals an event by
> making the line active again, at this point the virtio-gpio device (in
> the host) gets signaled and queues the reply. If it then looks at the
> line, it is still active, so with your model it would have to latch another
> event.

No, since interrupt-handling is being performed at this time, the
device MUST NOT latch a value for trigger type _level_. This is very
explicitly stated in the current version of specs.

> The gpio slave driver in the guest then processes the event
> and deactivates the line in order to not get woken up again until
> something new happens.
> 
> If the virtio-gpio device has already latched another event, this
> logic fails and you get woken up again directly at the end-of-interrupt
> (i.e. requeueing the eventq message) even if the line is currently
> inactive.

This shouldn't happen, but I now find the reliance on the request
buffer being available or not a bit confusing with respect to masking
or unmasking of the interrupt. More on this later..

> > > > +\item The driver MUST set the IRQ trigger type to
> > > > +    \field{VIRTIO_GPIO_IRQ_TYPE_NONE} once it is done using the GPIO line,
> > > > +    previously configured for a different trigger type.
> > > >  \end{itemize}
> > >
> > > I'm not entirely sure why this "MUST" be done. Can't the device clean up the
> > > irq when the  line is set back to direction=none or the queues are shut down?
> >
> > Yes we can infer that from direction=none as well, but even then the
> > device needs to return the unused buffers over the eventq. And I
> > thought it maybe better to explicitly mark this to be done and not mix
> > with other operations like direction=none.
> >
> > For the queues being shut case, I see that as a crash or hard stop.
> > The device may want to handle things in that case by its own way, but
> > the spec must try to avoid that case entirely and not encourage people
> > to do things that way :)
> 
> This still sounds like a "SHOULD" instead of "MUST" to me though,
> but I don't remember the exact definitions of these.

Sure, I can make that a SHOULD :)

> Fair enough, I don't care too much about this one, I was just thinking we'd
> expect it to do it the other way round since that is more consistent with the
> continued operation after the interrupts remain enabled and we go back and
> forth requeing new eventq requests without turning them off again.

Coming back to the confusing part here. I think we should make the
interrupt controller (device) dumb here and leave all intelligence at
the users (driver).

What about defining the sequence of events like this:

For edge interrupt:

- driver sets trigger type to EDGE (falling/rising).
- device enables the interrupt line, latches a value only after this
  point.
- driver queues a buffer over eventq (here or before setting trigger type).
- Once buffer is available over eventq, device returns it back and
  latches the next interrupt as soon as it happens.
- driver on receiving the buffer, re-queues the buffer and handles the
  interrupt by calling client's handler. Though queuing the buffer it
  after handling the request won't make a huge difference (and may be
  better for simpler driver code) as the next interrupt is latched
  anyway by the device and can be processed only after this one is
  done at the driver (some locking will be there to make sure only
  one interrupt gets processed per line at a time).
- Note that in this sequence we don't mask/unmask the interrupt at
  all. That's what kernel will also do in handle_edge_irq() if I
  understood it correctly.


For level interrupt:

- driver sets trigger type to LEVEL (high/low).
- device enables the interrupt line, latches a value only after this
  point.
- driver queues a buffer over eventq (here or before setting trigger type).
- Once buffer is available over eventq, device returns it back and
  latches the next interrupt as soon as it happens. Its okay.
- The driver on receiving the buffer, passes control to irq-core which
  masks the interrupt by calling driver to set the trigger type to
  NONE.
- The device masks the interrupt and discards any latched value.
- The irq-core handles the interrupt by calling client's handler.
- The irq-core unmasks the interrupt by calling the driver to set the
  trigger type to LEVEL.
- The device unmasks the interrupt and latches any new value from here
  on.
- The driver queues the buffer again.

How does that sound ? This removes any logical dependency between
availability of the buffer and the interrupt being masked or unmasked.

One thing I am not very clear about is where do
.irq_bus_lock()/unlock() come in this picture. Are they called during
interrupt handling time too or just during setting of the interrupt
(i.e. request_irq()).

-- 
viresh

