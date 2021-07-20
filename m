Return-Path: <viresh.kumar@linaro.org>
Date: Tue, 20 Jul 2021 12:41:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [virtio-dev] Re: [PATCH V5 2/2] virtio-gpio: Add support for
 interrupts
Message-ID: <20210720071149.inex3wzdgrwrvlgw@vireshk-i7>
References: <cover.1626418779.git.viresh.kumar@linaro.org>
 <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
 <CAK8P3a0jRnxz6-WTmWyA04H2B+KP0AQ_7G6RyBqecKa8Xp37rA@mail.gmail.com>
 <CAKohponTstJF108wtSpGWYy0xETh6AzGaesjREGDKav5Yyy06g@mail.gmail.com>
 <CAK8P3a1G3OO19nnL19B1sU5PBgRpk3eGPZKXz7j55=X+ngNggg@mail.gmail.com>
 <CAKohpo=6Ntb7qgu6T1TOfUYYQVxnhc2DZcgn6TPJEY-_27RW0w@mail.gmail.com>
 <CAK8P3a0AH0dAkCtvZNtP3JJ=XVi9ybw=cTVw0C9yS2Vf0yKf8Q@mail.gmail.com>
 <20210720054753.cmhrsdcmvpcxg3ed@vireshk-i7>
 <CAK8P3a1zxiWE_yTWQWdMerJpLmYJLjZVpztze_B-yBJuO=B5Ow@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1zxiWE_yTWQWdMerJpLmYJLjZVpztze_B-yBJuO=B5Ow@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 20-07-21, 09:01, Arnd Bergmann wrote:
> That's what I was hoping for, I'm just not sure if this is required
> by the virtio spec or just the usual implementation of the device
> side. Have you found a section in the spec that guarantees that
> the virtqueue_kick() serves as a sufficient barrier that the driver
> can rely on the information having arrived?

This is what the spec say about it:

https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html#x1-9000023

> Ok, in that case I guess the requeue has to be deferred, which may
> rule out everything other than the fasteoi method.

True.

> I meant the notification from device to driver that an event has
> happened.

Yeah, I understood it later.

-- 
viresh

