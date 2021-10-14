Return-Path: <virtio-dev-return-8874-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 793D898647C
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Oct 2021 10:42:58 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20211014102536.yoh4czkikw63cmoz@vireshk-i7>
References: <ed36fcb94f33cf27106b6ea0a555f71400d27ade.1634022690.git.viresh.kumar@linaro.org>
 <87o87rvrry.fsf@redhat.com> <20211014102536.yoh4czkikw63cmoz@vireshk-i7>
Date: Thu, 14 Oct 2021 12:42:46 +0200
Message-ID: <87lf2vvqe1.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH V9] virtio-gpio: Add support for interrupts
Content-Type: text/plain
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT
 consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, stratos-dev@op-lists.linaro.org, Kent Gibson <warthog618@gmail.com>, Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Oct 14 2021, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 14-10-21, 12:12, Cornelia Huck wrote:
>> What triggers the device to configure the GPIO lines in that state? Is
>> that something that it should already do when it decides to offer the
>> feature bit?
>
> Yes, it should be the state before negotiations start.

Ok, so it probably doesn't belong into the startup sequence... I guess
it is already clear that this is the default state? If not, is a
statement needed to describe that?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

