Return-Path: <virtio-dev-return-10702-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 86D82986763
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Feb 2023 15:02:11 +0000 (UTC)
Message-ID: <c20ee6cf-2aae-25ef-e97f-0e7fc3f9c5b6@opensynergy.com>
Date: Fri, 3 Feb 2023 16:02:04 +0100
References: <20220825134449.18803-1-harald.mommer@opensynergy.com>
 <20220827093909.ag3zi7k525k4zuqq@pengutronix.de>
 <40e3d678-b840-e780-c1da-367000724f69@opensynergy.com>
 <c2c0ba34-2985-21ea-0809-b96a3aa5e401@siemens.com>
 <36bb910c-4874-409b-ac71-d141cd1d8ecb@app.fastmail.com>
From: Harald Mommer <hmo@opensynergy.com>
In-Reply-To: <36bb910c-4874-409b-ac71-d141cd1d8ecb@app.fastmail.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/1] can: virtio: Initial virtio CAN
 driver.
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Harald Mommer <harald.mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org, Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>, stratos-dev@op-lists.linaro.org, Matti Moell <Matti.Moell@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hello,

we had here at OpenSynergy an internal discussion about an open source 
virtio-can device implementation.

The outcome of this is now that an open source virtio-can device is to 
be developed.

It has not yet been decided whether the open source device 
implementation will be done using qemu or kvmtool (or something else?). 
Negative or positive feedback for or against one of those is likely to 
influence the decision what will be used as basis for the development. 
Using kvmtool may be easier to do for me (to be investigated in detail) 
but on the other hand we have some people around in the team who have 
the knowledge to support with qemu.


On 04.11.22 18:03, Arnd Bergmann wrote:
> On Fri, Nov 4, 2022, at 16:32, Jan Kiszka wrote:
>> On 03.11.22 14:55, Harald Mommer wrote:
>>> On 27.08.22 11:39, Marc Kleine-Budde wrote:
>>>> Is there an Open Source implementation of the host side of this
>>>> interface?
>>> there is neither an open source device nor is it currently planned. The
>>> device I'm developing is closed source.
>> Likely not helpful long-term /wrt kernel QA - how should kernelci or
>> others even have a chance to test the driver? Keep in mind that you are
>> not proposing a specific driver for an Opensynergy hypervisor, rather
>> for the open and vendor-agnostic virtio spec.
>>
>> But QEMU already supports both CAN and virtio, thus should be relatively
>> easy to augment with this new device.
> Agreed, either hooking into the qemu support, or having a separate
> vhost-user backend that forwards data to the host stack would be
> helpful here, in particular to see how the flow control works.

What I would like to have is considering a CAN frame as sent when it was 
sent on the bus (vs. given to the lower layers where it is only 
scheduled for later transmission but not actually physically sent). This 
behavior is enabled by feature flag VIRTIO_CAN_F_LATE_TX_ACK. But under 
really heavy load conditions this does not work reliably. It looks like 
the own transmitted frames are discarded sometimes in heavy overload.

The reception of the own transmitted frames is used to trigger the state 
transition from "TX pending" => "TX done" for a pending transmitted 
frame in the device. So loosing those own transmitted frames leads to 
the situation that "TX pending" frames stay in this state forever and 
everything gets stuck quickly. So the feature flag 
VIRTIO_CAN_F_LATE_TX_ACK is currently not usable reliably in Linux. 
Either I need to find a good workaround or better a proper way to avoid 
that any of those acknowledgement frames is lost ever. I've no good 
solution found to cope with this yet.

But without VIRTIO_CAN_F_LATE_TX_ACK there is also no working flow 
control. Means I would like to see some day not only "how flow control 
works" but also "that flow control works regardless how the CAN stack is 
tortured".

> IIRC when we discussed virtio-can on the stratos list, one of the
> issues that was pointed out was filtering of frames for specific
> CAN IDs in the host socketcan for assigning individual IDs to
> separate guests.  It would be good to understand whether a generic
> host implementation has the same problems, and what can be
> done in socketcan to help with that.
>
>        Arnd
>
Harald


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

