Return-Path: <mst@redhat.com>
Date: Fri, 16 Jul 2021 11:22:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 1/2] virtio-gpio: Add the device specification
Message-ID: <20210716111916-mutt-send-email-mst@kernel.org>
References: <cover.1626418779.git.viresh.kumar@linaro.org>
 <4bb66b16dc261acf9d40517c8b7961a52212086b.1626418779.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
In-Reply-To: <4bb66b16dc261acf9d40517c8b7961a52212086b.1626418779.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 16, 2021 at 01:09:18PM +0530, Viresh Kumar wrote:
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

...


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

There's a problem with this approach: config space size is
actually pretty limited since it might be in the IO space
when using PCI. That is turn is recommended not to exceed 256 bytes.
Is it important to have the names accessible before driver
is fully initialized? If not I would just create a VQ
and use that to retrieve this data.

Note: the competing virtio-gpio proposal on list shares the issue.

-- 
MST

