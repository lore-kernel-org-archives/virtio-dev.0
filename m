Return-Path: <virtio-comment-return-4362-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <b4886307-e6d4-068d-9377-9e2976fac0fe@linux.alibaba.com>
Date: Sun, 19 Feb 2023 17:36:23 +0800
MIME-Version: 1.0
References: <20230219090312.1457138-1-alvaro.karsz@solid-run.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230219090312.1457138-1-alvaro.karsz@solid-run.com>
Subject: Re: [virtio-comment] [PATCH v6] virtio-net: Fix and update
 VIRTIO_NET_F_NOTF_COAL feature
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Alvaro Karsz <alvaro.karsz@solid-run.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, mst@redhat.com, parav@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi, Alvaro.
Thanks for your work !
As suggested earlier in the 'virtqueue coalescing' thread, I will be=20
working on top of your patch. :)


=E5=9C=A8 2023/2/19 =E4=B8=8B=E5=8D=885:03, Alvaro Karsz =E5=86=99=E9=81=93=
:
> This patch makes several improvements to the notification coalescing
> feature, including:
>
> - Consolidating virtio_net_ctrl_coal_tx and virtio_net_ctrl_coal_rx
>    into a single struct, virtio_net_ctrl_coal, as they are identical.
> - Emphasizing that the coalescing commands are best-effort.
> - Defining the behavior of coalescing with regards to delivering
>    notifications when a change occur.
> - Stating that the commands should apply to all the receive/transmit
>    virtqueues.
> - Stating that every receive/transmit virtqueue should count it's own
>    packets.
> - A new intro explaining the entire coalescing operation.
>
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> ---
> v2:
> =09- Add the last 2 points to the patch.
> =09- Rephrase the "commands are best-effort" note.
> =09- Replace "notification" with "used buffer notification" to be
> =09  more consistent.
> v3:
> =09- Add an intro explaining the entire coalescing operation.
> v4:
> =09- Minor wording fixes.
> =09- Rephrase the general note.
> v5:
> =09- Replace virtio_net_ctrl_coal->usecs with
> =09  virtio_net_ctrl_coal->max_usecs
> v6:
> =09- Replace usecs with microseconds.
> =09- Make the TX/RX examples relevant for MQ as well.
> =09- Explain that upon meeting the notification condition, the
> =09  device starts counting packets and microseconds again.
> =09- Add Parav's Reviewed-by tag (Thanks!)
>
>   device-types/net/description.tex | 74 +++++++++++++++++++-------------
>   1 file changed, 44 insertions(+), 30 deletions(-)
>
> diff --git a/device-types/net/description.tex b/device-types/net/descript=
ion.tex
> index 1741c79..c7a8ca6 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -1514,15 +1514,15 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
>   If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
>   send control commands for dynamically changing the coalescing parameter=
s.
>  =20
> -\begin{lstlisting}
> -struct virtio_net_ctrl_coal_rx {
> -    le32 rx_max_packets;
> -    le32 rx_usecs;
> -};
> +\begin{note}
> +The behavior of the device in response to these commands is best-effort:
> +the device may generate notifications more or less frequently than speci=
fied.
> +\end{note}
>  =20
> -struct virtio_net_ctrl_coal_tx {
> -    le32 tx_max_packets;
> -    le32 tx_usecs;
> +\begin{lstlisting}
> +struct virtio_net_ctrl_coal {
> +    le32 max_packets;
> +    le32 max_usecs;
>   };
>  =20
>   #define VIRTIO_NET_CTRL_NOTF_COAL 6
> @@ -1532,49 +1532,63 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
>  =20
>   Coalescing parameters:
>   \begin{itemize}
> -\item \field{rx_usecs}: Maximum number of usecs to delay a RX notificati=
on.
> -\item \field{tx_usecs}: Maximum number of usecs to delay a TX notificati=
on.
> -\item \field{rx_max_packets}: Maximum number of packets to receive befor=
e a RX notification.
> -\item \field{tx_max_packets}: Maximum number of packets to send before a=
 TX notification.
> +\item \field{max_usecs} for RX: Maximum number of microseconds to delay =
a RX notification.
> +\item \field{max_usecs} for TX: Maximum number of microseconds to delay =
a TX notification.
> +\item \field{max_packets} for RX: Maximum number of packets to receive b=
efore a RX notification.
> +\item \field{max_packets} for TX: Maximum number of packets to send befo=
re a TX notification.
>   \end{itemize}
>  =20
> -
>   The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
>   \begin{enumerate}
> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and \fi=
eld{tx_max_packets} parameters.
> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \fi=
eld{rx_max_packets} parameters.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and \f=
ield{max_packets} parameters for all the transmit virtqueues.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and \f=
ield{max_packets} parameters for all the receive virtqueues.
>   \end{enumerate}
>  =20
> -\subparagraph{RX Notifications}\label{sec:Device Types / Network Device =
/ Device Operation / Control Virtqueue / Notifications Coalescing / RX Noti=
fications}
> +\subparagraph{Operation}\label{sec:Device Types / Network Device / Devic=
e Operation / Control Virtqueue / Notifications Coalescing / Operation}
> +
> +The device sends a used buffer notification once the notification condit=
ions are met, if the notifications are not suppressed as explained in \ref{=
sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notifica=
tion Suppression}.
> +
> +When the device has non-zero \field{max_usecs} and non-zero \field{max_p=
ackets}, it starts counting microseconds and packets upon receiving/sending=
 a packet.
> +The device counts packets and microseconds for each receive virtqueue an=
d transmit virtqueue separately.
> +In this case, the notification conditions are met when \field{max_usecs}=
 microseconds elapses, or upon sending/receiving \field{max_packets} packet=
s, whichever happens first.
> +Afterwards, the device waits for the next packet and starts counting pac=
kets and microseconds again.
> +
> +When the device has \field{max_usecs} =3D 0 or \field{max_packets} =3D 0=
, the notification conditions are met after every packet received/sent.
> +
> +\subparagraph{RX Example}\label{sec:Device Types / Network Device / Devi=
ce Operation / Control Virtqueue / Notifications Coalescing / RX Example}
>  =20
>   If, for example:
>   \begin{itemize}
> -\item \field{rx_usecs} =3D 10.
> -\item \field{rx_max_packets} =3D 15.
> +\item \field{max_usecs} =3D 10.
> +\item \field{max_packets} =3D 15.
>   \end{itemize}
> -
> -The device will operate as follows:
> -
> +then each receive virtqueue of a device will operate as follows:
>   \begin{itemize}
> -\item The device will count received packets until it accumulates 15, or=
 until 10 usecs elapsed since the first one was received.
> +\item The device will count packets received on each virtqueue until it =
accumulates 15, or until 10 microseconds elapsed since the first one was re=
ceived.
>   \item If the notifications are not suppressed by the driver, the device=
 will send an used buffer notification, otherwise, the device will not send=
 an used buffer notification as long as the notifications are suppressed.
>   \end{itemize}
>  =20
> -\subparagraph{TX Notifications}\label{sec:Device Types / Network Device =
/ Device Operation / Control Virtqueue / Notifications Coalescing / TX Noti=
fications}
> +\subparagraph{TX Example}\label{sec:Device Types / Network Device / Devi=
ce Operation / Control Virtqueue / Notifications Coalescing / TX Example}
>  =20
>   If, for example:
>   \begin{itemize}
> -\item \field{tx_usecs} =3D 10.
> -\item \field{tx_max_packets} =3D 15.
> +\item \field{max_usecs} =3D 10.
> +\item \field{max_packets} =3D 15.
>   \end{itemize}
> -
> -The device will operate as follows:
> -
> +then each transmit virtqueue of a device will operate as follows:
>   \begin{itemize}
> -\item The device will count sent packets until it accumulates 15, or unt=
il 10 usecs elapsed since the first one was sent.
> +\item The device will count packets sent on each virtqueue until it accu=
mulates 15, or until 10 microseconds elapsed since the first one was sent.
>   \item If the notifications are not suppressed by the driver, the device=
 will send an used buffer notification, otherwise, the device will not send=
 an used buffer notification as long as the notifications are suppressed.
>   \end{itemize}
>  =20
> +\subparagraph{Notifications When Coalescing Parameters Change}\label{sec=
:Device Types / Network Device / Device Operation / Control Virtqueue / Not=
ifications Coalescing / Notifications When Coalescing Parameters Change}
> +
> +When the coalescing parameters of a device change, the device needs to c=
heck if the new notification conditions are met and send a used buffer noti=
fication if so.
> +
> +For example, \field{max_packets} =3D 15 for a device with a single trans=
mit virtqueue: if the device sends 10 packets and afterwards receives a
> +VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command with \field{max_packets} =3D 8,=
 then the notification condition is immediately considered to be met;
> +the device needs to immediately send a used buffer notification, if the =
notifications are not suppressed by the driver.
> +
>   \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types =
/ Network Device / Device Operation / Control Virtqueue / Notifications Coa=
lescing}
>  =20
>   If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driv=
er MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> @@ -1583,7 +1597,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
>  =20
>   A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with =
VIRTIO_NET_ERR if it was not able to change the parameters.
>  =20
> -A device SHOULD NOT send used buffer notifications to the driver, if the=
 notifications are suppressed as explained in \ref{sec:Basic Facilities of =
a Virtio Device / Virtqueues / Used Buffer Notification Suppression}, even =
if the coalescing counters expired.
> +A device SHOULD NOT send used buffer notifications to the driver if the =
notifications are suppressed, even if the notification conditions are met.
>  =20
>   Upon reset, a device MUST initialize all coalescing parameters to 0.
>  =20

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

