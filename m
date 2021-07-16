Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org> <4bb66b16dc261acf9d40517c8b7961a52212086b.1626418779.git.viresh.kumar@linaro.org>
In-Reply-To: <4bb66b16dc261acf9d40517c8b7961a52212086b.1626418779.git.viresh.kumar@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Jul 2021 11:13:15 +0200
Message-ID: <CAMuHMdW+xXBbqc5nYjQyUwuW2VDAawiAGA1U+iJ3_jd6pjOkTQ@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Viresh,

On Fri, Jul 16, 2021 at 9:40 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
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

Thanks for your patch!

Disclaimer: IANAVP (not a virtio person here ;-)

> --- /dev/null
> +++ b/virtio-gpio.tex
> @@ -0,0 +1,317 @@
> +\section{General Purpose IO Device}\label{sec:Device Types / GPIO Device}
> +
> +The Virtio GPIO device is a virtual general purpose IO device that supports a
> +variable number of named IO lines, which can be configured in input mode or in
> +output mode with logical level low (0) or high (1).
> +
> +\subsection{Device ID}\label{sec:Device Types / GPIO Device / Device ID}
> +41
> +
> +\subsection{Virtqueues}\label{sec:Device Types / GPIO Device / Virtqueues}
> +
> +\begin{description}
> +\item[0] txq (driver to device)
> +\item[1] rxq (device to driver)
> +\end{description}
> +
> +The \field{txq} virtqueue is used by the driver to send messages to the device
> +and the \field{rxq} virtqueue is used by the device to send messages to the
> +driver.
> +
> +\subsection{Feature bits}\label{sec:Device Types / GPIO Device / Feature bits}
> +
> +None currently defined.
> +
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

Is this the standard (virtio) way to define fields like this?
Personally, I would write "__gpio_names[]", to make it more obvious
if some code tries to access the field directly.
Of course the real implementation should provide a macro/function to
access the names in a safe way.

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
> +
> +\item[\field{ngpio}] is the total number of GPIO lines supported by the device.
> +
> +\item[\field{names_offset}] is the offset of the \field{gpio_names} field from
> +    the base address of the \field{struct virtio_gpio_config}. The device must
> +    set its value to 40 for current version of the specification. In future this
> +    value may change if the \field {struct virtio_gpio_config} is expanded by
> +    adding more fields to it.
> +
> +\item[\field{names_size}] is the size of the \field{gpio_names} memory block.
> +    The device must set it to the size, in bytes, of the \field{gpio_names}
> +    field. The device must set this to zero, if the \field{gpio_names} field
> +    isn't implemented by the device.
> +
> +\item[\field{gpio_names}] field is optional for a device to implement. If this
> +    field isn't implemented by the device, then the device must set the
> +    \field{names_size} field to zero. If this field is implemented by the
> +    device, then it must contain a stream of \field{ngpio} zero-terminated
> +    strings, where each string represents the name of a GPIO line, present in
> +    increasing order of the GPIO line numbers. The GPIO line names must
> +    be unique within a GPIO Device and must not be empty string.
> +
> +\end{description}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

