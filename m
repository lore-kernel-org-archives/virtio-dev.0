Return-Path: virtio-dev-return-6392-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0D705985CAF
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Nov 2019 07:30:47 +0000 (UTC)
References: <20191120151903.175110-1-jean-philippe@linaro.org>
 <20191120151903.175110-2-jean-philippe@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <19a7ef47-29b8-f1ff-822a-afc974b2a314@siemens.com>
Date: Mon, 25 Nov 2019 08:30:29 +0100
MIME-Version: 1.0
In-Reply-To: <20191120151903.175110-2-jean-philippe@linaro.org>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH RESEND v4 1/1] Add virtio-iommu device
 specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, virtio-dev@lists.oasis-open.org
Cc: joro@8bytes.org, tnowicki@marvell.com, eric.auger@redhat.com, kevin.tian@intel.com, lorenzo.pieralisi@arm.com, mst@redhat.com, bauerman@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 20.11.19 16:19, Jean-Philippe Brucker wrote:
> The IOMMU device allows a guest to manage DMA mappings for physical,
> emulated and paravirtualized endpoints. Add device description for the
> virtio-iommu device and driver. Introduce PROBE, ATTACH, DETACH, MAP and
> UNMAP requests, as well as translation error reporting.
>=20
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/37
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

...

> +
> +\subsubsection{Fault reporting}\label{sev:Device Types / IOMMU Device / =
Device operations / Fault reporting}
> +
> +The device can report translation faults and other significant
> +asynchronous events on the event virtqueue. The driver initially populat=
es
> +the queue with device-writeable buffers. When the device needs to report
> +an event, it fills a buffer and notifies the driver. The driver consumes
> +the report and adds a new buffer to the virtqueue.
> +
> +If no buffer is available, the device can either wait for one to be
> +consumed, or drop the event.
> +
> +\begin{lstlisting}
> +struct virtio_iommu_fault {
> +  u8    reason;
> +  u8    reserved[3];
> +  le32  flags;
> +  le32  endpoint;
> +  le32  reserved1;
> +  le64  address;
> +};
> +
> +#define VIRTIO_IOMMU_FAULT_F_READ     (1 << 0)
> +#define VIRTIO_IOMMU_FAULT_F_WRITE    (1 << 1)
> +#define VIRTIO_IOMMU_FAULT_F_ADDRESS  (1 << 8)
> +\end{lstlisting}
> +
> +\begin{description}
> +  \item[\field{reason}] The reason for this report. It may have the
> +    following values:
> +    \begin{description}
> +      \item[VIRTIO_IOMMU_FAULT_R_UNKNOWN (0)] An internal error happened=
, or
> +        an error that cannot be described with the following reasons.
> +      \item[VIRTIO_IOMMU_FAULT_R_DOMAIN (1)] The endpoint attempted to
> +        access \field{address} without being attached to a domain.
> +      \item[VIRTIO_IOMMU_FAULT_R_MAPPING (2)] The endpoint attempted to
> +        access \field{address}, which wasn't mapped in the domain or
> +        didn't have the correct protection flags.
> +    \end{description}
> +  \item[\field{flags}] Information about the fault context.
> +  \item[\field{endpoint}] The endpoint causing the fault.
> +  \item[\field{reserved} and \field{reserved1}] Should be zero.
> +  \item[\field{address}] If VIRTIO_IOMMU_FAULT_F_ADDRESS is set, the
> +    address causing the fault.
> +\end{description}
> +
> +When the fault is reported by a physical IOMMU, the fault reasons may no=
t
> +match exactly the reason of the original fault report. The device does i=
ts
> +best to find the closest match.
> +
> +If the device encounters an internal error that wasn't caused by a
> +specific endpoint, it is unlikely that the driver would be able to do
> +anything else than print the fault and stop using the device, so reporti=
ng
> +the fault on the event queue isn't useful. In that case, we recommend
> +using the DEVICE_NEEDS_RESET status bit.

What's the impact of a fault on the device(s) under the IOMMU regime?=20
Can they recover? Or will they get DEVICE_NEEDS_RESET as well? With PCI=20
device behind real IOMMUs, it's normal that they need a reset after=20
having caused a fault. I'm not sure if this is described in the related=20
specs for them, but it should be clarify for the virtual IOMMU. But this=20
can be done on top, IMHO.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

