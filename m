Return-Path: virtio-dev-return-2965-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B5DA5818CA4
	for <virtio-dev@lists.oasis-open.org>; Sat, 13 Jan 2018 23:45:53 -0800 (PST)
From: Ilya Lesokhin <ilyal@mellanox.com>
Date: Sun, 14 Jan 2018 07:45:50 +0000
Message-ID: <AM4PR0501MB27230E63B2FC6BBF79D1419FD4150@AM4PR0501MB2723.eurprd05.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] PCIe ordering and new VIRTIO packed ring format.
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: Liran Liss <liranl@mellanox.com>, Or Gerlitz <ogerlitz@mellanox.com>, Liran Liss <liranl@mellanox.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,
I have a concern about the portability of offloading the new VIRTIO packed =
ring format to hardware.

According to the PCIe rev 2.0, paragraph 2.4.2. Update Ordering and Granula=
rity Observed by a Read Transaction"
" if a host CPU writes a QWORD to host memory, a Requester reading that QWO=
RD from host memory may observe a portion of the QWORD updated and another =
portion of it containing the old value."

This means that after the device reads a 16byte descriptor, it cannot know =
that all the values In the descriptor are up to date even if the VIRTQ_DESC=
_F_AVAIL bit is set.
This is true even if the driver uses the appropriate memory barriers.

We encountered this behavior in practice on x86 servers. Our solution was t=
o add an index to the latest valid descriptor

Note that in practice the update granularity in x86 seems to be a cacheline=
, But this is not guaranteed by the spec.=20
The spec only makes the following recommendation:
"While not required by this specification, it is strongly recommended that =
host platforms guarantee that when a host CPU writes aligned DWORDs or alig=
ned QWORDs to host memory, the update granularity observed by a PCI Express=
 read will not be smaller than a DWORD."

Thanks,
Ilya



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

