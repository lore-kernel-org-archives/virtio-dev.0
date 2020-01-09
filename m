Return-Path: virtio-dev-return-6628-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7DB25985E3F
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Jan 2020 06:15:57 +0000 (UTC)
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <20200105054412-mutt-send-email-mst@kernel.org>
Message-ID: <c7a8fc93-9493-c0b3-623a-02426995f0f8@linux.intel.com>
Date: Thu, 9 Jan 2020 14:15:51 +0800
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
> On Wed, Dec 25, 2019 at 10:50:23AM +0800, Zha Bin wrote:
>> From: Liu Jiang<gerry@linux.alibaba.com>
>>
>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
>> virtio over mmio devices as a lightweight machine model for modern
>> cloud. The standard virtio over MMIO transport layer only supports one
>> legacy interrupt, which is much heavier than virtio over PCI transport
>> layer using MSI. Legacy interrupt has long work path and causes specific
>> VMExits in following cases, which would considerably slow down the
>> performance:
>>
>> 1) read interrupt status register
>> 2) update interrupt status register
>> 3) write IOAPIC EOI register
>>
>> We proposed to update virtio over MMIO to version 3[1] to add the
>> following new features and enhance the performance.
>>
>> 1) Support Message Signaled Interrupt(MSI), which increases the
>>     interrupt performance for virtio multi-queue devices
>> 2) Support per-queue doorbell, so the guest kernel may directly write
>>     to the doorbells provided by virtio devices.
> Do we need to come up with new "doorbell" terminology?
> virtio spec calls these available event notifications,
> let's stick to this.

Yes, let's keep virtio words, which just calls notifications.

>> The following is the network tcp_rr performance testing report, tested
>> with virtio-pci device, vanilla virtio-mmio device and patched
>> virtio-mmio device (run test 3 times for each case):
>>
>> =09netperf -t TCP_RR -H 192.168.1.36 -l 30 -- -r 32,1024
>>
>> =09=09Virtio-PCI    Virtio-MMIO   Virtio-MMIO(MSI)
>> =09trans/s=09    9536=096939=09=099500
>> =09trans/s=09    9734=097029=09=099749
>> =09trans/s=09    9894=097095=09=099318
>>
>> [1]https://lkml.org/lkml/2019/12/20/113
>>
>> Signed-off-by: Liu Jiang<gerry@linux.alibaba.com>
>> Signed-off-by: Zha Bin<zhabin@linux.alibaba.com>
>> Signed-off-by: Chao Peng<chao.p.peng@linux.intel.com>
>> Signed-off-by: Jing Liu<jing2.liu@linux.intel.com>
> Do we need a new version though? What is wrong with
> a feature bit? This way we can create compatible devices
> and drivers.

We considered using 1 feature bit of 24~37 to specify MSI capability, but

this feature bit only means for mmio transport layer, but not representing

comment feature negotiation of the virtio device. So we're not sure if=20
this is a good choice.

>> [...]
>>  =20
>> +static void mmio_write_msi_msg(struct msi_desc *desc, struct msi_msg *m=
sg)
>> +{
>> +=09struct device *dev =3D desc->dev;
>> +=09struct virtio_device *vdev =3D dev_to_virtio(dev);
>> +=09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
>> +=09void __iomem *pos =3D vm_dev->base;
>> +=09uint16_t cmd =3D VIRTIO_MMIO_MSI_CMD(VIRTIO_MMIO_MSI_CMD_UPDATE,
>> +=09=09=09desc->platform.msi_index);
>> +
>> +=09writel(msg->address_lo, pos + VIRTIO_MMIO_MSI_ADDRESS_LOW);
>> +=09writel(msg->address_hi, pos + VIRTIO_MMIO_MSI_ADDRESS_HIGH);
>> +=09writel(msg->data, pos + VIRTIO_MMIO_MSI_DATA);
>> +=09writew(cmd, pos + VIRTIO_MMIO_MSI_COMMAND);
>> +}
> All this can happen when IRQ affinity changes while device
> is sending interrupts. An interrupt sent between the writel
> operations will then be directed incorrectly.

When investigating kernel MSI behavior, I found in most case there's no=20
action during IRQ affinity changes to avoid the interrupt coming.

For example, when migrate_one_irq, it masks the irq before=20
irq_do_set_affinity. But for others, like user setting any irq affinity

via /proc/, it only holds desc->lock instead of disable/mask irq. In=20
such case, how can it ensure the interrupt sending between writel ops?


>> [...]
>> +
>> +/* RO: MSI feature enabled mask */
>> +#define VIRTIO_MMIO_MSI_ENABLE_MASK=090x8000
> I don't understand the comment. Is this a way for
> a version 3 device to say "I want/do not want MSI"?
> Why not just use a feature bit? We are not short on these.

This is just used for current MSI enabled/disabled status, after all MSI=20
configurations setup finished.

Not for showing MSI capability.

In other words, since the concern of feature bit, we choose to update=20
the virtio mmio

version that devices with v3 have MSI capability and notifications.


Thanks,

Jing


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

