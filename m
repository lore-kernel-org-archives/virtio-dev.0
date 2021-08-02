Return-Path: <viresh.kumar@linaro.org>
Date: Mon, 2 Aug 2021 10:42:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V8 2/2] virtio-gpio: Add support for interrupts
Message-ID: <20210802051254.yk7hrm5jfvkbqtza@vireshk-i7>
References: <cover.1627627021.git.viresh.kumar@linaro.org>
 <33671b4e543557740acf85bc30ed8ad1ba9ef8aa.1627627021.git.viresh.kumar@linaro.org>
 <CAK8P3a1G-TNkCxXg-FTAP6iqPyyJHU_gNGGF3ZqH8=5inASY5g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1G-TNkCxXg-FTAP6iqPyyJHU_gNGGF3ZqH8=5inASY5g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 30-07-21, 10:08, Arnd Bergmann wrote:
> On Fri, Jul 30, 2021 at 8:45 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +If the trigger type is set to \field{VIRTIO_GPIO_IRQ_TYPE_NONE}, the device MUST
> > +mask the interrupt for the GPIO line and discard any latched interrupt event
> > +associated with it. The device MUST also return any unused pair of buffers
> > +for the GPIO line, over the \field{eventq} virtqueue, after setting the
> > +\field{status} field to \field{VIRTIO_GPIO_IRQ_STATUS_INVALID}. If the driver
> > +queues another pair of buffers, while the trigger type remains set as
> > +\field{VIRTIO_GPIO_IRQ_TYPE_NONE}, the device MUST wait for another message of
> > +type \field{VIRTIO_GPIO_MSG_SET_IRQ_TYPE} before using the newly queued buffers.
> 
> We discussed this last part before, and you had already said you
> prefer this ordering,
> but after you explain it here, the interaction of VIRTIO_GPIO_MSG_SET_IRQ_TYPE
> with queued buffers still seems inconsistent to me: If setting the
> type to none cancels
> any outstanding eventq request, why do newly queued eventq request get added to
> the queue? If we change the order to always require the type to be
> enabled before
> queuing any events, this inconsistency would go away. With the
> behavior of the level
> triggered interrupts changed to fasteoi, do you still see a need to
> keep this ordering?

If you look at the message-flow sequence, I did change it to how you described
above, i.e. the driver enables the interrupt first and then queue the message.

I wasn't sure if we wanted to force it entirely and so kept it like this. But I
think it may be fine that way, so I will change this to mention that if buffers
are received while the interrupt is disabled, then the device should just return
them back unused. That will just make the expectation clear for both device and
driver in this case.

> > +\item In a typical guest operating system kernel, the virtio-gpio driver
> > +    notifies the client driver, that is associated with this gpio line, to
> > +    process the event.
> > +
> > +\item In the case of a level triggered interrupt, the client driver must fully
> > +    process and acknowledge the event at its source to return the line to its
> > +    inactive state.
> > +
> > +\item The driver may again queue, same or new, pair of buffers for that GPIO
> > +    line and notify the device.
> 
> I suggested this bit, but on second thought it still doesn't quite capture the
> important bit that the 'level' line has to be set to low /before/ the new buffer
> gets queued (to avoid a spurious notification).

I find the second item above say exactly the same thing. It says for level
triggered interrupted, line must return to inactive state.

> Otherwise there is no difference
> between edge and level interrupts, obviously in both cases the interrupt
> has to be processed eventually.

-- 
viresh

