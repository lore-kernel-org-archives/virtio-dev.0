Return-Path: <viresh.kumar@linaro.org>
Date: Tue, 20 Jul 2021 11:17:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [virtio-dev] Re: [PATCH V5 2/2] virtio-gpio: Add support for
 interrupts
Message-ID: <20210720054753.cmhrsdcmvpcxg3ed@vireshk-i7>
References: <cover.1626418779.git.viresh.kumar@linaro.org>
 <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
 <CAK8P3a0jRnxz6-WTmWyA04H2B+KP0AQ_7G6RyBqecKa8Xp37rA@mail.gmail.com>
 <CAKohponTstJF108wtSpGWYy0xETh6AzGaesjREGDKav5Yyy06g@mail.gmail.com>
 <CAK8P3a1G3OO19nnL19B1sU5PBgRpk3eGPZKXz7j55=X+ngNggg@mail.gmail.com>
 <CAKohpo=6Ntb7qgu6T1TOfUYYQVxnhc2DZcgn6TPJEY-_27RW0w@mail.gmail.com>
 <CAK8P3a0AH0dAkCtvZNtP3JJ=XVi9ybw=cTVw0C9yS2Vf0yKf8Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0AH0dAkCtvZNtP3JJ=XVi9ybw=cTVw0C9yS2Vf0yKf8Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 16-07-21, 20:49, Arnd Bergmann wrote:
> It's important to get the order correct here, and there are a lot of variations
> in hardware, so we need to pick the one that works best. Unfortunately
> I can never quite remember what they are either ;-)
> 
> Looking at the two ways of handling irqs that we care about
> 
> 1. edge interrupts:
> 
> void handle_edge_irq(struct irq_desc *desc)
> {
> ...
>         desc->irq_data.chip->irq_ack(&desc->irq_data);
>         do {
>               ...
>               handle_irq_event(desc);
>         } while ((desc->istate & IRQS_PENDING) &&
>                  !irqd_irq_disabled(&desc->irq_data));
>        ...
> }
> 
> Here the irq gets rearmed first and then we call into the driver
> that has requested it. That driver processes all information that
> is associated with the event, or possibly multiple events that
> have happened since the handler waslast called. If another irq
> arrives after the driver is done looking for them, we will receive
> another event from the virtio device and all is good.
> 
> Ideally the 'irq_ack' would simply involve queuing another
> request for an event on the second virtqueue. However I don't
> know if there is a way for the virtio-gpio driver to know whether
> this request has been observed by the virtio-gpio device.

The driver will send an event (virtqueue_kick()) after the buffer is
queued, so we can just assume that device has been notified and it has
seen it.

> If not, the irq_ack may arrive at the device only after the
> handle_irq_event() function is complete and we miss an interrupt.
> 
> 2. level interrupts:
> 
> void handle_level_irq(struct irq_desc *desc)
> {
>         mask_ack_irq(desc);
>         ...
>         handle_irq_event(desc);
>         ...
>         cond_unmask_irq(desc);
> }
> 
> Going through this the literal way would mean sending a mask,

One important think worth mentioning here is that the mask/unmask work
here will be done when irq_bus_sync_unlock() is called as this is a
slow bus and we can't do virtio-messages on mask/unmask, irq-context I
believe.

> ack, and unmask request through virtio and waiting for a reply
> each time, but that does seem excessive.
> 
> As long as the interrupt is masked initially (since there is no
> event request pending immediately after the irq event reply),

What irq event reply ?

> I would hope that we can get away with simply enqueuing the
> request in the 'cond_unmask_irq' step. In this case, we would
> call all handlers for this the level irq with the line pending
> and masked. After the handlers are complete, it should no
> longer be pending and we can unmask it. If another event comes
> in after the handler, it gets pending again, and we get sent a
> new irq event reply after the Ack.

Okay..

-- 
viresh

