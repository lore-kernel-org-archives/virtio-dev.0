Return-Path: <viresh.kumar@linaro.org>
Date: Mon, 2 Aug 2021 16:19:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V8 2/2] virtio-gpio: Add support for interrupts
Message-ID: <20210802104942.ovjnouzourvb7vdd@vireshk-i7>
References: <cover.1627627021.git.viresh.kumar@linaro.org>
 <33671b4e543557740acf85bc30ed8ad1ba9ef8aa.1627627021.git.viresh.kumar@linaro.org>
 <87a6m42ngf.wl-maz@kernel.org>
 <CAK8P3a2pMUpLUFFA62pTcH9LBYfo1g+gYGkqDxmBjUfQA2Uong@mail.gmail.com>
 <87v94q25iu.wl-maz@kernel.org>
 <CAK8P3a2Rz_HGVYG7n6stn06ws521VSTgagBvz__2Kh8ho0FDXA@mail.gmail.com>
 <87r1fc18od.wl-maz@kernel.org>
MIME-Version: 1.0
In-Reply-To: <87r1fc18od.wl-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Marc Zyngier <maz@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Marc,

On 02-08-21, 10:45, Marc Zyngier wrote:
> On Sun, 01 Aug 2021 14:43:37 +0100,
> Arnd Bergmann <arnd@kernel.org> wrote:
> > What are the requirements for a ->irq_mask() operation? Can this
> > be called in atomic context? If it can, is it allowed to be posted
> > (e.g. by queuing a new command without waiting for the reply)?
> 
> irq_mask() can definitely be called in atomic context. But in this
> case the driver must implement the bus_lock madness and commit changes
> to the backend on unlock. See how most of the I2C GPIO implementations
> work.

Right, I already have that in place but I have a few doubts on that.

I can see irq_bus_lock/unlock() getting called around irq_mask/unmask/set_type()
during request_irq(), and so I can issue all the virtio calls from
irq_bus_unlock() there.

But I don't see the same sequence being followed by the irq core when an
interrupt actually happens, i.e. when I call generic_handle_irq() from virtqueue
callback for eventq vq. In this case, the irq core can directly call
mask/unmask() around irq_eoi(), without calling the irq_bus_lock/unlock()
guards.

How should the driver take care of these mask/unmask calls, or should it take
care of it at all, as they should negate each other eventually ?

> Obviously, this has an effect on performance and complexity. It would
> be a lot better if there was a way to perform the mask/unmask
> operations synchronously, without the need of a buffer. For example,
> virtio-console has the so called 'emergency write' feature, which
> allows for write operations without any buffer.

We discussed this sometime back over IRC, and Jean Philippe said this in context
of virtio-iommu:

 "From some profiling the overhead of context switching is much greater than
 that of adding buffers, so adding a new virtio interface to bypass the
 virtqueue might not show any improvement."

We were looking to explore the config space for normal GPIO operations as well
then.

The host would be required to perform some action here on a config update and
the guest would be waiting over an atomic operation for it to complete. So
eventually it should also be slow.

> The later would allow the implementation of a "fire and forget"
> mask/unmask that would still be synchronous.

> > Alternatively, would it be possible to simply emulate the 'irq_mask()'
> > operation in software, by not delivering the next interrupt to the
> > handler until the driver calls irq_unmask()? Once it's been delivered,
> > it would just not get requeued in this case.
> 
> That'd be a poor-man's solution, as you would still get host
> notifications, which could have an impact in the case of a screaming
> interrupt.

Right, irq_bus_unlock() works fine for this though.

-- 
viresh

