Return-Path: virtio-dev-return-2363-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 72E1058193BA
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2017 08:30:43 -0700 (PDT)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Thu, 6 Jul 2017 15:30:37 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7392745A8@shsmsx102.ccr.corp.intel.com>
References: <1498617479-5809-1-git-send-email-wei.w.wang@intel.com>
 <20170706164819-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170706164819-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v4] virtio-net: enable configurable tx queue size
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "stefanha@gmail.com" <stefanha@gmail.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Jan Scheurich <jan.scheurich@ericsson.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thursday, July 6, 2017 9:49 PM, Michael S. Tsirkin wrote:
> On Wed, Jun 28, 2017 at 10:37:59AM +0800, Wei Wang wrote:
> > This patch enables the virtio-net tx queue size to be configurable
> > between 256 (the default queue size) and 1024 by the user when the
> > vhost-user backend is used.
> >
> > Currently, the maximum tx queue size for other backends is 512 due to
> > the following limitations:
> > - QEMU backend: the QEMU backend implementation in some cases may send
> > 1024+1 iovs to writev.
> > - Vhost_net backend: there are possibilities that the guest sends a
> > vring_desc of memory which crosses a MemoryRegion thereby generating
> > more than 1024 iovs after translation from guest-physical address in
> > the backend.
> >
> > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>=20
> Could you pls add a bit info about how this was tested?
> Was any special setup for dpdk necessary?

Yes, I used the vhost-user implementation in DPDK. So, on the host, I have=
=20
the legacy ovs-dpdk setup ready (I'm using dpdk-stable-16.11.1 and openvswi=
tch-2.6.1,
the setup steps can be found inside the source code directory).

When booting the guest, I have the following QEMU commands:
-chardev socket,id=3Dchar1,path=3D/usr/local/var/run/openvswitch/vhost-user=
-1
-netdev type=3Dvhost-user,id=3Dmynet1,chardev=3Dchar1,vhostforce
-device virtio-net-pci,mac=3D52:54:00:00:00:01,netdev=3Dmynet1,tx_queue_siz=
e=3D1024

To check the guest tx queue size, I simply added a printk() at the end of v=
irtnet_probe()
to print out vi->sq->vq->num_free, which initially equals to the queue size=
.

Then, I did Ping and netperf tests to transmit packets between VMs, which w=
orked fine.

If the related configuration support to Libvirt is ready, I think we can ge=
t the customer
to try in their test environment, too.

Best,
Wei






---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

