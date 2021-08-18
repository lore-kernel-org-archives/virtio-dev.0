Return-Path: <virtio-dev-return-8562-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3CB8986488
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Aug 2021 08:09:47 +0000 (UTC)
Date: Wed, 18 Aug 2021 13:39:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Message-ID: <20210818080943.peuchnrbxc6fmmci@vireshk-i7>
References: <bd0f81517c064b333ea5263bacbb74385e0d9b3a.1629107000.git.viresh.kumar@linaro.org>
 <20210816104430-mutt-send-email-mst@kernel.org>
 <20210817035324.r27cdx3yu2j4qmms@vireshk-i7>
 <20210817024607-mutt-send-email-mst@kernel.org>
 <20210817104314.yg2ybrodkpnfwpoq@vireshk-i7>
 <ade98cbb-ba4f-ae59-46a0-09b518d72ba7@intel.com>
 <20210818032644.gld65jqwvxjgwqeq@vireshk-i7>
 <CAK8P3a30e0-r7QxtSbRiBwOuM84TdftCz7mOTYwazHjgg=2egQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a30e0-r7QxtSbRiBwOuM84TdftCz7mOTYwazHjgg=2egQ@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH V2] virtio: i2c: Allow zero-length
 transactions
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jie Deng <jie.deng@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 18-08-21, 10:03, Arnd Bergmann wrote:
> I'd prefer your earlier approach.
> 
> My feeling is that changing the virtqueue code to allow zero-length
> buffers is more fragile than having something in the virtio-i2c code
> that has a special case for leaving out both read_buf and write_buf.

Exactly what I think about it and so my hesitation for the same :)

> Even if we fix the linux virtqueue code to deal with zero-length
> NULL buffers, there are other implementations that will require
> similar workarounds for existing sanity checks.

Lets say what Michael thinks about it.

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

