Return-Path: <viresh.kumar@linaro.org>
Date: Mon, 19 Jul 2021 13:02:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 1/2] virtio-gpio: Add the device specification
Message-ID: <20210719073249.gopt6iqb3gzf2bsn@vireshk-i7>
References: <cover.1626418779.git.viresh.kumar@linaro.org>
 <4bb66b16dc261acf9d40517c8b7961a52212086b.1626418779.git.viresh.kumar@linaro.org>
 <CAK8P3a1_ZeSu0XgqF7+zA+_HhZPtQw6rrBkda0djVKwTtAqGLg@mail.gmail.com>
 <CAKohponZQxCp99RUJSNMW2yv2byJ5CkQYwsrh+3thHr2wV=+aA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKohponZQxCp99RUJSNMW2yv2byJ5CkQYwsrh+3thHr2wV=+aA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 16-07-21, 21:56, Viresh Kumar wrote:
> On Fri, 16 Jul 2021 at 13:54, Arnd Bergmann <arnd@kernel.org> wrote:

> > As they are always treated as a transaction, wouldn't it be easier to have
> > a single virtqueue and make each transaction have both an input and an
> > output buffer?
> parallel
> 
> That's what I did initially (and that's we did in I2C as well), but
> then I realised
> that it may not work well with transactions done in parallel.
> 
> For example, we want to allow setting direction to input for pins 5 and 8 in
> parallel. I at that time thought that with using a single virtqueue for both
> request/response messages may block the virtqueue for further usage. But
> now that I think about it a bit more, it may not.
> 
> We should still be able to identify different response messages based on the
> address of the buffer (for example) and so what you are suggesting may
> actually work and won't be a bottleneck as I thought of it earlier.
> 
> If this works fine, I will move back to one virtqueue for all non-irq
> stuff, like I
> had until V4 and one virtqueue only for interrupt processing.

Okay, I tested this and it works. I was able to send multiple requests in
parallel and it worked out fine.

So I am going to switch back to what I had earlier, i.e. one virtqueue for all
requests originating from driver and its response from device.

And a different virtqueue for interrupts.

-- 
viresh

