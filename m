Return-Path: <virtio-comment-return-4481-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <99c38bdc-de93-aa82-5fba-a94bb7711ed6@linux.alibaba.com>
Date: Thu, 23 Feb 2023 19:56:18 +0800
MIME-Version: 1.0
References: <20230222140632.10253-1-hengqi@linux.alibaba.com>
 <m2sfewd76r.fsf@oracle.com>
 <3e0d0bd0-b3e8-1616-7fd6-8a4a5a35e6db@linux.alibaba.com>
 <m27cw8d2k6.fsf@oracle.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <m27cw8d2k6.fsf@oracle.com>
Subject: Re: [virtio-comment] Re: [PATCH v7] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: David Edmondson <david.edmondson@oracle.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/23 =E4=B8=8B=E5=8D=887:43, David Edmondson =E5=86=99=E9=81=
=93:
> On Thursday, 2023-02-23 at 18:52:14 +08, Heng Qi wrote:
>> Hi, David.
>>
>> =E5=9C=A8 2023/2/23 =E4=B8=8B=E5=8D=886:05, David Edmondson =E5=86=99=E9=
=81=93:
>>> On Wednesday, 2023-02-22 at 22:06:32 +08, Heng Qi wrote:
>>>> Currently, coalescing parameters are grouped for all transmit and rece=
ive
>>>> virtqueues. This patch supports setting or getting the parameters for =
a
>>>> specified virtqueue, and a typical application of this function is net=
dim[1].
>>>>
>>>> When the traffic between virtqueues is unbalanced, for example, one vi=
rtqueue
>>>> is busy and another virtqueue is idle, then it will be very useful to
>>>> control coalescing parameters at the virtqueue granularity.
>>>>
>>>> [1] https://docs.kernel.org/networking/net_dim.html
>>>>
>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>> ---
>>>> This patch is on top of Alvaro's latest v7 patch: https://lists.oasis-=
open.org/archives/virtio-dev/202302/msg00431.html .
>>>>
>>>> v6->v7:
>>>>          1. Clarify the relationship of VIRTIO_NET_CTRL_NOTF_COAL_TX/R=
X_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET. @Alvaro Karsz, @Michael S. Tsir=
kin
>>>>          2. Remove formula for vqn range. @Parav Pandit
>>>>          3. Some expressions are clearer. @Parav Pandit, @Michael S. T=
sirkin
>>>>
>>>> v5->v6:
>>>>          1. Explain that the device may set a different value than the=
 one passed in by the driver. @David Edmondson
>>> A couple of things about this:
>>> - why say "a value close to a power of 2" - couldn't the device pick an=
y
>>>     value it chooses?
>> This is just a hint from the spec, it is "MAY", not "MUST" in the
>> conformance of the device, the device can still set any value it
>> receives.
> Okay.
>
>> And, since "virtqueue notification coalescing" feature will be used in
>> the netdim [1] algorithm,
>> and the coalescing moderation of netdim is roughly as follows, so it
>> is allowed to give the hint in the spec:
>> "
>> #define NET_DIM_RX_EQE_PROFILES { \
>> {.usec =3D 1, .pkts =3D NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
>> {.usec =3D 8, .pkts =3D NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
>> {.usec =3D 64, .pkts =3D NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
>> {.usec =3D 128, .pkts =3D NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
>> {.usec =3D 256, .pkts =3D NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,} \
>> }
>>
>> #define NET_DIM_RX_CQE_PROFILES { \
>> {.usec =3D 2, .pkts =3D 256,}, \
>> {.usec =3D 8, .pkts =3D 128,}, \
>> {.usec =3D 16, .pkts =3D 64,}, \
>> {.usec =3D 32, .pkts =3D 64,}, \
>> {.usec =3D 64, .pkts =3D 64,} \
>> }
>>
>> #define NET_DIM_TX_EQE_PROFILES { \
>> {.usec =3D 1, .pkts =3D NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,}, \
>> {.usec =3D 8, .pkts =3D NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,}, \
>> {.usec =3D 32, .pkts =3D NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,}, \
>> {.usec =3D 64, .pkts =3D NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,}, \
>> {.usec =3D 128, .pkts =3D NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,} \
>> }
>>
>> #define NET_DIM_TX_CQE_PROFILES { \
>> {.usec =3D 5, .pkts =3D 128,}, \
>> {.usec =3D 8, .pkts =3D 64,}, \
>> {.usec =3D 16, .pkts =3D 32,}, \
>> {.usec =3D 32, .pkts =3D 32,}, \
>> {.usec =3D 64, .pkts =3D 32,} \
>> }
>> "
>> [1]=C2=A0 https://docs.kernel.org/networking/net_dim.html
>>
>>> - I think that we need to be more explicit that the values passed in th=
e
>>>     SET request may not be honoured exactly.
>> Yes, there are already examples in the current spec:
>> "
>> +When a device receives a command of the VIRTIO_NET_CTRL_NOTF_COAL
>> class to set a coalescing parameter,
>> +it may set the parameter to a value close to a power of 2. For example:
>> +If the device receives \field{max_usecs} =3D 7 from the
>> VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command, it may set \field{max_usecs}
>> =3D 8 for a given enabled virtqueue.
>> "
>> If you find this unclear, do you need more examples or clarification,
>> or do you have a better way?
> Explicit is good:
>
> When a device receives a command of the VIRTIO_NET_CTRL_NOTF_COAL class
> to set a coalescing parameter it may choose to use a value different to
> that specified in the command, for example a power of two value close to
> the specified parameter. The value chosen by the device can be retrieved
> using the VIRTIO_NET_CTRL_NOTF_VQ_GET command.

Good advice, thanks! :)

>
>>> - should the chosen value be returned in the SET call? (Not too fussed
>>>     about this, though it may result in an implementation immediately
>>>     calling GET after SET to see what actually happened.)
>> As you said, I think we can just call GET to view.
>>
>>> - the example which shows how the global and per-VQ set operations
>>>     interact is reasonably worded ("the device responds with coalescing
>>>     parameters of virtqueue1 set by command5"), so that seems okay.
>> Yeah.
>>
>> Thanks.
>>
>>>> v4->v5:
>>>>          1. Add the correspondence between virtio_net_ctrl_coal and vi=
rtio_net_ctrl_coal_vq and control commands. @Michael S. Tsirkin
>>>>          2. Add read and write attributes for each field. @Michael S. =
Tsirkin
>>>>          3. A clearer description of how to set coalescing parameters =
for vq reset. @Michael S. Tsirkin
>>>>          4. Fix some syntax errors. @Michael S. Tsirkin, @David Edmond=
son
>>>>
>>>> v3->v4:
>>>>          1. Include virtio_net_ctrl_coal in the virtio_net_ctrl_coal_v=
q structure. @Alvaro Karsz
>>>>          2. Add consideration of vq reset. @Michael S. Tsirkin, @Parav=
 Pandit, @Alvaro Karsz
>>>>          3. Avoid too many examples by giving a comprehensive example.=
 @Michael S. Tsirkin
>>>>          4. Fix typos and streamline clarifications. @Michael S. Tsirk=
in, @Parav Pandit, @Alvaro Karsz
>>>>
>>>> v2->v3:
>>>>          1. Add the netdim link. @Parav Pandit
>>>>          2. VIRTIO_NET_F_VQ_NOTF_COAL no longer depends on VIRTIO_NET_=
F_NOTF_COAL. @Michael S. Tsirkin, @Alvaro Karsz
>>>>          3. _VQ_GET is explained more. @Michael S. Tsirkin
>>>>          4. Add more examples to avoid misunderstandings. @Michael S. =
Tsirkin
>>>>          5. Clarify some statements. @Michael S. Tsirkin, @Parav Pandi=
t, @Alvaro Karsz
>>>>          6. Adjust the virtio_net_ctrl_coal_vq structure. @Michael S. =
Tsirkin
>>>>          7. Fix some typos. @Michael S. Tsirkin
>>>>
>>>> v1->v2:
>>>>          1. Rename VIRTIO_NET_F_PERQUEUE_NOTF_COAL to VIRTIO_NET_F_VQ_=
NOTF_COAL. @Michael S. Tsirkin
>>>>          2. Use the \field{vqn} instead of the qid. @Michael S. Tsirki=
n
>>>>          3. Unify tx and rx control structres into one structure virti=
o_net_ctrl_coal_vq. @Michael S. Tsirkin
>>>>          4. Add a new control command VIRTIO_NET_CTRL_NOTF_COAL_VQ. @M=
ichael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>>>>          5. The special value 0xFFF is removed because VIRTIO_NET_CTRL=
_NOTF_COAL can be used. @Alvaro Karsz
>>>>          6. Clarify some special scenarios. @Michael S. Tsirkin, @Para=
v Pandit, @Alvaro Karsz
>>>>
>>>>    device-types/net/description.tex | 99 +++++++++++++++++++++++++++++=
+--
>>>>    1 file changed, 94 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/device-types/net/description.tex b/device-types/net/descr=
iption.tex
>>>> index e71e33b..745e4d9 100644
>>>> --- a/device-types/net/description.tex
>>>> +++ b/device-types/net/description.tex
>>>> @@ -83,6 +83,8 @@ \subsection{Feature bits}\label{sec:Device Types / N=
etwork Device / Feature bits
>>>>    \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through contr=
ol
>>>>        channel.
>>>>    +\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue
>>>> notification coalescing.
>>>> +
>>>>    \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coa=
lescing.
>>>>      \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4
>>>> packets.
>>>> @@ -139,6 +141,7 @@ \subsubsection{Feature bit requirements}\label{sec=
:Device Types / Network Device
>>>>    \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>>>    \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRT=
IO_NET_F_HOST_TSO6.
>>>>    \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>>>> +\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>>>    \end{description}
>>>>      \subsubsection{Legacy Interface: Feature bits}\label{sec:Device
>>>> Types / Network Device / Feature bits / Legacy Interface: Feature
>>>> bits}
>>>> @@ -1508,6 +1511,14 @@ \subsubsection{Control Virtqueue}\label{sec:Dev=
ice Types / Network Device / Devi
>>>>    If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
>>>>    send control commands for dynamically changing the coalescing param=
eters.
>>>>    +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated:
>>>> +\begin{itemize}
>>>> +\item a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command to=
 set coalescing parameters of a given
>>>> +      enabled transmit/receive virtqueue.
>>>> +\item a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command to=
 a device, and the device responds with
>>>> +      coalescing parameters of a given enabled transmit/receive virtq=
ueue.
>>>> +\end{itemize}
>>>> +
>>>>    \begin{note}
>>>>    The behavior of the device in response to these commands is best-ef=
fort:
>>>>    the device may generate notifications more or less frequently than =
specified.
>>>> @@ -1519,25 +1530,76 @@ \subsubsection{Control Virtqueue}\label{sec:De=
vice Types / Network Device / Devi
>>>>        le32 max_usecs;
>>>>    };
>>>>    +struct virtio_net_ctrl_coal_vq {
>>>> +    le16 vqn;
>>>> +    le16 reserved;
>>>> +    struct virtio_net_ctrl_coal coal;
>>>> +};
>>>> +
>>>>    #define VIRTIO_NET_CTRL_NOTF_COAL 6
>>>>     #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
>>>>     #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
>>>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
>>>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
>>>>    \end{lstlisting}
>>>>    +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
>>>> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands use the
>>>> +virtio_net_ctrl_coal structure to set \field{max_usecs} and \field{ma=
x_packets} for all
>>>> +transmit/receive virtqueues.
>>>> +
>>>> +The VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command uses the virtio_net_ctrl=
_coal_vq structure
>>>> +to set \field{max_usecs} and \field{max_packets} for the supplied vir=
tqueue number \field{vqn}.
>>>> +
>>>> +The VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command gets the values of \fiel=
d{max_usecs} and
>>>> +\field{max_packets} of the specified virtqueue from the device by set=
ting \field{vqn}
>>>> +in the virtio_net_ctrl_coal_vq structure.
>>>> +
>>>> +# Read/Write attributes for coalescing parameters
>>>> +\begin{itemize}
>>>> +\item For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CT=
RL_NOTF_COAL_RX_SET, \field{max_usecs}
>>>> +      and \field{max_packets} are write-only for a driver.
>>>> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, \field{vqn}, =
\field{reserved}, \field{max_usecs}
>>>> +      and \field{max_packets} are write-only for a driver.
>>>> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn} a=
nd \field{reserved} are write-only
>>>> +      for a driver, and, \field{max_usecs} and \field{max_packets} ar=
e read-only for the driver.
>>>> +\end{itemize}
>>>> +
>>>>    Coalescing parameters:
>>>>    \begin{itemize}
>>>> +\item \field{vqn}: The virtqueue number of an enabled transmit or rec=
eive virtqueue.
>>>>    \item \field{max_usecs} for RX: Maximum number of microseconds to d=
elay a RX notification.
>>>>    \item \field{max_usecs} for TX: Maximum number of microseconds to d=
elay a TX notification.
>>>>    \item \field{max_packets} for RX: Maximum number of packets to rece=
ive before a RX notification.
>>>>    \item \field{max_packets} for TX: Maximum number of packets to send=
 before a TX notification.
>>>>    \end{itemize}
>>>>    -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
>>>> +\field{reserved} is reserved and it is ignored by a device.
>>>> +
>>>> +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
>>>>    \begin{enumerate}
>>>> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and=
 \field{max_packets} parameters for all transmit virtqueues.
>>>> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and=
 \field{max_packets} parameters for all receive virtqueues.
>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_usecs} and=
 \field{max_packets} parameters for an enabled transmit/receive
>>>> +                                        virtqueue whose number is \fi=
eld{vqn}.
>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device returns the \field=
{max_usecs} and \field{max_packets} parameters for an enabled
>>>> +                                        transmit/receive virtqueue wh=
ose number is \field{vqn}.
>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: have the same effect of setti=
ng coalescing parameters as the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command re=
peated for
>>>> +                                        each virtqueue of transmitq1\=
ldots transmitqN.
>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: have the same effect of setti=
ng coalescing parameters as the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command re=
peated for
>>>> +                                        each virtqueue of receiveq1\l=
dots receiveqN.
>>>>    \end{enumerate}
>>>>    +If coalescing parameters are being set, the device applies the
>>>> last coalescing parameters received for a
>>>> +virtqueue, regardless of the command used to set the parameters. For =
example with 2 pairs of virtqueues:
>>>> +# Command sequence
>>>> +Each of the following commands sets \field{max_usecs} and \field{max_=
packets} parameters for virtqueues.
>>>> +\begin{itemize}
>>>> +\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing
>> parameters for virtqueue0 and virtqueue2, and, virtqueue1 and
>> virtqueue3 retain their previous parameter values.
>>>> +\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =3D=
 0 sets coalescing parameters for virtqueue0, and virtqueue2 retains the va=
lues from command1.
>>>> +\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} =3D=
 0, the device responds with coalescing parameters of virtqueue0 set by com=
mand2.
>>>> +\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =3D=
 1 sets coalescing parameters for virtqueue1, and virtqueue3 retains its pr=
evious values.
>>>> +\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing para=
meters for virtqueue1 and virtqueue3, and overrides the values set by comma=
nd4.
>>>> +\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} =3D=
 1, the device responds with coalescing parameters of virtqueue1 set by com=
mand5.
>>>> +\end{itemize}
>>>> +
>>>>    \subparagraph{Operation}\label{sec:Device Types / Network Device / =
Device Operation / Control Virtqueue / Notifications Coalescing / Operation=
}
>>>>      The device sends a used buffer notification once the
>>>> notification conditions are met and if the notifications are not
>>>> suppressed as explained in \ref{sec:Basic Facilities of a Virtio
>>>> Device / Virtqueues / Used Buffer Notification Suppression}.
>>>> @@ -1549,6 +1611,15 @@ \subsubsection{Control Virtqueue}\label{sec:Dev=
ice Types / Network Device / Devi
>>>>      When the device has \field{max_usecs} =3D 0 or
>>>> \field{max_packets} =3D 0, the notification conditions are met after
>>>> every packet received/sent.
>>>>    +When a device receives a command of the
>>>> VIRTIO_NET_CTRL_NOTF_COAL class to set a coalescing parameter,
>>>> +it may set the parameter to a value close to a power of 2. For exampl=
e:
>>>> +If the device receives \field{max_usecs} =3D 7 from the VIRTIO_NET_CT=
RL_NOTF_COAL_VQ_SET command, it may set \field{max_usecs} =3D 8 for a given=
 enabled virtqueue.
>>>> +
>>>> +When the device receives the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIR=
TIO_NET_CTRL_NOTF_COAL_RX_SET commands,
>>>> +it saves the values of coalescing parameters as global values, and th=
e VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command
>>>> +does not change the global values. If the device is reset, the global=
 values will be set to 0.
>>>> +When a virtqueue is enabled after virtqueue reset, its coalescing par=
ameters are set to global values.
>>>> +
>>>>    \subparagraph{RX Example}\label{sec:Device Types / Network Device /=
 Device Operation / Control Virtqueue / Notifications Coalescing / RX Examp=
le}
>>>>      If, for example:
>>>> @@ -1585,11 +1656,29 @@ \subsubsection{Control Virtqueue}\label{sec:De=
vice Types / Network Device / Devi
>>>>      \drivernormative{\subparagraph}{Notifications
>>>> Coalescing}{Device Types / Network Device / Device Operation /
>>>> Control Virtqueue / Notifications Coalescing}
>>>>    -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated,
>>>> the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
>>>> +If neither the VIRTIO_NET_F_NOTF_COAL nor the VIRTIO_NET_F_VQ_NOTF_CO=
AL feature
>>>> +has been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_C=
OAL commands.
>>>> +
>>>> +A driver MUST ignore the values of coalescing parameters received fro=
m the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if a device responds with VI=
RTIO_NET_ERR.
>>>>      \devicenormative{\subparagraph}{Notifications
>>>> Coalescing}{Device Types / Network Device / Device Operation /
>>>> Control Virtqueue / Notifications Coalescing}
>>>>    -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL
>>>> commands with VIRTIO_NET_ERR if it was not able to change the
>>>> parameters.
>>>> +A device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTI=
O_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it was not able=
 to change the parameters.
>>>> +
>>>> +A device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command=
 with VIRTIO_NET_ERR if it was not able to change the parameters.
>>>> +
>>>> +A device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO_=
NET_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if the given virtque=
ue is disabled.
>>>> +
>>>> +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX=
_SET commands set coalescing parameters for all transmit/receive
>>>> +virtqueues respectively and values of coalescing parameters are recor=
ded as global values by a device.
>>>> +The device MUST set the global values of coalescing parameters to 0 a=
fter being reset.
>>>> +The VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command sets the coalescing para=
meters for a given enabled virtqueue without changing the global values.
>>>> +
>>>> +After disabling and re-enabling a virtqueue, the device MUST revert c=
oalescing parameters of the virtqueue to the global values.
>>>> +
>>>> +A device MAY set the coalescing parameter to a value close to a power=
 of 2 value.
>>>> +
>>>> +A device MUST ignore \field{reserved}.
>>>>      A device SHOULD NOT send used buffer notifications to the
>>>> driver if the notifications are suppressed, even if the
>>>> notification conditions are met.
>>
>> This publicly archived list offers a means to provide input to the
>> OASIS Virtual I/O Device (VIRTIO) TC.
>>
>> In order to verify user consent to the Feedback License terms and
>> to minimize spam in the list archive, subscription is required
>> before posting.
>>
>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>> List help: virtio-comment-help@lists.oasis-open.org
>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pd=
f
>> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-=
lists
>> Committee: https://www.oasis-open.org/committees/virtio/
>> Join OASIS: https://www.oasis-open.org/join/


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

