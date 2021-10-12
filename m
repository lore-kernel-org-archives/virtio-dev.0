Return-Path: <viresh.kumar@linaro.org>
Date: Tue, 12 Oct 2021 15:01:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V9] virtio-gpio: Add support for interrupts
Message-ID: <20211012093151.cygjqn4zpp5gewdk@vireshk-i7>
References: <ed36fcb94f33cf27106b6ea0a555f71400d27ade.1634022690.git.viresh.kumar@linaro.org>
 <CAK8P3a2UcbjcB1qDEe7XGAPRwdg8c=SnjfHAwri6frx5Mf1fNQ@mail.gmail.com>
 <20211012083307.rwozwxyzw4jabsue@vireshk-i7>
 <CAK8P3a1hGeJ7tchGdCQKKA+6rQksbi5dVhin_N+cFaUjOELV2Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1hGeJ7tchGdCQKKA+6rQksbi5dVhin_N+cFaUjOELV2Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Kent Gibson <warthog618@gmail.com>, Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On 12-10-21, 11:16, Arnd Bergmann wrote:
> I don't see a problem with the flexibility, but I find the inconsistency
> slightly annoying: if disabling the interrupt line has the side-effect of
> masking it, it should not be possible to unmask it before enabling.

I agree, this doesn't look consistent here.

> To have it more consistent, it would seem better to do one of two
> things:
> 
> a) require disabled interrupts to always be masked, only allowing
>     the unmask to happen after enable, while forcing a mask
>     during disable.
> 
> or
> 
> b) separate the 'mask' from the 'disable' operation, leaving the
>     event descriptor queued if you disable it, but adding another
>     operation for an explicit mask (i.e. return the event descriptor)
>     that is separate from 'disable'.
> 
> I would prefer a) here since I think that makes a nicer virtio spec,
> but b) would make it more similar to hardware gpio controllers.
> 
> In the end, I don't think any of the combinations would cause
> problems, this is just a matter of personal taste.

I also like option A to be a better (easier) choice here, though it
may make the Linux implementation a bit inefficient (maybe few extra
if/else blocks while enabling/disabling irqs). I will update this in
the next version then.

-- 
viresh

