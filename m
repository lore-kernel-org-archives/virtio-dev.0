Return-Path: <virtio-dev-return-9651-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 173F5986508
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Jul 2022 13:56:36 +0000 (UTC)
From: "Afsa, Baptiste" <Baptiste.Afsa@harman.com>
Date: Fri, 8 Jul 2022 13:56:31 +0000
Message-ID: <6f4f611e95cf49b0b16b37efba6bf78a@HIMDWSMB01.ad.harman.com>
MIME-Version: 1.0
Subject: [virtio-dev] VM memory protection and zero-copy transfers.
Content-Language: fr-FR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hello everyone,=0A=0AThe traditional virtio model relies on the ability for=
 the host to access the=0Aentire memory of the guest VM. Virtio is also use=
d in system configurations=0Awhere the devices are not featured by the host=
 (which may not exist as such in=0Athe case of a Type-1 hypervisor) but by =
another, unprivileged guest VM. In such=0Aa configuration, the guest VM mem=
ory sharing requirement would raise security=0Aconcerns.=0A=0AThe following=
 proposal removes that requirement by introducing an alternative=0Amodel wh=
ere the interactions between the virtio driver and the virtio device are=0A=
mediated by the hypervisor. This concept is applicable to both Type-1 and T=
ype-2=0Ahypervisors. In the following write-up, the "host" thus refers eith=
er to the=0Ahost OS or to the guest VM that executes the virtio device.=0A=
=0AThe main objective is to keep the memory of the VM that runs the driver =
isolated=0Afrom the memory that runs the device, while still allowing zero-=
copy transfers=0Abetween the two domains. The operations that control the e=
xchange of the virtio=0Abuffers are handled by hypervisor code that sits be=
tween the device and the=0Adriver.=0A=0AAs opposed to the regular virtio mo=
del, the virtqueues allocated by the driver=0Aare not shared with the devic=
e directly. Instead, the hypervisor allocates a=0Aseparate set of virtqueue=
s that have the same sizes as the original ones and=0Ashares this second se=
t with the device. These hypervisor-allocated virtqueues=0Aare referred as =
the "shadow virtqueues".=0A=0ADuring device operation, the hypervisor copie=
s the descriptors between the=0Adriver and the shadow virtqueues as the buf=
fers cycle between the driver and the=0Adevice.=0A=0AWhenever the driver ad=
ds some buffers to the available ring, the hypervisor=0Avalidates the descr=
iptors and dynamically grants the I/O buffers to the host or=0AVM that runs=
 the device. The hypervisor then copies these descriptors to the=0Ashadow v=
irtqueue's available ring. At the other end, when the device returns=0Abuff=
ers to the shadow virtqueue's used ring, the hypervisor unmaps these buffer=
s=0Afrom the host's address space and copy the descriptor to the driver's u=
sed ring.=0A=0AAlthough the virtio buffers can be allocated anywhere in the=
 guest memory and=0Aare not necessarily page-aligned, the memory sharing gr=
anularity is constrained=0Aby the page size. So when a buffer is mapped to =
the host address space, the=0Ahypervisor may end up sharing more memory tha=
t what is strictly needed.=0A=0AThe cost of granting the memory dynamically=
 as virtio transfers goes is=0Asignificant, though. We measured up to 40% p=
erformance degradation when using=0Athis dynamic buffer granting mechanism.=
=0A=0AWe also compared this solution to other approaches that we have seen =
elsewhere.=0AFor instance, using the swiotlb mechanism along with the=0AVIR=
TIO_F_ACCESS_PLATFORM feature bit to force a copy of the I/O buffers to a=
=0Astatically shared memory region. In that case, the same set of benchmark=
s shows=0Aan even bigger performance degradation, up to 60%, compared to th=
e original=0Avirtio performance.=0A=0AAlthough the shadow virtqueue concept=
 looks fairly simple, there is still one=0Apoint that has not been covered =
yet: indirect descriptors.=0A=0ATo support indirect descriptors, the follow=
ing two options were considered=0Ainitially:=0A=0A  1. Grant the indirect d=
escriptor as-is to the host while it is on the used=0A     ring. This intro=
duces a security issue because a compromised guest OS can=0A     modify the=
 indirect descriptor after it has been pushed to the available=0A     ring.=
 This would cause the device to fault while trying to access any=0A     arb=
itrary memory that was not actually granted.=0A=0A     Note that in the sha=
dow virtqueue model, there is no need for the device to=0A     validate the=
 descriptors in the available rings, because the hypervisor=0A     already =
performed such checks before granting the memory.=0A=0A  2. Follow the same=
 logic that is used for the "normal" descriptors and=0A     introduce shado=
w indirect descriptors. This would require the hypervisor to=0A     provisi=
on a memory pool to allocate these shadow indirect descriptors and=0A     d=
etermining the size of this pool may not be trivial.=0A=0A     Additionally=
, indirect descriptors can be as large as the driver wants them=0A     to b=
e, something that can cause the hypervisor to copy an arbitrary large=0A   =
  amount of data.=0A=0AAn alternative approach consists in introducing a ne=
w virtio feature bit. This=0Afeature bit, when set by the device, instructs=
 the driver to allocate indirect=0Adescriptors using dedicated memory pages=
. These pages shall hold no other data=0Athan the indirect descriptors. Sin=
ce a correct virtio driver implementation does=0Anot modify an indirect des=
criptor once it has been pushed to the device, the=0Apages where the indire=
ct descriptors lies can later on be remapped as read-only=0Ain the guest ad=
dress space.=0A=0AThis allows the hypervisor to validate the content of the=
 indirect descriptor,=0Agrant it to the host (along with all the buffers re=
ferenced by this descriptor)=0Aand remap the indirect descriptor read-only =
in the guest address space as long=0Aas it is granted to the host (i.e. unt=
il the indirect descriptor is returned=0Athrough the used ring).=0A=0AThe p=
resent proposal has some obvious drawbacks, but we believe that memory=0Apr=
otection will not come for free. We know that there are other folks out the=
re=0Awhich try to address this issue of memory sharing between VMs, so we w=
ould be=0Apleased to hear what you guys think about this approach.=0A=0AAdd=
itionally, we would like to know whether a feature bit similar to the one=
=0Athat was discussed here could be considered for addition to the virtio s=
tandard.=0A=0ALooking forwards to hear from you.=0ABaptiste=0A
---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

