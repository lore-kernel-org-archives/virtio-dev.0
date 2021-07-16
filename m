Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org> <4bb66b16dc261acf9d40517c8b7961a52212086b.1626418779.git.viresh.kumar@linaro.org>
 <CAK8P3a1_ZeSu0XgqF7+zA+_HhZPtQw6rrBkda0djVKwTtAqGLg@mail.gmail.com> <CAKohponZQxCp99RUJSNMW2yv2byJ5CkQYwsrh+3thHr2wV=+aA@mail.gmail.com>
In-Reply-To: <CAKohponZQxCp99RUJSNMW2yv2byJ5CkQYwsrh+3thHr2wV=+aA@mail.gmail.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 16 Jul 2021 20:20:31 +0200
Message-ID: <CAK8P3a0iZCJBLrz652Ez70m7Zj3Tjdm-Jfw_s3wUmdceY8bkNQ@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 16, 2021 at 6:26 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On Fri, 16 Jul 2021 at 13:54, Arnd Bergmann <arnd@kernel.org> wrote:
> > > +
> > > +All fields of this structure, except \field{gpio_names}, must always be set by
> > > +the device and all fields are read-only for the driver.
> > > +
> > > +\begin{description}
> > > +\item[\field{name}] is a zero-terminated string that represents the name of the
> > > +    GPIO device. The unused bytes in the string must be initialized to zero by
> > > +    the device.
> >
> > I'm a bit confused about why you have both a combined "name" field and
> > separate "gpio_names" fields. I not too familiar with the internals of the gpio
> > subsystem, but I see that in the devicetree bindings, we have only
> > optional per gpio line names, but no name for the device itself.
>
> The combined name is for distinguishing the GPIO controller at the guest, which
> is normally done in the kernel by assigning value from dev_name(dev).
>
> With virtio-mmio nodes assigned randomly by hypervisors (like Qemu), those
> names may not be very useful. And so I thought that this name can be useful.
>
> This eventually would get into gpio_chip->label field at kernel.

I still don't quite get it. Why would the guest care about a stable name?

Shouldn't all users of the gpio node be handled through phandle references
and similar?

> > > +\item[\field{gpio_names}] field is optional for a device to implement. If this
> > > +    field isn't implemented by the device, then the device must set the
> > > +    \field{names_size} field to zero. If this field is implemented by the
> > > +    device, then it must contain a stream of \field{ngpio} zero-terminated
> > > +    strings, where each string represents the name of a GPIO line, present in
> > > +    increasing order of the GPIO line numbers. The GPIO line names must
> > > +    be unique within a GPIO Device and must not be empty string.
> >
> > Also here, maybe add a sentence to explain what the gpio names are used
> > for and what they are not used for.
>
> Okay, will do. Though this field is going away now (after Michael's
> feedback) and a request will take its place.

Right. Any thoughts about just having the names be part of the
metadata in the DT? I think that sounds easier than the request,
though both methods are fairly straightforward really.

> > > +A request is initiated by the sender by adding a buffer of type \field{struct
> > > +virtio_gpio_msg} to its respective virtqueue, after setting all fields of the
> > > +message and \field{type} field with one of the message types from
> > > +\field{VIRTIO_GPIO_MSG_*}.
> > > +
> > > +In response, the receiver adds a copy of the same buffer on its respective
> > > +virtqueue, after performing a logical OR operation to the \field{type} field
> > > +with VIRTIO_GPIO_MSG_RESPONSE mask and updating the \field{value} field based on
> > > +message type.
> >
> > So you have one virtqueue for a request and another virtqueue for the reply?
>
> Yes, or I will say one for device to send message/response and one for driver.

Ah, so maybe it's more like what I was looking for then after all, rather than
what I understood you do.

To clarify: the flow as I now understand it is

- driver wants something (configuration, gpio read, gpio write, irq ack, ...):
  driver sends a message with transmit and receive buffer on the first
  queue and gets a reply back immediately

- device wants something (only an irq):
  driver sets up a message to receive a buffer for a line, device fills it
  when the event happens.

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

That should not be an issue. I think the reply would always be instantaneous
here, and the requests can just be processed in order.

> We should still be able to identify different response messages based on the
> address of the buffer (for example) and so what you are suggesting may
> actually work and won't be a bottleneck as I thought of it earlier.

Yes, I think that is rather normal operation for a virtqueue.

> If this works fine, I will move back to one virtqueue for all non-irq
> stuff, like I had until V4 and one virtqueue only for interrupt processing.

ok, great.

> > > +\subsubsection{Device Operation: Free}\label{sec:Device Types / GPIO Device / Device Operation / Free }
> > > +
> > > +The driver initiates this message to notify the device that a previously
> > > +requested line has been unassigned and can be deactivated.
> >
> > How is this intended to be used? Why is this not up to the guest
> > kernel to keep track
> > of? I would expect that if a gpio line is listed in the information
> > that the driver is free
> > to use it at any time without having to request it first.
> >
> > While we do have the notion of gpiod_get/gpiod_put in the in-kernel interface,
> > this is only used for arbitration between drivers (or driver vs user
> > space) normally,
> > but not communicated with gpio controllers as far as I know.
>
> I looked at kernel implementation of GPIO drivers and few of them
> have implemented request/free callbacks and they do read/write to
> hardware registers to do some controller specific stuff.
>
> Moreover, the host may want to arbitrate GPIO pins between guests
> for example and would need something like this to make it work.
>
> And so I thought the specification should always allow it.

Do you have an example for what the hardware driver would do here?
Maybe LinusW can clarify whether he thinks it is needed.

Even if the hardware requires the request/free style calls in case of
passing through a line to a guest, I would expect that can be handled
in host user space, i.e. the virtio device code calls 'request' before it
passes down a gpio line to a guest.

       Arnd

