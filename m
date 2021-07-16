Return-Path: <viresh.kumar@linaro.org>
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org> <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
 <CAK8P3a0jRnxz6-WTmWyA04H2B+KP0AQ_7G6RyBqecKa8Xp37rA@mail.gmail.com>
 <CAKohponTstJF108wtSpGWYy0xETh6AzGaesjREGDKav5Yyy06g@mail.gmail.com> <CAK8P3a1G3OO19nnL19B1sU5PBgRpk3eGPZKXz7j55=X+ngNggg@mail.gmail.com>
In-Reply-To: <CAK8P3a1G3OO19nnL19B1sU5PBgRpk3eGPZKXz7j55=X+ngNggg@mail.gmail.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 16 Jul 2021 22:20:19 +0530
Message-ID: <CAKohpo=6Ntb7qgu6T1TOfUYYQVxnhc2DZcgn6TPJEY-_27RW0w@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH V5 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 16 Jul 2021 at 21:49, Arnd Bergmann <arnd@kernel.org> wrote:
> On Fri, Jul 16, 2021 at 5:17 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On Fri, 16 Jul 2021 at 14:33, Arnd Bergmann <arnd@kernel.org> wrote:

> > > Is there a way for the driver to know which trigger types are supported on
> > > a given line? If not, would that be useful, or do we assume that this
> > > knowledge exists in the place that sets the trigger type based on e.g.
> > > device tree data?

And I understood it now only :(

I am not sure if this kind of per-line info would be really useful,
and I now doubt
if we should have a config structure field for the entire GPIO block
or not. i.e.
something that conveys the trigger types for entire GPIO device.

> What I meant is that the guest OS kernel would only ever set a trigger
> type that makes sense based on what the device on the other end of
> the GPIO line needs, and this would be encoded in the interrupt-cells.

Thanks for explaining again.

> Ok, let's see what they think. I would have found this less confusing if
> you just describe what message the driver sends and how the device
> responds to it.

I did add that kind of information in the tables for each of the message types,
maybe they weren't that readable in the text version.

Here is an example of it:

+\begin{tabular}{ |l||l|l|l| }
+\hline
+Fields & \field{type} & \field{gpio} & \field{value} \\
+\hline
+Message & \field{VIRTIO_GPIO_MSG_GET_DIRECTION} & line number & 0 \\
+\hline
+Response & \field{VIRTIO_GPIO_MSG_GET_DIRECTION} \newline |
\field{VIRTIO_GPIO_MSG_RESPONSE} & line number & 0 = output, 1 =
input, \newline or -errno = failure \\
+\hline
+\end{tabular}

The driver sends a message with "type" VIRTIO_GPIO_MSG_GET_DIRECTION and
the device responds with a buffer with "type" field set to
VIRTIO_GPIO_MSG_GET_DIRECTION | VIRTIO_GPIO_MSG_RESPONSE and
the direction set in the "value" field.

> > Yes, and the driver also needs to add buffers here for receiving response to
> > the messages initiated by the driver.
>
> Ok, I think that needs to be made clearer here. I'm still not sure I have
> understood exactly what messages you

Will work on that.

> > The device MUST not send another irq request for the same GPIO line, until
> > the time it has received a response from the driver. Once the response has
> > arrived at the device, it can raise the interrupt again if the level
> > interrupt is still active.
>
> The part about not sending another interrupt is the easy part. What I mean is
> what happens if another edge event comes into the gpio controller before the
> driver responds. Does the device immediately send another interrupt message
> or does it skip that?

Hmm, what should it do in that case ? What do we do in kernel for this ? I think
maybe we should accumulate the interrupts in that period of time and send only
the last one ?

Also will it make sense to send the trigger-type information to the driver on an
interrupt? For example a user may have programmed a line for both edge trigger
interrupts. Should we send info about which edge it is, rising or falling ?

> I'm not sure it's helpful to describe the protocol as symmetric when neither
> the virtqueue below it nor the idea of a gpio controller is symmetric.
>
> I think a better way to describe it would be request/response pairs where
> the driver asks for something to be done and it gets an immediate response,
> as opposed to long-running event notifications where the driver queues
> up a descriptor and it only completes when an interrupt happens.

Yes, I think it would be better to bind the request/response messages together.
I will see if that will work fine or not before confirming.

--
Viresh

