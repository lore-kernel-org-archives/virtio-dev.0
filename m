Return-Path: <virtio-dev-return-10120-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 20B81986681
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Nov 2022 17:24:33 +0000 (UTC)
From: Harald Mommer <Harald.Mommer@opensynergy.com>
Date: Fri,  4 Nov 2022 18:24:19 +0100
Message-Id: <20221104172421.8271-1-Harald.Mommer@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC PATCH v2 0/2] can: virtio: virtio-can driver
Content-Type: text/plain
To: virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hello,

this is a new virtio-can driver. 

The proposed addition to the virtio specification which should match
this driver has been sent 25-Aug-2022 and can be found here:

https://lore.kernel.org/all/20220825133410.18367-1-harald.mommer@opensynergy.com/

(Got no comments on the updated specification proposal now.)

The RFC driver version has been sent 25-Aug-2022 and can be found here:

https://lore.kernel.org/all/20220825134449.18803-1-harald.mommer@opensynergy.com/

- Small update to be compilable against newest kernel

  - netif_napi_add() prototype change

- Address the review comments got from Arnd Bergmann, Oliver Hartkopp,
  Marc Kleine-Budde:

  - Remove virtio_can_hexdump()
  - Use completion instead of polling
  - Restructure usage of spinlock in virtio_can_start_xmit()
  - Save kicks in virtio_can_start_xmit()
  - Minimize usage of BUG_ON()
  - Make driver less noisy
  - Move register_virtio_candev() down in code
  - Remove unwanted MISRA habits used to in a former life
  - Treat bitmasks as bitmasks
  - Remove excessive usage of netdev_warn() silently sanitizing
  - Fix RTR frame handling with payload != 0
  - Work through checkpatch problems
  - Clarify license
  - Remove some pointless leftover comments

Regards
Harald

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

