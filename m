Return-Path: <virtio-dev-return-8482-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EF6259864F9
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Aug 2021 13:12:00 +0000 (UTC)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Tue,  3 Aug 2021 14:10:22 +0100
Message-Id: <20210803131024.40280-14-cristian.marussi@arm.com>
In-Reply-To: <20210803131024.40280-1-cristian.marussi@arm.com>
References: <20210803131024.40280-1-cristian.marussi@arm.com>
Subject: [virtio-dev] [PATCH v7 13/15] dt-bindings: arm: Add virtio transport for SCMI
Content-Type: text/plain; charset="US-ASCII"
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, cristian.marussi@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Igor Skalkin <igor.skalkin@opensynergy.com>

Document the properties for arm,scmi-virtio compatible nodes.
The backing virtio SCMI device is described in patch [1].

While doing that, make shmem property required only for pre-existing
mailbox and smc transports, since virtio-scmi does not need it.

[1] https://lists.oasis-open.org/archives/virtio-comment/202102/msg00018.html

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
[ Peter: Adapted patch for submission to upstream. ]
Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
[ Cristian: converted to yaml format, moved shmen required property. ]
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> V4
- convertd to YAML
- make shmem required only for pre-existing mailbox and smc transport
- updated VirtIO specification patch message reference
- dropped virtio-mmio SCMI device example since really not pertinent to
  virtio-scmi dt bindings transport: it is not even referenced in SCMI
  virtio DT node since they are enumerated by VirtIO subsystem and there
  could be PCI based SCMI devices anyway.
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index cebf6ffe70d5..5c4c6782e052 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -34,6 +34,10 @@ properties:
       - description: SCMI compliant firmware with ARM SMC/HVC transport
         items:
           - const: arm,scmi-smc
+      - description: SCMI compliant firmware with SCMI Virtio transport.
+                     The virtio transport only supports a single device.
+        items:
+          - const: arm,scmi-virtio
 
   interrupts:
     description:
@@ -172,6 +176,7 @@ patternProperties:
       Each sub-node represents a protocol supported. If the platform
       supports a dedicated communication channel for a particular protocol,
       then the corresponding transport properties must be present.
+      The virtio transport does not support a dedicated communication channel.
 
     properties:
       reg:
@@ -195,7 +200,6 @@ patternProperties:
 
 required:
   - compatible
-  - shmem
 
 if:
   properties:
@@ -209,6 +213,7 @@ then:
 
   required:
     - mboxes
+    - shmem
 
 else:
   if:
@@ -219,6 +224,7 @@ else:
   then:
     required:
       - arm,smc-id
+      - shmem
 
 examples:
   - |
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

