Return-Path: <viresh.kumar@linaro.org>
MIME-Version: 1.0
References: <cover.1626418779.git.viresh.kumar@linaro.org> <4bb66b16dc261acf9d40517c8b7961a52212086b.1626418779.git.viresh.kumar@linaro.org>
 <CAMuHMdW+xXBbqc5nYjQyUwuW2VDAawiAGA1U+iJ3_jd6pjOkTQ@mail.gmail.com>
In-Reply-To: <CAMuHMdW+xXBbqc5nYjQyUwuW2VDAawiAGA1U+iJ3_jd6pjOkTQ@mail.gmail.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 16 Jul 2021 21:13:51 +0530
Message-ID: <CAKohpokLk3=x5FJSJ+-e37s3LPy01ibyyszeP-3n_=Kda2iMYA@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] virtio-gpio: Add the device specification
Content-Type: text/plain; charset="UTF-8"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 16 Jul 2021 at 14:43, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Is this the standard (virtio) way to define fields like this?
> Personally, I would write "__gpio_names[]", to make it more obvious
> if some code tries to access the field directly.
> Of course the real implementation should provide a macro/function to
> access the names in a safe way.

Looks like this field is going away and we need a separate request for this.

Thanks for taking time to look at this.

--
viresh

