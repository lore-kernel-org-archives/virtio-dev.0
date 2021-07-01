Return-Path: <virtio-comment-return-1922-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Resent-Message-ID: <20210701093253.wcsamlaz5jtjvkr2@vireshk-i7>
Resent-To: virtio-comment@lists.oasis-open.org
MIME-Version: 1.0
References: <20210630115837.12182-1-info@metux.net> <20210630152213.xhqhke54gzt3esdj@vireshk-i7>
 <641254c3-d60d-eb17-7388-29dd9ebcb826@metux.net> <20210630173022.7ukqg764z5xi5uho@vireshk-i7>
In-Reply-To: <20210630173022.7ukqg764z5xi5uho@vireshk-i7>
From: Arnd Bergmann <arnd@linaro.org>
Date: Thu, 1 Jul 2021 11:01:52 +0200
Message-ID: <CAK8P3a05SFQ2Vo_CjoC4kaxfz0jwj_K9ogfLw00rRim9EMZtnQ@mail.gmail.com>
Subject: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [PATCH v2] virtio-gpio: add
 formal specification
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Enrico Weigelt, metux IT consult" <lkml@metux.net>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Vincent Guittot <vincent.guittot@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Wang <jasowang@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jun 30, 2021 at 7:30 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 30-06-21, 17:55, Enrico Weigelt, metux IT consult wrote:
> > On 30.06.21 17:22, Viresh Kumar wrote:
> > > + All the people from previous version (Please cc them yourself while sending a
> > > new version, these are the people interested in this stuff).
>
> Adding them again, not sure why they got dropped after your email.

Thanks.

> > > I don't see the improvements suggested for the config structure, nothing about
> > > features, no interrupt support. You just reformatted the stuff and that's all.
> >
> > Don't worry, I haven't forgotten that. But that's something I'd *really*
> > like to have as optional features (so not all hardware is mandated to
> > implement that all) and i'd like to get the mandatory base finished,
> > before specifying the optional features like interrupt controller.
> >
> > Let's discuss the optional features separately, feel free to share your
> > thoughts here.
>
> What about the changes to the config structure to make it efficient,
> easily extendable, etc Or the Free Msg, etc? These views are already
> shared in details for the earlier version and I shouldn't be expected
> to explain them again.
>
> Over that, if you don't want to implement interrupts in your version
> (I can surely send a patch for that), then you need to drop the
> half-hearted interrupt support, i.e.  VIRTIO_GPIO_MSG_DEVICE_LEVEL, as
> that is not the right way of implementing interrupts. This will make
> the specification as well as Linux or backend code messy, as we would
> be required to support interrupts in two ways in this case based on
> irq-feature. If you want to support interrupts, then you need to do
> them properly, else don't add them at all.

Agreed, interrupt support is obviously something that can not be
retrofitted easily if you don't get it right from the start.

> Please reply to the issues raised in the previous version itself now
> and close them there. And please don't proceed with a new version
> unless there is a clear consensus in favor or otherwise. It just ends
> up wasting a lot of time for everyone.

+1

      Arnd

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

