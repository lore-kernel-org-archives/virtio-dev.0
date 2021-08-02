Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1627627021.git.viresh.kumar@linaro.org> <33671b4e543557740acf85bc30ed8ad1ba9ef8aa.1627627021.git.viresh.kumar@linaro.org>
 <87a6m42ngf.wl-maz@kernel.org> <CAK8P3a2pMUpLUFFA62pTcH9LBYfo1g+gYGkqDxmBjUfQA2Uong@mail.gmail.com>
 <87v94q25iu.wl-maz@kernel.org> <CAK8P3a2Rz_HGVYG7n6stn06ws521VSTgagBvz__2Kh8ho0FDXA@mail.gmail.com>
 <87r1fc18od.wl-maz@kernel.org>
In-Reply-To: <87r1fc18od.wl-maz@kernel.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 2 Aug 2021 13:25:59 +0200
Message-ID: <CAK8P3a0kFCoaAqk5sbF=P=t7wj1=ncn-NCejNv45W-uebKtDwQ@mail.gmail.com>
Subject: Re: [PATCH V8 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Marc Zyngier <maz@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Aug 2, 2021 at 11:45 AM Marc Zyngier <maz@kernel.org> wrote:
> On Sun, 01 Aug 2021 14:43:37 +0100, Arnd Bergmann <arnd@kernel.org> wrote:
> > On Sat, Jul 31, 2021 at 11:31 AM Marc Zyngier <maz@kernel.org> wrote:
> > > On Fri, 30 Jul 2021 11:05:30 +0100, Arnd Bergmann <arnd@kernel.org> wrote:
> > > > On Fri, Jul 30, 2021 at 10:52 AM Marc Zyngier <maz@kernel.org> wrote:

> > Viresh's previous first version actually had this, I asked him to
> > simplify it in order to reduce the number of possible states, as it
> > seemed to me that it would be better not to have eight possible
> > states when you have the various combinations of enabled/disabled,
> > unmasked/masked and armed/not-armed.
>
> What exactly is armed/not-armed? Is that equivalent to pending?
>
> > The current version folds
> > unmasked/masked into armed/not-armed by masking the interrupt
> > whenever the reply has been queued to the guest, until it gets
> > queued again on the eventq.
>
> Huh. I understood that it was mask end enabled that were folded
> together. I'm lost.

Sorry, it's probably my fault for not knowing the correct terminology.

With 'armed' I mean that the virtio-gpio driver has sent a message
to the eventq, which allows the device to reply that an event has
happened. If it was already pending and enabled, the device can
reply immediately, otherwise the notification will remain in 'armed'
state until the host observes the interrupt, and then it sends it back.

After the event is returned to the guest, it is no longer armed, and
the host can not send another event since it no longer owns
a message buffer for the gpio line, until the guest re-arms it by
providing a new message buffer.

> > This avoids the problem that using the controlq to mask explicitly
> > mask the interrupt cannot be done from atomic context since it
> > has to wait_for_completion() until the controlq message is returned.
> > Queing up the eventq message to unmask the even can be done
> > in atomic context, since this is a posted operation.
> >
> > What are the requirements for a ->irq_mask() operation? Can this
> > be called in atomic context? If it can, is it allowed to be posted
> > (e.g. by queuing a new command without waiting for the reply)?
>
> irq_mask() can definitely be called in atomic context. But in this
> case the driver must implement the bus_lock madness and commit changes
> to the backend on unlock. See how most of the I2C GPIO implementations
> work.
>
> Obviously, this has an effect on performance and complexity. It would
> be a lot better if there was a way to perform the mask/unmask
> operations synchronously, without the need of a buffer. For example,
> virtio-console has the so called 'emergency write' feature, which
> allows for write operations without any buffer.
>
> The latter would allow the implementation of a "fire and forget"
> mask/unmask that would still be synchronous.

I don't see the code in virtio-console you mention, but I don't think
this would work here: the console driver just needs to tell the
host that data is available but doesn't care if that makes it there,
while the irq mask operation must be sure the host has actually
prevented interrupts from getting delivered.

If we need to add an explicit 'mask' operation in the protocol,
that would involve queueing a command on either the controlq
or eventq, which leads to the already queued eventq buffer to
get returned to the guest, but as you say this would add a lot
of complexity.

> > Alternatively, would it be possible to simply emulate the 'irq_mask()'
> > operation in software, by not delivering the next interrupt to the
> > handler until the driver calls irq_unmask()? Once it's been delivered,
> > it would just not get requeued in this case.
>
> That'd be a poor-man's solution, as you would still get host
> notifications, which could have an impact in the case of a screaming
> interrupt.

What I meant is to only get one notification, and then not re-arm
the interrupt by sending the new request.

If we send a separate 'mask' command, then the guest actually
gets sent two buffers back: the completion of the 'mask' operation
and the eventq buffer. Not sending the command means we get
either no buffer back (if no interrupt happens while the line is
masked) or one buffer.

       Arnd

