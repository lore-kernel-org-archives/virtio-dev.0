Return-Path: <viresh.kumar@linaro.org>
Date: Thu, 29 Jul 2021 11:10:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V7 2/2] virtio-gpio: Add support for interrupts
Message-ID: <20210729054055.m4wloacr7qz4ylit@vireshk-i7>
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
> On Wed, Jul 28, 2021 at 1:11 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
 
> This also looks good to me overall, I have a few idea for clarifications below,
> but none of them are likely to change the actual behavior.
> 
> More importantly though, I would like to see a review by the linux irqchip
> maintainers (Marc Zyngier and/or Thomas Gleixner, both added to Cc here)
> before this gets merged into the virtio specification. I have a basic
> understanding
> of the subsystem but probably got something wrong myself.

Thanks for adding them.

> That review is probably easier once you post the driver code for it but if
> Thomas or Marc want to comment on the spec before seeing the driver,
> the patch is available at [1], along with the base virtio-gpio spec.
> 
> > +\subsubsection{requestq Operation: Set IRQ Type}\label{sec:Device Types / GPIO Device / requestq Operation / Set IRQ Type}
> > +
> > +The driver sends this message to request the device to set the IRQ trigger type,
> > +to one of the \field{VIRTIO_GPIO_IRQ_TYPE_*} values, for a line configured for
> > +input.
> > +
> > +This request is only allowed if the \field{VIRTIO_GPIO_F_IRQ} feature is
> > +enabled by the device.
> > +
> > +The device MUST mask the interrupt for a GPIO line, if the trigger type is set
> > +to \field{VIRTIO_GPIO_IRQ_TYPE_NONE} and also discard any latched interrupt
> > +status associated with the line. The device MUST unmask the interrupt for any
> > +other value of the trigger type.
> 
> I think the last sentence here is somewhat ambiguous, I'm not sure
> what it actually
> means to unmask a level triggered line if the driver has not queued an
> event request
> for that line.

(For everyone to follow, device == host, driver == guest)

There are two different situation where the interrupt can come and I
believe the behavior should be different.

- The driver has requested for the trigger-type to be set and
  unmasking of the interrupt. The device MUST unmask the interrupt
  even if the buffer isn't queued over eventq, and so it must latch
  the interrupt value and report it as soon as the buffer is made
  available.

  This behavior should be same for both edge or level interrupts.

- Once the interrupt is reported by the device, by returning the
  buffer over the eventq, the _level_ interrupt must be masked by the
  device until the time the buffer is re-queued by the driver, else it
  will end up reporting the same interrupt again as the line would
  have stayed at the same level until the interrupt handler had a
  chance to run and service the interrupt.

  This is not the case for edge interrupt of course, where we need to
  latch value as that counts for a new interrupt.

> For an edge triggered interrupt, I think it makes sense to unmask the
> interrupt at
> the device level and latch any incoming events until a request gets
> queued on the
> eventq.

I think the same holds true for level interrupts too.

> > +\item The driver MUST set the IRQ trigger type to
> > +    \field{VIRTIO_GPIO_IRQ_TYPE_NONE} once it is done using the GPIO line,
> > +    previously configured for a different trigger type.
> >  \end{itemize}
> 
> I'm not entirely sure why this "MUST" be done. Can't the device clean up the
> irq when the  line is set back to direction=none or the queues are shut down?

Yes we can infer that from direction=none as well, but even then the
device needs to return the unused buffers over the eventq. And I
thought it maybe better to explicitly mark this to be done and not mix
with other operations like direction=none.

For the queues being shut case, I see that as a crash or hard stop.
The device may want to handle things in that case by its own way, but
the spec must try to avoid that case entirely and not encourage people
to do things that way :)

> > +\item The driver queues a pair of buffers, interrupt-request and
> > +    interrupt-response, to the \field{eventq} virtqueue for the GPIO line.
> > +
> > +\item The driver notifies the device of the presence of new buffers on the
> > +    \field{eventq} virtqueue.
> > +
> > +\item The driver sends the \field{VIRTIO_GPIO_MSG_SET_IRQ_TYPE} message over the
> > +    \field{requestq} virtqueue and the device configures the GPIO line for the
> > +    requested trigger type and unmasks the interrupt.
> 
> Ah, I guess that explains the flow. I was expecting the reverse order (first
> set-irq-type, then queue event request), but I suppose it works either way.

Whatever the flow is here at the driver, the device may observe these
differently as these are two different virtqueues here. The device
should always provide the buffer before requesting the device to
enable to interrupt IMO.

> > +\item The driver on receiving the notification from the device, processes the
> > +    interrupt. The driver may try to update the trigger-type of the interrupt
> > +    for the GPIO line over the \field{requestq} virtqueue.
> > +
> > +\item The driver may again queue, same or new, pair of buffers for that GPIO
> > +    line and notify the device.
> 
> I feel there needs to be another step between these two, as this is where
> some of the magic happens that guarantees we don't get too many or
> not enough interrupts. How about:
> 
> \item In a typical guest operating system kernel, the virtio-gpio
>     driver notifies another device driver that is associated with this gpio
>     line to process the event.
> 
> \item In the case of a level triggered interrupt, the secondary device
>     driver must fully process and acknowledge the event at its source
>     to return the line to its inactive state.

Sure, they can be added. Will do.

-- 
viresh

