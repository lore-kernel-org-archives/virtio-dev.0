Return-Path: <alvaro.karsz@solid-run.com>
MIME-Version: 1.0
References: <20230216144301.57728-1-hengqi@linux.alibaba.com>
In-Reply-To: <20230216144301.57728-1-hengqi@linux.alibaba.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Fri, 17 Feb 2023 10:42:21 +0200
Message-ID: <CAJs=3_AS5qZ5ZcHWod+U5NSQazmZNgMkMvqGghr3aNsqSapRFA@mail.gmail.com>
Subject: Re: [virtio-comment] [PATCH v3] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Heng,

> +\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports the virtqueue
> +    notifications coalescing.
> +
>  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalesci=
ng.
>
>  \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> @@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label{sec:=
Device Types / Network Device
>  \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NE=
T_F_HOST_TSO6.
>  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>  \end{description}
>
>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / =
Network Device / Feature bits / Legacy Interface: Feature bits}
> @@ -4501,8 +4505,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device=
 Types / Network Device / Devi
>  };
>
>  #define VIRTIO_NET_CTRL_NOTF_COAL 6
> - #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
> + #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET 0
>   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
> +
>  \end{lstlisting}
>
>  Coalescing parameters:
> @@ -4514,12 +4521,67 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
>  \end{itemize}
>
>
> -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
> +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
>  \begin{enumerate}
>  \item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and \fi=
eld{tx_max_packets} parameters.
>  \item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \fi=
eld{rx_max_packets} parameters.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_packets} and =
\field{max_usecs} parameters for a enabled
> +                                        transmit/receive virtqueue whose=
 number is \field{vqn}.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device gets the \field{max_p=
ackets} and \field{max_usecs} parameters of
> +                                        a enabled transmit/receive virtq=
ueue whose number is \field{vqn}, and then
> +                                        responds them to the driver.
>  \end{enumerate}
>
> +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated:
> +1. a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command to set t=
he coalescing
> +   parameters of a enabled transmit/receive virtqueue.
> +2. a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command to a dev=
ice, and the device
> +   responds to the driver with the coalescing parameters of a enabled tr=
ansmit/receive virtqueue.
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

Maybe we can use struct virtio_net_ctrl_coal inside struct
virtio_net_ctrl_coal_vq instead of repeating max_usecs and
max_packets?
I'm not sure if it would be confusing, what do you think?

> +Virtqueue coalescing parameters:
> +\begin{itemize}
> +\item \field{vqn}: The virtqueue number of the enabled transmit or recei=
ve virtqueue, excluding the control virtqueue.
> +\item \field{max_packets}: The maximum number of packets sent/received b=
y the specified virtqueue before a TX/RX notification.
> +\item \field{max_usecs}: The maximum number of TX/RX usecs that the spec=
ified virtqueue delays a TX/RX notification.
> +\end{itemize}
> +
> +\field{reserved} is reserved and it is ignored by the device.
> +

max_packets is the same with VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and with
VIRTIO_NET_CTRL_NOTF_COAL_[T/R]X_SET.
("Maximum number of packets to receive/send before a RX/TX notification").
The fact that this is applied to all VQs or to a specific one is
derived from the command.
Same for max_usecs.
Maybe we can join the coalescing parameters somehow instead of
repeating the explanations?

> +THe value of \field{vqn} satisfies $ 0 \leq vqn < max_virtqueue_pairs \a=
st 2 $.
> +The conversion between \field{vqn} and transmitq/receiveq index:
> +\begin{itemize}
> +$ \lfloor vqn / 2 \rfloor $ is the index of the corresponding receiveq.
> +$ \lfloor (vqn / 2) + 1 \rfloor $ is the index of the corresponding tran=
mitq.
> +\end{itemize}
> +
> +The VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command is the same as the VIRTIO_N=
ET_CTRL_NOTF_COAL_VQ_SET
> +command repeated for each virtqueue of receiveq1\ldots receiveqN.
> +
> +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command is the same as the VIRTIO_N=
ET_CTRL_NOTF_COAL_VQ_SET
> +command repeated for each virtqueue of transmitq1\ldots transmitqN.
> +
> +If coalescing parameters are being set, the device applies the last coal=
escing parameters received for a
> +virtqueue, regardless of the command used to deliver the parameters. For=
 example:
> +# Command sequence 1:
> +1. VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command with $ \field{max_packets} =
=3D 15 $ and $ \field{max_usecs} =3D 10 $
> +2. VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with $ \field{vqn} =3D 0 $, =
$ \field{max_packets} =3D 12 $ and $ \field{max_usecs} =3D 8 $
> +After #2 command is applied by the device, the coalescing parameters of =
receiveq1 are $ \field{max_packets} =3D 12 $ and $ \field{max_usecs} =3D 8 =
$,
> +and the coalescing parameters of receiveq2\ldots receiveqN are $ \field{=
max_packets} =3D 15 $ and $ \field{max_usecs} =3D 10 $.
> +
> +# Command sequence 2:
> +1. VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with $ \field{vqn} =3D 0 $, =
$ \field{max_packets} =3D 12 $ and $ \field{max_usecs} =3D 8 $
> +2. VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command with $ \field{max_packets} =
=3D 15 $ and $ \field{max_usecs} =3D 10 $
> +After #2 command is applied by the device, the coalescing parameters of =
receiveq1\ldots receiveqN are $ \field{max_packets} =3D 15 $ and $ \field{m=
ax_usecs} =3D 10 $.
> +
>  \subparagraph{RX Notifications}\label{sec:Device Types / Network Device =
/ Device Operation / Control Virtqueue / Notifications Coalescing / RX Noti=
fications}
>
>  If, for example:
> @@ -4532,9 +4594,33 @@ \subsubsection{Control Virtqueue}\label{sec:Device=
 Types / Network Device / Devi
>
>  \begin{itemize}
>  \item The device will count received packets until it accumulates 15, or=
 until 10 usecs elapsed since the first one was received.
> -\item If the notifications are not suppressed by the driver, the device =
will send an used buffer notification, otherwise, the device will not send =
an used buffer notification as long as the notifications are suppressed.
> +\item If the notifications are not suppressed by the driver, the device =
will send an used buffer notification, otherwise,
> +      the device will not send an used buffer notification as long as th=
e notifications are suppressed.

Both sentences seem similar to me.

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
its virtqueue number is 0.
> +\item The device will count received packets on receiveq1 until it accum=
ulates 15, or until 10 usecs elapsed since the first one was received.
> +\item If the notifications are not suppressed by the driver, the device =
will send an used buffer notification, otherwise,
> +      the device will not send an used buffer notification as long as th=
e notifications are suppressed.
> +\end{itemize}
> +
> +Example of getting coalescing parameters from a receive virtqueue:
> +\begin{itemize}
> +\item \field{vqn} =3D 0.
>  \end{itemize}
>
> +The device gets the values of the \field{max_packets} and \field{max_use=
cs} parameters from the receiveq1 whose virtqueue number is 0,
> +and then responds them to the driver.
> +
>  \subparagraph{TX Notifications}\label{sec:Device Types / Network Device =
/ Device Operation / Control Virtqueue / Notifications Coalescing / TX Noti=
fications}
>
>  If, for example:
> @@ -4550,14 +4636,50 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
>  \item If the notifications are not suppressed by the driver, the device =
will send an used buffer notification, otherwise, the device will not send =
an used buffer notification as long as the notifications are suppressed.
>  \end{itemize}
>
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
 its virtqueue number is 1.
> +\item The device will count sent packets on transmitq1 until it accumula=
tes 15, or until 10 usecs elapsed since the first one was sent.
> +\item If the notifications are not suppressed by the driver, the device =
will send an used buffer notification, otherwise,
> +      the device will not send an used buffer notification as long as th=
e notifications are suppressed.
> +\end{itemize}
> +
> +Example of getting coalescing parameters from a transmit virtqueue:
> +\begin{itemize}
> +\item \field{vqn} =3D 1.
> +\end{itemize}
> +
> +The device gets the values of the \field{max_packets} and \field{max_use=
cs} parameters from the transmitq1 whose virtqueue number is 1,
> +and then responds them to the driver.
> +
>  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types /=
 Network Device / Device Operation / Control Virtqueue / Notifications Coal=
escing}
>
> -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the drive=
r MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> +If neither the VIRTIO_NET_F_NOTF_COAL nor the VIRTIO_NET_F_VQ_NOTF_COAL =
feature
> +has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_=
COAL commands.
> +
> +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated, the driver MUST =
set \field{vqn}
> +to a legal value, that is, \field{vqn} points to an enabled transmit/rec=
eive virtqueue.
> +
> +A driver MAY NOT get exactly the same value as the coalescing parameter =
it was set to, for example it MAY get a value that is a power of 2.
>

Maybe we can add here that the driver must ignore the values received
from VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, if the device responds with
VIRTIO_NET_ERR?

>  \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types /=
 Network Device / Device Operation / Control Virtqueue / Notifications Coal=
escing}
>
>  A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with V=
IRTIO_NET_ERR if it was not able to change the parameters.
>
> +When a device receives a virtqueue command to set/get coalescing paramet=
ers for a virtqueue with number \field{vqn},
> +if the virtqueue is not enabled, the device SHOULD respond to the comman=
d with VIRTIO_NET_ERR.
> +
> +A device MAY NOT set the coalescing parameter to the exact same value as=
 the one passed in by a driver. For example,
> +the value of \field{max_packets} set by the driver is 15, but the device=
 MAY store a value that is a power of 2, that is, 16.
> +
>  A device SHOULD NOT send used buffer notifications to the driver, if the=
 notifications are suppressed as explained in \ref{sec:Basic Facilities of =
a Virtio Device / Virtqueues / Used Buffer Notification Suppression}, even =
if the coalescing counters expired.
>
>  Upon reset, a device MUST initialize all coalescing parameters to 0.

