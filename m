Return-Path: <viresh.kumar@linaro.org>
Date: Mon, 2 Aug 2021 11:24:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V8 2/2] virtio-gpio: Add support for interrupts
Message-ID: <20210802055416.v67gdafcqslw53lt@vireshk-i7>
References: <cover.1627627021.git.viresh.kumar@linaro.org>
 <33671b4e543557740acf85bc30ed8ad1ba9ef8aa.1627627021.git.viresh.kumar@linaro.org>
 <87a6m42ngf.wl-maz@kernel.org>
 <CAK8P3a2pMUpLUFFA62pTcH9LBYfo1g+gYGkqDxmBjUfQA2Uong@mail.gmail.com>
 <87v94q25iu.wl-maz@kernel.org>
 <CAK8P3a2Rz_HGVYG7n6stn06ws521VSTgagBvz__2Kh8ho0FDXA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2Rz_HGVYG7n6stn06ws521VSTgagBvz__2Kh8ho0FDXA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On 01-08-21, 15:43, Arnd Bergmann wrote:
> On Sat, Jul 31, 2021 at 11:31 AM Marc Zyngier <maz@kernel.org> wrote:
> > Is there any sample code we could look at, both got guest and host?
> 
> Viresh said that he is close to sending it after updating the code
> to the latest spec.

I am close to sending code for the guest, but it will take time to get it done
for the host (I am going to do a Rust implementation for the same).

-- 
viresh

