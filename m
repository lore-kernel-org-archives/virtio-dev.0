Return-Path: virtio-dev-return-6669-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F3195985EFF
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Jan 2020 05:03:23 +0000 (UTC)
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <20200105054412-mutt-send-email-mst@kernel.org>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <be94a982-69c9-534a-77a1-3026a93bfb63@linux.intel.com>
Date: Tue, 21 Jan 2020 13:03:17 +0800
MIME-Version: 1.0
In-Reply-To: <20200105054412-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for
 virtio-mmio specification version 3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Zha Bin <zhabin@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com, jing2.liu@intel.com, chao.p.peng@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 1/5/2020 7:04 PM, Michael S. Tsirkin wrote:
>
>>  =20
>>   struct virtio_mmio_vq_info {
>> @@ -101,6 +107,8 @@ struct virtio_mmio_vq_info {
>>   };
>>  =20
>>  =20
>> +static void vm_free_msi_irqs(struct virtio_device *vdev);
>> +static int vm_request_msi_vectors(struct virtio_device *vdev, int nirqs=
);
>>  =20
>>   /* Configuration interface */
>>  =20
>> @@ -273,12 +281,28 @@ static bool vm_notify(struct virtqueue *vq)
>>   {
>>   =09struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vq->vde=
v);
>>  =20
>> +=09if (vm_dev->version =3D=3D 3) {
>> +=09=09int offset =3D vm_dev->doorbell_base +
>> +=09=09=09     vm_dev->doorbell_scale * vq->index;
>> +=09=09writel(vq->index, vm_dev->base + offset);
>> +=09} else
>>   =09/* We write the queue's selector into the notification register to
>>   =09 * signal the other end */
>> -=09writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
>> +=09=09writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
>> +
>>   =09return true;
>>   }
> You might want to support VIRTIO_F_NOTIFICATION_DATA too.
>
Yes, the feature is new in virtio1.1 and the kernel has not defined and=20
implemented it yet.

To implement it for both PCI and MMIO, maybe it would be good to work a=20
separate patch set later?

BTW, we are working on v2 and will send out later.

Thanks,

Jing


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

