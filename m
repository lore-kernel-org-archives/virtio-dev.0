Return-Path: <viresh.kumar@linaro.org>
Date: Tue, 27 Jul 2021 16:26:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V6 1/2] virtio-gpio: Add the device specification
Message-ID: <20210727105631.njv2wh2jvclbld56@vireshk-i7>
References: <cover.1626794843.git.viresh.kumar@linaro.org>
 <199c624bd735782dd5d4a51e376f466f5c38ef2c.1626794843.git.viresh.kumar@linaro.org>
 <CAK8P3a0PtwUMD0RRpmaXitfpUJ+OiayMMLx-4a=LnokSs4gPnA@mail.gmail.com>
 <20210726101653.5mjypnnv6rib4hon@vireshk-i7>
 <CAK8P3a3MFSkYzVY3TZ+F56KwM+ncEtin9pQFqfR1q_-MLJvmew@mail.gmail.com>
 <20210727075545.cq6lb7vsg4pdygtm@vireshk-i7>
 <CAK8P3a0ZnsOii_0HxDtbd4LcjjK29vxfCH1Kuw-wk12jPbDAXA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0ZnsOii_0HxDtbd4LcjjK29vxfCH1Kuw-wk12jPbDAXA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 27-07-21, 10:16, Arnd Bergmann wrote:
> On Tue, Jul 27, 2021 at 9:55 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 26-07-21, 13:28, Arnd Bergmann wrote:
> > > On Mon, Jul 26, 2021 at 12:16 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > Doing it per-line seems to be too much overhead, since we are going to
> > > > call this for every line anyway (at least in Linux implementation). I
> > > > haven't tried it, but I somehow feel that probe() will take a
> > > > significant time to finish with that, lets say for 256 GPIO lines.
> > >
> > > My guess is that this would not cause any notable overhead, but we
> > > will know for sure if you can measure it.
> >
> > I will surely try it to get the number out, but sending a request 256
> > times instead of just once looks inefficient from the face of it :)
 
I created a small setup with qemu-arm64 over x86:
- Without any memcpy() of data or buffers in the GPIO drivers on both
  ends.
- i.e. essentially taking into consideration only the time to send
  receive requests, the virtio core may be copying packets in between
  though, not sure.

> It could still be only one notification though, just a lot of requests
> with a pair of buffers each, that you send all at once.

If we send only one notification at the end, it takes ~ 1ms for 256
GPIO pins, pretty much like a single request only. The downside here
is that the device (host) also needs to prepare the queue for equal
number (to ngpio) of elements. This is something the spec hasn't
touched until now, i.e. how many buffers must be queued for the
virtqueues. The max allowed in qemu is 1024 right now.

Even if I send them sequentially, with separate notification for each
request, it takes ~15-20 ms to finish 256 lines and ~80 for 1024
lines.

Though a single request still sounds tempting to me :)

> > > My question here was about something else, to rephrase: Can't we allow
> > > the driver to queue multiple requests for one line and then have the device
> > > process them in order (regardless of whether it processes requests
> > > for other lines in parallel). The sequence I had in mind here was
> > >
> > > driver:
> > >     1. queue enable
> > >     2. queue set-direction
> > >     3. queue set-value
> > >     4. notify device
> > > device:
> > >     5. process enable
> > >     6. queue enable-response
> > >     7. process set-direction
> > >     8. queue set-direction response
> > >     9. process set-value
> > >     10. queue set-value response
> > >     11. notify driver
> > > driver:
> > >      12. mark all requests as done
> >
> > Hmm, we can do that in principle by saying all requests for a
> > particular line must be served in order. But right now I have rather
> > limited the number of requests per line to 1 for a reason, i.e. there
> > will always be a single user of a GPIO line at any point of time. And
> > so the operations will always be sequential.
> >
> > If you look at users of GPIO, lets say in kernel for now, they all use
> > generic APIs like request, set-direction, set-value, etc. There is no
> > fixed order of how the different callbacks will be called by the user,
> > and so we will never get the requests in bulk or groups (like you
> > mentioned above). Each operation has its own significance, and it
> > won't be right to return from, lets say gpio_set_value(), without
> > getting the result of the operation.
> >
> > So when can something like this, what you showed above, can be useful
> > ?
> 
> Maybe this is something we can get advice for from the virtio
> maintainers. It was just a feeling on my side that slightly relaxing
> the requirement makes this more like other virtio drivers.
> 
> Functionally, I think there is no difference between mandating that the
> driver only queues one request per gpio line over requiring that the
> device processes all requests on a gpio line in sequence, but the
> latter can be slightly more efficient.

Yes, it can be efficient but I don't see when this can be used in
practice. Specially in kernel, the way GPIO users handle stuff.

But anyway, I don't have any issue specifically with allowing multiple
requests per GPIO line in the spec itself. Spec can be kept open for
such an option.

> > > > To be most efficient, the queue should be thought of as a series of
> > > > buffers which are present in any order, based on what finishes first.
> > > > It doesn't increase the complexity on any side to be honest. The code
> > > > remains straight forward with it.
> > >
> > > I expected the host side to be atomic here. Under which circumstance
> > > would the 'set direction out with value' call in your example block?
> >
> > Yes it will block, but another thread can initiate another request for
> > a different GPIO line.
> 
> Ok, I was hoping that the gpiolib interfaces would all end up being
> non-blocking,

I am not sure how we can do that :(

> but I agree that if the guest has to wait for a notification
> it can be useful to have more than one going on at once. Especially
> if the host implementation is in a separate process there is not even
> a theoretical upper bound on how long it takes to process a request.

Right.

-- 
viresh

