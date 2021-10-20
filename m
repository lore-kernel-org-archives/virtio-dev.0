Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <2f66fd73961cd38a91c1a4297ad08642055dbb77.1634209052.git.viresh.kumar@linaro.org>
In-Reply-To: <2f66fd73961cd38a91c1a4297ad08642055dbb77.1634209052.git.viresh.kumar@linaro.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 20 Oct 2021 09:46:53 +0200
Message-ID: <CAK8P3a0mspcfLZ+duLcGXnCcJPKnoV_b2bJoT=YEon-Czo+NPg@mail.gmail.com>
Subject: Re: [PATCH V10] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Marc Zyngier <maz@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Kent Gibson <warthog618@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Oct 14, 2021 at 1:00 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This patch adds support for interrupts to the virtio-gpio specification.
> This uses the feature bit 0 for the same.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/114
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V9 -> V10:
> - Mandatory for the interrupt to be enabled before being unmasked.
>
> - Remove unnecessary stuff from Device Initialization and clean it up.
>
> - Minor cleanup (s/enabled/negotiated, etc).

With the latest changes, this all looks good to me, and I've had
another look at the kernel driver you posted last time to make
sure I don't see any substantial problems with that either.

I found a few things that can be improved in the driver (as discussed
on IRC), but none of those are relevant to the specification update.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

