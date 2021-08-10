Return-Path: <virtio-dev-return-8512-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 65F36986260
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Aug 2021 09:58:25 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <cb15de92f8cb840204a945ae643c14700b567600.1628492314.git.viresh.kumar@linaro.org>
References: <cb15de92f8cb840204a945ae643c14700b567600.1628492314.git.viresh.kumar@linaro.org>
Date: Tue, 10 Aug 2021 11:58:13 +0200
Message-ID: <87k0ktwrii.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH V9] virtio-gpio: Add the device specification
Content-Type: text/plain
To: Viresh Kumar <viresh.kumar@linaro.org>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT
 consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, stratos-dev@op-lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Aug 09 2021, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> virtio-gpio is a virtual GPIO controller. It provides a way to flexibly
> communicate with the host GPIO controllers from the guest.
>
> Note that the current implementation doesn't provide atomic APIs for
> GPIO configurations. i.e. the driver (guest) would need to implement
> sleep-able versions of the APIs as the guest will respond asynchronously
> over the virtqueue.
>
> This patch adds the specification for it.
>
> Based on the initial work posted by:
> "Enrico Weigelt, metux IT consult" <lkml@metux.net>.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/110
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V8->V9:
> - Dropped few occurrences of "MUST" from non-normative statements.
> - Send the patch for base GPIO specifications separately, so it can get merged
>   first while the IRQ support is still discussed.
>
> Here is the previous version:
>
> https://lists.oasis-open.org/archives/virtio-dev/202107/msg00232.html
>
>  conformance.tex |  28 +++-
>  content.tex     |   1 +
>  virtio-gpio.tex | 346 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 371 insertions(+), 4 deletions(-)
>  create mode 100644 virtio-gpio.tex

Thanks, this looks good to me now.

I'll go ahead and initiate a vote.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

