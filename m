Return-Path: <mst@redhat.com>
Date: Tue, 20 Jul 2021 05:50:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 2/2] virtio-gpio: Add support for interrupts
Message-ID: <20210720054847-mutt-send-email-mst@kernel.org>
References: <cover.1626418779.git.viresh.kumar@linaro.org>
 <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
 <20210719102411.yykntzjefeamz24t@vireshk-i7>
 <CAK8P3a09QeGsav65dbjK9=4yNCBRHPdxP6h0O1ve3tBYRbAuzQ@mail.gmail.com>
 <20210720061130.46y76hkjm5xgvjmo@vireshk-i7>
 <CAK8P3a1FqQ7VzVNWAjvwBv3d84OUa3VwF5a+sHRvrphNuUAWfQ@mail.gmail.com>
 <20210720075337.k6qxlsru2ot2odb6@vireshk-i7>
MIME-Version: 1.0
In-Reply-To: <20210720075337.k6qxlsru2ot2odb6@vireshk-i7>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 20, 2021 at 01:23:37PM +0530, Viresh Kumar wrote:
> On 20-07-21, 09:17, Arnd Bergmann wrote:
> > I don't think you can have a message for more than one line here,
> > that would mess up the synchronization as then you have to
> > keep double accounting of which gpios are already pending
> > on each side.
> 
> Yes.
> 
> > The most sensible way I see this can be done is to have a message
> > per line, and have it as a token that is either on the device or the
> > driver side at any point. When the driver has sent the token over
> > to the device, the irq is armed, and when the device replies, it is
> > implicitly masked.
> 
> I like the idea in general but at this point I am not very sure how it
> will work. Looking at kernel (and qemu) side implementations, what
> really transfers between device and driver is a series of buffers
> (marked as in or out sgs). Now these are either device writable or
> driver. I am not sure if the device is required to write anything here
> to the buffer, it can simply return the buffer as is and so we can
> make it driver writable only, i.e. only 1 sg element required.
> 
> > Ideally this could even replace the VIRTIO_GPIO_MSG_IRQ_TYPE,
> > VIRTIO_GPIO_MSG_IRQ_MASK
> 
> Maybe yes.
> 
> > and VIRTIO_GPIO_MSG_IRQ_UNMASK
> 
> I think we would still require some kind of unmasking here as the
> driver would have already sent the buffer to the device and wants the
> ownership back, otherwise it may hit an interrupt later on.
> 
> Although I would like to keep the three routines separate, just to be
> robust here. For example what will we do if the user does this (yes it
> won't do it, but I am trying to handle the corner cases well):
> 
> 1. irq-type-edge-falling
> 2. irq-unmask
> 3. irq-type-edge-both
> 
> Since we would have already sent the buffer at (2), we can't do (3)
> without getting the buffer back.
> 
> Tying everything with availability of the buffer itself makes it kind
> of messy.

I'm not sure about the detail but buffers can be consumed
in any order. So sure you can also have an explicit unmask
or cancel or whatever message on the same vq.

> > messages with a single message type on the interrupt virtqueue:
> > 
> > struct virtio_gpio_irq_event {
> >       __le16 line;
> >       __u8 type;
> >       __u8 status;
> > }
> > 
> > When the driver wants an event on a gpio line, it enqueues this
> > message to the virtqueue, and then the device either adds the
> > corresponding file descriptor to its poll table, or replies immediately
> > with one of these status words:
> > 
> > - request not supported
> > - level interrupt is still active (line remains at requested level)
> > - edge interrupt has happened since last reply
> 
> -- 
> viresh

