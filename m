Return-Path: <viresh.kumar@linaro.org>
Date: Wed, 18 Aug 2021 08:56:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [virtio-dev] Re: [PATCH V2] virtio: i2c: Allow zero-length
 transactions
Message-ID: <20210818032644.gld65jqwvxjgwqeq@vireshk-i7>
References: <bd0f81517c064b333ea5263bacbb74385e0d9b3a.1629107000.git.viresh.kumar@linaro.org>
 <20210816104430-mutt-send-email-mst@kernel.org>
 <20210817035324.r27cdx3yu2j4qmms@vireshk-i7>
 <20210817024607-mutt-send-email-mst@kernel.org>
 <20210817104314.yg2ybrodkpnfwpoq@vireshk-i7>
 <ade98cbb-ba4f-ae59-46a0-09b518d72ba7@intel.com>
MIME-Version: 1.0
In-Reply-To: <ade98cbb-ba4f-ae59-46a0-09b518d72ba7@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: Jie Deng <jie.deng@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org, Gerd Hoffmann <kraxel@redhat.com>, arnd@kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

+Arnd

On 18-08-21, 10:38, Jie Deng wrote:
> 
> On 2021/8/17 18:43, Viresh Kumar wrote:
> > On 17-08-21, 02:47, Michael S. Tsirkin wrote:
> > > On Tue, Aug 17, 2021 at 09:23:24AM +0530, Viresh Kumar wrote:
> > > > On 16-08-21, 10:45, Michael S. Tsirkin wrote:
> > > > > So I wonder. What if we allow zero-length buffers in virtio? Would that
> > > > > address the need?
> > > OK, so yea. Let's split this up please.
> > Just to make sure I understand what you asked for, we are looking for
> > something on these lines ? And the kernel side will still send an 'sg'
> > element and call sg_init_one(sg, NULL, 0) ?
> 
> 
> From the perspective of specification，I think we can allow zero-length
> buffers in virtio.
> 
> we can use the len of descriptor to see if it is a zero-length buffer.
> 
> But for a specific implementation, I don't think "NULL" can be passed to
> this API.
> 
> There is a check "BUG_ON(!virt_addr_valid(buf))" in it.

I tried to look at implementations of virt_addr_valid() and it doesn't
check for NULL specifically (for the ones I looked at). I haven't
tested it though.

Though I am not sure what's better here, remove the need of sending
buffer altogether, the way this patch proposed initially or what
Michael has suggested. And all that to prevent just a single bit to be
used in flags field, which will likely be used for more things later
on.

-- 
viresh

