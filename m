Return-Path: virtio-dev-return-4847-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 04FF2985D45
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Sep 2018 08:13:05 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 13 Sep 2018 10:12:56 +0200
Message-Id: <20180913081259.27457-2-kraxel@redhat.com>
In-Reply-To: <20180913081259.27457-1-kraxel@redhat.com>
References: <20180913081259.27457-1-kraxel@redhat.com>
Subject: [virtio-dev] [PATCH 1/3] drm: virtual connectors can have edid too
To: virtio-dev@lists.oasis-open.org, dri-devel@lists.freedesktop.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Gustavo Padovan <gustavo@padovan.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/drm_connector.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 6011d769d5..95cbbf7ee5 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -254,8 +254,7 @@ int drm_connector_init(struct drm_device *dev,
 	config->num_connector++;
 	spin_unlock_irq(&config->connector_list_lock);
 
-	if (connector_type != DRM_MODE_CONNECTOR_VIRTUAL &&
-	    connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
+	if (connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
 		drm_object_attach_property(&connector->base,
 					      config->edid_property,
 					      0);
-- 
2.9.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

