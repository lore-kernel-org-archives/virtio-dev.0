Return-Path: virtio-dev-return-3660-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Lars Ganrot <lga@napatech.com>
Date: Wed, 28 Mar 2018 08:23:38 +0000
Message-ID: <ee81d80dd7d4497a97f924be66e17227@napatech.com>
References: <1520629942-36324-1-git-send-email-mst@redhat.com>
 <1520629942-36324-14-git-send-email-mst@redhat.com>
In-Reply-To: <1520629942-36324-14-git-send-email-mst@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] [PATCH v10 13/13] split-ring: in order feature
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Michael et al

> Behalf Of Michael S. Tsirkin
> Sent: 9. marts 2018 22:24
>=20
> For a split ring, require that drivers use descriptors in order too.
> This allows devices to skip reading the available ring.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
[snip]
>=20
> +If VIRTIO_F_IN_ORDER has been negotiated, and when making a descriptor
> +with VRING_DESC_F_NEXT set in \field{flags} at offset $x$ in the table
> +available to the device, driver MUST set \field{next} to $0$ for the
> +last descriptor in the table (where $x =3D queue\_size - 1$) and to $x +
> +1$ for the rest of the descriptors.
> +
>  \subsubsection{Indirect Descriptors}\label{sec:Basic Facilities of a Vir=
tio
> Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descripto=
rs}
>=20
>  Some devices benefit by concurrently dispatching a large number @@ -247,=
6
> +257,10 @@ chained by \field{next}. An indirect descriptor without a vali=
d
> \field{next}  A single indirect descriptor  table can include both device=
-
> readable and device-writable descriptors.
>=20
> +If VIRTIO_F_IN_ORDER has been negotiated, indirect descriptors use
> +sequential indices, in-order: index 0 followed by index 1 followed by
> +index 2, etc.
> +
>  \drivernormative{\paragraph}{Indirect Descriptors}{Basic Facilities of a=
 Virtio
> Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descripto=
rs}
> The driver MUST NOT set the VIRTQ_DESC_F_INDIRECT flag unless the
>  VIRTIO_F_INDIRECT_DESC feature was negotiated.   The driver MUST NOT
> @@ -259,6 +273,10 @@ the device.
>  A driver MUST NOT set both VIRTQ_DESC_F_INDIRECT and
> VIRTQ_DESC_F_NEXT  in \field{flags}.
>=20
> +If VIRTIO_F_IN_ORDER has been negotiated, indirect descriptors MUST
> +appear sequentially, with \field{next} taking the value of 1 for the
> +1st descriptor, 2 for the 2nd one, etc.
> +
>  \devicenormative{\paragraph}{Indirect Descriptors}{Basic Facilities of a=
 Virtio
> Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descripto=
rs}
> The device MUST ignore the write-only flag
> (\field{flags}\&VIRTQ_DESC_F_WRITE) in the descriptor that refers to an
> indirect table.
>=20

The use of VIRTIO_F_IN_ORDER for split-ring can eliminate some accesses to =
the virtq_avail.ring and virtq_used.ring. However I'm wondering if the prop=
osed descriptor ordering for multi-element buffers couldn't be tweaked to b=
e more HW friendly.  Currently even with the VIRTIO_F_IN_ORDER negotiated, =
there is no way of knowing if, or how many chained descriptors follow the d=
escriptor pointed to by the virtq_avail.idx. A chain has to be inspected on=
e descriptor at a time until virtq_desc.flags[VIRTQ_DESC_F_NEXT]=3D0. This =
is awkward for HW offload, where you want to DMA all available descriptors =
in one shot, instead of iterating based on the contents of received DMA dat=
a. As currently defined, HW would have to find a compromise between likely =
chain length, and cost of additional DMA transfers. This leads to a perform=
ance penalty for all chained descriptors, and in case the length assumption=
 is wrong the impact can be significant.

Now, what if the VIRTIO_F_IN_ORDER instead required chained buffers to plac=
e the last element at the lowest index, and the head-element (to which virt=
q_avail.idx points) at the highest index? Then all the chained element desc=
riptors would be included in a DMA of the descriptor table from the previou=
s virtq_avail.idx+1 to the current virtq_avail.idx. The "backward" order of=
 the chained descriptors shouldn't pose an issue as such (at least not in H=
W).

Best Regards,

-Lars

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

