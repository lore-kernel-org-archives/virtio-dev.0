Return-Path: <virtio-comment-return-4130-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <6a3dd0a1-d597-8e12-e0e5-0a8817e097b0@linux.alibaba.com>
Date: Fri, 10 Feb 2023 18:00:42 +0800
MIME-Version: 1.0
References: <20230210070130.21811-1-hengqi@linux.alibaba.com>
 <CAJs=3_BbbzsYApYkdeZ4+vTcZ9qE+4eG-yDJJ_ZW3vdJEn-drQ@mail.gmail.com>
 <20230210043631-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230210043631-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-comment] [PATCH v2] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/10 =E4=B8=8B=E5=8D=885:38, Michael S. Tsirkin =E5=86=99=E9=
=81=93:
> On Fri, Feb 10, 2023 at 11:22:14AM +0200, Alvaro Karsz wrote:
>> Thanks Heng.
>>
>>> Currently, the coalescing profile is directly applied to all queues.
>>> This patch supports setting or getting the parameters for a specified q=
ueue,
>>> and a typical application of this function is NetDIM.
>>>
>>> When the traffic between queues is unbalanced, for example, one queue
>>> is busy and another queue is idle, then it will be very useful to
>>> control coalescing parameters at the queue granularity.
>>>
>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> ---
>>> v1->v2:
>>>      1. Rename VIRTIO_NET_F_PERQUEUE_NOTF_COAL to VIRTIO_NET_F_VQ_NOTF_=
COAL. @Michael S. Tsirkin
>>>      2. Use the \field{vqn} instead of the qid. @Michael S. Tsirkin
>>>      3. Unify tx and rx control structres into one structure virtio_net=
_ctrl_coal_vq. @Michael S. Tsirkin
>>>      4. Add a new control command VIRTIO_NET_CTRL_NOTF_COAL_VQ. @Michae=
l S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>>>      5. The special value 0xFFF is removed because VIRTIO_NET_CTRL_NOTF=
_COAL can be used. @Alvaro Karsz
>>>      6. Clarify some special scenarios. @Michael S. Tsirkin, @Parav Pan=
dit, @Alvaro Karsz
>>>
>>>   content.tex | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
-
>>>   1 file changed, 68 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/content.tex b/content.tex
>>> index e863709..2c497e1 100644
>>> --- a/content.tex
>>> +++ b/content.tex
>>> @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types =
/ Network Device / Feature bits
>>>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>>>       channel.
>>>
>>> +\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports the virtqueue
>>> +    notifications coalescing.
>>> +
>>>   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coale=
scing.
>>>
>>>   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
>>> @@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label{se=
c:Device Types / Network Device
>>>   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO=
_NET_F_HOST_TSO6.
>>>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>>> +\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ and VIR=
TIO_NET_F_NOTF_COAL.
>>>   \end{description}
>>>
>> Do we need VIRTIO_NET_F_CTRL_VQ in this case?
>> VIRTIO_NET_F_VQ_NOTF_COAL requires VIRTIO_NET_F_NOTF_COAL, which
>> requires VIRTIO_NET_F_CTRL_VQ, so it's implied.
>>
>> We have a similar example with VIRTIO_NET_F_HOST_ECN, which requires
>> VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
>> VIRTIO_NET_F_CSUM is not mentioned here, although required.
>>
>> So, should we remove VIRTIO_NET_F_CTRL_VQ here, or fix VIRTIO_NET_F_HOST=
_ECN?
> Ah good point.
> But I think  VIRTIO_NET_F_VQ_NOTF_COAL should not depend on VIRTIO_NET_F_=
NOTF_COAL.
> This way devices can drop the all-rx/all-tx commands if they want to.

We need to confirm this. If we make VIRTIO_NET_F_VQ_NOTF_COAL=20
independent of VIRTIO_NET_F_NOTF_COAL,
do we need to give vqn a special value so that the driver can also have=20
the fast path of sending all queues with global settings via=20
VIRTIO_NET_F_VQ_NOTF_COAL?

Thanks.

>
>
>>>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types=
 / Network Device / Feature bits / Legacy Interface: Feature bits}
>>> @@ -4520,6 +4524,49 @@ \subsubsection{Control Virtqueue}\label{sec:Devi=
ce Types / Network Device / Devi
>>>   \item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and =
\field{rx_max_packets} parameters.
>>>   \end{enumerate}
>>>
>>> +If additionally VIRTIO_NET_F_VQ_NOTF_COAL is negotiated, the driver ca=
n send
>>> +control commands to set or get the coalescing parameters of a specifie=
d
>>> +virtqueue (excluding the control virtqueue).
>>> +
>>> +\begin{lstlisting}
>>> +struct virtio_net_ctrl_coal_vq {
>>> +    le32 max_packets;
>>> +    le32 usecs;
>>> +    le16 vqn;
>>> +};
>>> +
>>> +#define VIRTIO_NET_CTRL_NOTF_COAL_VQ 7
>>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 0
>>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 1
>>> +\end{lstlisting}
>>> +
>> We already have a notifications coalescing class, why not group all
>> coalescing commands under a single class?
> Agree here.
>
>>> +Virtqueue coalescing parameters:
>>> +\begin{itemize}
>>> +\item \field{max_packets}: The maximum number of packets sent/received=
 by the
>>> +    specified virtqueue before a TX/RX notification.
>>> +\item \field{usecs}: The maximum number of TX/RX usecs that the specif=
ied
>>> +    virtqueue delays a TX/RX notification.
>>> +\item \field{vqn}: The virtqueue number of the specified virtqueue.
>>> +\end{itemize}
>>> +
>>> +The range of \filed{vqn} is between 0 and 0xFFFF inclusive, $ \lfloor =
vqn / 2 \rfloor $
>>> +is the index of the corresponding receiveq, and $\lfloor (vqn / 2) + 1=
 \rfloor $ is
>>> +the corresponding tranmitq.
>>> +
>>> +The VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command is the same as calling VI=
RTIO_NET_CTRL_NOTF_COAL_VQ
>>> +for virtqueues corresponding to all receiveqs.
>>> +
>>> +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command is the same as calling VI=
RTIO_NET_CTRL_NOTF_COAL_VQ
>>> +for virtqueues corresponding to all transmitqs.
>>> +
>>> +Virtqueue coalescing will be disabled if all parameters are set to 0.
>>> +
>>> +The class VIRTIO_NET_CTRL_NOTF_COAL_VQ has 2 commands:
>>> +\begin{enumerate}
>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_packets}, \=
field{usecs} and \filed{vqn} parameters.
>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: get the \field{max_packets}, \=
field{usecs} and \field{vqn} parameters.
>>> +\end{enumerate}
>>> +
>>>   \subparagraph{RX Notifications}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue / Notifications Coalescing / RX N=
otifications}
>>>
>>>   If, for example:
>>> @@ -4535,6 +4582,15 @@ \subsubsection{Control Virtqueue}\label{sec:Devi=
ce Types / Network Device / Devi
>>>   \item If the notifications are not suppressed by the driver, the devi=
ce will send an used buffer notification, otherwise, the device will not se=
nd an used buffer notification as long as the notifications are suppressed.
>>>   \end{itemize}
>>>
>>> +If, example of setting coalescing parameters for a receive virtqueue:
>>> +\begin{itemize}
>>> +\item \field{max_packets} =3D 15.
>>> +\item \field{usecs} =3D 10.
>>> +\item \field{vqn} =3D 0;
>>> +\end{itemize}
>>> +
>>> +The device will only operate on recieveq1 as VIRTIO_NET_CTRL_NOTF_COAL=
_RX_SET.
>>> +
>>>   \subparagraph{TX Notifications}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue / Notifications Coalescing / TX N=
otifications}
>>>
>>>   If, for example:
>>> @@ -4550,13 +4606,24 @@ \subsubsection{Control Virtqueue}\label{sec:Dev=
ice Types / Network Device / Devi
>>>   \item If the notifications are not suppressed by the driver, the devi=
ce will send an used buffer notification, otherwise, the device will not se=
nd an used buffer notification as long as the notifications are suppressed.
>>>   \end{itemize}
>>>
>>> +If, example of setting coalescing parameters for a transmit virtqueue:
>>> +\begin{itemize}
>>> +\item \field{max_packets} =3D 15.
>>> +\item \field{usecs} =3D 10.
>>> +\item \field{vqn} =3D 1;
>>> +\end{itemize}
>>> +
>>> +The device will only operate on transmitq1 as VIRTIO_NET_CTRL_NOTF_COA=
L_TX_SET.
>>> +
>>>   \drivernormative{\subparagraph}{Notifications Coalescing}{Device Type=
s / Network Device / Device Operation / Control Virtqueue / Notifications C=
oalescing}
>>>
>>>   If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the dr=
iver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
>>> +If the VIRTIO_NET_F_VQ_NOTF_COAL feature has not been negotiated, the =
driver MUST NOT issue VIRTIO_NET_CTRL_NOFT_COAL_VQ commands.
>>>
>>>   \devicenormative{\subparagraph}{Notifications Coalescing}{Device Type=
s / Network Device / Device Operation / Control Virtqueue / Notifications C=
oalescing}
>>>
>>> -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with=
 VIRTIO_NET_ERR if it was not able to change the parameters.
>>> +A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with=
 VIRTIO_NET_ERR if it was not able to change the parameters or
>>> +was not able to find a virtqueue using the \field{vqn}.
>>>
>>>   A device SHOULD NOT send used buffer notifications to the driver, if =
the notifications are suppressed as explained in \ref{sec:Basic Facilities =
of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}, ev=
en if the coalescing counters expired.
>>>
>>> --
>>> 2.19.1.6.gb485710b
>>>
>>>
>>> This publicly archived list offers a means to provide input to the
>>> OASIS Virtual I/O Device (VIRTIO) TC.
>>>
>>> In order to verify user consent to the Feedback License terms and
>>> to minimize spam in the list archive, subscription is required
>>> before posting.
>>>
>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>>> List help: virtio-comment-help@lists.oasis-open.org
>>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.p=
df
>>> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing=
-lists
>>> Committee: https://www.oasis-open.org/committees/virtio/
>>> Join OASIS: https://www.oasis-open.org/join/
>>>


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

