Return-Path: <virtio-dev-return-8216-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 23F6C9862C0
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Jul 2021 08:43:07 +0000 (UTC)
From: Peter Hilber <peter.hilber@opensynergy.com>
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-14-cristian.marussi@arm.com>
Message-ID: <e7fbfdfb-5368-f861-98c4-058d835779fc@opensynergy.com>
Date: Thu, 1 Jul 2021 10:43:02 +0200
In-Reply-To: <20210611165937.701-14-cristian.marussi@arm.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v4 13/16] dt-bindings: arm: Add virtio transport for SCMI
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Cristian Marussi <cristian.marussi@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 11.06.21 18:59, Cristian Marussi wrote:
> From: Igor Skalkin <igor.skalkin@opensynergy.com>
>=20
> Document the properties for arm,scmi-virtio compatible nodes.
> The backing virtio SCMI device is described in patch [1].
>=20
> While doing that, make shmem property required only for pre-existing
> mailbox and smc transports, since virtio-scmi does not need it.
>=20
> [1] https://lists.oasis-open.org/archives/virtio-comment/202102/msg00018.=
html
>=20
> CC: Rob Herring <robh+dt@kernel.org>
> CC: devicetree@vger.kernel.org
> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
> [ Peter: Adapted patch for submission to upstream. ]
> Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> [ Cristian: converted to yaml format, moved shmen required property. ]
> Co-developed-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v3 --> V4
> - convertd to YAML
> - make shmem required only for pre-existing mailbox and smc transport
> - updated VirtIO specification patch message reference
> - dropped virtio-mmio SCMI device example since really not pertinent to
>    virtio-scmi dt bindings transport: it is not even referenced in SCMI
>    virtio DT node since they are enumerated by VirtIO subsystem and there
>    could be PCI based SCMI devices anyway.
> ---
>   Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/D=
ocumentation/devicetree/bindings/firmware/arm,scmi.yaml
> index cebf6ffe70d5..5c4c6782e052 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -34,6 +34,10 @@ properties:
>         - description: SCMI compliant firmware with ARM SMC/HVC transport
>           items:
>             - const: arm,scmi-smc
> +      - description: SCMI compliant firmware with SCMI Virtio transport.
> +                     The virtio transport only supports a single device.
> +        items:
> +          - const: arm,scmi-virtio
>  =20
>     interrupts:
>       description:
> @@ -172,6 +176,7 @@ patternProperties:
>         Each sub-node represents a protocol supported. If the platform
>         supports a dedicated communication channel for a particular proto=
col,
>         then the corresponding transport properties must be present.
> +      The virtio transport does not support a dedicated communication ch=
annel.
>  =20
>       properties:
>         reg:
> @@ -195,7 +200,6 @@ patternProperties:
>  =20
>   required:
>     - compatible
> -  - shmem
>  =20
>   if:
>     properties:
> @@ -209,6 +213,7 @@ then:
>  =20
>     required:
>       - mboxes
> +    - shmem
>  =20
>   else:
>     if:
> @@ -219,6 +224,7 @@ else:
>     then:
>       required:
>         - arm,smc-id
> +      - shmem
>  =20
>   examples:
>     - |
>=20

Maybe a minimal example for arm,scmi-virtio could be added, such as below:

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml=20
b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 5c4c6782e052..576faf970c1b 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -344,4 +344,19 @@ examples:
          };
      };

+  - |
+    firmware {
+        scmi {
+            compatible =3D "arm,scmi-virtio";
+
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            scmi_devpd2: protocol@11 {
+                reg =3D <0x11>;
+                #power-domain-cells =3D <1>;
+            };
+        };
+    };
+
  ...

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

