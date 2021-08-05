Return-Path: <virtio-dev-return-8503-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 52B3F98653E
	for <virtio-dev@lists.oasis-open.org>; Thu,  5 Aug 2021 15:48:52 +0000 (UTC)
Date: Thu, 5 Aug 2021 16:48:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YQwIU5kFT4jetlVj@stefanha-x1.localdomain>
References: <87v94ldrqq.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87v94ldrqq.fsf@linaro.org>
Subject: [virtio-dev] Re: Enabling hypervisor agnosticism for VirtIO backends
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qi2sPqyr8E66D4XI"
Content-Disposition: inline
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Stratos Mailing List <stratos-dev@op-lists.linaro.org>, virtio-dev@lists.oasis-open.org, Arnd Bergmann <arnd.bergmann@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Stefano Stabellini <stefano.stabellini@xilinx.com>, Jan Kiszka <jan.kiszka@siemens.com>, Carl van Schaik <cvanscha@qti.qualcomm.com>, pratikp@quicinc.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--qi2sPqyr8E66D4XI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 04, 2021 at 10:04:30AM +0100, Alex Benn=E9e wrote:
> Hi,
>=20
> One of the goals of Project Stratos is to enable hypervisor agnostic
> backends so we can enable as much re-use of code as possible and avoid
> repeating ourselves. This is the flip side of the front end where
> multiple front-end implementations are required - one per OS, assuming
> you don't just want Linux guests. The resultant guests are trivially
> movable between hypervisors modulo any abstracted paravirt type
> interfaces.
>=20
> In my original thumb nail sketch of a solution I envisioned vhost-user
> daemons running in a broadly POSIX like environment. The interface to
> the daemon is fairly simple requiring only some mapped memory and some
> sort of signalling for events (on Linux this is eventfd). The idea was a
> stub binary would be responsible for any hypervisor specific setup and
> then launch a common binary to deal with the actual virtqueue requests
> themselves.
>=20
> Since that original sketch we've seen an expansion in the sort of ways
> backends could be created. There is interest in encapsulating backends
> in RTOSes or unikernels for solutions like SCMI. There interest in Rust
> has prompted ideas of using the trait interface to abstract differences
> away as well as the idea of bare-metal Rust backends.
>=20
> We have a card (STR-12) called "Hypercall Standardisation" which
> calls for a description of the APIs needed from the hypervisor side to
> support VirtIO guests and their backends. However we are some way off
> from that at the moment as I think we need to at least demonstrate one
> portable backend before we start codifying requirements. To that end I
> want to think about what we need for a backend to function.
>=20
> Configuration
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> In the type-2 setup this is typically fairly simple because the host
> system can orchestrate the various modules that make up the complete
> system. In the type-1 case (or even type-2 with delegated service VMs)
> we need some sort of mechanism to inform the backend VM about key
> details about the system:
>=20
>   - where virt queue memory is in it's address space
>   - how it's going to receive (interrupt) and trigger (kick) events
>   - what (if any) resources the backend needs to connect to
>=20
> Obviously you can elide over configuration issues by having static
> configurations and baking the assumptions into your guest images however
> this isn't scalable in the long term. The obvious solution seems to be
> extending a subset of Device Tree data to user space but perhaps there
> are other approaches?
>=20
> Before any virtio transactions can take place the appropriate memory
> mappings need to be made between the FE guest and the BE guest.
> Currently the whole of the FE guests address space needs to be visible
> to whatever is serving the virtio requests. I can envision 3 approaches:
>=20
>  * BE guest boots with memory already mapped
>=20
>  This would entail the guest OS knowing where in it's Guest Physical
>  Address space is already taken up and avoiding clashing. I would assume
>  in this case you would want a standard interface to userspace to then
>  make that address space visible to the backend daemon.
>=20
>  * BE guests boots with a hypervisor handle to memory
>=20
>  The BE guest is then free to map the FE's memory to where it wants in
>  the BE's guest physical address space. To activate the mapping will
>  require some sort of hypercall to the hypervisor. I can see two options
>  at this point:
>=20
>   - expose the handle to userspace for daemon/helper to trigger the
>     mapping via existing hypercall interfaces. If using a helper you
>     would have a hypervisor specific one to avoid the daemon having to
>     care too much about the details or push that complexity into a
>     compile time option for the daemon which would result in different
>     binaries although a common source base.
>=20
>   - expose a new kernel ABI to abstract the hypercall differences away
>     in the guest kernel. In this case the userspace would essentially
>     ask for an abstract "map guest N memory to userspace ptr" and let
>     the kernel deal with the different hypercall interfaces. This of
>     course assumes the majority of BE guests would be Linux kernels and
>     leaves the bare-metal/unikernel approaches to their own devices.

VIRTIO typically uses the vring memory layout but doesn't need to. The
VIRTIO device model deals with virtqueues. The shared memory vring
layout is part of the VIRTIO transport (PCI, MMIO, and CCW use vrings).
Alternative transports with other virtqueue representations are possible
(e.g. VIRTIO-over-TCP). They don't need to involve a BE mapping shared
memory and processing a vring owned by the FE.

For example, there could be BE hypercalls to pop a virtqueue elements,
push a virtqueue elements, and to access buffers (basically DMA
read/write). The FE could either be a traditional virtio-mmio/pci device
with a vring or use FE hypercalls to add available elements to a
virtqueue and get used elements.

I don't know the goals of project Stratos or whether this helps, but it
might allow other architectures that have different security,
complexity, etc properties.

Stefan

--qi2sPqyr8E66D4XI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEMCFMACgkQnKSrs4Gr
c8hcyQf/QVrK3cWsBOnLSPRi80One2TEG6dS2JFR1s2jDWjzeKhhb9yp728PSqXq
0Fo8WhSh7kbQ+ahfxj7UVJsg/uNoL9qV7KC6LEUqCPe7zsvOi8Vj1hshhZ7jfg6X
DPV9BU5n60OeWzfuWE196XrugXjEmgvM1Wz2rM1zkqE2muNM9W084aQTRzcxG0of
kK+OYJwQWD0Kc0yGatATreYfZ7woGUMQA8vyZ/EA6R4ZEIZPWxISvc4ul26JoBc9
FQ4nkBRZziini0f9twq3jENYGWWrNeD55GZW5WjXD0LZsvs9wqsxo399tOj6mF6K
ajBHz2Zbe3C0HGjad3IjA9Z28J+E+Q==
=bzBT
-----END PGP SIGNATURE-----

--qi2sPqyr8E66D4XI--

