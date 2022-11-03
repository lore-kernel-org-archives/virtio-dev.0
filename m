Return-Path: <virtio-dev-return-10116-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3576298661D
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Nov 2022 13:55:56 +0000 (UTC)
Message-ID: <40e3d678-b840-e780-c1da-367000724f69@opensynergy.com>
Date: Thu, 3 Nov 2022 14:55:49 +0100
References: <20220825134449.18803-1-harald.mommer@opensynergy.com>
 <20220827093909.ag3zi7k525k4zuqq@pengutronix.de>
From: Harald Mommer <hmo@opensynergy.com>
In-Reply-To: <20220827093909.ag3zi7k525k4zuqq@pengutronix.de>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [RFC PATCH 1/1] can: virtio: Initial virtio CAN driver.
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Marc Kleine-Budde <mkl@pengutronix.de>, Harald Mommer <harald.mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hello,

On 27.08.22 11:39, Marc Kleine-Budde wrote:
> Is there an Open Source implementation of the host side of this
> interface?
there is neither an open source device nor is it currently planned. The 
device I'm developing is closed source.
> Please fix these checkpatch warnings:
>
> | WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> | #65:
> | new file mode 100644
> |
Addressed most of the checkpatch warnings. Regarding the BUG_ON() 
minimized usage. Removed where not necessary, reworked where a better 
error handling was possible, kept where I don't think it will catch ever 
but if it catches I would like to know. Of course I could make the tool 
happy but on the other hand I don't want to fly completely blind in case 
a bug has to be hunted.
> regards,
> Marc

Regards
Harald



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

