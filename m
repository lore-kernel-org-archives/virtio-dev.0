Return-Path: virtio-dev-return-6357-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 07224985E7C
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Nov 2019 17:27:50 +0000 (UTC)
Date: Wed, 20 Nov 2019 18:27:34 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20191120182734.7d6ec586.cohuck@redhat.com>
In-Reply-To: <20191120151903.175110-2-jean-philippe@linaro.org>
References: <20191120151903.175110-1-jean-philippe@linaro.org>
	<20191120151903.175110-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH RESEND v4 1/1] Add virtio-iommu device
 specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, joro@8bytes.org, tnowicki@marvell.com, eric.auger@redhat.com, kevin.tian@intel.com, lorenzo.pieralisi@arm.com, mst@redhat.com, bauerman@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 20 Nov 2019 16:19:03 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> The IOMMU device allows a guest to manage DMA mappings for physical,
> emulated and paravirtualized endpoints. Add device description for the
> virtio-iommu device and driver. Introduce PROBE, ATTACH, DETACH, MAP and
> UNMAP requests, as well as translation error reporting.
>=20
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/37
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  conformance.tex  |  40 ++-
>  content.tex      |   1 +
>  virtio-iommu.tex | 816 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 855 insertions(+), 2 deletions(-)
>  create mode 100644 virtio-iommu.tex

Sorry about being late to the party, but I just started looking at this
when the voting went up :/

(...)

> diff --git a/virtio-iommu.tex b/virtio-iommu.tex
> new file mode 100644
> index 0000000..28c562b
> --- /dev/null
> +++ b/virtio-iommu.tex

(...)

> +\subsection{Device configuration layout}\label{sec:Device Types / IOMMU =
Device / Device configuration layout}
> +
> +The \field{page_size_mask} field is always present. Availability of the
> +others all depend on feature bits described in
> +\ref{sec:Device Types / IOMMU Device / Feature bits}.
> +
> +\begin{lstlisting}
> +struct virtio_iommu_config {
> +  le64 page_size_mask;
> +  struct virtio_iommu_range_64 {
> +    le64 start;
> +    le64 end;
> +  } input_range;
> +  struct virtio_iommu_range_32 {
> +    le32 start;
> +    le32 end;
> +  } domain_range;
> +  le32 probe_size;
> +};
> +\end{lstlisting}
> +
> +\drivernormative{\subsubsection}{Device configuration layout}{Device Typ=
es / IOMMU Device / Device configuration layout}
> +
> +The driver MUST NOT write to device configuration fields.
> +
> +\devicenormative{\subsubsection}{Device configuration layout}{Device Typ=
es / IOMMU Device / Device configuration layout}
> +
> +The device SHOULD set \field{padding} to zero.

I don't see any field named 'padding' -- is that a leftover from an
earlier version?

If it is, we can probably remove it as a trivial change on top after
this change went in.

> +
> +The device MUST set at least one bit in \field{page_size_mask}, describi=
ng
> +the page granularity. The device MAY set more than one bit in
> +\field{page_size_mask}.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

