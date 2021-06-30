Return-Path: <virtio-dev-return-8209-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D26D59861EA
	for <virtio-dev@lists.oasis-open.org>; Wed, 30 Jun 2021 15:22:17 +0000 (UTC)
Date: Wed, 30 Jun 2021 20:52:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Message-ID: <20210630152213.xhqhke54gzt3esdj@vireshk-i7>
References: <20210630115837.12182-1-info@metux.net>
MIME-Version: 1.0
In-Reply-To: <20210630115837.12182-1-info@metux.net>
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v2] virtio-gpio: add formal specification
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Vincent Guittot <vincent.guittot@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Wang <jasowang@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Arnd Bergmann <arnd@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

+ All the people from previous version (Please cc them yourself while sending a
new version, these are the people interested in this stuff).

On 30-06-21, 13:58, Enrico Weigelt, metux IT consult wrote:
> This patch adds specification for attaching general purpose IO (gpio) devices
> via virtio. The protocol is specifically designed to be easily implemented in
> software (e.g. hypervisors) as well as low end hardware (eg. silicon, FPGA,
> tiny MCUs) and allows future extensions while retaining full backwards
> compatibility.
> 
> Implementations for driver (Linux kernel) and device (Qemu) are publically
> available and field tested since late 2020. Hardware implementations also
> exist (but proprietary, cannot be published yet).
> 
> Device type ID 41 has been allocated by TC vote #3632.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> 
> ---
> 
> changes v2: * fixed htlatex build error with underscores in labels
>             * using code listings for structs and define's
>             * fixed mixed-up device/driver wording

What happened to all the detailed discussions that we went through ? Why did we
spend so much time discussing all that when you didn't had to take suggestions
from the reviews provided on the list?

This version may be good for you, but not for everyone else. We need a generic
enough solution which works seamlessly for everyone involved here. This isn't
some proprietary spec which we are working on here, which we can write based
only on our needs. The spec to be merged MUST be good enough for everyone.

I was expecting the discussions to go in better direction here to be honest and
not have another short lived struggle.

I don't see the improvements suggested for the config structure, nothing about
features, no interrupt support. You just reformatted the stuff and that's all.

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

