Return-Path: <virtio-dev-return-8917-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DFFBF986434
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 Nov 2021 13:02:09 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20211022121219.1133867-1-jean-philippe@linaro.org>
References: <20211022121219.1133867-1-jean-philippe@linaro.org>
Date: Wed, 03 Nov 2021 14:01:43 +0100
Message-ID: <87cznhbdfs.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v3] virtio-iommu: Rework the bypass feature
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, virtio-dev@lists.oasis-open.org, eric.auger@redhat.com, kevin.tian@intel.com
Cc: sebastien.boeuf@intel.com, mst@redhat.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 22 2021, Jean-Philippe Brucker <jean-philippe@linaro.org> wrote=
:

> The VIRTIO_IOMMU_F_BYPASS feature is awkward to use and incomplete.
> Although it is implemented by QEMU, it is not supported by any driver as
> far as I know. Replace it with a new VIRTIO_IOMMU_F_BYPASS_CONFIG
> feature.
>
> Two features are missing from virtio-iommu:
>
> * The ability for an hypervisor to start the device in bypass mode. The
>   wording for VIRTIO_IOMMU_F_BYPASS is not clear enough to allow it at
>   the moment, because it only specifies the behavior after feature
>   negotiation.
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
>   fields is initialized to 0 or 1. It is sticky and isn't affected by
>   device reset.
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
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/119
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>
> The virtio-iommu spec with colored diff is available at
> https://jpbrucker.net/virtio-iommu/spec-bypass/virtio-iommu-f-bypass-conf=
ig-v3-diff.pdf
>
> v1: https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg07817=
.html
> v2: https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg07898=
.html
> v3:
> * Normative statement about device reset vs. system reset - the bypass
>   bit is sticky across device reset to avoid the vulnerability described
>   above, but restored on system reset (a term also used by the virtio
>   memory device).
> * Explain that the field bypass is in effect as long as the new feature
>   is offered, even when not accepted by the driver
> * Another clarification about the state of an endpoint after detach.
> ---
>  conformance.tex  |   1 -
>  virtio-iommu.tex | 111 ++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 90 insertions(+), 22 deletions(-)

Now looks good to me.

Michael, do you think we should start voting?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

