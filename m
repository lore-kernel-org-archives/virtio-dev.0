Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626794843.git.viresh.kumar@linaro.org> <199c624bd735782dd5d4a51e376f466f5c38ef2c.1626794843.git.viresh.kumar@linaro.org>
 <CAK8P3a0PtwUMD0RRpmaXitfpUJ+OiayMMLx-4a=LnokSs4gPnA@mail.gmail.com>
 <20210726101653.5mjypnnv6rib4hon@vireshk-i7> <CAK8P3a3MFSkYzVY3TZ+F56KwM+ncEtin9pQFqfR1q_-MLJvmew@mail.gmail.com>
 <20210727075545.cq6lb7vsg4pdygtm@vireshk-i7>
In-Reply-To: <20210727075545.cq6lb7vsg4pdygtm@vireshk-i7>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 27 Jul 2021 10:16:18 +0200
Message-ID: <CAK8P3a0ZnsOii_0HxDtbd4LcjjK29vxfCH1Kuw-wk12jPbDAXA@mail.gmail.com>
Subject: Re: [PATCH V6 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 27, 2021 at 9:55 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 26-07-21, 13:28, Arnd Bergmann wrote:
> > On Mon, Jul 26, 2021 at 12:16 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > Doing it per-line seems to be too much overhead, since we are going to
> > > call this for every line anyway (at least in Linux implementation). I
> > > haven't tried it, but I somehow feel that probe() will take a
> > > significant time to finish with that, lets say for 256 GPIO lines.
> >
> > My guess is that this would not cause any notable overhead, but we
> > will know for sure if you can measure it.
>
> I will surely try it to get the number out, but sending a request 256
> times instead of just once looks inefficient from the face of it :)

It could still be only one notification though, just a lot of requests
with a pair of buffers each, that you send all at once.

> > If you keep the list of nul-terminated strings, then I think I would
> > also not limit the length per line.
>
> The problem at hand is knowing the (maximum) size of the buffer to
> pre-allocate at the driver. And here are the options:
>
> - Keep gpio_names_size in the config structure (like this commit,
>   which is kind of fine since we won't need this multiple times).
>
> - Add a new message type for that, i.e. getting size of the
>   gpio_names_block, but I don't like it since this will be used only
>   once.
>
> - Fix size for each GPIO pin's name to X characters and the driver
>   allocates a buffer of size X * ngpio. This provides good boundaries
>   between line names, more straightforward, less confusing, but more
>   data (unnecessarily) to be sent.
>
> Which one do you like ?

If we stay with a single message to get all the names, I'd probably
also stay with having the buffer length in config space as you do in
the current version.

> > > > I have a question here, not sure if this needs to be answered in the spec: why
> > > > can't the driver send activate, set-direction and set-value all at
> > > > once for a line?
> > > > Clearly if one request fails, the later ones would fail as well in
> > > > this example, but
> > > > I don't see this as a problem for either side.
> >
> > > Merging activate along with that would mean, that the host needs to keep
> > > a reference count at its end to activate the line on the first call to
> > > set-value, but not on others.
> >
> > My question here was about something else, to rephrase: Can't we allow
> > the driver to queue multiple requests for one line and then have the device
> > process them in order (regardless of whether it processes requests
> > for other lines in parallel). The sequence I had in mind here was
> >
> > driver:
> >     1. queue enable
> >     2. queue set-direction
> >     3. queue set-value
> >     4. notify device
> > device:
> >     5. process enable
> >     6. queue enable-response
> >     7. process set-direction
> >     8. queue set-direction response
> >     9. process set-value
> >     10. queue set-value response
> >     11. notify driver
> > driver:
> >      12. mark all requests as done
>
> Hmm, we can do that in principle by saying all requests for a
> particular line must be served in order. But right now I have rather
> limited the number of requests per line to 1 for a reason, i.e. there
> will always be a single user of a GPIO line at any point of time. And
> so the operations will always be sequential.
>
> If you look at users of GPIO, lets say in kernel for now, they all use
> generic APIs like request, set-direction, set-value, etc. There is no
> fixed order of how the different callbacks will be called by the user,
> and so we will never get the requests in bulk or groups (like you
> mentioned above). Each operation has its own significance, and it
> won't be right to return from, lets say gpio_set_value(), without
> getting the result of the operation.
>
> So when can something like this, what you showed above, can be useful
> ?

Maybe this is something we can get advice for from the virtio
maintainers. It was just a feeling on my side that slightly relaxing
the requirement makes this more like other virtio drivers.

Functionally, I think there is no difference between mandating that the
driver only queues one request per gpio line over requiring that the
device processes all requests on a gpio line in sequence, but the
latter can be slightly more efficient.

> > This is similar to folding the irq type into the direction command, and I
> > would slightly prefer it that way, but I'd like to hear what others think
> > about it.
>
> I would really like to keep the irq stuff separate from rest of the
> basic APIs. This would also be less confusing because the irq stuff is
> handled separately using a feature flag here.
>
> Over that the users won't club these either, like in Linux the user
> will do gpio-request, then direction-input, and then request irq.
>
> So these are all required to be sent at different times.

ok

> > > To be most efficient, the queue should be thought of as a series of
> > > buffers which are present in any order, based on what finishes first.
> > > It doesn't increase the complexity on any side to be honest. The code
> > > remains straight forward with it.
> >
> > I expected the host side to be atomic here. Under which circumstance
> > would the 'set direction out with value' call in your example block?
>
> Yes it will block, but another thread can initiate another request for
> a different GPIO line.

Ok, I was hoping that the gpiolib interfaces would all end up being
non-blocking, but I agree that if the guest has to wait for a notification
it can be useful to have more than one going on at once. Especially
if the host implementation is in a separate process there is not even
a theoretical upper bound on how long it takes to process a request.

       Arnd

