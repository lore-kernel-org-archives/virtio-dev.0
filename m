Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org> <54f15944263f4a32e1ea90cd47a45adfa76f260f.1626418779.git.viresh.kumar@linaro.org>
 <CAK8P3a0jRnxz6-WTmWyA04H2B+KP0AQ_7G6RyBqecKa8Xp37rA@mail.gmail.com>
 <CAKohponTstJF108wtSpGWYy0xETh6AzGaesjREGDKav5Yyy06g@mail.gmail.com>
 <CAK8P3a1G3OO19nnL19B1sU5PBgRpk3eGPZKXz7j55=X+ngNggg@mail.gmail.com>
 <CAKohpo=6Ntb7qgu6T1TOfUYYQVxnhc2DZcgn6TPJEY-_27RW0w@mail.gmail.com>
 <CAK8P3a0AH0dAkCtvZNtP3JJ=XVi9ybw=cTVw0C9yS2Vf0yKf8Q@mail.gmail.com>
 <20210720054753.cmhrsdcmvpcxg3ed@vireshk-i7> <CAK8P3a1zxiWE_yTWQWdMerJpLmYJLjZVpztze_B-yBJuO=B5Ow@mail.gmail.com>
 <20210720071149.inex3wzdgrwrvlgw@vireshk-i7>
In-Reply-To: <20210720071149.inex3wzdgrwrvlgw@vireshk-i7>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 20 Jul 2021 09:22:31 +0200
Message-ID: <CAK8P3a0DbdoJcsxxDX9OgvtmKPhpuYic4FaDUVzDJNFmaWWJsA@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH V5 2/2] virtio-gpio: Add support for interrupts
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 20, 2021 at 9:11 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 20-07-21, 09:01, Arnd Bergmann wrote:
> > That's what I was hoping for, I'm just not sure if this is required
> > by the virtio spec or just the usual implementation of the device
> > side. Have you found a section in the spec that guarantees that
> > the virtqueue_kick() serves as a sufficient barrier that the driver
> > can rely on the information having arrived?
>
> This is what the spec say about it:
>
> https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html#x1-9000023

I don't see it spell out whether this acts as a barrier or not. As far
as I can tell, the notification may be deferred, e.g. if the host is
multi-threaded and virtqueue_kick() needs to send an IPI to another
processor to look at the data.

       Arnd

