Return-Path: <virtio-dev-return-8703-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B28F698636E
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Sep 2021 08:09:40 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <8d35aa1c925ab7cd2452f790ea84e78ff905db00.1630481293.git.viresh.kumar@linaro.org>
References: <8d35aa1c925ab7cd2452f790ea84e78ff905db00.1630481293.git.viresh.kumar@linaro.org>
Date: Wed, 22 Sep 2021 10:09:34 +0200
Message-ID: <87ilytf2v5.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH V3] virtio: i2c: Allow zero-length transactions
Content-Type: text/plain
To: Viresh Kumar <viresh.kumar@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jie Deng <jie.deng@intel.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Sep 01 2021, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> The I2C protocol allows zero-length requests with no data, like the
> SMBus Quick command, where the command is inferred based on the
> read/write flag itself.
>
> In order to allow such a request, allocate another bit,
> VIRTIO_I2C_FLAGS_M_RD(1), in the flags to pass the request type, as read
> or write. This was earlier done using the read/write permission to the
> buffer itself.
>
> This still won't work well if multiple buffers are passed for the same
> request, i.e. the write-read requests, as the VIRTIO_I2C_FLAGS_M_RD flag
> can only be used with a single buffer.
>
> Coming back to it, there is no need to send multiple buffers with a
> single request. All we need, is a way to group several requests
> together, which we can already do based on the
> VIRTIO_I2C_FLAGS_FAIL_NEXT flag.
>
> Remove support for multiple buffers within a single request.
>
> Since we are at very early stage of development currently, we can do
> these modifications without addition of new features or versioning of
> the protocol.

I'm a bit worried about this statement. While we have not done a formal
release of the standard since i2c has been added, it still has been out
there already, and this is an incompatible change (even if it is one
that makes sense.)

So, I'm a bit torn between just going with this and adding a feature bit
(that can be mandatory so we don't need to drag the old implementation
around.) But I'm also worried whether there are more incompatible
changes expected in the near future; if there are, I'd be more
comfortable if we could just hold off until everyone agrees things are
stable.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

