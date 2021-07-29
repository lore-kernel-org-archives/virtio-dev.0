Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1627469463.git.viresh.kumar@linaro.org> <0dac5ab26a5fcc94ec530dbf83247788922123d7.1627469463.git.viresh.kumar@linaro.org>
 <CAK8P3a0x5OcQu1FuhhbEbcmvw1VDLQGR9-WFkA24nJTeDZtErw@mail.gmail.com>
 <20210729054055.m4wloacr7qz4ylit@vireshk-i7> <CAK8P3a374rcCEY6pGX0_F3PoFVaVzqPQ7QMM_rmOEvzNhHzqpQ@mail.gmail.com>
 <20210729084531.lev7joaghqszjf47@vireshk-i7>
In-Reply-To: <20210729084531.lev7joaghqszjf47@vireshk-i7>
From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 29 Jul 2021 11:26:58 +0200
Message-ID: <CAK8P3a2uYcCGuAS6MTKkSDEsV4KwVzux-_ZUjMu++eSZ_+0gGA@mail.gmail.com>
Subject: Re: [PATCH V7 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jul 29, 2021 at 10:45 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> > Fair enough, I don't care too much about this one, I was just thinking we'd
> > expect it to do it the other way round since that is more consistent with the
> > continued operation after the interrupts remain enabled and we go back and
> > forth requeing new eventq requests without turning them off again.
>
> Coming back to the confusing part here. I think we should make the
> interrupt controller (device) dumb here and leave all intelligence at
> the users (driver).
>
> What about defining the sequence of events like this:
>
> For edge interrupt:
>
> - driver sets trigger type to EDGE (falling/rising).
> - device enables the interrupt line, latches a value only after this
>   point.
> - driver queues a buffer over eventq (here or before setting trigger type).
> - Once buffer is available over eventq, device returns it back and
>   latches the next interrupt as soon as it happens.
> - driver on receiving the buffer, re-queues the buffer and handles the
>   interrupt by calling client's handler. Though queuing the buffer it
>   after handling the request won't make a huge difference (and may be
>   better for simpler driver code) as the next interrupt is latched
>   anyway by the device and can be processed only after this one is
>   done at the driver (some locking will be there to make sure only
>   one interrupt gets processed per line at a time).
> - Note that in this sequence we don't mask/unmask the interrupt at
>   all. That's what kernel will also do in handle_edge_irq() if I
>   understood it correctly.

Maybe this is where we misunderstood each other: I was thinking
of it in terms of handle_fasteoi_irq() control flow, not handle_edge_irq().

For the edge interrupt, it doesn't make much of a difference, but
for the level case, I think we really want handle_fasteoi_irq(),
and as I understand it, the driver side should work the same way
here.

> For level interrupt:
>
> - driver sets trigger type to LEVEL (high/low).
> - device enables the interrupt line, latches a value only after this
>   point.
> - driver queues a buffer over eventq (here or before setting trigger type).
> - Once buffer is available over eventq, device returns it back and
>   latches the next interrupt as soon as it happens. Its okay.
> - The driver on receiving the buffer, passes control to irq-core which
>   masks the interrupt by calling driver to set the trigger type to
>   NONE.
> - The device masks the interrupt and discards any latched value.
> - The irq-core handles the interrupt by calling client's handler.
> - The irq-core unmasks the interrupt by calling the driver to set the
>   trigger type to LEVEL.
> - The device unmasks the interrupt and latches any new value from here
>   on.
> - The driver queues the buffer again.
>
> How does that sound ? This removes any logical dependency between
> availability of the buffer and the interrupt being masked or unmasked.

I think having to mask/unmask the level interrupt explicitly adds
way too much complexity here, in particular when these are both
blocking operations. With the fasteoi flow, the irq core never has
to mask it, but only atomically requeue the buffer at the end.

       Arnd

