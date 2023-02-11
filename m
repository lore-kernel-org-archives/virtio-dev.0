Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v10 05/10] pci: add admin vq registers to virtio over pci
Date: Sat, 11 Feb 2023 18:52:00 +0000
Message-ID: <PH0PR12MB54816EC0376FC8C0C585B21EDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-6-mst@redhat.com>
In-Reply-To: <20230209121221.15118-6-mst@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>
Cc: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, February 9, 2023 7:14 AM

> diff --git a/content.tex b/content.tex
> index c8647c9..2d9b903 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -946,6 +946,10 @@ \subsubsection{Common configuration structure
> layout}\label{sec:Virtio Transport
>          le64 queue_device;              /* read-write */
>          le16 queue_notify_data;         /* read-only for driver */
>          le16 queue_reset;               /* read-write */
> +
> +        /* About the administration virtqueue. */
> +        le16 admin_queue_index;         /* read-only for driver */
> +        le16 admin_queue_num;         /* read-only for driver */
>  };
>  \end{lstlisting}
>=20
> @@ -1031,6 +1035,19 @@ \subsubsection{Common configuration structure
> layout}\label{sec:Virtio Transport
>          This field exists only if VIRTIO_F_RING_RESET has been
>          negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / =
Virtqueues /
> Virtqueue Reset}).
>=20
> +\item[\field{admin_queue_index}]
> +        The device uses this to report the index of the first administra=
tion
> virtqueue.
> +        This field is valid only if VIRTIO_F_ADMIN_VQ has been negotiate=
d.
> +\item[\field{admin_queue_num}]
> +=09The device uses this to report the number of the
> +=09supported administration virtqueues. =20
admin_queue_count reads more intuitive to me to indicate how many aqs.
It may be even simpler to have start and end vq numbers rather than complic=
ation of index + inclusive sum of number.

> Virtqueues with index
> +=09between \field{admin_queue_index} and (\field{admin_queue_index} +
> +=09\field{admin_queue_num}) inclusive serve as administration
> +=09virtqueues.
> +=09Thus the number of administration virtqueues equals
> +=09(\field{admin_queue_num} + 1).
> +=09This field is valid only if VIRTIO_F_ADMIN_VQ has been
> +=09negotiated.
>  \end{description}
>=20
>  \devicenormative{\paragraph}{Common configuration structure layout}{Virt=
io
> Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common
> configuration structure layout} @@ -1117,6 +1134,14 @@
> \subsubsection{Common configuration structure layout}\label{sec:Virtio
> Transport  were used before the queue reset.
>  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtque=
ue Reset}).
>=20
> +If VIRTIO_F_ADMIN_VQ has been negotiated, and if the driver configures
> +any administration virtqueues, the driver MUST configure the
> +administration virtqueues using the index in the range
> +\field{admin_queue_index} to \field{admin_queue_index} +
> +\field{admin_queue_num} inclusive.
> +The driver MAY configure less administration virtqueues than supported
> +by the device.
> +
>  \subsubsection{Notification structure layout}\label{sec:Virtio Transport=
 Options
> / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
>=20
>  The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG @=
@
> -7684,6 +7709,15 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved
> Feature Bits}
>=20
>    \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device
> exposes one or more
>    administration virtqueues.
> +  At the moment this feature is only supported for devices using
> +  \ref{sec:Virtio Transport Options / Virtio Over PCI
> +=09  Bus}~\nameref{sec:Virtio Transport Options / Virtio Over PCI Bus}
> +=09  as the transport and is reserved for future use for
> +=09  devices using other transports (see
> +=09  \ref{drivernormative:Basic Facilities of a Virtio Device / Feature =
Bits}
> +=09and
> +=09\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bi=
ts}
> for
> +=09handling features reserved for future use.
>=20
>  \end{description}
>=20
> --
> MST
Reviewed-by: Parav Pandit <parav@nvidia.com>


