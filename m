Return-Path: <viresh.kumar@linaro.org>
Date: Mon, 19 Jul 2021 15:54:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 2/2] virtio-gpio: Add support for interrupts
Message-ID: <20210719102411.yykntzjefeamz24t@vireshk-i7>
References: <cover.1626418779.git.viresh.kumar@linaro.org>
 <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
In-Reply-To: <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 16-07-21, 13:09, Viresh Kumar wrote:
> This patch adds support for interrupts to the virtio-gpio specification.
> This uses the feature bit 0 for the same.

Michael (and other virtio experts),

I have a doubt about interrupt messages initiated by the device. There is
nothing meaningful I want to return from the driver to the device on an
interrupt event, but I need to make sure the device doesn't send another
interrupt for the same GPIO line, before the previous one is serviced. I was
thinking about sending some sort of response message for it, but am not sure how
to implement it.

Another way out to implement this, is by adding to the spec that on interrupt
the device MUST mask the interrupt line on the GPIO before sending the event to
the driver and this irq can be re-enabled only by the driver sending another
request over the primary virtqueue (and not interrupt virtqueue).

What do you suggest ?

-- 
viresh

