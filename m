Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1626794843.git.viresh.kumar@linaro.org> <199c624bd735782dd5d4a51e376f466f5c38ef2c.1626794843.git.viresh.kumar@linaro.org>
 <CAK8P3a0PtwUMD0RRpmaXitfpUJ+OiayMMLx-4a=LnokSs4gPnA@mail.gmail.com>
 <20210726101653.5mjypnnv6rib4hon@vireshk-i7> <CAK8P3a3MFSkYzVY3TZ+F56KwM+ncEtin9pQFqfR1q_-MLJvmew@mail.gmail.com>
 <20210727075545.cq6lb7vsg4pdygtm@vireshk-i7> <CAK8P3a0ZnsOii_0HxDtbd4LcjjK29vxfCH1Kuw-wk12jPbDAXA@mail.gmail.com>
 <20210727105631.njv2wh2jvclbld56@vireshk-i7> <CAK8P3a0ZMW+PcmXShNdgtVog_vNipF5xMLGBHqZFLQPoqxrzMg@mail.gmail.com>
 <CAKohponT-XW5WbdJ6Bx_h5faw7GOcSiT8RxHy44hHExB0vV=Xw@mail.gmail.com> <CAKohponHYoeMrUrmAJhjfV3ra_R4R7cskwc3rVeEQ15DPrfoNw@mail.gmail.com>
In-Reply-To: <CAKohponHYoeMrUrmAJhjfV3ra_R4R7cskwc3rVeEQ15DPrfoNw@mail.gmail.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 27 Jul 2021 16:38:27 +0200
Message-ID: <CAK8P3a3Rw65Cu4C9XrrxCza0e3s64iPXLENfdpmZ8kw3YQ4G_w@mail.gmail.com>
Subject: Re: [PATCH V6 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 27, 2021 at 4:20 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> So making it per-line doesn't give us any flexibility that we may be
> looking for.

I was not really looking for extra flexibility here, only for a simpler and
more consistent interface definition. But if the simpler interface comes
at the cost of more complexity and time overhead in the driver, it's
probably not worth it.

      Arnd

