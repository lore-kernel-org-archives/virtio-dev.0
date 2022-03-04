Return-Path: <virtio-dev-return-9345-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 85C9A986666
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Mar 2022 04:56:57 +0000 (UTC)
Date: Thu, 3 Mar 2022 23:56:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220303235527-mutt-send-email-mst@kernel.org>
References: <CAAfnVBmDf1fA1ZAufPsPhyOWj0=ynGCVfzX_Cx=pgVmkXe8Tog@mail.gmail.com>
 <CAAfnVBmCUHKRUVA=UouoSUH-eTyTTpNReU6i8TSD94iyYWyQzg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAfnVBmCUHKRUVA=UouoSUH-eTyTTpNReU6i8TSD94iyYWyQzg@mail.gmail.com>
Subject: [virtio-dev] Re: virtio-gpu dedicated heap
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Gurchetan Singh <gurchetansingh@google.com>
Cc: virtio-dev@lists.oasis-open.org, peterz@infradead.org, m.szyprowski@samsung.com, hch@lst.de, robin.murphy@arm.com, will@kernel.org, Claire Chang <tientzu@google.com>, Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

$ ./scripts/get_maintainer.pl -f ./drivers/gpu/drm/virtio/

David Airlie <airlied@linux.ie> (maintainer:VIRTIO GPU DRIVER)
Gerd Hoffmann <kraxel@redhat.com> (maintainer:VIRTIO GPU DRIVER)
Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS)
dri-devel@lists.freedesktop.org (open list:VIRTIO GPU DRIVER)
virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER)
linux-kernel@vger.kernel.org (open list)

You might want to CC these people.

On Thu, Mar 03, 2022 at 08:07:03PM -0800, Gurchetan Singh wrote:
> +iommu@lists.linux-foundation.org=A0not iommu-request
>=20
> On Thu, Mar 3, 2022 at 8:05 PM Gurchetan Singh <gurchetansingh@chromium.o=
rg>
> wrote:
>=20
>     Hi everyone,
>=20
>     With the current virtio setup, all of guest memory is shared with hos=
t
>     devices.=A0 There=A0has been=A0interest in changing this, to improve =
isolation of
>     guest memory and increase confidentiality.=A0=A0
>=20
>     The recently introduced restricted DMA mechanism makes excellent prog=
ress
>     in this area:
>=20
>     https://patchwork.kernel.org/project/xen-devel/cover/
>     20210624155526.2775863-1-tientzu@chromium.org/=A0=A0
>=20
>     Devices without an IOMMU (traditional virtio devices for example) wou=
ld
>     allocate from a specially designated region.=A0 Swiotlb bouncing is d=
one for
>     all DMA transfers.=A0 This is controlled by the VIRTIO_F_ACCESS_PLATF=
ORM
>     feature bit.
>=20
>     https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm=
/+/
>     3064198
>=20
>     This mechanism works great for the devices it was designed for, such =
as
>     virtio-net.=A0 However, when trying to adapt to it for other devices,=
 there
>     are some limitations.=A0=A0
>=20
>     It would be great=A0to have a dedicated heap for virtio-gpu rather th=
an
>     allocating from guest memory.=A0=A0
>=20
>     We would like to use dma_alloc_noncontiguous on the restricted dma po=
ol,
>     ideally with page-level granularity somehow.=A0 Continuous buffers ar=
e
>     definitely going out of fashion.
>=20
>     There are two considerations when using it with the restricted DMA
>     approach:
>=20
>     1) No bouncing (aka memcpy)
>=20
>     Expensive with graphics buffers, since guest=A0user space would desig=
nate
>     shareable graphics buffers with the host.=A0 We plan to use
>     DMA_ATTR_SKIP_CPU_SYNC when doing any DMA transactions with GPU buffe=
rs.
>=20
>     Bounce buffering will be utilized with virtio-cmds, like the other vi=
rtio
>     devices that use the restricted DMA mechanism.
>=20
>     2) IO_TLB_SEGSIZE is too small for graphics buffers
>=20
>     This issue was hit before here too:
>=20
>     https://www.spinics.net/lists/kernel/msg4154086.html
>=20
>     The suggestion was to use shared-dma-pool rather than restricted DMA.=
=A0 But
>     we're not sure a single device can have restricted DMA (for
>     VIRTIO_F_ACCESS_PLATFORM) and shared-dma-pool (for larger buffers) at=
 the
>     same time.=A0 Does anyone know?=A0
>=20
>     If not, it sounds like "splitting the allocation into dma_max_mapping=
_size
>     () chunks" for restricted-dma is also possible.=A0 What is the prefer=
red
>     method?
>=20
>     More generally, we would love more feedback on the proposed design or
>     consider alternatives!
>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

