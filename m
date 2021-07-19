Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org> <4bb66b16dc261acf9d40517c8b7961a52212086b.1626418779.git.viresh.kumar@linaro.org>
 <CAK8P3a1_ZeSu0XgqF7+zA+_HhZPtQw6rrBkda0djVKwTtAqGLg@mail.gmail.com>
 <CAKohponZQxCp99RUJSNMW2yv2byJ5CkQYwsrh+3thHr2wV=+aA@mail.gmail.com>
 <CAK8P3a0iZCJBLrz652Ez70m7Zj3Tjdm-Jfw_s3wUmdceY8bkNQ@mail.gmail.com>
 <20210719092937.jqwfeouaqwarg2op@vireshk-i7> <CAK8P3a1G-vUXeVB45e5EJvqfuSKxwZ1Zt2xxWAo6z1ZQPPCPrw@mail.gmail.com>
In-Reply-To: <CAK8P3a1G-vUXeVB45e5EJvqfuSKxwZ1Zt2xxWAo6z1ZQPPCPrw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Jul 2021 13:48:12 +0200
Message-ID: <CAMuHMdU+t0Z+q=fk9wniJ_OhN8yy0O0O9ctdyoZL8+YCq1-XmQ@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain; charset="UTF-8"
To: Arnd Bergmann <arnd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Arnd,

On Mon, Jul 19, 2021 at 12:40 PM Arnd Bergmann <arnd@kernel.org> wrote:
> On Mon, Jul 19, 2021 at 11:29 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 16-07-21, 20:20, Arnd Bergmann wrote:
> > > I still don't quite get it. Why would the guest care about a stable name?
> >
> > For Linux userspace, debugging mostly, at guest userspace. Like what you get out
> > of /sys/class/gpio/gpiochipN/label or in debugfs.
> >
> > i.e. to easily identify the chip there since device names aren't fixed
> > otherwise.
> >
> > Though this was initially added by Enrico and I never though of removing it. If
> > you still think it is a waste, will get rid of it.
>
> I still don't see it as an important enough part of the interface to be encoded
> in the virtio spec. In the most likely use cases I can think of, you would never
> need more than one gpio controller in a virtio machine, since you can have
> an arbitrary number of lines connected to it already.
>
> This also simplifies the host side, as it avoids requiring the host to configure
> a name that ends up being the same almost always.

Exactly, using the GPIO aggregator you can aggregate all GPIOs you want
to export to a specific guest, followed by adjusting the permissions
on the newly created /dev/gpiochip*.

Note to $self: look into interrupt support for the GPIO Aggregator.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

