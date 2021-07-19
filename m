Return-Path: <virtio-dev-return-8323-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D20D39861EC
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Jul 2021 10:40:37 +0000 (UTC)
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org> <4bb66b16dc261acf9d40517c8b7961a52212086b.1626418779.git.viresh.kumar@linaro.org>
 <CAK8P3a1_ZeSu0XgqF7+zA+_HhZPtQw6rrBkda0djVKwTtAqGLg@mail.gmail.com>
 <CAKohponZQxCp99RUJSNMW2yv2byJ5CkQYwsrh+3thHr2wV=+aA@mail.gmail.com>
 <CAK8P3a0iZCJBLrz652Ez70m7Zj3Tjdm-Jfw_s3wUmdceY8bkNQ@mail.gmail.com> <20210719092937.jqwfeouaqwarg2op@vireshk-i7>
In-Reply-To: <20210719092937.jqwfeouaqwarg2op@vireshk-i7>
From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 19 Jul 2021 12:40:18 +0200
Message-ID: <CAK8P3a1G-vUXeVB45e5EJvqfuSKxwZ1Zt2xxWAo6z1ZQPPCPrw@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH V5 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 19, 2021 at 11:29 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 16-07-21, 20:20, Arnd Bergmann wrote:
> > I still don't quite get it. Why would the guest care about a stable name?
>
> For Linux userspace, debugging mostly, at guest userspace. Like what you get out
> of /sys/class/gpio/gpiochipN/label or in debugfs.
>
> i.e. to easily identify the chip there since device names aren't fixed
> otherwise.
>
> Though this was initially added by Enrico and I never though of removing it. If
> you still think it is a waste, will get rid of it.

I still don't see it as an important enough part of the interface to be encoded
in the virtio spec. In the most likely use cases I can think of, you would never
need more than one gpio controller in a virtio machine, since you can have
an arbitrary number of lines connected to it already.

This also simplifies the host side, as it avoids requiring the host to configure
a name that ends up being the same almost always.

If Linus or Bartosz think we should have the name, leave it in there, otherwise
I'd remove it.

> > Right. Any thoughts about just having the names be part of the
> > metadata in the DT? I think that sounds easier than the request,
> > though both methods are fairly straightforward really.
>
> I think we shouldn't divide stuff in between spec and DT as the spec can be used
> without DT as well. And so keeping them entirely in the spec may be better. The
> same holds true otherwise for number of gpio lines as well, or the entire config
> structure.

Encoding the number of gpio lines in the config registers makes sense to me,
but I don't see how you can sensibly get away without some other structure
to describe what the lines are. It doesn't have to be DT, but that's what we use
in practice.

> > That should not be an issue. I think the reply would always be instantaneous
> > here, and the requests can just be processed in order.
>
> They aren't required to be in order after all. Lets say 3 different requests are
> added by 3 different threads in guest, they can all reach in random order at the
> host and the host can send response to them in any order. At least in Linux, you
> can attach a void *data with each transfer and we can easily use that to
> identify the transfer which completed.

Ok, good.

> > Even if the hardware requires the request/free style calls in case of
> > passing through a line to a guest, I would expect that can be handled
> > in host user space, i.e. the virtio device code calls 'request' before it
> > passes down a gpio line to a guest.
>
> That may not always work and this count of refcounting at the backend daemon may
> not be correct.
>
> So, the guest calls set-direction-out-with-val-1, the backend activates the GPIO
> pin, sets direction/value and then deactivates it ? That won't work, right ?
>
> On those lines, I think these operations must be renamed to ACTIVATE/DEACTIVATE
> instead of REQUEST/FREE, that is what we want to do here.

From the drivers you pointed to, it seems to be something like a 'disconnected'
state where the pin is neither input nor output, so this could perhaps
get reflected
in the interface as well, by having each pin be one of IN/OUT/NONE. Not sure
if that is any better.

     Arnd

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

