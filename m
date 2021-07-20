Return-Path: <viresh.kumar@linaro.org>
Date: Tue, 20 Jul 2021 09:49:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 2/2] virtio-gpio: Add support for interrupts
Message-ID: <20210720041913.d2rrbbsvusph272g@vireshk-i7>
References: <cover.1626418779.git.viresh.kumar@linaro.org>
 <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
 <20210719102411.yykntzjefeamz24t@vireshk-i7>
 <20210719110854-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210719110854-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 19-07-21, 11:11, Michael S. Tsirkin wrote:
> On Mon, Jul 19, 2021 at 03:54:11PM +0530, Viresh Kumar wrote:
> > On 16-07-21, 13:09, Viresh Kumar wrote:
> > > This patch adds support for interrupts to the virtio-gpio specification.
> > > This uses the feature bit 0 for the same.
> > 
> > Michael (and other virtio experts),
> > 
> > I have a doubt about interrupt messages initiated by the device. There is
> > nothing meaningful I want to return from the driver to the device on an
> > interrupt event, but I need to make sure the device doesn't send another
> > interrupt for the same GPIO line, before the previous one is serviced. I was
> > thinking about sending some sort of response message for it, but am not sure how
> > to implement it.
> 
> My suggestion is this: driver adds a buffer to tell device
> it wants an interrupt. device uses the buffer to notify
> driver of the interrupt event.

So what you are suggesting is, re-queue of the buffer would mean an
acknowledgement for the interrupt from the driver.

Hmm, I was looking at parallelizing the interrupts for various GPIOs. Lets say
we have X number of GPIO lines, with what you are suggesting, we will only honor
1 interrupt at a time. What I was thinking of was providing multiple buffers at
the beginning itself, lets say 5-10, so we can process the interrupts in
parallel in separate threads (probably running on different virtual CPUs in the
guest).

> > Another way out to implement this, is by adding to the spec that on interrupt
> > the device MUST mask the interrupt line on the GPIO before sending the event to
> > the driver and this irq can be re-enabled only by the driver sending another
> > request over the primary virtqueue (and not interrupt virtqueue).
> > 
> > What do you suggest ?
> 
> Well vqs fundamentally can cause spurious interrupts. First suggestion
> is closer to how other devices do this.

-- 
viresh

