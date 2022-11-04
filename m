Return-Path: <virtio-dev-return-10118-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 27F48986681
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Nov 2022 15:32:55 +0000 (UTC)
Message-ID: <c2c0ba34-2985-21ea-0809-b96a3aa5e401@siemens.com>
Date: Fri, 4 Nov 2022 16:32:49 +0100
References: <20220825134449.18803-1-harald.mommer@opensynergy.com>
 <20220827093909.ag3zi7k525k4zuqq@pengutronix.de>
 <40e3d678-b840-e780-c1da-367000724f69@opensynergy.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <40e3d678-b840-e780-c1da-367000724f69@opensynergy.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/1] can: virtio: Initial virtio CAN
 driver.
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Harald Mommer <hmo@opensynergy.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Harald Mommer <harald.mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 03.11.22 14:55, Harald Mommer wrote:
> Hello,
> 
> On 27.08.22 11:39, Marc Kleine-Budde wrote:
>> Is there an Open Source implementation of the host side of this
>> interface?
> there is neither an open source device nor is it currently planned. The
> device I'm developing is closed source.

Likely not helpful long-term /wrt kernel QA - how should kernelci or
others even have a chance to test the driver? Keep in mind that you are
not proposing a specific driver for an Opensynergy hypervisor, rather
for the open and vendor-agnostic virtio spec.

But QEMU already supports both CAN and virtio, thus should be relatively
easy to augment with this new device.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

