Return-Path: <virtio-comment-return-4487-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <c395f443-2454-91a6-8707-7a1e89843da1@linux.alibaba.com>
Date: Thu, 23 Feb 2023 21:58:58 +0800
MIME-Version: 1.0
References: <20230222140632.10253-1-hengqi@linux.alibaba.com>
 <m2sfewd76r.fsf@oracle.com>
 <3e0d0bd0-b3e8-1616-7fd6-8a4a5a35e6db@linux.alibaba.com>
 <m27cw8d2k6.fsf@oracle.com> <20230223081813-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230223081813-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-comment] Re: [PATCH v7] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, David Edmondson <david.edmondson@oracle.com>
Cc: virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/23 =E4=B8=8B=E5=8D=889:20, Michael S. Tsirkin =E5=86=99=E9=
=81=93:
> On Thu, Feb 23, 2023 at 11:43:29AM +0000, David Edmondson wrote:
>> On Thursday, 2023-02-23 at 18:52:14 +08, Heng Qi wrote:
>>> Hi, David.
>>>
>>> =E5=9C=A8 2023/2/23 =E4=B8=8B=E5=8D=886:05, David Edmondson =E5=86=99=
=E9=81=93:
>>>> On Wednesday, 2023-02-22 at 22:06:32 +08, Heng Qi wrote:
>>>>> Currently, coalescing parameters are grouped for all transmit and rec=
eive
>>>>> virtqueues. This patch supports setting or getting the parameters for=
 a
>>>>> specified virtqueue, and a typical application of this function is ne=
tdim[1].
>>>>>
>>>>> When the traffic between virtqueues is unbalanced, for example, one v=
irtqueue
>>>>> is busy and another virtqueue is idle, then it will be very useful to
>>>>> control coalescing parameters at the virtqueue granularity.
>>>>>
>>>>> [1] https://docs.kernel.org/networking/net_dim.html
>>>>>
>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>>> ---
>>>>> This patch is on top of Alvaro's latest v7 patch: https://lists.oasis=
-open.org/archives/virtio-dev/202302/msg00431.html .
>>>>>
>>>>> v6->v7:
>>>>>          1. Clarify the relationship of VIRTIO_NET_CTRL_NOTF_COAL_TX/=
RX_SET and VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET. @Alvaro Karsz, @Michael S. Tsi=
rkin
>>>>>          2. Remove formula for vqn range. @Parav Pandit
>>>>>          3. Some expressions are clearer. @Parav Pandit, @Michael S. =
Tsirkin
>>>>>
>>>>> v5->v6:
>>>>>          1. Explain that the device may set a different value than th=
e one passed in by the driver. @David Edmondson
>>>> A couple of things about this:
>>>> - why say "a value close to a power of 2" - couldn't the device pick a=
ny
>>>>     value it chooses?
>>> This is just a hint from the spec, it is "MAY", not "MUST" in the
>>> conformance of the device, the device can still set any value it
>>> receives.
>> Okay.
>>
>>> And, since "virtqueue notification coalescing" feature will be used in
>>> the netdim [1] algorithm,
>>> and the coalescing moderation of netdim is roughly as follows, so it
>>> is allowed to give the hint in the spec:
>>> "
>>> #define NET_DIM_RX_EQE_PROFILES { \
>>> {.usec =3D 1, .pkts =3D NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
>>> {.usec =3D 8, .pkts =3D NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
>>> {.usec =3D 64, .pkts =3D NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
>>> {.usec =3D 128, .pkts =3D NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,}, \
>>> {.usec =3D 256, .pkts =3D NET_DIM_DEFAULT_RX_CQ_PKTS_FROM_EQE,} \
>>> }
>>>
>>> #define NET_DIM_RX_CQE_PROFILES { \
>>> {.usec =3D 2, .pkts =3D 256,}, \
>>> {.usec =3D 8, .pkts =3D 128,}, \
>>> {.usec =3D 16, .pkts =3D 64,}, \
>>> {.usec =3D 32, .pkts =3D 64,}, \
>>> {.usec =3D 64, .pkts =3D 64,} \
>>> }
>>>
>>> #define NET_DIM_TX_EQE_PROFILES { \
>>> {.usec =3D 1, .pkts =3D NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,}, \
>>> {.usec =3D 8, .pkts =3D NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,}, \
>>> {.usec =3D 32, .pkts =3D NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,}, \
>>> {.usec =3D 64, .pkts =3D NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,}, \
>>> {.usec =3D 128, .pkts =3D NET_DIM_DEFAULT_TX_CQ_PKTS_FROM_EQE,} \
>>> }
>>>
>>> #define NET_DIM_TX_CQE_PROFILES { \
>>> {.usec =3D 5, .pkts =3D 128,}, \
>>> {.usec =3D 8, .pkts =3D 64,}, \
>>> {.usec =3D 16, .pkts =3D 32,}, \
>>> {.usec =3D 32, .pkts =3D 32,}, \
>>> {.usec =3D 64, .pkts =3D 32,} \
>>> }
>>> "
>>> [1]=C2=A0 https://docs.kernel.org/networking/net_dim.html
>>>
>>>> - I think that we need to be more explicit that the values passed in t=
he
>>>>     SET request may not be honoured exactly.
>>> Yes, there are already examples in the current spec:
>>> "
>>> +When a device receives a command of the VIRTIO_NET_CTRL_NOTF_COAL
>>> class to set a coalescing parameter,
>>> +it may set the parameter to a value close to a power of 2. For example=
:
>>> +If the device receives \field{max_usecs} =3D 7 from the
>>> VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command, it may set \field{max_usecs}
>>> =3D 8 for a given enabled virtqueue.
>>> "
>>> If you find this unclear, do you need more examples or clarification,
>>> or do you have a better way?
>> Explicit is good:
>>
>> When a device receives a command of the VIRTIO_NET_CTRL_NOTF_COAL class
>> to set a coalescing parameter it may choose to use a value different to
>> that specified in the command, for example a power of two value close to
>> the specified parameter.
>
> Hmm. This clarification actually belongs in Alvaro's patch btw, no?
> Basically with the best-effort sentence.


Indeed, considering my patch is on top of Alvaro's patch and this=20
description in his patch seems to contain what we now want to express=20
"the device may set a different value":
=E2=80=9CThe behavior of the device in response to these commands is=20
best-effort: the device may generate notifications more or less=20
frequently than specified.=E2=80=9D

Maybe, do we need to add this to my patch?
"
When a device receives a command of class VIRTIO_NET_CTRL_NOTF_COAL to=20
set or respond to a coalescing parameter, it behaves on a best-effort=20
basis. For example:
If a device receives \field{max_usecs} =3D 7 from a=20
VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command, it may set \field{max_usecs} =3D=
=20
8 for a given enabled virtqueue.
Then the device receives the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,=20
it may respond with \field{max_usecs} =3D 8 for the virtqueue.
"
If the example is dropped, there is no difference with Alvaro's=20
expression, and we can delete the description about "close to a power of=20
2" in my patch.

Or, use the description below?
"
When a device receives a command of the VIRTIO_NET_CTRL_NOTF_COAL class=20
to set a coalescing parameter, it may choose to use a value different to=20
that specified in the command.
The value chosen by the device can be retrieved using the=20
VIRTIO_NET_CTRL_NOTF_VQ_GET command. For example:
If a device receives \field{max_usecs} =3D 7 from a=20
VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command, it may set \field{max_usecs} =3D=
=20
8 for a given enabled virtqueue.
Then the device receives the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,=20
it may respond with \field{max_usecs} =3D 8 for the virtqueue.
"
If we don't want the example of this description, we can also drop it=20
and keep only the others.

Thanks :)

>
>> The value chosen by the device can be retrieved
>> using the VIRTIO_NET_CTRL_NOTF_VQ_GET command.
> I do however feel that maybe we should not allow any value.
> Values lower than what is specified are definitely ok.
>
>
>>>> - should the chosen value be returned in the SET call? (Not too fussed
>>>>     about this, though it may result in an implementation immediately
>>>>     calling GET after SET to see what actually happened.)
>>> As you said, I think we can just call GET to view.
>>>
>>>> - the example which shows how the global and per-VQ set operations
>>>>     interact is reasonably worded ("the device responds with coalescin=
g
>>>>     parameters of virtqueue1 set by command5"), so that seems okay.
>>> Yeah.
>>>
>>> Thanks.
>>>
>>>>> v4->v5:
>>>>>          1. Add the correspondence between virtio_net_ctrl_coal and v=
irtio_net_ctrl_coal_vq and control commands. @Michael S. Tsirkin
>>>>>          2. Add read and write attributes for each field. @Michael S.=
 Tsirkin
>>>>>          3. A clearer description of how to set coalescing parameters=
 for vq reset. @Michael S. Tsirkin
>>>>>          4. Fix some syntax errors. @Michael S. Tsirkin, @David Edmon=
dson
>>>>>
>>>>> v3->v4:
>>>>>          1. Include virtio_net_ctrl_coal in the virtio_net_ctrl_coal_=
vq structure. @Alvaro Karsz
>>>>>          2. Add consideration of vq reset. @Michael S. Tsirkin, @Para=
v Pandit, @Alvaro Karsz
>>>>>          3. Avoid too many examples by giving a comprehensive example=
. @Michael S. Tsirkin
>>>>>          4. Fix typos and streamline clarifications. @Michael S. Tsir=
kin, @Parav Pandit, @Alvaro Karsz
>>>>>
>>>>> v2->v3:
>>>>>          1. Add the netdim link. @Parav Pandit
>>>>>          2. VIRTIO_NET_F_VQ_NOTF_COAL no longer depends on VIRTIO_NET=
_F_NOTF_COAL. @Michael S. Tsirkin, @Alvaro Karsz
>>>>>          3. _VQ_GET is explained more. @Michael S. Tsirkin
>>>>>          4. Add more examples to avoid misunderstandings. @Michael S.=
 Tsirkin
>>>>>          5. Clarify some statements. @Michael S. Tsirkin, @Parav Pand=
it, @Alvaro Karsz
>>>>>          6. Adjust the virtio_net_ctrl_coal_vq structure. @Michael S.=
 Tsirkin
>>>>>          7. Fix some typos. @Michael S. Tsirkin
>>>>>
>>>>> v1->v2:
>>>>>          1. Rename VIRTIO_NET_F_PERQUEUE_NOTF_COAL to VIRTIO_NET_F_VQ=
_NOTF_COAL. @Michael S. Tsirkin
>>>>>          2. Use the \field{vqn} instead of the qid. @Michael S. Tsirk=
in
>>>>>          3. Unify tx and rx control structres into one structure virt=
io_net_ctrl_coal_vq. @Michael S. Tsirkin
>>>>>          4. Add a new control command VIRTIO_NET_CTRL_NOTF_COAL_VQ. @=
Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>>>>>          5. The special value 0xFFF is removed because VIRTIO_NET_CTR=
L_NOTF_COAL can be used. @Alvaro Karsz
>>>>>          6. Clarify some special scenarios. @Michael S. Tsirkin, @Par=
av Pandit, @Alvaro Karsz
>>>>>
>>>>>    device-types/net/description.tex | 99 ++++++++++++++++++++++++++++=
++--
>>>>>    1 file changed, 94 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/device-types/net/description.tex b/device-types/net/desc=
ription.tex
>>>>> index e71e33b..745e4d9 100644
>>>>> --- a/device-types/net/description.tex
>>>>> +++ b/device-types/net/description.tex
>>>>> @@ -83,6 +83,8 @@ \subsection{Feature bits}\label{sec:Device Types / =
Network Device / Feature bits
>>>>>    \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through cont=
rol
>>>>>        channel.
>>>>>    +\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue
>>>>> notification coalescing.
>>>>> +
>>>>>    \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications co=
alescing.
>>>>>      \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4
>>>>> packets.
>>>>> @@ -139,6 +141,7 @@ \subsubsection{Feature bit requirements}\label{se=
c:Device Types / Network Device
>>>>>    \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>>>>    \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIR=
TIO_NET_F_HOST_TSO6.
>>>>>    \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>>>>> +\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>>>>    \end{description}
>>>>>      \subsubsection{Legacy Interface: Feature bits}\label{sec:Device
>>>>> Types / Network Device / Feature bits / Legacy Interface: Feature
>>>>> bits}
>>>>> @@ -1508,6 +1511,14 @@ \subsubsection{Control Virtqueue}\label{sec:De=
vice Types / Network Device / Devi
>>>>>    If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver ca=
n
>>>>>    send control commands for dynamically changing the coalescing para=
meters.
>>>>>    +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated:
>>>>> +\begin{itemize}
>>>>> +\item a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command t=
o set coalescing parameters of a given
>>>>> +      enabled transmit/receive virtqueue.
>>>>> +\item a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command t=
o a device, and the device responds with
>>>>> +      coalescing parameters of a given enabled transmit/receive virt=
queue.
>>>>> +\end{itemize}
>>>>> +
>>>>>    \begin{note}
>>>>>    The behavior of the device in response to these commands is best-e=
ffort:
>>>>>    the device may generate notifications more or less frequently than=
 specified.
>>>>> @@ -1519,25 +1530,76 @@ \subsubsection{Control Virtqueue}\label{sec:D=
evice Types / Network Device / Devi
>>>>>        le32 max_usecs;
>>>>>    };
>>>>>    +struct virtio_net_ctrl_coal_vq {
>>>>> +    le16 vqn;
>>>>> +    le16 reserved;
>>>>> +    struct virtio_net_ctrl_coal coal;
>>>>> +};
>>>>> +
>>>>>    #define VIRTIO_NET_CTRL_NOTF_COAL 6
>>>>>     #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
>>>>>     #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
>>>>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
>>>>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
>>>>>    \end{lstlisting}
>>>>>    +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
>>>>> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands use the
>>>>> +virtio_net_ctrl_coal structure to set \field{max_usecs} and \field{m=
ax_packets} for all
>>>>> +transmit/receive virtqueues.
>>>>> +
>>>>> +The VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command uses the virtio_net_ctr=
l_coal_vq structure
>>>>> +to set \field{max_usecs} and \field{max_packets} for the supplied vi=
rtqueue number \field{vqn}.
>>>>> +
>>>>> +The VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command gets the values of \fie=
ld{max_usecs} and
>>>>> +\field{max_packets} of the specified virtqueue from the device by se=
tting \field{vqn}
>>>>> +in the virtio_net_ctrl_coal_vq structure.
>>>>> +
>>>>> +# Read/Write attributes for coalescing parameters
>>>>> +\begin{itemize}
>>>>> +\item For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_C=
TRL_NOTF_COAL_RX_SET, \field{max_usecs}
>>>>> +      and \field{max_packets} are write-only for a driver.
>>>>> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, \field{vqn},=
 \field{reserved}, \field{max_usecs}
>>>>> +      and \field{max_packets} are write-only for a driver.
>>>>> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn} =
and \field{reserved} are write-only
>>>>> +      for a driver, and, \field{max_usecs} and \field{max_packets} a=
re read-only for the driver.
>>>>> +\end{itemize}
>>>>> +
>>>>>    Coalescing parameters:
>>>>>    \begin{itemize}
>>>>> +\item \field{vqn}: The virtqueue number of an enabled transmit or re=
ceive virtqueue.
>>>>>    \item \field{max_usecs} for RX: Maximum number of microseconds to =
delay a RX notification.
>>>>>    \item \field{max_usecs} for TX: Maximum number of microseconds to =
delay a TX notification.
>>>>>    \item \field{max_packets} for RX: Maximum number of packets to rec=
eive before a RX notification.
>>>>>    \item \field{max_packets} for TX: Maximum number of packets to sen=
d before a TX notification.
>>>>>    \end{itemize}
>>>>>    -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
>>>>> +\field{reserved} is reserved and it is ignored by a device.
>>>>> +
>>>>> +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
>>>>>    \begin{enumerate}
>>>>> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} an=
d \field{max_packets} parameters for all transmit virtqueues.
>>>>> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} an=
d \field{max_packets} parameters for all receive virtqueues.
>>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_usecs} an=
d \field{max_packets} parameters for an enabled transmit/receive
>>>>> +                                        virtqueue whose number is \f=
ield{vqn}.
>>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device returns the \fiel=
d{max_usecs} and \field{max_packets} parameters for an enabled
>>>>> +                                        transmit/receive virtqueue w=
hose number is \field{vqn}.
>>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: have the same effect of sett=
ing coalescing parameters as the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command r=
epeated for
>>>>> +                                        each virtqueue of transmitq1=
\ldots transmitqN.
>>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: have the same effect of sett=
ing coalescing parameters as the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command r=
epeated for
>>>>> +                                        each virtqueue of receiveq1\=
ldots receiveqN.
>>>>>    \end{enumerate}
>>>>>    +If coalescing parameters are being set, the device applies the
>>>>> last coalescing parameters received for a
>>>>> +virtqueue, regardless of the command used to set the parameters. For=
 example with 2 pairs of virtqueues:
>>>>> +# Command sequence
>>>>> +Each of the following commands sets \field{max_usecs} and \field{max=
_packets} parameters for virtqueues.
>>>>> +\begin{itemize}
>>>>> +\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing
>>> parameters for virtqueue0 and virtqueue2, and, virtqueue1 and
>>> virtqueue3 retain their previous parameter values.
>>>>> +\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =
=3D 0 sets coalescing parameters for virtqueue0, and virtqueue2 retains the=
 values from command1.
>>>>> +\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} =
=3D 0, the device responds with coalescing parameters of virtqueue0 set by =
command2.
>>>>> +\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =
=3D 1 sets coalescing parameters for virtqueue1, and virtqueue3 retains its=
 previous values.
>>>>> +\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing par=
ameters for virtqueue1 and virtqueue3, and overrides the values set by comm=
and4.
>>>>> +\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} =
=3D 1, the device responds with coalescing parameters of virtqueue1 set by =
command5.
>>>>> +\end{itemize}
>>>>> +
>>>>>    \subparagraph{Operation}\label{sec:Device Types / Network Device /=
 Device Operation / Control Virtqueue / Notifications Coalescing / Operatio=
n}
>>>>>      The device sends a used buffer notification once the
>>>>> notification conditions are met and if the notifications are not
>>>>> suppressed as explained in \ref{sec:Basic Facilities of a Virtio
>>>>> Device / Virtqueues / Used Buffer Notification Suppression}.
>>>>> @@ -1549,6 +1611,15 @@ \subsubsection{Control Virtqueue}\label{sec:De=
vice Types / Network Device / Devi
>>>>>      When the device has \field{max_usecs} =3D 0 or
>>>>> \field{max_packets} =3D 0, the notification conditions are met after
>>>>> every packet received/sent.
>>>>>    +When a device receives a command of the
>>>>> VIRTIO_NET_CTRL_NOTF_COAL class to set a coalescing parameter,
>>>>> +it may set the parameter to a value close to a power of 2. For examp=
le:
>>>>> +If the device receives \field{max_usecs} =3D 7 from the VIRTIO_NET_C=
TRL_NOTF_COAL_VQ_SET command, it may set \field{max_usecs} =3D 8 for a give=
n enabled virtqueue.
>>>>> +
>>>>> +When the device receives the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VI=
RTIO_NET_CTRL_NOTF_COAL_RX_SET commands,
>>>>> +it saves the values of coalescing parameters as global values, and t=
he VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command
>>>>> +does not change the global values. If the device is reset, the globa=
l values will be set to 0.
>>>>> +When a virtqueue is enabled after virtqueue reset, its coalescing pa=
rameters are set to global values.
>>>>> +
>>>>>    \subparagraph{RX Example}\label{sec:Device Types / Network Device =
/ Device Operation / Control Virtqueue / Notifications Coalescing / RX Exam=
ple}
>>>>>      If, for example:
>>>>> @@ -1585,11 +1656,29 @@ \subsubsection{Control Virtqueue}\label{sec:D=
evice Types / Network Device / Devi
>>>>>      \drivernormative{\subparagraph}{Notifications
>>>>> Coalescing}{Device Types / Network Device / Device Operation /
>>>>> Control Virtqueue / Notifications Coalescing}
>>>>>    -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated,
>>>>> the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
>>>>> +If neither the VIRTIO_NET_F_NOTF_COAL nor the VIRTIO_NET_F_VQ_NOTF_C=
OAL feature
>>>>> +has been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_=
COAL commands.
>>>>> +
>>>>> +A driver MUST ignore the values of coalescing parameters received fr=
om the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if a device responds with V=
IRTIO_NET_ERR.
>>>>>      \devicenormative{\subparagraph}{Notifications
>>>>> Coalescing}{Device Types / Network Device / Device Operation /
>>>>> Control Virtqueue / Notifications Coalescing}
>>>>>    -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL
>>>>> commands with VIRTIO_NET_ERR if it was not able to change the
>>>>> parameters.
>>>>> +A device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRT=
IO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it was not abl=
e to change the parameters.
>>>>> +
>>>>> +A device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET comman=
d with VIRTIO_NET_ERR if it was not able to change the parameters.
>>>>> +
>>>>> +A device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and VIRTIO=
_NET_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if the given virtqu=
eue is disabled.
>>>>> +
>>>>> +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_R=
X_SET commands set coalescing parameters for all transmit/receive
>>>>> +virtqueues respectively and values of coalescing parameters are reco=
rded as global values by a device.
>>>>> +The device MUST set the global values of coalescing parameters to 0 =
after being reset.
>>>>> +The VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command sets the coalescing par=
ameters for a given enabled virtqueue without changing the global values.
>>>>> +
>>>>> +After disabling and re-enabling a virtqueue, the device MUST revert =
coalescing parameters of the virtqueue to the global values.
>>>>> +
>>>>> +A device MAY set the coalescing parameter to a value close to a powe=
r of 2 value.
>>>>> +
>>>>> +A device MUST ignore \field{reserved}.
>>>>>      A device SHOULD NOT send used buffer notifications to the
>>>>> driver if the notifications are suppressed, even if the
>>>>> notification conditions are met.
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
>> --=20
>> Come down, come talk to me.


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

