Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626794843.git.viresh.kumar@linaro.org> <199c624bd735782dd5d4a51e376f466f5c38ef2c.1626794843.git.viresh.kumar@linaro.org>
 <CAK8P3a0PtwUMD0RRpmaXitfpUJ+OiayMMLx-4a=LnokSs4gPnA@mail.gmail.com> <20210726101653.5mjypnnv6rib4hon@vireshk-i7>
In-Reply-To: <20210726101653.5mjypnnv6rib4hon@vireshk-i7>
From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 26 Jul 2021 13:28:27 +0200
Message-ID: <CAK8P3a3MFSkYzVY3TZ+F56KwM+ncEtin9pQFqfR1q_-MLJvmew@mail.gmail.com>
Subject: Re: [PATCH V6 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 26, 2021 at 12:16 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 26-07-21, 11:18, Arnd Bergmann wrote:
> > I would be more comfortable with leaving out this field, and making the
> > name lookup fixed-length and per line.
>
> I can leave it from configuration, sure.
>
> Doing it per-line seems to be too much overhead, since we are going to
> call this for every line anyway (at least in Linux implementation). I
> haven't tried it, but I somehow feel that probe() will take a
> significant time to finish with that, lets say for 256 GPIO lines.

My guess is that this would not cause any notable overhead, but we
will know for sure if you can measure it.

> > Making this a per-line request also has the advantage that the device
> > can have names associated with some of the lines, but leave
> > some other lines unnamed, which I think is something that happens
> > in practice.
> >
> > Not sure what a good upper limit for the length of the name is, but
> > making this fixed-length would seem simpler to me.
>
> Or allocate 20-25 bytes for each string and allocate a buffer of size
>
> 25 * ngpios
>
> The device can write 0 (null) for some of the GPIOs, where it doesn't
> want to provide a name, or set it to a null terminated string with
> length <= 25.

I was thinking of a name limit in the context of doing the operation per
line. If you keep the list of nul-terminated strings, then I think I would
also not limit the length per line.

> > > +\item The driver MUST NOT send another message, of any type, for a GPIO line
> > > +    before receiving a response from the device for the previously sent message
> > > +    for the same GPIO line.
> >
> > I have a question here, not sure if this needs to be answered in the spec: why
> > can't the driver send activate, set-direction and set-value all at
> > once for a line?
> > Clearly if one request fails, the later ones would fail as well in
> > this example, but
> > I don't see this as a problem for either side.
>
> The driver can already do set-direction and value at once.

Ah, I completely missed that.

> Merging activate along with that would mean, that the host needs to keep
> a reference count at its end to activate the line on the first call to
> set-value, but not on others.

My question here was about something else, to rephrase: Can't we allow
the driver to queue multiple requests for one line and then have the device
process them in order (regardless of whether it processes requests
for other lines in parallel). The sequence I had in mind here was

driver:
    1. queue enable
    2. queue set-direction
    3. queue set-value
    4. notify device
device:
    5. process enable
    6. queue enable-response
    7. process set-direction
    8. queue set-direction response
    9. process set-value
    10. queue set-value response
    11. notify driver
driver:
     12. mark all requests as done

> We would still need to keep the deactivate request, as the host
> wouldn't know when the guest is done using a line. And for that reason
> it looked better to have an explicit call to activate here.

Folding the activate/deactivate is also an interesting option, as discussed
before. I don't think we actually need to do reference counting, just making
the direction a tristate. I think this would work fine here:

- default direction is VIRTIO_GPIO_MSG_SET_DIRECTION_NONE"
- as long as the direction is not set, nothing else is allowed on the line
- changing the direction from "none" to "in" or "out" implies "activate"
- changing the direction from "in" or "out" back to "none" implies "deactivate"

This is similar to folding the irq type into the direction command, and I
would slightly prefer it that way, but I'd like to hear what others think
about it.

> > > +\item The device MAY process messages out of order and in parallel and MAY send
> > > +    message's response to the driver out of order.
> >
> > Here I have the opposite question: what is the benefit of allowing the requests
> > to be processed out of order? Should these not all be instantaneous, and easier
> > to handle by making the request queue serialized?
>
> Lets say the guest sends two requests, almost at the same time to
> the host and they are queued on the vq in this order only:
>
> - set direction-out-with-value-1 for line 5.
> - set direction-in for line 11.
>
> Now, if the host is able to process them in parallel, then the second
> request for line 11 may finish before the requests for line 5 (as it
> has lesser amount of work to do).
>
> I don't see why the host should wait for the first request to finish
> before queuing up the buffers for the second request, while it has
> already finished.
>
> To be most efficient, the queue should be thought of as a series of
> buffers which are present in any order, based on what finishes first.
> It doesn't increase the complexity on any side to be honest. The code
> remains straight forward with it.

I expected the host side to be atomic here. Under which circumstance
would the 'set direction out with value' call in your example block?

        Arnd

