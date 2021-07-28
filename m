Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
References: <cover.1627469463.git.viresh.kumar@linaro.org> <0dac5ab26a5fcc94ec530dbf83247788922123d7.1627469463.git.viresh.kumar@linaro.org>
In-Reply-To: <0dac5ab26a5fcc94ec530dbf83247788922123d7.1627469463.git.viresh.kumar@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 28 Jul 2021 14:58:25 +0200
Message-ID: <CACRpkdZDptyPpin_0o7gr+u5ve183Fxf_aVBeHUUExkTUSK1cg@mail.gmail.com>
Subject: Re: [PATCH V7 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Cornelia Huck <cohuck@redhat.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, stratos-dev@op-lists.linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 28, 2021 at 1:11 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> This patch adds support for interrupts to the virtio-gpio specification.
> This uses the feature bit 0 for the same.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/110
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

From a GPIO point of view this looks good, so FWIW
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

It's best if you get feedback from the irqchip people too.

Yours,
Linus Walleij

