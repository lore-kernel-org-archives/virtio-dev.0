Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626794843.git.viresh.kumar@linaro.org> <8ebe189f12f8f46b17f92f9e2fc3f49e2e3de0a2.1626794843.git.viresh.kumar@linaro.org>
In-Reply-To: <8ebe189f12f8f46b17f92f9e2fc3f49e2e3de0a2.1626794843.git.viresh.kumar@linaro.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 26 Jul 2021 13:10:39 +0200
Message-ID: <CAK8P3a011+3OLHXXEY5w3JOeQEbYVvbKNHOvXLV=znRSi0C-gg@mail.gmail.com>
Subject: Re: [PATCH V6 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 20, 2021 at 5:28 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This patch adds support for interrupts to the virtio-gpio specification.
> This uses the feature bit 0 for the same.

I think the flow of event messages already looks great with this version, and I
like the level of detail in the explanations.

The only part I don't like is that it seems overly redundant to have three
ways to enable/disable irq delivery. More on that below.

> +\item If the GPIO line is configured for Level interrupts, the device MUST
> +    ignore any further interrupts for the line, until the time the buffers are
> +    made available again by the driver.

This wording sounds odd, since there are not technically any interrupt events
on the level triggered line, but instead the level is active. I would
describe this
as "the device MUST mask the interrupt line, until the time ...", though that
conflicts with the terminology for the mask/unmask request.

I would still hope that we can combine the irq_type, mask and request
steps into either one or two steps. I think the minimalistic approach would
be to expand the message to include both the "mask" and "set-type"
operations, and this should work, as long as we define sensible semantics.

Another option would be to fold the "set irq type" operation into "set
direction",
so an input can be configured as any of the five irq types, with
"IRQ_TYPE_NONE" implying that interrupts are disabled for this line.
This would still provide an extra way of masking the interrupt, so we just
need "set-direction" and "request event". In this case, setting the interrupt
type to "none" should probably cancel any pending irq and force the
message to be returned.

You could actually take that further and fold the "set value" into "set
direction", which also simplifies the output direction and avoids the
case where can you set a gpio to output before setting the value first.

         Arnd

