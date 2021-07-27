Return-Path: <viresh.kumar@linaro.org>
Date: Tue, 27 Jul 2021 16:31:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [virtio-dev] Re: [PATCH V6 2/2] virtio-gpio: Add support for
 interrupts
Message-ID: <20210727110156.ptqm2ep5xdvebvje@vireshk-i7>
References: <cover.1626794843.git.viresh.kumar@linaro.org>
 <8ebe189f12f8f46b17f92f9e2fc3f49e2e3de0a2.1626794843.git.viresh.kumar@linaro.org>
 <CAK8P3a011+3OLHXXEY5w3JOeQEbYVvbKNHOvXLV=znRSi0C-gg@mail.gmail.com>
 <20210726115134.o5x5udigitucs5je@vireshk-i7>
 <CAK8P3a2n0mLE5pVig_UWBco5+hCGJ_RAjC2FHrPdOy5=gB9WSg@mail.gmail.com>
 <20210727062318.isjkuaiaxn2qrkdi@vireshk-i7>
 <CAK8P3a1k8gtHsK9YQjQGsBau8MWia8NisN5CBdMjY829y9-mPg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1k8gtHsK9YQjQGsBau8MWia8NisN5CBdMjY829y9-mPg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 27-07-21, 10:03, Arnd Bergmann wrote:
> On Tue, Jul 27, 2021 at 8:23 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 26-07-21, 14:13, Arnd Bergmann wrote:
> > > The question is whether it adds any value though. As far as I can tell,
> > > it is completely redundant, duplicating either what is implied by
> > > irq type==none, or what is implied by the request not being queued.
> >
> > Right, we shouldn't have redundant stuff in here.
> >
> > Though, binding of all interrupt operations to the eventq can be trick
> > IMO.
> >
> > - How will the driver mask an interrupt for which the buffer is
> >   already sent over the eventq? There is no API available to recall a
> >   buffer. So we would need an API over the requestq for that.
> 
> Agreed, there needs to be some way to cancel the request. I don't
> think this would have to be a fast or common operation, so setting
> the line back to IRQ_TYPE_NONE would be one way.

Hmm, how would that work ? I thought you were talking about inferring
all irq operations from the presence of the buffer in the eventq
itself. So once the buffer is sent to the host, we can't send it again
to change the irq-type.

> Another option would be to make the mask software-only and
> just ignore an incoming event for a line that is configured as
> masked, and then not requeue the request.

Hmm, I wonder what will happen if the driver gets removed/probed again
after sending the buffer :)

> > - Latching of edge interrupt between the buffer is returned by the
> >   device and requeued by the driver. How will the device know if the
> >   user has simply requeued the eventq buffer (where the latched value
> >   is meaningful) or it has done something like free_irq() followed by
> >   request_irq() in the kernel (where the latched value must be
> >   discarded).
> 
> I was expecting a 'mask' to not discard the latched event but simply
> not deliver it until it gets unmasked.

Right, we are aligned on that. Masked == buffer is owned by driver
here.

> Either way, we can define that
> a new set-irq-type request discards all latched edge interrupts.

Hmm, so you proposing to keep a separate (single) request for irq
handling over the controlq ?

-- 
viresh

