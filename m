Return-Path: virtio-dev-return-7523-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA61C98600C
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Jul 2020 13:14:28 +0000 (UTC)
Date: Fri, 3 Jul 2020 14:14:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200703131410.GB191363@stefanha-x1.localdomain>
References: <87a7194kgt.fsf@linaro.org>
 <20200618132515.GA2013520@stefanha-x1.localdomain>
 <87zh8zt0us.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87zh8zt0us.fsf@linaro.org>
Subject: [virtio-dev] Re: Constraining where a guest may allocate virtio accessible
 resources
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, David Hildenbrand <david@redhat.com>, jan.kiszka@siemens.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Azzedine Touzni <atouzni@qti.qualcomm.com>, =?iso-8859-1?Q?Fran=E7ois?= Ozog <francois.ozog@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Soni, Trilok" <tsoni@quicinc.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2020 at 06:35:39PM +0100, Alex Benn=E9e wrote:
>=20
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > On Wed, Jun 17, 2020 at 06:31:15PM +0100, Alex Benn=E9e wrote:
> >> This follows on from the discussion in the last thread I raised:
> >>=20
> >>   Subject: Backend libraries for VirtIO device emulation
> >>   Date: Fri, 06 Mar 2020 18:33:57 +0000
> >>   Message-ID: <874kv15o4q.fsf@linaro.org>
> >>=20
> >> To support the concept of a VirtIO backend having limited visibility o=
f
> >
> > It's unclear what we're discussing. Does "VirtIO backend" mean
> > vhost-user devices?
> >
> > Can you describe what you are trying to do?
> >
>=20
> Yes - although eventually the vhost-user device might be hosted in a
> separate VM. See this contrived architecture diagram:
>=20
>                                                    |                     =
                               =20
>                 Secure World                       |          Non-secure =
world                =20
>                                                    |   +-----------------=
---+  +---------------+ =20
>                                                    |   |c1AB             =
   |  |cGRE           | =20
>                                                    |   |                 =
   |  |               | =20
>                                                    |   |     Primary OS  =
   |  |   Secondary   | =20
>                                                    |   |      (android)  =
   |  |      VM       | =20
>          +--------------+                          |   |                 =
   |  |               | =20
>          |cYEL          |                          |   |                 =
   |  |   (Backend)   | =20
>          |              |                          |   |                 =
   |  +---------------+ =20
>          |              |                          |   |                 =
   |                  =20
>          |  Untrusted   |                          |   |                 =
   |                  =20
>          |              |                          |   |                 =
   |  +---------------+ =20
>    EL0   |   Service    |                          |   |                 =
   |  |cGRE           |
>     .    |              |                          |   |                 =
   |  |               |
>     .    |              |                          :   | +---------------=
-+ |  |   Secondary   |
>     .    |              |                          |   | |{io} VirtIO    =
 | |  |      VM       |
>    EL1   |              |                          |   | |               =
 | |  |               |
>          |  (Backend)   |                          |   | +---------------=
-+ |  |   (Backend)   |
>          +--------------+                          |   +----------------+=
---+  +---------------+
>                                                    |                     =
                  =20
>          +-------------------------------------+   |   +-----------------=
----------------------+
>          |cPNK                                 |   |   |cGRE             =
                      |
>    EL2   |        Secure Hypervisor            |   |   |          Non-sec=
ure Hypervisor        |
>          |                                     |   |   |                 =
                      |
>          +-------------------------------------+   |   +-----------------=
----------------------+
>                                                    +---------------------=
--------------------------
>          +---------------------------------------------------------------=
----------------------+
>          |cRED                                                           =
                      |
>    EL3   |                                  Secure Firmware              =
                      |
>          |                                                               =
                      |
>          +---------------------------------------------------------------=
----------------------+
>   ----=3D----------------------------------------------------------------=
-------------------------  =20
>          +------------------------+ +-------------------------+ +--------=
----------------------+
>          | c444                   | | {s}                c444 | | {io}   =
                 c444 |
>    HW    |        Compute         | |         Storage         | |        =
     I/O              |
>          |  (CPUs, GPUs, Accel)   | |  (Flash, Secure Flash)  | |   Netwo=
rk, USB, Peripherals  |
>          |                        | |                         | |        =
                      |
>          +------------------------+ +-------------------------+ +--------=
----------------------+
>=20
> Here the primary OS is connected to the work through VirtIO devices
> (acting as a common HAL). Each individual device might have a secondary
> VM associated with it. Some devices might be virtual - for example a 3rd
> party DRM module. It would be un-trusted so doesn't run as part of the
> secure firmware but it might still need to access secure resources like
> a key store or a video port.
>=20
> For all these backends they should only have access to the minimum
> amount of the primary OS's memory space that they need to fulfil their
> job. While the non-secure hypervisor could be something like KVM it's
> likely the secure one will be a much more lightweight type-1 hypervisor.

This is possible with vhost-user + virtio-vhost-user:

Expose a subset of the Primary VM's memory over vhost-user to the
Secondary VM. Normally all guest RAM is exposed over vhost-user, but
it's simple to expose only a subset. The DMA region needs to be its own
file descriptor (not a larger memfd that also contains other guest RAM)
since vhost-user uses file descriptor passing to share memory.

The "Guest Physical Addresses" in virtqueues don't need to be
translated, they can be the same GPAs used inside the guest. The
Secondary just have access to GPAs outside the memfd region(s) that have
been provided by the Primary.

The guest drivers in the Primary will need to copy buffers to the DMA
memory region if existing applications are not aware of DMA address
contraints.

Nikos Dragazis has DPDK and SPDK code with virtio-vhost-user support, so
you could use that as a starting point to add DMA constraints. The
Secondary either emulates a virtio-net (DPDK) device or a virtio-scsi
(SPDK) device:

https://ndragazis.github.io/spdk.html

The missing pieces are:

1. A way to associate memory backends with vhost-user devices so the
   Primary knows which memory to expose:

     -object memory-backend-memfd,id=3Dfoo,...
     -device vhost-user-scsi-pci,memory-backend[0]=3Dfoo,...

   Now the vhost-uesr-scsi-pci device will only expose the 'foo' memfd
   over vhost-user, not all of guest RAM.

2. A way to communicate per-device DMA address restrictions to the
   Primary OS and the necessary driver memory allocation changes and/or
   bounce buffers.

Adding those two things on top of virtio-vhost-user will do what you've
described in the diagram.

> My interest in including TCG in this mix is for early prototyping and
> ease of debugging when working with this towering array of layers ;-)

Once TCG works with vhost-user it will also work with virtio-vhost-user.

> >> a guests memory space there needs to be some mechanism to limit the
> >> where that guest may place things.
> >
> > Or an enforcing IOMMU? In other words, an IOMMU that only gives access
> > to memory that has been put forth for DMA.
> >
> > This was discussed recently in the context of the ongoing
> > vfio-over-socket work ("RFC: use VFIO over a UNIX domain socket to
> > implement device offloading" on qemu-devel). The idea is to use the VFI=
O
> > protocol but over UNIX domain sockets to another host userspace process
> > instead of over ioctls to the kernel VFIO drivers. This would allow
> > arbitary devices to be emulated in a separate process from QEMU. As a
> > first step I suggested DMA_READ/DMA_WRITE protocol messages, even thoug=
h
> > this will have poor performance.
>=20
> This is still mediated by a kernel though right?

The host kernel? The guest kernel?

It's possible to have a vIOMMU in the guest and no host kernel IOMMU.

The guest kernel needs to support the vIOMMU. Infrastructure is there in
Linux since the vIOMMU can already be used already for device
passthrough.

> > I think finding a solution for an enforcing IOMMU is preferrable to
> > guest cooperation. The problem with guest cooperation is that you may b=
e
> > able to get new VIRTIO guest drivers to restrict where the virtqueues
> > are placed, but what about applications (e.g. O_DIRECT disk I/O, networ=
k
> > packets) with memory buffers at arbitrary addresses?
>=20
> The virtqueues are the simple case but yes it gets complex for the rest
> of the data - the simple case is handled by a bounce buffer which the
> guest then copies from into it's own secure address space.
>=20
> > Modifying guest applications to honor buffer memory restrictions is too
> > disruptive for most use cases.
> >
> >> A simple VirtIO device can be
> >> expressed purely in virt resources, for example:
> >>=20
> >>    * status, feature and config fields
> >>    * notification/doorbell
> >>    * one or more virtqueues
> >>=20
> >> Using a PCI backend the location of everything but the virtqueues it
> >> controlled by the mapping of the PCI device so something that is
> >> controllable by the host/hypervisor. However the guest is free to
> >> allocate the virtqueues anywhere in the virtual address space of syste=
m
> >> RAM.
> >>=20
> >> In theory this shouldn't matter because sharing virtual pages is just =
a
> >> matter of putting the appropriate translations in place. However there
> >> are multiple ways the host and guest may interact:
> >>=20
> >> * QEMU TCG
> >>=20
> >> QEMU sees a block of system memory in it's virtual address space that
> >> has a one to one mapping with the guests physical address space. If QE=
MU
> >> want to share a subset of that address space it can only realistically
> >> do it for a contiguous region of it's address space which implies the
> >> guest must use a contiguous region of it's physical address space.
> >
> > This paragraph doesn't reflect my understanding. There can be multiple
> > RAMBlocks. There isn't necessarily just 1 contiguous piece of RAM.
> >
> >>=20
> >> * QEMU KVM
> >>=20
> >> The situation here is broadly the same - although both QEMU and the
> >> guest are seeing a their own virtual views of a linear address space
> >> which may well actually be a fragmented set of physical pages on the
> >> host.
> >
> > I don't understand the "although" part. Isn't the situation the same as
> > with TCG, where guest physical memory ranges can cross RAMBlock
> > boundaries?
>=20
> You are correct - I was over simplifying. This is why I was thinking
> about the virtio-mem device. That would have it's own RAMBlock which
> could be the only one with an associated shared memory object.
>=20
> >> KVM based guests have additional constraints if they ever want to acce=
ss
> >> real hardware in the host as you need to ensure any address accessed b=
y
> >> the guest can be eventually translated into an address that can
> >> physically access the bus which a device in one (for device
> >> pass-through). The area also has to be DMA coherent so updates from a
> >> bus are reliably visible to software accessing the same address space.
> >
> > I'm surprised about the DMA coherency sentence. Dont't VFIO and other
> > userspace I/O APIs provide the DMA APIs allowing applications to deal
> > with caches/coherency?
>=20
> Yes - but the kernel has to ensure the buffers used by these APIs are
> allocated in regions that meet the requirements.

Is coherency as issue for software devices? Normally software device
implementations respect memory ordering (e.g. by using memory barriers)
but there is nothing else to worry about.

> >
> >>=20
> >> * Xen (and other type-1's?)
> >>=20
> >> Here the situation is a little different because the guest explicitly
> >> makes it's pages visible to other domains by way of grant tables. The
> >> guest is still free to use whatever parts of its address space it wish=
es
> >> to. Other domains then request access to those pages via the hyperviso=
r.
> >>=20
> >> In theory the requester is free to map the granted pages anywhere in
> >> its own address space. However there are differences between the
> >> architectures on how well this is supported.
> >>=20
> >> So I think this makes a case for having a mechanism by which the guest
> >> can restrict it's allocation to a specific area of the guest physical
> >> address space. The question is then what is the best way to inform the
> >> guest kernel of the limitation?
> >
> > As mentioned above, I don't think it's possible to do this without
> > modifying applications - which is not possible in many use cases.
> > Instead we could improve IOMMU support so that this works transparently=
.
>=20
> Yes. So the IOMMU allows the guest to mark all the pages associated with
> a particular device and it's transactions but how do we map that to the
> userspace view which in controlled in software?

The userspace device implementation in the Secondary? vhost-user
supports vIOMMU address translation. It asks the vIOMMU to translate a
IOVA to a GPA. The problem is that the device can still access all of
guest RAM. I'm not aware of a fast and secure interface for changing
mmaps in another process :( so it seems tricky to achieve this.

If you care more about security than performance you can add DMA
read/write messages to the vhost-user protocol. The Secondary will the
perform each DMA read/write by sending a message to the Primary
including the data that needs to be transferred.

To get slightly better performance this could be enhanced with
traditional shared memory regions for the virtqueues so that at least
the vring can be accessed via shared memory. Then only indirect
descriptor tables and the actual data buffers need to take the slow
path through the Primary.

Stefan

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7/LyIACgkQnKSrs4Gr
c8iAcQf/cc5ut6NTHWHdf0ZElxWDT441/ihOdMUdWXrbRH7X5rZRLRKlQqtcgNBX
ujIBEZ0OzmiSDJPNK7I1XgXWHQoIP75miLjL62QS1yfPCf33lYUnYKFDZwciUW10
L0llFrfE8IiVoi0vyOrUbYzUn/iSbeIRzxcC9BFz/IZwfs9xlzklmM4nJh+FMUd7
4v6wsyfj3g1B6QmnD/YFe6IjlWftbAASA+DMPhHVWlJqVHIDaACXM6q8MabYp5YW
mVKPcGYf7YCRZ95jmhwvxfAyTqi8OGdcTOhXBZHFEU+JBohnYmIyk+WO9IaLcH+o
5Kri6sDDe6uOPrjZQ7fkarkCvGGCzA==
=bKIa
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--

