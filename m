Return-Path: <virtio-comment-return-1923-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20210630115837.12182-1-info@metux.net>
 <20210630152213.xhqhke54gzt3esdj@vireshk-i7>
 <641254c3-d60d-eb17-7388-29dd9ebcb826@metux.net>
 <20210630173022.7ukqg764z5xi5uho@vireshk-i7>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <3be7fbc9-6765-c83a-4340-32ab1b62f132@metux.net>
Date: Thu, 1 Jul 2021 16:21:10 +0200
MIME-Version: 1.0
In-Reply-To: <20210630173022.7ukqg764z5xi5uho@vireshk-i7>
Subject: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [PATCH v2] virtio-gpio: add
 formal specification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: quoted-printable
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Vincent Guittot <vincent.guittot@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Wang <jasowang@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Arnd Bergmann <arnd@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 30.06.21 19:30, Viresh Kumar wrote:

Hi,

> I don't expect others, specially the GPIO maintainers or Arnd, to have
> subscribed to these lists (and many times people try to subscribe to
> lists with no-email option, so their reply can reach to everyone,
> while don't want unnecessary emails).

okay, I'm hereby nominate you for the moderator of this virtual meetting
who takes care of those things :p

> What about the changes to the config structure to make it efficient,
> easily extendable,=20

What exactly are you missing here, that cannot be easily added in future
versions ?

We currently have:

* plenty free bytes
* version field for clear distinction
* config space may be increased later

> etc Or the Free Msg, etc?=20

You mean release a previously requested line ? Yes, that's indeed
slipped through. Sorry about that, and thanks for reminding me.

It really gotten too much and too heated mail traffic, so I lost track
a bit. I believe a good approach for solving those kind of problems is
just keeping a list of open issues and reposting the still remaining
points.

> Over that, if you don't want to implement interrupts in your version
> (I can surely send a patch for that), then you need to drop the
> half-hearted interrupt support, i.e.  VIRTIO_GPIO_MSG_DEVICE_LEVEL, as
> that is not the right way of implementing interrupts.=20

This is message is an signal that tells the level has changed and what
the new level is. It is just an event. If you wanna use that event as
an interrupt source, it naturally fits an edge interrupt.

Note that we're still talking about an gpio controller, not an interrupt
controller. The gpio controller signals when something happened on some
input, and it even tells it along with that signal, no explicit readout
required (as on traditional controllers).

Masking out unintersting events is a more sophisticated functionality
(which needs lots of more gates in HW). Certainly good to have, but
that really shouldn't be mandatory for all. That's why I've explicitly
planned that as an *optional* feature (means: controller announces that
in a dedicated feature bit).

> This will make the specification as well as Linux or backend code messy,=
=20
> as we would be required to support interrupts in two ways in this case=20
> based on irq-feature.

Why so ? If HW has the IRQ controller feature bit set, we send the
mask / unmask messages, otherwise we don't. Will be a simple 'if'
statement in virtio_gpio_irq_mask() / virtio_gpio_irq_unmask(). Two
extra lines in each function.


--mtx

--=20
---
Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt und=
 manipuliert
werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schl=C3=BCssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

