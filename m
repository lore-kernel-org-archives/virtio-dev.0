Return-Path: <virtualization-bounces@lists.linux-foundation.org>
Date: Thu, 24 Jun 2021 13:22:55 -0600
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 13/16] dt-bindings: arm: Add virtio transport for SCMI
Message-ID: <20210624192255.GA1842097@robh.at.kernel.org>
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-14-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210611165937.701-14-cristian.marussi@arm.com>
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
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, f.fainelli@gmail.com, vincent.guittot@linaro.org, igor.skalkin@opensynergy.com, virtio-dev@lists.oasis-open.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Vasyl.Vavrychuk@opensynergy.com, Rob Herring <robh+dt@kernel.org>, peter.hilber@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com, james.quinlan@broadcom.com, Jonathan.Cameron@huawei.com, souvik.chakravarty@arm.com, etienne.carriere@linaro.org, linux-arm-kernel@lists.infradead.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 11 Jun 2021 17:59:34 +0100, Cristian Marussi wrote:
> From: Igor Skalkin <igor.skalkin@opensynergy.com>
> 
> Document the properties for arm,scmi-virtio compatible nodes.
> The backing virtio SCMI device is described in patch [1].
> 
> While doing that, make shmem property required only for pre-existing
> mailbox and smc transports, since virtio-scmi does not need it.
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202102/msg00018.html
> 
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
>   virtio-scmi dt bindings transport: it is not even referenced in SCMI
>   virtio DT node since they are enumerated by VirtIO subsystem and there
>   could be PCI based SCMI devices anyway.
> ---
>  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
