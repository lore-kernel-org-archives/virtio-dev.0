Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
References: <cover.1627469463.git.viresh.kumar@linaro.org> <056d54eae73a353b33b5319acd1b948c8f7aad93.1627469463.git.viresh.kumar@linaro.org>
In-Reply-To: <056d54eae73a353b33b5319acd1b948c8f7aad93.1627469463.git.viresh.kumar@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 28 Jul 2021 14:56:19 +0200
Message-ID: <CACRpkda6RUPD+xbwtJNUuC6Wvov84hKY6-+KD4oUsGX0++k=SA@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Cornelia Huck <cohuck@redhat.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, stratos-dev@op-lists.linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Viresh,

overall this looks good, with the minor nits pointed out:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

On Wed, Jul 28, 2021 at 1:11 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> +\subsubsection{requestq Operation: Get Direction}\label{sec:Device Types / GPIO Device / requestq Operation / Get Direction}
> +
> +The driver sends this message to request the device to return a line's
> +configured direction.
> +
> +\begin{tabularx}{\textwidth}{ |l||X|X|X| }
> +\hline
> +\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
> +\hline
> +& \field{VIRTIO_GPIO_MSG_GET_DIRECTION} & line number & 0 \\
> +\hline
> +\end{tabularx}
> +
> +\begin{tabularx}{\textwidth}{ |l||X|X|X| }
> +\hline
> +\textbf{Response} & \field{status} & \field{value[N]} & \field{Where N is} \\
> +\hline
> +    & \field{VIRTIO_GPIO_STATUS_*} & \field{VIRTIO_GPIO_DIRECTION_*} & 1 \\
> +\hline
> +\end{tabularx}

Is it clearly defined which value of VIRTIO_GPIO_DIRECTION_[IN|OUT]
mean "input" and which value means "output"? Else add some text
clarifying this.

> +\begin{tabularx}{\textwidth}{ |l||X|X|X| }
> +\hline
> +\textbf{Response} & \field{status} & \field{value[N]} & \field{Where N is} \\
> +\hline
> +& \field{VIRTIO_GPIO_STATUS_*} & 0 = low, 1 = high & 1 \\
> +\hline
> +\end{tabularx}

Here, for example it is clearly defined.

Yours,
Linus Walleij

