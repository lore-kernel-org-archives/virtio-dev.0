Return-Path: <viresh.kumar@linaro.org>
Date: Thu, 29 Jul 2021 09:14:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V7 1/2] virtio-gpio: Add the device specification
Message-ID: <20210729034413.yhc6bxkzefqxnnka@vireshk-i7>
References: <cover.1627469463.git.viresh.kumar@linaro.org>
 <056d54eae73a353b33b5319acd1b948c8f7aad93.1627469463.git.viresh.kumar@linaro.org>
 <CAK8P3a01zz0fgZ0mZsC=xqEEdgRjy511nfBC2D5=ziWqgEd8Mg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a01zz0fgZ0mZsC=xqEEdgRjy511nfBC2D5=ziWqgEd8Mg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 28-07-21, 13:26, Arnd Bergmann wrote:
> I think the structure layout here is good, but I wonder if the
> description would be clearer
> if you define two separate structures, with a fixed-length structure for normal
> requests, and the variable-length structure for VIRTIO_GPIO_MSG_GET_LINE_NAMES.

Sure.

-- 
viresh

