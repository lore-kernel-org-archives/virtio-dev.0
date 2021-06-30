Return-Path: <virtio-comment-return-1921-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 30 Jun 2021 23:00:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Message-ID: <20210630173022.7ukqg764z5xi5uho@vireshk-i7>
References: <20210630115837.12182-1-info@metux.net>
 <20210630152213.xhqhke54gzt3esdj@vireshk-i7>
 <641254c3-d60d-eb17-7388-29dd9ebcb826@metux.net>
MIME-Version: 1.0
In-Reply-To: <641254c3-d60d-eb17-7388-29dd9ebcb826@metux.net>
Subject: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [PATCH v2] virtio-gpio: add
 formal specification
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Vincent Guittot <vincent.guittot@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Wang <jasowang@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Arnd Bergmann <arnd@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 30-06-21, 17:55, Enrico Weigelt, metux IT consult wrote:
> On 30.06.21 17:22, Viresh Kumar wrote:
> > + All the people from previous version (Please cc them yourself while sending a
> > new version, these are the people interested in this stuff).

Adding them again, not sure why they got dropped after your email.

> Phuh, it's hard to track them all. I'm assuming everybody interested in
> this is already on the list or can easily subscribe :p

Not necessarily.

I don't expect others, specially the GPIO maintainers or Arnd, to have
subscribed to these lists (and many times people try to subscribe to
lists with no-email option, so their reply can reach to everyone,
while don't want unnecessary emails).

If you are using git to send emails, then an easy way out is to create
an alias for GPIO and have all the interested folks in cc.

It is important to keep few of the people in cc list here.

> > What happened to all the detailed discussions that we went through ? Why did we
> > spend so much time discussing all that when you didn't had to take suggestions
> > from the reviews provided on the list?
> 
> Which ones are missing, besides those that we talked about doing as
> optional feature (like irq controller, etc). Please let's do that in
> separate rounds - the minimal base spec first, and then add optional
> features.

You must have closed the discussion first in the previous version
itself in that case.

> > I don't see the improvements suggested for the config structure, nothing about
> > features, no interrupt support. You just reformatted the stuff and that's all.
> 
> Don't worry, I haven't forgotten that. But that's something I'd *really*
> like to have as optional features (so not all hardware is mandated to
> implement that all) and i'd like to get the mandatory base finished,
> before specifying the optional features like interrupt controller.
> 
> Let's discuss the optional features separately, feel free to share your
> thoughts here.

What about the changes to the config structure to make it efficient,
easily extendable, etc Or the Free Msg, etc? These views are already
shared in details for the earlier version and I shouldn't be expected
to explain them again.

Over that, if you don't want to implement interrupts in your version
(I can surely send a patch for that), then you need to drop the
half-hearted interrupt support, i.e.  VIRTIO_GPIO_MSG_DEVICE_LEVEL, as
that is not the right way of implementing interrupts. This will make
the specification as well as Linux or backend code messy, as we would
be required to support interrupts in two ways in this case based on
irq-feature. If you want to support interrupts, then you need to do
them properly, else don't add them at all.

Please reply to the issues raised in the previous version itself now
and close them there. And please don't proceed with a new version
unless there is a clear consensus in favor or otherwise. It just ends
up wasting a lot of time for everyone.

I asked for a new version today as I expected you to have made all the
changes based on suggestions, where you haven't had a last say.

-- 
viresh

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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

