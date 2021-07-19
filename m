Return-Path: <viresh.kumar@linaro.org>
Date: Mon, 19 Jul 2021 16:20:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 1/2] virtio-gpio: Add the device specification
Message-ID: <20210719105041.4rn2opwhrisxtglu@vireshk-i7>
References: <cover.1626418779.git.viresh.kumar@linaro.org>
 <4bb66b16dc261acf9d40517c8b7961a52212086b.1626418779.git.viresh.kumar@linaro.org>
 <CAK8P3a1_ZeSu0XgqF7+zA+_HhZPtQw6rrBkda0djVKwTtAqGLg@mail.gmail.com>
 <CAKohponZQxCp99RUJSNMW2yv2byJ5CkQYwsrh+3thHr2wV=+aA@mail.gmail.com>
 <CAK8P3a0iZCJBLrz652Ez70m7Zj3Tjdm-Jfw_s3wUmdceY8bkNQ@mail.gmail.com>
 <20210719092937.jqwfeouaqwarg2op@vireshk-i7>
 <CAK8P3a1G-vUXeVB45e5EJvqfuSKxwZ1Zt2xxWAo6z1ZQPPCPrw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1G-vUXeVB45e5EJvqfuSKxwZ1Zt2xxWAo6z1ZQPPCPrw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 19-07-21, 12:40, Arnd Bergmann wrote:
> I still don't see it as an important enough part of the interface to be encoded
> in the virtio spec. In the most likely use cases I can think of, you would never
> need more than one gpio controller in a virtio machine, since you can have
> an arbitrary number of lines connected to it already.
> 
> This also simplifies the host side, as it avoids requiring the host to configure
> a name that ends up being the same almost always.
> 
> If Linus or Bartosz think we should have the name, leave it in there, otherwise
> I'd remove it.

I don't have a really good argument for keeping it, dropping it for now unless
someone thinks it is important. :)

> Encoding the number of gpio lines in the config registers makes sense to me,
> but I don't see how you can sensibly get away without some other structure
> to describe what the lines are. It doesn't have to be DT, but that's what we use
> in practice.

Yes, we normally end up defining them in DT via "gpio-line-names" binding, but I
think it would be better to get them over the protocol instead here as this
should be self sufficient. Something like DT will still be required to link
users to the GPIO device, and that's outside of the scope of the protocol, so DT
works well there.

> > That may not always work and this count of refcounting at the backend daemon may
> > not be correct.
> >
> > So, the guest calls set-direction-out-with-val-1, the backend activates the GPIO
> > pin, sets direction/value and then deactivates it ? That won't work, right ?
> >
> > On those lines, I think these operations must be renamed to ACTIVATE/DEACTIVATE
> > instead of REQUEST/FREE, that is what we want to do here.
> 
> From the drivers you pointed to,

There were more, I just didn't get to them :)

> it seems to be something like a 'disconnected'
> state where the pin is neither input nor output, so this could perhaps
> get reflected
> in the interface as well, by having each pin be one of IN/OUT/NONE. Not sure
> if that is any better.

I think keeping APIs like ACTIVATE/DEACTIVATE makes it cleaner, than adding
another state of the PIN itself.

-- 
viresh

