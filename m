Return-Path: virtio-dev-return-7593-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5BBB59860A0
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Jul 2020 15:37:14 +0000 (UTC)
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-10-ndragazis@arrikto.com>
 <20200717095720.GI128195@stefanha-x1.localdomain>
From: Nikos Dragazis <ndragazis@arrikto.com>
Message-ID: <e74eb30a-3086-b843-958b-e49863182fe4@arrikto.com>
Date: Fri, 17 Jul 2020 18:37:11 +0300
MIME-Version: 1.0
In-Reply-To: <20200717095720.GI128195@stefanha-x1.localdomain>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v5 09/10] vhost-user: intercept slave's reply
 to VHOST_USER_GET_PROTOCOL_FEATURES
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 17/7/20 12:57 =CE=BC.=CE=BC., Stefan Hajnoczi wrote:

> On Mon, May 18, 2020 at 11:37:20PM +0300, Nikos Dragazis wrote:
>> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
>> ---
>>   virtio-vhost-user.tex | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
>> index a673526..328baec 100644
>> --- a/virtio-vhost-user.tex
>> +++ b/virtio-vhost-user.tex
>> @@ -142,10 +142,15 @@ \subsubsection{Device Operation: RX/TX Queues}\lab=
el{sec:Device Types / Vhost-us
>>   message that is too large for an rxq buffer, then DEVICE_NEEDS_RESET i=
s set and
>>   the driver must reset the device.
>>  =20
>> -File descriptor passing is handled differently by the vhost-user device
>> -backend.  When a message is received that carries one or more file desc=
riptors
>> -according to the vhost-user protocol, additional device resources becom=
e
>> -available to the driver.
>> +File descriptor passing is handled differently by the vhost-user device=
 backend.
>> +When a master-initiated message is received that carries one or more fi=
le
>> +descriptors according to the vhost-user protocol, additional device res=
ources
>> +become available to the driver.
>> +
>> +On the contrary, the slave cannot pass file descriptors to the master. =
For this
>> +reason, the vhost-user device backend MUST be intercepting the slave's =
reply to
>> +the VHOST_USER_GET_PROTOCOL_FEATURES vhost-user message and clearing th=
ese
>> +feature bits that allow the slave to send messages that pass file descr=
iptors.
> Please be specific about which vhost-user protocol bits are not
> supported.

Currently, this goes for the VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD and
VHOST_USER_PROTOCOL_F_PAGEFAULT feature bits.

>
> Why does the virtio-vhost-user device implementation need to silently
> clear those feature bits? Is there a security impact or some other
> reason why the VIRTIO spec should specify this behavior?

In our setup, the slave cannot pass file descriptors to the master.
The easiest way to enforce this restriction is during feature
negotiation. The virtio-vhost-user device will mask the unsupported
feature bits and, therefore, the master will not enable these feature
bits on the slave.

>
> Stefan

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

