Return-Path: <virtio-dev-return-9344-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 980E4986666
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Mar 2022 04:05:40 +0000 (UTC)
MIME-Version: 1.0
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 3 Mar 2022 20:05:25 -0800
Message-ID: <CAAfnVBmDf1fA1ZAufPsPhyOWj0=ynGCVfzX_Cx=pgVmkXe8Tog@mail.gmail.com>
Subject: [virtio-dev] virtio-gpu dedicated heap
Content-Type: multipart/alternative; boundary="0000000000007b2c7405d95ca096"
To: iommu-request@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, peterz@infradead.org, m.szyprowski@samsung.com, hch@lst.de, "Michael S. Tsirkin" <mst@redhat.com>, robin.murphy@arm.com, will@kernel.org, Claire Chang <tientzu@google.com>, Tomasz Figa <tfiga@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--0000000000007b2c7405d95ca096
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

With the current virtio setup, all of guest memory is shared with host
devices.  There has been interest in changing this, to improve isolation of
guest memory and increase confidentiality.

The recently introduced restricted DMA mechanism makes excellent progress
in this area:

https://patchwork.kernel.org/project/xen-devel/cover/20210624155526.2775863-1-tientzu@chromium.org/


Devices without an IOMMU (traditional virtio devices for example) would
allocate from a specially designated region.  Swiotlb bouncing is done for
all DMA transfers.  This is controlled by the VIRTIO_F_ACCESS_PLATFORM
feature bit.

https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3064198

This mechanism works great for the devices it was designed for, such as
virtio-net.  However, when trying to adapt to it for other devices, there
are some limitations.

It would be great to have a dedicated heap for virtio-gpu rather than
allocating from guest memory.

We would like to use dma_alloc_noncontiguous on the restricted dma pool,
ideally with page-level granularity somehow.  Continuous buffers are
definitely going out of fashion.

There are two considerations when using it with the restricted DMA approach:

1) No bouncing (aka memcpy)

Expensive with graphics buffers, since guest user space would designate
shareable graphics buffers with the host.  We plan to use
DMA_ATTR_SKIP_CPU_SYNC when doing any DMA transactions with GPU buffers.

Bounce buffering will be utilized with virtio-cmds, like the other virtio
devices that use the restricted DMA mechanism.

2) IO_TLB_SEGSIZE is too small for graphics buffers

This issue was hit before here too:

https://www.spinics.net/lists/kernel/msg4154086.html

The suggestion was to use shared-dma-pool rather than restricted DMA.  But
we're not sure a single device can have restricted DMA (for
VIRTIO_F_ACCESS_PLATFORM) and shared-dma-pool (for larger buffers) at the
same time.  Does anyone know?

If not, it sounds like "splitting the allocation into
dma_max_mapping_size() chunks" for restricted-dma is also possible.  What
is the preferred method?

More generally, we would love more feedback on the proposed design or
consider alternatives!

--0000000000007b2c7405d95ca096
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail-gs" style=3D"margin:0px;padding:0px 0p=
x 20px;width:784px;font-family:Roboto,RobotoDraft,Helvetica,Arial,sans-seri=
f;font-size:medium"><div class=3D"gmail-"><div id=3D"gmail-:2op" class=3D"g=
mail-ii gmail-gt" style=3D"direction:ltr;margin:8px 0px 0px;padding:0px;fon=
t-size:0.875rem"><div id=3D"gmail-:2nx" class=3D"gmail-a3s gmail-aiL" style=
=3D"font-variant-numeric:normal;font-variant-east-asian:normal;font-stretch=
:normal;font-size:small;line-height:1.5;font-family:Arial,Helvetica,sans-se=
rif;overflow:hidden"><div dir=3D"ltr"><div>Hi everyone,</div><div><br></div=
><div>With the current virtio setup, all of guest memory is shared with hos=
t devices.=C2=A0 There=C2=A0has been=C2=A0interest in changing this, to imp=
rove isolation of guest memory and increase confidentiality.=C2=A0=C2=A0</d=
iv><div><br></div><div>The recently introduced restricted DMA mechanism mak=
es excellent progress in this area:</div><div><br></div><div><div><a href=
=3D"https://patchwork.kernel.org/project/xen-devel/cover/20210624155526.277=
5863-1-tientzu@chromium.org/" target=3D"_blank">https://patchwork.kernel.or=
g/project/xen-devel/cover/20210624155526.2775863-1-tientzu@chromium.org/</a=
>=C2=A0=C2=A0</div><div><br></div></div><div>Devices without an IOMMU (trad=
itional virtio devices for example) would allocate from a specially designa=
ted region.=C2=A0 Swiotlb bouncing is done for all DMA transfers.=C2=A0 Thi=
s is controlled by the VIRTIO_F_ACCESS_PLATFORM feature bit.</div><div><br>=
</div><div><a href=3D"https://chromium-review.googlesource.com/c/chromiumos=
/platform/crosvm/+/3064198" target=3D"_blank">https://chromium-review.googl=
esource.com/c/chromiumos/platform/crosvm/+/3064198</a><br></div><div><br></=
div><div>This mechanism works great for the devices it was designed for, su=
ch as virtio-net.=C2=A0 However, when trying to adapt to it for other devic=
es, there are some limitations.=C2=A0=C2=A0</div><div><br></div><div>It wou=
ld be great=C2=A0to have a dedicated heap for virtio-gpu rather than alloca=
ting from guest memory.=C2=A0=C2=A0</div><div><br></div><div><div>We would =
like to use dma_alloc_noncontiguous on the restricted dma pool, ideally wit=
h page-level granularity somehow.=C2=A0 Continuous buffers are definitely g=
oing out of fashion.</div></div><div><br></div><div>There are two considera=
tions when using it with the restricted DMA approach:</div><div><br></div><=
div>1) No bouncing (aka memcpy)</div><div><br></div><div>Expensive with gra=
phics buffers, since guest=C2=A0user space would designate shareable graphi=
cs buffers with the host.=C2=A0 We plan to use DMA_ATTR_SKIP_CPU_SYNC when =
doing any DMA transactions with GPU buffers.</div><div><br></div><div>Bounc=
e buffering will be utilized with virtio-cmds, like the other virtio device=
s that use the restricted DMA mechanism.</div><div><br></div><div>2) IO_TLB=
_SEGSIZE is too small for graphics buffers</div><div><br></div><div>This is=
sue was hit before here too:</div><div><br></div><div><a href=3D"https://ww=
w.spinics.net/lists/kernel/msg4154086.html" target=3D"_blank">https://www.s=
pinics.net/lists/kernel/msg4154086.html</a></div><div><br></div><div>The su=
ggestion was to use shared-dma-pool rather than restricted DMA.=C2=A0 But w=
e&#39;re not sure a single device can have restricted DMA (for VIRTIO_F_ACC=
ESS_PLATFORM) and shared-dma-pool (for larger buffers) at the same time.=C2=
=A0 Does anyone know?=C2=A0</div><div><br></div><div>If not, it sounds like=
 &quot;splitting the allocation into dma_max_mapping_size() chunks&quot; fo=
r restricted-dma is also possible.=C2=A0 What is the preferred method?</div=
><div><br></div><div>More generally, we would love more feedback on the pro=
posed design or consider alternatives!</div></div></div></div></div></div><=
/div>

--0000000000007b2c7405d95ca096--

