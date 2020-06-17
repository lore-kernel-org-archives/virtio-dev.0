Return-Path: virtio-dev-return-7468-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 13FF4985EA0
	for <virtio-dev@lists.oasis-open.org>; Wed, 17 Jun 2020 17:31:20 +0000 (UTC)
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <87a7194kgt.fsf@linaro.org>
Date: Wed, 17 Jun 2020 18:31:15 +0100
MIME-Version: 1.0
Subject: [virtio-dev] Constraining where a guest may allocate virtio accessible resources
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: David Hildenbrand <david@redhat.com>, jan.kiszka@siemens.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Azzedine Touzni <atouzni@qti.qualcomm.com>, =?utf-8?Q?Fran=C3=A7ois?= Ozog <francois.ozog@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Soni, Trilok" <tsoni@quicinc.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>


Hi,

This follows on from the discussion in the last thread I raised:

  Subject: Backend libraries for VirtIO device emulation
  Date: Fri, 06 Mar 2020 18:33:57 +0000
  Message-ID: <874kv15o4q.fsf@linaro.org>

To support the concept of a VirtIO backend having limited visibility of
a guests memory space there needs to be some mechanism to limit the
where that guest may place things. A simple VirtIO device can be
expressed purely in virt resources, for example:

   * status, feature and config fields
   * notification/doorbell
   * one or more virtqueues

Using a PCI backend the location of everything but the virtqueues it
controlled by the mapping of the PCI device so something that is
controllable by the host/hypervisor. However the guest is free to
allocate the virtqueues anywhere in the virtual address space of system
RAM.

In theory this shouldn't matter because sharing virtual pages is just a
matter of putting the appropriate translations in place. However there
are multiple ways the host and guest may interact:

* QEMU TCG

QEMU sees a block of system memory in it's virtual address space that
has a one to one mapping with the guests physical address space. If QEMU
want to share a subset of that address space it can only realistically
do it for a contiguous region of it's address space which implies the
guest must use a contiguous region of it's physical address space.

* QEMU KVM

The situation here is broadly the same - although both QEMU and the
guest are seeing a their own virtual views of a linear address space
which may well actually be a fragmented set of physical pages on the
host.

KVM based guests have additional constraints if they ever want to access
real hardware in the host as you need to ensure any address accessed by
the guest can be eventually translated into an address that can
physically access the bus which a device in one (for device
pass-through). The area also has to be DMA coherent so updates from a
bus are reliably visible to software accessing the same address space.

* Xen (and other type-1's?)

Here the situation is a little different because the guest explicitly
makes it's pages visible to other domains by way of grant tables. The
guest is still free to use whatever parts of its address space it wishes
to. Other domains then request access to those pages via the hypervisor.

In theory the requester is free to map the granted pages anywhere in
its own address space. However there are differences between the
architectures on how well this is supported.

So I think this makes a case for having a mechanism by which the guest
can restrict it's allocation to a specific area of the guest physical
address space. The question is then what is the best way to inform the
guest kernel of the limitation?

Option 1 - Kernel Command Line
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

This isn't without precedent - the kernel supports options like "memmap"
which can with the appropriate amount of crafting be used to carve out
sections of bad ram from the physical address space. Other formulations
can be used to mark specific areas of the address space as particular
types of memory. =20

However there are cons to this approach as it then becomes a job for
whatever builds the VMM command lines to ensure the both the backend and
the kernel know where things are. It is also very Linux centric and
doesn't solve the problem for other guest OSes. Considering the rest of
VirtIO can be made discover-able this seems like it would be a backward
step.

Option 2 - Additional Platform Data
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This would be extending using something like device tree or ACPI tables
which could define regions of memory that would inform the low level
memory allocation routines where they could allocate from. There is
already of the concept of "dma-ranges" in device tree which can be a
per-device property which defines the region of space that is DMA
coherent for a device.

There is the question of how you tie regions declared here with the
eventual instantiating of the VirtIO devices?

For a fully distributed set of backends (one backend per device per
worker VM) you would need several different regions. Would each region
be tied to each device or just a set of areas the guest would allocate
from in sequence?

Option 3 - Abusing PCI Regions
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

One of the reasons to use the VirtIO PCI backend it to help with
automatic probing and setup. Could we define a new PCI region which on
backend just maps to RAM but from the front-ends point of view is a
region it can allocate it's virtqueues? Could we go one step further and
just let the host to define and allocate the virtqueue in the reserved
PCI space and pass the base of it somehow?

Options 4 - Extend VirtIO Config
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

Another approach would be to extend the VirtIO configuration and
start-up handshake to supply these limitations to the guest. This could
be handled by the addition of a feature bit (VIRTIO_F_HOST_QUEUE?) and
additional configuration information.

One problem I can foresee is device initialisation is usually done
fairly late in the start-up of a kernel by which time any memory zoning
restrictions will likely need to have informed the kernels low level
memory management. Does that mean we would have to combine such a
feature behaviour with a another method anyway?

Option 5 - Additional Device
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

The final approach would be to tie the allocation of virtqueues to
memory regions as defined by additional devices. For example the
proposed IVSHMEMv2 spec offers the ability for the hypervisor to present
a fixed non-mappable region of the address space. Other proposals like
virtio-mem allow for hot plugging of "physical" memory into the guest
(conveniently treatable as separate shareable memory objects for QEMU
;-).


Closing Thoughts and Open Questions
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Currently all of this is considering just virtqueues themselves but of
course only a subset of devices interact purely by virtqueue messages.
Network and Block devices often end up filling up additional structures
in memory that are usually across the whole of system memory. To achieve
better isolation you either need to ensure that specific bits of kernel
allocation are done in certain regions (i.e. block cache in "shared"
region) or implement some sort of bounce buffer [1] that allows you to brin=
g
data from backend to frontend (which is more like the channel concept of
Xen's PV).

I suspect the solution will end up being a combination of all of these
approaches. There setup of different systems might mean we need a
plethora of ways to carve out and define regions in ways a kernel can
understand and make decisions about.

I think there will always have to be an element of VirtIO config
involved as that is *the* mechanism by which front/back end negotiate if
they can get up and running in a way they are both happy with.

One potential approach would be to introduce the concept of a region id
at the VirtIO config level which is simply a reasonably unique magic
number that virtio driver passes down into the kernel when requesting
memory for it's virtqueues. It could then be left to the kernel to
associate use that id when identifying the physical address range to
allocate from. This seems a bit of a loose binding between the driver
level and the kernel level but perhaps that is preferable to allow for
flexibility about how such regions are discovered by kernels?

I hope this message hasn't rambled on to much. I feel this is a complex
topic and I'm want to be sure I've thought through all the potential
options before starting to prototype a solution. For those that have
made it this far the final questions are:

  - is constraining guest allocation of virtqueues a reasonable requirement=
?

  - could virtqueues ever be directly host/hypervisor assigned?

  - should there be a tight or loose coupling between front-end driver
    and kernel/hypervisor support for allocating memory?

Of course if this is all solvable with existing code I'd be more than
happy but please let me know how ;-)

Regards,


--=20
Alex Benn=C3=A9e

[1] Example bounce buffer approach

Subject: [PATCH 0/5] virtio on Type-1 hypervisor
Message-Id: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

