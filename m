Return-Path: <virtio-dev-return-10119-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D952986681
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Nov 2022 17:04:13 +0000 (UTC)
Mime-Version: 1.0
Message-Id: <36bb910c-4874-409b-ac71-d141cd1d8ecb@app.fastmail.com>
In-Reply-To: <c2c0ba34-2985-21ea-0809-b96a3aa5e401@siemens.com>
References: <20220825134449.18803-1-harald.mommer@opensynergy.com>
 <20220827093909.ag3zi7k525k4zuqq@pengutronix.de>
 <40e3d678-b840-e780-c1da-367000724f69@opensynergy.com>
 <c2c0ba34-2985-21ea-0809-b96a3aa5e401@siemens.com>
Date: Fri, 04 Nov 2022 18:03:50 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/1] can: virtio: Initial virtio CAN driver.
Content-Type: text/plain
To: Jan Kiszka <jan.kiszka@siemens.com>, Harald Mommer <hmo@opensynergy.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Harald Mommer <harald.mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org, Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>, stratos-dev@op-lists.linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 4, 2022, at 16:32, Jan Kiszka wrote:
> On 03.11.22 14:55, Harald Mommer wrote:
>> 
>> On 27.08.22 11:39, Marc Kleine-Budde wrote:
>>> Is there an Open Source implementation of the host side of this
>>> interface?
>> there is neither an open source device nor is it currently planned. The
>> device I'm developing is closed source.
>
> Likely not helpful long-term /wrt kernel QA - how should kernelci or
> others even have a chance to test the driver? Keep in mind that you are
> not proposing a specific driver for an Opensynergy hypervisor, rather
> for the open and vendor-agnostic virtio spec.
>
> But QEMU already supports both CAN and virtio, thus should be relatively
> easy to augment with this new device.

Agreed, either hooking into the qemu support, or having a separate
vhost-user backend that forwards data to the host stack would be
helpful here, in particular to see how the flow control works.

IIRC when we discussed virtio-can on the stratos list, one of the
issues that was pointed out was filtering of frames for specific
CAN IDs in the host socketcan for assigning individual IDs to
separate guests.  It would be good to understand whether a generic
host implementation has the same problems, and what can be
done in socketcan to help with that.

      Arnd

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

