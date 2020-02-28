Return-Path: virtio-dev-return-6820-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F32D1985EDB
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Feb 2020 16:47:37 +0000 (UTC)
References: <87mu93vwy2.fsf@linaro.org>
 <db75fc2b-ac2e-2351-cc3c-cdb42a50ac24@siemens.com>
 <0b80da21-ed40-c550-c605-031a209115b1@siemens.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <0b80da21-ed40-c550-c605-031a209115b1@siemens.com>
Date: Fri, 28 Feb 2020 16:47:33 +0000
Message-ID: <878skmwtei.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: VIRTIO adoption in other hypervisors
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, Stefano Stabellini <sstabellini@kernel.org>, Wei Liu <liuw@liuw.name>
List-ID: <virtio-dev.lists.oasis-open.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 28.02.20 11:30, Jan Kiszka wrote:
>> On 28.02.20 11:16, Alex Benn=C3=A9e wrote:
>>> Hi,
>>>
<snip>
>>> I believe there has been some development work for supporting VIRTIO on
>>> Xen although it seems to have stalled according to:
>>>
>>>    https://wiki.xenproject.org/wiki/Virtio_On_Xen
>>>
>>> Recently at KVM Forum there was Jan's talk about Inter-VM shared memory
>>> which proposed ivshmemv2 as a VIRTIO transport:
>>>
>>>    https://events19.linuxfoundation.org/events/kvm-forum-2019/program/s=
chedule/=20
>>>
>>>
>>> As I understood it this would allow Xen (and other hypervisors) a simpl=
e
>>> way to be able to carry virtio traffic between guest and end point.
>
> And to clarify the scope of this effort: virtio-over-ivshmem is not
> the fastest option to offer virtio to a guest (static "DMA" window),
> but it is the simplest one from the hypervisor PoV and, thus, also
> likely the easiest one to argue over when it comes to security and
> safety.

So to drill down on this is this a particular problem with type-1
hypervisors?

It seems to me any KVM-like run loop trivially supports a range of
virtio devices by virtue of trapping accesses to the signalling area of
a virtqueue and allowing the VMM to handle the transaction which ever
way it sees fit.

I've not quite understood the way Xen interfaces to QEMU aside from it's
different to everything else. More over it seems the type-1 hypervisors
are more interested in providing better isolation between segments of a
system whereas VIRTIO currently assumes either the VMM or the hypervisor
has full access the full guest address space. I've seen quite a lot of
slides that want to isolate sections of device emulation to separate
processes or even separate guest VMs.

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

