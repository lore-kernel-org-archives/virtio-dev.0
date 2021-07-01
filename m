Return-Path: <virtio-dev-return-8223-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D9FAF98635D
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Jul 2021 16:09:05 +0000 (UTC)
Date: Thu, 1 Jul 2021 21:39:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Message-ID: <20210701160900.bk4nfoyre4zb6l2y@vireshk-i7>
References: <20210630115837.12182-1-info@metux.net>
 <20210630152213.xhqhke54gzt3esdj@vireshk-i7>
 <641254c3-d60d-eb17-7388-29dd9ebcb826@metux.net>
 <20210630173022.7ukqg764z5xi5uho@vireshk-i7>
 <3be7fbc9-6765-c83a-4340-32ab1b62f132@metux.net>
MIME-Version: 1.0
In-Reply-To: <3be7fbc9-6765-c83a-4340-32ab1b62f132@metux.net>
Subject: Re: [virtio-dev] Re: [virtio-comment] [PATCH v2] virtio-gpio: add
 formal specification
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Vincent Guittot <vincent.guittot@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Wang <jasowang@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Arnd Bergmann <arnd@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 01-07-21, 16:21, Enrico Weigelt, metux IT consult wrote:
> On 30.06.21 19:30, Viresh Kumar wrote:
> > I don't expect others, specially the GPIO maintainers or Arnd, to have
> > subscribed to these lists (and many times people try to subscribe to
> > lists with no-email option, so their reply can reach to everyone,
> > while don't want unnecessary emails).
> 
> okay, I'm hereby nominate you for the moderator of this virtual meetting
> who takes care of those things :p

What about start cc'ing LKML here then, so everyone gets every message
unconditionally ?

> > What about the changes to the config structure to make it efficient,
> > easily extendable,
> 
> What exactly are you missing here, that cannot be easily added in future
> versions ?
> 
> We currently have:
> 
> * plenty free bytes
> * version field for clear distinction
> * config space may be increased later

Please look at this here, I am not willing to explain them again.

https://lists.oasis-open.org/archives/virtio-comment/202106/msg00037.html

And reply right there on that thread. In short, version field needs to
go, we need to remove all extra padding and add gpio_names_offset.

If you don't agree, you can post your reasoning in reply to that, but
on the main thread please.

> > Over that, if you don't want to implement interrupts in your version
> > (I can surely send a patch for that), then you need to drop the
> > half-hearted interrupt support, i.e.  VIRTIO_GPIO_MSG_DEVICE_LEVEL, as
> > that is not the right way of implementing interrupts.
> 
> This is message is an signal that tells the level has changed and what
> the new level is.

You can call it whatever you want, but this really is an interrupt
from device to driver. And it shouldn't be implemented this way.

Moreover, an interrupt should never come in the first place until the
time the driver (guest) has requested the device (host) for enabling
it.

> It is just an event. If you wanna use that event as
> an interrupt source, it naturally fits an edge interrupt.
> 
> Note that we're still talking about an gpio controller, not an interrupt
> controller. The gpio controller signals when something happened on some
> input, and it even tells it along with that signal, no explicit readout
> required (as on traditional controllers).

No, you do polling if you want to read something. GPIO doesn't need an
interrupt if the users don't want to be notified about changes.

> Masking out unintersting events is a more sophisticated functionality
> (which needs lots of more gates in HW). Certainly good to have, but
> that really shouldn't be mandatory for all. That's why I've explicitly
> planned that as an *optional* feature (means: controller announces that
> in a dedicated feature bit).

Sure, but this kind of half-hearted interrupt implementation is not
going to fly. Sorry about that.

Either don't support interrupts, or if you want to do, then please do
it properly.

> > This will make the specification as well as Linux or backend code messy,
> > as we would be required to support interrupts in two ways in this case
> > based on irq-feature.
> 
> Why so ? If HW has the IRQ controller feature bit set, we send the
> mask / unmask messages, otherwise we don't. Will be a simple 'if'
> statement in virtio_gpio_irq_mask() / virtio_gpio_irq_unmask(). Two
> extra lines in each function.

We are writing a new specification here, and we aren't going to make
the specification or code confusing in this aspect.

From your Linux side driver, this is what you do on this event:

static void virtio_gpio_signal(struct virtio_gpio_priv *priv, int event,
                              int pin, int value)
{
       int mapped_irq = irq_find_mapping(priv->gc.irq.domain, pin);

       if ((pin < priv->num_gpios) && test_bit(pin, priv->irq_mask))
               generic_handle_irq(mapped_irq);
}

How can you even say this isn't interrupt ? You are trying the
interrupt in a hacky way and it isn't going to work. Sorry about that.

I am fine in implementing the interrupt support in driver and spec,
but you need to drop this event completely here for that.

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

