Return-Path: <virtio-comment-return-4578-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <46d5248b-1632-22b1-03b0-7ca64d536f04@linux.alibaba.com>
Date: Tue, 28 Feb 2023 10:41:18 +0800
MIME-Version: 1.0
References: <20230226093724.44717-1-hengqi@linux.alibaba.com>
 <CAJs=3_CGcYc1dPv2x+U-vy7smGBQ3cGWNzi_D-KzpMT2RdVzrg@mail.gmail.com>
 <1ba1c6ed-6a3f-21e6-dbb2-0f1a1ed9ca62@linux.alibaba.com>
 <CAJs=3_DND7WdoXc19XzOKDDKYNXFKdKRMr6j93p9z7=5EyGHGQ@mail.gmail.com>
 <20230227151420-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230227151420-mutt-send-email-mst@kernel.org>
Subject: [virtio-comment] Re: [virtio-dev] Re: [PATCH v9] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, David Edmondson <david.edmondson@oracle.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/28 =E4=B8=8A=E5=8D=884:19, Michael S. Tsirkin =E5=86=99=E9=
=81=93:
> On Mon, Feb 27, 2023 at 08:45:43PM +0200, Alvaro Karsz wrote:
>>>>> -If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
>>>>> -send control commands for dynamically changing the coalescing parame=
ters.
>>>>> +If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can =
send the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
>>>>> +and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands to dynamically change =
the coalescing parameters for all transmit
>>>>> +and receive virtqueues, respectively.
>>>>> +
>>>>> +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated:
>>>>> +\begin{itemize}
>>>>> +\item a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command t=
o set coalescing parameters of a given
>>>>> +      enabled transmit/receive virtqueue.
>>>>> +\item a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command t=
o a device, and the device responds with
>>>>> +      coalescing parameters of a given enabled transmit/receive virt=
queue.
>>>>> +\end{itemize}
>>>>>
>>>> The VQ_NOTF_COAL commands are enclosed in an itemize and the NOTF_COAL
>>>> commands aren't.
>>>> I think that we should be consistent here.
>>> The VQ commands are enclosed in an itemize because it has both GET and
>>> SET operations.
>>>
>>> I don't think VIRTIO_NET_CTRL_NOTF_COAL_RX_SET and
>>> VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
>>> have to do this, because they are both settings, just in different
>>> directions, and we have described them like this elsewhere.
>>>
>>>> I'm not sure that describing the commands in here is necessary, maybe
>>>> just mentioning which commands can be used with which feature bit is
>>> Isn't that what this sentence does?
>>>
>> Yes, but it also describes what the command does
>> "to dynamically change the coalescing parameters for all transmit and
>> receive virtqueues"
>>
>> Seems a bit repetitive to me.
>>
>>>> enough (this is what I meant in v8, sorry if I wasn't clear).
>>>>
>>>> I'm not saying that describing the commands in here is not good, but
>>>> notice that the commands are described in 3 different places.
>>> Three places describe different effects.
>>>
>>> #1 describes which commands are available for which feature.
>>> #2 describes which command can use which structure.
>>> #3 describes which parameters can be set for each command, and whether
>>> they can affect "global values".
>>> It is placed in the "Operation" section because it explains how the
>>> device should behave.
>>>
>> You're right, but some parts seems repetitive to me:
>> #1:  "commands to dynamically change the coalescing parameters for all
>> transmit and receive virtqueues"
>>
>> #2: "commands use the virtio_net_ctrl_coal structure to set
>> \field{max_usecs} and \field{max_packets} for all transmit/receive
>> virtqueues."
>>
>> #3: " set the \field{max_usecs} and \field{max_packets} parameters for
>> all transmit virtqueues, and values of..."
>>
>> Feels like every time we re-explain the commands with more detail.
>> So, for example we read #2 and understand what the command does (set
>> usecs and packets), then we read #3 and understand that it does some
>> more stuff.
>>
>> IMO we need to explain it once, with all the details.
>
> This is how we've written it historically. The idea is that
> reader can get everything on the first pass: 1st high level
> picture then detailed description then the formalities.
>
> Other specs do it differently so one has to re-read them
> many times to understand. I don't like this personally and
> I much prefer the virtio way.
>
>
>>> Maybe #1 and #2 descriptions can be combined and described together.
>>>
>>>> This is #1.
>>>>
>>>>>    \begin{note}
>>>>>    The behavior of the device in response to these commands is best-e=
ffort:
>>>>> @@ -1519,25 +1531,76 @@ \subsubsection{Control Virtqueue}\label{sec:D=
evice Types / Network Device / Devi
>>>>>        le32 max_usecs;
>>>>>    };
>>>>>
>>>>> +struct virtio_net_ctrl_coal_vq {
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
>>>>>
>>>>> +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_R=
X_SET commands use the
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
>>>> This is #2.
>>>>
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
>>>>>
>>>>> -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
>>>>> +\field{reserved} is reserved and it is ignored by a device.
>>>>> +
>>>>> +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
>>>>>    \begin{enumerate}
>>>>> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} an=
d \field{max_packets} parameters for all transmit virtqueues.
>>>>> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} an=
d \field{max_packets} parameters for all receive virtqueues.
>>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} an=
d \field{max_packets} parameters for all transmit virtqueues, and values of
>>>>> +                                        coalescing parameters are re=
corded as TX global values by a device.
>>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} an=
d \field{max_packets} parameters for all receive virtqueues, and values of
>>>>> +                                        coalescing parameters are re=
corded as RX global values by a device.
>>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_usecs} an=
d \field{max_packets} parameters for an enabled transmit/receive
>>>>> +                                        virtqueue whose number is \f=
ield{vqn}, and do not change the TX/RX global values.
>>>>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device returns the \fiel=
d{max_usecs} and \field{max_packets} parameters for an enabled
>>>>> +                                        transmit/receive virtqueue w=
hose number is \field{vqn}.
>>>>>    \end{enumerate}
>>>> This is #3.
>>>>
>>>>> +If coalescing parameters are being set, the device applies the last =
coalescing parameters received for a
>>>>> +virtqueue, regardless of the command used to set the parameters. For=
 example with 2 pairs of virtqueues:
>>>>> +# Command sequence
>>>>> +Each of the following commands sets \field{max_usecs} and \field{max=
_packets} parameters for virtqueues.
>>>>> +\begin{itemize}
>>>>> +\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing par=
ameters for virtqueue0 and virtqueue2, and, virtqueue1 and virtqueue3 retai=
n their previous parameter values.
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
>>>>>
>>>>>    The device sends a used buffer notification once the notification =
conditions are met and if the notifications are not suppressed as explained=
 in \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer=
 Notification Suppression}.
>>>>> @@ -1549,6 +1612,11 @@ \subsubsection{Control Virtqueue}\label{sec:De=
vice Types / Network Device / Devi
>>>>>
>>>>>    When the device has \field{max_usecs} =3D 0 or \field{max_packets}=
 =3D 0, the notification conditions are met after every packet received/sen=
t.
>>>>>
>>>>> +When the device receives the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VI=
RTIO_NET_CTRL_NOTF_COAL_RX_SET commands,
>>>>> +it saves the values of coalescing parameters as global values, and t=
he VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command
>>>>> +does not change the global values. If the device is reset, the globa=
l values will be set to 0.
>>>>> +When a virtqueue is enabled after virtqueue reset, its coalescing pa=
rameters are set to global values.
>>>>> +
>>>> Maybe this explanation should be put closer to the commands
>>>> descriptions, where the global coalescing parameters are mentioned for
>>>> the first time.
>>>> Something like:
>>>> ....
>>>> \item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device returns the
>>>> \field{max_usecs} and \field{max_packets} parameters for an enabled
>>>>                                  transmit/receive virtqueue whose numb=
er
>>>> is \field{vqn}.
>>>>
>>>> The device maintains global coalescing parameters for TX and RX....
>>> This is the "Operation" chapter, and the description of the operation i=
s
>>> more likely to be placed here, isn't it?
>>>
>> I see your point, but a reader will see the "global notifications
>> coalescing parameter" concept, and won't know what it is until next
>> paragraph.
>> Maybe we can have a new list with the notification coalescing concepts
>> (like the notification coalescing parameters)? Just throwing an idea
>> here.
> Actually, "global notification coalescing parameters" is confusing:
> are these global notifications? global coalescings? global parameters?
>
> The problem is the global qualifier. And it's not even global -
> there are two sets for rx and for tx and does not apply to cvq at all.
> How about "RX/TX coalescing parameters"?

As Parav suggested, we probably don't need to mention "global=20
values/coalescing parameters" since this values/parameters are the ones=20
set by CTRL_NOTF_COAL_RX/TX_SET.

Just like this:
"
After disabling and re-enabling a virtuqueue, the device MUST revert to=20
coalescing parameters to the one configured using VIRTIO_NET_CTRL_NOTF_COAL=
.
"

Thanks.

>
>
>>>> And maybe we should use "global coalescing parameters" instead of
>>>> "global values" (in devicenormative as well).
>>>>
>>>>>    \subparagraph{RX Example}\label{sec:Device Types / Network Device =
/ Device Operation / Control Virtqueue / Notifications Coalescing / RX Exam=
ple}
>>>>>
>>>>>    If, for example:
>>>>> @@ -1585,15 +1653,26 @@ \subsubsection{Control Virtqueue}\label{sec:D=
evice Types / Network Device / Devi
>>>>>
>>>>>    \drivernormative{\subparagraph}{Notifications Coalescing}{Device T=
ypes / Network Device / Device Operation / Control Virtqueue / Notification=
s Coalescing}
>>>>>
>>>>> -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the d=
river MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
>>>>> +If neither the VIRTIO_NET_F_NOTF_COAL nor the VIRTIO_NET_F_VQ_NOTF_C=
OAL feature
>>>>> +has been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_=
COAL commands.
>>>> Maybe this part can be splitted to:
>>>> if the F1 feature has not been negotiated, the driver must not issue
>>>> commands C1,C2.
>>>> if the F2 feature has not been negotiated, the driver must not issue
>>>> commands C3,C4.
>>> Ok.
>>>
>>> Thanks.
>>>
>>>>> +
>>>>> +A driver MUST ignore the values of coalescing parameters received fr=
om the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if a device responds with V=
IRTIO_NET_ERR.
>>>>>
>>>>>    \devicenormative{\subparagraph}{Notifications Coalescing}{Device T=
ypes / Network Device / Device Operation / Control Virtqueue / Notification=
s Coalescing}
>>>>>
>>>>> -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands wi=
th VIRTIO_NET_ERR if it was not able to change the parameters.
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
>>>>> +A device MUST ignore \field{reserved}.
>>>>>
>>>>>    A device SHOULD NOT send used buffer notifications to the driver i=
f the notifications are suppressed, even if the notification conditions are=
 met.
>>>>>
>>>>> -Upon reset, a device MUST initialize all coalescing parameters to 0.
>>>>> +After disabling and re-enabling a virtqueue, the device MUST revert =
coalescing parameters of the virtqueue to the global values.
>>>>> +
>>>>> +Upon reset, a device MUST initialize all coalescing parameters to 0 =
and MUST set the global values to 0.
>>>>>
>>>>>    \subsubsection{Legacy Interface: Framing Requirements}\label{sec:D=
evice
>>>>>    Types / Network Device / Legacy Interface: Framing Requirements}
>>>>> --
>>>> Let's wait for more comments before the next version, I guess some may
>>>> not agree with my comments.


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

