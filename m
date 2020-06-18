Return-Path: virtio-dev-return-7474-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7BE49985EFF
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 Jun 2020 13:30:33 +0000 (UTC)
Date: Thu, 18 Jun 2020 14:29:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200618132958.GB2013520@stefanha-x1.localdomain>
References: <87a7194kgt.fsf@linaro.org>
 <28614897-bfb7-b36c-6698-6c6942a87399@siemens.com>
MIME-Version: 1.0
In-Reply-To: <28614897-bfb7-b36c-6698-6c6942a87399@siemens.com>
Subject: Re: [virtio-dev] Re: Constraining where a guest may allocate virtio
 accessible resources
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, David Hildenbrand <david@redhat.com>, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Azzedine Touzni <atouzni@qti.qualcomm.com>, =?iso-8859-1?Q?Fran=E7ois?= Ozog <francois.ozog@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Soni, Trilok" <tsoni@quicinc.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2020 at 08:01:14PM +0200, Jan Kiszka wrote:
> On 17.06.20 19:31, Alex Benn=E9e wrote:
> >=20
> > Hi,
> >=20
> > This follows on from the discussion in the last thread I raised:
> >=20
> >   Subject: Backend libraries for VirtIO device emulation
> >   Date: Fri, 06 Mar 2020 18:33:57 +0000
> >   Message-ID: <874kv15o4q.fsf@linaro.org>
> >=20
> > To support the concept of a VirtIO backend having limited visibility of
> > a guests memory space there needs to be some mechanism to limit the
> > where that guest may place things. A simple VirtIO device can be
> > expressed purely in virt resources, for example:
> >=20
> >    * status, feature and config fields
> >    * notification/doorbell
> >    * one or more virtqueues
> >=20
> > Using a PCI backend the location of everything but the virtqueues it
> > controlled by the mapping of the PCI device so something that is
> > controllable by the host/hypervisor. However the guest is free to
> > allocate the virtqueues anywhere in the virtual address space of system
> > RAM.
> >=20
> > In theory this shouldn't matter because sharing virtual pages is just a
> > matter of putting the appropriate translations in place. However there
> > are multiple ways the host and guest may interact:
> >=20
> > * QEMU TCG
> >=20
> > QEMU sees a block of system memory in it's virtual address space that
> > has a one to one mapping with the guests physical address space. If QEM=
U
> > want to share a subset of that address space it can only realistically
> > do it for a contiguous region of it's address space which implies the
> > guest must use a contiguous region of it's physical address space.
> >=20
> > * QEMU KVM
> >=20
> > The situation here is broadly the same - although both QEMU and the
> > guest are seeing a their own virtual views of a linear address space
> > which may well actually be a fragmented set of physical pages on the
> > host.
> >=20
> > KVM based guests have additional constraints if they ever want to acces=
s
> > real hardware in the host as you need to ensure any address accessed by
> > the guest can be eventually translated into an address that can
> > physically access the bus which a device in one (for device
> > pass-through). The area also has to be DMA coherent so updates from a
> > bus are reliably visible to software accessing the same address space.
> >=20
> > * Xen (and other type-1's?)
> >=20
> > Here the situation is a little different because the guest explicitly
> > makes it's pages visible to other domains by way of grant tables. The
> > guest is still free to use whatever parts of its address space it wishe=
s
> > to. Other domains then request access to those pages via the hypervisor=
.
> >=20
> > In theory the requester is free to map the granted pages anywhere in
> > its own address space. However there are differences between the
> > architectures on how well this is supported.
> >=20
> > So I think this makes a case for having a mechanism by which the guest
> > can restrict it's allocation to a specific area of the guest physical
> > address space. The question is then what is the best way to inform the
> > guest kernel of the limitation?
> >=20
> > Option 1 - Kernel Command Line
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >=20
> > This isn't without precedent - the kernel supports options like "memmap=
"
> > which can with the appropriate amount of crafting be used to carve out
> > sections of bad ram from the physical address space. Other formulations
> > can be used to mark specific areas of the address space as particular
> > types of memory. =20
> >=20
> > However there are cons to this approach as it then becomes a job for
> > whatever builds the VMM command lines to ensure the both the backend an=
d
> > the kernel know where things are. It is also very Linux centric and
> > doesn't solve the problem for other guest OSes. Considering the rest of
> > VirtIO can be made discover-able this seems like it would be a backward
> > step.
> >=20
> > Option 2 - Additional Platform Data
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > This would be extending using something like device tree or ACPI tables
> > which could define regions of memory that would inform the low level
> > memory allocation routines where they could allocate from. There is
> > already of the concept of "dma-ranges" in device tree which can be a
> > per-device property which defines the region of space that is DMA
> > coherent for a device.
> >=20
> > There is the question of how you tie regions declared here with the
> > eventual instantiating of the VirtIO devices?
> >=20
> > For a fully distributed set of backends (one backend per device per
> > worker VM) you would need several different regions. Would each region
> > be tied to each device or just a set of areas the guest would allocate
> > from in sequence?
> >=20
> > Option 3 - Abusing PCI Regions
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >=20
> > One of the reasons to use the VirtIO PCI backend it to help with
> > automatic probing and setup. Could we define a new PCI region which on
> > backend just maps to RAM but from the front-ends point of view is a
> > region it can allocate it's virtqueues? Could we go one step further an=
d
> > just let the host to define and allocate the virtqueue in the reserved
> > PCI space and pass the base of it somehow?
> >=20
> > Options 4 - Extend VirtIO Config
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Another approach would be to extend the VirtIO configuration and
> > start-up handshake to supply these limitations to the guest. This could
> > be handled by the addition of a feature bit (VIRTIO_F_HOST_QUEUE?) and
> > additional configuration information.
> >=20
> > One problem I can foresee is device initialisation is usually done
> > fairly late in the start-up of a kernel by which time any memory zoning
> > restrictions will likely need to have informed the kernels low level
> > memory management. Does that mean we would have to combine such a
> > feature behaviour with a another method anyway?
> >=20
> > Option 5 - Additional Device
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >=20
> > The final approach would be to tie the allocation of virtqueues to
> > memory regions as defined by additional devices. For example the
> > proposed IVSHMEMv2 spec offers the ability for the hypervisor to presen=
t
> > a fixed non-mappable region of the address space. Other proposals like
> > virtio-mem allow for hot plugging of "physical" memory into the guest
> > (conveniently treatable as separate shareable memory objects for QEMU
> > ;-).
> >=20
>=20
> I think you forgot one approach: virtual IOMMU. That is the advanced
> form of the grant table approach. The backend still "sees" the full
> address space of the frontend, but it will not be able to access all of
> it and there might even be a translation going on. Well, like IOMMUs work=
.
>=20
> However, this implies dynamics that are under guest control, namely of
> the frontend guest. And such dynamics can be counterproductive for
> certain scenarios. That's where this static windows of shared memory
> came up.

Yes, I think IOMMU interfaces are worth investigating more too. IOMMUs
are now widely implemented in Linux and virtualization software. That
means guest modifications aren't necessary and unmodified guest
applications will run.

Applications that need the best performance can use a static mapping
while applications that want the strongest isolation can map/unmap DMA
buffers dynamically.

Stefan

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7rbFYACgkQnKSrs4Gr
c8i+PQf/avdmcSizpP9A/KX10uZZt0k4Amj+Ci9IAIkRwjrIL8fIWFPI2UC26IFZ
SCcoS5PE974HWN1GnbezwAC/CCdfwpp21QxoFdY3KWUnL9sG63XwMIbmjoAPC3DV
UmEyKz9B8tRVo6bjTc/K/RyIXr65oqDZB/+JmSZC+pRtgEdHKrjrP0d82r6vUs64
Te/nsVm5RCoTd89fjbcZPjfGKbSeRsz02scCNcOSauOQ93EIsWTYCQvbYKP/KvxT
NJjqkToCGk7URGyXw/nmLZMPd/KU3JxMUpPLWeZTfTwtfz6a798oM0WnC7UdS0Up
D/Sqhr6pHBaCK4iOsnFaPagZ///CcQ==
=uAVL
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

