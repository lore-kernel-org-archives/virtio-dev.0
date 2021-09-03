Return-Path: <virtio-dev-return-8636-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2FA49865D8
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Sep 2021 09:38:53 +0000 (UTC)
References: <87v94ldrqq.fsf@linaro.org>
 <alpine.DEB.2.21.2108041055390.9768@sstabellini-ThinkPad-T480s>
 <YRuSPT9075NuWRYS@stefanha-x1.localdomain> <875yvkh1p1.fsf@linaro.org>
 <20210903080609.GD47953@laputa>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 03 Sep 2021 10:28:06 +0100
In-reply-to: <20210903080609.GD47953@laputa>
Message-ID: <87czpqq9qu.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: Enabling hypervisor agnosticism for VirtIO backends
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, virtio-dev@lists.oasis-open.org, Arnd Bergmann <arnd.bergmann@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Stefano Stabellini <stefano.stabellini@xilinx.com>, Jan Kiszka <jan.kiszka@siemens.com>, Carl van Schaik <cvanscha@qti.qualcomm.com>, pratikp@quicinc.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Wei.Chen@arm.com, olekstysh@gmail.com, Oleksandr_Tyshchenko@epam.com, Bertrand.Marquis@arm.com, Artem_Mygaiev@epam.com, julien@xen.org, jgross@suse.com, paul@xen.org, xen-devel@lists.xen.org, Elena Afanasova <eafanasova@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>


AKASHI Takahiro <takahiro.akashi@linaro.org> writes:

> Alex,
>
> On Wed, Sep 01, 2021 at 01:53:34PM +0100, Alex Benn??e wrote:
>>=20
>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>=20
>> > [[PGP Signed Part:Undecided]]
>> > On Wed, Aug 04, 2021 at 12:20:01PM -0700, Stefano Stabellini wrote:
>> >> > Could we consider the kernel internally converting IOREQ messages f=
rom
>> >> > the Xen hypervisor to eventfd events? Would this scale with other k=
ernel
>> >> > hypercall interfaces?
>> >> >=20
>> >> > So any thoughts on what directions are worth experimenting with?
>> >> =20
>> >> One option we should consider is for each backend to connect to Xen v=
ia
>> >> the IOREQ interface. We could generalize the IOREQ interface and make=
 it
>> >> hypervisor agnostic. The interface is really trivial and easy to add.
>> >> The only Xen-specific part is the notification mechanism, which is an
>> >> event channel. If we replaced the event channel with something else t=
he
>> >> interface would be generic. See:
>> >> https://gitlab.com/xen-project/xen/-/blob/staging/xen/include/public/=
hvm/ioreq.h#L52
>> >
>> > There have been experiments with something kind of similar in KVM
>> > recently (see struct ioregionfd_cmd):
>> > https://lore.kernel.org/kvm/dad3d025bcf15ece11d9df0ff685e8ab0a4f2edd.1=
613828727.git.eafanasova@gmail.com/
>>=20
>> Reading the cover letter was very useful in showing how this provides a
>> separate channel for signalling IO events to userspace instead of using
>> the normal type-2 vmexit type event. I wonder how deeply tied the
>> userspace facing side of this is to KVM? Could it provide a common FD
>> type interface to IOREQ?
>
> Why do you stick to a "FD" type interface?

I mean most user space interfaces on POSIX start with a file descriptor
and the usual read/write semantics or a series of ioctls.

>> As I understand IOREQ this is currently a direct communication between
>> userspace and the hypervisor using the existing Xen message bus. My
>
> With IOREQ server, IO event occurrences are notified to BE via Xen's even=
t
> channel, while the actual contexts of IO events (see struct ioreq in iore=
q.h)
> are put in a queue on a single shared memory page which is to be assigned
> beforehand with xenforeignmemory_map_resource hypervisor call.

If we abstracted the IOREQ via the kernel interface you would probably
just want to put the ioreq structure on a queue rather than expose the
shared page to userspace.=20

>> worry would be that by adding knowledge of what the underlying
>> hypervisor is we'd end up with excess complexity in the kernel. For one
>> thing we certainly wouldn't want an API version dependency on the kernel
>> to understand which version of the Xen hypervisor it was running on.
>
> That's exactly what virtio-proxy in my proposal[1] does; All the hypervis=
or-
> specific details of IO event handlings are contained in virtio-proxy
> and virtio BE will communicate with virtio-proxy through a virtqueue
> (yes, virtio-proxy is seen as yet another virtio device on BE) and will
> get IO event-related *RPC* callbacks, either MMIO read or write, from
> virtio-proxy.
>
> See page 8 (protocol flow) and 10 (interfaces) in [1].

There are two areas of concern with the proxy approach at the moment.
The first is how the bootstrap of the virtio-proxy channel happens and
the second is how many context switches are involved in a transaction.
Of course with all things there is a trade off. Things involving the
very tightest latency would probably opt for a bare metal backend which
I think would imply hypervisor knowledge in the backend binary.

>
> If kvm's ioregionfd can fit into this protocol, virtio-proxy for kvm
> will hopefully be implemented using ioregionfd.
>
> -Takahiro Akashi
>
> [1] https://op-lists.linaro.org/pipermail/stratos-dev/2021-August/000548.=
html

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

