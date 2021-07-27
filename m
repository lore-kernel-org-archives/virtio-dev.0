Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626794843.git.viresh.kumar@linaro.org> <8ebe189f12f8f46b17f92f9e2fc3f49e2e3de0a2.1626794843.git.viresh.kumar@linaro.org>
 <CAK8P3a011+3OLHXXEY5w3JOeQEbYVvbKNHOvXLV=znRSi0C-gg@mail.gmail.com>
 <20210726115134.o5x5udigitucs5je@vireshk-i7> <CAK8P3a2n0mLE5pVig_UWBco5+hCGJ_RAjC2FHrPdOy5=gB9WSg@mail.gmail.com>
 <20210727062318.isjkuaiaxn2qrkdi@vireshk-i7>
In-Reply-To: <20210727062318.isjkuaiaxn2qrkdi@vireshk-i7>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 27 Jul 2021 10:03:01 +0200
Message-ID: <CAK8P3a1k8gtHsK9YQjQGsBau8MWia8NisN5CBdMjY829y9-mPg@mail.gmail.com>
Subject: Re: [PATCH V6 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 27, 2021 at 8:23 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 26-07-21, 14:13, Arnd Bergmann wrote:
> > The question is whether it adds any value though. As far as I can tell,
> > it is completely redundant, duplicating either what is implied by
> > irq type==none, or what is implied by the request not being queued.
>
> Right, we shouldn't have redundant stuff in here.
>
> Though, binding of all interrupt operations to the eventq can be trick
> IMO.
>
> - How will the driver mask an interrupt for which the buffer is
>   already sent over the eventq? There is no API available to recall a
>   buffer. So we would need an API over the requestq for that.

Agreed, there needs to be some way to cancel the request. I don't
think this would have to be a fast or common operation, so setting
the line back to IRQ_TYPE_NONE would be one way.

Another option would be to make the mask software-only and
just ignore an incoming event for a line that is configured as
masked, and then not requeue the request.

> - Latching of edge interrupt between the buffer is returned by the
>   device and requeued by the driver. How will the device know if the
>   user has simply requeued the eventq buffer (where the latched value
>   is meaningful) or it has done something like free_irq() followed by
>   request_irq() in the kernel (where the latched value must be
>   discarded).

I was expecting a 'mask' to not discard the latched event but simply
not deliver it until it gets unmasked. Either way, we can define that
a new set-irq-type request discards all latched edge interrupts.

       Arnd

