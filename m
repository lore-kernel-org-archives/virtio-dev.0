Return-Path: virtio-dev-return-7433-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 04B64985E06
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 Jun 2020 02:04:18 +0000 (UTC)
References: <20200529080303.15449-1-jasowang@redhat.com>
 <20200529080303.15449-5-jasowang@redhat.com>
 <CAJPjb1JGn-+Y2EHvn1S+=uX_cjPVEUmGGo7CmAM2kTqyn4NRYQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e8a88037-4027-b919-684d-9b83416c1c12@redhat.com>
Date: Tue, 2 Jun 2020 10:04:09 +0800
MIME-Version: 1.0
In-Reply-To: <CAJPjb1JGn-+Y2EHvn1S+=uX_cjPVEUmGGo7CmAM2kTqyn4NRYQ@mail.gmail.com>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH 4/6] vhost_vdpa: support doorbell mapping
 via mmap
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Rob Miller <rob.miller@broadcom.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/5/30 =E4=B8=8A=E5=8D=882:30, Rob Miller wrote:
> Given the need for 4K doorbell such that QEMU can easily map, ect, and=20
> assuming that I have a HW device which exposes 2 VQ's, with a=20
> notification area off of BAR3, offset=3Dwhatever, notifier_multiplier=3D4=
,=20
> we don't need to have 2 x 4K pages mapped into the VM for both=20
> doorbells do we? The guest driver would ring DB0 at BAR4+offset, and=20
> DB1 at BAR4+offset+(4*1).


This requires qemu to advertise notifier_multiplier =3D 4 to guest, it has=
=20
several implications:

- guest may think control virtqueue sit in the same page then we can't=20
trap access to control virtqueue, qemu may lose the state of the device
- it requires the destination to have exact the same queue_notify_off=20
and notifier_multiplier in order to let migration to work

So for doorbell mapping itself, we can support the mapping of doorbells=20
at once which may occupy one or more pages, but it may bring troubles=20
for other features.


>
> The 4K per DB is useful=C2=A0how? This allows for QEMU trapping of=20
> individual DBs, that can then be used to do what, just forward the DBs=20
> via some other scheme - this makes sense for non-HW related Virtio=20
> devices I guess. Is this why there is a qemu option?


The page per vq option provides extra flexibility. Note that it's the=20
layout seen by guest, so actually for hardware vendor, the most easy way=20
is to:

- use a single doorbell register for all virtqueues except for the=20
control virtqueue (driver can differ queue index by the value wrote by=20
the driver)
- do not share the page with other registers

In this way, it doesn't require much BAR space and we can still:

- map doorbell separately to guest: guest may see a page per vq doorbell=20
layout but in fact all those pages are mapped into the same page
- trap the control virtqueue, (don't do mmap for control vq)

Thanks


>
> Rob Miller
> rob.miller@broadcom.com <mailto:rob.miller@broadcom.com>
> (919)721-3339
>
>
> On Fri, May 29, 2020 at 4:03 AM Jason Wang <jasowang@redhat.com=20
> <mailto:jasowang@redhat.com>> wrote:
>
>     Currently the doorbell is relayed via eventfd which may have
>     significant overhead because of the cost of vmexits or syscall. This
>     patch introduces mmap() based doorbell mapping which can eliminate th=
e
>     overhead caused by vmexit or syscall.
>
>     To ease the userspace modeling of the doorbell layout (usually
>     virtio-pci), this patch starts from a doorbell per page
>     model. Vhost-vdpa only support the hardware doorbell that sit at the
>     boundary of a page and does not share the page with other registers.
>
>     Doorbell of each virtqueue must be mapped separately, pgoff is the
>     index of the virtqueue. This allows userspace to map a subset of the
>     doorbell which may be useful for the implementation of software
>     assisted virtqueue (control vq) in the future.
>
>     Signed-off-by: Jason Wang <jasowang@redhat.com
>     <mailto:jasowang@redhat.com>>
>     ---
>     =C2=A0drivers/vhost/vdpa.c | 59
>     ++++++++++++++++++++++++++++++++++++++++++++
>     =C2=A01 file changed, 59 insertions(+)
>
>     diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>     index 6ff72289f488..bbe23cea139a 100644
>     --- a/drivers/vhost/vdpa.c
>     +++ b/drivers/vhost/vdpa.c
>     @@ -15,6 +15,7 @@
>     =C2=A0#include <linux/module.h>
>     =C2=A0#include <linux/cdev.h>
>     =C2=A0#include <linux/device.h>
>     +#include <linux/mm.h>
>     =C2=A0#include <linux/iommu.h>
>     =C2=A0#include <linux/uuid.h>
>     =C2=A0#include <linux/vdpa.h>
>     @@ -741,12 +742,70 @@ static int vhost_vdpa_release(struct inode
>     *inode, struct file *filep)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>     =C2=A0}
>
>     +static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
>     +{
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost_vdpa *v =3D vmf->vma->vm_fil=
e->private_data;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vdpa_device *vdpa =3D v->vdpa;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct vdpa_config_ops *ops =3D vdp=
a->config;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vdpa_notification_area notify;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vm_area_struct *vma =3D vmf->vma;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 index =3D vma->vm_pgoff;
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0notify =3D ops->get_vq_notification(vdpa,=
 index);
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0vma->vm_page_prot =3D pgprot_noncached(vm=
a->vm_page_prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (remap_pfn_range(vma, vmf->address & P=
AGE_MASK,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0notify.addr >> PAGE_SHIFT, PAGE_SIZE,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vma->vm_page_prot))
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return VM_FAU=
LT_SIGBUS;
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0return VM_FAULT_NOPAGE;
>     +}
>     +
>     +static const struct vm_operations_struct vhost_vdpa_vm_ops =3D {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0.fault =3D vhost_vdpa_fault,
>     +};
>     +
>     +static int vhost_vdpa_mmap(struct file *file, struct
>     vm_area_struct *vma)
>     +{
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost_vdpa *v =3D vma->vm_file->pr=
ivate_data;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vdpa_device *vdpa =3D v->vdpa;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct vdpa_config_ops *ops =3D vdp=
a->config;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vdpa_notification_area notify;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0int index =3D vma->vm_pgoff;
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (vma->vm_end - vma->vm_start !=3D PAGE=
_SIZE)
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVA=
L;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((vma->vm_flags & VM_SHARED) =3D=3D 0)
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVA=
L;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (vma->vm_flags & VM_READ)
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVA=
L;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (index > 65535)
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVA=
L;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ops->get_vq_notification)
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTS=
UPP;
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* To be safe and easily modelled by user=
space, We only
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * support the doorbell which sits on the=
 page boundary and
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * does not share the page with other reg=
isters.
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0notify =3D ops->get_vq_notification(vdpa,=
 index);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (notify.addr & (PAGE_SIZE - 1))
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVA=
L;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (vma->vm_end - vma->vm_start !=3D noti=
fy.size)
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTS=
UPP;
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0vma->vm_ops =3D &vhost_vdpa_vm_ops;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>     +}
>     +
>     =C2=A0static const struct file_operations vhost_vdpa_fops =3D {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D THIS_MODULE,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 .open=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D vhost_vdpa_open,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 .release=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D v=
host_vdpa_release,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 .write_iter=C2=A0 =C2=A0 =C2=A0=3D vhost_=
vdpa_chr_write_iter,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 .unlocked_ioctl =3D vhost_vdpa_unlocked_i=
octl,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0.mmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D vhost_vdpa_mmap,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 .compat_ioctl=C2=A0 =C2=A0=3D compat_ptr_=
ioctl,
>     =C2=A0};
>
>     --=20
>     2.20.1
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

