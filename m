Return-Path: <viresh.kumar@linaro.org>
Date: Thu, 14 Oct 2021 15:55:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V9] virtio-gpio: Add support for interrupts
Message-ID: <20211014102536.yoh4czkikw63cmoz@vireshk-i7>
References: <ed36fcb94f33cf27106b6ea0a555f71400d27ade.1634022690.git.viresh.kumar@linaro.org>
 <87o87rvrry.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87o87rvrry.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, stratos-dev@op-lists.linaro.org, Kent Gibson <warthog618@gmail.com>, Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On 14-10-21, 12:12, Cornelia Huck wrote:
> What triggers the device to configure the GPIO lines in that state? Is
> that something that it should already do when it decides to offer the
> feature bit?

Yes, it should be the state before negotiations start.

-- 
viresh

