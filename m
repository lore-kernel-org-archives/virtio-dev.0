Return-Path: <virtio-dev-return-9938-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 69DC6986584
	for <virtio-dev@lists.oasis-open.org>; Fri,  9 Sep 2022 08:52:11 +0000 (UTC)
From: "Afsa, Baptiste" <Baptiste.Afsa@harman.com>
Date: Fri, 9 Sep 2022 08:52:02 +0000
Message-ID: <1662713522072.6550@harman.com>
References: <6f4f611e95cf49b0b16b37efba6bf78a@HIMDWSMB01.ad.harman.com>
 <Ys1704UaN4/e3/Rf@stefanha-x1.localdomain>
 <1657894712677.5057@harman.com>,<YtGayTbaFh9cbp/U@stefanha-x1.localdomain>
In-Reply-To: <YtGayTbaFh9cbp/U@stefanha-x1.localdomain>
MIME-Version: 1.0
Subject: Re: [virtio-dev] VM memory protection and zero-copy transfers.
Content-Language: fr-FR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hello,=0A=0AI ran some benchmarks to compare the performances achieved by t=
he swiotlb=0Aapproach and our dynamic memory granting solution while using =
different buffer=0Asizes. Without any surprise, the swiotlb approach perfor=
ms much better when the=0Abuffers are small. Actually for small buffers, th=
e performances are on par with=0Athe original configuration where the entir=
e memory is shared. Of course these=0Aresults are specific to the platform =
I used and the system workload (e.g. CPU=0Autilization, caches utilization)=
.=0A=0AAt the moment we are not planning to add a mechanism that would take=
 the=0Adecision between copying or granting the buffers dynamically based o=
n their=0Asizes, but this experience showed us that devices that uses small=
 packets would=0Abenefits from going through the swiotlb. So we are conside=
ring making this=0Aconfigurable on a per-device basis in our solution.=0A=
=0AWe have also experimented with the use of a virtual IOMMU on the guest s=
ide and=0Awe have a few concerns with this option.=0A=0AIf we add a virtual=
 IOMMU, we can see mapping commands being issued as virtio=0Abuffers are ex=
changed between the device and the driver. However the kernel=0Acontrols th=
e mappings from DMA addresses to physical addresses. In theory, we=0Acould =
remap the memory in the host address space to "implement" these mappings=0A=
but we have some additional constraints that make this approach problematic=
.=0A=0AOur solution runs on systems where the physical IOMMU does not suppo=
rt address=0Atranslation. So we rely on having an identity mapping between =
the guest address=0Aspace and the physical address space to allow the guest=
 OS to initiate DMA=0Atransactions. If the memory that we import for virtio=
 buffers uses translated=0Aaddresses, these buffers cannot be used in DMA t=
ransactions.=0A=0AWe also have an issue with letting the driver control the=
 exported memory=0Athrough an IOMMU. If we do this, we need to consider wha=
t will happen if the=0Aguest unmaps a virtio buffer while it is in use on t=
he device side.=0A=0AAlthough it looks possible to recover from such a scen=
ario in the case of a=0Adevice doing CPU accesses to the shared memory, thi=
ngs get more complicated if=0Awe start considering that the buffer may be i=
nvolved in a DMA transaction.=0A=0AIn some previous projects, we have learn=
ed that the ability for the hardware=0Adevice and/or its associated driver =
to recover from an aborted transaction is=0Anot something that we can rely =
upon in the general case.=0A=0AFor this reason, in our typical memory grant=
ing scenarios, we usually "lock" the=0Ashared memory regions to prevent the=
 exporter from revoking the mappings until=0Athe importer says it is ok to =
do so.=0A=0ANote that locking the mappings could be applied here as well. I=
n this case, we=0Awould still use this concept of shadow virtqueues and the=
 hypervisor would be=0Aresponsible for locking/unlocking the virtio buffers=
 as they cycle between the=0Adevice and the driver. This design is likely t=
o be slower than the original=0Aimplementation as the cost of locking the m=
appings is significant (i.e. an extra=0Apage table walk to validate the mem=
ory regions).=0A=0AAs we discussed in this thread, there are a few options =
available to enable=0Avirtio in configurations where the VM address spaces =
are isolated. I think they=0Aall have different trade-offs. Our approach ce=
rtainly have some drawbacks but it=0Aalso addresses some specific considera=
tions that are relevant in our use=0Acase. Different configurations will pr=
obably require different solutions to this=0Aquestion.=0A=0AWhat would be t=
he next steps to go forward with adding a new feature bit such as=0Athe one=
 I discussed in my original email? Should we prepare a patch on the=0Aspeci=
fication and post it here for further discussions?=0A=0ABaptiste=0A
---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

