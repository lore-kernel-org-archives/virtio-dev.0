Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626794843.git.viresh.kumar@linaro.org> <199c624bd735782dd5d4a51e376f466f5c38ef2c.1626794843.git.viresh.kumar@linaro.org>
 <CAK8P3a0PtwUMD0RRpmaXitfpUJ+OiayMMLx-4a=LnokSs4gPnA@mail.gmail.com>
 <20210726101653.5mjypnnv6rib4hon@vireshk-i7> <CAK8P3a3MFSkYzVY3TZ+F56KwM+ncEtin9pQFqfR1q_-MLJvmew@mail.gmail.com>
 <20210727075545.cq6lb7vsg4pdygtm@vireshk-i7> <CAK8P3a0ZnsOii_0HxDtbd4LcjjK29vxfCH1Kuw-wk12jPbDAXA@mail.gmail.com>
 <20210727105631.njv2wh2jvclbld56@vireshk-i7>
In-Reply-To: <20210727105631.njv2wh2jvclbld56@vireshk-i7>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 27 Jul 2021 14:06:58 +0200
Message-ID: <CAK8P3a0ZMW+PcmXShNdgtVog_vNipF5xMLGBHqZFLQPoqxrzMg@mail.gmail.com>
Subject: Re: [PATCH V6 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 27, 2021 at 12:56 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 27-07-21, 10:16, Arnd Bergmann wrote:
> > On Tue, Jul 27, 2021 at 9:55 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > My guess is that this would not cause any notable overhead, but we
> > > > will know for sure if you can measure it.
> > >
> > > I will surely try it to get the number out, but sending a request 256
> > > times instead of just once looks inefficient from the face of it :)
>
> I created a small setup with qemu-arm64 over x86:
> - Without any memcpy() of data or buffers in the GPIO drivers on both
>   ends.
> - i.e. essentially taking into consideration only the time to send
>   receive requests, the virtio core may be copying packets in between
>   though, not sure.
>
> > It could still be only one notification though, just a lot of requests
> > with a pair of buffers each, that you send all at once.
>
> If we send only one notification at the end, it takes ~ 1ms for 256
> GPIO pins, pretty much like a single request only. The downside here
> is that the device (host) also needs to prepare the queue for equal
> number (to ngpio) of elements. This is something the spec hasn't
> touched until now, i.e. how many buffers must be queued for the
> virtqueues. The max allowed in qemu is 1024 right now.

1ms is borderline I guess, it's close to the range of things that gets
annoying for boot-time optimization.

> Even if I send them sequentially, with separate notification for each
> request, it takes ~15-20 ms to finish 256 lines and ~80 for 1024
> lines.
>
> Though a single request still sounds tempting to me :)

Right, 80ms is definitely noticeable, this can easily make the difference
between an instant guest boot and a perceived delay.

> > > > I expected the host side to be atomic here. Under which circumstance
> > > > would the 'set direction out with value' call in your example block?
> > >
> > > Yes it will block, but another thread can initiate another request for
> > > a different GPIO line.
> >
> > Ok, I was hoping that the gpiolib interfaces would all end up being
> > non-blocking,
>
> I am not sure how we can do that :(

I suppose not without a complete redesign from scratch.

        Arnd

