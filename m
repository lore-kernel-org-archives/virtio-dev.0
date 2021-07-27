Return-Path: <viresh.kumar@linaro.org>
Date: Tue, 27 Jul 2021 11:07:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] virtio: i2c: Allow buffer less transactions
Message-ID: <20210727053700.otwkh7khsmdaj3be@vireshk-i7>
References: <cd02a45c16631d92d864fbf432bf0b2865b7de12.1627017387.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
In-Reply-To: <cd02a45c16631d92d864fbf432bf0b2865b7de12.1627017387.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Jie Deng <jie.deng@intel.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 23-07-21, 10:56, Viresh Kumar wrote:
> The I2C protocol allows requests with no data, like the SMBus Quick
> command, where the command is inferred based on the read/write flag
> itself.
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
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Realized now that I need to create an issue as well :)

https://github.com/oasis-tcs/virtio-spec/issues/112

-- 
viresh

