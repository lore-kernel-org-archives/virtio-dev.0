Return-Path: virtio-dev-return-6400-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9A1BF985CB0
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Nov 2019 12:35:23 +0000 (UTC)
Date: Mon, 25 Nov 2019 13:35:19 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <20191125123519.GA920756@lophozonia>
References: <20191120151903.175110-1-jean-philippe@linaro.org>
 <20191120151903.175110-2-jean-philippe@linaro.org>
 <19a7ef47-29b8-f1ff-822a-afc974b2a314@siemens.com>
MIME-Version: 1.0
In-Reply-To: <19a7ef47-29b8-f1ff-822a-afc974b2a314@siemens.com>
Subject: Re: [virtio-dev] [PATCH RESEND v4 1/1] Add virtio-iommu device
 specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: virtio-dev@lists.oasis-open.org, joro@8bytes.org, tnowicki@marvell.com, eric.auger@redhat.com, kevin.tian@intel.com, lorenzo.pieralisi@arm.com, mst@redhat.com, bauerman@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Jan,

On Mon, Nov 25, 2019 at 08:30:29AM +0100, Jan Kiszka wrote:
> What's the impact of a fault on the device(s) under the IOMMU regime? Can
> they recover?

Are you asking about what happens to the endpoints when the virtio-iommu
encounters an internal error? Or what happens to the endpoints if their
DMA transactions fails translation? I think they are both equivalent to
"what happens when the endpoint's memory transaction aborts?". The answer
to that depends on the bus and endpoint, and is out of scope. The
virtio-iommu spec could state that in those cases, we abort the memory
transaction, but it's too vague since we don't know the specifics of the
bus, and it isn't necessarily true (see VT-d and SMMU below).

> Or will they get DEVICE_NEEDS_RESET as well?

If the endpoint is virtio, then the behavior upon DMA fault should be
specified by the virtio transport, because it could happen without an
IOMMU (e.g. trying to access a physical address that isn't mapped to RAM
or MMIO), or with a VT-d emulation for example.

But it's not necessarily virtio. It can be a hardware passed-through
endpoint, in which case the abort behavior depends on the physical IOMMU,
which virtio-iommu doesn't know anything about, in addition to the
physical bus and endpoint.

I also wouldn't state that the whole device (or function, though we're not
necessarily PCI) needs reset. It might be possible for some devices to
only stop the faulting queue and leave the others running, to avoid
disturbing the rest of the system.

> With PCI device
> behind real IOMMUs, it's normal that they need a reset after having cause=
d a
> fault. I'm not sure if this is described in the related specs for them, b=
ut
> it should be clarify for the virtual IOMMU. But this can be done on top,
> IMHO.

The device behaviour is generally not specified. However their spec can
say something about the bus:

* For Intel VT-d see 7.2 and 7.2.1 (Non-Recoverable Address Translation
  Faults), where the spec provides various implementation examples.

  "Requests that encounter non-recoverable address translation faults are
  aborted by the remapping hardware, and typically require a reset of the
  device (such as through a function-level-reset) to recover and
  re-initialize the device to put it back into service."

  So could be aborted, but as stated later in 7.2.1, can also be
  redirected to a catch-all memory location.

* For Arm SMMU, the host driver can specify for each context whether
  the SMMU should return an abort (Slave Error on the AMBA bus) or not
  (read-zero, write-ignore).

  The spec also says "The behavior of the client device after termination
  is specific to the device." (3.12.1 Terminate model)

* For AMD IOMMU, "when the IOMMU detects an I/O page fault, it target
  aborts the faulting request." and "the IOMMU sets the legacy PCI
  Signaled Target Abort bit, if applicable" (2.1.3.2 I/O Page Faults).
  I believe the equivalent for the PCIe bus is a Completer Abort response.

They can specify the behaviour with some precision, because they also
specify how the IOMMU is integrated with the system. We don't have this
luxury, because if the virtio-iommu is just a proxy for a physical IOMMU,
we don't know how aborts are configured, and the bus may be a variant of
PCI, AMBA or something else.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

