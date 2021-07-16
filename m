Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org> <4bb66b16dc261acf9d40517c8b7961a52212086b.1626418779.git.viresh.kumar@linaro.org>
In-Reply-To: <4bb66b16dc261acf9d40517c8b7961a52212086b.1626418779.git.viresh.kumar@linaro.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 16 Jul 2021 10:23:43 +0200
Message-ID: <CAK8P3a1_ZeSu0XgqF7+zA+_HhZPtQw6rrBkda0djVKwTtAqGLg@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> virtio-gpio is a virtual GPIO controller. It provides a way to flexibly
> communicate with the host GPIO controllers from the guest.
>
> This patch adds the specification for it.
>
> Based on the initial work posted by:
> "Enrico Weigelt, metux IT consult" <lkml@metux.net>.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/110
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I'm not too familiar with either virtio specification or gpio, but
there are a few things
that stuck out to me anyway, so I'll comment here anyway on the things that
surprised me the most.

> +\section{General Purpose IO Device}\label{sec:Device Types / GPIO Device}

Nitpicking: If you expand GPIO, I would write it as "General Purpose
Input/Output"
or maybe "General Purpose I/O", but not just "General Purpose IO".

> +\subsection{Device configuration layout}\label{sec:Device Types / GPIO Device / Device configuration layout}
> +
> +GPIO device uses the following structure layout for configuration:
> +
> +\begin{lstlisting}
> +struct virtio_gpio_config {
> +    u8 name[32];
> +    le16 ngpio;
> +    le16 names_offset;
> +    le32 names_size;
> +
> +    /* at offset defined by names_offset field */
> +    u8 gpio_names[];
> +};
> +\end{lstlisting}
> +
> +All fields of this structure, except \field{gpio_names}, must always be set by
> +the device and all fields are read-only for the driver.
> +
> +\begin{description}
> +\item[\field{name}] is a zero-terminated string that represents the name of the
> +    GPIO device. The unused bytes in the string must be initialized to zero by
> +    the device.

I'm a bit confused about why you have both a combined "name" field and
separate "gpio_names" fields. I not too familiar with the internals of the gpio
subsystem, but I see that in the devicetree bindings, we have only
optional per gpio line names, but no name for the device itself.

Even if we decide that this is needed after all, it would be helpful to explain
some background here about what this name is used for, as others may
have the same question.

> +\item[\field{gpio_names}] field is optional for a device to implement. If this
> +    field isn't implemented by the device, then the device must set the
> +    \field{names_size} field to zero. If this field is implemented by the
> +    device, then it must contain a stream of \field{ngpio} zero-terminated
> +    strings, where each string represents the name of a GPIO line, present in
> +    increasing order of the GPIO line numbers. The GPIO line names must
> +    be unique within a GPIO Device and must not be empty string.

Also here, maybe add a sentence to explain what the gpio names are used
for and what they are not used for.

> +A request is initiated by the sender by adding a buffer of type \field{struct
> +virtio_gpio_msg} to its respective virtqueue, after setting all fields of the
> +message and \field{type} field with one of the message types from
> +\field{VIRTIO_GPIO_MSG_*}.
> +
> +In response, the receiver adds a copy of the same buffer on its respective
> +virtqueue, after performing a logical OR operation to the \field{type} field
> +with VIRTIO_GPIO_MSG_RESPONSE mask and updating the \field{value} field based on
> +message type.

So you have one virtqueue for a request and another virtqueue for the reply?
As they are always treated as a transaction, wouldn't it be easier to have
a single virtqueue and make each transaction have both an input and an
output buffer?

> +#define VIRTIO_GPIO_MSG_GET_DIRECTION           0x0003
> +#define VIRTIO_GPIO_MSG_SET_DIRECTION_IN        0x0004
> +#define VIRTIO_GPIO_MSG_SET_DIRECTION_OUT       0x0005
> +#define VIRTIO_GPIO_MSG_GET_VALUE               0x0006
> +#define VIRTIO_GPIO_MSG_SET_VALUE               0x0007
> +
> +/* GPIO response mask, to be Or'ed with one of the above */
> +#define VIRTIO_GPIO_MSG_RESPONSE                    0x8000
> +\end{lstlisting}
> +
> +The response messages may contain error codes (in the \field{value} field) on
> +failures, they must be read as negative POSIX errno codes, unless stated
> +otherwise, i.e. 0 as success, and negative value as POSIX error code, positive
> +values as invalid, unless stated otherwise.

I don't understand how POSIX errno codes are meant to be used here, as I'm
not aware of any generic definition of binary values. If you mean the Linux
errno values, those cannot be used here as they are certainly architecture
specific. You have to enumerate the possible response codes that the
device is allowed to return, and what the meaning behind those is.

> +\subsubsection{Device Operation: Request}\label{sec:Device Types / GPIO Device / Device Operation / Request }
> +
> +The driver initiates this message to notify the device that one of its lines has
> +been assigned for use.
> +
> +\begin{tabular}{ |l||l|l|l| }
> +\hline
> +Fields & \field{type} & \field{gpio} & \field{value} \\
> +\hline
> +Message & \field{VIRTIO_GPIO_MSG_REQUEST} & line number & 0 \\
> +\hline
> +Response & \field{VIRTIO_GPIO_MSG_REQUEST} \newline | \field{VIRTIO_GPIO_MSG_RESPONSE} & line number & 0 = success, \newline or -errno = failure \\
> +\hline
> +\end{tabular}
> +
> +\subsubsection{Device Operation: Free}\label{sec:Device Types / GPIO Device / Device Operation / Free }
> +
> +The driver initiates this message to notify the device that a previously
> +requested line has been unassigned and can be deactivated.

How is this intended to be used? Why is this not up to the guest
kernel to keep track
of? I would expect that if a gpio line is listed in the information
that the driver is free
to use it at any time without having to request it first.

While we do have the notion of gpiod_get/gpiod_put in the in-kernel interface,
this is only used for arbitration between drivers (or driver vs user
space) normally,
but not communicated with gpio controllers as far as I know.

> +\subsection{Message flow}\label{sec:Device Types / GPIO Device / Message Flow}
> +
> +This section describe how the messages flow between device and driver.

                     describes

     Arnd

