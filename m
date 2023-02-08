Return-Path: <virtio-comment-return-4027-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <8008f51b-e7b7-b5c4-5e4b-2298acabe636@linux.alibaba.com>
Date: Wed, 8 Feb 2023 19:23:10 +0800
MIME-Version: 1.0
References: <20230207111634.75542-1-hengqi@linux.alibaba.com>
 <20230207090019-mutt-send-email-mst@kernel.org>
 <98c2cd3f-2f59-74e1-0b37-cbf2a9180bd4@linux.alibaba.com>
 <20230208045634-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230208045634-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [PATCH]
 virtio-net: support per-queue coalescing moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/8 =E4=B8=8B=E5=8D=886:04, Michael S. Tsirkin =E5=86=99=E9=
=81=93:
> On Wed, Feb 08, 2023 at 09:57:54AM +0800, Heng Qi wrote:
>>
>> =E5=9C=A8 2023/2/7 =E4=B8=8B=E5=8D=8810:06, Michael S. Tsirkin =E5=86=99=
=E9=81=93:
>>> On Tue, Feb 07, 2023 at 07:16:34PM +0800, Heng Qi wrote:
>>>> Currently, the coalescing profile is directly applied to all queues.
>>>> This patch supports configuring the parameters for a specified queue.
>>>>
>>>> When the traffic between queues is unbalanced, for example, one queue
>>>> is busy and another queue is idle, then it will be very useful to
>>>> control coalescing parameters at the queue granularity.
>>> ethtool does not support this though, does it? what's the plan?
>> Yes, ethtool does not support this function yet, and this function will =
not
>> conflict with ethool.
>> Our current goal is to let virtio-net support netdim first.
>>
>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> What I dislike about this interface is that if
>>> VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, then
>>> in the common case of same parameters for all queues
>>> driver has to issue multiple commands.
>>> I can see either a special vq index (0xffff ?) or a special
>>> command used to set it for all queues.
>>>
>>>
>>>> ---
>>>>    content.tex | 49 ++++++++++++++++++++++++++++++++++++++++++-------
>>>>    1 file changed, 42 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/content.tex b/content.tex
>>>> index e863709..049c0e4 100644
>>>> --- a/content.tex
>>>> +++ b/content.tex
>>>> @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types=
 / Network Device / Feature bits
>>>>    \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through contr=
ol
>>>>        channel.
>>>> +\item[VIRTIO_NET_F_PERQUEUE_NOTF_COAL(52)] Device supports per-queue
>>>> +=09notifications coalescing.
>>>> +
>>>>    \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coa=
lescing.
>>>>    \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packet=
s.
>>>> @@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label{s=
ec:Device Types / Network Device
>>>>    \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>>>    \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRT=
IO_NET_F_HOST_TSO6.
>>>>    \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>>>> +\item[VIRTIO_NET_F_PERQUEUE_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ =
and VIRTIO_NET_F_NOTF_COAL.
>>>>    \end{description}
>>>>    \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Typ=
es / Network Device / Feature bits / Legacy Interface: Feature bits}
>>>> @@ -4488,16 +4492,21 @@ \subsubsection{Control Virtqueue}\label{sec:De=
vice Types / Network Device / Devi
>>>>    If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
>>>>    send control commands for dynamically changing the coalescing param=
eters.
>>>> +If additionally VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, the dr=
iver
>>>> +can send control commands to configure the coalescing parameters of a
>>>> +specified receiveq or transmitq.
>>>>    \begin{lstlisting}
>>>>    struct virtio_net_ctrl_coal_rx {
>>>>        le32 rx_max_packets;
>>>>        le32 rx_usecs;
>>>> +    le16 rx_qid;  (Only if VIRTIO_NET_F_PERQUEUE_NOTF_COAL negotiated=
)
>>>>    };
>>>>    struct virtio_net_ctrl_coal_tx {
>>>>        le32 tx_max_packets;
>>>>        le32 tx_usecs;
>>>> +    le16 tx_qid;  (Only if VIRTIO_NET_F_PERQUEUE_NOTF_COAL negotiated=
)
>>>>    };
>>>>    #define VIRTIO_NET_CTRL_NOTF_COAL 6
>>> I think it's a good idea to do this on top of Alvaro's patch
>>> unifying these two structures.
>> I saw Alvaro's patch, but it doesn't seem to be stable yet, is there a g=
ood
>> way for me to
>> unify the two structures, since a patch should only do one thing.
>>
>>>> @@ -4507,17 +4516,34 @@ \subsubsection{Control Virtqueue}\label{sec:De=
vice Types / Network Device / Devi
>>>>    Coalescing parameters:
>>>>    \begin{itemize}
>>>> -\item \field{rx_usecs}: Maximum number of usecs to delay a RX notific=
ation.
>>>> -\item \field{tx_usecs}: Maximum number of usecs to delay a TX notific=
ation.
>>>> +\item \field{rx_qid}: Index of which receiveq to change the coalescin=
g parameters.
>>>> +=09If the value is between 0 and 0x7FFF, it represents the index of t=
he specified
>>>> +=09receiveq. Otherwise, if the value is 0xFFFF, it indicates to chang=
e the
>>>> +=09coalescing parameters for all receiveqs.
>>> what if the index does not map to a receive queue?
>> The spec mentioned
>> "A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with
>> VIRTIO_NET_ERR if it was not able to change the parameters.",
>> I think this belongs to this situation.
>>
>> Thanks.
> Maybe but it's worth calling out. Because another interpretation
> is that if qid matches rx queue we change rx parameters and
> if it matches tx queue we change tx parameters.
> There's a redundancy here I don't like different devices
> might handle the error differently.

Ok, I'll clarify here.

> Maybe a new command is better?

I agree, but there is one thing to confirm below.

>
> VIRTIO_NET_CTRL_NOTF_COAL_QUEUE_SET ?
>
> qid selects whether it's rx or tx.

I think the qid you expressed here should refer to the virtqueue id?
If qid represents the index of recieveq or transmitq, we can use=20
VIRTIO_NET_CTRL_NOTF_COAL_RX_QUEUE_SET and=20
VIRTIO_NET_CTRL_NOTF_COAL_TX_QUEUE_SET.

Which do you think is more suitable? I think the latter (qid means the=20
id of receiveq or transmitq) seems to be more aligned with the current spec=
?

>
> and then it's a natural thing with a feature bit controlling a new
> command. we have lots of examples like this.
>
>
> something we should also mention is that VIRTIO_NET_CTRL_NOTF_COAL_RX_SET
> is the same as calling VIRTIO_NET_CTRL_NOTF_COAL_QUEUE_SET
> for all RX queues.

Sure.

Thanks.

>
>>>> +\item \field{tx_qid}: Index of which transmitq to change the coalesci=
ng parameters.
>>>> +=09If the value is between 0 and 0x7FFF, it represents the index of t=
he specified
>>>> +=09transmitq. Otherwise, if the value is 0xFFFF, it indicates to chan=
ge the
>>>> +=09coalescing parameters for all transmitqs.
>>>> +\item \field{rx_usecs}: Maximum number of usecs to delay a RX notific=
ation. If additionally
>>>> +=09VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, it works for the sp=
ecified recieveq
>>>> +=09or all receieveqs.
>>>> +\item \field{tx_usecs}: Maximum number of usecs to delay a TX notific=
ation. If additionally
>>>> +=09VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, it works for the sp=
ecified transmitq
>>>> +=09or all transmitqs.
>>>>    \item \field{rx_max_packets}: Maximum number of packets to receive =
before a RX notification.
>>>> +=09If additionally VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, it =
works for the
>>>> +=09specified receiveq or all receiveqs.
>>>>    \item \field{tx_max_packets}: Maximum number of packets to send bef=
ore a TX notification.
>>>> +=09If additionally VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, it =
works for the
>>>> +=09specified transmitq or all transmitqs.
>>>>    \end{itemize}
>>>> -
>>>>    The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
>>>>    \begin{enumerate}
>>>> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and =
\field{tx_max_packets} parameters.
>>>> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and =
\field{rx_max_packets} parameters.
>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and =
\field{tx_max_packets} parameters,
>>>> +=09and set the \field{tx_qid} if VIRTIO_NET_F_PERQUEUE_NOTF_COAL is n=
egotiated.
>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and =
\field{rx_max_packets} parameters,
>>>> +=09and set the \field{rx_qid} if VIRTIO_NET_F_PERQUEUE_NOTF_COAL is n=
egotiated.
>>>>    \end{enumerate}
>>>>    \subparagraph{RX Notifications}\label{sec:Device Types / Network De=
vice / Device Operation / Control Virtqueue / Notifications Coalescing / RX=
 Notifications}
>>>> @@ -4531,7 +4557,11 @@ \subsubsection{Control Virtqueue}\label{sec:Dev=
ice Types / Network Device / Devi
>>>>    The device will operate as follows:
>>>>    \begin{itemize}
>>>> -\item The device will count received packets until it accumulates 15,=
 or until 10 usecs elapsed since the first one was received.
>>>> +\item The device will count received packets until it accumulates 15,=
 or until
>>>> +=0910 usecs elapsed since the first one was received. If additionally
>>>> +=09VIRTIO_NET_F_PERQUEUE_NOTF_COAL=09is negotiated: when \field{rx_qi=
d} is set
>>>> +=09to 0, the accumulation was only from the receiveq1; when \field{rx=
_qid} is
>>>> +=09set to 0xFFFF, the accumulation was from all receiveqs.
>>>>    \item If the notifications are not suppressed by the driver, the de=
vice will send an used buffer notification, otherwise, the device will not =
send an used buffer notification as long as the notifications are suppresse=
d.
>>>>    \end{itemize}
>>>> @@ -4546,7 +4576,12 @@ \subsubsection{Control Virtqueue}\label{sec:Dev=
ice Types / Network Device / Devi
>>>>    The device will operate as follows:
>>>>    \begin{itemize}
>>>> -\item The device will count sent packets until it accumulates 15, or =
until 10 usecs elapsed since the first one was sent.
>>>> +\item The device will count sent packets on the transmitq1 until it a=
ccumulates 15,
>>>> +=09or until 10 usecs elapsed since the first one was sent. If additio=
nally
>>>> +=09VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated: when \field{tx_qid}=
 is set
>>>> +=09to 0, the accumulation was only from the transmitq1; when \field{t=
x_qid} is
>>>> +=09set to 0xFFFF, the accumulation was from all transmitqs.
>>>> +
>>>>    \item If the notifications are not suppressed by the driver, the de=
vice will send an used buffer notification, otherwise, the device will not =
send an used buffer notification as long as the notifications are suppresse=
d.
>>>>    \end{itemize}
>>>> --=20
>>>> 2.19.1.6.gb485710b
>>>>
>>>>
>>>> This publicly archived list offers a means to provide input to the
>>>> OASIS Virtual I/O Device (VIRTIO) TC.
>>>>
>>>> In order to verify user consent to the Feedback License terms and
>>>> to minimize spam in the list archive, subscription is required
>>>> before posting.
>>>>
>>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>>>> List help: virtio-comment-help@lists.oasis-open.org
>>>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>>>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.=
pdf
>>>> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailin=
g-lists
>>>> Committee: https://www.oasis-open.org/committees/virtio/
>>>> Join OASIS: https://www.oasis-open.org/join/
>>> ---------------------------------------------------------------------
>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/


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

