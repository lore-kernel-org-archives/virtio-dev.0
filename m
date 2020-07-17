Return-Path: virtio-dev-return-7595-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 51E459860A4
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Jul 2020 16:52:24 +0000 (UTC)
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-2-ndragazis@arrikto.com> <87v9inv26c.fsf@linaro.org>
From: Nikos Dragazis <ndragazis@arrikto.com>
Message-ID: <2a539c1d-683f-e403-8c2c-7b0c4d37bbc9@arrikto.com>
Date: Fri, 17 Jul 2020 19:52:19 +0300
MIME-Version: 1.0
In-Reply-To: <87v9inv26c.fsf@linaro.org>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v5 01/10] vhost-user: add vhost-user device
 type
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 16/7/20 7:45 =CE=BC.=CE=BC., Alex Benn=C3=A9e wrote:

> Nikos Dragazis <ndragazis@arrikto.com> writes:
>
>> +
>> +    When the driver clears VIRTIO_VHOST_USER_SLAVE_UP while the vhost-u=
ser
>> +    master is connected, the vhost-user master is disconnected.
> What happens to messages in flight? Do they stay in the queues until
> there is a re-connection?

After the reconnection, the master-slave communication starts from
scratch, i.e., there is no state. At least, this is what I can infer
from the vhost-user spec.=C2=A0 So, in-flight vhost-user messages have to b=
e
discarded. We should mention it explicitly in the spec.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

