Return-Path: virtio-dev-return-3654-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0B9365818041
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Mar 2018 06:48:44 -0700 (PDT)
Date: Tue, 27 Mar 2018 21:47:05 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180327134705.3zqzangejm2yy3ph@debian>
References: <20180319071537.28649-1-tiwei.bie@intel.com>
 <20180319071537.28649-4-tiwei.bie@intel.com>
 <20180322164345-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180322164345-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v2 3/6] virtio: support adding sub-regions for notify
 region
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Mar 22, 2018 at 04:57:23PM +0200, Michael S. Tsirkin wrote:
> On Mon, Mar 19, 2018 at 03:15:34PM +0800, Tiwei Bie wrote:
[...]
> > +
> > +bool virtio_pci_page_per_vq_enabled(VirtIODevice *vdev)
> > +{
> > +    VirtIOPCIProxy *proxy = virtio_device_to_virtio_pci_proxy(vdev);
> > +
> > +    if (proxy == NULL) {
> > +        return false;
> > +    }
> > +
> > +    return !!(proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ);
> > +}
> > +
> 
> VIRTIO_PCI_FLAG_PAGE_PER_VQ is not something external users
> should care about. Need to find some other way to express the
> specific requirements.
> 
> In particular do you want to use a host page per VQ?
> 
> This isn't what VIRTIO_PCI_FLAG_PAGE_PER_VQ does - it uses a 4K offset
> which does not match a memory page size on all platforms.

Yeah, right. I'll think about how to deal with this.

> 
> 
> > +int virtio_pci_notify_region_map(VirtIODevice *vdev, int queue_idx,
> > +                                 MemoryRegion *mr)
> > +{
> > +    VirtIOPCIProxy *proxy = virtio_device_to_virtio_pci_proxy(vdev);
> > +    int offset;
> > +
> > +    if (proxy == NULL || !virtio_pci_modern(proxy)) {
> > +        return -1;
> > +    }
> > +
> > +    offset = virtio_pci_queue_mem_mult(proxy) * queue_idx;
> > +    memory_region_add_subregion(&proxy->notify.mr, offset, mr);
> > +
> > +    return 0;
> > +}
> > +
> > +void virtio_pci_notify_region_unmap(VirtIODevice *vdev, MemoryRegion *mr)
> > +{
> > +    VirtIOPCIProxy *proxy = virtio_device_to_virtio_pci_proxy(vdev);
> > +
> > +    if (proxy != NULL) {
> > +        memory_region_del_subregion(&proxy->notify.mr, mr);
> > +    }
> > +}
> > +
> >  static void virtio_pci_pre_plugged(DeviceState *d, Error **errp)
> >  {
> >      VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
> > diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> > index 813082b0d7..8061133741 100644
> > --- a/hw/virtio/virtio-pci.h
> > +++ b/hw/virtio/virtio-pci.h
> > @@ -213,6 +213,11 @@ static inline void virtio_pci_disable_modern(VirtIOPCIProxy *proxy)
> >      proxy->disable_modern = true;
> >  }
> >  
> > +bool virtio_pci_page_per_vq_enabled(VirtIODevice *vdev);
> > +int virtio_pci_notify_region_map(VirtIODevice *vdev, int queue_idx,
> > +                                 MemoryRegion *mr);
> > +void virtio_pci_notify_region_unmap(VirtIODevice *vdev, MemoryRegion *mr);
> > +
> >  /*
> >   * virtio-scsi-pci: This extends VirtioPCIProxy.
> >   */
> 
> These are not great APIs unfortunately. Need to come up with generic names.
> E.g. do we register and de-register host notifiers maybe?
> 

I like the name "host notifier". I'll try to use it. Thanks a lot!

> 
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 006d3d1148..90ee72984c 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -22,6 +22,7 @@
> >  #include "qemu/atomic.h"
> >  #include "hw/virtio/virtio-bus.h"
> >  #include "hw/virtio/virtio-access.h"
> > +#include "hw/virtio/virtio-pci.h"
> >  #include "sysemu/dma.h"
> >  
> >  /*
> > @@ -2681,6 +2682,44 @@ void virtio_device_release_ioeventfd(VirtIODevice *vdev)
> >      virtio_bus_release_ioeventfd(vbus);
> >  }
> >  
> > +bool virtio_device_parent_is_pci_device(VirtIODevice *vdev)
> > +{
> > +    BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
> > +    const char *typename = object_get_typename(OBJECT(qbus->parent));
> > +
> > +    return strstr(typename, "pci") != NULL;
> > +}
> > +
> > +bool virtio_device_page_per_vq_enabled(VirtIODevice *vdev)
> > +{
> > +#ifdef CONFIG_VIRTIO_PCI
> > +    if (virtio_device_parent_is_pci_device(vdev)) {
> > +        return virtio_pci_page_per_vq_enabled(vdev);
> > +    }
> > +#endif
> > +    return false;
> > +}
> > +
> 
> A better way to do this is to pass a callback to the bus where each bus can
> implement its own.
> 

It's pretty neat! It helped me get rid of all the
changes to the build scripts. Thanks a lot!

Best regards,
Tiwei Bie

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

