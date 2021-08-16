Return-Path: <virtio-dev-return-8526-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E8BAC98612F
	for <virtio-dev@lists.oasis-open.org>; Mon, 16 Aug 2021 09:33:32 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210806042116.ji6n4j4vswvotnjh@vireshk-i7>
References: <cd02a45c16631d92d864fbf432bf0b2865b7de12.1627017387.git.viresh.kumar@linaro.org>
 <20210806042116.ji6n4j4vswvotnjh@vireshk-i7>
Date: Mon, 16 Aug 2021 11:33:22 +0200
Message-ID: <871r6tvin1.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH] virtio: i2c: Allow buffer less transactions
Content-Type: text/plain
To: Viresh Kumar <viresh.kumar@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jie Deng <jie.deng@intel.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Aug 06 2021, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 23-07-21, 10:56, Viresh Kumar wrote:
>> The I2C protocol allows requests with no data, like the SMBus Quick
>> command, where the command is inferred based on the read/write flag
>> itself.
>> 
>> In order to allow such a request, allocate another bit,
>> VIRTIO_I2C_FLAGS_M_RD(1), in the flags to pass the request type, as read
>> or write. This was earlier done using the read/write permission to the
>> buffer itself.
>> 
>> This still won't work well if multiple buffers are passed for the same
>> request, i.e. the write-read requests, as the VIRTIO_I2C_FLAGS_M_RD flag
>> can only be used with a single buffer.
>> 
>> Coming back to it, there is no need to send multiple buffers with a
>> single request. All we need, is a way to group several requests
>> together, which we can already do based on the
>> VIRTIO_I2C_FLAGS_FAIL_NEXT flag.
>> 
>> Remove support for multiple buffers within a single request.
>> 
>> Since we are at very early stage of development currently, we can do
>> these modifications without addition of new features or versioning of
>> the protocol.
>> 
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>
> Gentle reminder!

Hm, I thought there had been some feedback already? I've been waiting
for a respin.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

