Return-Path: <virtio-comment-return-3972-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Mon, 6 Feb 2023 22:02:39 +0000
Message-ID: <PH0PR12MB5481B6E2510FB242B76BBB30DCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230206080210.37758-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20230206080210.37758-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [virtio-dev] [PATCH v3] virtio-net: Mention
 VIRTIO_NET_F_HASH_REPORT dependency on VIRTIO_NET_F_CTRL_VQ
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> O=
n
> Behalf Of Alvaro Karsz
> ---
> v2: Use SHOULD instead of Feature bit requirement, version 1.2 is already
>     out and doesn't include this depencency.
>=20
> v3: Explain the dependency in a less confusing way.
>=20
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
>=20
>  device-types/net/description.tex | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/device-types/net/description.tex b/device-types/net/descript=
ion.tex
> index 700a1cb..1741c79 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -256,6 +256,9 @@ \subsection{Device configuration
> layout}\label{sec:Device Types / Network Device  \field{duplex} fields as=
 long as
> VIRTIO_NET_S_LINK_UP is set in  the \field{status}.
>=20
> +The device SHOULD NOT offer VIRTIO_NET_F_HASH_REPORT if it does not
> +offer VIRTIO_NET_F_CTRL_VQ.
> +
I believe this applies to all the configurations done through the control V=
Q.
So we should write a generic description instead of per feature statement l=
ike above.

>  \drivernormative{\subsubsection}{Device configuration layout}{Device Typ=
es /
> Network Device / Device configuration layout}
>=20
>  A driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it.
> @@ -289,6 +292,9 @@ \subsection{Device configuration
> layout}\label{sec:Device Types / Network Device  SHOULD re-read \field{sp=
eed}
> and \field{duplex} after a  configuration change notification.
>=20
> +A driver SHOULD NOT negotiate VIRTIO_NET_F_HASH_REPORT if it does not
> +negotiate VIRTIO_NET_F_CTRL_VQ.
> +
Same for the driver too.
Like below.
The driver should not negotiate a feature that requires to use a control VQ=
 when VIRTIO_NET_F_CTRL_VQ is not negotiated.

Or driver must not .. ..
Exception to that is VIRTIO_NET_F_HASH_REPORT, which driver should avoid ne=
gotiation ...

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

