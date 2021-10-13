Return-Path: <viresh.kumar@linaro.org>
Date: Wed, 13 Oct 2021 09:42:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 2/2] virtio: i2c: Allow zero-length transactions
Message-ID: <20211013041230.oatwkmhubjnzcakk@vireshk-i7>
References: <cover.1634037711.git.viresh.kumar@linaro.org>
 <325276eec77c6ab3bd28382386055b821754396b.1634037711.git.viresh.kumar@linaro.org>
 <CAK8P3a3GvrcjeTXfdnL=vrWSUVD2KOXa7x1Lw0+uMSzfOJarEQ@mail.gmail.com>
 <20211013033919.jybykoof526zjpsm@vireshk-i7>
 <457e947c-7c62-31e4-f879-61ff482297e6@intel.com>
MIME-Version: 1.0
In-Reply-To: <457e947c-7c62-31e4-f879-61ff482297e6@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jie Deng <jie.deng@intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 13-10-21, 12:07, Jie Deng wrote:
> The "VIRTIO_I2C_FLAGS_M_RD" is consistent with the permissions of the
> buffer.

Yes.

> When this flag is set, the buffer is also marked as device write -only with
> VIRTQ_DESC_F_WRITE set.

Yes.

> So if this feature isn't available we can use the the latter. We only need
> this flag when there is no buffer.

Which means that we need to carry extra piece of code for the same
work (with no benefit as it will never happen, everyone will support
this flag as all the implementations are new currently). This is
exactly what we are trying to avoid by making this feature mandatory,
drivers will be expected to set/clear this flag all the time.

We don't want to have code like this anywhere:

if (feature)
        read flag...
else
        read permissions...

-- 
viresh

