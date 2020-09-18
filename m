Return-Path: virtio-dev-return-7795-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 929C698602C
	for <virtio-dev@lists.oasis-open.org>; Fri, 18 Sep 2020 16:56:39 +0000 (UTC)
From: Peter Hilber <peter.hilber@opensynergy.com>
Date: Fri, 18 Sep 2020 18:55:58 +0200
Message-ID: <20200918165558.257086-1-peter.hilber@opensynergy.com>
In-Reply-To: <20200918162311.254564-1-peter.hilber@opensynergy.com>
References: <20200918162311.254564-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC PATCH 6/7] dt-bindings: arm: Add virtio transport for SCMI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, souvik.chakravarty@arm.com, alex.bennee@linaro.org, jean-philippe@linaro.org, igor.skalkin@opensynergy.com, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Peter Hilber <peter.hilber@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Igor Skalkin <igor.skalkin@opensynergy.com>

Document the properties for arm,scmi-virtio compatible nodes. The
backing virtio SCMI device is described in patch [1].

[1] https://lists.oasis-open.org/archives/virtio-comment/202005/msg00096.ht=
ml

Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
---
 .../devicetree/bindings/arm/arm,scmi.txt      | 38 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documenta=
tion/devicetree/bindings/arm/arm,scmi.txt
index 55deb68230eb..844ff3c40a49 100644
--- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
@@ -13,6 +13,9 @@ the device tree.
 Required properties:
=20
 The scmi node with the following properties shall be under the /firmware/ =
node.
+Some properties are specific to a transport type.
+
+shmem-based transports (mailbox, smc/hvc):
=20
 - compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transport=
s
 - mboxes: List of phandle and mailbox channel specifiers. It should contai=
n
@@ -21,6 +24,17 @@ The scmi node with the following properties shall be und=
er the /firmware/ node.
 =09  supported.
 - shmem : List of phandle pointing to the shared memory(SHM) area as per
 =09  generic mailbox client binding.
+
+Virtio transport:
+
+- compatible : shall be "arm,scmi-virtio".
+- virtio_transport : phandle of the virtio device. This device must suppor=
t one
+                     virtqueue for transmitting commands ("tx", cmdq), and=
,
+=09=09     optionally, one more virtqueue for receiving notifications
+=09=09     and delayed responses ("rx", eventq).
+
+Additional required properties:
+
 - #address-cells : should be '1' if the device has sub-nodes, maps to
 =09  protocol identifier for a given sub-node.
 - #size-cells : should be '0' as 'reg' property doesn't have any size
@@ -42,7 +56,8 @@ Each protocol supported shall have a sub-node with corres=
ponding compatible
 as described in the following sections. If the platform supports dedicated
 communication channel for a particular protocol, the 3 properties namely:
 mboxes, mbox-names and shmem shall be present in the sub-node correspondin=
g
-to that protocol.
+to that protocol. The virtio transport does not support dedicated communic=
ation
+channels.
=20
 Clock/Performance bindings for the clocks/OPPs based on SCMI Message Proto=
col
 ------------------------------------------------------------
@@ -106,7 +121,8 @@ Required sub-node properties:
 [4] Documentation/devicetree/bindings/sram/sram.yaml
 [5] Documentation/devicetree/bindings/reset/reset.txt
=20
-Example:
+Example (mailbox transport):
+----------------------------
=20
 sram@50000000 {
 =09compatible =3D "mmio-sram";
@@ -195,3 +211,21 @@ thermal-zones {
 =09=09...
 =09};
 };
+
+Example (virtio transport):
+---------------------------
+
+virtio_mmio_scmi: virtio_mmio@4b001000 {
+=09compatible =3D "virtio,mmio";
+=09...
+};
+
+firmware {
+=09...
+=09scmi {
+=09=09compatible =3D "arm,scmi-virtio";
+=09=09virtio_transport =3D <&virtio_mmio_scmi>;
+=09=09...
+
+The rest is similar to the mailbox transport example, when omitting the
+mailbox/shmem-specific properties.
--=20
2.25.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

