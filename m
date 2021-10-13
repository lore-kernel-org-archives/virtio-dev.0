Return-Path: <virtio-dev-return-8870-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 682CD9865CF
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Oct 2021 11:10:57 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20211013104359.wykpyaz5cffgefuu@vireshk-i7>
References: <cover.1634037711.git.viresh.kumar@linaro.org>
 <325276eec77c6ab3bd28382386055b821754396b.1634037711.git.viresh.kumar@linaro.org>
 <87bl3twa15.fsf@redhat.com> <20211013104359.wykpyaz5cffgefuu@vireshk-i7>
Date: Wed, 13 Oct 2021 13:10:48 +0200
Message-ID: <8735p5w56v.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH V5 2/2] virtio: i2c: Allow zero-length transactions
Content-Type: text/plain
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jie Deng <jie.deng@intel.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Oct 13 2021, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 13-10-21, 11:26, Cornelia Huck wrote:
>> On Tue, Oct 12 2021, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > +A device SHOULD implement the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.
>> 
>> Same here, I would make this "MUST offer", and simply make old device
>> implementations non-compliant.
>
>> The device should also reject any driver that does not negotiate the
>> flag, I think?
>
> Thinking about this a bit more, in practice the device doesn't get to
> know about what the driver does with the flag. So how can a device
> reject the driver ?

It can fail setting FEATURES_OK, if the driver does not set the feature.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

