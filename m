Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1627627021.git.viresh.kumar@linaro.org> <33671b4e543557740acf85bc30ed8ad1ba9ef8aa.1627627021.git.viresh.kumar@linaro.org>
 <87a6m42ngf.wl-maz@kernel.org>
In-Reply-To: <87a6m42ngf.wl-maz@kernel.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 30 Jul 2021 12:05:30 +0200
Message-ID: <CAK8P3a2pMUpLUFFA62pTcH9LBYfo1g+gYGkqDxmBjUfQA2Uong@mail.gmail.com>
Subject: Re: [PATCH V8 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Marc Zyngier <maz@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 30, 2021 at 10:52 AM Marc Zyngier <maz@kernel.org> wrote:
> On Fri, 30 Jul 2021 07:45:03 +0100, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +
> > +\item If the GPIO line is configured for level interrupts, the device MUST
> > +    ignore an active interrupt signaled on this GPIO line, until the time the
> > +    buffers are made available again by the driver. Once the buffers are
> > +    available again, and the interrupt on the line is still active, the device
> > +    MUST notify the driver again of an interrupt event.
>
> It feels like there is a problem here. A virtio device signals
> interrupts by using edge triggered signalling. Nothing wrong with
> that. However, signalling a level over a an edge signalling is much
> more tricky.
>
> For example, let's assume that the irqchip driver handles a level
> interrupt: it gets the message from the device indicating that a GPIO
> level interrupt is pending. During the handling, the interrupt is made
> pending again, without having ever transitioned via an inactive state.
> If you don't have a mechanism to retrigger the level, you have lost an
> interrupt.
>
> I can't see anything in this document that hints at a way to
> resample/retrigger a level interrupt, which is what you would normally
> do on EOI for an interrupt controller that implements level-over-edge
> signalling.

Thanks a lot for taking a closer look. I still hope this is just a problem
that needs to be clarified in the description, not something wrong with
the design, as I don't see the problem yet. As far as I can tell, this is
different from an edge interrupt, since the eventq communication is
really a two-way message.

The EOI for the level interrupt is the message being enqueued after
the guest is done processing the interrupt. I can see four ways this
could go:

1. If the interrupt has not been made pending again yet, nothing happens
  until it eventually becomes pending again (this is the obvious case)

2. If it is already pending, chip->irq_eoi() causes the new event descriptor
  to be queued on the eventq, and it signals the host about new buffers
  being available. The /host/ samples the level of the line, notices it is
  pending and puts the resulting buffer back on the 'used' queue even
  before returning from the guest 'notify' function.
  The guest virtio core code keeps processing the 'used' buffers and
  gets back into the interrupt handler.

3. Same as 2., but the host handles the virtqueue ->notify asynchronously,
  and the guest has already checked the 'used' queue before the host
  adds back the buffer to tell it that the line is still active. Now the guest
  gets notified again after it returns from the virtqueue interrupt, in order
  to process the new 'used' buffer.

4. The gpio line actually goes into inactive state until after the new event
   is queued in chip->irq_eoi(), but becomes active immediately afterwards.
   Now the host gets interrupted and handles this by queuing the event
   reply but cannot interrupt the guest because it is still processing the
   original virtqueue event. However, since the event is queued, it will be
   processed the same way as 2. or 3. by the virtio core.

Do  you see a problem with scenarios 2, 3 or 4, or with another case
that I may have missed?

[This all assumes that the host is able to atomically enable interrupts and
check the current level when processing the new buffer. If the host uses the
Linux gpiolib ioctl interface, this means it has to register for an edge event
on the line first, and then read the current value before adding the file
descriptor to its poll table. I feel this is out of the scope of the virtio spec
though.]

       Arnd

