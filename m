Return-Path: virtio-dev-return-7229-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7402A985BC2
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Apr 2020 19:34:33 +0000 (UTC)
Date: Thu, 30 Apr 2020 15:34:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200430152808-mutt-send-email-mst@kernel.org>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
 <20200430101431.GD19932@willie-the-truck>
 <20200430103446.GH5097@quicinc.com>
 <20200430104149.GG19932@willie-the-truck>
 <20200430111156.GI5097@quicinc.com>
 <7bf8bffe-267b-6c66-86c9-40017d3ca4c2@siemens.com>
 <20200430133321.GC3204@quicinc.com>
MIME-Version: 1.0
In-Reply-To: <20200430133321.GC3204@quicinc.com>
Subject: [virtio-dev] Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Will Deacon <will@kernel.org>, konrad.wilk@oracle.com, jasowang@redhat.com, stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 30, 2020 at 07:03:21PM +0530, Srivatsa Vaddagiri wrote:
> * Jan Kiszka <jan.kiszka@siemens.com> [2020-04-30 14:59:50]:
>=20
> > >I believe ivshmem2_virtio requires hypervisor to support PCI device em=
ulation
> > >(for life-cycle management of VMs), which our hypervisor may not suppo=
rt.

PCI is mostly just 2 registers. One sets the affected device, one the data =
to read/write.

> A
> > >simple shared memory and doorbell or message-queue based transport wil=
l work for
> > >us.
> >=20
> > As written in our private conversation, a mapping of the ivshmem2 devic=
e
> > discovery to platform mechanism (device tree etc.) and maybe even the
> > register access for doorbell and life-cycle management to something
> > hypercall-like would be imaginable. What would count more from virtio
> > perspective is a common mapping on a shared memory transport.
>=20
> Yes that sounds simpler for us.
>=20
> > That said, I also warned about all the features that PCI already define=
d
> > (such as message-based interrupts) which you may have to add when going=
 a
> > different way for the shared memory device.
>=20
> Is it really required to present this shared memory as belonging to a PCI
> device?

But then you will go on and add MSI, and NUMA, and security, and and and ..=
.

> I would expect the device-tree to indicate the presence of this shared
> memory region, which we should be able to present to ivshmem2 as shared m=
emory
> region to use (along with some handles for doorbell or message queue use)=
.
>=20
> I understand the usefulness of modeling the shared memory as part of devi=
ce so
> that hypervisor can send events related to peers going down or coming up.=
 In our
> case, there will be other means to discover those events and avoiding thi=
s
> requirement on hypervisor (to emulate PCI) will simplify the solution for=
 us.
>=20
> Any idea when we can expect virtio over ivshmem2 to become available?!

Check out the virtio spec. Right at the beginning it states:

=09These devices are
=09found in virtual environments, yet by design they look like physical dev=
ices to the guest within
=09the virtual machine - and this document treats them as such. This simila=
rity allows the guest to
=09use standard drivers and discovery mechanisms


> --=20
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

