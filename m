Return-Path: virtio-dev-return-7429-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC3AE9860A0
	for <virtio-dev@lists.oasis-open.org>; Fri, 29 May 2020 18:30:48 +0000 (UTC)
MIME-Version: 1.0
References: <20200529080303.15449-1-jasowang@redhat.com> <20200529080303.15449-5-jasowang@redhat.com>
In-Reply-To: <20200529080303.15449-5-jasowang@redhat.com>
From: Rob Miller <rob.miller@broadcom.com>
Date: Fri, 29 May 2020 14:30:19 -0400
Message-ID: <CAJPjb1JGn-+Y2EHvn1S+=uX_cjPVEUmGGo7CmAM2kTqyn4NRYQ@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH 4/6] vhost_vdpa: support doorbell mapping via mmap
Content-Type: multipart/alternative; boundary="000000000000d094a005a6cda45c"
To: Jason Wang <jasowang@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000d094a005a6cda45c
Content-Type: text/plain; charset="UTF-8"

Given the need for 4K doorbell such that QEMU can easily map, ect, and
assuming that I have a HW device which exposes 2 VQ's, with a notification
area off of BAR3, offset=whatever, notifier_multiplier=4, we don't need to
have 2 x 4K pages mapped into the VM for both doorbells do we? The guest
driver would ring DB0 at BAR4+offset, and DB1 at BAR4+offset+(4*1).

The 4K per DB is useful how? This allows for QEMU trapping of individual
DBs, that can then be used to do what, just forward the DBs via some other
scheme - this makes sense for non-HW related Virtio devices I guess. Is
this why there is a qemu option?

Rob Miller
rob.miller@broadcom.com
(919)721-3339


On Fri, May 29, 2020 at 4:03 AM Jason Wang <jasowang@redhat.com> wrote:

> Currently the doorbell is relayed via eventfd which may have
> significant overhead because of the cost of vmexits or syscall. This
> patch introduces mmap() based doorbell mapping which can eliminate the
> overhead caused by vmexit or syscall.
>
> To ease the userspace modeling of the doorbell layout (usually
> virtio-pci), this patch starts from a doorbell per page
> model. Vhost-vdpa only support the hardware doorbell that sit at the
> boundary of a page and does not share the page with other registers.
>
> Doorbell of each virtqueue must be mapped separately, pgoff is the
> index of the virtqueue. This allows userspace to map a subset of the
> doorbell which may be useful for the implementation of software
> assisted virtqueue (control vq) in the future.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/vdpa.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 6ff72289f488..bbe23cea139a 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/cdev.h>
>  #include <linux/device.h>
> +#include <linux/mm.h>
>  #include <linux/iommu.h>
>  #include <linux/uuid.h>
>  #include <linux/vdpa.h>
> @@ -741,12 +742,70 @@ static int vhost_vdpa_release(struct inode *inode,
> struct file *filep)
>         return 0;
>  }
>
> +static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
> +{
> +       struct vhost_vdpa *v = vmf->vma->vm_file->private_data;
> +       struct vdpa_device *vdpa = v->vdpa;
> +       const struct vdpa_config_ops *ops = vdpa->config;
> +       struct vdpa_notification_area notify;
> +       struct vm_area_struct *vma = vmf->vma;
> +       u16 index = vma->vm_pgoff;
> +
> +       notify = ops->get_vq_notification(vdpa, index);
> +
> +       vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +       if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
> +                           notify.addr >> PAGE_SHIFT, PAGE_SIZE,
> +                           vma->vm_page_prot))
> +               return VM_FAULT_SIGBUS;
> +
> +       return VM_FAULT_NOPAGE;
> +}
> +
> +static const struct vm_operations_struct vhost_vdpa_vm_ops = {
> +       .fault = vhost_vdpa_fault,
> +};
> +
> +static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +       struct vhost_vdpa *v = vma->vm_file->private_data;
> +       struct vdpa_device *vdpa = v->vdpa;
> +       const struct vdpa_config_ops *ops = vdpa->config;
> +       struct vdpa_notification_area notify;
> +       int index = vma->vm_pgoff;
> +
> +       if (vma->vm_end - vma->vm_start != PAGE_SIZE)
> +               return -EINVAL;
> +       if ((vma->vm_flags & VM_SHARED) == 0)
> +               return -EINVAL;
> +       if (vma->vm_flags & VM_READ)
> +               return -EINVAL;
> +       if (index > 65535)
> +               return -EINVAL;
> +       if (!ops->get_vq_notification)
> +               return -ENOTSUPP;
> +
> +       /* To be safe and easily modelled by userspace, We only
> +        * support the doorbell which sits on the page boundary and
> +        * does not share the page with other registers.
> +        */
> +       notify = ops->get_vq_notification(vdpa, index);
> +       if (notify.addr & (PAGE_SIZE - 1))
> +               return -EINVAL;
> +       if (vma->vm_end - vma->vm_start != notify.size)
> +               return -ENOTSUPP;
> +
> +       vma->vm_ops = &vhost_vdpa_vm_ops;
> +       return 0;
> +}
> +
>  static const struct file_operations vhost_vdpa_fops = {
>         .owner          = THIS_MODULE,
>         .open           = vhost_vdpa_open,
>         .release        = vhost_vdpa_release,
>         .write_iter     = vhost_vdpa_chr_write_iter,
>         .unlocked_ioctl = vhost_vdpa_unlocked_ioctl,
> +       .mmap           = vhost_vdpa_mmap,
>         .compat_ioctl   = compat_ptr_ioctl,
>  };
>
> --
> 2.20.1
>
>

--000000000000d094a005a6cda45c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Given the need for 4K doorbell such that QEMU can easily m=
ap, ect, and assuming that I have a HW device which exposes 2 VQ&#39;s, wit=
h a notification area off of BAR3, offset=3Dwhatever, notifier_multiplier=
=3D4, we don&#39;t need to have 2 x 4K pages mapped into the VM for both do=
orbells do we? The guest driver would ring DB0 at BAR4+offset, and DB1 at B=
AR4+offset+(4*1).<div><br></div><div>The 4K per DB is useful=C2=A0how? This=
 allows for QEMU trapping of individual DBs, that can then be used to do wh=
at, just forward the DBs via some other scheme - this makes sense for non-H=
W related Virtio devices I guess. Is this why there is a qemu option?</div>=
<div><br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature" data=
-smartmail=3D"gmail_signature"><div dir=3D"ltr">Rob Miller<div><a href=3D"m=
ailto:rob.miller@broadcom.com" target=3D"_blank">rob.miller@broadcom.com</a=
></div><div>(919)721-3339</div></div></div></div><br></div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 29, =
2020 at 4:03 AM Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasow=
ang@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Currently the doorbell is relayed via eventfd which may have<=
br>
significant overhead because of the cost of vmexits or syscall. This<br>
patch introduces mmap() based doorbell mapping which can eliminate the<br>
overhead caused by vmexit or syscall.<br>
<br>
To ease the userspace modeling of the doorbell layout (usually<br>
virtio-pci), this patch starts from a doorbell per page<br>
model. Vhost-vdpa only support the hardware doorbell that sit at the<br>
boundary of a page and does not share the page with other registers.<br>
<br>
Doorbell of each virtqueue must be mapped separately, pgoff is the<br>
index of the virtqueue. This allows userspace to map a subset of the<br>
doorbell which may be useful for the implementation of software<br>
assisted virtqueue (control vq) in the future.<br>
<br>
Signed-off-by: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=
=3D"_blank">jasowang@redhat.com</a>&gt;<br>
---<br>
=C2=A0drivers/vhost/vdpa.c | 59 +++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 59 insertions(+)<br>
<br>
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c<br>
index 6ff72289f488..bbe23cea139a 100644<br>
--- a/drivers/vhost/vdpa.c<br>
+++ b/drivers/vhost/vdpa.c<br>
@@ -15,6 +15,7 @@<br>
=C2=A0#include &lt;linux/module.h&gt;<br>
=C2=A0#include &lt;linux/cdev.h&gt;<br>
=C2=A0#include &lt;linux/device.h&gt;<br>
+#include &lt;linux/mm.h&gt;<br>
=C2=A0#include &lt;linux/iommu.h&gt;<br>
=C2=A0#include &lt;linux/uuid.h&gt;<br>
=C2=A0#include &lt;linux/vdpa.h&gt;<br>
@@ -741,12 +742,70 @@ static int vhost_vdpa_release(struct inode *inode, st=
ruct file *filep)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
+static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost_vdpa *v =3D vmf-&gt;vma-&gt;vm_fil=
e-&gt;private_data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vdpa_device *vdpa =3D v-&gt;vdpa;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct vdpa_config_ops *ops =3D vdpa-&gt;=
config;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vdpa_notification_area notify;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vm_area_struct *vma =3D vmf-&gt;vma;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 index =3D vma-&gt;vm_pgoff;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0notify =3D ops-&gt;get_vq_notification(vdpa, in=
dex);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vma-&gt;vm_page_prot =3D pgprot_noncached(vma-&=
gt;vm_page_prot);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (remap_pfn_range(vma, vmf-&gt;address &amp; =
PAGE_MASK,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0notify.addr &gt;&gt; PAGE_SHIFT, PAGE_SIZE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0vma-&gt;vm_page_prot))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return VM_FAULT_SIG=
BUS;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return VM_FAULT_NOPAGE;<br>
+}<br>
+<br>
+static const struct vm_operations_struct vhost_vdpa_vm_ops =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.fault =3D vhost_vdpa_fault,<br>
+};<br>
+<br>
+static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)<=
br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost_vdpa *v =3D vma-&gt;vm_file-&gt;pr=
ivate_data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vdpa_device *vdpa =3D v-&gt;vdpa;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct vdpa_config_ops *ops =3D vdpa-&gt;=
config;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vdpa_notification_area notify;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int index =3D vma-&gt;vm_pgoff;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (vma-&gt;vm_end - vma-&gt;vm_start !=3D PAGE=
_SIZE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((vma-&gt;vm_flags &amp; VM_SHARED) =3D=3D 0=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (vma-&gt;vm_flags &amp; VM_READ)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (index &gt; 65535)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ops-&gt;get_vq_notification)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTSUPP;<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* To be safe and easily modelled by userspace,=
 We only<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * support the doorbell which sits on the page =
boundary and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * does not share the page with other registers=
.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0notify =3D ops-&gt;get_vq_notification(vdpa, in=
dex);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (notify.addr &amp; (PAGE_SIZE - 1))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (vma-&gt;vm_end - vma-&gt;vm_start !=3D noti=
fy.size)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTSUPP;<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vma-&gt;vm_ops =3D &amp;vhost_vdpa_vm_ops;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
=C2=A0static const struct file_operations vhost_vdpa_fops =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TH=
IS_MODULE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .open=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D vhost_vdpa_open,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .release=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D vhost_v=
dpa_release,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .write_iter=C2=A0 =C2=A0 =C2=A0=3D vhost_vdpa_c=
hr_write_iter,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .unlocked_ioctl =3D vhost_vdpa_unlocked_ioctl,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.mmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D vhost_vdpa_mmap,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .compat_ioctl=C2=A0 =C2=A0=3D compat_ptr_ioctl,=
<br>
=C2=A0};<br>
<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div>

--000000000000d094a005a6cda45c--

