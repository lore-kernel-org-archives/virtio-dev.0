Return-Path: <viresh.kumar@linaro.org>
Date: Tue, 27 Jul 2021 13:25:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V6 1/2] virtio-gpio: Add the device specification
Message-ID: <20210727075545.cq6lb7vsg4pdygtm@vireshk-i7>
References: <cover.1626794843.git.viresh.kumar@linaro.org>
 <199c624bd735782dd5d4a51e376f466f5c38ef2c.1626794843.git.viresh.kumar@linaro.org>
 <CAK8P3a0PtwUMD0RRpmaXitfpUJ+OiayMMLx-4a=LnokSs4gPnA@mail.gmail.com>
 <20210726101653.5mjypnnv6rib4hon@vireshk-i7>
 <CAK8P3a3MFSkYzVY3TZ+F56KwM+ncEtin9pQFqfR1q_-MLJvmew@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3MFSkYzVY3TZ+F56KwM+ncEtin9pQFqfR1q_-MLJvmew@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 26-07-21, 13:28, Arnd Bergmann wrote:
> On Mon, Jul 26, 2021 at 12:16 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Doing it per-line seems to be too much overhead, since we are going to
> > call this for every line anyway (at least in Linux implementation). I
> > haven't tried it, but I somehow feel that probe() will take a
> > significant time to finish with that, lets say for 256 GPIO lines.
> 
> My guess is that this would not cause any notable overhead, but we
> will know for sure if you can measure it.

I will surely try it to get the number out, but sending a request 256
times instead of just once looks inefficient from the face of it :)

> > Or allocate 20-25 bytes for each string and allocate a buffer of size
> >
> > 25 * ngpios
> >
> > The device can write 0 (null) for some of the GPIOs, where it doesn't
> > want to provide a name, or set it to a null terminated string with
> > length <= 25.
> 
> I was thinking of a name limit in the context of doing the operation per
> line.

I really don't want to do it, since in kernel at least we would run
that function for all lines right at probe().

> If you keep the list of nul-terminated strings, then I think I would
> also not limit the length per line.

The problem at hand is knowing the (maximum) size of the buffer to
pre-allocate at the driver. And here are the options:

- Keep gpio_names_size in the config structure (like this commit,
  which is kind of fine since we won't need this multiple times).

- Add a new message type for that, i.e. getting size of the
  gpio_names_block, but I don't like it since this will be used only
  once.

- Fix size for each GPIO pin's name to X characters and the driver
  allocates a buffer of size X * ngpio. This provides good boundaries
  between line names, more straightforward, less confusing, but more
  data (unnecessarily) to be sent.

Which one do you like ?

> > > I have a question here, not sure if this needs to be answered in the spec: why
> > > can't the driver send activate, set-direction and set-value all at
> > > once for a line?
> > > Clearly if one request fails, the later ones would fail as well in
> > > this example, but
> > > I don't see this as a problem for either side.
> 
> > Merging activate along with that would mean, that the host needs to keep
> > a reference count at its end to activate the line on the first call to
> > set-value, but not on others.
> 
> My question here was about something else, to rephrase: Can't we allow
> the driver to queue multiple requests for one line and then have the device
> process them in order (regardless of whether it processes requests
> for other lines in parallel). The sequence I had in mind here was
> 
> driver:
>     1. queue enable
>     2. queue set-direction
>     3. queue set-value
>     4. notify device
> device:
>     5. process enable
>     6. queue enable-response
>     7. process set-direction
>     8. queue set-direction response
>     9. process set-value
>     10. queue set-value response
>     11. notify driver
> driver:
>      12. mark all requests as done

Hmm, we can do that in principle by saying all requests for a
particular line must be served in order. But right now I have rather
limited the number of requests per line to 1 for a reason, i.e. there
will always be a single user of a GPIO line at any point of time. And
so the operations will always be sequential.

If you look at users of GPIO, lets say in kernel for now, they all use
generic APIs like request, set-direction, set-value, etc. There is no
fixed order of how the different callbacks will be called by the user,
and so we will never get the requests in bulk or groups (like you
mentioned above). Each operation has its own significance, and it
won't be right to return from, lets say gpio_set_value(), without
getting the result of the operation.

So when can something like this, what you showed above, can be useful
?

> > We would still need to keep the deactivate request, as the host
> > wouldn't know when the guest is done using a line. And for that reason
> > it looked better to have an explicit call to activate here.
> 
> Folding the activate/deactivate is also an interesting option, as discussed
> before. I don't think we actually need to do reference counting, just making
> the direction a tristate. I think this would work fine here:
> 
> - default direction is VIRTIO_GPIO_MSG_SET_DIRECTION_NONE"
> - as long as the direction is not set, nothing else is allowed on the line
> - changing the direction from "none" to "in" or "out" implies "activate"
> - changing the direction from "in" or "out" back to "none" implies "deactivate"

I am not able to see anything which can break with this, so this looks
okay. We can get away with activate/deactivate and use direction-none
for that.

> This is similar to folding the irq type into the direction command, and I
> would slightly prefer it that way, but I'd like to hear what others think
> about it.

I would really like to keep the irq stuff separate from rest of the
basic APIs. This would also be less confusing because the irq stuff is
handled separately using a feature flag here.

Over that the users won't club these either, like in Linux the user
will do gpio-request, then direction-input, and then request irq.

So these are all required to be sent at different times.

> > > Here I have the opposite question: what is the benefit of allowing the requests
> > > to be processed out of order? Should these not all be instantaneous, and easier
> > > to handle by making the request queue serialized?
> >
> > Lets say the guest sends two requests, almost at the same time to
> > the host and they are queued on the vq in this order only:
> >
> > - set direction-out-with-value-1 for line 5.
> > - set direction-in for line 11.
> >
> > Now, if the host is able to process them in parallel, then the second
> > request for line 11 may finish before the requests for line 5 (as it
> > has lesser amount of work to do).
> >
> > I don't see why the host should wait for the first request to finish
> > before queuing up the buffers for the second request, while it has
> > already finished.
> >
> > To be most efficient, the queue should be thought of as a series of
> > buffers which are present in any order, based on what finishes first.
> > It doesn't increase the complexity on any side to be honest. The code
> > remains straight forward with it.
> 
> I expected the host side to be atomic here. Under which circumstance
> would the 'set direction out with value' call in your example block?

Yes it will block, but another thread can initiate another request for
a different GPIO line.

-- 
viresh

