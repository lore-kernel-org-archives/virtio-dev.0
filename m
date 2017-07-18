Return-Path: virtio-dev-return-2404-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6A45A58192C4
	for <virtio-dev@lists.oasis-open.org>; Tue, 18 Jul 2017 07:29:09 -0700 (PDT)
From: Lior Narkis <liorn@mellanox.com>
Date: Tue, 18 Jul 2017 14:29:04 +0000
Message-ID: <VI1PR05MB1774022115CB7C4502DEEE73D3A10@VI1PR05MB1774.eurprd05.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] virtq configuration over PCI
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi All,
I am trying to figure out how the queue_select mechanism works.
It seems that there is an assumption that the device can react to the pcie =
write of the queue index to queue_select,=20
before other pcie transactions that come after are being served.
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

