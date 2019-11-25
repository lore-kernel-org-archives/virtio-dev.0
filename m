Return-Path: virtio-dev-return-6406-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9AE0F985DB8
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Nov 2019 19:02:12 +0000 (UTC)
References: <20191120151903.175110-1-jean-philippe@linaro.org>
 <20191120151903.175110-2-jean-philippe@linaro.org>
 <19a7ef47-29b8-f1ff-822a-afc974b2a314@siemens.com>
 <20191125123519.GA920756@lophozonia>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bdd27c86-bc62-7e3a-acd2-ac1c1a26d91b@siemens.com>
Date: Mon, 25 Nov 2019 20:01:56 +0100
MIME-Version: 1.0
In-Reply-To: <20191125123519.GA920756@lophozonia>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH RESEND v4 1/1] Add virtio-iommu device
 specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, joro@8bytes.org, tnowicki@marvell.com, eric.auger@redhat.com, kevin.tian@intel.com, lorenzo.pieralisi@arm.com, mst@redhat.com, bauerman@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 25.11.19 13:35, Jean-Philippe Brucker wrote:
> Hi Jan,
>=20
> On Mon, Nov 25, 2019 at 08:30:29AM +0100, Jan Kiszka wrote:
>> What's the impact of a fault on the device(s) under the IOMMU regime? Ca=
n
>> they recover?
>=20
> Are you asking about what happens to the endpoints when the virtio-iommu
> encounters an internal error? Or what happens to the endpoints if their
> DMA transactions fails translation? I think they are both equivalent to
> "what happens when the endpoint's memory transaction aborts?". The answer
> to that depends on the bus and endpoint, and is out of scope. The
> virtio-iommu spec could state that in those cases, we abort the memory
> transaction, but it's too vague since we don't know the specifics of the
> bus, and it isn't necessarily true (see VT-d and SMMU below).

I'm interested in both cases in how to recover the endpoints - of course=20
also the virtual IOMMU, but that seems clear - from such errors. Can we=20
describe a procedure that will always lead to working setup again, even=20
if there might be simpler ways on certain setups? I mean, the answer=20
shouldn't be "reset the host"...

>=20
>> Or will they get DEVICE_NEEDS_RESET as well?
>=20
> If the endpoint is virtio, then the behavior upon DMA fault should be
> specified by the virtio transport, because it could happen without an
> IOMMU (e.g. trying to access a physical address that isn't mapped to RAM
> or MMIO), or with a VT-d emulation for example.
>=20
> But it's not necessarily virtio. It can be a hardware passed-through
> endpoint, in which case the abort behavior depends on the physical IOMMU,
> which virtio-iommu doesn't know anything about, in addition to the
> physical bus and endpoint.
>=20
> I also wouldn't state that the whole device (or function, though we're no=
t
> necessarily PCI) needs reset. It might be possible for some devices to
> only stop the faulting queue and leave the others running, to avoid
> disturbing the rest of the system.

As I said above: There should be at least one know-to-work path, and a=20
way to signal better options when they are available in a concrete setup.

>=20
>> With PCI device
>> behind real IOMMUs, it's normal that they need a reset after having caus=
ed a
>> fault. I'm not sure if this is described in the related specs for them, =
but
>> it should be clarify for the virtual IOMMU. But this can be done on top,
>> IMHO.
>=20
> The device behaviour is generally not specified. However their spec can
> say something about the bus:
>=20
> * For Intel VT-d see 7.2 and 7.2.1 (Non-Recoverable Address Translation
>    Faults), where the spec provides various implementation examples.
>=20
>    "Requests that encounter non-recoverable address translation faults ar=
e
>    aborted by the remapping hardware, and typically require a reset of th=
e
>    device (such as through a function-level-reset) to recover and
>    re-initialize the device to put it back into service."
>=20
>    So could be aborted, but as stated later in 7.2.1, can also be
>    redirected to a catch-all memory location.
>=20
> * For Arm SMMU, the host driver can specify for each context whether
>    the SMMU should return an abort (Slave Error on the AMBA bus) or not
>    (read-zero, write-ignore).
>=20
>    The spec also says "The behavior of the client device after terminatio=
n
>    is specific to the device." (3.12.1 Terminate model)
>=20
> * For AMD IOMMU, "when the IOMMU detects an I/O page fault, it target
>    aborts the faulting request." and "the IOMMU sets the legacy PCI
>    Signaled Target Abort bit, if applicable" (2.1.3.2 I/O Page Faults).
>    I believe the equivalent for the PCIe bus is a Completer Abort respons=
e.
>=20
> They can specify the behaviour with some precision, because they also
> specify how the IOMMU is integrated with the system. We don't have this
> luxury, because if the virtio-iommu is just a proxy for a physical IOMMU,
> we don't know how aborts are configured, and the bus may be a variant of
> PCI, AMBA or something else.

Again: I'm on a virtual machine, my device just ran into a fault - how=20
can I find out what I'm supposed to do to get it working again, in its=20
driver and possibly also the virtio-iommu driver?

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

