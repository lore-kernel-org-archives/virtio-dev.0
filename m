Return-Path: <viresh.kumar@linaro.org>
Date: Tue, 27 Jul 2021 11:53:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V6 2/2] virtio-gpio: Add support for interrupts
Message-ID: <20210727062318.isjkuaiaxn2qrkdi@vireshk-i7>
References: <cover.1626794843.git.viresh.kumar@linaro.org>
 <8ebe189f12f8f46b17f92f9e2fc3f49e2e3de0a2.1626794843.git.viresh.kumar@linaro.org>
 <CAK8P3a011+3OLHXXEY5w3JOeQEbYVvbKNHOvXLV=znRSi0C-gg@mail.gmail.com>
 <20210726115134.o5x5udigitucs5je@vireshk-i7>
 <CAK8P3a2n0mLE5pVig_UWBco5+hCGJ_RAjC2FHrPdOy5=gB9WSg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2n0mLE5pVig_UWBco5+hCGJ_RAjC2FHrPdOy5=gB9WSg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 26-07-21, 14:13, Arnd Bergmann wrote:
> On Mon, Jul 26, 2021 at 1:51 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 26-07-21, 13:10, Arnd Bergmann wrote:
> >
> > > I would still hope that we can combine the irq_type, mask and request
> >
> > request ? you wanted to say "unmask" ?
> 
> No, I meant VIRTIO_GPIO_MSG_IRQ_TYPE,

Ah, I was confused since this request type isn't there anymore.

> VIRTIO_GPIO_MSG_IRQ_{UN,}MASK and virtio_gpio_irq_request messages.
> 
> All three can change the state between 'can interrupt' and 'can not interrupt',
> so you only get notified if all three are in the active state (irq type != none,
> mask disabled, request queued).
> 
> > > steps into either one or two steps. I think the minimalistic approach would
> > > be to expand the message to include both the "mask" and "set-type"
> > > operations, and this should work, as long as we define sensible semantics.
> >
> > I think we can easily merge unmask and set-type into a single message,
> > since that will fit within the request structure used for most of the
> > requests on the requestq. i.e. a single byte of data.
> >
> > mask() doesn't require irq-type, so it can live separately.
> 
> The question is whether it adds any value though. As far as I can tell,
> it is completely redundant, duplicating either what is implied by
> irq type==none, or what is implied by the request not being queued.

Right, we shouldn't have redundant stuff in here.

Though, binding of all interrupt operations to the eventq can be trick
IMO.

- How will the driver mask an interrupt for which the buffer is
  already sent over the eventq? There is no API available to recall a
  buffer. So we would need an API over the requestq for that.

- Latching of edge interrupt between the buffer is returned by the
  device and requeued by the driver. How will the device know if the
  user has simply requeued the eventq buffer (where the latched value
  is meaningful) or it has done something like free_irq() followed by
  request_irq() in the kernel (where the latched value must be
  discarded).

-- 
viresh

