Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1626418779.git.viresh.kumar@linaro.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 16 Jul 2021 11:57:41 +0200
Message-ID: <CAK8P3a0KuFUEA-nTb+HkS39xMWA=v-wLQ2_pz0f5oOEAXSoS_A@mail.gmail.com>
Subject: Re: [PATCH V5 0/2] virtio: Add specification for virtio-gpio
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 16, 2021 at 9:39 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hello,
>
> This patchset adds virtio specification for GPIO devices. It supports basic GPIO
> line operations, along with optional interrupts on them (in a separate patch).
>
> This is an *alternative implementation* of the virtio-gpio specification,
> another version of it was earlier posted by Enrico [1].
>
> I took back V4 of the specification I posted earlier (on June 17th), to allow
> Enrico to come up with something that is robust and works for everyone (as he
> started this thing last year), but it didn't go as expected. I couldn't
> see any of my review comments being incorporated (or any intentions of them
> getting in ever) in the two versions Enrico posted and a month passed since
> then.
>
> And so I am trying to present an alternative approach here to solve the problem,
> which I believe is more clear and robust. I am open to suggestions to improve it
> further.

Hi Viresh,

I've looked at the two proposals again now, and yours does look more
mature, so I agree it makes sense to continue with your version.

> I will let the virtio/gpio maintainers decide on its fate.
>
> Key differences from Enrico's approach [1]:
>
> - config structure is rearranged to remove unnecessary fields/padding, and place
>   gpio_names block in such a way that we can expand the structure easily going
>   forward, if required.

Simplifying is good, maybe we can cut it down even further. I now
actually wonder
if we shouldn't remove the gpio names from the virtio-gpu spec entirely.

In practice I assume this driver only makes sense to be used in combination
with firmware describing how it interacts with other drivers
(gpio-key, gpio-led,
mmc, i2c, ...) that require access to gpio lines for something they do, and
these already rely on DT information or some equivalent.

As soon as we have a DT node for the device, the names can just be
passed according ot the generic DT binding for gpio controllers.

> - Supports freeing of a GPIO line after use.

I agree it makes sense have both alloc and free as a pair if you have one
of them, but as I commented I'm not convinced we do need them at all,
so removing both may be better here.

> - Interrupt implementation handled with feature bit 0. Either the interrupts are
>   fully supported or not at all.

The interrupt definition looks better than Enrico's version, but the
serialization
still looks incomplete, especially since you added level triggered
mode. I always
get confused by those as well, so we'll need to have this reviewed by an
irqchip person as well, but let's start with my questions for now.

> - Doesn't add any ordering restrictions on the device, it can respond earlier to
>   the second request, while still processing the first one.
>
> - Clearly state that two requests can't be initiated for the same line by device
>   or driver.

These are good.

The other comments I had regarding the use of errno values, and the
split between txq/rxq messages are things you inherited from Enrico's
version, so those need to be resolved regardless.

       Arnd

