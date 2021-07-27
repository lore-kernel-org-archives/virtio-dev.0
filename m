Return-Path: <viresh.kumar@linaro.org>
Date: Tue, 27 Jul 2021 16:51:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [virtio-dev] Re: [PATCH V6 1/2] virtio-gpio: Add the device
 specification
Message-ID: <20210727112103.rbmeoraspyzkjjn6@vireshk-i7>
References: <cover.1626794843.git.viresh.kumar@linaro.org>
 <199c624bd735782dd5d4a51e376f466f5c38ef2c.1626794843.git.viresh.kumar@linaro.org>
 <CAK8P3a0PtwUMD0RRpmaXitfpUJ+OiayMMLx-4a=LnokSs4gPnA@mail.gmail.com>
 <20210726101653.5mjypnnv6rib4hon@vireshk-i7>
 <CAK8P3a3MFSkYzVY3TZ+F56KwM+ncEtin9pQFqfR1q_-MLJvmew@mail.gmail.com>
 <20210727075545.cq6lb7vsg4pdygtm@vireshk-i7>
 <CAK8P3a0ZnsOii_0HxDtbd4LcjjK29vxfCH1Kuw-wk12jPbDAXA@mail.gmail.com>
 <87tukg3ty6.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87tukg3ty6.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 27-07-21, 12:57, Cornelia Huck wrote:
> On Tue, Jul 27 2021, Arnd Bergmann <arnd@kernel.org> wrote:
> >> > driver:
> >> >     1. queue enable
> >> >     2. queue set-direction
> >> >     3. queue set-value
> >> >     4. notify device
> >> > device:
> >> >     5. process enable
> >> >     6. queue enable-response
> >> >     7. process set-direction
> >> >     8. queue set-direction response
> >> >     9. process set-value
> >> >     10. queue set-value response
> >> >     11. notify driver
> >> > driver:
> >> >      12. mark all requests as done
> 
> What are the ordering/sequence requirements here? E.g., are
> enable/set-direction or enable/set-value/set-direction valid sequences?

Yes, these are valid sequences. But there is not real hardfixed way of
doing things here, the users can call them most likely in any order.

> If we consider the sequence 1-4 above as a command chain, what about
> adding a chaining field that can point to the next command in the chain?
> The driver would build the chain in one go, the device would process the
> chain one after another, and stop if it encounters an error. The driver
> would be free to submit chains for other lines, but not another one for
> the same line as long as the current chain is not yet finished.

These commands aren't related necessarily and so this kind of linking
between them is not right. Each operation is really independent from
each other, though the user may not want to initiate the second
operation if the first one fails. This isn't something like I2C
messages, where the first one gives the address and second one gives
something else (like size) and is incomplete without the first one.

Here all instructions is actually independent of each other.

I think Arnd was just thinking of this to make it possible to send
notification only once, if that can give some improvement. But I am
quite sure that Linux today will most likely not end up using it that
way.

> > Maybe this is something we can get advice for from the virtio
> > maintainers. It was just a feeling on my side that slightly relaxing
> > the requirement makes this more like other virtio drivers.
> >
> > Functionally, I think there is no difference between mandating that the
> > driver only queues one request per gpio line over requiring that the
> > device processes all requests on a gpio line in sequence, but the
> > latter can be slightly more efficient.
> 
> It might be worth considering for future drivers, or non-Linux drivers.

Right, as I said in the other email just now, I am fine with allowing
this in spec at least (someone may want to use it later), i.e. queuing
of multiple request for the same GPIO line and them being processed in
the same order.

-- 
viresh

