Return-Path: virtio-dev-return-7424-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4AF4B986075
	for <virtio-dev@lists.oasis-open.org>; Fri, 29 May 2020 02:57:18 +0000 (UTC)
References: <0592979c-c8ae-fd28-2ddf-e64b135a7292@redhat.com>
 <20200528140040.GD158218@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <95d6aa67-9a6e-e264-38b2-392dfffda8ef@redhat.com>
Date: Fri, 29 May 2020 10:57:03 +0800
MIME-Version: 1.0
In-Reply-To: <20200528140040.GD158218@stefanha-x1.localdomain>
Content-Language: en-US
Subject: Re: [virtio-dev] queue_enable vs QueueReady
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/5/28 =E4=B8=8B=E5=8D=8810:00, Stefan Hajnoczi wrote:
> On Thu, May 28, 2020 at 09:06:36PM +0800, Jason Wang wrote:
>> Hi:
>>
>> I found ambiguity in the virtio specification:
>>
>> In PCI part, it describes the queue_enable as:
>>
>> The driver uses this to selectively prevent the device from executing
>> requests from this virtqueue. 1 - enabled; 0 - disabled.
>>
>> In MMIO part, it describes the QueueReady as:
>>
>> Writing one (0x1) to this register notifies the device that it can execu=
te
>> requests from this virtual queue. Reading from this register returns the
>> last value written to it. Both read and write accesses apply to the queu=
e
>> selected by writing to QueueSel.
>>
>> If I understand this correctly, they have the same meaning, but the driv=
er
>> requirements section looks conflict:
>>
>> PCI said: The driver MUST NOT write a 0 to queue_enable.
>>
>> MMIO said:
>>
>> To stop using the queue the driver MUST write zero (0x0) to this QueueRe=
ady
>> and MUST read the value back to ensure synchronization.
>>
>> So we can't disable a queue via queue_enable but QueueReady. Any reason =
for
>> such inconsistency?
> I think MMIO is the outlier here. The device emulation code in QEMU
> doesn't deal with queue shutdown. That only happens during device reset,
> so it's like that a if the guest disables a virtio-mmio queue then
> something undefined will happen on the QEMU side.


Qemu's MMIO only implement the fucntion of value write and read. Its PCI=20
implementation is also buggy which assumes the value is one.


>   For example, writing
> used elements back to the virtqueue after it has been disabled.


Ok, but kernel virtio-mmio driver did the following in vm_del_vq():

 =C2=A0=C2=A0=C2=A0 /* Select and deactivate the queue */
 =C2=A0=C2=A0=C2=A0 writel(index, vm_dev->base + VIRTIO_MMIO_QUEUE_SEL);
 =C2=A0=C2=A0=C2=A0 if (vm_dev->version =3D=3D 1) {
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 writel(0, vm_dev->base + VIRTIO_MMIO=
_QUEUE_PFN);
 =C2=A0=C2=A0=C2=A0 } else {
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 writel(0, vm_dev->base + VIRTIO_MMIO=
_QUEUE_READY);
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 WARN_ON(readl(vm_dev->base + VIRTIO_=
MMIO_QUEUE_READY));
 =C2=A0=C2=A0=C2=A0 }

Which tries to align with the spec ...


>
> If the VIRTIO spec really intends to support virtqueue shutdown then the
> semantics need to be spelled out clearly: what happens to in-flight
> requests? How do devices behave that rely on multiple virtqueues during
> normal operation (e.g. virtio-vsock where you can't really have rx-only
> or tx-only)?


If we plan to do this, we need do something similar to status. That=20
means driver must wait for a read of queue_enable to return 0.

For in-flight request we can do the same thing as device reset but just=20
for a virtqueue probably.

Thanks


>
> Stefan


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

