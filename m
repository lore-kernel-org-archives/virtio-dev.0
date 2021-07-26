Return-Path: <viresh.kumar@linaro.org>
Date: Mon, 26 Jul 2021 15:46:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V6 1/2] virtio-gpio: Add the device specification
Message-ID: <20210726101653.5mjypnnv6rib4hon@vireshk-i7>
References: <cover.1626794843.git.viresh.kumar@linaro.org>
 <199c624bd735782dd5d4a51e376f466f5c38ef2c.1626794843.git.viresh.kumar@linaro.org>
 <CAK8P3a0PtwUMD0RRpmaXitfpUJ+OiayMMLx-4a=LnokSs4gPnA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0PtwUMD0RRpmaXitfpUJ+OiayMMLx-4a=LnokSs4gPnA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 26-07-21, 11:18, Arnd Bergmann wrote:
> I would be more comfortable with leaving out this field, and making the
> name lookup fixed-length and per line.

I can leave it from configuration, sure.

Doing it per-line seems to be too much overhead, since we are going to
call this for every line anyway (at least in Linux implementation). I
haven't tried it, but I somehow feel that probe() will take a
significant time to finish with that, lets say for 256 GPIO lines.

> Making this a per-line request also has the advantage that the device
> can have names associated with some of the lines, but leave
> some other lines unnamed, which I think is something that happens
> in practice.
> 
> Not sure what a good upper limit for the length of the name is, but
> making this fixed-length would seem simpler to me.

Or allocate 20-25 bytes for each string and allocate a buffer of size

25 * ngpios

The device can write 0 (null) for some of the GPIOs, where it doesn't
want to provide a name, or set it to a null terminated string with
length <= 25.

> > +\subsubsection{requestq Operation: Activate}\label{sec:Device Types / GPIO Device / requestq Operation / Activate}
> > +
> > +The driver sends this message to notify the device that one of its lines has
> > +been assigned for use.
> 
> Maybe expand this description a little more according to our previous
> discussion.
> In particular, I would expect this to describe
> 
> - what the controller hardware is expected to do as a result
> - which of the other calls are allowed on lines that have been requested
>   or have not been requested. This information could be duplicated in the
>   respective descriptions. In particular, it is not obvious whether you should
>   set the direction before or after 'request', and I assume only one of the
>   two possibilities is allowed.

Right.

> > +\item The driver MUST NOT send another message, of any type, for a GPIO line
> > +    before receiving a response from the device for the previously sent message
> > +    for the same GPIO line.
> 
> I have a question here, not sure if this needs to be answered in the spec: why
> can't the driver send activate, set-direction and set-value all at
> once for a line?
> Clearly if one request fails, the later ones would fail as well in
> this example, but
> I don't see this as a problem for either side.

The driver can already do set-direction and value at once. Merging
activate along with that would mean, that the host needs to keep a
reference count at its end to activate the line on the first call to
set-value, but not on others.

We would still need to keep the deactivate request, as the host
wouldn't know when the guest is done using a line. And for that reason
it looked better to have an explicit call to activate here.

> > +\item The device MAY process messages out of order and in parallel and MAY send
> > +    message's response to the driver out of order.
> 
> Here I have the opposite question: what is the benefit of allowing the requests
> to be processed out of order? Should these not all be instantaneous, and easier
> to handle by making the request queue serialized?

Lets say the guest sends two requests, almost at the same time to
the host and they are queued on the vq in this order only:

- set direction-out-with-value-1 for line 5.
- set direction-in for line 11.

Now, if the host is able to process them in parallel, then the second
request for line 11 may finish before the requests for line 5 (as it
has lesser amount of work to do).

I don't see why the host should wait for the first request to finish
before queuing up the buffers for the second request, while it has
already finished.

To be most efficient, the queue should be thought of as a series of
buffers which are present in any order, based on what finishes first.
It doesn't increase the complexity on any side to be honest. The code
remains straight forward with it.

-- 
viresh

