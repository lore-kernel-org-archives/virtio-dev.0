Return-Path: <virtio-dev-return-8382-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 20D8B985DF2
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Jul 2021 09:18:46 +0000 (UTC)
MIME-Version: 1.0
References: <cover.1626794843.git.viresh.kumar@linaro.org> <199c624bd735782dd5d4a51e376f466f5c38ef2c.1626794843.git.viresh.kumar@linaro.org>
In-Reply-To: <199c624bd735782dd5d4a51e376f466f5c38ef2c.1626794843.git.viresh.kumar@linaro.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 26 Jul 2021 11:18:26 +0200
Message-ID: <CAK8P3a0PtwUMD0RRpmaXitfpUJ+OiayMMLx-4a=LnokSs4gPnA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH V6 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 20, 2021 at 5:28 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
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
> ---
> +
> +\item[\field{gpio_names_size}] is the size of the gpio-names memory block in
> +    bytes, which can be fetched by the driver using the
> +    \field{VIRTIO_GPIO_MSG_GET_NAMES} message. The device MUST set this to 0 if
> +    it doesn't support names for the GPIO lines.
> +\end{description}

I would be more comfortable with leaving out this field, and making the
name lookup fixed-length and per line.

> +\subsubsection{requestq Operation: Get Names}\label{sec:Device Types / GPIO Device / requestq Operation / Get Names}
> +
> +The driver sends this message to receive a stream of zero-terminated strings,
> +where each string represents the name of a GPIO line, present in increasing
> +order of the GPIO line numbers. The GPIO line names must be unique within a GPIO
> +Device and must not be an empty string.
> +
> +These names of the GPIO lines should be most meaningful producer names for the
> +system, such as name indicating the usage. For example "MMC-CD", "Red LED Vdd"
> +and "ethernet reset" are reasonable line names as they describe what the line is
> +used for, while "GPIO0" is not a good name to give to a GPIO line.
> +
> +The device MUST set the \field{gpio_names_size} to a non-zero value if this
> +message is supported by the device, else it must be set to zero.
> +
> +The driver must allocate the \field{value[N]} buffer in the \field{struct
> +virtio_gpio_response} for N bytes, where N = \field{gpio_names_size}.

Making this a per-line request also has the advantage that the device
can have names associated with some of the lines, but leave
some other lines unnamed, which I think is something that happens
in practice.

Not sure what a good upper limit for the length of the name is, but
making this fixed-length would seem simpler to me.

> +\subsubsection{requestq Operation: Activate}\label{sec:Device Types / GPIO Device / requestq Operation / Activate}
> +
> +The driver sends this message to notify the device that one of its lines has
> +been assigned for use.

Maybe expand this description a little more according to our previous
discussion.
In particular, I would expect this to describe

- what the controller hardware is expected to do as a result
- which of the other calls are allowed on lines that have been requested
  or have not been requested. This information could be duplicated in the
  respective descriptions. In particular, it is not obvious whether you should
  set the direction before or after 'request', and I assume only one of the
  two possibilities is allowed.

> +
> +\item The driver MUST NOT send another message, of any type, for a GPIO line
> +    before receiving a response from the device for the previously sent message
> +    for the same GPIO line.

I have a question here, not sure if this needs to be answered in the spec: why
can't the driver send activate, set-direction and set-value all at
once for a line?
Clearly if one request fails, the later ones would fail as well in
this example, but
I don't see this as a problem for either side.

> +\item The device MAY process messages out of order and in parallel and MAY send
> +    message's response to the driver out of order.

Here I have the opposite question: what is the benefit of allowing the requests
to be processed out of order? Should these not all be instantaneous, and easier
to handle by making the request queue serialized?

        Arnd

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

