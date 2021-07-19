Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org> <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
 <20210719102411.yykntzjefeamz24t@vireshk-i7>
In-Reply-To: <20210719102411.yykntzjefeamz24t@vireshk-i7>
From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 19 Jul 2021 14:00:21 +0200
Message-ID: <CAK8P3a09QeGsav65dbjK9=4yNCBRHPdxP6h0O1ve3tBYRbAuzQ@mail.gmail.com>
Subject: Re: [PATCH V5 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 19, 2021 at 12:24 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 16-07-21, 13:09, Viresh Kumar wrote:
> > This patch adds support for interrupts to the virtio-gpio specification.
> > This uses the feature bit 0 for the same.
>
> Michael (and other virtio experts),
>
> I have a doubt about interrupt messages initiated by the device. There is
> nothing meaningful I want to return from the driver to the device on an
> interrupt event, but I need to make sure the device doesn't send another
> interrupt for the same GPIO line, before the previous one is serviced. I was
> thinking about sending some sort of response message for it, but am not sure how
> to implement it.
>
> Another way out to implement this, is by adding to the spec that on interrupt
> the device MUST mask the interrupt line on the GPIO before sending the event to
> the driver and this irq can be re-enabled only by the driver sending another
> request over the primary virtqueue (and not interrupt virtqueue).
>
> What do you suggest ?

I would still hope that we can simplify this to the 'Ack' being implied by
requeuing the message from the gpio driver. In case of a level interrupt:

      device              driver
1.                            queue message
2. line activates
3. send reply
4. notify guest
5.                            call handler
6. line may activate
7.                            goto 1

For edge interrupts, I'm still not sure how it would work. The options
that I see are:

a) fasteoi style controller: when the device sends an event, this
    becomes implicitly masked as there is no way to send another
    until the message is requeued, but the device latches any further
    events, so that queuing the next message after the guest handler
    returns immediately results in the event getting delivered.
    This would use the minimum number of requests and let the
    driver use the exact same code for edge and level mode, but it
    does mean the possibility of extra wakeups, and it may require
    more work in the host.

b) require the requeue to happen in the guest before calling the
     handler to prevent missed events. Not sure if this is possible
     without another message, as the guest must be sure that the
     host has observed the requeue, but it cannot have returned
     any data yet.

c) explicit ack at start of guest: driver starts by sending an
    ack to the first virtqueue and waiting for it to be complete,
    then calls the handler, and only then  requeues the request.
    This would presumably add a lot of extra latency.

          Arnd

