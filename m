Return-Path: virtio-dev-return-7473-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E3DF4985EFF
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 Jun 2020 13:25:41 +0000 (UTC)
Date: Thu, 18 Jun 2020 14:25:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200618132515.GA2013520@stefanha-x1.localdomain>
References: <87a7194kgt.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87a7194kgt.fsf@linaro.org>
Subject: [virtio-dev] Re: Constraining where a guest may allocate virtio accessible
 resources
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, David Hildenbrand <david@redhat.com>, jan.kiszka@siemens.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Azzedine Touzni <atouzni@qti.qualcomm.com>, =?iso-8859-1?Q?Fran=E7ois?= Ozog <francois.ozog@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Soni, Trilok" <tsoni@quicinc.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2020 at 06:31:15PM +0100, Alex Benn=E9e wrote:
> This follows on from the discussion in the last thread I raised:
>=20
>   Subject: Backend libraries for VirtIO device emulation
>   Date: Fri, 06 Mar 2020 18:33:57 +0000
>   Message-ID: <874kv15o4q.fsf@linaro.org>
>=20
> To support the concept of a VirtIO backend having limited visibility of

It's unclear what we're discussing. Does "VirtIO backend" mean
vhost-user devices?

Can you describe what you are trying to do?

> a guests memory space there needs to be some mechanism to limit the
> where that guest may place things.

Or an enforcing IOMMU? In other words, an IOMMU that only gives access
to memory that has been put forth for DMA.

This was discussed recently in the context of the ongoing
vfio-over-socket work ("RFC: use VFIO over a UNIX domain socket to
implement device offloading" on qemu-devel). The idea is to use the VFIO
protocol but over UNIX domain sockets to another host userspace process
instead of over ioctls to the kernel VFIO drivers. This would allow
arbitary devices to be emulated in a separate process from QEMU. As a
first step I suggested DMA_READ/DMA_WRITE protocol messages, even though
this will have poor performance.

I think finding a solution for an enforcing IOMMU is preferrable to
guest cooperation. The problem with guest cooperation is that you may be
able to get new VIRTIO guest drivers to restrict where the virtqueues
are placed, but what about applications (e.g. O_DIRECT disk I/O, network
packets) with memory buffers at arbitrary addresses?

Modifying guest applications to honor buffer memory restrictions is too
disruptive for most use cases.

> A simple VirtIO device can be
> expressed purely in virt resources, for example:
>=20
>    * status, feature and config fields
>    * notification/doorbell
>    * one or more virtqueues
>=20
> Using a PCI backend the location of everything but the virtqueues it
> controlled by the mapping of the PCI device so something that is
> controllable by the host/hypervisor. However the guest is free to
> allocate the virtqueues anywhere in the virtual address space of system
> RAM.
>=20
> In theory this shouldn't matter because sharing virtual pages is just a
> matter of putting the appropriate translations in place. However there
> are multiple ways the host and guest may interact:
>=20
> * QEMU TCG
>=20
> QEMU sees a block of system memory in it's virtual address space that
> has a one to one mapping with the guests physical address space. If QEMU
> want to share a subset of that address space it can only realistically
> do it for a contiguous region of it's address space which implies the
> guest must use a contiguous region of it's physical address space.

This paragraph doesn't reflect my understanding. There can be multiple
RAMBlocks. There isn't necessarily just 1 contiguous piece of RAM.

>=20
> * QEMU KVM
>=20
> The situation here is broadly the same - although both QEMU and the
> guest are seeing a their own virtual views of a linear address space
> which may well actually be a fragmented set of physical pages on the
> host.

I don't understand the "although" part. Isn't the situation the same as
with TCG, where guest physical memory ranges can cross RAMBlock
boundaries?

>=20
> KVM based guests have additional constraints if they ever want to access
> real hardware in the host as you need to ensure any address accessed by
> the guest can be eventually translated into an address that can
> physically access the bus which a device in one (for device
> pass-through). The area also has to be DMA coherent so updates from a
> bus are reliably visible to software accessing the same address space.

I'm surprised about the DMA coherency sentence. Dont't VFIO and other
userspace I/O APIs provide the DMA APIs allowing applications to deal
with caches/coherency?

>=20
> * Xen (and other type-1's?)
>=20
> Here the situation is a little different because the guest explicitly
> makes it's pages visible to other domains by way of grant tables. The
> guest is still free to use whatever parts of its address space it wishes
> to. Other domains then request access to those pages via the hypervisor.
>=20
> In theory the requester is free to map the granted pages anywhere in
> its own address space. However there are differences between the
> architectures on how well this is supported.
>=20
> So I think this makes a case for having a mechanism by which the guest
> can restrict it's allocation to a specific area of the guest physical
> address space. The question is then what is the best way to inform the
> guest kernel of the limitation?

As mentioned above, I don't think it's possible to do this without
modifying applications - which is not possible in many use cases.
Instead we could improve IOMMU support so that this works transparently.

Stefan

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7razsACgkQnKSrs4Gr
c8hhawf+LQopsXGoAbGgNJXydx4d+b4G4sSdK5bD/Opg+fNvyWQg7WKSVBRD5cX2
m49NAeOLCt5JlR9O0taheIMkc4aaLJKCzZ0A0E+0xBXA/f/9r/DKZL51hLuASBks
X8U2PJJELnYAJlqobG9hQR/fY4/o2FbzpXEyEjQFcf9HfEXB5nURLoFCcQCNnroX
4nZCr7uj9Sn4XX0ea+FqfCHH13nbkXvWYGNJTcA1UM+bFEzpexyK14U/VWOj8jgY
sljMm1yHs964W1U8a0kvJ3q/Rz1ujkQ0kTVO6DXms+fVQTCgnQhjxNiSyRMLdOmL
/kLfcV4wuQ/IfKJbt0CMTHLtgt4vjQ==
=Sgrk
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

