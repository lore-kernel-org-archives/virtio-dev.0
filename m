Return-Path: virtio-dev-return-7495-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A8A7F98612F
	for <virtio-dev@lists.oasis-open.org>; Fri, 19 Jun 2020 18:20:30 +0000 (UTC)
References: <87a7194kgt.fsf@linaro.org>
 <20200618032405-mutt-send-email-mst@kernel.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20200618032405-mutt-send-email-mst@kernel.org>
Date: Fri, 19 Jun 2020 19:20:26 +0100
Message-ID: <87sgequdcl.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: Constraining where a guest may allocate virtio accessible
 resources
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, David Hildenbrand <david@redhat.com>, jan.kiszka@siemens.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Azzedine Touzni <atouzni@qti.qualcomm.com>, =?utf-8?Q?Fran=C3=A7ois?= Ozog <francois.ozog@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Soni, Trilok" <tsoni@quicinc.com>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>


Michael S. Tsirkin <mst@redhat.com> writes:

> On Wed, Jun 17, 2020 at 06:31:15PM +0100, Alex Benn=C3=83=C2=A9e wrote:
>>=20
>> Hi,
>>=20
>> This follows on from the discussion in the last thread I raised:
>>=20
>>   Subject: Backend libraries for VirtIO device emulation
>>   Date: Fri, 06 Mar 2020 18:33:57 +0000
>>   Message-ID: <874kv15o4q.fsf@linaro.org>
>>=20
>> To support the concept of a VirtIO backend having limited visibility of
>> a guests memory space there needs to be some mechanism to limit the
>> where that guest may place things. A simple VirtIO device can be
>> expressed purely in virt resources, for example:
>>=20
>>    * status, feature and config fields
>>    * notification/doorbell
>>    * one or more virtqueues
>>=20
>> Using a PCI backend the location of everything but the virtqueues it
>> controlled by the mapping of the PCI device so something that is
>> controllable by the host/hypervisor. However the guest is free to
>> allocate the virtqueues anywhere in the virtual address space of system
>> RAM.
>>=20
>> In theory this shouldn't matter because sharing virtual pages is just a
>> matter of putting the appropriate translations in place. However there
>> are multiple ways the host and guest may interact:
>>=20
>> * QEMU TCG
>>=20
>> QEMU sees a block of system memory in it's virtual address space that
>> has a one to one mapping with the guests physical address space. If QEMU
>> want to share a subset of that address space it can only realistically
>> do it for a contiguous region of it's address space which implies the
>> guest must use a contiguous region of it's physical address space.
>>=20
>> * QEMU KVM
>>=20
>> The situation here is broadly the same - although both QEMU and the
>> guest are seeing a their own virtual views of a linear address space
>> which may well actually be a fragmented set of physical pages on the
>> host.
>>=20
>> KVM based guests have additional constraints if they ever want to access
>> real hardware in the host as you need to ensure any address accessed by
>> the guest can be eventually translated into an address that can
>> physically access the bus which a device in one (for device
>> pass-through). The area also has to be DMA coherent so updates from a
>> bus are reliably visible to software accessing the same address space.
>>=20
>> * Xen (and other type-1's?)
>>=20
>> Here the situation is a little different because the guest explicitly
>> makes it's pages visible to other domains by way of grant tables. The
>> guest is still free to use whatever parts of its address space it wishes
>> to. Other domains then request access to those pages via the hypervisor.
>>=20
>> In theory the requester is free to map the granted pages anywhere in
>> its own address space. However there are differences between the
>> architectures on how well this is supported.
>>=20
>> So I think this makes a case for having a mechanism by which the guest
>> can restrict it's allocation to a specific area of the guest physical
>> address space. The question is then what is the best way to inform the
>> guest kernel of the limitation?
>
> Something that's unclear to me is whether you envision each
> device to have its own dedicated memory it can access,
> or broadly to have a couple of groups of devices,
> kind of like e.g. there are 32 bit and 64 bit DMA capable pci devices,
> or like we have devices with VIRTIO_F_ACCESS_PLATFORM and
> without it?

See the diagram I posted upthread in reply to Stefan but yes potentially
a different bit of dedicated memory per virtio device so each backend
can only see it's particular virt queues (and potentially kernel buffers
it needs access to).

<snip>
>>=20
>> Option 5 - Additional Device
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>=20
>> The final approach would be to tie the allocation of virtqueues to
>> memory regions as defined by additional devices. For example the
>> proposed IVSHMEMv2 spec offers the ability for the hypervisor to present
>> a fixed non-mappable region of the address space. Other proposals like
>> virtio-mem allow for hot plugging of "physical" memory into the guest
>> (conveniently treatable as separate shareable memory objects for QEMU
>> ;-).
>
> Another approach would be supplying this information through virtio-iommu=
.
> That already has topology information, and can be used together with
> VIRTIO_F_ACCESS_PLATFORM to limit device access to memory.
> As virtio iommu is fairly new I kind of like this approach myself -
> not a lot of legacy to contend with.

Does anything implement this yet? I had a dig through QEMU and Linux and
couldn't see it mentioned.


--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

