Return-Path: <virtio-dev-return-8497-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3632F986533
	for <virtio-dev@lists.oasis-open.org>; Wed,  4 Aug 2021 17:50:09 +0000 (UTC)
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 04 Aug 2021 10:04:30 +0100
Message-ID: <87v94ldrqq.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Enabling hypervisor agnosticism for VirtIO backends
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Stratos Mailing List <stratos-dev@op-lists.linaro.org>, virtio-dev@lists.oasis-open.org
Cc: Arnd Bergmann <arnd.bergmann@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Stefano Stabellini <stefano.stabellini@xilinx.com>, stefanha@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Carl van Schaik <cvanscha@qti.qualcomm.com>, pratikp@quicinc.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

One of the goals of Project Stratos is to enable hypervisor agnostic
backends so we can enable as much re-use of code as possible and avoid
repeating ourselves. This is the flip side of the front end where
multiple front-end implementations are required - one per OS, assuming
you don't just want Linux guests. The resultant guests are trivially
movable between hypervisors modulo any abstracted paravirt type
interfaces.

In my original thumb nail sketch of a solution I envisioned vhost-user
daemons running in a broadly POSIX like environment. The interface to
the daemon is fairly simple requiring only some mapped memory and some
sort of signalling for events (on Linux this is eventfd). The idea was a
stub binary would be responsible for any hypervisor specific setup and
then launch a common binary to deal with the actual virtqueue requests
themselves.

Since that original sketch we've seen an expansion in the sort of ways
backends could be created. There is interest in encapsulating backends
in RTOSes or unikernels for solutions like SCMI. There interest in Rust
has prompted ideas of using the trait interface to abstract differences
away as well as the idea of bare-metal Rust backends.

We have a card (STR-12) called "Hypercall Standardisation" which
calls for a description of the APIs needed from the hypervisor side to
support VirtIO guests and their backends. However we are some way off
from that at the moment as I think we need to at least demonstrate one
portable backend before we start codifying requirements. To that end I
want to think about what we need for a backend to function.

Configuration
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

In the type-2 setup this is typically fairly simple because the host
system can orchestrate the various modules that make up the complete
system. In the type-1 case (or even type-2 with delegated service VMs)
we need some sort of mechanism to inform the backend VM about key
details about the system:

  - where virt queue memory is in it's address space
  - how it's going to receive (interrupt) and trigger (kick) events
  - what (if any) resources the backend needs to connect to

Obviously you can elide over configuration issues by having static
configurations and baking the assumptions into your guest images however
this isn't scalable in the long term. The obvious solution seems to be
extending a subset of Device Tree data to user space but perhaps there
are other approaches?

Before any virtio transactions can take place the appropriate memory
mappings need to be made between the FE guest and the BE guest.
Currently the whole of the FE guests address space needs to be visible
to whatever is serving the virtio requests. I can envision 3 approaches:

 * BE guest boots with memory already mapped

 This would entail the guest OS knowing where in it's Guest Physical
 Address space is already taken up and avoiding clashing. I would assume
 in this case you would want a standard interface to userspace to then
 make that address space visible to the backend daemon.

 * BE guests boots with a hypervisor handle to memory

 The BE guest is then free to map the FE's memory to where it wants in
 the BE's guest physical address space. To activate the mapping will
 require some sort of hypercall to the hypervisor. I can see two options
 at this point:

  - expose the handle to userspace for daemon/helper to trigger the
    mapping via existing hypercall interfaces. If using a helper you
    would have a hypervisor specific one to avoid the daemon having to
    care too much about the details or push that complexity into a
    compile time option for the daemon which would result in different
    binaries although a common source base.

  - expose a new kernel ABI to abstract the hypercall differences away
    in the guest kernel. In this case the userspace would essentially
    ask for an abstract "map guest N memory to userspace ptr" and let
    the kernel deal with the different hypercall interfaces. This of
    course assumes the majority of BE guests would be Linux kernels and
    leaves the bare-metal/unikernel approaches to their own devices.

Operation
=3D=3D=3D=3D=3D=3D=3D=3D=3D

The core of the operation of VirtIO is fairly simple. Once the
vhost-user feature negotiation is done it's a case of receiving update
events and parsing the resultant virt queue for data. The vhost-user
specification handles a bunch of setup before that point, mostly to
detail where the virt queues are set up FD's for memory and event
communication. This is where the envisioned stub process would be
responsible for getting the daemon up and ready to run. This is
currently done inside a big VMM like QEMU but I suspect a modern
approach would be to use the rust-vmm vhost crate. It would then either
communicate with the kernel's abstracted ABI or be re-targeted as a
build option for the various hypervisors.

One question is how to best handle notification and kicks. The existing
vhost-user framework uses eventfd to signal the daemon (although QEMU
is quite capable of simulating them when you use TCG). Xen has it's own
IOREQ mechanism. However latency is an important factor and having
events go through the stub would add quite a lot.

Could we consider the kernel internally converting IOREQ messages from
the Xen hypervisor to eventfd events? Would this scale with other kernel
hypercall interfaces?

So any thoughts on what directions are worth experimenting with?

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

