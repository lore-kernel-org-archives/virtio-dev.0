Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org> <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
 <20210719102411.yykntzjefeamz24t@vireshk-i7> <CAK8P3a09QeGsav65dbjK9=4yNCBRHPdxP6h0O1ve3tBYRbAuzQ@mail.gmail.com>
 <20210720061130.46y76hkjm5xgvjmo@vireshk-i7> <CAK8P3a1FqQ7VzVNWAjvwBv3d84OUa3VwF5a+sHRvrphNuUAWfQ@mail.gmail.com>
 <20210720075337.k6qxlsru2ot2odb6@vireshk-i7>
In-Reply-To: <20210720075337.k6qxlsru2ot2odb6@vireshk-i7>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 20 Jul 2021 10:10:45 +0200
Message-ID: <CAK8P3a14HR9ricPxkAxKUB-prgdwh7+penZH=VuKioP=_NymUA@mail.gmail.com>
Subject: Re: [PATCH V5 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 20, 2021 at 9:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 20-07-21, 09:17, Arnd Bergmann wrote:
> > I don't think you can have a message for more than one line here,
> > that would mess up the synchronization as then you have to
> > keep double accounting of which gpios are already pending
> > on each side.
>
> Yes.
>
> > The most sensible way I see this can be done is to have a message
> > per line, and have it as a token that is either on the device or the
> > driver side at any point. When the driver has sent the token over
> > to the device, the irq is armed, and when the device replies, it is
> > implicitly masked.
>
> I like the idea in general but at this point I am not very sure how it
> will work. Looking at kernel (and qemu) side implementations, what
> really transfers between device and driver is a series of buffers
> (marked as in or out sgs). Now these are either device writable or
> driver. I am not sure if the device is required to write anything here
> to the buffer, it can simply return the buffer as is and so we can
> make it driver writable only, i.e. only 1 sg element required.

I think it can be done either way:

a) if you have two buffers, the driver asks for an irq event, and
the driver replies with a filled-out event saying what happened,
or that it could not do it.

b) with just one buffer, we know that something happened,
but now the driver has to ensure that the event request is
valid before queuing it. If the driver asks for an event on a
gpio line that is not an irq source, or configured as output,
or has a mode that the device cannot support, the event
would either have to be returned immediately or never.

> > and VIRTIO_GPIO_MSG_IRQ_UNMASK
>
> I think we would still require some kind of unmasking here as the
> driver would have already sent the buffer to the device and wants the
> ownership back, otherwise it may hit an interrupt later on.

I think we can live with getting a spurious interrupt in case the
driver reconfigures the line later on to no longer be an interrupt
source.

> Although I would like to keep the three routines separate, just to be
> robust here. For example what will we do if the user does this (yes it
> won't do it, but I am trying to handle the corner cases well):
>
> 1. irq-type-edge-falling
> 2. irq-unmask
> 3. irq-type-edge-both
>
> Since we would have already sent the buffer at (2), we can't do (3)
> without getting the buffer back.
>
> Tying everything with availability of the buffer itself makes it kind
> of messy.

Right, this case would be easier for the guest if we separate setting
the irq polarity from the action of asking for an event, but I suspect
it would make the device implementation trickier in the process
(which you may not care about as much).

An easy way to deal with this scenario would be to mandate
that any VIRTIO_GPIO_MSG_SET_* command forces the
irq event message to trigger and have to be requeued.

       Arnd

