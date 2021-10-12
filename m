Return-Path: <viresh.kumar@linaro.org>
Date: Tue, 12 Oct 2021 14:03:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V9] virtio-gpio: Add support for interrupts
Message-ID: <20211012083307.rwozwxyzw4jabsue@vireshk-i7>
References: <ed36fcb94f33cf27106b6ea0a555f71400d27ade.1634022690.git.viresh.kumar@linaro.org>
 <CAK8P3a2UcbjcB1qDEe7XGAPRwdg8c=SnjfHAwri6frx5Mf1fNQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2UcbjcB1qDEe7XGAPRwdg8c=SnjfHAwri6frx5Mf1fNQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Kent Gibson <warthog618@gmail.com>, Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On 12-10-21, 09:51, Arnd Bergmann wrote:
> This looks good to me overall, I find it very clear in describing the protocol,
> and I see no remaining technical issues.

To me as well. Marc's comments really helped to simplify it.

> > +The driver can enable and unmask the interrupt in any order, i.e. it can enable
> > +the interrupt first and then queue the buffers or queue the buffers first and
> > +then enable the interrupt.
> 
> This should work fine, but it seems odd that this is asymmetric between
> enable/unmask and disable/mask. My feeling is that it would be more consistent
> if you also require the "enable" to happen before "unmask" to limit the number
> possible states that the irq line can be in.

If you look at a regular IP block (GPIO or GIC, etc) which exposes
registers for enable/disable and mask/unmask, then normally they won't
have any constraints on what needs to be done first enable or unmask.
Both have different purposes and can be handled (and must be) handled
separately. The same should apply here as well.

> Do you have a particular use case in mind that would benefit from first
> queuing the event request and then enabling the line?

If you look at the proposed Linux implementation [1], I have done
exactly this as it makes the code simpler to write since some of the
part (enabling from bus-unlock) happens at a later time (once we are
in non-atomic context).

> I see you listed
> this as one of the things you changed in v9, but I don't remember for
> what reason. Your "eventq Operation: Message Flow" section only
> describes one of the two allowed cases here, and I think it's the one
> we want anyway.

Quite the opposite as per the current proposal :)

And so I thought it is better to keep these two orthogonal to each
other with no hard limits. Just like what a normal IP would do.

--
Viresh

[1] https://lore.kernel.org/linux-gpio/96223fb8143a4eaa9b183d376ff46e5cd8ef54b4.1628590591.git.viresh.kumar@linaro.org/

