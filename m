Return-Path: <virtualization-bounces@lists.linux-foundation.org>
Date: Mon, 17 May 2021 16:39:18 -0500
From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH v3 10/12] dt-bindings: arm: Add virtio transport for
 SCMI
Message-ID: <20210517213918.GA3244026@robh.at.kernel.org>
References: <20210511002040.802226-1-peter.hilber@opensynergy.com>
 <20210511002040.802226-11-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210511002040.802226-11-peter.hilber@opensynergy.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Peter Hilber <peter.hilber@opensynergy.com>
Cc: devicetree@vger.kernel.org, mikhail.golubev@opensynergy.com, Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>, souvik.chakravarty@arm.com, Igor Skalkin <igor.skalkin@opensynergy.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Cristian Marussi <cristian.marussi@arm.com>, sudeep.holla@arm.com, jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org, Andriy Tryshnivskyy <Andriy.Tryshnivskyy@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 11, 2021 at 02:20:38AM +0200, Peter Hilber wrote:
> From: Igor Skalkin <igor.skalkin@opensynergy.com>
> 
> Document the properties for arm,scmi-virtio compatible nodes. The
> backing virtio SCMI device is described in patch [1].
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202005/msg00096.html
> 
> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
> [ Peter: Adapted patch for submission to upstream. ]
> Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> ---
>  .../devicetree/bindings/arm/arm,scmi.txt      | 35 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)

Seems like it may not be perfectly clear what properties apply or not 
for the different transports. Can you convert this to DT schema first.

> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> index 667d58e0a659..5d209ba666f6 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> @@ -13,6 +13,9 @@ the device tree.
>  Required properties:
>  
>  The scmi node with the following properties shall be under the /firmware/ node.
> +Some properties are specific to a transport type.
> +
> +shmem-based transports (mailbox, smc/hvc):
>  
>  - compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transports
>  - mboxes: List of phandle and mailbox channel specifiers. It should contain
> @@ -21,6 +24,15 @@ The scmi node with the following properties shall be under the /firmware/ node.
>  	  supported.
>  - shmem : List of phandle pointing to the shared memory(SHM) area as per
>  	  generic mailbox client binding.
> +
> +Virtio transport:
> +
> +- compatible : shall be "arm,scmi-virtio".
> +
> +The virtio transport only supports a single device.
> +
> +Additional required properties:
> +
>  - #address-cells : should be '1' if the device has sub-nodes, maps to
>  	  protocol identifier for a given sub-node.
>  - #size-cells : should be '0' as 'reg' property doesn't have any size
> @@ -50,7 +62,8 @@ Each protocol supported shall have a sub-node with corresponding compatible
>  as described in the following sections. If the platform supports dedicated
>  communication channel for a particular protocol, the 3 properties namely:
>  mboxes, mbox-names and shmem shall be present in the sub-node corresponding
> -to that protocol.
> +to that protocol. The virtio transport does not support dedicated communication
> +channels.
>  
>  Clock/Performance bindings for the clocks/OPPs based on SCMI Message Protocol
>  ------------------------------------------------------------
> @@ -129,7 +142,8 @@ Required sub-node properties:
>  [5] Documentation/devicetree/bindings/reset/reset.txt
>  [6] Documentation/devicetree/bindings/regulator/regulator.yaml
>  
> -Example:
> +Example (mailbox transport):
> +----------------------------
>  
>  sram@50000000 {
>  	compatible = "mmio-sram";
> @@ -237,3 +251,20 @@ thermal-zones {
>  		...
>  	};
>  };
> +
> +Example (virtio transport):
> +---------------------------
> +
> +virtio_mmio@4b001000 {
> +	compatible = "virtio,mmio";
> +	...
> +};
> +
> +firmware {
> +	...
> +	scmi {
> +		compatible = "arm,scmi-virtio";
> +		...
> +
> +The rest is similar to the mailbox transport example, when omitting the
> +mailbox/shmem-specific properties.
> -- 
> 2.25.1
> 
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
