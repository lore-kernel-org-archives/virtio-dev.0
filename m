Return-Path: virtio-dev-return-6657-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 40EA4985F62
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Jan 2020 07:06:43 +0000 (UTC)
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <20200105054412-mutt-send-email-mst@kernel.org>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <b0975121-99d4-3b53-50c5-03002d90b28f@linux.intel.com>
Date: Wed, 15 Jan 2020 15:06:39 +0800
MIME-Version: 1.0
In-Reply-To: <20200105054412-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Zha Bin <zhabin@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com, jing2.liu@intel.com, chao.p.peng@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 1/5/2020 7:04 PM, Michael S. Tsirkin wrote:
> [...]
>> +static int vm_find_vqs_msi(struct virtio_device *vdev, unsigned int nvq=
s,
>> +=09=09=09struct virtqueue *vqs[], vq_callback_t *callbacks[],
>> +=09=09=09const char * const names[], const bool *ctx,
>> +=09=09=09struct irq_affinity *desc)
>> +{
>> +=09int i, err, irq;
>> +=09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
>> +
>> +=09/* Allocate nvqs irqs for queues and one irq for configuration */
>> +=09err =3D vm_request_msi_vectors(vdev, nvqs + 1);
>> +=09if (err !=3D 0)
>> +=09=09return err;
> Not all devices need high speed.  Some might want to share
> irqs between VQs, or even with config change callback.
> Balloon is a case in point.
> A hint about max # of MSI necessary would be a good
> idea for this case.

This seems being a hint about telling MSI number device supported and=20
whether it wants MSI sharing.

For devices with tens of queues at most or need high speed, they choose=20
vector per queue, and can simply use fixed mapping.

For others, it can ask for advanced mode, which means MSI sharing and=20
dynamic mapping.

What about let device decide the mode it would use, as follows.

MaxVecNum 32bit - The max msi vector number that device supports.

MsiState 32bit

- bit[x]=3D0 implies vec per queue/config and fixed mapping. In this case,=
=20
MsiVecNum>=3Dnum_queue+1

- bit [x]=3D1 implies the hint of msi sharing and dynamic mapping. In this=
=20
case, MsiVecNum<num_queue+1


Thanks,

Jing

>
> Sharing MSI doesn't necessarily require dedicated registers like PCI has,
> you can just program same vector in multiple VQs.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

