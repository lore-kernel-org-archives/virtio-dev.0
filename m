Return-Path: virtio-dev-return-6569-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9118B985D7E
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Dec 2019 10:21:08 +0000 (UTC)
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <229e689d-10f1-2bfb-c393-14dfa9c78971@redhat.com>
Date: Wed, 25 Dec 2019 18:20:54 +0800
MIME-Version: 1.0
In-Reply-To: <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com, jing2.liu@intel.com, chao.p.peng@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2019/12/25 =E4=B8=8A=E5=8D=8810:50, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
>
> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
> virtio over mmio devices as a lightweight machine model for modern
> cloud. The standard virtio over MMIO transport layer only supports one
> legacy interrupt, which is much heavier than virtio over PCI transport
> layer using MSI. Legacy interrupt has long work path and causes specific
> VMExits in following cases, which would considerably slow down the
> performance:
>
> 1) read interrupt status register
> 2) update interrupt status register
> 3) write IOAPIC EOI register
>
> We proposed to update virtio over MMIO to version 3[1] to add the
> following new features and enhance the performance.
>
> 1) Support Message Signaled Interrupt(MSI), which increases the
>     interrupt performance for virtio multi-queue devices
> 2) Support per-queue doorbell, so the guest kernel may directly write
>     to the doorbells provided by virtio devices.
>
> The following is the network tcp_rr performance testing report, tested
> with virtio-pci device, vanilla virtio-mmio device and patched
> virtio-mmio device (run test 3 times for each case):
>
> =09netperf -t TCP_RR -H 192.168.1.36 -l 30 -- -r 32,1024
>
> =09=09Virtio-PCI    Virtio-MMIO   Virtio-MMIO(MSI)
> =09trans/s=09    9536=096939=09=099500
> =09trans/s=09    9734=097029=09=099749
> =09trans/s=09    9894=097095=09=099318
>
> [1] https://lkml.org/lkml/2019/12/20/113


Thanks for the patch. Two questions after a quick glance:

1) In PCI we choose to support MSI-X instead of MSI for having extra=20
flexibility like alias, independent data and address (e.g for affinity)=20
. Any reason for not start from MSI-X? E.g having MSI-X table and PBA=20
(both of which looks pretty independent).
2) It's better to split notify_multiplexer out of MSI support to ease=20
the reviewers (apply to spec patch as well)

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

