Return-Path: <virtio-dev-return-8407-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7193F98622C
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Jul 2021 10:57:47 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <CAK8P3a0ZnsOii_0HxDtbd4LcjjK29vxfCH1Kuw-wk12jPbDAXA@mail.gmail.com>
References: <cover.1626794843.git.viresh.kumar@linaro.org>
 <199c624bd735782dd5d4a51e376f466f5c38ef2c.1626794843.git.viresh.kumar@linaro.org>
 <CAK8P3a0PtwUMD0RRpmaXitfpUJ+OiayMMLx-4a=LnokSs4gPnA@mail.gmail.com>
 <20210726101653.5mjypnnv6rib4hon@vireshk-i7>
 <CAK8P3a3MFSkYzVY3TZ+F56KwM+ncEtin9pQFqfR1q_-MLJvmew@mail.gmail.com>
 <20210727075545.cq6lb7vsg4pdygtm@vireshk-i7>
 <CAK8P3a0ZnsOii_0HxDtbd4LcjjK29vxfCH1Kuw-wk12jPbDAXA@mail.gmail.com>
Date: Tue, 27 Jul 2021 12:57:37 +0200
Message-ID: <87tukg3ty6.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH V6 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain
To: Arnd Bergmann <arnd@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico
 Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 27 2021, Arnd Bergmann <arnd@kernel.org> wrote:

> On Tue, Jul 27, 2021 at 9:55 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 26-07-21, 13:28, Arnd Bergmann wrote:
>> > On Mon, Jul 26, 2021 at 12:16 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>

[Disclaimer: I basically don't know anything about gpio]

>> > > > I have a question here, not sure if this needs to be answered in the spec: why
>> > > > can't the driver send activate, set-direction and set-value all at
>> > > > once for a line?
>> > > > Clearly if one request fails, the later ones would fail as well in
>> > > > this example, but
>> > > > I don't see this as a problem for either side.
>> >
>> > > Merging activate along with that would mean, that the host needs to keep
>> > > a reference count at its end to activate the line on the first call to
>> > > set-value, but not on others.
>> >
>> > My question here was about something else, to rephrase: Can't we allow
>> > the driver to queue multiple requests for one line and then have the device
>> > process them in order (regardless of whether it processes requests
>> > for other lines in parallel). The sequence I had in mind here was
>> >
>> > driver:
>> >     1. queue enable
>> >     2. queue set-direction
>> >     3. queue set-value
>> >     4. notify device
>> > device:
>> >     5. process enable
>> >     6. queue enable-response
>> >     7. process set-direction
>> >     8. queue set-direction response
>> >     9. process set-value
>> >     10. queue set-value response
>> >     11. notify driver
>> > driver:
>> >      12. mark all requests as done

What are the ordering/sequence requirements here? E.g., are
enable/set-direction or enable/set-value/set-direction valid sequences?

If we consider the sequence 1-4 above as a command chain, what about
adding a chaining field that can point to the next command in the chain?
The driver would build the chain in one go, the device would process the
chain one after another, and stop if it encounters an error. The driver
would be free to submit chains for other lines, but not another one for
the same line as long as the current chain is not yet finished.

[Yes, I realize that this looks a lot like channel I/O...]

>>
>> Hmm, we can do that in principle by saying all requests for a
>> particular line must be served in order. But right now I have rather
>> limited the number of requests per line to 1 for a reason, i.e. there
>> will always be a single user of a GPIO line at any point of time. And
>> so the operations will always be sequential.
>>
>> If you look at users of GPIO, lets say in kernel for now, they all use
>> generic APIs like request, set-direction, set-value, etc. There is no
>> fixed order of how the different callbacks will be called by the user,
>> and so we will never get the requests in bulk or groups (like you
>> mentioned above). Each operation has its own significance, and it
>> won't be right to return from, lets say gpio_set_value(), without
>> getting the result of the operation.

You could match this to individual chains of length one, where you
cannot submit another request for a line before the current one is
finished.

>>
>> So when can something like this, what you showed above, can be useful
>> ?
>
> Maybe this is something we can get advice for from the virtio
> maintainers. It was just a feeling on my side that slightly relaxing
> the requirement makes this more like other virtio drivers.
>
> Functionally, I think there is no difference between mandating that the
> driver only queues one request per gpio line over requiring that the
> device processes all requests on a gpio line in sequence, but the
> latter can be slightly more efficient.

It might be worth considering for future drivers, or non-Linux drivers.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

