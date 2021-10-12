Return-Path: <virtio-dev-return-8840-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B8A84986410
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Oct 2021 07:51:28 +0000 (UTC)
MIME-Version: 1.0
References: <ed36fcb94f33cf27106b6ea0a555f71400d27ade.1634022690.git.viresh.kumar@linaro.org>
In-Reply-To: <ed36fcb94f33cf27106b6ea0a555f71400d27ade.1634022690.git.viresh.kumar@linaro.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 12 Oct 2021 09:51:09 +0200
Message-ID: <CAK8P3a2UcbjcB1qDEe7XGAPRwdg8c=SnjfHAwri6frx5Mf1fNQ@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH V9] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Kent Gibson <warthog618@gmail.com>, Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Oct 12, 2021 at 9:16 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This patch adds support for interrupts to the virtio-gpio specification.
> This uses the feature bit 0 for the same.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/114
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This looks good to me overall, I find it very clear in describing the protocol,
and I see no remaining technical issues.

Marc had a number of concerns with the older versions, so I think he
needs to see if you have addressed those as well.

I think we need a little bit of copy-editing on some of the sentences, but
I'm not commenting on those as I'm not a native English speaker.

There is one bit that I would change, and I think we have discussed
it in the past, but I don't remember the reasoning here:

> +When the interrupt is disabled by the driver, by setting the trigger type to
> +\field{VIRTIO_GPIO_IRQ_TYPE_NONE}, the device should return any unused pair of
> +buffers for the GPIO line, over the \field{eventq} virtqueue, after setting the
> +\field{status} field to \field{VIRTIO_GPIO_IRQ_STATUS_INVALID}. This also masks
> +the interrupt.
> +
> +The driver can enable and unmask the interrupt in any order, i.e. it can enable
> +the interrupt first and then queue the buffers or queue the buffers first and
> +then enable the interrupt.

This should work fine, but it seems odd that this is asymmetric between
enable/unmask and disable/mask. My feeling is that it would be more consistent
if you also require the "enable" to happen before "unmask" to limit the number
possible states that the irq line can be in.

Do you have a particular use case in mind that would benefit from first
queuing the event request and then enabling the line? I see you listed
this as one of the things you changed in v9, but I don't remember for
what reason. Your "eventq Operation: Message Flow" section only
describes one of the two allowed cases here, and I think it's the one
we want anyway.

        Arnd

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

