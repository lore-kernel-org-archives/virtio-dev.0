Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v6] virtio-net: Avoid confusion between a card and a
 device
Date: Fri, 3 Feb 2023 13:46:23 +0000
Message-ID: <PH0PR12MB5481C9E9030566EF839F33CBDCD79@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230123170645.1141842-1-parav@nvidia.com>
In-Reply-To: <20230123170645.1141842-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Michael,

> From: Parav Pandit <parav@nvidia.com>
> Sent: Monday, January 23, 2023 12:07 PM
> To: mst@redhat.com; virtio-dev@lists.oasis-open.org; cohuck@redhat.com;
> pasic@linux.ibm.com; jasowang@redhat.com
> Cc: virtio-comment@lists.oasis-open.org; Shahaf Shuler
> <shahafs@nvidia.com>; Parav Pandit <parav@nvidia.com>
> Subject: [PATCH v6] virtio-net: Avoid confusion between a card and a devi=
ce
>=20
> Historically virtio network device is documented as an Ethernet card.
> A modern card in the industry has one to multiple ports, one to multiple =
PCI
> functions. However the virtio network device is usually just a single lin=
k/port
> network interface controller.
>=20
> Hence, avoid this confusing term 'card' and align the specification to ad=
here to
> widely used specification term as 'device' used for all virtio device typ=
es.
>=20
> Replaced 'card' with 'network interface controller'.
>=20
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/154
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> This patch is on top of change [1].
>=20
> [1] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00210.html

This is due many days now.
I have also addressed the comment of Halil.
Other patches depend on this change, and they need to progress too.
This was reviewed by Jason Wang before. I dropped the Jason's reviewed-by t=
ag due to one change in the wording.

Can you please initiate the voting?

> ---
> changelog:
> v5->v6:
> - fixed 'consist' to 'consists'
> v4->v5:
> - replaced 'network card' with 'device' in the device initialization
>   section description
> - net device checksum feature bit description updated
> - rename card to network interface controller
> v3->v4:
> - rebased to new directory name
> v2->v3:
> - rebased to new file name
> v1->v2:
> - adapt to new file path
> v0->v1:
> - removed device word twice
> - corrected grammar for changing from card to device
> ---
>  content.tex                      |  6 +++---
>  device-types/net/description.tex | 22 +++++++++++-----------
>  2 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/content.tex b/content.tex
> index 0118b8a..df5ce16 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -619,7 +619,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio
> Transport Options / Virtio Ov  \hline
>  Transitional PCI Device ID  &  Virtio Device    \\
>  \hline \hline
> -0x1000      &   network card     \\
> +0x1000      &   network device     \\
>  \hline
>  0x1001     &   block device     \\
>  \hline
> @@ -635,7 +635,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio
> Transport Options / Virtio Ov  \hline  \end{tabular}
>=20
> -For example, the network card device with the Virtio Device ID 1
> +For example, the network device with the Virtio Device ID 1
>  has the PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
>=20
>  The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
> @@ -2912,7 +2912,7 @@ \chapter{Device Types}\label{sec:Device Types}
> \hline \hline
>  0          & reserved (invalid) \\
>  \hline
> -1          &   network card     \\
> +1          &   network device     \\
>  \hline
>  2          &   block device     \\
>  \hline
> diff --git a/device-types/net/description.tex b/device-types/net/descript=
ion.tex
> index d3f9b52..e1341e6 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -1,13 +1,14 @@
>  \section{Network Device}\label{sec:Device Types / Network Device}
>=20
> -The virtio network device is a virtual ethernet card, and is the -most c=
omplex
> of the devices supported so far by virtio. It has -enhanced rapidly and
> demonstrates clearly how support for new -features are added to an existi=
ng
> device. Empty buffers are -placed in one virtqueue for receiving packets,=
 and
> outgoing -packets are enqueued into another for transmission in that orde=
r.
> -A third command queue is used to control advanced filtering -features.
> +The virtio network device is a virtual network interface controller.
> +It consists of a virtual Ethernet link which connects the device to the
> +Ethernet network. It is the most complex of the devices supported so
> +far by virtio. It has enhanced rapidly and demonstrates clearly how
> +support for new features are added to an existing device. Empty buffers
> +are placed in one virtqueue for receiving packets, and outgoing packets
> +are enqueued into another for transmission in that order. A third
> +command queue is used to control advanced filtering features.
>=20
>  \subsection{Device ID}\label{sec:Device Types / Network Device / Device =
ID}
>=20
> @@ -32,8 +33,7 @@ \subsection{Virtqueues}\label{sec:Device Types /
> Network Device / Virtqueues}  \subsection{Feature bits}\label{sec:Device =
Types
> / Network Device / Feature bits}
>=20
>  \begin{description}
> -\item[VIRTIO_NET_F_CSUM (0)] Device handles packets with partial
> checksum.   This
> -  ``checksum offload'' is a common feature on modern network cards.
> +\item[VIRTIO_NET_F_CSUM (0)] Device handles packets with partial checksu=
m
> offload.
>=20
>  \item[VIRTIO_NET_F_GUEST_CSUM (1)] Driver handles packets with partial
> checksum.
>=20
> @@ -323,7 +323,7 @@ \subsection{Device Initialization}\label{sec:Device
> Types / Network Device / Dev
>=20
>  \item If the VIRTIO_NET_F_MAC feature bit is set, the configuration
>    space \field{mac} entry indicates the ``physical'' address of the
> -  network card, otherwise the driver would typically generate a random
> +  device, otherwise the driver would typically generate a random
>    local MAC address.
>=20
>  \item If the VIRTIO_NET_F_STATUS feature bit is negotiated, the link
> --
> 2.26.2

