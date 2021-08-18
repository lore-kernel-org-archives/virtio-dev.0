Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <da4212f303c9fa797bde4eb8bcdc2d8d2d71bc99.1629286171.git.viresh.kumar@linaro.org>
In-Reply-To: <da4212f303c9fa797bde4eb8bcdc2d8d2d71bc99.1629286171.git.viresh.kumar@linaro.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 18 Aug 2021 14:02:19 +0200
Message-ID: <CAK8P3a0V_9DR1yNfO2HgXnb521TJzg_51HfCn47Hb_-v8uMDDA@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpio: Specify character encoding for gpio names
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, virtio-dev@lists.oasis-open.org, Stratos Mailing List <stratos-dev@op-lists.linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Aug 18, 2021 at 1:31 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> diff --git a/virtio-gpio.tex b/virtio-gpio.tex
> index 5da16d920aa3..0b0689cceb08 100644
> --- a/virtio-gpio.tex
> +++ b/virtio-gpio.tex
> @@ -119,7 +119,8 @@ \subsubsection{requestq Operation: Get Line Names}\label{sec:Device Types / GPIO
>  order of the GPIO line numbers. The names of the GPIO lines are optional and may
>  be present only for a subset of GPIO lines. If missing, then a zero-byte must be
>  present for the GPIO line. If present, the name string must be zero-terminated
> -and the name must be unique within a GPIO Device.
> +and the name must be unique within a GPIO Device. The names of the GPIO lines
> +are encoded in UTF-8.

I would prefer mandating this to be 7-bit ASCII, since Linux uses the string as
a file name in the (deprecated) sysfs interface, and the more unusual symbols
may be hard to type on the command line.

There is also a question about UTF-8 normalization of those strings: should
the guest assume that the names within a device just have different binary
representations, or also that they represent unique strings when there are
multiple equivalent or compatible sequences?

       Arnd

