Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1627469463.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1627469463.git.viresh.kumar@linaro.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 28 Jul 2021 13:16:48 +0200
Message-ID: <CAK8P3a1qfh6M8i8RUOvXFMaCoChnmGw+0nydJFH7QqofA3HJzw@mail.gmail.com>
Subject: Re: [PATCH V7 0/2] virtio: Add specification for virtio-gpio
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 28, 2021 at 1:11 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Version history of the specification I sent:
>
> V6 -> V7:
> - Drop Activate/Deactivate requests and merge them with set-direction one.
> - Dropped separate calls to set direction to input or output (with a value),
>   with a single call to set-direction (input, output, or none). Note that the
>   driver needs to call set-value before calling set-direction-out now.
> - Allow multiple messages for a GPIO line to be sent together, they must be
>   processed in order though.
> - The gpio-line names aren't required to be set for all the lines now, it is
>   optional and can be present only for a subset of lines. Provided example as
>   well.
> - Merge irq-set/mask/unmask to a single set-irq-type message.
> - We have only 6 message types now instead of 11 in v6.
> - Mentioned about non-atomic nature of the these messages in commit log for
>   patch 1/2.
> - Improved spec content overall.

Nice update, this all sounds good to me. I'll go through the two patches
in more detail next, but don't expect to find much then.

       Arnd

