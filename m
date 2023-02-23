Return-Path: <virtio-comment-return-4468-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Thu, 23 Feb 2023 05:28:54 +0000
Message-ID: <PH0PR12MB5481814374787A88D91ABE90DCAB9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230222083014.2375727-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20230222083014.2375727-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [virtio-dev] [PATCH v2] virtio-net: define the
 VIRTIO_NET_F_CTRL_RX_EXTRA feature bit
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> O=
n
> Behalf Of Alvaro Karsz
>=20
> The VIRTIO_NET_F_CTRL_RX_EXTRA feature bit is mentioned in the spec since
> version 1.0, but it's not properly defined.
>=20
> This patch defines the feature bit and defines the dependency on
> VIRTIO_NET_F_CTRL_VQ.
>=20
> Since this dependency is missing in previous versions, we add it now as a
> "SHOULD".
>=20
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/162
>=20
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> ---
> v2:
> =09- Rephrase commit log, no changes to patch body.
>=20
>  device-types/net/description.tex | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/device-types/net/description.tex b/device-types/net/descript=
ion.tex
> index 8487ccd..cf37da5 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -74,6 +74,8 @@ \subsection{Feature bits}\label{sec:Device Types /
> Network Device / Feature bits
>=20
>  \item[VIRTIO_NET_F_CTRL_VLAN (19)] Control channel VLAN filtering.
>=20
> +\item[VIRTIO_NET_F_CTRL_RX_EXTRA (20)]=09Control channel RX extra
> mode support.
> +
>  \item[VIRTIO_NET_F_GUEST_ANNOUNCE(21)] Driver can send gratuitous
>      packets.
>=20
> @@ -259,6 +261,9 @@ \subsection{Device configuration
> layout}\label{sec:Device Types / Network Device  The device SHOULD NOT
> offer VIRTIO_NET_F_HASH_REPORT if it  does not offer
> VIRTIO_NET_F_CTRL_VQ.
>=20
> +The device SHOULD NOT offer VIRTIO_NET_F_CTRL_RX_EXTRA if it does not
> +offer VIRTIO_NET_F_CTRL_VQ.
> +
>  \drivernormative{\subsubsection}{Device configuration layout}{Device Typ=
es /
> Network Device / Device configuration layout}
>=20
>  A driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it.
> @@ -295,6 +300,9 @@ \subsection{Device configuration
> layout}\label{sec:Device Types / Network Device  A driver SHOULD NOT
> negotiate VIRTIO_NET_F_HASH_REPORT if it  does not negotiate
> VIRTIO_NET_F_CTRL_VQ.
>=20
> +A driver SHOULD NOT negotiate VIRTIO_NET_F_CTRL_RX_EXTRA if it does not
> +negotiate VIRTIO_NET_F_CTRL_VQ.
> +
>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:=
Device
> Types / Network Device / Device configuration layout / Legacy Interface: =
Device
> configuration layout}  \label{sec:Device Types / Block Device / Feature b=
its /
> Device configuration layout / Legacy Interface: Device configuration layo=
ut}
> When using the legacy interface, transitional devices and drivers
> --
> 2.34.1

Reviewed-by: Parav Pandit <parav@nvidia.com>


This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

