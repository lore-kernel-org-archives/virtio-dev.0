Return-Path: <viresh.kumar@linaro.org>
Date: Mon, 26 Jul 2021 17:21:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V6 2/2] virtio-gpio: Add support for interrupts
Message-ID: <20210726115134.o5x5udigitucs5je@vireshk-i7>
References: <cover.1626794843.git.viresh.kumar@linaro.org>
 <8ebe189f12f8f46b17f92f9e2fc3f49e2e3de0a2.1626794843.git.viresh.kumar@linaro.org>
 <CAK8P3a011+3OLHXXEY5w3JOeQEbYVvbKNHOvXLV=znRSi0C-gg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a011+3OLHXXEY5w3JOeQEbYVvbKNHOvXLV=znRSi0C-gg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 26-07-21, 13:10, Arnd Bergmann wrote:
> On Tue, Jul 20, 2021 at 5:28 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > This patch adds support for interrupts to the virtio-gpio specification.
> > This uses the feature bit 0 for the same.
> 
> I think the flow of event messages already looks great with this version, and I
> like the level of detail in the explanations.

Thanks.

> The only part I don't like is that it seems overly redundant to have three
> ways to enable/disable irq delivery. More on that below.
> 
> > +\item If the GPIO line is configured for Level interrupts, the device MUST
> > +    ignore any further interrupts for the line, until the time the buffers are
> > +    made available again by the driver.
> 
> This wording sounds odd, since there are not technically any interrupt events
> on the level triggered line, but instead the level is active. I would
> describe this
> as "the device MUST mask the interrupt line, until the time ...", though that
> conflicts with the terminology for the mask/unmask request.

Right.

> I would still hope that we can combine the irq_type, mask and request

request ? you wanted to say "unmask" ?

> steps into either one or two steps. I think the minimalistic approach would
> be to expand the message to include both the "mask" and "set-type"
> operations, and this should work, as long as we define sensible semantics.

I think we can easily merge unmask and set-type into a single message,
since that will fit within the request structure used for most of the
requests on the requestq. i.e. a single byte of data.

mask() doesn't require irq-type, so it can live separately.

> Another option would be to fold the "set irq type" operation into "set
> direction",

Yeah, I would like to keep them separate and not mix irq-type with
directions in general, as you can set direction to input with or
without setting its interrupt type.

Over that interrupt support is enabled with a feature, so better keep
it separate.

> so an input can be configured as any of the five irq types, with
> "IRQ_TYPE_NONE" implying that interrupts are disabled for this line.
> This would still provide an extra way of masking the interrupt, so we just
> need "set-direction" and "request event". In this case, setting the interrupt
> type to "none" should probably cancel any pending irq and force the
> message to be returned.
> 
> You could actually take that further and fold the "set value" into "set
> direction",

At least gpio-direction-out already takes a value with it.

> which also simplifies the output direction and avoids the
> case where can you set a gpio to output before setting the value first.

Yeah, that is already done.

-- 
viresh

