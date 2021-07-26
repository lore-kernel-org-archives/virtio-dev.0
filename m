Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626794843.git.viresh.kumar@linaro.org> <8ebe189f12f8f46b17f92f9e2fc3f49e2e3de0a2.1626794843.git.viresh.kumar@linaro.org>
 <CAK8P3a011+3OLHXXEY5w3JOeQEbYVvbKNHOvXLV=znRSi0C-gg@mail.gmail.com> <20210726115134.o5x5udigitucs5je@vireshk-i7>
In-Reply-To: <20210726115134.o5x5udigitucs5je@vireshk-i7>
From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 26 Jul 2021 14:13:36 +0200
Message-ID: <CAK8P3a2n0mLE5pVig_UWBco5+hCGJ_RAjC2FHrPdOy5=gB9WSg@mail.gmail.com>
Subject: Re: [PATCH V6 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 26, 2021 at 1:51 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 26-07-21, 13:10, Arnd Bergmann wrote:
>
> > I would still hope that we can combine the irq_type, mask and request
>
> request ? you wanted to say "unmask" ?

No, I meant VIRTIO_GPIO_MSG_IRQ_TYPE,
VIRTIO_GPIO_MSG_IRQ_{UN,}MASK and virtio_gpio_irq_request messages.

All three can change the state between 'can interrupt' and 'can not interrupt',
so you only get notified if all three are in the active state (irq type != none,
mask disabled, request queued).

> > steps into either one or two steps. I think the minimalistic approach would
> > be to expand the message to include both the "mask" and "set-type"
> > operations, and this should work, as long as we define sensible semantics.
>
> I think we can easily merge unmask and set-type into a single message,
> since that will fit within the request structure used for most of the
> requests on the requestq. i.e. a single byte of data.
>
> mask() doesn't require irq-type, so it can live separately.

The question is whether it adds any value though. As far as I can tell,
it is completely redundant, duplicating either what is implied by
irq type==none, or what is implied by the request not being queued.

> > so an input can be configured as any of the five irq types, with
> > "IRQ_TYPE_NONE" implying that interrupts are disabled for this line.
> > This would still provide an extra way of masking the interrupt, so we just
> > need "set-direction" and "request event". In this case, setting the interrupt
> > type to "none" should probably cancel any pending irq and force the
> > message to be returned.
> >
> > You could actually take that further and fold the "set value" into "set
> > direction",
>
> At least gpio-direction-out already takes a value with it.

Ok.

        Arnd

