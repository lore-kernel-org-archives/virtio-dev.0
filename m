Return-Path: <virtio-dev-return-8784-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6BDB39863D2
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Oct 2021 16:58:15 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210930163503.51200-1-jean-philippe@linaro.org>
References: <20210930163503.51200-1-jean-philippe@linaro.org>
Date: Tue, 05 Oct 2021 18:57:50 +0200
Message-ID: <87a6jn1ka9.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH] virtio-iommu: Rework the bypass feature
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, virtio-dev@lists.oasis-open.org, eric.auger@redhat.com
Cc: sebastien.boeuf@intel.com, kevin.tian@intel.com, mst@redhat.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 30 2021, Jean-Philippe Brucker <jean-philippe@linaro.org> wrote=
:

> The VIRTIO_IOMMU_F_BYPASS feature is awkward to use and incomplete.
> Although it is implemented by QEMU, it is not supported by any driver as
> far as I know. Replace it with a new VIRTIO_IOMMU_F_BYPASS_CONFIG
> feature. The old feature bit is deprecated and will be recycled once
> versions of QEMU that implement it are not distributed anymore.

I'm not sure we can safely reuse old feature bits. I don't think we're
running out of free feature bits, so just keep this as reserved and
deprecated?

>
> Two features are missing from virtio-iommu:
>
> * The ability for an hypervisor to start the device in bypass mode. The
>   wording for VIRTIO_IOMMU_F_BYPASS is not clear enough to allow it at
>   the moment.
>
> * The ability for a guest to set individual endpoints in bypass mode
>   when bypass is globally disabled. An OS should have the ability to
>   allow only endpoints it trusts to bypass the IOMMU, while keeping DMA
>   disabled for endpoints it isn't even aware of. At the moment this can
>   only be emulated by creating identity mappings.
>
> The VIRTIO_IOMMU_F_BYPASS_CONFIG feature adds a 'bypass' config field
> that allows to enable and disable bypass globally. It also adds a new
> flag for the ATTACH request.
>
> * The hypervisor can start the VM with bypass enabled or, if it knows
>   that the software stack supports it, disabled. The 'bypass' config
>   fields resets to 0 or 1.
>
> * Generally the firmware won't have an IOMMU driver and will need to be
>   started in bypass mode, so the bootloader and kernel can be loaded
>   from storage endpoint.
>
>   For more security, the firmware could implement a minimal virtio-iommu
>   driver that reuses existing virtio support and only touches the config
>   space. It could enable PCI bus mastering in bridges only for the
>   endpoints that need it, enable global IOMMU bypass by flipping a bit,
>   then tear everything down before handing control over to the OS. This
>   prevents vulnerability windows where a malicious endpoint reprograms
>   the IOMMU while the OS is configuring it [1].
>
>   The isolation provided by vIOMMUs has mainly been used for securely
>   assigning endpoints to untrusted applications so far, while kernel DMA
>   bypasses the IOMMU. But we can expect boot security to become as
>   important in virtualization as it presently is on bare-metal systems,
>   where some devices are untrusted and must never be able to access
>   memory that wasn't assigned to them.
>
> * The OS can enable and disable bypass globally. It can then enable
>   bypass for individual endpoints by attaching them to bypass domains,
>   using the new VIRTIO_IOMMU_ATTACH_F_BYPASS flag. It can disable bypass
>   by attaching them to normal domains.
>
> [1] IOMMU protection against I/O attacks: a vulnerability and a proof of =
concept
>     Morgan, B., Alata, =C3=89., Nicomette, V. et al.
>     https://link.springer.com/article/10.1186/s13173-017-0066-7

I'm not really familiar with this topic, so I'll just point out some
spec things.

>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> The virtio-iommu spec with colored diff is available at
> https://jpbrucker.net/virtio-iommu/spec-bypass/virtio-iommu-f-bypass-conf=
ig-v1-diff.pdf
>
> Apologies for the poorly thought out VIRTIO_IOMMU_F_BYPASS. I didn't
> spend enough time on it and ignored valuable suggestions.
> ---
>  virtio-iommu.tex | 69 +++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 53 insertions(+), 16 deletions(-)
>
> diff --git a/virtio-iommu.tex b/virtio-iommu.tex
> index efa735b..a2c90ea 100644
> --- a/virtio-iommu.tex
> +++ b/virtio-iommu.tex
> @@ -59,14 +59,19 @@ \subsection{Feature bits}\label{sec:Device Types / IO=
MMU Device / Feature bits}
>    VIRTIO_IOMMU_F_MAP_UNMAP is supported.}
> =20
>  \item[VIRTIO_IOMMU_F_BYPASS (3)]
> -  When not attached to a domain, endpoints downstream of the IOMMU
> -  can access the guest-physical address space.
> +  This feature is deprecated.

"and must not be negotiated." ?

Not sure if we should add normative statements for that.

> =20
>  \item[VIRTIO_IOMMU_F_PROBE (4)]
>    The PROBE request is available.
> =20
>  \item[VIRTIO_IOMMU_F_MMIO (5)]
>    The VIRTIO_IOMMU_MAP_F_MMIO flag is available.
> +
> +\item[VIRTIO_IOMMU_F_BYPASS_CONFIG (6)]
> +  The global bypass state is described in \field{bypass} of
> +  struct virtio_iommu_config. The domain bypass state is
> +  described by VIRTIO_IOMMU_ATTACH_F_BYPASS.
> +
>  \end{description}
> =20
>  \drivernormative{\subsubsection}{Feature bits}{Device Types / IOMMU Devi=
ce / Feature bits}
> @@ -97,12 +102,19 @@ \subsection{Device configuration layout}\label{sec:D=
evice Types / IOMMU Device /
>      le32 end;
>    } domain_range;
>    le32 probe_size;
> +  u8 bypass;
> +  u8 reserved[3];
>  };
>  \end{lstlisting}
> =20
>  \drivernormative{\subsubsection}{Device configuration layout}{Device Typ=
es / IOMMU Device / Device configuration layout}
> =20
> -The driver MUST NOT write to device configuration fields.
> +When the VIRTIO_IOMMU_F_BYPASS_CONFIG feature is negotiated, the
> +driver MAY write to \field{bypass}. The driver MUST NOT write to
> +any other device configuration field.
> +
> +If field \field{bypass} contains a value different than 0 or 1,
> +the driver SHOULD treat it as 0.

"The driver MUST NOT write any value different than 0 or 1 to
\field{bypass}." ?

> =20
>  \devicenormative{\subsubsection}{Device configuration layout}{Device Typ=
es / IOMMU Device / Device configuration layout}
> =20
> @@ -110,16 +122,24 @@ \subsection{Device configuration layout}\label{sec:=
Device Types / IOMMU Device /
>  the page granularity. The device MAY set more than one bit in
>  \field{page_size_mask}.
> =20
> +If the driver writes a value different than 0 or 1 in
> +\field{bypass}, the device SHOULD treat it as 0.

"The device MUST NOT present any value different than 0 or 1 in
\field{bypass}." ?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

