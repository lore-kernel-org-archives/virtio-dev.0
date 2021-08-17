Return-Path: <mst@redhat.com>
Date: Tue, 17 Aug 2021 02:47:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] virtio: i2c: Allow zero-length transactions
Message-ID: <20210817024607-mutt-send-email-mst@kernel.org>
References: <bd0f81517c064b333ea5263bacbb74385e0d9b3a.1629107000.git.viresh.kumar@linaro.org>
 <20210816104430-mutt-send-email-mst@kernel.org>
 <20210817035324.r27cdx3yu2j4qmms@vireshk-i7>
MIME-Version: 1.0
In-Reply-To: <20210817035324.r27cdx3yu2j4qmms@vireshk-i7>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Cornelia Huck <cohuck@redhat.com>, Jie Deng <jie.deng@intel.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 17, 2021 at 09:23:24AM +0530, Viresh Kumar wrote:
> On 16-08-21, 10:45, Michael S. Tsirkin wrote:
> > On Mon, Aug 16, 2021 at 03:17:23PM +0530, Viresh Kumar wrote:
> > > The I2C protocol allows zero-length requests with no data, like the
> > > SMBus Quick command, where the command is inferred based on the
> > > read/write flag itself.
> > 
> > So I wonder. What if we allow zero-length buffers in virtio? Would that
> > address the need?
> 
> There are three things this patch does, all of which are important
> IMO:
> 
> 1. Drop the need of passing both write and read buffers, as that isn't
>    required really since we already have another way of linking
>    different transfers using the fail-next flag.
> 
> 2. Make the buffer optional, for zero-length transfers.
> 
> 3. Pass the r/w flag separately, which is kind of relevant because of
>    2 (zero-length transfers) only.
> 
> 
> I think (1) can be done separately anyway, and we may be able to solve
> (2) and (3) if we allow zero-length buffers in virtio itself.

OK, so yea. Let's split this up please.

> -- 
> viresh

