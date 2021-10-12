Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <ed36fcb94f33cf27106b6ea0a555f71400d27ade.1634022690.git.viresh.kumar@linaro.org>
 <CAK8P3a2UcbjcB1qDEe7XGAPRwdg8c=SnjfHAwri6frx5Mf1fNQ@mail.gmail.com> <20211012083307.rwozwxyzw4jabsue@vireshk-i7>
In-Reply-To: <20211012083307.rwozwxyzw4jabsue@vireshk-i7>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 12 Oct 2021 11:16:10 +0200
Message-ID: <CAK8P3a1hGeJ7tchGdCQKKA+6rQksbi5dVhin_N+cFaUjOELV2Q@mail.gmail.com>
Subject: Re: [PATCH V9] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Kent Gibson <warthog618@gmail.com>, Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Oct 12, 2021 at 10:33 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 12-10-21, 09:51, Arnd Bergmann wrote:
> >
> > This should work fine, but it seems odd that this is asymmetric between
> > enable/unmask and disable/mask. My feeling is that it would be more consistent
> > if you also require the "enable" to happen before "unmask" to limit the number
> > possible states that the irq line can be in.
>
> If you look at a regular IP block (GPIO or GIC, etc) which exposes
> registers for enable/disable and mask/unmask, then normally they won't
> have any constraints on what needs to be done first enable or unmask.
> Both have different purposes and can be handled (and must be) handled
> separately. The same should apply here as well.

I don't see a problem with the flexibility, but I find the inconsistency
slightly annoying: if disabling the interrupt line has the side-effect of
masking it, it should not be possible to unmask it before enabling.

To have it more consistent, it would seem better to do one of two
things:

a) require disabled interrupts to always be masked, only allowing
    the unmask to happen after enable, while forcing a mask
    during disable.

or

b) separate the 'mask' from the 'disable' operation, leaving the
    event descriptor queued if you disable it, but adding another
    operation for an explicit mask (i.e. return the event descriptor)
    that is separate from 'disable'.

I would prefer a) here since I think that makes a nicer virtio spec,
but b) would make it more similar to hardware gpio controllers.

In the end, I don't think any of the combinations would cause
problems, this is just a matter of personal taste.

       Arnd

