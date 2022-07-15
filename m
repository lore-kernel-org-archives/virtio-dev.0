Return-Path: <virtio-dev-return-9654-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ACA279867F8
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Jul 2022 14:18:40 +0000 (UTC)
From: "Afsa, Baptiste" <Baptiste.Afsa@harman.com>
Date: Fri, 15 Jul 2022 14:18:32 +0000
Message-ID: <1657894712677.5057@harman.com>
References: <6f4f611e95cf49b0b16b37efba6bf78a@HIMDWSMB01.ad.harman.com>,<Ys1704UaN4/e3/Rf@stefanha-x1.localdomain>
In-Reply-To: <Ys1704UaN4/e3/Rf@stefanha-x1.localdomain>
MIME-Version: 1.0
Subject: Re: [virtio-dev] VM memory protection and zero-copy transfers.
Content-Language: fr-FR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> Did you try virtio-pci with an IOMMU? The advantage compared to both=0A> =
your proposal and swiotlb is that workloads that reuse buffers have no=0A> =
performance overhead because the IOMMU mappings remain in place across=0A> =
virtqueue requests.=0A>=0A> I have CCed Jean-Philippe Brucker <jean-philipp=
e@linaro.org> who=0A> designed the virtio-iommu device.=0A>=0A> Using an IO=
MMU can be slower than the approach you are proposing when=0A> each request=
 requires new mappings. That's because your approach=0A> combines the virtq=
ueue kick processing with the page granting whereas=0A> programming an IOMM=
U with map/unmap commands is a separate vmexit from=0A> the virtqueue kick.=
 It's probably easier to make your approach faster in=0A> the dynamic mappi=
ngs case for this reason.=0A>=0A> A page-table based IOMMU (doesn't require=
 explicit map/unamp commands=0A> because it reads mappings on-demand from a=
 page table structure) might=0A> perform better than one that needs to be p=
rogrammed for each each=0A> map/unmap operation. It still needs a kick (vme=
xit) for invalidation but=0A> it might be possible for a design of this typ=
e to avoid vmexits in the=0A> common case.=0A=0AWe considered it at some po=
int with the idea of moving the memory granting to=0Athe driver's side but =
we did not go in this direction for the reason that you=0Amentioned, plus t=
he fact that doing it from the hypervisor allows us to validate=0Athe descr=
iptors while granting the memory and moving them to the shadow queue.=0A=0A=
However, we did not consider workloads where the buffers are reused. I am=
=0Acurious to see how much this is used in practice and the sort of gain we=
 are=0Alooking at.=0A=0AThank you for pointing this out, this looks like so=
mething we should investigate=0Afurther.=0A=0A> > Although the shadow virtq=
ueue concept looks fairly simple, there is still one=0A> > point that has n=
ot been covered yet: indirect descriptors.=0A> >=0A> > To support indirect =
descriptors, the following two options were considered=0A> > initially:=0A>=
 >=0A> >   1. Grant the indirect descriptor as-is to the host while it is o=
n the used=0A> >      ring. This introduces a security issue because a comp=
romised guest OS can=0A> >      modify the indirect descriptor after it has=
 been pushed to the available=0A> >      ring. This would cause the device =
to fault while trying to access any=0A> >      arbitrary memory that was no=
t actually granted.=0A> >=0A> >      Note that in the shadow virtqueue mode=
l, there is no need for the device to=0A> >      validate the descriptors i=
n the available rings, because the hypervisor=0A> >      already performed =
such checks before granting the memory.=0A>=0A> Assuming that the driver ca=
n trust the device isn't possible in all use=0A> cases. Hardware VIRTIO dev=
ice implementations, VDUSE=0A> (https://docs.kernel.org/userspace-api/vduse=
.html), and Confidential=0A> Computing are 3 use cases where the device is =
untrusted. If you make the=0A> assumption then it's important to clearly ma=
rk the code so it won't be=0A> reused in a context where that would be a se=
curity problem.=0A>=0A> >=0A> >   2. Follow the same logic that is used for=
 the "normal" descriptors and=0A> >      introduce shadow indirect descript=
ors. This would require the hypervisor to=0A> >      provision a memory poo=
l to allocate these shadow indirect descriptors and=0A> >      determining =
the size of this pool may not be trivial.=0A> >=0A> >      Additionally, in=
direct descriptors can be as large as the driver wants them=0A> >      to b=
e, something that can cause the hypervisor to copy an arbitrary large=0A> >=
      amount of data.=0A>=0A> I agree that it's unfortunate that indirect d=
escriptors would require=0A> some kind of dynamic memory in the hypervisor.=
 However, the statement=0A> about indirect descriptor size is incorrect. Th=
ey are limited by Queue=0A> Size:=0A>=0A>   VIRTIO 1.2 2.7.5.3.1 Driver Req=
uirements: Indirect Descriptors=0A>=0A>   A driver MUST NOT create a descri=
ptor chain longer than the Queue Size=0A>   of the device.=0A>=0A> >=0A> > =
An alternative approach consists in introducing a new virtio feature bit. T=
his=0A> > feature bit, when set by the device, instructs the driver to allo=
cate indirect=0A> > descriptors using dedicated memory pages. These pages s=
hall hold no other data=0A> > than the indirect descriptors. Since a correc=
t virtio driver implementation does=0A> > not modify an indirect descriptor=
 once it has been pushed to the device, the=0A> > pages where the indirect =
descriptors lies can later on be remapped as read-only=0A> > in the guest a=
ddress space.=0A> >=0A> > This allows the hypervisor to validate the conten=
t of the indirect descriptor,=0A> > grant it to the host (along with all th=
e buffers referenced by this descriptor)=0A> > and remap the indirect descr=
iptor read-only in the guest address space as long=0A> > as it is granted t=
o the host (i.e. until the indirect descriptor is returned=0A> > through th=
e used ring).=0A>=0A> That sounds very slow (2 page table updates per reque=
st).=0A=0AYes it is. As I mentioned, overall this approach is about 40% slo=
wer on the set=0Aof benchmarks we used when compared to running virtio devi=
ces without memory=0Aisolation.=0A=0A> > The present proposal has some obvi=
ous drawbacks, but we believe that memory=0A> > protection will not come fo=
r free. We know that there are other folks out there=0A> > which try to add=
ress this issue of memory sharing between VMs, so we would be=0A> > pleased=
 to hear what you guys think about this approach.=0A> >=0A> > Additionally,=
 we would like to know whether a feature bit similar to the one=0A> > that =
was discussed here could be considered for addition to the virtio standard.=
=0A>=0A> Memory isolation is hard to do efficiently. It would be great to d=
iscuss=0A> your proposal more with the VIRTIO community and then send a spe=
c patch=0A> for detailed review and voting.=0A=0AThis is exactly why we are=
 here!=0A=0AI can indeed prepare a spec patch but before doing that I wante=
d to get some=0Afeedback on this approach and see if anyone in the communit=
y would see any=0Areason not to introduce such a feature bit.=0A=0A> One th=
ing I didn't see in your proposal was a copying vs zero-copy=0A> threshold.=
 Maybe it helps to look at the size of requests and copy data=0A> instead o=
f granting pages when descriptors are small? On the other hand,=0A> a 4 KB =
page size means that many descriptors won't be larger than 4 KB=0A> anyway =
due to guest physical memory fragmentation. This is basically=0A> hybrid of=
 swiotlb and your proposal - zero-copy when it pays off,=0A> copying when i=
t's cheap.=0A>=0A> As I mentioned, I think IOMMUs are worth investigating, =
in particular=0A> for the case where mappings are rarely changed. They are =
fast in that=0A> case.=0A=0AI agree there is much likely a point until whic=
h copying is cheaper. However, we=0Ahave not considered this in our initial=
 investigation.=0A=0AThank you Stefan for taking the time to read this prop=
osal and for your=0Afeedback.=0A=0ABaptiste
---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

