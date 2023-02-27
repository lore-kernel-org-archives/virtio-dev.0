Return-Path: <virtio-dev-return-11314-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Message-ID: <1ba1c6ed-6a3f-21e6-dbb2-0f1a1ed9ca62@linux.alibaba.com>
Date: Mon, 27 Feb 2023 21:02:28 +0800
MIME-Version: 1.0
References: <20230226093724.44717-1-hengqi@linux.alibaba.com>
 <CAJs=3_CGcYc1dPv2x+U-vy7smGBQ3cGWNzi_D-KzpMT2RdVzrg@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CAJs=3_CGcYc1dPv2x+U-vy7smGBQ3cGWNzi_D-KzpMT2RdVzrg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v9] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>, David Edmondson <david.edmondson@oracle.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi, Alvaro.

=E5=9C=A8 2023/2/27 =E4=B8=8A=E5=8D=883:33, Alvaro Karsz =E5=86=99=E9=81=93=
:
>   Hi,
>
>> Currently, coalescing parameters are grouped for all transmit and receiv=
e
>> virtqueues. This patch supports setting or getting the parameters for a
>> specified virtqueue, and a typical application of this function is netdi=
m[1].
>>
>> When the traffic between virtqueues is unbalanced, for example, one virt=
queue
>> is busy and another virtqueue is idle, then it will be very useful to
>> control coalescing parameters at the virtqueue granularity.
>>
>> [1] https://docs.kernel.org/networking/net_dim.html
>>
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> ---
>> This patch is on top of Alvaro's latest v7 patch: https://lists.oasis-op=
en.org/archives/virtio-dev/202302/msg00431.html .
>>
>> v8->v9:
>>         1. Declare the commands that can be sent for each feature. @Alva=
ro Karsz
>>         2. Add information about "global values" in the command's explan=
ation. @Alvaro Karsz
>>
>> v7->v8:
>>         1. Use "best-effort" in Alvaro's patch instead of "the device ma=
y set the parameter to a value close to 2". @Michael S . Tsirkin, @David Ed=
mondson
>>
>> v6->v7:
>>         1. Clarify the relationship of VIRTIO_NET_CTRL_NOTF_COAL_TX/RX_S=
ET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET. @Alvaro Karsz, @Michael S. Tsirkin
>>         2. Remove the formula for vqn range. @Parav Pandit
>>         3. Some expressions are clearer. @Parav Pandit, @Michael S. Tsir=
kin
>>
>> v5->v6:
>>         1. Explain that the device may set a different value than the on=
e passed in by the driver. @David Edmondson
>>
>> v4->v5:
>>         1. Add the correspondence between virtio_net_ctrl_coal and virti=
o_net_ctrl_coal_vq and control commands. @Michael S. Tsirkin
>>         2. Add read and write attributes for each field. @Michael S. Tsi=
rkin
>>         3. A clearer description of how to set coalescing parameters for=
 vq reset. @Michael S. Tsirkin
>>         4. Fix some syntax errors. @Michael S. Tsirkin, @David Edmondson
>>
>> v3->v4:
>>         1. Include virtio_net_ctrl_coal in the virtio_net_ctrl_coal_vq s=
tructure. @Alvaro Karsz
>>         2. Add consideration of vq reset. @Michael S. Tsirkin, @Parav Pa=
ndit, @Alvaro Karsz
>>         3. Avoid too many examples by giving a comprehensive example. @M=
ichael S. Tsirkin
>>         4. Fix typos and streamline clarifications. @Michael S. Tsirkin,=
 @Parav Pandit, @Alvaro Karsz
>>
>> v2->v3:
>>         1. Add the netdim link. @Parav Pandit
>>         2. VIRTIO_NET_F_VQ_NOTF_COAL no longer depends on VIRTIO_NET_F_N=
OTF_COAL. @Michael S. Tsirkin, @Alvaro Karsz
>>         3. _VQ_GET is explained more. @Michael S. Tsirkin
>>         4. Add more examples to avoid misunderstandings. @Michael S. Tsi=
rkin
>>         5. Clarify some statements. @Michael S. Tsirkin, @Parav Pandit, =
@Alvaro Karsz
>>         6. Adjust the virtio_net_ctrl_coal_vq structure. @Michael S. Tsi=
rkin
>>         7. Fix some typos. @Michael S. Tsirkin
>>
>> v1->v2:
>>         1. Rename VIRTIO_NET_F_PERQUEUE_NOTF_COAL to VIRTIO_NET_F_VQ_NOT=
F_COAL. @Michael S. Tsirkin
>>         2. Use the \field{vqn} instead of the qid. @Michael S. Tsirkin
>>         3. Unify tx and rx control structures into one structure virtio_=
net_ctrl_coal_vq. @Michael S. Tsirkin
>>         4. Add a new control command VIRTIO_NET_CTRL_NOTF_COAL_VQ. @Mich=
ael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>>         5. The special value 0xFFF is removed because VIRTIO_NET_CTRL_NO=
TF_COAL can be used. @Alvaro Karsz
>>         6. Clarify some special scenarios. @Michael S. Tsirkin, @Parav P=
andit, @Alvaro Karsz
>>
>>   device-types/net/description.tex | 95 +++++++++++++++++++++++++++++---
>>   1 file changed, 87 insertions(+), 8 deletions(-)
>>
>> diff --git a/device-types/net/description.tex b/device-types/net/descrip=
tion.tex
>> index e71e33b..71f6827 100644
>> --- a/device-types/net/description.tex
>> +++ b/device-types/net/description.tex
>> @@ -83,6 +83,8 @@ \subsection{Feature bits}\label{sec:Device Types / Net=
work Device / Feature bits
>>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>>       channel.
>>
>> +\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notifica=
tion coalescing.
>> +
>>   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coales=
cing.
>>
>>   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
>> @@ -139,6 +141,7 @@ \subsubsection{Feature bit requirements}\label{sec:D=
evice Types / Network Device
>>   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_=
NET_F_HOST_TSO6.
>>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>> +\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>   \end{description}
>>
>>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types =
/ Network Device / Feature bits / Legacy Interface: Feature bits}
>> @@ -1505,8 +1508,17 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
>>
>>   \paragraph{Notifications Coalescing}\label{sec:Device Types / Network =
Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>>
>> -If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
>> -send control commands for dynamically changing the coalescing parameter=
s.
>> +If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can sen=
d the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
>> +and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands to dynamically change the=
 coalescing parameters for all transmit
>> +and receive virtqueues, respectively.
>> +
>> +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated:
>> +\begin{itemize}
>> +\item a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command to s=
et coalescing parameters of a given
>> +      enabled transmit/receive virtqueue.
>> +\item a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command to a=
 device, and the device responds with
>> +      coalescing parameters of a given enabled transmit/receive virtque=
ue.
>> +\end{itemize}
>>
> The VQ_NOTF_COAL commands are enclosed in an itemize and the NOTF_COAL
> commands aren't.
> I think that we should be consistent here.

The VQ commands are enclosed in an itemize because it has both GET and=20
SET operations.

I don't think VIRTIO_NET_CTRL_NOTF_COAL_RX_SET and=20
VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
have to do this, because they are both settings, just in different=20
directions, and we have described them like this elsewhere.

>
> I'm not sure that describing the commands in here is necessary, maybe
> just mentioning which commands can be used with which feature bit is

Isn't that what this sentence does?

> enough (this is what I meant in v8, sorry if I wasn't clear).
>
> I'm not saying that describing the commands in here is not good, but
> notice that the commands are described in 3 different places.

Three places describe different effects.

#1 describes which commands are available for which feature.
#2 describes which command can use which structure.
#3 describes which parameters can be set for each command, and whether=20
they can affect "global values".
It is placed in the "Operation" section because it explains how the=20
device should behave.

Maybe #1 and #2 descriptions can be combined and described together.

> This is #1.
>
>>   \begin{note}
>>   The behavior of the device in response to these commands is best-effor=
t:
>> @@ -1519,25 +1531,76 @@ \subsubsection{Control Virtqueue}\label{sec:Devi=
ce Types / Network Device / Devi
>>       le32 max_usecs;
>>   };
>>
>> +struct virtio_net_ctrl_coal_vq {
>> +    le16 vqn;
>> +    le16 reserved;
>> +    struct virtio_net_ctrl_coal coal;
>> +};
>> +
>>   #define VIRTIO_NET_CTRL_NOTF_COAL 6
>>    #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
>>    #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
>>   \end{lstlisting}
>>
>> +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_S=
ET commands use the
>> +virtio_net_ctrl_coal structure to set \field{max_usecs} and \field{max_=
packets} for all
>> +transmit/receive virtqueues.
>> +
>> +The VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command uses the virtio_net_ctrl_c=
oal_vq structure
>> +to set \field{max_usecs} and \field{max_packets} for the supplied virtq=
ueue number \field{vqn}.
>> +
>> +The VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command gets the values of \field{=
max_usecs} and
>> +\field{max_packets} of the specified virtqueue from the device by setti=
ng \field{vqn}
>> +in the virtio_net_ctrl_coal_vq structure.
>> +
> This is #2.
>
>> +# Read/Write attributes for coalescing parameters
>> +\begin{itemize}
>> +\item For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL=
_NOTF_COAL_RX_SET, \field{max_usecs}
>> +      and \field{max_packets} are write-only for a driver.
>> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, \field{vqn}, \f=
ield{reserved}, \field{max_usecs}
>> +      and \field{max_packets} are write-only for a driver.
>> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn} and=
 \field{reserved} are write-only
>> +      for a driver, and, \field{max_usecs} and \field{max_packets} are =
read-only for the driver.
>> +\end{itemize}
>> +
>>   Coalescing parameters:
>>   \begin{itemize}
>> +\item \field{vqn}: The virtqueue number of an enabled transmit or recei=
ve virtqueue.
>>   \item \field{max_usecs} for RX: Maximum number of microseconds to dela=
y a RX notification.
>>   \item \field{max_usecs} for TX: Maximum number of microseconds to dela=
y a TX notification.
>>   \item \field{max_packets} for RX: Maximum number of packets to receive=
 before a RX notification.
>>   \item \field{max_packets} for TX: Maximum number of packets to send be=
fore a TX notification.
>>   \end{itemize}
>>
>> -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
>> +\field{reserved} is reserved and it is ignored by a device.
>> +
>> +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
>>   \begin{enumerate}
>> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and \=
field{max_packets} parameters for all transmit virtqueues.
>> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and \=
field{max_packets} parameters for all receive virtqueues.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and \=
field{max_packets} parameters for all transmit virtqueues, and values of
>> +                                        coalescing parameters are recor=
ded as TX global values by a device.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and \=
field{max_packets} parameters for all receive virtqueues, and values of
>> +                                        coalescing parameters are recor=
ded as RX global values by a device.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_usecs} and \=
field{max_packets} parameters for an enabled transmit/receive
>> +                                        virtqueue whose number is \fiel=
d{vqn}, and do not change the TX/RX global values.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device returns the \field{m=
ax_usecs} and \field{max_packets} parameters for an enabled
>> +                                        transmit/receive virtqueue whos=
e number is \field{vqn}.
>>   \end{enumerate}
> This is #3.
>
>> +If coalescing parameters are being set, the device applies the last coa=
lescing parameters received for a
>> +virtqueue, regardless of the command used to set the parameters. For ex=
ample with 2 pairs of virtqueues:
>> +# Command sequence
>> +Each of the following commands sets \field{max_usecs} and \field{max_pa=
ckets} parameters for virtqueues.
>> +\begin{itemize}
>> +\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing parame=
ters for virtqueue0 and virtqueue2, and, virtqueue1 and virtqueue3 retain t=
heir previous parameter values.
>> +\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =3D 0=
 sets coalescing parameters for virtqueue0, and virtqueue2 retains the valu=
es from command1.
>> +\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} =3D 0=
, the device responds with coalescing parameters of virtqueue0 set by comma=
nd2.
>> +\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =3D 1=
 sets coalescing parameters for virtqueue1, and virtqueue3 retains its prev=
ious values.
>> +\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing parame=
ters for virtqueue1 and virtqueue3, and overrides the values set by command=
4.
>> +\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} =3D 1=
, the device responds with coalescing parameters of virtqueue1 set by comma=
nd5.
>> +\end{itemize}
>> +
>>   \subparagraph{Operation}\label{sec:Device Types / Network Device / Dev=
ice Operation / Control Virtqueue / Notifications Coalescing / Operation}
>>
>>   The device sends a used buffer notification once the notification cond=
itions are met and if the notifications are not suppressed as explained in =
\ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Not=
ification Suppression}.
>> @@ -1549,6 +1612,11 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
>>
>>   When the device has \field{max_usecs} =3D 0 or \field{max_packets} =3D=
 0, the notification conditions are met after every packet received/sent.
>>
>> +When the device receives the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTI=
O_NET_CTRL_NOTF_COAL_RX_SET commands,
>> +it saves the values of coalescing parameters as global values, and the =
VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command
>> +does not change the global values. If the device is reset, the global v=
alues will be set to 0.
>> +When a virtqueue is enabled after virtqueue reset, its coalescing param=
eters are set to global values.
>> +
> Maybe this explanation should be put closer to the commands
> descriptions, where the global coalescing parameters are mentioned for
> the first time.
> Something like:
> ....
> \item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device returns the
> \field{max_usecs} and \field{max_packets} parameters for an enabled
>                                 transmit/receive virtqueue whose number
> is \field{vqn}.
>
> The device maintains global coalescing parameters for TX and RX....

This is the "Operation" chapter, and the description of the operation is=20
more likely to be placed here, isn't it?



>
> And maybe we should use "global coalescing parameters" instead of
> "global values" (in devicenormative as well).
>
>>   \subparagraph{RX Example}\label{sec:Device Types / Network Device / De=
vice Operation / Control Virtqueue / Notifications Coalescing / RX Example}
>>
>>   If, for example:
>> @@ -1585,15 +1653,26 @@ \subsubsection{Control Virtqueue}\label{sec:Devi=
ce Types / Network Device / Devi
>>
>>   \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types=
 / Network Device / Device Operation / Control Virtqueue / Notifications Co=
alescing}
>>
>> -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driv=
er MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
>> +If neither the VIRTIO_NET_F_NOTF_COAL nor the VIRTIO_NET_F_VQ_NOTF_COAL=
 feature
>> +has been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COA=
L commands.
> Maybe this part can be splitted to:
> if the F1 feature has not been negotiated, the driver must not issue
> commands C1,C2.
> if the F2 feature has not been negotiated, the driver must not issue
> commands C3,C4.

Ok.

Thanks.

>> +
>> +A driver MUST ignore the values of coalescing parameters received from =
the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if a device responds with VIRT=
IO_NET_ERR.
>>
>>   \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types=
 / Network Device / Device Operation / Control Virtqueue / Notifications Co=
alescing}
>>
>> -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with =
VIRTIO_NET_ERR if it was not able to change the parameters.
>> +A device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_=
NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it was not able t=
o change the parameters.
>> +
>> +A device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command w=
ith VIRTIO_NET_ERR if it was not able to change the parameters.
>> +
>> +A device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_NE=
T_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if the given virtqueue=
 is disabled.
>> +
>> +A device MUST ignore \field{reserved}.
>>
>>   A device SHOULD NOT send used buffer notifications to the driver if th=
e notifications are suppressed, even if the notification conditions are met=
.
>>
>> -Upon reset, a device MUST initialize all coalescing parameters to 0.
>> +After disabling and re-enabling a virtqueue, the device MUST revert coa=
lescing parameters of the virtqueue to the global values.
>> +
>> +Upon reset, a device MUST initialize all coalescing parameters to 0 and=
 MUST set the global values to 0.
>>
>>   \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Devic=
e
>>   Types / Network Device / Legacy Interface: Framing Requirements}
>> --
> Let's wait for more comments before the next version, I guess some may
> not agree with my comments.
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

