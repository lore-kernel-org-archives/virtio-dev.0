Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org> <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
 <20210719102411.yykntzjefeamz24t@vireshk-i7> <CAK8P3a09QeGsav65dbjK9=4yNCBRHPdxP6h0O1ve3tBYRbAuzQ@mail.gmail.com>
 <20210720061130.46y76hkjm5xgvjmo@vireshk-i7>
In-Reply-To: <20210720061130.46y76hkjm5xgvjmo@vireshk-i7>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 20 Jul 2021 09:17:30 +0200
Message-ID: <CAK8P3a1FqQ7VzVNWAjvwBv3d84OUa3VwF5a+sHRvrphNuUAWfQ@mail.gmail.com>
Subject: Re: [PATCH V5 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 20, 2021 at 8:11 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 19-07-21, 14:00, Arnd Bergmann wrote:
> > I would still hope that we can simplify this to the 'Ack' being implied by
> > requeuing the message from the gpio driver.
>
> Which would mean that we process one interrupt at a time, I was hoping
> to do some sort parallelization here by allowing interrupts for
> multiple GPIO lines to be processed together.
>
> Another way of doing that would be sending a mask of all GPIO pins
> where interrupt is pending on this irq request. That would require a
> separate bit for each GPIO pin, i.e. 8 32-bit values for 256 GPIO
> pins. Which would also require to change the size of ngpio field in
> the config structure to u8 instead of u16. I am not sure why it should
> be u16 really (Enrico had it this way), it sounds really big. Will we
> ever need anything over 256? And why not add another device in that
> case.

I don't think you can have a message for more than one line here,
that would mess up the synchronization as then you have to
keep double accounting of which gpios are already pending
on each side.

The most sensible way I see this can be done is to have a message
per line, and have it as a token that is either on the device or the
driver side at any point. When the driver has sent the token over
to the device, the irq is armed, and when the device replies, it is
implicitly masked.

Ideally this could even replace the VIRTIO_GPIO_MSG_IRQ_TYPE,
VIRTIO_GPIO_MSG_IRQ_MASK and VIRTIO_GPIO_MSG_IRQ_UNMASK
messages with a single message type on the interrupt virtqueue:

struct virtio_gpio_irq_event {
      __le16 line;
      __u8 type;
      __u8 status;
}

When the driver wants an event on a gpio line, it enqueues this
message to the virtqueue, and then the device either adds the
corresponding file descriptor to its poll table, or replies immediately
with one of these status words:

- request not supported
- level interrupt is still active (line remains at requested level)
- edge interrupt has happened since last reply

> > b) require the requeue to happen in the guest before calling the
> >      handler to prevent missed events. Not sure if this is possible
> >      without another message, as the guest must be sure that the
> >      host has observed the requeue, but it cannot have returned
> >      any data yet.
>
> The driver does call virtqueue_kick() there, so an event must go to
> the device. Maybe that can be seen as the device has observed the
> event.

But you said we can't enqueue the event from irq context in your
other reply, so I think it wouldn't work after all.

       Arnd

