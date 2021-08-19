Return-Path: <virtio-dev-return-8580-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 64EDB98648C
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Aug 2021 10:31:00 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <8cb679e3013bc9dd49af5d4837c0dcffeb41b8e8.1629345350.git.viresh.kumar@linaro.org>
References: <8cb679e3013bc9dd49af5d4837c0dcffeb41b8e8.1629345350.git.viresh.kumar@linaro.org>
Date: Thu, 19 Aug 2021 12:30:48 +0200
Message-ID: <87fsv5sp47.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH V2] virtio-gpio: Specify character encoding for gpio names
Content-Type: text/plain
To: Viresh Kumar <viresh.kumar@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@kernel.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico
 Weigelt, metux IT consult" <info@metux.net>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Aug 19 2021, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Specify 7-bit ASCII character encoding for GPIO names strings.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/115
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2:
> - Use ASCII instead of UTF-8.
>
>  virtio-gpio.tex | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

