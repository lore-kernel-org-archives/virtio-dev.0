Return-Path: virtio-dev-return-6574-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 47C5B9843F1
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Dec 2019 09:37:27 +0000 (UTC)
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <85eeab19-1f53-6c45-95a2-44c1cfd39184@redhat.com>
Message-ID: <28da67db-73ab-f772-fb00-5a471b746fc5@linux.intel.com>
Date: Fri, 27 Dec 2019 17:37:22 +0800
MIME-Version: 1.0
In-Reply-To: <85eeab19-1f53-6c45-95a2-44c1cfd39184@redhat.com>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for
 virtio-mmio specification version 3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>, Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com, jing2.liu@intel.com, chao.p.peng@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Jason,

Thanks for reviewing the patches!

 =C2=A0[...]
>> -
>> +#include <linux/msi.h>
>> +#include <asm/irqdomain.h>
>> =C2=A0 =C2=A0 /* The alignment to use between consumer and producer part=
s of=20
>> vring.
>> =C2=A0=C2=A0 * Currently hardcoded to the page size. */
>> @@ -90,6 +90,12 @@ struct virtio_mmio_device {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* a list of queues so we can dispatch IR=
Qs */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spinlock_t lock;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head virtqueues;
>> +
>> +=C2=A0=C2=A0=C2=A0 int doorbell_base;
>> +=C2=A0=C2=A0=C2=A0 int doorbell_scale;
>
>
> It's better to use the terminology defined by spec, e.g=20
> notify_base/notify_multiplexer etc.
>
> And we usually use unsigned type for offset.

We will fix this in next version.


>
>
>> +=C2=A0=C2=A0=C2=A0 bool msi_enabled;
>> +=C2=A0=C2=A0=C2=A0 /* Name strings for interrupts. */
>> +=C2=A0=C2=A0=C2=A0 char (*vm_vq_names)[256];
>> =C2=A0 };
>> =C2=A0 =C2=A0 struct virtio_mmio_vq_info {
>> @@ -101,6 +107,8 @@ struct virtio_mmio_vq_info {
>> =C2=A0 };
>> =C2=A0 =C2=A0 +static void vm_free_msi_irqs(struct virtio_device *vdev);
>> +static int vm_request_msi_vectors(struct virtio_device *vdev, int=20
>> nirqs);
>> =C2=A0 =C2=A0 /* Configuration interface */
>> =C2=A0 @@ -273,12 +281,28 @@ static bool vm_notify(struct virtqueue *vq)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct virtio_mmio_device *vm_dev =3D=20
>> to_virtio_mmio_device(vq->vdev);
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (vm_dev->version =3D=3D 3) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int offset =3D vm_dev->doorb=
ell_base +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm_dev->doorbell_scale * vq->index;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writel(vq->index, vm_dev->ba=
se + offset);
>
>
> In virtio-pci we store the doorbell address in vq->priv to avoid doing=20
> multiplication in fast path.

Good suggestion. We will fix this in next version.

[...]

>> +
>> +static int vm_request_msi_vectors(struct virtio_device *vdev, int=20
>> nirqs)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct virtio_mmio_device *vm_dev =3D to_virtio_mmio=
_device(vdev);
>> +=C2=A0=C2=A0=C2=A0 int irq, err;
>> +=C2=A0=C2=A0=C2=A0 u16 csr =3D readw(vm_dev->base + VIRTIO_MMIO_MSI_STA=
TUS);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (vm_dev->msi_enabled || (csr & VIRTIO_MMIO_MSI_EN=
ABLE_MASK)=20
>> =3D=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +
>> +=C2=A0=C2=A0=C2=A0 vm_dev->vm_vq_names =3D kmalloc_array(nirqs,=20
>> sizeof(*vm_dev->vm_vq_names),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_=
KERNEL);
>> +=C2=A0=C2=A0=C2=A0 if (!vm_dev->vm_vq_names)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!vdev->dev.msi_domain)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vdev->dev.msi_domain =3D pla=
tform_msi_get_def_irq_domain();
>> +=C2=A0=C2=A0=C2=A0 err =3D platform_msi_domain_alloc_irqs(&vdev->dev, n=
irqs,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mmio=
_write_msi_msg);
>
>
> Can platform_msi_domain_alloc_irqs check msi_domain vs NULL?
>
Actually here, we need to firstly consider the cases that @dev doesn't=20
have @msi_domain,

according to the report by lkp.

For the platform_msi_domain_alloc_irqs, it can help check inside.


> [...]
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D register_virtio_device(&vm_=
dev->vdev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
>> @@ -619,8 +819,6 @@ static int virtio_mmio_remove(struct=20
>> platform_device *pdev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 -
>> -
>
>
> Unnecessary changes.

Got it. Will remove it later.


> [...]
>> =C2=A0 +/* MSI related registers */
>> +
>> +/* MSI status register */
>> +#define VIRTIO_MMIO_MSI_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x0c0
>> +/* MSI command register */
>> +#define VIRTIO_MMIO_MSI_COMMAND=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x0c2
>> +/* MSI low 32 bit address, 64 bits in two halves */
>> +#define VIRTIO_MMIO_MSI_ADDRESS_LOW=C2=A0=C2=A0=C2=A0 0x0c4
>> +/* MSI high 32 bit address, 64 bits in two halves */
>> +#define VIRTIO_MMIO_MSI_ADDRESS_HIGH=C2=A0=C2=A0=C2=A0 0x0c8
>> +/* MSI data */
>> +#define VIRTIO_MMIO_MSI_DATA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
0x0cc
>
>
> I wonder what's the advantage of using registers instead of memory=20
> mapped tables as PCI did. Is this because MMIO doesn't have capability=20
> list which makes it hard to be extended if we have variable size of=20
> tables?
>
Yes, mmio doesn't have capability which limits the extension.

It need some registers to specify the msi table/mask table/pending table=20
offsets if using what pci did.

As comments previously, mask/pending can be easily extended by MSI command.

>
>> +
>> +/* RO: MSI feature enabled mask */
>> +#define VIRTIO_MMIO_MSI_ENABLE_MASK=C2=A0=C2=A0=C2=A0 0x8000
>> +/* RO: Maximum queue size available */
>> +#define VIRTIO_MMIO_MSI_STATUS_QMASK=C2=A0=C2=A0=C2=A0 0x07ff
>> +/* Reserved */
>> +#define VIRTIO_MMIO_MSI_STATUS_RESERVED=C2=A0=C2=A0=C2=A0 0x7800
>> +
>> +#define VIRTIO_MMIO_MSI_CMD_UPDATE=C2=A0=C2=A0=C2=A0 0x1
>
>
> I believe we need a command to read the number of vectors supported by=20
> the device, or 2048 is assumed to be a fixed size here?

For not bringing much complexity, we proposed vector per queue and fixed=20
relationship between events and vectors.

So the number of vectors supported by device is equal to the total=20
number of vqs and config.

We will try to explicitly highlight this point in spec for later version.


Thanks!

Jing

>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

