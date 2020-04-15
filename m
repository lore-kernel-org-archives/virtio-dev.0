Return-Path: virtio-dev-return-7066-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 01655985FA8
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Apr 2020 13:50:33 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
References: <f3c003fb-9e54-2a13-47cf-a8820b96e62d@redhat.com>
Message-ID: <57b53bc2-7336-04fd-0b51-cafc9048f0e5@redhat.com>
Date: Wed, 15 Apr 2020 21:50:20 +0800
MIME-Version: 1.0
In-Reply-To: <f3c003fb-9e54-2a13-47cf-a8820b96e62d@redhat.com>
Content-Language: en-US
Subject: [virtio-dev] Re: Doorbell mapping of vDPA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: virtio-networking@redhat.com, Virtio-Dev <virtio-dev@lists.oasis-open.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/4/7 =E4=B8=8B=E5=8D=883:55, Jason Wang wrote:
> Hi all:
>
> To get native performance of VF, we need to map doorbell to guest to=20
> avoid unnecessary vmexit. In order to do this, we will launch qemu=20
> with page-per-vq=3Don. This means the each doorbell register should be=20
> located at the beginning of 4K page and does not share the page with=20
> other registers.=20


After discussion with some vendors. We can relax such requirement by=20
extending qemu to support doorbells like:

1) doorbell registers should exclusively own one or more pages
2) The location of the each doorbell register could be calculated as the=20
algorithm described in the specification (4.1.4.4)

Then qemu can map them safely to guest through virtio-pci.

For virtio-mmio, we will extend the spec to support the same doorbell=20
layouts.

Thanks


> Then vDPA framework can safely map it into the guest physical address=20
> (GPA) range defined by qemu. It could be either
>
> 1) a single doorbell register that is used by all virtqueues
>
> or
>
> 2) several different per-vq doorbell registers
>
> If you decide to implement a virtio-pci register layout, need to make=20
> sure for notification structure (4.1.4.4 of virtio spec):
>
> For each virtqueue, the result=20
> ofcap.offset+queue_notify_off*notify_off_multiplier is PAGE_SIZE (e.g=C2=
=A0=20
> 4K) alignment, and the doorbeel does not share the page with other=20
> registers.
>
> And it would be better if queue_notify_off, notify_off_multiplier can=20
> be changed via firmware for extra flexibility.
>
> Please check and make sure your hardware have such ability and feel=20
> free to ask if you have questions (offline if necessary).
>
> Thanks
>
>
>
>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

