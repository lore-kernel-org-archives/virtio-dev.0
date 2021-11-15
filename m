Return-Path: <virtio-dev-return-8948-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA628986301
	for <virtio-dev@lists.oasis-open.org>; Mon, 15 Nov 2021 10:29:21 +0000 (UTC)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Mon, 15 Nov 2021 10:29:10 +0000
Message-Id: <20211115102910.7639-1-cristian.marussi@arm.com>
Subject: [virtio-dev] [PATCH] firmware: arm_scmi: Make virtio Version_1 compliance optional
Content-Type: text/plain; charset="US-ASCII"
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, Cristian Marussi <cristian.marussi@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Introduce a compilation option to disable strict enforcement of compliance
against VirtIO Version_1 backends, so as to allow to support also Legacy
VirtIO devices implementations.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/Kconfig  | 14 ++++++++++++++
 drivers/firmware/arm_scmi/virtio.c |  3 ++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 3d7081e84853..1e6c4659b640 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -77,6 +77,20 @@ config ARM_SCMI_TRANSPORT_VIRTIO
 	  If you want the ARM SCMI PROTOCOL stack to include support for a
 	  transport based on VirtIO, answer Y.
 
+config ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE
+	bool "SCMI VirtIO transport Version 1 compliance"
+	depends on ARM_SCMI_TRANSPORT_VIRTIO
+	default y
+	help
+	  This enforces strict compliance with VirtIO Version 1 specification.
+
+	  If you want the ARM SCMI VirtIO transport layer to refuse to work
+	  with Legacy VirtIO backends and instead support only VirtIO Version 1
+	  devices (or above), answer Y.
+	  If you want instead to support also old Legacy VirtIO backends (like
+	  the ones implemented by kvmtool) and let the core Kernel VirtIO layer
+	  take care of the needed conversions, say N.
+
 endif #ARM_SCMI_PROTOCOL
 
 config ARM_SCMI_POWER_DOMAIN
diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index c8cab5652daf..bcfc4474535b 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -459,12 +459,13 @@ static void scmi_vio_remove(struct virtio_device *vdev)
 
 static int scmi_vio_validate(struct virtio_device *vdev)
 {
+#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE
 	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
 		dev_err(&vdev->dev,
 			"device does not comply with spec version 1.x\n");
 		return -EINVAL;
 	}
-
+#endif
 	return 0;
 }
 
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

