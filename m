Return-Path: <viresh.kumar@linaro.org>
Date: Tue, 20 Jul 2021 14:12:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 2/2] virtio-gpio: Add support for interrupts
Message-ID: <20210720084206.whknzzlt7n37o6dp@vireshk-i7>
References: <cover.1626418779.git.viresh.kumar@linaro.org>
 <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
 <20210719102411.yykntzjefeamz24t@vireshk-i7>
 <CAK8P3a09QeGsav65dbjK9=4yNCBRHPdxP6h0O1ve3tBYRbAuzQ@mail.gmail.com>
 <20210720061130.46y76hkjm5xgvjmo@vireshk-i7>
 <CAK8P3a1FqQ7VzVNWAjvwBv3d84OUa3VwF5a+sHRvrphNuUAWfQ@mail.gmail.com>
 <20210720075337.k6qxlsru2ot2odb6@vireshk-i7>
 <CAK8P3a14HR9ricPxkAxKUB-prgdwh7+penZH=VuKioP=_NymUA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a14HR9ricPxkAxKUB-prgdwh7+penZH=VuKioP=_NymUA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 20-07-21, 10:10, Arnd Bergmann wrote:
> I think it can be done either way:
> 
> a) if you have two buffers, the driver asks for an irq event, and
> the driver replies with a filled-out event saying what happened,
> or that it could not do it.
> 
> b) with just one buffer, we know that something happened,
> but now the driver has to ensure that the event request is
> valid before queuing it. If the driver asks for an event on a
> gpio line that is not an irq source, or configured as output,
> or has a mode that the device cannot support, the event
> would either have to be returned immediately or never.

> I think we can live with getting a spurious interrupt in case the
> driver reconfigures the line later on to no longer be an interrupt
> source.

> Right, this case would be easier for the guest if we separate setting
> the irq polarity from the action of asking for an event, but I suspect
> it would make the device implementation trickier in the process
> (which you may not care about as much).
> 
> An easy way to deal with this scenario would be to mandate
> that any VIRTIO_GPIO_MSG_SET_* command forces the
> irq event message to trigger and have to be requeued.

I will put more thought to the whole stuff and update the spec based
on what I get to finally.

But I really liked the idea of the token system, with a separate
message for each GPIO line. That will solve most of our problems.

-- 
viresh

