Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <cover.1634037711.git.viresh.kumar@linaro.org> <be859d7eb192077ec4523c219f53ce8cc57ec531.1634037711.git.viresh.kumar@linaro.org>
In-Reply-To: <be859d7eb192077ec4523c219f53ce8cc57ec531.1634037711.git.viresh.kumar@linaro.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 12 Oct 2021 15:58:11 +0200
Message-ID: <CAK8P3a1CAx0F=01MeVBs8+A0ur1BKCtC3T6Ead0=+ZGLybXwnw@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] virtio: i2c: No need to have separate read-write buffers
Content-Type: text/plain; charset="UTF-8"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Jie Deng <jie.deng@intel.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Oct 12, 2021 at 1:23 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The virtio I2C protocol allows to contain multiple read-write requests
> in a single I2C transaction using the VIRTIO_I2C_FLAGS_FAIL_NEXT flag,
> where each request contains a header, buffer and status.
>
> There is no need to pass both read and write buffers in a single
> request, as we have a better way of combining requests into a single I2C
> transaction. Moreover, this also limits the transactions to two buffers,
> one for read operation and one for write. By using
> VIRTIO_I2C_FLAGS_FAIL_NEXT, we don't have any such limits.
>
> Remove support for multiple buffers within a single request.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/112
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks for splitting up the two patches, I think this is much clearer now.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

