Return-Path: <virtio-dev-return-8224-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6910A9863C4
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Jul 2021 16:51:46 +0000 (UTC)
Date: Thu, 1 Jul 2021 22:21:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Message-ID: <20210701165141.nuj4hmqfuby6hxlc@vireshk-i7>
References: <20210630115837.12182-1-info@metux.net>
 <20210630152213.xhqhke54gzt3esdj@vireshk-i7>
 <641254c3-d60d-eb17-7388-29dd9ebcb826@metux.net>
 <20210630173022.7ukqg764z5xi5uho@vireshk-i7>
 <CAK8P3a05SFQ2Vo_CjoC4kaxfz0jwj_K9ogfLw00rRim9EMZtnQ@mail.gmail.com>
 <d4862fc4-97aa-a1a3-ef21-8c18cc3681b4@metux.net>
MIME-Version: 1.0
In-Reply-To: <d4862fc4-97aa-a1a3-ef21-8c18cc3681b4@metux.net>
Subject: Re: [virtio-dev] Re: [virtio-comment] [PATCH v2] virtio-gpio: add
 formal specification
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: Arnd Bergmann <arnd@linaro.org>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Vincent Guittot <vincent.guittot@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Wang <jasowang@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 01-07-21, 16:43, Enrico Weigelt, metux IT consult wrote:
> On 01.07.21 11:01, Arnd Bergmann wrote:
> 
> > Agreed, interrupt support is obviously something that can not be
> > retrofitted easily if you don't get it right from the start.
> 
> It's basically present, the basic version (as now writting in this spec)
> just can't do hardware masking - that part is planned as an optional
> feature (which I haven't yet put into that spec version, since I wanted
> to get the basic version finished up before doing the optional
> features).

Finally you called it interrupt :)

> Actually, the optional feature will just add another message for
> mask/unmask. I'll yet having conversations w/ HW engineers on certain
> aspects, e.g. automatic masking (yes/no/configurable ?).

An interrupt should never occur unless asked for. Here is an example
of how this is BROKEN right now.

Lets say the host passes 32 gpio lines to guest, guest moves them in
input mode (some user requested for them) and then frees the gpio
lines.

At this point there are no users of the GPIO block in the guest OS,
but the virtio traffic will continue for the interrupts, as the host
will keep sending the GPIO status changes to the guest.

This is simply BROKEN and NOT acceptable.

If you want to implement interrupts, then add them in a separate
feature or just don't. Partial implementations aren't going to work.

I don't really understand what's the big deal about it, though...

> There're also other more sophisticated features like HW debounce,
> pinmux, etc, that are to come later - as *optional* features that some
> device may or may not support.
> 
> Note that this isn't just about moving drivers into some VMM, but also
> about actual hardware.

... I do understand why you are so adamant on not changing this. And
lemme say this again for clarity.

We are not going to write a new protocol in a BUGGY way, because some
existing hardware implements it in a BROKEN way. You should have
upstreamed the specification before finalizing the hardware and make
sure such chicken and egg situations do not occur.

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

