Return-Path: virtio-dev-return-7494-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F76A986130
	for <virtio-dev@lists.oasis-open.org>; Fri, 19 Jun 2020 17:35:43 +0000 (UTC)
References: <87a7194kgt.fsf@linaro.org>
 <20200618132515.GA2013520@stefanha-x1.localdomain>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20200618132515.GA2013520@stefanha-x1.localdomain>
Date: Fri, 19 Jun 2020 18:35:39 +0100
Message-ID: <87zh8zt0us.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: Constraining where a guest may allocate virtio accessible
 resources
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, David Hildenbrand <david@redhat.com>, jan.kiszka@siemens.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Azzedine Touzni <atouzni@qti.qualcomm.com>, =?utf-8?Q?Fran=C3=A7ois?= Ozog <francois.ozog@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Soni, Trilok" <tsoni@quicinc.com>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>


Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Wed, Jun 17, 2020 at 06:31:15PM +0100, Alex Benn=C3=A9e wrote:
>> This follows on from the discussion in the last thread I raised:
>>=20
>>   Subject: Backend libraries for VirtIO device emulation
>>   Date: Fri, 06 Mar 2020 18:33:57 +0000
>>   Message-ID: <874kv15o4q.fsf@linaro.org>
>>=20
>> To support the concept of a VirtIO backend having limited visibility of
>
> It's unclear what we're discussing. Does "VirtIO backend" mean
> vhost-user devices?
>
> Can you describe what you are trying to do?
>

Yes - although eventually the vhost-user device might be hosted in a
separate VM. See this contrived architecture diagram:

                                                   |                       =
                             =20
                Secure World                       |          Non-secure wo=
rld                =20
                                                   |   +-------------------=
-+  +---------------+ =20
                                                   |   |c1AB               =
 |  |cGRE           | =20
                                                   |   |                   =
 |  |               | =20
                                                   |   |     Primary OS    =
 |  |   Secondary   | =20
                                                   |   |      (android)    =
 |  |      VM       | =20
         +--------------+                          |   |                   =
 |  |               | =20
         |cYEL          |                          |   |                   =
 |  |   (Backend)   | =20
         |              |                          |   |                   =
 |  +---------------+ =20
         |              |                          |   |                   =
 |                  =20
         |  Untrusted   |                          |   |                   =
 |                  =20
         |              |                          |   |                   =
 |  +---------------+ =20
   EL0   |   Service    |                          |   |                   =
 |  |cGRE           |
    .    |              |                          |   |                   =
 |  |               |
    .    |              |                          :   | +----------------+=
 |  |   Secondary   |
    .    |              |                          |   | |{io} VirtIO     |=
 |  |      VM       |
   EL1   |              |                          |   | |                |=
 |  |               |
         |  (Backend)   |                          |   | +----------------+=
 |  |   (Backend)   |
         +--------------+                          |   +----------------+--=
-+  +---------------+
                                                   |                       =
                =20
         +-------------------------------------+   |   +-------------------=
--------------------+
         |cPNK                                 |   |   |cGRE               =
                    |
   EL2   |        Secure Hypervisor            |   |   |          Non-secur=
e Hypervisor        |
         |                                     |   |   |                   =
                    |
         +-------------------------------------+   |   +-------------------=
--------------------+
                                                   +-----------------------=
------------------------
         +-----------------------------------------------------------------=
--------------------+
         |cRED                                                             =
                    |
   EL3   |                                  Secure Firmware                =
                    |
         |                                                                 =
                    |
         +-----------------------------------------------------------------=
--------------------+
  ----=3D------------------------------------------------------------------=
-----------------------  =20
         +------------------------+ +-------------------------+ +----------=
--------------------+
         | c444                   | | {s}                c444 | | {io}     =
               c444 |
   HW    |        Compute         | |         Storage         | |          =
   I/O              |
         |  (CPUs, GPUs, Accel)   | |  (Flash, Secure Flash)  | |   Network=
, USB, Peripherals  |
         |                        | |                         | |          =
                    |
         +------------------------+ +-------------------------+ +----------=
--------------------+

Here the primary OS is connected to the work through VirtIO devices
(acting as a common HAL). Each individual device might have a secondary
VM associated with it. Some devices might be virtual - for example a 3rd
party DRM module. It would be un-trusted so doesn't run as part of the
secure firmware but it might still need to access secure resources like
a key store or a video port.

For all these backends they should only have access to the minimum
amount of the primary OS's memory space that they need to fulfil their
job. While the non-secure hypervisor could be something like KVM it's
likely the secure one will be a much more lightweight type-1 hypervisor.

My interest in including TCG in this mix is for early prototyping and
ease of debugging when working with this towering array of layers ;-)

>> a guests memory space there needs to be some mechanism to limit the
>> where that guest may place things.
>
> Or an enforcing IOMMU? In other words, an IOMMU that only gives access
> to memory that has been put forth for DMA.
>
> This was discussed recently in the context of the ongoing
> vfio-over-socket work ("RFC: use VFIO over a UNIX domain socket to
> implement device offloading" on qemu-devel). The idea is to use the VFIO
> protocol but over UNIX domain sockets to another host userspace process
> instead of over ioctls to the kernel VFIO drivers. This would allow
> arbitary devices to be emulated in a separate process from QEMU. As a
> first step I suggested DMA_READ/DMA_WRITE protocol messages, even though
> this will have poor performance.

This is still mediated by a kernel though right?

> I think finding a solution for an enforcing IOMMU is preferrable to
> guest cooperation. The problem with guest cooperation is that you may be
> able to get new VIRTIO guest drivers to restrict where the virtqueues
> are placed, but what about applications (e.g. O_DIRECT disk I/O, network
> packets) with memory buffers at arbitrary addresses?

The virtqueues are the simple case but yes it gets complex for the rest
of the data - the simple case is handled by a bounce buffer which the
guest then copies from into it's own secure address space.

> Modifying guest applications to honor buffer memory restrictions is too
> disruptive for most use cases.
>
>> A simple VirtIO device can be
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
>>=20
>> In theory this shouldn't matter because sharing virtual pages is just a
>> matter of putting the appropriate translations in place. However there
>> are multiple ways the host and guest may interact:
>>=20
>> * QEMU TCG
>>=20
>> QEMU sees a block of system memory in it's virtual address space that
>> has a one to one mapping with the guests physical address space. If QEMU
>> want to share a subset of that address space it can only realistically
>> do it for a contiguous region of it's address space which implies the
>> guest must use a contiguous region of it's physical address space.
>
> This paragraph doesn't reflect my understanding. There can be multiple
> RAMBlocks. There isn't necessarily just 1 contiguous piece of RAM.
>
>>=20
>> * QEMU KVM
>>=20
>> The situation here is broadly the same - although both QEMU and the
>> guest are seeing a their own virtual views of a linear address space
>> which may well actually be a fragmented set of physical pages on the
>> host.
>
> I don't understand the "although" part. Isn't the situation the same as
> with TCG, where guest physical memory ranges can cross RAMBlock
> boundaries?

You are correct - I was over simplifying. This is why I was thinking
about the virtio-mem device. That would have it's own RAMBlock which
could be the only one with an associated shared memory object.

>> KVM based guests have additional constraints if they ever want to access
>> real hardware in the host as you need to ensure any address accessed by
>> the guest can be eventually translated into an address that can
>> physically access the bus which a device in one (for device
>> pass-through). The area also has to be DMA coherent so updates from a
>> bus are reliably visible to software accessing the same address space.
>
> I'm surprised about the DMA coherency sentence. Dont't VFIO and other
> userspace I/O APIs provide the DMA APIs allowing applications to deal
> with caches/coherency?

Yes - but the kernel has to ensure the buffers used by these APIs are
allocated in regions that meet the requirements.

>
>>=20
>> * Xen (and other type-1's?)
>>=20
>> Here the situation is a little different because the guest explicitly
>> makes it's pages visible to other domains by way of grant tables. The
>> guest is still free to use whatever parts of its address space it wishes
>> to. Other domains then request access to those pages via the hypervisor.
>>=20
>> In theory the requester is free to map the granted pages anywhere in
>> its own address space. However there are differences between the
>> architectures on how well this is supported.
>>=20
>> So I think this makes a case for having a mechanism by which the guest
>> can restrict it's allocation to a specific area of the guest physical
>> address space. The question is then what is the best way to inform the
>> guest kernel of the limitation?
>
> As mentioned above, I don't think it's possible to do this without
> modifying applications - which is not possible in many use cases.
> Instead we could improve IOMMU support so that this works transparently.

Yes. So the IOMMU allows the guest to mark all the pages associated with
a particular device and it's transactions but how do we map that to the
userspace view which in controlled in software?

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

