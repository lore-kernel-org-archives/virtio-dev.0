Return-Path: virtio-dev-return-7493-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 98D2698612F
	for <virtio-dev@lists.oasis-open.org>; Fri, 19 Jun 2020 15:16:31 +0000 (UTC)
References: <87a7194kgt.fsf@linaro.org>
 <28614897-bfb7-b36c-6698-6c6942a87399@siemens.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <28614897-bfb7-b36c-6698-6c6942a87399@siemens.com>
Date: Fri, 19 Jun 2020 16:16:26 +0100
Message-ID: <87bllfulv9.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: Constraining where a guest may allocate virtio accessible
 resources
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: virtio-dev@lists.oasis-open.org, David Hildenbrand <david@redhat.com>, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Azzedine Touzni <atouzni@qti.qualcomm.com>, =?utf-8?Q?Fran=C3=A7ois?= Ozog <francois.ozog@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Soni, Trilok" <tsoni@quicinc.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 17.06.20 19:31, Alex Benn=C3=A9e wrote:
>>=20
>> Hi,
>>=20
>> This follows on from the discussion in the last thread I raised:
>>=20
>>   Subject: Backend libraries for VirtIO device emulation
>>   Date: Fri, 06 Mar 2020 18:33:57 +0000
>>   Message-ID: <874kv15o4q.fsf@linaro.org>
>>=20
>> To support the concept of a VirtIO backend having limited visibility of
>> a guests memory space there needs to be some mechanism to limit the
>> where that guest may place things. A simple VirtIO device can be
>> expressed purely in virt resources, for example:
>>=20
>>    * status, feature and config fields
>>    * notification/doorbell
>>    * one or more virtqueues
>>=20
>> Using a PCI backend the location of everything but the virtqueues it
>> controlled by the mapping of the PCI device so something that is
>> controllable by the host/hypervisor. However the guest is free to
>> allocate the virtqueues anywhere in the virtual address space of system
>> RAM.

Dave has helpfully reminded me the guest still has control in via the
BARs of where in the guests physical address space these PCI regions
exist. Although there is I believe a mechanism which allows for fixed
PCI regions.

<snip>
>>=20
>> Option 5 - Additional Device
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>=20
>> The final approach would be to tie the allocation of virtqueues to
>> memory regions as defined by additional devices. For example the
>> proposed IVSHMEMv2 spec offers the ability for the hypervisor to present
>> a fixed non-mappable region of the address space. Other proposals like
>> virtio-mem allow for hot plugging of "physical" memory into the guest
>> (conveniently treatable as separate shareable memory objects for QEMU
>> ;-).
>>=20
>
> I think you forgot one approach: virtual IOMMU. That is the advanced
> form of the grant table approach. The backend still "sees" the full
> address space of the frontend, but it will not be able to access all of
> it and there might even be a translation going on. Well, like IOMMUs
> work.

I can see how this works in the type-1 case with strict control of which
pages are visible to which domains of a system. In the QEMU KVM/TCG case
however the main process will always see the whole address space unless
there is something else (like SEV encryption) that allows it to peek the
guest. Maybe that can't be helped though but then the question is how
does it hand off a portion of the address space to either:

  - another userspace process in QEMU's domain
  - another userspace process in another VM

Maybe the problem of sharing memory between two processes in the same
domain and in different domains should be treated differently? The APIs
available to userspace<->userspace are different to
userspace<->hypervisor.

> However, this implies dynamics that are under guest control, namely of
> the frontend guest. And such dynamics can be counterproductive for
> certain scenarios. That's where this static windows of shared memory
> came up.
>
>>=20
>> Closing Thoughts and Open Questions
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> Currently all of this is considering just virtqueues themselves but of
>> course only a subset of devices interact purely by virtqueue messages.
>> Network and Block devices often end up filling up additional structures
>> in memory that are usually across the whole of system memory. To achieve
>> better isolation you either need to ensure that specific bits of kernel
>> allocation are done in certain regions (i.e. block cache in "shared"
>> region) or implement some sort of bounce buffer [1] that allows you to b=
ring
>> data from backend to frontend (which is more like the channel concept of
>> Xen's PV).
>
> For [1], look at https://lkml.org/lkml/2020/3/26/700 or at
> http://git.kiszka.org/?p=3Dlinux.git;a=3Dblob;f=3Ddrivers/virtio/virtio_i=
vshmem.c;hb=3Drefs/heads/queues/jailhouse
> (which should be using swiotlb one day).

So I guess this depends on dev_memremap being able to successfully allocate
the memory when the driver is initialised?

In the use cases I'm looking at I guess there will always be a trade off
between performance and security. I suspect for file-systems there is
too much benefit in being able to map pages directly into the primary
guests address space compared to a device which may be interacting with
an un-trusted component.

>> I suspect the solution will end up being a combination of all of these
>> approaches. There setup of different systems might mean we need a
>> plethora of ways to carve out and define regions in ways a kernel can
>> understand and make decisions about.
>>=20
>> I think there will always have to be an element of VirtIO config
>> involved as that is *the* mechanism by which front/back end negotiate if
>> they can get up and running in a way they are both happy with.
>>=20
>> One potential approach would be to introduce the concept of a region id
>> at the VirtIO config level which is simply a reasonably unique magic
>> number that virtio driver passes down into the kernel when requesting
>> memory for it's virtqueues. It could then be left to the kernel to
>> associate use that id when identifying the physical address range to
>> allocate from. This seems a bit of a loose binding between the driver
>> level and the kernel level but perhaps that is preferable to allow for
>> flexibility about how such regions are discovered by kernels?
>>=20
>> I hope this message hasn't rambled on to much. I feel this is a complex
>> topic and I'm want to be sure I've thought through all the potential
>> options before starting to prototype a solution. For those that have
>> made it this far the final questions are:
>>=20
>>   - is constraining guest allocation of virtqueues a reasonable requirem=
ent?
>>=20
>>   - could virtqueues ever be directly host/hypervisor assigned?
>>=20
>>   - should there be a tight or loose coupling between front-end driver
>>     and kernel/hypervisor support for allocating memory?
>>=20
>> Of course if this is all solvable with existing code I'd be more than
>> happy but please let me know how ;-)
>>=20
>
> Queues are a central element of virtio, but there is a (maintainability
> & security) benefit if you can keep them away from the hosting
> hypervisor, limit their interpretation and negotiation to the backend
> driver in a host process or in a backend guest VM. So I would be careful
> with coupling things too tightly.
>
> One of the issues I see in virtio for use in minimalistic hypervisors is
> the need to be aware of the different virtio devices when using PCI or
> MMIO transports. That's where a shared memory transport come into
> play.

Yes the majority of the use cases are for security isolation. For
example having a secure but un-trusted component provide some sort of
service to the main OS via a virtio-device. The ARM hypervisor model now
allows for both secure and non-secure hypervisors each with their
attendant kernel and user-mode layers. Hypervisors all the way down ;-)

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

