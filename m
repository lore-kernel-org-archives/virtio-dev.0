Return-Path: <virtio-dev-return-8586-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DCC97985A01
	for <virtio-dev@lists.oasis-open.org>; Sat, 21 Aug 2021 14:10:04 +0000 (UTC)
Date: Sat, 21 Aug 2021 16:08:20 +0200
From: Matias Ezequiel Vara Larsen <matiasevara@gmail.com>
Message-ID: <20210821140820.GA19@matiasv.localdomain>
References: <87v94ldrqq.fsf@linaro.org>
 <20210819091154.GA20@matiasv.localdomain>
 <20210820060558.GB13452@laputa>
MIME-Version: 1.0
In-Reply-To: <20210820060558.GB13452@laputa>
Subject: Re: [virtio-dev] Enabling hypervisor agnosticism for VirtIO backends
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Alex Benn??e <alex.bennee@linaro.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, virtio-dev@lists.oasis-open.org, Arnd Bergmann <arnd.bergmann@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Stefano Stabellini <stefano.stabellini@xilinx.com>, stefanha@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Carl van Schaik <cvanscha@qti.qualcomm.com>, pratikp@quicinc.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hello,

On Fri, Aug 20, 2021 at 03:05:58PM +0900, AKASHI Takahiro wrote:
> Hi Matias,
>=20
> On Thu, Aug 19, 2021 at 11:11:55AM +0200, Matias Ezequiel Vara Larsen wro=
te:
> > Hello Alex,
> >=20
> > I can tell you my experience from working on a PoC (library)=20
> > to allow the implementation of virtio-devices that are hypervisor/OS ag=
nostic.=20
>=20
> What hypervisor are you using for your PoC here?
>=20

I am using an in-house hypervisor, which is similar to Jailhouse.

> > I focused on two use cases:
> > 1. type-I hypervisor in which the backend is running as a VM. This
> > is an in-house hypervisor that does not support VMExits.
> > 2. Linux user-space. In this case, the library is just used to
> > communicate threads. The goal of this use case is merely testing.
> >=20
> > I have chosen virtio-mmio as the way to exchange information
> > between the frontend and backend. I found it hard to synchronize the
> > access to the virtio-mmio layout without VMExits. I had to add some ext=
ra bits to allow=20
>=20
> Can you explain how MMIOs to registers in virito-mmio layout
> (which I think means a configuration space?) will be propagated to BE?
>=20

In this PoC, the BE guest is created with a fixed number of regions
of memory that represents each device. The BE initializes these regions, an=
d then, waits
for the FEs to begin the initialization.=20

> > the front-end and back-end to synchronize, which is required
> > during the device-status initialization. These extra bits would not be=
=20
> > needed in case the hypervisor supports VMExits, e.g., KVM.
> >=20
> > Each guest has a memory region that is shared with the backend.=20
> > This memory region is used by the frontend to allocate the io-buffers. =
This region also=20
> > maps the virtio-mmio layout that is initialized by the backend. For the=
 moment, this region=20
> > is defined when the guest is created. One limitation is that the memory=
 for io-buffers is fixed.=20
>=20
> So in summary, you have a single memory region that is used
> for virtio-mmio layout and io-buffers (I think they are for payload)
> and you assume that the region will be (at lease for now) statically
> shared between FE and BE so that you can eliminate 'mmap' at every
> time to access the payload.
> Correct?
>

Yes, It is.=20

> If so, it can be an alternative solution for memory access issue,
> and a similar technique is used in some implementations:
> - (Jailhouse's) ivshmem
> - Arnd's fat virtqueue
>
> In either case, however, you will have to allocate payload from the regio=
n
> and so you will see some impact on FE code (at least at some low level).
> (In ivshmem, dma_ops in the kernel is defined for this purpose.)
> Correct?

Yes, It is. The FE implements a sort of malloc() to organize the allocation=
 of io-buffers from that
memory region.

Rethinking about the VMExits, I am not sure how this mechanism may be used =
when both the FE and=20
the BE are VMs. The use of VMExits may require to involve the hypervisor.

Matias
>=20
> -Takahiro Akashi
>=20
> > At some point, the guest shall be able to balloon this region. Notifica=
tions between=20
> > the frontend and the backend are implemented by using an hypercall. The=
 hypercall=20
> > mechanism and the memory allocation are abstracted away by a platform l=
ayer that=20
> > exposes an interface that is hypervisor/os agnostic.
> >=20
> > I split the backend into a virtio-device driver and a
> > backend driver. The virtio-device driver is the virtqueues and the
> > backend driver gets packets from the virtqueue for
> > post-processing. For example, in the case of virtio-net, the backend
> > driver would decide if the packet goes to the hardware or to another
> > virtio-net device. The virtio-device drivers may be
> > implemented in different ways like by using a single thread, multiple t=
hreads,=20
> > or one thread for all the virtio-devices.
> >=20
> > In this PoC, I just tackled two very simple use-cases. These
> > use-cases allowed me to extract some requirements for an hypervisor to
> > support virtio.
> >=20
> > Matias
> >=20
> > On Wed, Aug 04, 2021 at 10:04:30AM +0100, Alex Benn=E9e wrote:
> > > Hi,
> > >=20
> > > One of the goals of Project Stratos is to enable hypervisor agnostic
> > > backends so we can enable as much re-use of code as possible and avoi=
d
> > > repeating ourselves. This is the flip side of the front end where
> > > multiple front-end implementations are required - one per OS, assumin=
g
> > > you don't just want Linux guests. The resultant guests are trivially
> > > movable between hypervisors modulo any abstracted paravirt type
> > > interfaces.
> > >=20
> > > In my original thumb nail sketch of a solution I envisioned vhost-use=
r
> > > daemons running in a broadly POSIX like environment. The interface to
> > > the daemon is fairly simple requiring only some mapped memory and som=
e
> > > sort of signalling for events (on Linux this is eventfd). The idea wa=
s a
> > > stub binary would be responsible for any hypervisor specific setup an=
d
> > > then launch a common binary to deal with the actual virtqueue request=
s
> > > themselves.
> > >=20
> > > Since that original sketch we've seen an expansion in the sort of way=
s
> > > backends could be created. There is interest in encapsulating backend=
s
> > > in RTOSes or unikernels for solutions like SCMI. There interest in Ru=
st
> > > has prompted ideas of using the trait interface to abstract differenc=
es
> > > away as well as the idea of bare-metal Rust backends.
> > >=20
> > > We have a card (STR-12) called "Hypercall Standardisation" which
> > > calls for a description of the APIs needed from the hypervisor side t=
o
> > > support VirtIO guests and their backends. However we are some way off
> > > from that at the moment as I think we need to at least demonstrate on=
e
> > > portable backend before we start codifying requirements. To that end =
I
> > > want to think about what we need for a backend to function.
> > >=20
> > > Configuration
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > In the type-2 setup this is typically fairly simple because the host
> > > system can orchestrate the various modules that make up the complete
> > > system. In the type-1 case (or even type-2 with delegated service VMs=
)
> > > we need some sort of mechanism to inform the backend VM about key
> > > details about the system:
> > >=20
> > >   - where virt queue memory is in it's address space
> > >   - how it's going to receive (interrupt) and trigger (kick) events
> > >   - what (if any) resources the backend needs to connect to
> > >=20
> > > Obviously you can elide over configuration issues by having static
> > > configurations and baking the assumptions into your guest images howe=
ver
> > > this isn't scalable in the long term. The obvious solution seems to b=
e
> > > extending a subset of Device Tree data to user space but perhaps ther=
e
> > > are other approaches?
> > >=20
> > > Before any virtio transactions can take place the appropriate memory
> > > mappings need to be made between the FE guest and the BE guest.
> > > Currently the whole of the FE guests address space needs to be visibl=
e
> > > to whatever is serving the virtio requests. I can envision 3 approach=
es:
> > >=20
> > >  * BE guest boots with memory already mapped
> > >=20
> > >  This would entail the guest OS knowing where in it's Guest Physical
> > >  Address space is already taken up and avoiding clashing. I would ass=
ume
> > >  in this case you would want a standard interface to userspace to the=
n
> > >  make that address space visible to the backend daemon.
> > >=20
> > >  * BE guests boots with a hypervisor handle to memory
> > >=20
> > >  The BE guest is then free to map the FE's memory to where it wants i=
n
> > >  the BE's guest physical address space. To activate the mapping will
> > >  require some sort of hypercall to the hypervisor. I can see two opti=
ons
> > >  at this point:
> > >=20
> > >   - expose the handle to userspace for daemon/helper to trigger the
> > >     mapping via existing hypercall interfaces. If using a helper you
> > >     would have a hypervisor specific one to avoid the daemon having t=
o
> > >     care too much about the details or push that complexity into a
> > >     compile time option for the daemon which would result in differen=
t
> > >     binaries although a common source base.
> > >=20
> > >   - expose a new kernel ABI to abstract the hypercall differences awa=
y
> > >     in the guest kernel. In this case the userspace would essentially
> > >     ask for an abstract "map guest N memory to userspace ptr" and let
> > >     the kernel deal with the different hypercall interfaces. This of
> > >     course assumes the majority of BE guests would be Linux kernels a=
nd
> > >     leaves the bare-metal/unikernel approaches to their own devices.
> > >=20
> > > Operation
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > The core of the operation of VirtIO is fairly simple. Once the
> > > vhost-user feature negotiation is done it's a case of receiving updat=
e
> > > events and parsing the resultant virt queue for data. The vhost-user
> > > specification handles a bunch of setup before that point, mostly to
> > > detail where the virt queues are set up FD's for memory and event
> > > communication. This is where the envisioned stub process would be
> > > responsible for getting the daemon up and ready to run. This is
> > > currently done inside a big VMM like QEMU but I suspect a modern
> > > approach would be to use the rust-vmm vhost crate. It would then eith=
er
> > > communicate with the kernel's abstracted ABI or be re-targeted as a
> > > build option for the various hypervisors.
> > >=20
> > > One question is how to best handle notification and kicks. The existi=
ng
> > > vhost-user framework uses eventfd to signal the daemon (although QEMU
> > > is quite capable of simulating them when you use TCG). Xen has it's o=
wn
> > > IOREQ mechanism. However latency is an important factor and having
> > > events go through the stub would add quite a lot.
> > >=20
> > > Could we consider the kernel internally converting IOREQ messages fro=
m
> > > the Xen hypervisor to eventfd events? Would this scale with other ker=
nel
> > > hypercall interfaces?
> > >=20
> > > So any thoughts on what directions are worth experimenting with?
> > >=20
> > > --=20
> > > Alex Benn=E9e
> > >=20
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > >=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

