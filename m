Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <cover.1626794843.git.viresh.kumar@linaro.org> <199c624bd735782dd5d4a51e376f466f5c38ef2c.1626794843.git.viresh.kumar@linaro.org>
 <CAK8P3a0PtwUMD0RRpmaXitfpUJ+OiayMMLx-4a=LnokSs4gPnA@mail.gmail.com> <20210726101653.5mjypnnv6rib4hon@vireshk-i7>
In-Reply-To: <20210726101653.5mjypnnv6rib4hon@vireshk-i7>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Jul 2021 13:30:40 +0200
Message-ID: <CAMuHMdXTCqAfnLKzHh0tWWRjHo0eNJ74xM3SKoj0=kscw5faCQ@mail.gmail.com>
Subject: Re: [PATCH V6 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Viresh,

On Mon, Jul 26, 2021 at 12:16 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 26-07-21, 11:18, Arnd Bergmann wrote:
> > Here I have the opposite question: what is the benefit of allowing the requests
> > to be processed out of order? Should these not all be instantaneous, and easier
> > to handle by making the request queue serialized?
>
> Lets say the guest sends two requests, almost at the same time to
> the host and they are queued on the vq in this order only:
>
> - set direction-out-with-value-1 for line 5.
> - set direction-in for line 11.
>
> Now, if the host is able to process them in parallel, then the second
> request for line 11 may finish before the requests for line 5 (as it
> has lesser amount of work to do).

Speaking about parallel processing, have you already envisioned
support for .[sg]et_multiple()?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

