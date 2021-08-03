Return-Path: <virtio-dev-return-8476-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A540A986515
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Aug 2021 13:11:35 +0000 (UTC)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Tue,  3 Aug 2021 14:10:16 +0100
Message-Id: <20210803131024.40280-8-cristian.marussi@arm.com>
In-Reply-To: <20210803131024.40280-1-cristian.marussi@arm.com>
References: <20210803131024.40280-1-cristian.marussi@arm.com>
Subject: [virtio-dev] [PATCH v7 07/15] firmware: arm_scmi: Make polling mode optional
Content-Type: text/plain; charset="US-ASCII"
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, cristian.marussi@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

Add a check for the presence of .poll_done transport operation so that
transports that do not need to support polling mode have no need to provide
a dummy .poll_done callback either and polling mode can be disabled in the
SCMI core for that tranport.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- s/EINVAL/-EINVAL/
- refactored to bail out early when polling mode not supported
---
 drivers/firmware/arm_scmi/driver.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 6c77fcc1bcb7..5ff0bcbb4db4 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -751,6 +751,12 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	struct device *dev = info->dev;
 	struct scmi_chan_info *cinfo;
 
+	if (xfer->hdr.poll_completion && !info->desc->ops->poll_done) {
+		dev_warn_once(dev,
+			      "Polling mode is not supported by transport.\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * Initialise protocol id now from protocol handle to avoid it being
 	 * overridden by mistake (or malice) by the protocol code mangling with
@@ -787,7 +793,6 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 		ktime_t stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLL_TO_NS);
 
 		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
-
 		if (ktime_before(ktime_get(), stop)) {
 			unsigned long flags;
 
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

