Return-Path: <virtio-dev-return-10628-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Mon, 16 Jan 2023 19:42:01 +0000
Message-ID: <PH0PR12MB5481A88FBABF45BC2736AC56DCC19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230111152123.148889-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20230111152123.148889-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Subject: RE: [virtio-dev] [PATCH v2] virtio_net: support low and high rate of
 notification coalescing
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Alvaro,

> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> O=
n
> Behalf Of Alvaro Karsz
>=20
> This patch adds a new feature, VIRTIO_NET_F_NOTF_COAL_LOW_HIGH, while
> clarifying/fixing existing coalescing concepts.
>=20
While its visible in the patch itself, what is being done,=20
its important to mention the problem statement/motivation for the feature a=
t start of the commit log as first step.

So, can you please describe the motivation, what problem does the new comma=
nd solve?
It is likely that control entity which want to set different coalescing par=
ameters likely wants to more than just two values.
This is something already supported today.

> The new feature adds 4 new commands to VIRTIO_NET_CTRL_NOTF_COAL
> class:
> =09- VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET - coalescing
> parameters
> =09  to use when the packet rate is equal or lower then the low
> =09  threshold for TX.
>         - VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET - coalescing parameters
>           to use when the packet rate is equal or lower then the low
>           threshold for RX.
>         - VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET - coalescing parameters
>           to use when the packet rate is equal or higher then the high
>           threshold for TX.
>         - VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET - coalescing parameters
>           to use when the packet rate is equal or higher then the high
>           threshold for RX.
>=20
> On top of the new feature, this patch:
> =09- Unifies the virtio_net_ctrl_coal structs, since the one for tx
> =09  and the one for rx are identical.
> =09- Clarifies that the coalescing commands are best-effort.
> =09- Specifies coalescing in respect to delivering interrupts when config
>           changes.
>=20
They are best to be handled a pre-patch to this one.
Please split them so that spec improvement work can progress while new feat=
ures are under review.

>=20
> +\item[VIRTIO_NET_F_NOTF_COAL_LOW_HIGH(50)] Device supports
> notifications coalescing low rate and high rate sets.
> +
Even though historically, many feature bits exists, adding more feature bit=
s is not scalable.
It is also limits to enable such functionality at very early stage in the d=
evice configuration.

So, if at all this proceeds, we want the new admin q to discover and negoti=
ate the new features.
(Instead of features bits).

>  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications
> coalescing.
>=20
>  \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> @@ -3142,6 +3144,7 @@ \subsubsection{Feature bit
> requirements}\label{sec:Device Types / Network Device
> \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_NOTF_COAL_LOW_HIGH] Requires
> VIRTIO_NET_F_NOTF_COAL.
>  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or
> VIRTIO_NET_F_HOST_TSO6.
>  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>  \end{description}
> @@ -4493,43 +4496,62 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi  If the
> VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can  send contro=
l
> commands for dynamically changing the coalescing parameters.
>=20
> +Note: In general, these commands are best-effort: A device could send a
> notification even if it is not supposed to.
> +
>  \begin{lstlisting}
> -struct virtio_net_ctrl_coal_rx {
> -    le32 rx_max_packets;
> -    le32 rx_usecs;
> +struct virtio_net_ctrl_coal {
> +    le32 max_packets;
> +    le32 usecs;
>  };
>=20
Please put this change in a pre-patch along with additional rework of below=
.


> -struct virtio_net_ctrl_coal_tx {
> -    le32 tx_max_packets;
> -    le32 tx_usecs;
> +struct virtio_net_ctrl_coal_threshold {
> +    le32 pkt_rate;
> +    struct virtio_net_ctrl_coal params;
>  };
>=20
>  #define VIRTIO_NET_CTRL_NOTF_COAL 6
>   #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
>   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> + #define VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET 2 //Only if
> + VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated #define
> + VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET 3 //Only if
> + VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated #define
> + VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET 4 //Only if
> + VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated #define
> + VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET 5 //Only if
> + VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated
>  \end{lstlisting}
>=20
> -Coalescing parameters:
> +TX Coalescing parameters:
> +\begin{itemize}
> +\item \field{usecs}: Maximum number of usecs to delay a TX notification.
> +\item \field{max_packets}: Maximum number of packets to send before a TX
> notification.
> +\end{itemize}
> +
> +RX Coalescing parameters:
> +\begin{itemize}
> +\item \field{usecs}: Maximum number of usecs to delay a RX notification.
> +\item \field{max_packets}: Maximum number of packets to receive before a
> RX notification.
> +\end{itemize}
> +
> +General Coalescing parameters:
>  \begin{itemize}
> -\item \field{rx_usecs}: Maximum number of usecs to delay a RX notificati=
on.
> -\item \field{tx_usecs}: Maximum number of usecs to delay a TX notificati=
on.
> -\item \field{rx_max_packets}: Maximum number of packets to receive befor=
e
> a RX notification.
> -\item \field{tx_max_packets}: Maximum number of packets to send before a
> TX notification.
> +\item \field{pkt_rate}: Threshold for low/high packet rate coalescing
> parameters, in units of packets per second.
>  \end{itemize}
>=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

