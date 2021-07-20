Return-Path: <viresh.kumar@linaro.org>
Date: Tue, 20 Jul 2021 11:41:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 2/2] virtio-gpio: Add support for interrupts
Message-ID: <20210720061130.46y76hkjm5xgvjmo@vireshk-i7>
References: <cover.1626418779.git.viresh.kumar@linaro.org>
 <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
 <20210719102411.yykntzjefeamz24t@vireshk-i7>
 <CAK8P3a09QeGsav65dbjK9=4yNCBRHPdxP6h0O1ve3tBYRbAuzQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a09QeGsav65dbjK9=4yNCBRHPdxP6h0O1ve3tBYRbAuzQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 19-07-21, 14:00, Arnd Bergmann wrote:
> I would still hope that we can simplify this to the 'Ack' being implied by
> requeuing the message from the gpio driver.

Which would mean that we process one interrupt at a time, I was hoping
to do some sort parallelization here by allowing interrupts for
multiple GPIO lines to be processed together.

Another way of doing that would be sending a mask of all GPIO pins
where interrupt is pending on this irq request. That would require a
separate bit for each GPIO pin, i.e. 8 32-bit values for 256 GPIO
pins. Which would also require to change the size of ngpio field in
the config structure to u8 instead of u16. I am not sure why it should
be u16 really (Enrico had it this way), it sounds really big. Will we
ever need anything over 256? And why not add another device in that
case.

> In case of a level interrupt:
> 
>       device              driver
> 1.                            queue message
> 2. line activates
> 3. send reply
> 4. notify guest
> 5.                            call handler
> 6. line may activate
> 7.                            goto 1
> 
> For edge interrupts, I'm still not sure how it would work. The options
> that I see are:
> 
> a) fasteoi style controller: when the device sends an event, this
>     becomes implicitly masked as there is no way to send another
>     until the message is requeued, but the device latches any further
>     events, so that queuing the next message after the guest handler
>     returns immediately results in the event getting delivered.
>     This would use the minimum number of requests and let the
>     driver use the exact same code for edge and level mode, but it
>     does mean the possibility of extra wakeups, and it may require
>     more work in the host.
> 
> b) require the requeue to happen in the guest before calling the
>      handler to prevent missed events. Not sure if this is possible
>      without another message, as the guest must be sure that the
>      host has observed the requeue, but it cannot have returned
>      any data yet.

The driver does call virtqueue_kick() there, so an event must go to
the device. Maybe that can be seen as the device has observed the
event.

> c) explicit ack at start of guest: driver starts by sending an
>     ack to the first virtqueue and waiting for it to be complete,
>     then calls the handler, and only then  requeues the request.
>     This would presumably add a lot of extra latency.

I would like the interrupt handler at the guest to share same code
across irq types, so re-queuing a buffer only after handling the
interrupt work then. Moreover I am not sure currently when does
irq_bus_sync_lock/unlock() get called in this whole sequence, where we
actually mask/unmask the interrupts.

-- 
viresh

