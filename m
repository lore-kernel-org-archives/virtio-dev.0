Return-Path: virtio-dev-return-2408-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id CB90E5818F7B
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Jul 2017 03:38:18 -0700 (PDT)
From: "Dhanoa, Kully" <kully.dhanoa@intel.com>
Date: Wed, 19 Jul 2017 10:37:46 +0000
Message-ID: <4DCA102C9749C849A7B61D9934ED62520B7278@fmsmsx122.amr.corp.intel.com>
References: <VI1PR05MB1774022115CB7C4502DEEE73D3A10@VI1PR05MB1774.eurprd05.prod.outlook.com>
In-Reply-To: <VI1PR05MB1774022115CB7C4502DEEE73D3A10@VI1PR05MB1774.eurprd05.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] RE: virtq configuration over PCI
To: Lior Narkis <liorn@mellanox.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Lior


With regards to your points on HW implementation, I'm not sure I understand=
 your concerns.

Guest performing queue write:
1. Single write PCIe transaction with queue_select and other fields (e.g. d=
esc_addr, avail_addr) set
	1.1. HW should be able to process transaction before next one (most likely=
 pipelined writes)
		- however if it can't, it would just backpressure the PCIe hard IP in the=
 HW

Guest performing queue read:
1. Single write PCIe transaction with queue_select set
	1.1. HW would just store queue_select value
2. Single read PCIe transaction
	2.1 HW would return queue information for queue selected in earlier PCIe w=
rite transaction.

HW would have a separate queue_select register per VF (Virtual Function), s=
o any accesses from other guests inbetween 1 and 2 above would not cause an=
y problems.

Within a guest, would a guest set up a queue_select and then before generat=
ing the read transaction for that queue, change the queue_select? (seems un=
likely)

Regards
Kully
-----Original Message-----
From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-open.o=
rg] On Behalf Of Lior Narkis
Sent: Tuesday, July 18, 2017 3:29 PM
To: virtio-dev@lists.oasis-open.org
Subject: [virtio-dev] virtq configuration over PCI

Hi All,
I am trying to figure out how the queue_select mechanism works.
It seems that there is an assumption that the device can react to the pcie =
write of the queue index to queue_select, before other pcie transactions th=
at come after are being served.
So for example, reading the queue_size after writing to queue_select.

I would like to understand if I captured it right, and if so, understand ho=
w it is guaranteed today with a SW implementation of a device.

Having an HW implementation in mind, I believe this mechanism limits some p=
ossible implementations, and it is not robust for adding/changing new queue=
 properties, which will require a new field on the PCIe BAR.

I believe a cleaner way will be to have a queue for device management.
The parameters of how to access this queue should be R/W on the PCIe BAR, b=
ut there is only one such queue so no need for the select.
In this queue the work is a command to the device. e.g create_virtq

Kind Regards,
Lior Narkis



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

