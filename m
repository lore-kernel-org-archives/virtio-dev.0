Return-Path: <viresh.kumar@linaro.org>
Date: Mon, 4 Oct 2021 11:40:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [virtio-dev] Re: [PATCH V3] virtio: i2c: Allow zero-length
 transactions
Message-ID: <20211004061011.dd2nflittub7sj3o@vireshk-i7>
References: <8d35aa1c925ab7cd2452f790ea84e78ff905db00.1630481293.git.viresh.kumar@linaro.org>
 <87ilytf2v5.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87ilytf2v5.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jie Deng <jie.deng@intel.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 22-09-21, 10:09, Cornelia Huck wrote:
> On Wed, Sep 01 2021, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > The I2C protocol allows zero-length requests with no data, like the
> > SMBus Quick command, where the command is inferred based on the
> > read/write flag itself.
> >
> > In order to allow such a request, allocate another bit,
> > VIRTIO_I2C_FLAGS_M_RD(1), in the flags to pass the request type, as read
> > or write. This was earlier done using the read/write permission to the
> > buffer itself.
> >
> > This still won't work well if multiple buffers are passed for the same
> > request, i.e. the write-read requests, as the VIRTIO_I2C_FLAGS_M_RD flag
> > can only be used with a single buffer.
> >
> > Coming back to it, there is no need to send multiple buffers with a
> > single request. All we need, is a way to group several requests
> > together, which we can already do based on the
> > VIRTIO_I2C_FLAGS_FAIL_NEXT flag.
> >
> > Remove support for multiple buffers within a single request.
> >
> > Since we are at very early stage of development currently, we can do
> > these modifications without addition of new features or versioning of
> > the protocol.
> 
> I'm a bit worried about this statement. While we have not done a formal
> release of the standard since i2c has been added, it still has been out
> there already,

As far as I know, there are only two users of this stuff for now, Linaro and
Intel (Jie). And both of us are okay to go ahead with this change.

> and this is an incompatible change (even if it is one
> that makes sense.)

Yes, it is incompatible for sure.

> So, I'm a bit torn between just going with this and adding a feature bit
> (that can be mandatory so we don't need to drag the old implementation
> around.)

I would be fine with that as it would solve the problem at hand.

> But I'm also worried whether there are more incompatible
> changes expected in the near future; if there are, I'd be more
> comfortable if we could just hold off until everyone agrees things are
> stable.

Both me and Jie are done with our developments of backends and Linux driver and
this is the only thing that came up during reviews. So there is nothing which is
already known.

-- 
viresh

