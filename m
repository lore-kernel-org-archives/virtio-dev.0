Return-Path: <viresh.kumar@linaro.org>
Date: Wed, 13 Oct 2021 16:13:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 2/2] virtio: i2c: Allow zero-length transactions
Message-ID: <20211013104359.wykpyaz5cffgefuu@vireshk-i7>
References: <cover.1634037711.git.viresh.kumar@linaro.org>
 <325276eec77c6ab3bd28382386055b821754396b.1634037711.git.viresh.kumar@linaro.org>
 <87bl3twa15.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87bl3twa15.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jie Deng <jie.deng@intel.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 13-10-21, 11:26, Cornelia Huck wrote:
> On Tue, Oct 12 2021, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +A device SHOULD implement the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.
> 
> Same here, I would make this "MUST offer", and simply make old device
> implementations non-compliant.

> The device should also reject any driver that does not negotiate the
> flag, I think?

Thinking about this a bit more, in practice the device doesn't get to
know about what the driver does with the flag. So how can a device
reject the driver ?

-- 
viresh

