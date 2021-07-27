Return-Path: <viresh.kumar@linaro.org>
MIME-Version: 1.0
References: <cover.1626794843.git.viresh.kumar@linaro.org> <199c624bd735782dd5d4a51e376f466f5c38ef2c.1626794843.git.viresh.kumar@linaro.org>
 <CAK8P3a0PtwUMD0RRpmaXitfpUJ+OiayMMLx-4a=LnokSs4gPnA@mail.gmail.com>
 <20210726101653.5mjypnnv6rib4hon@vireshk-i7> <CAK8P3a3MFSkYzVY3TZ+F56KwM+ncEtin9pQFqfR1q_-MLJvmew@mail.gmail.com>
 <20210727075545.cq6lb7vsg4pdygtm@vireshk-i7> <CAK8P3a0ZnsOii_0HxDtbd4LcjjK29vxfCH1Kuw-wk12jPbDAXA@mail.gmail.com>
 <20210727105631.njv2wh2jvclbld56@vireshk-i7> <CAK8P3a0ZMW+PcmXShNdgtVog_vNipF5xMLGBHqZFLQPoqxrzMg@mail.gmail.com>
In-Reply-To: <CAK8P3a0ZMW+PcmXShNdgtVog_vNipF5xMLGBHqZFLQPoqxrzMg@mail.gmail.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 27 Jul 2021 19:47:24 +0530
Message-ID: <CAKohponT-XW5WbdJ6Bx_h5faw7GOcSiT8RxHy44hHExB0vV=Xw@mail.gmail.com>
Subject: Re: [PATCH V6 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain; charset="UTF-8"
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 27 Jul 2021 at 17:37, Arnd Bergmann <arnd@kernel.org> wrote:
> On Tue, Jul 27, 2021 at 12:56 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> > If we send only one notification at the end, it takes ~ 1ms for 256
> > GPIO pins, pretty much like a single request only. The downside here
> > is that the device (host) also needs to prepare the queue for equal
> > number (to ngpio) of elements. This is something the spec hasn't
> > touched until now, i.e. how many buffers must be queued for the
> > virtqueues. The max allowed in qemu is 1024 right now.
>
> 1ms is borderline I guess, it's close to the range of things that gets
> annoying for boot-time optimization.
>
> > Even if I send them sequentially, with separate notification for each
> > request, it takes ~15-20 ms to finish 256 lines and ~80 for 1024
> > lines.
> >
> > Though a single request still sounds tempting to me :)
>
> Right, 80ms is definitely noticeable, this can easily make the difference
> between an instant guest boot and a perceived delay.

It is also important to mention here that in my current example, there
was no copy
of the gpio line name string made anywhere.

If we choose this message to be per-line, then there will be at least one memcpy
at the host of the string for each GPIO line, there may be another
copy somewhere
in between at guest or host, not sure. Though in case of a single
request, this will
be a single memcpy operation at the guest (and others in between as
mentioned earlier),
but not per line and maybe more efficient.

So even in the best possible scenario, this will be several ms, at
least for separate
message for each GPIO line.

Anyway, how do you suggest I define this call now. Per-line or entire
block (fixed size or
from config structure) ? I will do it the way you suggest to cut short
the discussion :)

> > I am not sure how we can do that :(
>
> I suppose not without a complete redesign from scratch.

Yeah, I am not doing it then :)

--
viresh

