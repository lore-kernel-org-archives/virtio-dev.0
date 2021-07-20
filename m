Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org> <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
 <CAK8P3a0jRnxz6-WTmWyA04H2B+KP0AQ_7G6RyBqecKa8Xp37rA@mail.gmail.com>
 <CAKohponTstJF108wtSpGWYy0xETh6AzGaesjREGDKav5Yyy06g@mail.gmail.com>
 <CAK8P3a1G3OO19nnL19B1sU5PBgRpk3eGPZKXz7j55=X+ngNggg@mail.gmail.com>
 <CAKohpo=6Ntb7qgu6T1TOfUYYQVxnhc2DZcgn6TPJEY-_27RW0w@mail.gmail.com>
 <CAK8P3a0AH0dAkCtvZNtP3JJ=XVi9ybw=cTVw0C9yS2Vf0yKf8Q@mail.gmail.com> <20210720054753.cmhrsdcmvpcxg3ed@vireshk-i7>
In-Reply-To: <20210720054753.cmhrsdcmvpcxg3ed@vireshk-i7>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 20 Jul 2021 09:01:10 +0200
Message-ID: <CAK8P3a1zxiWE_yTWQWdMerJpLmYJLjZVpztze_B-yBJuO=B5Ow@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH V5 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 20, 2021 at 7:47 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 16-07-21, 20:49, Arnd Bergmann wrote:
> > It's important to get the order correct here, and there are a lot of variations
> > in hardware, so we need to pick the one that works best. Unfortunately
> > I can never quite remember what they are either ;-)
> >
> > Looking at the two ways of handling irqs that we care about
> >
> > 1. edge interrupts:
> >
> > void handle_edge_irq(struct irq_desc *desc)
> > {
> > ...
> >         desc->irq_data.chip->irq_ack(&desc->irq_data);
> >         do {
> >               ...
> >               handle_irq_event(desc);
> >         } while ((desc->istate & IRQS_PENDING) &&
> >                  !irqd_irq_disabled(&desc->irq_data));
> >        ...
> > }
> >
> > Here the irq gets rearmed first and then we call into the driver
> > that has requested it. That driver processes all information that
> > is associated with the event, or possibly multiple events that
> > have happened since the handler waslast called. If another irq
> > arrives after the driver is done looking for them, we will receive
> > another event from the virtio device and all is good.
> >
> > Ideally the 'irq_ack' would simply involve queuing another
> > request for an event on the second virtqueue. However I don't
> > know if there is a way for the virtio-gpio driver to know whether
> > this request has been observed by the virtio-gpio device.
>
> The driver will send an event (virtqueue_kick()) after the buffer is
> queued, so we can just assume that device has been notified and it has
> seen it.

That's what I was hoping for, I'm just not sure if this is required
by the virtio spec or just the usual implementation of the device
side. Have you found a section in the spec that guarantees that
the virtqueue_kick() serves as a sufficient barrier that the driver
can rely on the information having arrived?

> > If not, the irq_ack may arrive at the device only after the
> > handle_irq_event() function is complete and we miss an interrupt.
> >
> > 2. level interrupts:
> >
> > void handle_level_irq(struct irq_desc *desc)
> > {
> >         mask_ack_irq(desc);
> >         ...
> >         handle_irq_event(desc);
> >         ...
> >         cond_unmask_irq(desc);
> > }
> >
> > Going through this the literal way would mean sending a mask,
>
> One important think worth mentioning here is that the mask/unmask work
> here will be done when irq_bus_sync_unlock() is called as this is a
> slow bus and we can't do virtio-messages on mask/unmask, irq-context I
> believe.

Ok, in that case I guess the requeue has to be deferred, which may
rule out everything other than the fasteoi method.

> > ack, and unmask request through virtio and waiting for a reply
> > each time, but that does seem excessive.
> >
> > As long as the interrupt is masked initially (since there is no
> > event request pending immediately after the irq event reply),
>
> What irq event reply ?

I meant the notification from device to driver that an event has
happened.

       Arnd

