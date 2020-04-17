Return-Path: virtio-dev-return-7094-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 78A7B986076
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Apr 2020 04:15:20 +0000 (UTC)
References: <BN6PR1801MB2067FCCE45316C25E5EB82F7C5DA0@BN6PR1801MB2067.namprd18.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5c682a37-04cc-e96f-e593-ec932caefbc7@redhat.com>
Date: Fri, 17 Apr 2020 12:15:06 +0800
MIME-Version: 1.0
In-Reply-To: <BN6PR1801MB2067FCCE45316C25E5EB82F7C5DA0@BN6PR1801MB2067.namprd18.prod.outlook.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [Virtio-networking] Doorbell mapping of vDPA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Vitaly Mireyno <vmireyno@marvell.com>, "virtio-networking@redhat.com" <virtio-networking@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ariel Elior <aelior@marvell.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/4/14 =E4=B8=8B=E5=8D=889:12, Vitaly Mireyno wrote:
>> -----Original Message-----
>> From: virtio-networking-bounces@redhat.com <virtio-networking-bounces@re=
dhat.com> On Behalf
>> Of Jason Wang
>> Sent: Tuesday, 7 April, 2020 10:56
>> To: virtio-networking@redhat.com; Virtio-Dev <virtio-dev@lists.oasis-ope=
n.org>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Subject: [Virtio-networking] Doorbell mapping of vDPA
>>
>> ----------------------------------------------------------------------
>> Hi all:
>>
>> To get native performance of VF, we need to map doorbell to guest to avo=
id unnecessary vmexit. In
>> order to do this, we will launch qemu with page-per-vq=3Don. This means =
the each doorbell register
>> should be located at the beginning of 4K page and does not share the pag=
e with other registers. Then
>> vDPA framework can safely map it into the guest physical address (GPA) r=
ange defined by qemu. It
>> could be either
>>
>> 1) a single doorbell register that is used by all virtqueues
>>
>> or
>>
>> 2) several different per-vq doorbell registers
>>
>> If you decide to implement a virtio-pci register layout, need to make su=
re for notification structure
>> (4.1.4.4 of virtio spec):
>>
>> For each virtqueue, the result
>> ofcap.offset+queue_notify_off*notify_off_multiplier is PAGE_SIZE (e.g
>> 4K) alignment, and the doorbeel does not share the page with other regis=
ters.
>>
>> And it would be better if queue_notify_off, notify_off_multiplier can be=
 changed via firmware for
>> extra flexibility.
>>
> In some cases, these conditions could not be met for a virtio-net hardwar=
e device over PCI transport.
> queue_notify and notify_off_multiplier could not always be fully controll=
ed by the firmware. There could be hardware limitations on flexibility degr=
ee of these parameters.
> Specifically, the limitations I'm thinking of are:
>   * queue_notify_off>0 and notify_off_multiplier>0
>   * Several doorbell registers of several virtqueues share the same page =
(but don't share the page with other registers).
>
> Can this be supported in vDPA with direct doorbell mapping?


I think this could be supported, we can introduce the API to:

1) let qemu to=C2=A0 mmap() the notification pages to userspace
2) let qemu query the location of each notification registers, and=20
decide whether or not it could be modeled by the transport. E.g in your=20
case, if the transport is virtio-pci, it can be supported.

Thanks


>
> Thanks
>
>> Please check and make sure your hardware have such ability and feel free=
 to ask if you have questions
>> (offline if necessary).
>>
>> Thanks
>>
>>
>>
>>
>>
>> _______________________________________________
>> Virtio-networking mailing list
>> Virtio-networking@redhat.com
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.redhat.com_ma=
ilman_listinfo_virtio-
>> 2Dnetworking&d=3DDwIGaQ&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DlDHJ2FW52oJ3lqqsA=
rgFRdcevq01tbLQAw
>> 4A_NO7xgI&m=3DpddgVCz-
>> orGTuUXATJ4Dmi7vAXatG9w47AmULNC3V9A&s=3D5mfYWbLCjcZO8FcwDqgAc5bjE-H-
>> 4p5TBkRZqP3uMsQ&e=3D


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

