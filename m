Return-Path: <virtio-comment-return-4140-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Fri, 10 Feb 2023 19:36:03 +0000
Message-ID: <PH0PR12MB548155EF2CB09C6C88B75C44DCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230210070130.21811-1-hengqi@linux.alibaba.com>
In-Reply-To: <20230210070130.21811-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [PATCH v2] virtio-net: support the virtqueue coalescing
 moderation
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Friday, February 10, 2023 2:02 AM
>=20
> Currently, the coalescing profile is directly applied to all queues.

Say it,
Currently coalescing parameters are grouped for all transmit and receive vi=
rtqueues.

> This patch supports setting or getting the parameters for a specified que=
ue, and
> a typical application of this function is NetDIM.
Many of us know the net dim.
But if you prefer to mention it here, better to have the link for it.

Please add pointer to it.
[1] https://docs.kernel.org/networking/net_dim.html

>=20
> When the traffic between queues is unbalanced, for example, one queue is
> busy and another queue is idle, then it will be very useful to control co=
alescing
> parameters at the queue granularity.
>=20
>=20
> +If additionally VIRTIO_NET_F_VQ_NOTF_COAL is negotiated, the driver can
> +send control commands to set or get the coalescing parameters of a
Control command singular?

> +specified virtqueue (excluding the control virtqueue).
> +
> +\begin{lstlisting}
> +struct virtio_net_ctrl_coal_vq {
> +    le32 max_packets;
> +    le32 usecs;
> +    le16 vqn;
> +};
> +
Change that Michael suggest restructuring and under same class looks good t=
o me.

> +#define VIRTIO_NET_CTRL_NOTF_COAL_VQ 7
> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 0  #define
> +VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 1 \end{lstlisting}
> +
> +Virtqueue coalescing parameters:
> +\begin{itemize}
> +\item \field{max_packets}: The maximum number of packets sent/received b=
y
> the
> +    specified virtqueue before a TX/RX notification.
> +\item \field{usecs}: The maximum number of TX/RX usecs that the specifie=
d
> +    virtqueue delays a TX/RX notification.
> +\item \field{vqn}: The virtqueue number of the specified virtqueue.
> +\end{itemize}
> +
The virtqueue number of the enabled transmit or receive virtuqueue.
This will simplify below description.

> +The range of \filed{vqn} is between 0 and 0xFFFF inclusive, $ \lfloor
> +vqn / 2 \rfloor $ is the index of the corresponding receiveq, and
> +$\lfloor (vqn / 2) + 1 \rfloor $ is the corresponding tranmitq.
> +

Please add short description something like,

When the driver prefers to use per virtqueue notifications coalescing, and =
if queue group (transmit or receive) level notification coalescing is enabl=
ed, driver SHOULD first disable device level notification coalescing.
Or it should be,

Virtqueue level notifications coalescing, and device level notifications ca=
n be enabled together.
When both of them are enabled, per virtqueue notifications coalescing take =
priority over queue group level.

With rests of the comments from Michael and Alvaro in progress, looks good.

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

