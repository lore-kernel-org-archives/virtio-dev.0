Return-Path: virtio-dev-return-7492-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AE4AF986127
	for <virtio-dev@lists.oasis-open.org>; Fri, 19 Jun 2020 08:02:42 +0000 (UTC)
Date: Fri, 19 Jun 2020 10:02:28 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <20200619080228.GA2530@myrica>
References: <87a7194kgt.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87a7194kgt.fsf@linaro.org>
Subject: [virtio-dev] Re: Constraining where a guest may allocate virtio accessible
 resources
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, David Hildenbrand <david@redhat.com>, jan.kiszka@siemens.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Azzedine Touzni <atouzni@qti.qualcomm.com>, =?utf-8?B?RnJhbsOnb2lz?= Ozog <francois.ozog@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Soni, Trilok" <tsoni@quicinc.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jun 17, 2020 at 06:31:15PM +0100, Alex Benn=C3=A9e wrote:
[...]
> Option 2 - Additional Platform Data
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> This would be extending using something like device tree or ACPI tables
> which could define regions of memory that would inform the low level
> memory allocation routines where they could allocate from. There is
> already of the concept of "dma-ranges" in device tree which can be a
> per-device property which defines the region of space that is DMA
> coherent for a device.

They are regions that are accessible to a device for DMA, coherency is
described through other methods.

Thinking more about this, dma-ranges (and ACPI _DMA) don't exactly
describe what you need. They describe addressing limitation from a
bridge's perspective, for example from the PCI root complex. So there are
at least two issues:

1. They apply to the whole downstream bus, so you can't define per-device
   DMA windows. Although with PCIe I suppose you could put one on each
   downstream port.

2. More importantly, they only describe addressing limitations locally.
   When the device directly accesses memory, it emits guest-physical
   addresses (GPA) so you can use DMA ranges to describe which memory it
   can access. However, if there is an IOMMU in between, the device emits
   I/O virtual addresses (IOVA), which are translated by the IOMMU into
   GPA. In this case the DMA ranges apply to the IOVA, and there doesn't
   exist a way to describe limitations on the GPA.

There are other mechanisms describing addressing limitations such as
Intel's RMRR, but those also apply to IOVAs as far as I know.

Thanks,
Jean

>=20
> There is the question of how you tie regions declared here with the
> eventual instantiating of the VirtIO devices?
>=20
> For a fully distributed set of backends (one backend per device per
> worker VM) you would need several different regions. Would each region
> be tied to each device or just a set of areas the guest would allocate
> from in sequence?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

