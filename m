Return-Path: virtio-dev-return-7434-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 193D5985E06
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 Jun 2020 02:57:37 +0000 (UTC)
References: <0592979c-c8ae-fd28-2ddf-e64b135a7292@redhat.com>
 <20200601015736-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1768dfde-36c7-f0c7-89d1-8b3e3f99761d@redhat.com>
Date: Tue, 2 Jun 2020 10:57:19 +0800
MIME-Version: 1.0
In-Reply-To: <20200601015736-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: queue_enable vs QueueReady
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/6/1 =E4=B8=8B=E5=8D=882:01, Michael S. Tsirkin wrote:
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
>>
>> Thanks
> PCI assumed device reset is enough to stop all queues.  We had tons of
> bugs around shutdown because of this, so in hindsight, MMIO had maybe a
> better idea.
>
> Ability to stop a queue and take back buffers would be nice, e.g. serial
> is kind of messed up around port disconnect without it.


Yes, but this inconsistency brings trouble for vDPA implementation which=20
has a set_queue_ready() and we do the following in virtio_vdpa as MMIO did:

 =C2=A0=C2=A0=C2=A0 /* Select and deactivate the queue */
 =C2=A0=C2=A0=C2=A0 ops->set_vq_ready(vdpa, index, 0);
 =C2=A0=C2=A0=C2=A0 WARN_ON(ops->get_vq_ready(vdpa, index));

The codes seems to work fine for IFC (a violation of the spec probably)=20
but not Qemu's virtio-net-pci.

Thanks



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

