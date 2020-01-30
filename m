Return-Path: virtio-dev-return-6696-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B6BBC986074
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Jan 2020 11:50:50 +0000 (UTC)
Date: Thu, 30 Jan 2020 06:50:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200130064451-mutt-send-email-mst@kernel.org>
References: <4fa78a91-751d-a7b5-fadf-b0ae8a5d5903@siemens.com>
 <CAJPjb1+Jnm-eHUQSFjhRBKAFNKqceHQMdRWtKEG+uncypGYKcA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJPjb1+Jnm-eHUQSFjhRBKAFNKqceHQMdRWtKEG+uncypGYKcA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] split-ring: Demand that a device must not
 change descriptor entries
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Rob Miller <rob.miller@broadcom.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Nov 11, 2019 at 12:17:51PM -0500, Rob Miller wrote:
> On Mon, Nov 11, 2019 at 12:13 PM Jan Kiszka <jan.kiszka@siemens.com> wrot=
e:
>=20
>     From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
>     So far the spec only indirectly says that a descriptor table entry is
>     not modified by a device when processing it. Make this explicit by
>     adding it as normative requirement. Existing drivers already depend o=
n
>     this.
>=20
>     See also https://lists.oasis-open.org/archives/virtio-dev/201910/
>     msg00057.html.
>=20
>     Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>     ---
>     =A0split-ring.tex | 2 +-
>     =A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
>     diff --git a/split-ring.tex b/split-ring.tex
>     index 123ac9f..bfef62d 100644
>     --- a/split-ring.tex
>     +++ b/split-ring.tex
>     @@ -217,7 +217,7 @@ \subsection{The Virtqueue Descriptor Table}\label
>     {sec:Basic Facilities of a Virt
>     =A0\devicenormative{\subsubsection}{The Virtqueue Descriptor Table}{B=
asic
>     Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor
>     Table}
>     =A0A device MUST NOT write to a device-readable buffer, and a device =
SHOULD
>     NOT
>     =A0read a device-writable buffer (it MAY do so for debugging or diagn=
ostic
>     -purposes).
>     +purposes). A device MUST NOT write to any descriptor table entry.
>=20
>     =A0\drivernormative{\subsubsection}{The Virtqueue Descriptor Table}{B=
asic
>     Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor
>     Table}
>     =A0Drivers MUST NOT add a descriptor chain longer than $2^{32}$ bytes=
 in
>     total;
>     --
>     2.16.4
>=20
>=20
> what is trying to be solved=A0here? There is a reason why this is allowed=
 as some
> vendors update the table when using RX_MERABLE_BUFFERs & F_IN_ORDER featu=
res
>=20
> Rob Miller
> rob.miller@broadcom.com
> (919)721-3339
>=20
>=20


Going back to this, I don't see how this can work with current Linux
guests at least when VIRTIO_F_IOMMU_PLATFORM is specified, since
the data is mapped to devices as follows:

                        dma_addr_t addr =3D vring_map_one_sg(vq, sg, DMA_TO=
_DEVICE);

and I guess we all agreed physical devices all set this flag?
Could you explain a bit more about how writing into descriptors
is useful with RX_MERABLE_BUFFERs?


--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

