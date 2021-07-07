Return-Path: <viresh.kumar@linaro.org>
Date: Wed, 7 Jul 2021 10:34:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [virtio-dev] Re: [virtio-comment] [PATCH v2] virtio-gpio: add
 formal specification
Message-ID: <20210707050421.dedvvsutosz6gyck@vireshk-i7>
References: <20210630115837.12182-1-info@metux.net>
 <20210630152213.xhqhke54gzt3esdj@vireshk-i7>
 <641254c3-d60d-eb17-7388-29dd9ebcb826@metux.net>
 <20210630173022.7ukqg764z5xi5uho@vireshk-i7>
 <CAK8P3a05SFQ2Vo_CjoC4kaxfz0jwj_K9ogfLw00rRim9EMZtnQ@mail.gmail.com>
 <d4862fc4-97aa-a1a3-ef21-8c18cc3681b4@metux.net>
 <20210701165141.nuj4hmqfuby6hxlc@vireshk-i7>
MIME-Version: 1.0
In-Reply-To: <20210701165141.nuj4hmqfuby6hxlc@vireshk-i7>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@linaro.org>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Vincent Guittot <vincent.guittot@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Wang <jasowang@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 01-07-21, 22:21, Viresh Kumar wrote:
> On 01-07-21, 16:43, Enrico Weigelt, metux IT consult wrote:
> > On 01.07.21 11:01, Arnd Bergmann wrote:
> > 
> > > Agreed, interrupt support is obviously something that can not be
> > > retrofitted easily if you don't get it right from the start.
> > 
> > It's basically present, the basic version (as now writting in this spec)
> > just can't do hardware masking - that part is planned as an optional
> > feature (which I haven't yet put into that spec version, since I wanted
> > to get the basic version finished up before doing the optional
> > features).
> 
> Finally you called it interrupt :)
> 
> > Actually, the optional feature will just add another message for
> > mask/unmask. I'll yet having conversations w/ HW engineers on certain
> > aspects, e.g. automatic masking (yes/no/configurable ?).
> 
> An interrupt should never occur unless asked for. Here is an example
> of how this is BROKEN right now.
> 
> Lets say the host passes 32 gpio lines to guest, guest moves them in
> input mode (some user requested for them) and then frees the gpio
> lines.
> 
> At this point there are no users of the GPIO block in the guest OS,
> but the virtio traffic will continue for the interrupts, as the host
> will keep sending the GPIO status changes to the guest.
> 
> This is simply BROKEN and NOT acceptable.
> 
> If you want to implement interrupts, then add them in a separate
> feature or just don't. Partial implementations aren't going to work.

Will it be possible to move this stuff a bit faster? We are still where
we were in December last year. Not a lot has changed.

We have future work blocked because of this, Linux driver and generic Backend
implementation (and their users later on), etc.

We really need to move it forward.

Thanks.

-- 
viresh

