Return-Path: <virtio-dev-return-9750-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E9A90986350
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 Aug 2022 12:23:58 +0000 (UTC)
Message-ID: <e2701032-a84e-3917-8e40-71facb3dc4eb@opensynergy.com>
Date: Wed, 10 Aug 2022 14:23:48 +0200
From: Igor Skalkin <igor.skalkin@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] virtio-mmio: Introduce virtio_mmio hotplug
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Igor Skalkin <igor.skalkin@opensynergy.com>

While the virtio device is not yet running, the virtual machine manager
advertises the device with device_id set to 0.
During virtio mmio probing, the device_id is checked, and if it is 0,
the rest of the probing function is deferred until the interrupt arrives.

Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
---
In our setup, we have a Linux host running virtio devices and virtualised
Linux/Android Guest[s] running virtio drivers.
Situation "the guest OS calls the probe() function for the virtio driver,
but the virtio device has not yet started in the host OS." keeps happening.
Also, some devices need to be hot-plugged later instead of starting during
system sturtup.

Probing of the guest virtio drivers should be deferred until the host devic=
e
has started.
---
 drivers/virtio/virtio_mmio.c | 58 ++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 083ff1eb743d..c2e28a8faaaa 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -91,6 +91,8 @@ struct virtio_mmio_device {
        /* a list of queues so we can dispatch IRQs */
        spinlock_t lock;
        struct list_head virtqueues;
+
+       struct work_struct hotplug_work;
 };
  struct virtio_mmio_vq_info {
@@ -592,6 +594,43 @@ static void virtio_mmio_release_dev(struct device *_d)
  /* Platform device */
 +static irqreturn_t hotplug_interrupt(int irq, void *opaque)
+{
+       struct virtio_mmio_device *vm_dev =3D opaque;
+
+       if (readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID))
+               schedule_work(&vm_dev->hotplug_work);
+
+       return IRQ_HANDLED;
+}
+
+static int virtio_mmio_request_irq(irq_handler_t handler,
+                                  struct virtio_mmio_device *vm_dev)
+{
+       int err;
+
+       err =3D request_irq(platform_get_irq(vm_dev->pdev, 0), handler,
+                         IRQF_SHARED, dev_name(&vm_dev->pdev->dev), vm_dev=
);
+       if (err)
+               dev_err(&vm_dev->pdev->dev, "request_irq(%s) returns %d\n",
+                       dev_name(&vm_dev->pdev->dev), err);
+
+       return err;
+}
+
+static int finish_probe(struct virtio_mmio_device *vm_dev);
+static void virtio_mmio_hotplug_work(struct work_struct *hotplug_work)
+{
+       struct virtio_mmio_device *vm_dev =3D
+               container_of(hotplug_work, struct virtio_mmio_device,
+                           hotplug_work);
+
+       free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
+
+       if (finish_probe(vm_dev))
+               virtio_mmio_request_irq(hotplug_interrupt, vm_dev);
+}
+
 static int virtio_mmio_probe(struct platform_device *pdev)
 {
        struct virtio_mmio_device *vm_dev;
@@ -628,6 +667,25 @@ static int virtio_mmio_probe(struct platform_device
*pdev)
                return -ENXIO;
        }
 +      vm_dev->vdev.id.device =3D readl(vm_dev->base + VIRTIO_MMIO_DEVICE_=
ID);
+       if (!vm_dev->vdev.id.device) {
+               rc =3D virtio_mmio_request_irq(hotplug_interrupt, vm_dev);
+               if (rc)
+                       return rc;
+
+               INIT_WORK(&vm_dev->hotplug_work, virtio_mmio_hotplug_work);
+
+               return 0;
+       }
+
+       return finish_probe(vm_dev);
+}
+
+static int finish_probe(struct virtio_mmio_device *vm_dev)
+{
+       struct platform_device *pdev =3D vm_dev->pdev;
+       int rc;
+
        vm_dev->vdev.id.device =3D readl(vm_dev->base + VIRTIO_MMIO_DEVICE_=
ID);
        if (vm_dev->vdev.id.device =3D=3D 0) {
                /*
--
2.37.1



Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

