Return-Path: <viresh.kumar@linaro.org>
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org> <CAK8P3a0KuFUEA-nTb+HkS39xMWA=v-wLQ2_pz0f5oOEAXSoS_A@mail.gmail.com>
In-Reply-To: <CAK8P3a0KuFUEA-nTb+HkS39xMWA=v-wLQ2_pz0f5oOEAXSoS_A@mail.gmail.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 16 Jul 2021 22:27:21 +0530
Message-ID: <CAKohpo=4NgpZ9QQyyeA_G1yahF218NenEE3=AsEUD=iVU7W4HQ@mail.gmail.com>
Subject: Re: [PATCH V5 0/2] virtio: Add specification for virtio-gpio
Content-Type: text/plain; charset="UTF-8"
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 16 Jul 2021 at 15:28, Arnd Bergmann <arnd@kernel.org> wrote:
> On Fri, Jul 16, 2021 at 9:39 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> I've looked at the two proposals again now, and yours does look more
> mature, so I agree it makes sense to continue with your version.

Thanks for that.

> > I will let the virtio/gpio maintainers decide on its fate.
> >
> > Key differences from Enrico's approach [1]:
> >
> > - config structure is rearranged to remove unnecessary fields/padding, and place
> >   gpio_names block in such a way that we can expand the structure easily going
> >   forward, if required.
>
> Simplifying is good, maybe we can cut it down even further. I now
> actually wonder
> if we shouldn't remove the gpio names from the virtio-gpu spec entirely.
>
> In practice I assume this driver only makes sense to be used in combination
> with firmware describing how it interacts with other drivers
> (gpio-key, gpio-led,
> mmc, i2c, ...) that require access to gpio lines for something they do, and
> these already rely on DT information or some equivalent.
>
> As soon as we have a DT node for the device, the names can just be
> passed according ot the generic DT binding for gpio controllers.

So the Linux gpiolib implementation does use this information, not entirely
sure how apart from displaying that in sysfs.

The gpio-names thing is going to be dropped anyway from the config structure
and will be shared over virtqueue if really required.

> > - Interrupt implementation handled with feature bit 0. Either the interrupts are
> >   fully supported or not at all.
>
> The interrupt definition looks better than Enrico's version, but the
> serialization
> still looks incomplete, especially since you added level triggered
> mode. I always
> get confused by those as well, so we'll need to have this reviewed by an
> irqchip person as well, but let's start with my questions for now.

Sure.

> The other comments I had regarding the use of errno values, and the
> split between txq/rxq messages are things you inherited from Enrico's
> version, so those need to be resolved regardless.

Sure.

Thanks for taking time to review this Arnd.

--
Viresh

