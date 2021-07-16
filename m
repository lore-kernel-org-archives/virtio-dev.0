Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org> <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
 <CAK8P3a0jRnxz6-WTmWyA04H2B+KP0AQ_7G6RyBqecKa8Xp37rA@mail.gmail.com>
 <CAKohponTstJF108wtSpGWYy0xETh6AzGaesjREGDKav5Yyy06g@mail.gmail.com>
 <CAK8P3a1G3OO19nnL19B1sU5PBgRpk3eGPZKXz7j55=X+ngNggg@mail.gmail.com> <CAKohpo=6Ntb7qgu6T1TOfUYYQVxnhc2DZcgn6TPJEY-_27RW0w@mail.gmail.com>
In-Reply-To: <CAKohpo=6Ntb7qgu6T1TOfUYYQVxnhc2DZcgn6TPJEY-_27RW0w@mail.gmail.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 16 Jul 2021 20:49:57 +0200
Message-ID: <CAK8P3a0AH0dAkCtvZNtP3JJ=XVi9ybw=cTVw0C9yS2Vf0yKf8Q@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH V5 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 16, 2021 at 6:50 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On Fri, 16 Jul 2021 at 21:49, Arnd Bergmann <arnd@kernel.org> wrote:
> > > The device MUST not send another irq request for the same GPIO line, until
> > > the time it has received a response from the driver. Once the response has
> > > arrived at the device, it can raise the interrupt again if the level
> > > interrupt is still active.
> >
> > The part about not sending another interrupt is the easy part. What I mean is
> > what happens if another edge event comes into the gpio controller before the
> > driver responds. Does the device immediately send another interrupt message
> > or does it skip that?
>
> Hmm, what should it do in that case ? What do we do in kernel for this ? I think
> maybe we should accumulate the interrupts in that period of time and send only
> the last one ?
>
> Also will it make sense to send the trigger-type information to the driver on an
> interrupt? For example a user may have programmed a line for both edge trigger
> interrupts. Should we send info about which edge it is, rising or falling ?

It's important to get the order correct here, and there are a lot of variations
in hardware, so we need to pick the one that works best. Unfortunately
I can never quite remember what they are either ;-)

Looking at the two ways of handling irqs that we care about

1. edge interrupts:

void handle_edge_irq(struct irq_desc *desc)
{
...
        desc->irq_data.chip->irq_ack(&desc->irq_data);
        do {
              ...
              handle_irq_event(desc);
        } while ((desc->istate & IRQS_PENDING) &&
                 !irqd_irq_disabled(&desc->irq_data));
       ...
}

Here the irq gets rearmed first and then we call into the driver
that has requested it. That driver processes all information that
is associated with the event, or possibly multiple events that
have happened since the handler waslast called. If another irq
arrives after the driver is done looking for them, we will receive
another event from the virtio device and all is good.

Ideally the 'irq_ack' would simply involve queuing another
request for an event on the second virtqueue. However I don't
know if there is a way for the virtio-gpio driver to know whether
this request has been observed by the virtio-gpio device.
If not, the irq_ack may arrive at the device only after the
handle_irq_event() function is complete and we miss an interrupt.

2. level interrupts:

void handle_level_irq(struct irq_desc *desc)
{
        mask_ack_irq(desc);
        ...
        handle_irq_event(desc);
        ...
        cond_unmask_irq(desc);
}

Going through this the literal way would mean sending a mask,
ack, and unmask request through virtio and waiting for a reply
each time, but that does seem excessive.

As long as the interrupt is masked initially (since there is no
event request pending immediately after the irq event reply),
I would hope that we can get away with simply enqueuing the
request in the 'cond_unmask_irq' step. In this case, we would
call all handlers for this the level irq with the line pending
and masked. After the handlers are complete, it should no
longer be pending and we can unmask it. If another event comes
in after the handler, it gets pending again, and we get sent a
new irq event reply after the Ack.

> > I'm not sure it's helpful to describe the protocol as symmetric when neither
> > the virtqueue below it nor the idea of a gpio controller is symmetric.
> >
> > I think a better way to describe it would be request/response pairs where
> > the driver asks for something to be done and it gets an immediate response,
> > as opposed to long-running event notifications where the driver queues
> > up a descriptor and it only completes when an interrupt happens.
>
> Yes, I think it would be better to bind the request/response messages together.
> I will see if that will work fine or not before confirming.

Ok.

         Arnd

