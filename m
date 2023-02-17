Return-Path: <virtio-comment-return-4308-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Fri, 17 Feb 2023 02:54:47 +0000
Message-ID: <PH0PR12MB5481F5B39A8CEB6E88B858CBDCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230216145611.1361327-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20230216145611.1361327-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [PATCH v5] virtio-net: Fix and update VIRTIO_NET_F_NOTF_COAL
 feature
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "hengqi@linux.alibaba.com" <hengqi@linux.alibaba.com>, "david.edmondson@oracle.com" <david.edmondson@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Alvaro Karsz <alvaro.karsz@solid-run.com>
> Sent: Thursday, February 16, 2023 9:56 AM

[..]
> +When the device has \field{max_usecs} =3D 0 or \field{max_packets} =3D 0=
, the
> notification conditions are met after every packet received/sent.
> +

> +\subparagraph{RX Example}\label{sec:Device Types / Network Device /
> +Device Operation / Control Virtqueue / Notifications Coalescing / RX
> +Example}
>=20
>  If, for example:
>  \begin{itemize}
> -\item \field{rx_usecs} =3D 10.
> -\item \field{rx_max_packets} =3D 15.
> +\item \field{max_usecs} =3D 10.
> +\item \field{max_packets} =3D 15.
>  \end{itemize}
> -
> -The device will operate as follows:
> -
> +then a device with a single receive virtqueue will operate as follows:
>  \begin{itemize}
>  \item The device will count received packets until it accumulates 15, or=
 until 10
> usecs elapsed since the first one was received.
>  \item If the notifications are not suppressed by the driver, the device =
will send
> an used buffer notification, otherwise, the device will not send an used =
buffer
> notification as long as the notifications are suppressed.
>  \end{itemize}
>=20
> -\subparagraph{TX Notifications}\label{sec:Device Types / Network Device =
/
> Device Operation / Control Virtqueue / Notifications Coalescing / TX
> Notifications}
> +\subparagraph{TX Example}\label{sec:Device Types / Network Device /
> +Device Operation / Control Virtqueue / Notifications Coalescing / TX
> +Example}
>=20
>  If, for example:
>  \begin{itemize}
> -\item \field{tx_usecs} =3D 10.
> -\item \field{tx_max_packets} =3D 15.
> +\item \field{max_usecs} =3D 10.
> +\item \field{max_packets} =3D 15.
>  \end{itemize}
> -
> -The device will operate as follows:
> -
> +then a device with a single transmit virtqueue will operate as follows:
>  \begin{itemize}
>  \item The device will count sent packets until it accumulates 15, or unt=
il 10
> usecs elapsed since the first one was sent.
>  \item If the notifications are not suppressed by the driver, the device =
will send
> an used buffer notification, otherwise, the device will not send an used =
buffer
> notification as long as the notifications are suppressed.
>  \end{itemize}
>=20
> +\subparagraph{Notifications When Coalescing Parameters
> +Change}\label{sec:Device Types / Network Device / Device Operation /
> +Control Virtqueue / Notifications Coalescing / Notifications When
> +Coalescing Parameters Change}
> +
> +When the coalescing parameters of a device change, the device needs to
> check if the new notification conditions are met and send a used buffer
> notification if so.
> +
> +For example, \field{max_packets} =3D 15 for a device with a single
> +transmit virtqueue: if the device sends 10 packets and afterwards
> +receives a VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command with
> \field{max_packets} =3D 8, then the notification condition is immediately
> considered to be met; the device needs to immediately send a used buffer
> notification, if the notifications are not suppressed by the driver.
> +
>  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types /
> Network Device / Device Operation / Control Virtqueue / Notifications
> Coalescing}
>=20
>  If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the drive=
r
> MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> @@ -1583,7 +1596,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device
> Types / Network Device / Devi
>=20
>  A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands
> with VIRTIO_NET_ERR if it was not able to change the parameters.
>=20
> -A device SHOULD NOT send used buffer notifications to the driver, if the
> notifications are suppressed as explained in \ref{sec:Basic Facilities of=
 a Virtio
> Device / Virtqueues / Used Buffer Notification Suppression}, even if the
> coalescing counters expired.
> +A device SHOULD NOT send used buffer notifications to the driver if the
> notifications are suppressed, even if the notification conditions are met=
.
>=20
>  Upon reset, a device MUST initialize all coalescing parameters to 0.
>=20
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

