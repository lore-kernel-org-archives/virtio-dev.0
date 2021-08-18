Return-Path: <virtio-dev-return-8549-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CCE23986488
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Aug 2021 02:38:38 +0000 (UTC)
References: <bd0f81517c064b333ea5263bacbb74385e0d9b3a.1629107000.git.viresh.kumar@linaro.org>
 <20210816104430-mutt-send-email-mst@kernel.org>
 <20210817035324.r27cdx3yu2j4qmms@vireshk-i7>
 <20210817024607-mutt-send-email-mst@kernel.org>
 <20210817104314.yg2ybrodkpnfwpoq@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <ade98cbb-ba4f-ae59-46a0-09b518d72ba7@intel.com>
Date: Wed, 18 Aug 2021 10:38:32 +0800
MIME-Version: 1.0
In-Reply-To: <20210817104314.yg2ybrodkpnfwpoq@vireshk-i7>
Subject: [virtio-dev] Re: [PATCH V2] virtio: i2c: Allow zero-length transactions
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Viresh Kumar <viresh.kumar@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2021/8/17 18:43, Viresh Kumar wrote:
> On 17-08-21, 02:47, Michael S. Tsirkin wrote:
>> On Tue, Aug 17, 2021 at 09:23:24AM +0530, Viresh Kumar wrote:
>>> On 16-08-21, 10:45, Michael S. Tsirkin wrote:
>>>> So I wonder. What if we allow zero-length buffers in virtio? Would tha=
t
>>>> address the need?
>> OK, so yea. Let's split this up please.
> Just to make sure I understand what you asked for, we are looking for
> something on these lines ? And the kernel side will still send an 'sg'
> element and call sg_init_one(sg, NULL, 0) ?


 From the perspective of specification=EF=BC=8CI think we can allow zero-le=
ngth=20
buffers in virtio.

we can use the len of descriptor to see if it is a zero-length buffer.

But for a specific implementation, I don't think "NULL" can be passed to=20
this API.

There is a check "BUG_ON(!virt_addr_valid(buf))" in it.




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

