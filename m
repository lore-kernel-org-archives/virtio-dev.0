Return-Path: <viresh.kumar@linaro.org>
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org> <4bb66b16dc261acf9d40517c8b7961a52212086b.1626418779.git.viresh.kumar@linaro.org>
 <CAK8P3a1_ZeSu0XgqF7+zA+_HhZPtQw6rrBkda0djVKwTtAqGLg@mail.gmail.com>
In-Reply-To: <CAK8P3a1_ZeSu0XgqF7+zA+_HhZPtQw6rrBkda0djVKwTtAqGLg@mail.gmail.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 16 Jul 2021 21:56:58 +0530
Message-ID: <CAKohponZQxCp99RUJSNMW2yv2byJ5CkQYwsrh+3thHr2wV=+aA@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain; charset="UTF-8"
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 16 Jul 2021 at 13:54, Arnd Bergmann <arnd@kernel.org> wrote:
> > +\section{General Purpose IO Device}\label{sec:Device Types / GPIO Device}
>
> Nitpicking: If you expand GPIO, I would write it as "General Purpose
> Input/Output"
> or maybe "General Purpose I/O", but not just "General Purpose IO".

Right.

> > +\subsection{Device configuration layout}\label{sec:Device Types / GPIO Device / Device configuration layout}
> > +
> > +GPIO device uses the following structure layout for configuration:
> > +
> > +\begin{lstlisting}
> > +struct virtio_gpio_config {
> > +    u8 name[32];
> > +    le16 ngpio;
> > +    le16 names_offset;
> > +    le32 names_size;
> > +
> > +    /* at offset defined by names_offset field */
> > +    u8 gpio_names[];
> > +};
> > +\end{lstlisting}
> > +
> > +All fields of this structure, except \field{gpio_names}, must always be set by
> > +the device and all fields are read-only for the driver.
> > +
> > +\begin{description}
> > +\item[\field{name}] is a zero-terminated string that represents the name of the
> > +    GPIO device. The unused bytes in the string must be initialized to zero by
> > +    the device.
>
> I'm a bit confused about why you have both a combined "name" field and
> separate "gpio_names" fields. I not too familiar with the internals of the gpio
> subsystem, but I see that in the devicetree bindings, we have only
> optional per gpio line names, but no name for the device itself.

The combined name is for distinguishing the GPIO controller at the guest, which
is normally done in the kernel by assigning value from dev_name(dev).

With virtio-mmio nodes assigned randomly by hypervisors (like Qemu), those
names may not be very useful. And so I thought that this name can be useful.

This eventually would get into gpio_chip->label field at kernel.

> Even if we decide that this is needed after all, it would be helpful to explain
> some background here about what this name is used for, as others may
> have the same question.

Okay, I will add some details on it.

> > +\item[\field{gpio_names}] field is optional for a device to implement. If this
> > +    field isn't implemented by the device, then the device must set the
> > +    \field{names_size} field to zero. If this field is implemented by the
> > +    device, then it must contain a stream of \field{ngpio} zero-terminated
> > +    strings, where each string represents the name of a GPIO line, present in
> > +    increasing order of the GPIO line numbers. The GPIO line names must
> > +    be unique within a GPIO Device and must not be empty string.
>
> Also here, maybe add a sentence to explain what the gpio names are used
> for and what they are not used for.

Okay, will do. Though this field is going away now (after Michael's
feedback) and
a request will take its place.

> > +A request is initiated by the sender by adding a buffer of type \field{struct
> > +virtio_gpio_msg} to its respective virtqueue, after setting all fields of the
> > +message and \field{type} field with one of the message types from
> > +\field{VIRTIO_GPIO_MSG_*}.
> > +
> > +In response, the receiver adds a copy of the same buffer on its respective
> > +virtqueue, after performing a logical OR operation to the \field{type} field
> > +with VIRTIO_GPIO_MSG_RESPONSE mask and updating the \field{value} field based on
> > +message type.
>
> So you have one virtqueue for a request and another virtqueue for the reply?

Yes, or I will say one for device to send message/response and one for driver.

> As they are always treated as a transaction, wouldn't it be easier to have
> a single virtqueue and make each transaction have both an input and an
> output buffer?
parallel

That's what I did initially (and that's we did in I2C as well), but
then I realised
that it may not work well with transactions done in parallel.

For example, we want to allow setting direction to input for pins 5 and 8 in
parallel. I at that time thought that with using a single virtqueue for both
request/response messages may block the virtqueue for further usage. But
now that I think about it a bit more, it may not.

We should still be able to identify different response messages based on the
address of the buffer (for example) and so what you are suggesting may
actually work and won't be a bottleneck as I thought of it earlier.

If this works fine, I will move back to one virtqueue for all non-irq
stuff, like I
had until V4 and one virtqueue only for interrupt processing.

> > +#define VIRTIO_GPIO_MSG_GET_DIRECTION           0x0003
> > +#define VIRTIO_GPIO_MSG_SET_DIRECTION_IN        0x0004
> > +#define VIRTIO_GPIO_MSG_SET_DIRECTION_OUT       0x0005
> > +#define VIRTIO_GPIO_MSG_GET_VALUE               0x0006
> > +#define VIRTIO_GPIO_MSG_SET_VALUE               0x0007
> > +
> > +/* GPIO response mask, to be Or'ed with one of the above */
> > +#define VIRTIO_GPIO_MSG_RESPONSE                    0x8000
> > +\end{lstlisting}
> > +
> > +The response messages may contain error codes (in the \field{value} field) on
> > +failures, they must be read as negative POSIX errno codes, unless stated
> > +otherwise, i.e. 0 as success, and negative value as POSIX error code, positive
> > +values as invalid, unless stated otherwise.
>
> I don't understand how POSIX errno codes are meant to be used here, as I'm
> not aware of any generic definition of binary values. If you mean the Linux
> errno values, those cannot be used here as they are certainly architecture
> specific. You have to enumerate the possible response codes that the
> device is allowed to return, and what the meaning behind those is.

That's what I thought earlier and had my own error types, but then
Enrico suggested
using these and I thought, why not ?

Now that I looked at
https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html

POSIX only defines meaning of various error names and don't attach a numerical
value to them. So, we can't use them as is.

> > +\subsubsection{Device Operation: Free}\label{sec:Device Types / GPIO Device / Device Operation / Free }
> > +
> > +The driver initiates this message to notify the device that a previously
> > +requested line has been unassigned and can be deactivated.
>
> How is this intended to be used? Why is this not up to the guest
> kernel to keep track
> of? I would expect that if a gpio line is listed in the information
> that the driver is free
> to use it at any time without having to request it first.
>
> While we do have the notion of gpiod_get/gpiod_put in the in-kernel interface,
> this is only used for arbitration between drivers (or driver vs user
> space) normally,
> but not communicated with gpio controllers as far as I know.

I looked at kernel implementation of GPIO drivers and few of them
have implemented request/free callbacks and they do read/write to
hardware registers to do some controller specific stuff.

Moreover, the host may want to arbitrate GPIO pins between guests
for example and would need something like this to make it work.

And so I thought the specification should always allow it.

--
Viresh

