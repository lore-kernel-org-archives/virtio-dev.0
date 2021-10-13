Return-Path: <jie.deng@intel.com>
Subject: Re: [PATCH V5 0/2] virtio: i2c: Allow zero-length transactions
References: <cover.1634037711.git.viresh.kumar@linaro.org>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <50491e03-dc86-e765-f761-b397bdf79fba@intel.com>
Date: Wed, 13 Oct 2021 10:25:53 +0800
MIME-Version: 1.0
In-Reply-To: <cover.1634037711.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2021/10/12 19:23, Viresh Kumar wrote:
> Hi,
>
> Arnd suggested (over IRC) to split this into two patches for better readability
> and so here is a resend. The eventual specification hasn't changed at all.
>
> V4->V5:
> - Split into two patches.
>
> V3->V4:
> - Add a new mandatory feature flag.
>
> V2->V3:
> - Add conformance clauses that require that the flag is consistent with the
>    buffer.
>
> V1->V2:
> - Name the buffer-less request as zero-length request.
>
> ------
>
> I did try to follow the discussion you guys had during V4, where we added
> support for multiple buffers for the same request, which I think is unnecessary
> now, after introduction of the VIRTIO_I2C_FLAGS_FAIL_NEXT flag.
>
> https://lists.oasis-open.org/archives/virtio-comment/202011/msg00005.html
>
> And so starting this discussion again, because we need to support stuff
> like: i2cdetect -q <i2c-bus-number>, which issues a zero-length SMBus
> Quick command.
>
> Viresh Kumar (2):
>    virtio: i2c: No need to have separate read-write buffers
>    virtio: i2c: Allow zero-length transactions

LGTM. Thanks Viresh.

Reviewed-by: Jie Deng <jie.deng@intel.com>

