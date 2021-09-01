Return-Path: <virtio-dev-return-8623-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF0899865C0
	for <virtio-dev@lists.oasis-open.org>; Wed,  1 Sep 2021 13:20:45 +0000 (UTC)
References: <87v94ldrqq.fsf@linaro.org>
 <alpine.DEB.2.21.2108041055390.9768@sstabellini-ThinkPad-T480s>
 <YRuSPT9075NuWRYS@stefanha-x1.localdomain>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 01 Sep 2021 13:53:34 +0100
In-reply-to: <YRuSPT9075NuWRYS@stefanha-x1.localdomain>
Message-ID: <875yvkh1p1.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: Enabling hypervisor agnosticism for VirtIO backends
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, virtio-dev@lists.oasis-open.org, Arnd Bergmann <arnd.bergmann@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Stefano Stabellini <stefano.stabellini@xilinx.com>, Jan Kiszka <jan.kiszka@siemens.com>, Carl van Schaik <cvanscha@qti.qualcomm.com>, pratikp@quicinc.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Wei.Chen@arm.com, olekstysh@gmail.com, Oleksandr_Tyshchenko@epam.com, Bertrand.Marquis@arm.com, Artem_Mygaiev@epam.com, julien@xen.org, jgross@suse.com, paul@xen.org, xen-devel@lists.xen.org, Elena Afanasova <eafanasova@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>


Stefan Hajnoczi <stefanha@redhat.com> writes:

> [[PGP Signed Part:Undecided]]
> On Wed, Aug 04, 2021 at 12:20:01PM -0700, Stefano Stabellini wrote:
>> > Could we consider the kernel internally converting IOREQ messages from
>> > the Xen hypervisor to eventfd events? Would this scale with other kern=
el
>> > hypercall interfaces?
>> >=20
>> > So any thoughts on what directions are worth experimenting with?
>> =20
>> One option we should consider is for each backend to connect to Xen via
>> the IOREQ interface. We could generalize the IOREQ interface and make it
>> hypervisor agnostic. The interface is really trivial and easy to add.
>> The only Xen-specific part is the notification mechanism, which is an
>> event channel. If we replaced the event channel with something else the
>> interface would be generic. See:
>> https://gitlab.com/xen-project/xen/-/blob/staging/xen/include/public/hvm=
/ioreq.h#L52
>
> There have been experiments with something kind of similar in KVM
> recently (see struct ioregionfd_cmd):
> https://lore.kernel.org/kvm/dad3d025bcf15ece11d9df0ff685e8ab0a4f2edd.1613=
828727.git.eafanasova@gmail.com/

Reading the cover letter was very useful in showing how this provides a
separate channel for signalling IO events to userspace instead of using
the normal type-2 vmexit type event. I wonder how deeply tied the
userspace facing side of this is to KVM? Could it provide a common FD
type interface to IOREQ?

As I understand IOREQ this is currently a direct communication between
userspace and the hypervisor using the existing Xen message bus. My
worry would be that by adding knowledge of what the underlying
hypervisor is we'd end up with excess complexity in the kernel. For one
thing we certainly wouldn't want an API version dependency on the kernel
to understand which version of the Xen hypervisor it was running on.

>> There is also another problem. IOREQ is probably not be the only
>> interface needed. Have a look at
>> https://marc.info/?l=3Dxen-devel&m=3D162373754705233&w=3D2. Don't we als=
o need
>> an interface for the backend to inject interrupts into the frontend? And
>> if the backend requires dynamic memory mappings of frontend pages, then
>> we would also need an interface to map/unmap domU pages.
>>=20
>> These interfaces are a lot more problematic than IOREQ: IOREQ is tiny
>> and self-contained. It is easy to add anywhere. A new interface to
>> inject interrupts or map pages is more difficult to manage because it
>> would require changes scattered across the various emulators.
>
> Something like ioreq is indeed necessary to implement arbitrary devices,
> but if you are willing to restrict yourself to VIRTIO then other
> interfaces are possible too because the VIRTIO device model is different
> from the general purpose x86 PIO/MMIO that Xen's ioreq seems to
> support.

It's true our focus is just VirtIO which does support alternative
transport options however most implementations seem to be targeting
virtio-mmio for it's relative simplicity and understood semantics
(modulo a desire for MSI to reduce round trip latency handling
signalling).

>
> Stefan
>
> [[End of PGP Signed Part]]


--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

