Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v3] virtio-net: support the virtqueue coalescing
 moderation
Date: Fri, 17 Feb 2023 02:47:43 +0000
Message-ID: <PH0PR12MB5481646B2DE1E64D0DC6E3A5DCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230216144301.57728-1-hengqi@linux.alibaba.com>
In-Reply-To: <20230216144301.57728-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Thursday, February 16, 2023 9:43 AM

[..]
>  #define VIRTIO_NET_CTRL_NOTF_COAL 6
> - #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
> + #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET 0
Unrelated change. Please remove this hunk.

>   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2 #define
> + VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
> +
>  \end{lstlisting}
>=20
>  Coalescing parameters:
> @@ -4514,12 +4521,67 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi  \end{itemize}
>=20
>=20
> -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
> +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
>  \begin{enumerate}
>  \item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and
> \field{tx_max_packets} parameters.
>  \item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and
> \field{rx_max_packets} parameters.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_packets}
> and \field{max_usecs} parameters for a enabled
> +                                        transmit/receive virtqueue whose=
 number is \field{vqn}.
In the spec we have mix of notion as vqn or vq index.
For example, recent aq patch from Michael refers to aq vq index.
Mmio has vq index register too for long time.

And some places we don't refer to index vs number. (pcie queue_select regis=
ter).
We all understand that they refer to same.
But it is time to get consistency for new additions.

So lets agree on either one of the naming convention.

Michael,
I am inclined to name it as vq index given existings references and with yo=
ur aq vq index patch.
Do you have preference?
If its index, above should be changed from vqn/vq_index.

> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device gets the
> \field{max_packets} and \field{max_usecs} parameters of
> +                                        a enabled transmit/receive virtq=
ueue whose number is
> \field{vqn}, and then
> +                                        responds them to the driver.
>  \end{enumerate}
It is confusing line of "device gets".

It is better to write it as,=20
The device returns max_packets and max_usecs for the enabled transmit or re=
ceive virtuque whose index is vq_index.

>=20
> +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated:
> +1. a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command to
> set the coalescing
> +   parameters of a enabled transmit/receive virtqueue.
> +2. a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command to a
> device, and the device
> +   responds to the driver with the coalescing parameters of a enabled
> transmit/receive virtqueue.
> +
> +\begin{lstlisting}
> +struct virtio_net_ctrl_coal_vq {
> +    le16 vqn;
> +    le16 reserved;
> +    le32 max_packets;
> +    le32 max_usecs;
> +};
> +\end{lstlisting}
> +
> +Virtqueue coalescing parameters:
> +\begin{itemize}
> +\item \field{vqn}: The virtqueue number of the enabled transmit or recei=
ve
> virtqueue, excluding the control virtqueue.
Transmit and receive vq is self-explanatory. No need to mention control vq.
The word "excluding" doesn't fit here well given it refers to only single v=
q at a time.

> +\item \field{max_packets}: The maximum number of packets sent/received b=
y
> the specified virtqueue before a TX/RX notification.
> +\item \field{max_usecs}: The maximum number of TX/RX usecs that the
> specified virtqueue delays a TX/RX notification.
> +\end{itemize}
> +
> +\field{reserved} is reserved and it is ignored by the device.
> +
> +THe value of \field{vqn} satisfies $ 0 \leq vqn < max_virtqueue_pairs \a=
st 2 $.
> +The conversion between \field{vqn} and transmitq/receiveq index:
> +\begin{itemize}
> +$ \lfloor vqn / 2 \rfloor $ is the index of the corresponding receiveq.
> +$ \lfloor (vqn / 2) + 1 \rfloor $ is the index of the corresponding tran=
mitq.
> +\end{itemize}
> +
No need to provide the math here, it is about enabled vq.
The spec somewhere else already describes what the valid index of enabled v=
q.

> +The VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command is the same as the
> +VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command repeated for each
> virtqueue of receiveq1\ldots receiveqN.
> +
> +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command is the same as the
> +VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command repeated for each
> virtqueue of transmitq1\ldots transmitqN.
> +
> +If coalescing parameters are being set, the device applies the last
> +coalescing parameters received for a virtqueue, regardless of the comman=
d
> used to deliver the parameters. For example:
used to set the parameters.

> +# Command sequence 1:
> +1. VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command with $
> \field{max_packets}
> +=3D 15 $ and $ \field{max_usecs} =3D 10 $ 2.
> +VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with $ \field{vqn} =3D 0 $, $
> +\field{max_packets} =3D 12 $ and $ \field{max_usecs} =3D 8 $ After #2 co=
mmand is
> applied by the device, the coalescing parameters of receiveq1 are $
> \field{max_packets} =3D 12 $ and $ \field{max_usecs} =3D 8 $, and the coa=
lescing
> parameters of receiveq2\ldots receiveqN are $ \field{max_packets} =3D 15 =
$ and
> $ \field{max_usecs} =3D 10 $.
> +
> +# Command sequence 2:
> +1. VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with $ \field{vqn} =3D 0 $,
> $
> +\field{max_packets} =3D 12 $ and $ \field{max_usecs} =3D 8 $ 2.
> +VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command with $ \field{max_packets}
> =3D 15 $ and $ \field{max_usecs} =3D 10 $ After #2 command is applied by =
the
> device, the coalescing parameters of receiveq1\ldots receiveqN are $
> \field{max_packets} =3D 15 $ and $ \field{max_usecs} =3D 10 $.
> +
>  \subparagraph{RX Notifications}\label{sec:Device Types / Network Device =
/
> Device Operation / Control Virtqueue / Notifications Coalescing / RX
> Notifications}
>=20
>  If, for example:
> @@ -4532,9 +4594,33 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi
>=20
>  \begin{itemize}
>  \item The device will count received packets until it accumulates 15, or=
 until 10
> usecs elapsed since the first one was received.
> -\item If the notifications are not suppressed by the driver, the device =
will send
> an used buffer notification, otherwise, the device will not send an used =
buffer
> notification as long as the notifications are suppressed.
> +\item If the notifications are not suppressed by the driver, the device =
will send
> an used buffer notification, otherwise,
> +      the device will not send an used buffer notification as long as th=
e
> notifications are suppressed.
> +\end{itemize}
> +
> +Example of setting coalescing parameters for a receive virtqueue:
> +\begin{itemize}
> +\item \field{max_packets} =3D 15
> +\item \field{max_usecs} =3D 10
> +\item \field{vqn} =3D 0
> +\end{itemize}
> +
> +The device will operate as follows:
> +\begin{itemize}
> +\item The device applies the coalescing parameters to receiveq1 because =
its
> virtqueue number is 0.
> +\item The device will count received packets on receiveq1 until it accum=
ulates
> 15, or until 10 usecs elapsed since the first one was received.

> +\item If the notifications are not suppressed by the driver, the device =
will send
> an used buffer notification, otherwise,
> +      the device will not send an used buffer notification as long as th=
e
> notifications are suppressed.
> +\end{itemize}
> +
> +Example of getting coalescing parameters from a receive virtqueue:
> +\begin{itemize}
> +\item \field{vqn} =3D 0.
>  \end{itemize}
>=20
> +The device gets the values of the \field{max_packets} and
> +\field{max_usecs} parameters from the receiveq1 whose virtqueue number i=
s
> 0, and then responds them to the driver.
> +
The device returns the value of X and Y parameters for the supplied vq inde=
x.

>  \subparagraph{TX Notifications}\label{sec:Device Types / Network Device =
/
> Device Operation / Control Virtqueue / Notifications Coalescing / TX
> Notifications}
>=20
>  If, for example:
> @@ -4550,14 +4636,50 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi  \item If the
> notifications are not suppressed by the driver, the device will send an u=
sed
> buffer notification, otherwise, the device will not send an used buffer
> notification as long as the notifications are suppressed.
>  \end{itemize}
>=20
> +Example of setting coalescing parameters for a transmit virtqueue:
> +\begin{itemize}
> +\item \field{max_packets} =3D 15
> +\item \field{max_usecs} =3D 10
> +\item \field{vqn} =3D 1
> +\end{itemize}
> +
> +The device will operate as follows:
> +
> +\begin{itemize}
> +\item The device applies the coalescing parameters to transmitq1 because=
 its
> virtqueue number is 1.
> +\item The device will count sent packets on transmitq1 until it accumula=
tes 15,
> or until 10 usecs elapsed since the first one was sent.
> +\item If the notifications are not suppressed by the driver, the device =
will send
> an used buffer notification, otherwise,
> +      the device will not send an used buffer notification as long as th=
e
> notifications are suppressed.
> +\end{itemize}
> +
> +Example of getting coalescing parameters from a transmit virtqueue:
> +\begin{itemize}
> +\item \field{vqn} =3D 1.
> +\end{itemize}
> +
> +The device gets the values of the \field{max_packets} and
> +\field{max_usecs} parameters from the transmitq1 whose virtqueue number
> is 1, and then responds them to the driver.
> +
>  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types /
> Network Device / Device Operation / Control Virtqueue / Notifications
> Coalescing}
>=20
> -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the drive=
r
> MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> +If neither the VIRTIO_NET_F_NOTF_COAL nor the
> VIRTIO_NET_F_VQ_NOTF_COAL
> +feature has not been negotiated, the driver MUST NOT issue
> VIRTIO_NET_CTRL_NOTF_COAL commands.
> +
> +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated, the driver MUST
> +set \field{vqn} to a legal value, that is, \field{vqn} points to an enab=
led
> transmit/receive virtqueue.
> +
> +A driver MAY NOT get exactly the same value as the coalescing parameter =
it
> was set to, for example it MAY get a value that is a power of 2.
>=20
It MAY get a value that is close to power of 2 value of the previously set =
value.

>  \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types /
> Network Device / Device Operation / Control Virtqueue / Notifications
> Coalescing}
>=20
>  A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands
> with VIRTIO_NET_ERR if it was not able to change the parameters.
>
Silently dropping the command is not good, we cannot change past now.
But lets please fix the below one.
Please add the note around above text that,
Note: VQ_COAL is exception to it, which must return NET_ERR if device is un=
able to change the parameters.

> +When a device receives a virtqueue command to set/get coalescing
> +parameters for a virtqueue with number \field{vqn}, if the virtqueue is =
not
> enabled, the device SHOULD respond to the command with VIRTIO_NET_ERR.
> +
Device MUST respond with an error on the object that doesn't exist.
Please change it to MUST.

Please add below text. Need some wording change for above SHOULD.

A device MUST respond to the VIRTIO_NET_CTRL_VQ_NOTF_COAL_GET and SET comma=
nd with
with VIRTIO_NET_ERR if it is not able to change the parameters.


> +A device MAY NOT set the coalescing parameter to the exact same value
> +as the one passed in by a driver.=20
s/as the one passed in by a driver/as the one set by the driver

For example, the value of \field{max_packets}
> set by the driver is 15, but the device MAY store a value that is a power=
 of 2,
> that is, 16.
> +
>  A device SHOULD NOT send used buffer notifications to the driver, if the
> notifications are suppressed as explained in \ref{sec:Basic Facilities of=
 a Virtio
> Device / Virtqueues / Used Buffer Notification Suppression}, even if the
> coalescing counters expired.
>=20
>  Upon reset, a device MUST initialize all coalescing parameters to 0.
> --
> 2.19.1.6.gb485710b

