Return-Path: <viresh.kumar@linaro.org>
Date: Mon, 19 Jul 2021 14:59:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 1/2] virtio-gpio: Add the device specification
Message-ID: <20210719092937.jqwfeouaqwarg2op@vireshk-i7>
References: <cover.1626418779.git.viresh.kumar@linaro.org>
 <4bb66b16dc261acf9d40517c8b7961a52212086b.1626418779.git.viresh.kumar@linaro.org>
 <CAK8P3a1_ZeSu0XgqF7+zA+_HhZPtQw6rrBkda0djVKwTtAqGLg@mail.gmail.com>
 <CAKohponZQxCp99RUJSNMW2yv2byJ5CkQYwsrh+3thHr2wV=+aA@mail.gmail.com>
 <CAK8P3a0iZCJBLrz652Ez70m7Zj3Tjdm-Jfw_s3wUmdceY8bkNQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0iZCJBLrz652Ez70m7Zj3Tjdm-Jfw_s3wUmdceY8bkNQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 16-07-21, 20:20, Arnd Bergmann wrote:
> I still don't quite get it. Why would the guest care about a stable name?

For Linux userspace, debugging mostly, at guest userspace. Like what you get out
of /sys/class/gpio/gpiochipN/label or in debugfs.

i.e. to easily identify the chip there since device names aren't fixed
otherwise.

Though this was initially added by Enrico and I never though of removing it. If
you still think it is a waste, will get rid of it.

> Shouldn't all users of the gpio node be handled through phandle references
> and similar?

Yeah, users should be using that.

> Right. Any thoughts about just having the names be part of the
> metadata in the DT? I think that sounds easier than the request,
> though both methods are fairly straightforward really.

I think we shouldn't divide stuff in between spec and DT as the spec can be used
without DT as well. And so keeping them entirely in the spec may be better. The
same holds true otherwise for number of gpio lines as well, or the entire config
structure.

> Ah, so maybe it's more like what I was looking for then after all, rather than
> what I understood you do.

Naah, you understood it correctly earlier.

> To clarify: the flow as I now understand it is
> 
> - driver wants something (configuration, gpio read, gpio write, irq ack, ...):
>   driver sends a message with transmit and receive buffer on the first
>   queue and gets a reply back immediately
> 
> - device wants something (only an irq):
>   driver sets up a message to receive a buffer for a line, device fills it
>   when the event happens.

And this is what I am going to do now :)

In the irq case, the driver must send a response message as well, to inform that
interrupt is processed and it is ready for the next one.

> That should not be an issue. I think the reply would always be instantaneous
> here, and the requests can just be processed in order.

They aren't required to be in order after all. Lets say 3 different requests are
added by 3 different threads in guest, they can all reach in random order at the
host and the host can send response to them in any order. At least in Linux, you
can attach a void *data with each transfer and we can easily use that to
identify the transfer which completed.

> Do you have an example for what the hardware driver would do here?

Activate functioning of a pin ?

I see many drivers in Linux who do some reg read/write in request, not exactly
sure what's going on but something on the lines of activating/deactivating a
line. Examples: gpio-cadence.c, gpio-din2.c, gpio-cs5535.c, gpio-mb86s7x.c, etc.

> Maybe LinusW can clarify whether he thinks it is needed.

+1

> Even if the hardware requires the request/free style calls in case of
> passing through a line to a guest, I would expect that can be handled
> in host user space, i.e. the virtio device code calls 'request' before it
> passes down a gpio line to a guest.

That may not always work and this count of refcounting at the backend daemon may
not be correct.

So, the guest calls set-direction-out-with-val-1, the backend activates the GPIO
pin, sets direction/value and then deactivates it ? That won't work, right ?

On those lines, I think these operations must be renamed to ACTIVATE/DEACTIVATE
instead of REQUEST/FREE, that is what we want to do here.

-- 
viresh

