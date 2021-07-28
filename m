Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1627469463.git.viresh.kumar@linaro.org> <056d54eae73a353b33b5319acd1b948c8f7aad93.1627469463.git.viresh.kumar@linaro.org>
In-Reply-To: <056d54eae73a353b33b5319acd1b948c8f7aad93.1627469463.git.viresh.kumar@linaro.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 28 Jul 2021 13:26:40 +0200
Message-ID: <CAK8P3a01zz0fgZ0mZsC=xqEEdgRjy511nfBC2D5=ziWqgEd8Mg@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 28, 2021 at 1:11 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> virtio-gpio is a virtual GPIO controller. It provides a way to flexibly
> communicate with the host GPIO controllers from the guest.
>
> Note that the current implementation doesn't provide atomic APIs for
> GPIO configurations. i.e. the driver (guest) would need to implement
> sleep-able versions of the APIs as the guest will respond asynchronously
> over the virtqueue.
>
> This patch adds the specification for it.
>
> Based on the initial work posted by:
> "Enrico Weigelt, metux IT consult" <lkml@metux.net>.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/110
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I found one detail that could be improved if you can come up with a better
way, or you just leave it:

> +\begin{lstlisting}
> +struct virtio_gpio_response {
> +    u8 status;
> +    u8 value[N];
> +};
> +
> +/* Possible values of the status field */
> +#define VIRTIO_GPIO_STATUS_OK                   0x0
> +#define VIRTIO_GPIO_STATUS_ERR                  0x1
> +\end{lstlisting}
> +
> +All the fields of this structure are set by the device and read by the driver.
> +
> +\begin{description}
> +\item[\field{status}] of the GPIO message,
> +    \field{VIRTIO_GPIO_STATUS_OK} on success and \field{VIRTIO_GPIO_STATUS_ERR}
> +    on failure.
> +
> +\item[\field{value}] is a message specific defined value. The value of N (i.e.
> +    size of the \field{value} buffer in bytes) is 1 for most of the messages,
> +    except \field{VIRTIO_GPIO_MSG_GET_LINE_NAMES}, where it is set to the value
> +    of \field{gpio_names_size} field.
> +\end{description}

I think the structure layout here is good, but I wonder if the
description would be clearer
if you define two separate structures, with a fixed-length structure for normal
requests, and the variable-length structure for VIRTIO_GPIO_MSG_GET_LINE_NAMES.

         Arnd

