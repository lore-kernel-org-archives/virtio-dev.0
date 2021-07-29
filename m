Return-Path: <virtio-dev-return-8432-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B21B986134
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Jul 2021 06:18:28 +0000 (UTC)
References: <cd02a45c16631d92d864fbf432bf0b2865b7de12.1627017387.git.viresh.kumar@linaro.org>
 <7c74b6aa-5d1d-8ab1-b4ca-e1f9df8b6605@intel.com>
 <20210729054712.aw76luyq7ajso35v@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <6ea301e0-0420-f17a-c79f-8551fb840ecc@intel.com>
Date: Thu, 29 Jul 2021 14:18:21 +0800
MIME-Version: 1.0
In-Reply-To: <20210729054712.aw76luyq7ajso35v@vireshk-i7>
Subject: [virtio-dev] Re: [PATCH] virtio: i2c: Allow buffer less transactions
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2021/7/29 13:47, Viresh Kumar wrote:
> On 29-07-21, 13:39, Jie Deng wrote:
>
>> Well, then can we also add a flag to mark the zero-length request.
>>
>> I think it will be convenient for backend developers.
> Hmm, I think that information is already present at the device since
> only two elements will be present in the received request, one out
> buffer and one in buffer. And since the middle (data) buffer is not
> present, the device can easily know that it is a zero-length request.
>
> I don't see a real advantage of adding a flag for this.
>  =20


The number of descriptors required for a request will not be fixed.

If there is a descriptor sequence in the virtqueue, then you may need a=20
state machine

to parse the sequence. For example, when you have


WR=C2=A0=C2=A0 =C2=A0=C2=A0 RR =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 ZR

O O I=C2=A0=C2=A0 O I I=C2=A0=C2=A0=C2=A0=C2=A0 O I

* WR:(write request), RR (read request), ZR (zero request), O: output=20
descriptor, I: input descriptor


When you encounter "O I" combination, you have to read the element after=20
it to distinguish

RR and ZR. Will this bring unnecessary difficulties for the backend coding =
?





---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

