Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v10 06/10] mmio: document ADMIN_VQ as reserved
Date: Sat, 11 Feb 2023 18:52:08 +0000
Message-ID: <PH0PR12MB5481559F4C0C9BFCE434C71CDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-7-mst@redhat.com>
In-Reply-To: <20230209121221.15118-7-mst@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>
Cc: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, February 9, 2023 7:14 AM
>=20
> Adding relevant registers needs more work and it's not clear what the use=
-case
> will be as currently only the PCI transport is supported. But let's keep =
the door
> open on this.
> We already say it's reserved in a central place, but it does not hurt to =
remind
> implementers to mask it.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/content.tex b/content.tex
> index 2d9b903..f8bd1ab 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2362,6 +2362,18 @@ \subsection{Legacy interface}\label{sec:Virtio
> Transport Options / Virtio Over M
>=20
>  Notification mechanisms did not change.
>=20
> +\subsection{Features reserved for future use}\label{sec:Virtio
> +Transport Options / Virtio Over MMIO / Features reserved for future
> +use}
> +
> +At this time, devices and drivers utilizing Virtio Over MMIO do not
> +support the following features:
> +\begin{itemize}
> +
> +\item VIRTIO_F_ADMIN_VQ
> +
> +\end{itemize}
> +
> +These features are reserved for future use.
> +
>  \section{Virtio Over Channel I/O}\label{sec:Virtio Transport Options / V=
irtio
> Over Channel I/O}
>=20
>  S/390 based virtual machines support neither PCI nor MMIO, so a
> --
> MST

Reviewed-by: Parav Pandit <parav@nvidia.com>

