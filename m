Return-Path: <viresh.kumar@linaro.org>
Date: Thu, 29 Jul 2021 09:17:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V7 1/2] virtio-gpio: Add the device specification
Message-ID: <20210729034720.qadiqugbg7dzhs5c@vireshk-i7>
References: <cover.1627469463.git.viresh.kumar@linaro.org>
 <056d54eae73a353b33b5319acd1b948c8f7aad93.1627469463.git.viresh.kumar@linaro.org>
 <CACRpkda6RUPD+xbwtJNUuC6Wvov84hKY6-+KD4oUsGX0++k=SA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACRpkda6RUPD+xbwtJNUuC6Wvov84hKY6-+KD4oUsGX0++k=SA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Cornelia Huck <cohuck@redhat.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, stratos-dev@op-lists.linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 28-07-21, 14:56, Linus Walleij wrote:
> overall this looks good, with the minor nits pointed out:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks.

> On Wed, Jul 28, 2021 at 1:11 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > +\subsubsection{requestq Operation: Get Direction}\label{sec:Device Types / GPIO Device / requestq Operation / Get Direction}
> > +
> > +The driver sends this message to request the device to return a line's
> > +configured direction.
> > +
> > +\begin{tabularx}{\textwidth}{ |l||X|X|X| }
> > +\hline
> > +\textbf{Request} & \field{type} & \field{gpio} & \field{value} \\
> > +\hline
> > +& \field{VIRTIO_GPIO_MSG_GET_DIRECTION} & line number & 0 \\
> > +\hline
> > +\end{tabularx}
> > +
> > +\begin{tabularx}{\textwidth}{ |l||X|X|X| }
> > +\hline
> > +\textbf{Response} & \field{status} & \field{value[N]} & \field{Where N is} \\
> > +\hline
> > +    & \field{VIRTIO_GPIO_STATUS_*} & \field{VIRTIO_GPIO_DIRECTION_*} & 1 \\
> > +\hline
> > +\end{tabularx}
> 
> Is it clearly defined which value of VIRTIO_GPIO_DIRECTION_[IN|OUT]
> mean "input" and which value means "output"? Else add some text
> clarifying this.

+/* GPIO Direction types */
+#define VIRTIO_GPIO_DIRECTION_NONE              0x00
+#define VIRTIO_GPIO_DIRECTION_OUT               0x01
+#define VIRTIO_GPIO_DIRECTION_IN                0x02

Not sure if you missed this.

Were you looking for this or some text saying
"VIRTIO_GPIO_DIRECTION_IN means direction-input", which looked self
explanatory to me at least, though I can surely add it anyway.

-- 
viresh

