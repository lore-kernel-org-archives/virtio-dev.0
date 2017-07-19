Return-Path: virtio-dev-return-2410-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6C184581926E
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Jul 2017 10:56:43 -0700 (PDT)
From: Lior Narkis <liorn@mellanox.com>
Date: Wed, 19 Jul 2017 17:56:39 +0000
Message-ID: <DB5PR05MB17664614B26F6C8AA069E5B4D3A60@DB5PR05MB1766.eurprd05.prod.outlook.com>
References: <VI1PR05MB1774022115CB7C4502DEEE73D3A10@VI1PR05MB1774.eurprd05.prod.outlook.com>
 <4DCA102C9749C849A7B61D9934ED62520B7278@fmsmsx122.amr.corp.intel.com>
In-Reply-To: <4DCA102C9749C849A7B61D9934ED62520B7278@fmsmsx122.amr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: virtq configuration over PCI
To: "Dhanoa, Kully" <kully.dhanoa@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Thank you for the comments
See below
> -----Original Message-----
> From: Dhanoa, Kully [mailto:kully.dhanoa@intel.com]
> Sent: Wednesday, July 19, 2017 1:38 PM
> To: Lior Narkis <liorn@mellanox.com>; virtio-dev@lists.oasis-open.org
> Subject: RE: virtq configuration over PCI
>=20
> Hi Lior
>=20
>=20
> With regards to your points on HW implementation, I'm not sure I understa=
nd
> your concerns.
>=20
> Guest performing queue write:
> 1. Single write PCIe transaction with queue_select and other fields (e.g.
> desc_addr, avail_addr) set
> 	1.1. HW should be able to process transaction before next one (most
> likely pipelined writes)
> 		- however if it can't, it would just backpressure the PCIe hard
> IP in the HW
I would not recommend back-pressuring the PCI, it will have system wide eff=
ects.

The point is not how many transactions, but the behavior of this special me=
chanism.
Since there is no feedback mechanism that the driver can check if this conf=
iguration is completed or not, this memory is special.
It cannot be just plain memory that stores the writes and responses to the =
reads, but needs to have a MUX logic.

This is similar to the problem with doorbell(notify) writes, when a queue n=
umbers are written to a specific location.

Both mechanisms, if implemented on plain memory which is mapped to the PCIe=
 BAR means that with a new write you lose the old data.
If the old data is not relevant to you anymore, than it is fine.
But if your implementation failed to act on this data by the time the new d=
ata arrived, this is bad.

One option, which I understand from your comment is ok, is to have a fifo t=
o store those. =20
But then, what happens when the fifo is full.
Back-pressuring is bad.
An alternative to back-pressuring is to have the ability to lose writes and=
 have a recovery mechanism.
So the device should know it lost a write, and know where it should recover=
 it from, in the host memory.
This kind of a mechanism should be specified in the spec.

I do believe a management queue is a better option.
You can look at how NVMe devices operate, in my opinion it is both clean an=
d simple.

>=20
> Guest performing queue read:
> 1. Single write PCIe transaction with queue_select set
> 	1.1. HW would just store queue_select value
> 2. Single read PCIe transaction
> 	2.1 HW would return queue information for queue selected in earlier
> PCIe write transaction.
>=20
> HW would have a separate queue_select register per VF (Virtual Function),=
 so
> any accesses from other guests inbetween 1 and 2 above would not cause an=
y
> problems.
Correct, each function has its own BAR.

>=20
> Within a guest, would a guest set up a queue_select and then before
> generating the read transaction for that queue, change the queue_select?
> (seems unlikely)

It is a driver bug if it happens, I agree.

>=20
> Regards
> Kully
> -----Original Message-----
> From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-open=
.org]
> On Behalf Of Lior Narkis
> Sent: Tuesday, July 18, 2017 3:29 PM
> To: virtio-dev@lists.oasis-open.org
> Subject: [virtio-dev] virtq configuration over PCI
>=20
> Hi All,
> I am trying to figure out how the queue_select mechanism works.
> It seems that there is an assumption that the device can react to the pci=
e write
> of the queue index to queue_select, before other pcie transactions that c=
ome
> after are being served.
> So for example, reading the queue_size after writing to queue_select.
>=20
> I would like to understand if I captured it right, and if so, understand =
how it is
> guaranteed today with a SW implementation of a device.
>=20
> Having an HW implementation in mind, I believe this mechanism limits some
> possible implementations, and it is not robust for adding/changing new qu=
eue
> properties, which will require a new field on the PCIe BAR.
>=20
> I believe a cleaner way will be to have a queue for device management.
> The parameters of how to access this queue should be R/W on the PCIe BAR,
> but there is only one such queue so no need for the select.
> In this queue the work is a command to the device. e.g create_virtq
>=20
> Kind Regards,
> Lior Narkis
>=20
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20
> ---------------------------------------------------------------------
> Intel Corporation (UK) Limited
> Registered No. 1134945 (England)
> Registered Office: Pipers Way, Swindon SN3 1RJ
> VAT No: 860 2173 47
>=20
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

