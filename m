Return-Path: virtio-dev-return-7107-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 06C1C986077
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Apr 2020 09:29:16 +0000 (UTC)
References: <BN6PR1801MB2067FCCE45316C25E5EB82F7C5DA0@BN6PR1801MB2067.namprd18.prod.outlook.com>
 <20200414121724-mutt-send-email-mst@kernel.org>
 <6cd6b9aa-1ee8-d523-aee3-4765dc52202e@redhat.com>
 <20200417023552-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cbbd4acc-a11f-59af-04b8-896998eda403@redhat.com>
Date: Fri, 17 Apr 2020 17:29:00 +0800
MIME-Version: 1.0
In-Reply-To: <20200417023552-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: [virtio-dev] Re: [Virtio-networking] Doorbell mapping of vDPA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Vitaly Mireyno <vmireyno@marvell.com>, "virtio-networking@redhat.com" <virtio-networking@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Ariel Elior <aelior@marvell.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/4/17 =E4=B8=8B=E5=8D=882:37, Michael S. Tsirkin wrote:
> On Fri, Apr 17, 2020 at 12:19:43PM +0800, Jason Wang wrote:
>> On 2020/4/15 =E4=B8=8A=E5=8D=8812:20, Michael S. Tsirkin wrote:
>>> On Tue, Apr 14, 2020 at 01:12:51PM +0000, Vitaly Mireyno wrote:
>>>>> -----Original Message-----
>>>>> From: virtio-networking-bounces@redhat.com <virtio-networking-bounces=
@redhat.com> On Behalf
>>>>> Of Jason Wang
>>>>> Sent: Tuesday, 7 April, 2020 10:56
>>>>> To: virtio-networking@redhat.com; Virtio-Dev <virtio-dev@lists.oasis-=
open.org>
>>>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>>>> Subject: [Virtio-networking] Doorbell mapping of vDPA
>>>>>
>>>>> ---------------------------------------------------------------------=
-
>>>>> Hi all:
>>>>>
>>>>> To get native performance of VF, we need to map doorbell to guest to =
avoid unnecessary vmexit. In
>>>>> order to do this, we will launch qemu with page-per-vq=3Don. This mea=
ns the each doorbell register
>>>>> should be located at the beginning of 4K page and does not share the =
page with other registers. Then
>>>>> vDPA framework can safely map it into the guest physical address (GPA=
) range defined by qemu. It
>>>>> could be either
>>>>>
>>>>> 1) a single doorbell register that is used by all virtqueues
>>>>>
>>>>> or
>>>>>
>>>>> 2) several different per-vq doorbell registers
>>>>>
>>>>> If you decide to implement a virtio-pci register layout, need to make=
 sure for notification structure
>>>>> (4.1.4.4 of virtio spec):
>>>>>
>>>>> For each virtqueue, the result
>>>>> ofcap.offset+queue_notify_off*notify_off_multiplier is PAGE_SIZE (e.g
>>>>> 4K) alignment, and the doorbeel does not share the page with other re=
gisters.
>>>>>
>>>>> And it would be better if queue_notify_off, notify_off_multiplier can=
 be changed via firmware for
>>>>> extra flexibility.
>>>>>
>>>> In some cases, these conditions could not be met for a virtio-net hard=
ware device over PCI transport.
>>>> queue_notify and notify_off_multiplier could not always be fully contr=
olled by the firmware. There could be hardware limitations on flexibility d=
egree of these parameters.
>>>> Specifically, the limitations I'm thinking of are:
>>>>    * queue_notify_off>0 and notify_off_multiplier>0
>>>>    * Several doorbell registers of several virtqueues share the same p=
age (but don't share the page with other registers).
>>>>
>>>> Can this be supported in vDPA with direct doorbell mapping?
>>>>
>>>> Thanks
>>> There's value in being able to intercept some vqs in software
>>> while the rest of vqs are handled in hardware.
>>> E.g. that's the case for e.g. the control vq.
>>
>> Good point, so in this case, the doorbell of control vq must exclusively=
 own
>> a page.
>>
>> Or to facilitate the hardware design, we may introduce dedicated
>> notification area for control vq?
>>
>> Thanks
> Well all this would need spec changes.


Yes.


> I'm guessing at this
> point it's easier to just have hardware send commands to
> qemu through some channel before using them.


Yes, the plan is to let hardware report the location (offset) of the=20
doorbell registers.


>   With SRIOV that would need
> to be either the PF, or a memory bar of the VF.


So I think what we want is:

- map doorbells for non control vqs
- intercept the control vq doorbell

In order to do this, hardware need to make sure that the doorbell of=20
control vq registers does not share page with any other doorbells.

Then qemu may provide a suitable queue_notify_off for control vq which=20
make sure it can be intercepted independently.

Thanks


>
>
>>>
>>>>> Please check and make sure your hardware have such ability and feel f=
ree to ask if you have questions
>>>>> (offline if necessary).
>>>>>
>>>>> Thanks
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> Virtio-networking mailing list
>>>>> Virtio-networking@redhat.com
>>>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.redhat.com=
_mailman_listinfo_virtio-
>>>>> 2Dnetworking&d=3DDwIGaQ&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DlDHJ2FW52oJ3lq=
qsArgFRdcevq01tbLQAw
>>>>> 4A_NO7xgI&m=3DpddgVCz-
>>>>> orGTuUXATJ4Dmi7vAXatG9w47AmULNC3V9A&s=3D5mfYWbLCjcZO8FcwDqgAc5bjE-H-
>>>>> 4p5TBkRZqP3uMsQ&e=3D


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

