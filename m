Return-Path: <virtio-comment-return-4563-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <2b67b976-210a-b8e9-cff2-259bfcc46591@linux.alibaba.com>
Date: Tue, 28 Feb 2023 00:25:31 +0800
MIME-Version: 1.0
From: Heng Qi <hengqi@linux.alibaba.com>
References: <20230226093724.44717-1-hengqi@linux.alibaba.com>
 <CAJs=3_CGcYc1dPv2x+U-vy7smGBQ3cGWNzi_D-KzpMT2RdVzrg@mail.gmail.com>
 <1ba1c6ed-6a3f-21e6-dbb2-0f1a1ed9ca62@linux.alibaba.com>
In-Reply-To: <1ba1c6ed-6a3f-21e6-dbb2-0f1a1ed9ca62@linux.alibaba.com>
Subject: [virtio-comment] Re: [virtio-dev] Re: [PATCH v9] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, David Edmondson <david.edmondson@oracle.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/27 =E4=B8=8B=E5=8D=889:02, Heng Qi =E5=86=99=E9=81=93:
> Hi, Alvaro.
>
> =E5=9C=A8 2023/2/27 =E4=B8=8A=E5=8D=883:33, Alvaro Karsz =E5=86=99=E9=81=
=93:
>> =C2=A0 Hi,
>>
>>> Currently, coalescing parameters are grouped for all transmit and=20
>>> receive
>>> virtqueues. This patch supports setting or getting the parameters for a
>>> specified virtqueue, and a typical application of this function is=20
>>> netdim[1].
>>>
>>> When the traffic between virtqueues is unbalanced, for example, one=20
>>> virtqueue
>>> is busy and another virtqueue is idle, then it will be very useful to
>>> control coalescing parameters at the virtqueue granularity.
>>>
>>> [1] https://docs.kernel.org/networking/net_dim.html
>>>
>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> ---
>>> This patch is on top of Alvaro's latest v7 patch:=20
>>> https://lists.oasis-open.org/archives/virtio-dev/202302/msg00431.html .
>>>
>>> v8->v9:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. Declare the commands that=
 can be sent for each feature.=20
>>> @Alvaro Karsz
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2. Add information about "gl=
obal values" in the command's=20
>>> explanation. @Alvaro Karsz
>>>
>>> v7->v8:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. Use "best-effort" in Alva=
ro's patch instead of "the=20
>>> device may set the parameter to a value close to 2". @Michael S .=20
>>> Tsirkin, @David Edmondson
>>>
>>> v6->v7:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. Clarify the relationship =
of=20
>>> VIRTIO_NET_CTRL_NOTF_COAL_TX/RX_SET and=20
>>> VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET. @Alvaro Karsz, @Michael S. Tsirkin
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2. Remove the formula for vq=
n range. @Parav Pandit
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3. Some expressions are clea=
rer. @Parav Pandit, @Michael S.=20
>>> Tsirkin
>>>
>>> v5->v6:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. Explain that the device m=
ay set a different value than=20
>>> the one passed in by the driver. @David Edmondson
>>>
>>> v4->v5:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. Add the correspondence be=
tween virtio_net_ctrl_coal and=20
>>> virtio_net_ctrl_coal_vq and control commands. @Michael S. Tsirkin
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2. Add read and write attrib=
utes for each field. @Michael S.=20
>>> Tsirkin
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3. A clearer description of =
how to set coalescing parameters=20
>>> for vq reset. @Michael S. Tsirkin
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4. Fix some syntax errors. @=
Michael S. Tsirkin, @David=20
>>> Edmondson
>>>
>>> v3->v4:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. Include virtio_net_ctrl_c=
oal in the=20
>>> virtio_net_ctrl_coal_vq structure. @Alvaro Karsz
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2. Add consideration of vq r=
eset. @Michael S. Tsirkin,=20
>>> @Parav Pandit, @Alvaro Karsz
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3. Avoid too many examples b=
y giving a comprehensive=20
>>> example. @Michael S. Tsirkin
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4. Fix typos and streamline =
clarifications. @Michael S.=20
>>> Tsirkin, @Parav Pandit, @Alvaro Karsz
>>>
>>> v2->v3:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. Add the netdim link. @Par=
av Pandit
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2. VIRTIO_NET_F_VQ_NOTF_COAL=
 no longer depends on=20
>>> VIRTIO_NET_F_NOTF_COAL. @Michael S. Tsirkin, @Alvaro Karsz
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3. _VQ_GET is explained more=
. @Michael S. Tsirkin
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4. Add more examples to avoi=
d misunderstandings. @Michael S.=20
>>> Tsirkin
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5. Clarify some statements. =
@Michael S. Tsirkin, @Parav=20
>>> Pandit, @Alvaro Karsz
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6. Adjust the virtio_net_ctr=
l_coal_vq structure. @Michael S.=20
>>> Tsirkin
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7. Fix some typos. @Michael =
S. Tsirkin
>>>
>>> v1->v2:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. Rename VIRTIO_NET_F_PERQU=
EUE_NOTF_COAL to=20
>>> VIRTIO_NET_F_VQ_NOTF_COAL. @Michael S. Tsirkin
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2. Use the \field{vqn} inste=
ad of the qid. @Michael S. Tsirkin
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3. Unify tx and rx control s=
tructures into one structure=20
>>> virtio_net_ctrl_coal_vq. @Michael S. Tsirkin
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4. Add a new control command=
 VIRTIO_NET_CTRL_NOTF_COAL_VQ.=20
>>> @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5. The special value 0xFFF i=
s removed because=20
>>> VIRTIO_NET_CTRL_NOTF_COAL can be used. @Alvaro Karsz
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6. Clarify some special scen=
arios. @Michael S. Tsirkin,=20
>>> @Parav Pandit, @Alvaro Karsz
>>>
>>> =C2=A0 device-types/net/description.tex | 95=20
>>> +++++++++++++++++++++++++++++---
>>> =C2=A0 1 file changed, 87 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/device-types/net/description.tex=20
>>> b/device-types/net/description.tex
>>> index e71e33b..71f6827 100644
>>> --- a/device-types/net/description.tex
>>> +++ b/device-types/net/description.tex
>>> @@ -83,6 +83,8 @@ \subsection{Feature bits}\label{sec:Device Types /=20
>>> Network Device / Feature bits
>>> =C2=A0 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through co=
ntrol
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 channel.
>>>
>>> +\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue=20
>>> notification coalescing.
>>> +
>>> =C2=A0 \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications=
=20
>>> coalescing.
>>>
>>> =C2=A0 \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 pac=
kets.
>>> @@ -139,6 +141,7 @@ \subsubsection{Feature bit=20
>>> requirements}\label{sec:Device Types / Network Device
>>> =C2=A0 \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>> =C2=A0 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or=
=20
>>> VIRTIO_NET_F_HOST_TSO6.
>>> =C2=A0 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>>> +\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>> =C2=A0 \end{description}
>>>
>>> =C2=A0 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device=
=20
>>> Types / Network Device / Feature bits / Legacy Interface: Feature bits}
>>> @@ -1505,8 +1508,17 @@ \subsubsection{Control=20
>>> Virtqueue}\label{sec:Device Types / Network Device / Devi
>>>
>>> =C2=A0 \paragraph{Notifications Coalescing}\label{sec:Device Types /=20
>>> Network Device / Device Operation / Control Virtqueue /=20
>>> Notifications Coalescing}
>>>
>>> -If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
>>> -send control commands for dynamically changing the coalescing=20
>>> parameters.
>>> +If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can=20
>>> send the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
>>> +and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands to dynamically change=20
>>> the coalescing parameters for all transmit
>>> +and receive virtqueues, respectively.
>>> +
>>> +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated:
>>> +\begin{itemize}
>>> +\item a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command=20
>>> to set coalescing parameters of a given
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enabled transmit/receive virtqueue.
>>> +\item a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command=20
>>> to a device, and the device responds with
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 coalescing parameters of a given enable=
d transmit/receive=20
>>> virtqueue.
>>> +\end{itemize}
>>>
>> The VQ_NOTF_COAL commands are enclosed in an itemize and the NOTF_COAL
>> commands aren't.
>> I think that we should be consistent here.
>
> The VQ commands are enclosed in an itemize because it has both GET and=20
> SET operations.
>
> I don't think VIRTIO_NET_CTRL_NOTF_COAL_RX_SET and=20
> VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
> have to do this, because they are both settings, just in different=20
> directions, and we have described them like this elsewhere.
>
>>
>> I'm not sure that describing the commands in here is necessary, maybe
>> just mentioning which commands can be used with which feature bit is
>
> Isn't that what this sentence does?
>
>> enough (this is what I meant in v8, sorry if I wasn't clear).
>>
>> I'm not saying that describing the commands in here is not good, but
>> notice that the commands are described in 3 different places.
>
> Three places describe different effects.
>
> #1 describes which commands are available for which feature.
> #2 describes which command can use which structure.
> #3 describes which parameters can be set for each command, and whether=20
> they can affect "global values".
> It is placed in the "Operation" section because it explains how the=20
> device should behave.
>
> Maybe #1 and #2 descriptions can be combined and described together.
>
>> This is #1.
>>
>>> =C2=A0 \begin{note}
>>> =C2=A0 The behavior of the device in response to these commands is=20
>>> best-effort:
>>> @@ -1519,25 +1531,76 @@ \subsubsection{Control=20
>>> Virtqueue}\label{sec:Device Types / Network Device / Devi
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le32 max_usecs;
>>> =C2=A0 };
>>>
>>> +struct virtio_net_ctrl_coal_vq {
>>> +=C2=A0=C2=A0=C2=A0 le16 vqn;
>>> +=C2=A0=C2=A0=C2=A0 le16 reserved;
>>> +=C2=A0=C2=A0=C2=A0 struct virtio_net_ctrl_coal coal;
>>> +};
>>> +
>>> =C2=A0 #define VIRTIO_NET_CTRL_NOTF_COAL 6
>>> =C2=A0=C2=A0 #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET=C2=A0 0
>>> =C2=A0=C2=A0 #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
>>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
>>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
>>> =C2=A0 \end{lstlisting}
>>>
>>> +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and=20
>>> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands use the
>>> +virtio_net_ctrl_coal structure to set \field{max_usecs} and=20
>>> \field{max_packets} for all
>>> +transmit/receive virtqueues.
>>> +
>>> +The VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command uses the=20
>>> virtio_net_ctrl_coal_vq structure
>>> +to set \field{max_usecs} and \field{max_packets} for the supplied=20
>>> virtqueue number \field{vqn}.
>>> +
>>> +The VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command gets the values of=20
>>> \field{max_usecs} and
>>> +\field{max_packets} of the specified virtqueue from the device by=20
>>> setting \field{vqn}
>>> +in the virtio_net_ctrl_coal_vq structure.
>>> +
>> This is #2.
>>
>>> +# Read/Write attributes for coalescing parameters
>>> +\begin{itemize}
>>> +\item For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and=20
>>> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, \field{max_usecs}
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and \field{max_packets} are write-only =
for a driver.
>>> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,=20
>>> \field{vqn}, \field{reserved}, \field{max_usecs}
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and \field{max_packets} are write-only =
for a driver.
>>> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn}=20
>>> and \field{reserved} are write-only
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for a driver, and, \field{max_usecs} an=
d \field{max_packets}=20
>>> are read-only for the driver.
>>> +\end{itemize}
>>> +
>>> =C2=A0 Coalescing parameters:
>>> =C2=A0 \begin{itemize}
>>> +\item \field{vqn}: The virtqueue number of an enabled transmit or=20
>>> receive virtqueue.
>>> =C2=A0 \item \field{max_usecs} for RX: Maximum number of microseconds t=
o=20
>>> delay a RX notification.
>>> =C2=A0 \item \field{max_usecs} for TX: Maximum number of microseconds t=
o=20
>>> delay a TX notification.
>>> =C2=A0 \item \field{max_packets} for RX: Maximum number of packets to=
=20
>>> receive before a RX notification.
>>> =C2=A0 \item \field{max_packets} for TX: Maximum number of packets to=
=20
>>> send before a TX notification.
>>> =C2=A0 \end{itemize}
>>>
>>> -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
>>> +\field{reserved} is reserved and it is ignored by a device.
>>> +
>>> +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
>>> =C2=A0 \begin{enumerate}
>>> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs}=20
>>> and \field{max_packets} parameters for all transmit virtqueues.
>>> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs}=20
>>> and \field{max_packets} parameters for all receive virtqueues.
>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs}=20
>>> and \field{max_packets} parameters for all transmit virtqueues, and=20
>>> values of
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 coalescing parameters are=20
>>> recorded as TX global values by a device.
>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs}=20
>>> and \field{max_packets} parameters for all receive virtqueues, and=20
>>> values of
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 coalescing parameters are=20
>>> recorded as RX global values by a device.
>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_usecs}=20
>>> and \field{max_packets} parameters for an enabled transmit/receive
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 virtqueue whose number is=20
>>> \field{vqn}, and do not change the TX/RX global values.
>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device returns the=20
>>> \field{max_usecs} and \field{max_packets} parameters for an enabled
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 transmit/receive virtqueue=20
>>> whose number is \field{vqn}.
>>> =C2=A0 \end{enumerate}
>> This is #3.
>>
>>> +If coalescing parameters are being set, the device applies the last=20
>>> coalescing parameters received for a
>>> +virtqueue, regardless of the command used to set the parameters.=20
>>> For example with 2 pairs of virtqueues:
>>> +# Command sequence
>>> +Each of the following commands sets \field{max_usecs} and=20
>>> \field{max_packets} parameters for virtqueues.
>>> +\begin{itemize}
>>> +\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing=20
>>> parameters for virtqueue0 and virtqueue2, and, virtqueue1 and=20
>>> virtqueue3 retain their previous parameter values.
>>> +\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =3D=
=20
>>> 0 sets coalescing parameters for virtqueue0, and virtqueue2 retains=20
>>> the values from command1.
>>> +\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} =3D=
=20
>>> 0, the device responds with coalescing parameters of virtqueue0 set=20
>>> by command2.
>>> +\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =3D=
=20
>>> 1 sets coalescing parameters for virtqueue1, and virtqueue3 retains=20
>>> its previous values.
>>> +\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing=20
>>> parameters for virtqueue1 and virtqueue3, and overrides the values=20
>>> set by command4.
>>> +\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} =3D=
=20
>>> 1, the device responds with coalescing parameters of virtqueue1 set=20
>>> by command5.
>>> +\end{itemize}
>>> +
>>> =C2=A0 \subparagraph{Operation}\label{sec:Device Types / Network Device=
 /=20
>>> Device Operation / Control Virtqueue / Notifications Coalescing /=20
>>> Operation}
>>>
>>> =C2=A0 The device sends a used buffer notification once the notificatio=
n=20
>>> conditions are met and if the notifications are not suppressed as=20
>>> explained in \ref{sec:Basic Facilities of a Virtio Device /=20
>>> Virtqueues / Used Buffer Notification Suppression}.
>>> @@ -1549,6 +1612,11 @@ \subsubsection{Control=20
>>> Virtqueue}\label{sec:Device Types / Network Device / Devi
>>>
>>> =C2=A0 When the device has \field{max_usecs} =3D 0 or \field{max_packet=
s} =3D=20
>>> 0, the notification conditions are met after every packet=20
>>> received/sent.
>>>
>>> +When the device receives the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and=20
>>> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands,
>>> +it saves the values of coalescing parameters as global values, and=20
>>> the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command
>>> +does not change the global values. If the device is reset, the=20
>>> global values will be set to 0.
>>> +When a virtqueue is enabled after virtqueue reset, its coalescing=20
>>> parameters are set to global values.
>>> +
>> Maybe this explanation should be put closer to the commands
>> descriptions, where the global coalescing parameters are mentioned for
>> the first time.
>> Something like:
>> ....
>> \item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device returns the
>> \field{max_usecs} and \field{max_packets} parameters for an enabled
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 transmit/receive virtqueue whose nu=
mber
>> is \field{vqn}.
>>
>> The device maintains global coalescing parameters for TX and RX....
>
> This is the "Operation" chapter, and the description of the operation=20
> is more likely to be placed here, isn't it?
>
>
>
>>
>> And maybe we should use "global coalescing parameters" instead of
>> "global values" (in devicenormative as well).
>>
>>> =C2=A0 \subparagraph{RX Example}\label{sec:Device Types / Network Devic=
e=20
>>> / Device Operation / Control Virtqueue / Notifications Coalescing /=20
>>> RX Example}
>>>
>>> =C2=A0 If, for example:
>>> @@ -1585,15 +1653,26 @@ \subsubsection{Control=20
>>> Virtqueue}\label{sec:Device Types / Network Device / Devi
>>>
>>> =C2=A0 \drivernormative{\subparagraph}{Notifications Coalescing}{Device=
=20
>>> Types / Network Device / Device Operation / Control Virtqueue /=20
>>> Notifications Coalescing}
>>>
>>> -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the=20
>>> driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
>>> +If neither the VIRTIO_NET_F_NOTF_COAL nor the=20
>>> VIRTIO_NET_F_VQ_NOTF_COAL feature
>>> +has been negotiated, the driver MUST NOT issue=20
>>> VIRTIO_NET_CTRL_NOTF_COAL commands.
>> Maybe this part can be splitted to:
>> if the F1 feature has not been negotiated, the driver must not issue
>> commands C1,C2.
>> if the F2 feature has not been negotiated, the driver must not issue
>> commands C3,C4.
>
> Ok.
>
> Thanks.
>
>>> +
>>> +A driver MUST ignore the values of coalescing parameters received=20
>>> from the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if a device=20
>>> responds with VIRTIO_NET_ERR.
>>>
>>> =C2=A0 \devicenormative{\subparagraph}{Notifications Coalescing}{Device=
=20
>>> Types / Network Device / Device Operation / Control Virtqueue /=20
>>> Notifications Coalescing}
>>>
>>> -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands=20
>>> with VIRTIO_NET_ERR if it was not able to change the parameters.
>>> +A device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and=20
>>> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it=20
>>> was not able to change the parameters.
>>> +
>>> +A device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET=20
>>> command with VIRTIO_NET_ERR if it was not able to change the=20
>>> parameters.
>>> +
>>> +A device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and=20
>>> VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if the=20
>>> given virtqueue is disabled.
>>> +
>>> +A device MUST ignore \field{reserved}.
>>>
>>> =C2=A0 A device SHOULD NOT send used buffer notifications to the driver=
=20
>>> if the notifications are suppressed, even if the notification=20
>>> conditions are met.
>>>
>>> -Upon reset, a device MUST initialize all coalescing parameters to 0.
>>> +After disabling and re-enabling a virtqueue, the device MUST revert=20
>>> coalescing parameters of the virtqueue to the global values.
>>> +
>>> +Upon reset, a device MUST initialize all coalescing parameters to 0=20
>>> and MUST set the global values to 0.
>>>
>>> =C2=A0 \subsubsection{Legacy Interface: Framing=20
>>> Requirements}\label{sec:Device
>>> =C2=A0 Types / Network Device / Legacy Interface: Framing Requirements}
>>> --=20
>> Let's wait for more comments before the next version, I guess some may
>> not agree with my comments.

Hi, Michael and Parav, what do you think?

Thanks.

>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


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

