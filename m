Return-Path: <virtio-dev-return-8854-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2F0D998640D
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Oct 2021 02:32:09 +0000 (UTC)
References: <cover.1634037711.git.viresh.kumar@linaro.org>
 <325276eec77c6ab3bd28382386055b821754396b.1634037711.git.viresh.kumar@linaro.org>
 <CAK8P3a3GvrcjeTXfdnL=vrWSUVD2KOXa7x1Lw0+uMSzfOJarEQ@mail.gmail.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <35f923a5-8437-52fd-4dcd-33856f5b2fac@intel.com>
Date: Wed, 13 Oct 2021 10:32:03 +0800
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3GvrcjeTXfdnL=vrWSUVD2KOXa7x1Lw0+uMSzfOJarEQ@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH V5 2/2] virtio: i2c: Allow zero-length
 transactions
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2021/10/12 22:09, Arnd Bergmann wrote:
>
>> @@ -124,13 +140,23 @@ \subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C
>>
>>   \drivernormative{\subsubsection}{Device Operation}{Device Types / I2C Adapter Device / Device Operation}
>>
>> +A driver SHOULD implement the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.
> I don't think this needs to be "SHOULD", as a driver may be written to only
> talk to certain i2c clients on the device side, and they do not need zero
> length requests. Maybe this could be
>
> "A driver MAY assume that the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST
> feature is available".

Agree. "MAY" is better.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

