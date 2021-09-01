Return-Path: <virtio-dev-return-8621-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BA01B986483
	for <virtio-dev@lists.oasis-open.org>; Wed,  1 Sep 2021 08:56:45 +0000 (UTC)
References: <87v94ldrqq.fsf@linaro.org>
 <20210819091154.GA20@matiasv.localdomain>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 01 Sep 2021 09:43:19 +0100
In-reply-to: <20210819091154.GA20@matiasv.localdomain>
Message-ID: <87ilzkhdx3.fsf@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Enabling hypervisor agnosticism for VirtIO backends
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Matias Ezequiel Vara Larsen <matiasevara@gmail.com>
Cc: Stratos Mailing List <stratos-dev@op-lists.linaro.org>, virtio-dev@lists.oasis-open.org, Arnd Bergmann <arnd.bergmann@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Stefano Stabellini <stefano.stabellini@xilinx.com>, stefanha@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Carl van Schaik <cvanscha@qti.qualcomm.com>, pratikp@quicinc.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>


Matias Ezequiel Vara Larsen <matiasevara@gmail.com> writes:

> Hello Alex,
>
> I can tell you my experience from working on a PoC (library)=20
> to allow the implementation of virtio-devices that are hypervisor/OS agno=
stic.=20
> I focused on two use cases:
> 1. type-I hypervisor in which the backend is running as a VM. This
> is an in-house hypervisor that does not support VMExits.
> 2. Linux user-space. In this case, the library is just used to
> communicate threads. The goal of this use case is merely testing.
>
> I have chosen virtio-mmio as the way to exchange information
> between the frontend and backend. I found it hard to synchronize the
> access to the virtio-mmio layout without VMExits. I had to add some extra=
 bits to allow=20
> the front-end and back-end to synchronize, which is required
> during the device-status initialization. These extra bits would not be=20
> needed in case the hypervisor supports VMExits, e.g., KVM.

The support for a vmexit seems rather fundamental to type-2 hypervisors
(like KVM) as the VMM is intrinsically linked to a vCPUs run loop. This
makes handling a condition like a bit of MMIO fairly natural to
implement. For type-1 cases the line of execution between "guest
accesses MMIO" and "something services that request" is a little
trickier to pin down. Ultimately at that point you are relying on the
hypervisor itself to make the scheduling decision to stop executing the
guest and allow the backend to do it's thing. We don't really want to
expose the exact details about that as it probably varies a lot between
hypervisors. However would a backend API semantic that expresses:

  - guest has done some MMIO
  - hypervisor has stopped execution of guest
  - guest will be restarted when response conditions are set by backend

cover the needs of a virtio backend and could the userspace facing
portion of that be agnostic?

>
> Each guest has a memory region that is shared with the backend.=20
> This memory region is used by the frontend to allocate the io-buffers. Th=
is region also=20
> maps the virtio-mmio layout that is initialized by the backend. For the m=
oment, this region=20
> is defined when the guest is created. One limitation is that the memory f=
or io-buffers is fixed.=20
> At some point, the guest shall be able to balloon this region. Notificati=
ons between=20
> the frontend and the backend are implemented by using an hypercall. The h=
ypercall=20
> mechanism and the memory allocation are abstracted away by a platform lay=
er that=20
> exposes an interface that is hypervisor/os agnostic.
>
> I split the backend into a virtio-device driver and a
> backend driver. The virtio-device driver is the virtqueues and the
> backend driver gets packets from the virtqueue for
> post-processing. For example, in the case of virtio-net, the backend
> driver would decide if the packet goes to the hardware or to another
> virtio-net device. The virtio-device drivers may be
> implemented in different ways like by using a single thread, multiple thr=
eads,=20
> or one thread for all the virtio-devices.
>
> In this PoC, I just tackled two very simple use-cases. These
> use-cases allowed me to extract some requirements for an hypervisor to
> support virtio.
>
> Matias
<snip>

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

