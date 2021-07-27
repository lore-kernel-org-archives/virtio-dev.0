Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626794843.git.viresh.kumar@linaro.org> <8ebe189f12f8f46b17f92f9e2fc3f49e2e3de0a2.1626794843.git.viresh.kumar@linaro.org>
 <CAK8P3a011+3OLHXXEY5w3JOeQEbYVvbKNHOvXLV=znRSi0C-gg@mail.gmail.com>
 <20210726115134.o5x5udigitucs5je@vireshk-i7> <CAK8P3a2n0mLE5pVig_UWBco5+hCGJ_RAjC2FHrPdOy5=gB9WSg@mail.gmail.com>
 <20210727062318.isjkuaiaxn2qrkdi@vireshk-i7> <CAK8P3a1k8gtHsK9YQjQGsBau8MWia8NisN5CBdMjY829y9-mPg@mail.gmail.com>
 <20210727110156.ptqm2ep5xdvebvje@vireshk-i7> <CAK8P3a1h9FZh9+rNzk457pLj1xD=QXAgB_ZjuaaHb5HAZGeo+Q@mail.gmail.com>
 <20210727112650.nrhwmryn75igpq3e@vireshk-i7>
In-Reply-To: <20210727112650.nrhwmryn75igpq3e@vireshk-i7>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 27 Jul 2021 14:42:57 +0200
Message-ID: <CAK8P3a2TvrmBdF7SwYh5_2RKyUnyEDcGfNcmBi9ij-UjAsYY2w@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH V6 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 27, 2021 at 1:26 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 27-07-21, 13:16, Arnd Bergmann wrote:
> > This was under the assumption that we decide to still keep some
> > controlq request that sets the irq type and just remove the 'mask'
> > command.
>
> Right, so I think I can fold all three of irq messages, mask, unmask
> and type, to a single message type. Where the value of type can play
> the role of masking/unmasking. This should work fine, I will see if I
> get any more doubts on this.
>
> > If we go all the way to having only one message for interrupts, I
> > suppose it does get a little uglier than I was hoping for, but it would still
> > be doable: in this case, we could allow a flow like this on the eventq:
> >
> > - driver requests edge interrupts
>
> This over eventq and ..
>
> > - (no event happened, so request remains pending)
> > - driver queues a new request asking for IRQ_TYPE_NONE notification
> >   in order to mask this line
>
> This over controlq. Right ?

Sorry for not being too clear: this was meant as the example
where both messages are on the eventq. It would work just
as well if the irq type setting is a message on the controlq though,
so I suppose it doesn't matter what I was thinking as long as
we end up with a working design ;-)

> > - device replies to both requests saying no interrupt happened
>
> Yes, that can work.
>
> > Between this control flow and the version where set-type is part of
> > set-direction, I would prefer the other option, but you already said
> > that you don't like that one.
>
> Yeah, I would like to keep this away from set-direction, which I am
> already going to use for activate/deactivate :)

Ok, so the set of relevant messages here would be:

- controlq: set direction (includes enable, but not set-irq-type)
- controlq: set-irq-type (may cancel outstanding eventq request)
- eventq: request notification (implies unmask, reply implies mask)

This sounds like a reasonably consistent and efficient way to do it,
I'm happy enough with that design for the next version.

        Arnd

