Return-Path: <virtio-comment-return-4128-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <9548a959-f38e-ef90-002e-cf022ddf8e7e@linux.alibaba.com>
Date: Fri, 10 Feb 2023 17:53:40 +0800
MIME-Version: 1.0
References: <20230210070130.21811-1-hengqi@linux.alibaba.com>
 <20230210031041-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230210031041-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-comment] Re: [PATCH v2] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/10 =E4=B8=8B=E5=8D=884:38, Michael S. Tsirkin =E5=86=99=E9=
=81=93:
> On Fri, Feb 10, 2023 at 03:01:30PM +0800, Heng Qi wrote:
>> Currently, the coalescing profile is directly applied to all queues.
>> This patch supports setting or getting the parameters for a specified qu=
eue,
>> and a typical application of this function is NetDIM.
>>
>> When the traffic between queues is unbalanced, for example, one queue
>> is busy and another queue is idle, then it will be very useful to
>> control coalescing parameters at the queue granularity.
>>
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> I like this generally, thanks! Language needs to be tightened a bit.
>> ---
>> v1->v2:
>>      1. Rename VIRTIO_NET_F_PERQUEUE_NOTF_COAL to VIRTIO_NET_F_VQ_NOTF_C=
OAL. @Michael S. Tsirkin
>>      2. Use the \field{vqn} instead of the qid. @Michael S. Tsirkin
>>      3. Unify tx and rx control structres into one structure virtio_net_=
ctrl_coal_vq. @Michael S. Tsirkin
>>      4. Add a new control command VIRTIO_NET_CTRL_NOTF_COAL_VQ. @Michael=
 S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>>      5. The special value 0xFFF is removed because VIRTIO_NET_CTRL_NOTF_=
COAL can be used. @Alvaro Karsz
>>      6. Clarify some special scenarios. @Michael S. Tsirkin, @Parav Pand=
it, @Alvaro Karsz
>>
>>   content.tex | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 68 insertions(+), 1 deletion(-)
>>
>> diff --git a/content.tex b/content.tex
>> index e863709..2c497e1 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types /=
 Network Device / Feature bits
>>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>>       channel.
>>  =20
>> +\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports the virtqueue
>> +    notifications coalescing.
>> +
>>   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coales=
cing.
>>  =20
>>   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
>> @@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label{sec=
:Device Types / Network Device
>>   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_=
NET_F_HOST_TSO6.
>>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>> +\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ and VIRT=
IO_NET_F_NOTF_COAL.
>>   \end{description}
>>  =20
>>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types =
/ Network Device / Feature bits / Legacy Interface: Feature bits}
>> @@ -4520,6 +4524,49 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
>>   \item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \=
field{rx_max_packets} parameters.
>>   \end{enumerate}
>>  =20
>> +If additionally VIRTIO_NET_F_VQ_NOTF_COAL is negotiated, the driver can=
 send
>> +control commands to set or get the coalescing parameters of a specified
>> +virtqueue (excluding the control virtqueue).
>> +
>> +\begin{lstlisting}
>> +struct virtio_net_ctrl_coal_vq {
>> +    le32 max_packets;
>> +    le32 usecs;
>> +    le16 vqn;
> Add le16 reserved here, so keep things aligned naturally.
> In fact if you want to support GET you need to re-order things
> since write buffers come before read buffers:

I see, thanks for pointing it out.

>   +    le16 vqn;
>   +    le16 reserved;
>
>   +    le32 max_packets;
>   +    le32 usecs;
>
> see below for more explanation.
>
>
>
>> +};
>> +
>> +#define VIRTIO_NET_CTRL_NOTF_COAL_VQ 7
>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 0
>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 1
>> +\end{lstlisting}
>> +
>> +Virtqueue coalescing parameters:
>> +\begin{itemize}
>> +\item \field{max_packets}: The maximum number of packets sent/received =
by the
>> +    specified virtqueue before a TX/RX notification.
>> +\item \field{usecs}: The maximum number of TX/RX usecs that the specifi=
ed
>> +    virtqueue delays a TX/RX notification.
>> +\item \field{vqn}: The virtqueue number of the specified virtqueue.
>> +\end{itemize}
>> +
>> +The range of \filed{vqn} is between 0 and 0xFFFF inclusive,
>
> No really because last vq is a cvq. Maybe just drop this?

In fact I have ruled out the control virtqueue.

Its virtqueue number should be 0x10000.

>
>> $ \lfloor vqn / 2 \rfloor $
>> +is the index of the corresponding receiveq, and $\lfloor (vqn / 2) + 1 =
\rfloor $ is
>> +the corresponding tranmitq.
>> +
>> +The VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command is the same as calling VIR=
TIO_NET_CTRL_NOTF_COAL_VQ
> you don't "call" commands. driver sends them, device receives them.
> But here you are talking about a command abstracty so I'd just drop
> a verb, or maybe "repeating".
> And "same" is inexact in that it's not the same - takes more time - it
> just has the same effect, or is equivalent to.

There is indeed a gerund match here, I'll fix that.

>
>
>> +for virtqueues corresponding to all receiveqs.
> receiveqs is confusing.
>
> Also elsewhere we use the language receiveq1\ldots receiveqn
> which seems clearer. Also you can not call VIRTIO_NET_CTRL_NOTF_COAL_VQ
> for all vqs - it applies to one vq only. You mean each.

I express something wrong, but what I mean is to send for each virtqueue.

> And virtqueues do not correspond to receiveqs - they
> are receiveqs. If you like vqn corresponds to them.

This is ambiguous, the number of virtqueues is 2*N+1, the number of=20
receive queues and transmit queues is N,
and there is also a control queue. Is this a problem?
But I know what you mean it's better to use "same as=20
VIRTIO_NET_CTRL_NOTF_COAL_VQ repeated for each of receiveq1\ldots receiveqn=
"

> Or better just "same as VIRTIO_NET_CTRL_NOTF_COAL_VQ repeated for
> each of receiveq1\ldots receiveqn"

Sure.

>> +
>> +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command is the same as calling VIR=
TIO_NET_CTRL_NOTF_COAL_VQ
>> +for virtqueues corresponding to all transmitqs.
>> +
>> +Virtqueue coalescing will be disabled if all parameters are set to 0.
> In fact, either usecs 0 or max_packets disables coalescing, no?

Yes. I'll fix this.

>
>> +
>> +The class VIRTIO_NET_CTRL_NOTF_COAL_VQ has 2 commands:
>> +\begin{enumerate}
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_packets}, \f=
ield{usecs} and \filed{vqn} parameters.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: get the \field{max_packets}, \f=
ield{usecs} and \field{vqn} parameters.
> How does VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET work then? For which vq?
> I think you mean vqn is specified and you get back max_packets and
> usecs. All this needs to be documented fully for each command.

Yes, VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET gets the parameters of the=20
virtqueue corresponding to vqn each time.

>
> I would also think it's a good idea to mention that VQ_GET does not have
> to return exactly the same parameters - since it's best effort anyway,

This is confusing, I think the device does not have to set the same=20
parameters for VQ_SET, but for VQ_GET, the device should return to the=20
driver every time.

> it's ok for device to round down and store a smaller value for either
> max_packets or usecs, e.g. to save space.
>
> This kind of formalizes the best effort thing we discussed
> previously.
>
>
> Maybe make VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET a separate patch -
> in the series,

No problem, I'll try to describe it as best I can.

> at this point you did not make any effort to document it,
> it needs more work.
>
>
>> +\end{enumerate}
>> +
>>   \subparagraph{RX Notifications}\label{sec:Device Types / Network Devic=
e / Device Operation / Control Virtqueue / Notifications Coalescing / RX No=
tifications}
>>  =20
>>   If, for example:
>> @@ -4535,6 +4582,15 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
>>   \item If the notifications are not suppressed by the driver, the devic=
e will send an used buffer notification, otherwise, the device will not sen=
d an used buffer notification as long as the notifications are suppressed.
>>   \end{itemize}
>>  =20
>> +If, example of setting coalescing parameters for a receive virtqueue:
> "If" without "then" is confusing. I'd just start with "Example".

Ok.

>
>> +\begin{itemize}
>> +\item \field{max_packets} =3D 15.
>> +\item \field{usecs} =3D 10.
>> +\item \field{vqn} =3D 0;
> why . above and ; here? I would just drop punctuation.

It's a typo and I'll fix it.

>
>> +\end{itemize}
>> +
>> +The device will only operate on recieveq1 as VIRTIO_NET_CTRL_NOTF_COAL_=
RX_SET.
> This really does not explain anything. Please just document exactly what
> it does and does not do.

Ok.

>
>
>> +
>>   \subparagraph{TX Notifications}\label{sec:Device Types / Network Devic=
e / Device Operation / Control Virtqueue / Notifications Coalescing / TX No=
tifications}
>>  =20
>>   If, for example:
>> @@ -4550,13 +4606,24 @@ \subsubsection{Control Virtqueue}\label{sec:Devi=
ce Types / Network Device / Devi
>>   \item If the notifications are not suppressed by the driver, the devic=
e will send an used buffer notification, otherwise, the device will not sen=
d an used buffer notification as long as the notifications are suppressed.
>>   \end{itemize}
>>  =20
>> +If, example of setting coalescing parameters for a transmit virtqueue:
>> +\begin{itemize}
>> +\item \field{max_packets} =3D 15.
>> +\item \field{usecs} =3D 10.
>> +\item \field{vqn} =3D 1;
>> +\end{itemize}
>> +
>> +The device will only operate on transmitq1 as VIRTIO_NET_CTRL_NOTF_COAL=
_TX_SET.
>> +
> I feel it's the other way around. Document
>

Why? I'll add documentation, but read on below.

>
>>   \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types=
 / Network Device / Device Operation / Control Virtqueue / Notifications Co=
alescing}
>>  =20
>>   If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the dri=
ver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
>> +If the VIRTIO_NET_F_VQ_NOTF_COAL feature has not been negotiated, the d=
river MUST NOT issue VIRTIO_NET_CTRL_NOFT_COAL_VQ commands.
>>  =20
> Don't we want to limit driver to legal values of vqn?
>

Yes, I will add.

>>   \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types=
 / Network Device / Device Operation / Control Virtqueue / Notifications Co=
alescing}
>>  =20
>> -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with =
VIRTIO_NET_ERR if it was not able to change the parameters.
>> +A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with =
VIRTIO_NET_ERR if it was not able to change the parameters or
>> +was not able to find a virtqueue using the \field{vqn}.
> First please create multiple statements not a single long one.
> Second vqn only exists for per vq commands so create a statement
> just for that.

Ok, reasonable.

> Also more explicit please. What does this mean? I suspect that vq was not
> enabled?

Indicates that a vqn cannot be mapped to the corresponding virtqueue.

> Also, we MUST have vqn < max_virtqueue_pairs.

Here should be vq < max_virtqueue_pairs * 2?

Thanks.

>
>
>>  =20
>>   A device SHOULD NOT send used buffer notifications to the driver, if t=
he notifications are suppressed as explained in \ref{sec:Basic Facilities o=
f a Virtio Device / Virtqueues / Used Buffer Notification Suppression}, eve=
n if the coalescing counters expired.
>>  =20
>> --=20
>> 2.19.1.6.gb485710b
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

