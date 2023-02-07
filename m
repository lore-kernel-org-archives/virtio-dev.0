Return-Path: <virtio-comment-return-3975-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <efbd1f5a-8e85-295d-d790-d361c7f8129b@linux.alibaba.com>
Date: Tue, 7 Feb 2023 08:33:59 +0800
MIME-Version: 1.0
References: <20230206084746.40536-1-alvaro.karsz@solid-run.com>
 <PH0PR12MB54817FE12FD77CC74B36D136DCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230206160206-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818A5BD25527FEAEAFF6CCDCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB54818A5BD25527FEAEAFF6CCDCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: Re: [virtio-comment] RE: [virtio-dev] [PATCH] virtio-net: Fix and
 update VIRTIO_NET_F_NOTF_COAL feature
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/7 =E4=B8=8A=E5=8D=885:53, Parav Pandit =E5=86=99=E9=81=93:
>
>> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> =
On
>> Behalf Of Michael S. Tsirkin
>>
>> On Mon, Feb 06, 2023 at 07:13:43PM +0000, Parav Pandit wrote:
>>>
>>>> From: virtio-dev@lists.oasis-open.org
>>>> <virtio-dev@lists.oasis-open.org> On Behalf Of Alvaro Karsz
>>>>
>>>> This patch makes several improvements to the notification coalescing
>>>> feature,
>>>> including:
>>>>
>>>> - Consolidating virtio_net_ctrl_coal_tx and virtio_net_ctrl_coal_rx
>>>>    into a single struct, virtio_net_ctrl_coal, as they are identical.
>>>> - Emphasizing that the coalescing commands are best-effort.
>>>> - Defining the behavior of coalescing with regards to delivering
>>>>    notifications when a change occur.
>>>>
>>> Patch needs to do one thing at a time.
>>> Please split above into three patches.
>>>
>>>> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
>>>> ---
>>>>   device-types/net/description.tex | 40
>>>> ++++++++++++++++++--------------
>>>>   1 file changed, 22 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/device-types/net/description.tex
>>>> b/device-types/net/description.tex
>>>> index 1741c79..2a98411 100644
>>>> --- a/device-types/net/description.tex
>>>> +++ b/device-types/net/description.tex
>>>> @@ -1514,15 +1514,12 @@ \subsubsection{Control
>>>> Virtqueue}\label{sec:Device Types / Network Device / Devi  If the
>>>> VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can  send
>>>> control commands for dynamically changing the coalescing parameters.
>>>>
>>>> -\begin{lstlisting}
>>>> -struct virtio_net_ctrl_coal_rx {
>>>> -    le32 rx_max_packets;
>>>> -    le32 rx_usecs;
>>>> -};
>>>> +Note: In general, these commands are best-effort: A device could
>>>> +send a
>>>> notification even if it is not supposed to.
>>>>
>>> Please remove this note from this patch.
>>> Instead of Note, we need to describe this device requirements descripti=
on.
>>> We better need to describe the motivation for it.
>>> We may want to say there may be jitter in notification, but device shou=
ld not
>> be sending when it is not supposed to.
>>
>> It's explicitly allowed:
>>
>> split-ring.tex:The driver MUST handle spurious notifications from the de=
vice.
>> split-ring.tex:The device MUST handle spurious notifications from the dr=
iver.
>>
> The intent is the guide to device implementation to have less spurious in=
terrupts.
> Best effort wording says that device is free to implement timer of any gr=
anularity of choice, which kind of defeats the purpose of IM.
>
> So, both can handle/generate spurious notifications, but it shouldn't be =
best line guidance.
>
>>
>>> I also have more description to add in this area with regards to GSO an=
d LRO.
>>> I make humble suggestion that we draft is jointly in separate patch com=
bining
>> these clarifications.
>>>> -struct virtio_net_ctrl_coal_tx {
>>>> -    le32 tx_max_packets;
>>>> -    le32 tx_usecs;
>>>> +\begin{lstlisting}
>>>> +struct virtio_net_ctrl_coal {
>>>> +    le32 max_packets;
>>>> +    le32 usecs;
>>>>   };
>>>>
>>> This is one good change to go as separate patch.
>>>
>>>>   #define VIRTIO_NET_CTRL_NOTF_COAL 6 @@ -1532,25 +1529,25 @@
>>>> \subsubsection{Control Virtqueue}\label{sec:Device Types / Network
>>>> Device / Devi
>>>>
>>>>   Coalescing parameters:
>>>>   \begin{itemize}
>>>> -\item \field{rx_usecs}: Maximum number of usecs to delay a RX
>> notification.
>>>> -\item \field{tx_usecs}: Maximum number of usecs to delay a TX
>> notification.
>>>> -\item \field{rx_max_packets}: Maximum number of packets to receive
>>>> before a RX notification.
>>>> -\item \field{tx_max_packets}: Maximum number of packets to send
>>>> before a TX notification.
>>>> +\item \field{usecs} for RX: Maximum number of usecs to delay a RX
>>>> notification.
>>>> +\item \field{usecs} for TX: Maximum number of usecs to delay a TX
>>>> notification.
>>>> +\item \field{max_packets} for RX: Maximum number of packets to
>>>> +receive
>>>> before a RX notification.
>>>> +\item \field{max_packets} for TX: Maximum number of packets to send
>>>> +before
>>>> a TX notification.
>>>>   \end{itemize}
>>>>
>>> s/for Rx/For receive virtqueue
>>> s/for Tx/For transmit virtqueue
>> Which virtqueue? It says TX/RX pretty consistently in this text.
>> Changing to receive virtqueue/transmit virtqueue would be a big change a=
nd
>> frankly for a very modest gain in readability.
>> Rather maybe just say RX/TX where we describe virtqueue.
>>
> We are describing rest of the previous sections as transmitq, receiveq.
> Would like to keep this section consistent with rest of the Network devic=
e section, and not just notification coalescing section.
>
>>>>   The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
>>>>   \begin{enumerate}
>>>> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs}
>>>> and \field{tx_max_packets} parameters.
>>>> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs}
>>>> and \field{rx_max_packets} parameters.
>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{usecs} and
>>>> \field{max_packets} parameters for TX.
>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{usecs} and
>>>> \field{max_packets} parameters for RX.
>>>>   \end{enumerate}
>>>>
>>>>   \subparagraph{RX Notifications}\label{sec:Device Types / Network
>>>> Device / Device Operation / Control Virtqueue / Notifications
>>>> Coalescing / RX Notifications}
>>>>
>>>>   If, for example:
>>>>   \begin{itemize}
>>>> -\item \field{rx_usecs} =3D 10.
>>>> -\item \field{rx_max_packets} =3D 15.
>>>> +\item \field{usecs} =3D 10.
>>>> +\item \field{max_packets} =3D 15.
>>>>   \end{itemize}
>>>>
>>>>   The device will operate as follows:
>>>> @@ -1564,8 +1561,8 @@ \subsubsection{Control
>>>> Virtqueue}\label{sec:Device Types / Network Device / Devi
>>>>
>>>>   If, for example:
>>>>   \begin{itemize}
>>>> -\item \field{tx_usecs} =3D 10.
>>>> -\item \field{tx_max_packets} =3D 15.
>>>> +\item \field{usecs} =3D 10.
>>>> +\item \field{max_packets} =3D 15.
>>>>   \end{itemize}
>>>>
>>>>   The device will operate as follows:
>>>> @@ -1575,6 +1572,13 @@ \subsubsection{Control
>>>> Virtqueue}\label{sec:Device Types / Network Device / Devi  \item If
>>>> the notifications are not suppressed by the driver, the device will
>>>> send an used buffer notification, otherwise, the device will not
>>>> send an used buffer notification as long as the notifications are supp=
ressed.
>>>>   \end{itemize}
>>>>
>>>> +\subparagraph{Notifications When Coalescing Parameters
>>>> +Change}\label{sec:Device Types / Network Device / Device Operation
>>>> +/ Control Virtqueue / Notifications Coalescing / Notifications When
>>>> +Coalescing Parameters Change}
>>>> +
>>>> +When a device changes the coalescing parameters, the device needs
>>>> +to check
>>>> if the new parameters are met and issue a notification if so.
>>>> +
>>>> +For example, \field{max_packets} =3D 15 for TX.
>>>> +If the device sends 10 packets, then it receives a
>>>> VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command with
>> \field{max_packets} =3D
>>>> 8, the device needs to immediately send a TX notification, if the
>>>> notifications are not suppressed by the driver.
>>>> +
>>> Its better written as,
>>> When device applies new coalescing parameters, if the new parameters
>> already meet the current packet counters, device SHOULD generate immedia=
te
>> notification.
>>
>> what are packet counters though? they aren't defined anywhere.
>>
> Notification coalescing is counting packets in current text as " The devi=
ce will count sent packets until it accumulates 15 ..."
>
>>> For example, current \field{max_packets} is 15 for transmit virtqueue, =
and
>> device already sent 10 packets.
>>
>> I assume it is all per virtqueue? Makes sense but it does not actually s=
ay
>> anywhere.
>>
> Yes, it is per virtqueue because the coalescing commands are per virtqueu=
e.
> Not sure explicitly keep adding per virtqueue in every line improves the =
readability.

Oh, what a coincidence! We are working with our hardware team on NetDIM,
NetDIM needs to determine its own interrupt parameters based on the traffic
information of each queue, because it is not reasonable to use the=20
traffic of one
queue to determine the interrupt moderation profile of all queues.

We have preliminarily modified the virtio specification and will issue=20
it today
or tomorrow, please wait for review.

Thanks! :)

>
>>> When device receives a VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command,
>> the device SHOULD immediately send a TX notification.
>>
>> always? why?
> Ah no. not always. It was in the context of the example continuation.
>
> May be better to rewrite as,
>
> For example, current \field{max_packets} is 15 for the transmit virtqueue=
, and device already sent 10 packets; in such case when device receives a V=
IRTIO_NET_CTRL_NOTF_COAL_TX_SET command, the device SHOULD immediately send=
 a TX notification.
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

