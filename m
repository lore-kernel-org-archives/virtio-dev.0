Return-Path: <virtio-comment-return-4311-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <5f89d97e-3f66-27a1-bee2-2957685b6b95@linux.alibaba.com>
Date: Fri, 17 Feb 2023 12:56:46 +0800
MIME-Version: 1.0
References: <20230216144301.57728-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481646B2DE1E64D0DC6E3A5DCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB5481646B2DE1E64D0DC6E3A5DCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-comment] Re: [virtio-dev] RE: [PATCH v3] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi, Parav. Thanks for your suggested revisions.

=E5=9C=A8 2023/2/17 =E4=B8=8A=E5=8D=8810:47, Parav Pandit =E5=86=99=E9=81=
=93:
>> From: Heng Qi <hengqi@linux.alibaba.com>
>> Sent: Thursday, February 16, 2023 9:43 AM
> [..]
>>   #define VIRTIO_NET_CTRL_NOTF_COAL 6
>> - #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
>> + #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET 0
> Unrelated change. Please remove this hunk.

Ok. Will fix.

>
>>    #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2 #define
>> + VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
>> +
>>   \end{lstlisting}
>>
>>   Coalescing parameters:
>> @@ -4514,12 +4521,67 @@ \subsubsection{Control
>> Virtqueue}\label{sec:Device Types / Network Device / Devi  \end{itemize}
>>
>>
>> -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
>> +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
>>   \begin{enumerate}
>>   \item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and
>> \field{tx_max_packets} parameters.
>>   \item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and
>> \field{rx_max_packets} parameters.
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_packets}
>> and \field{max_usecs} parameters for a enabled
>> +                                        transmit/receive virtqueue whos=
e number is \field{vqn}.
> In the spec we have mix of notion as vqn or vq index.
> For example, recent aq patch from Michael refers to aq vq index.
> Mmio has vq index register too for long time.
>
> And some places we don't refer to index vs number. (pcie queue_select reg=
ister).
> We all understand that they refer to same.
> But it is time to get consistency for new additions.

I totally agree.
I see that "\item [vqn] VQ number to be notified." is currently present=20
in \section{Driver Notifications},
and also
"When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
The driver sends an available buffer notification to the device by=20
writing the 16-bit virtqueue index=E2=80=9D

These all seem to exist at the same time, and I think we should indeed=20
unify.

> So lets agree on either one of the naming convention.
>
> Michael,
> I am inclined to name it as vq index given existings references and with =
your aq vq index patch.
> Do you have preference?
> If its index, above should be changed from vqn/vq_index.
>
>> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device gets the
>> \field{max_packets} and \field{max_usecs} parameters of
>> +                                        a enabled transmit/receive virt=
queue whose number is
>> \field{vqn}, and then
>> +                                        responds them to the driver.
>>   \end{enumerate}
> It is confusing line of "device gets".
>
> It is better to write it as,
> The device returns max_packets and max_usecs for the enabled transmit or =
receive virtuque whose index is vq_index.

Ok. Will modify.

>
>> +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated:
>> +1. a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command to
>> set the coalescing
>> +   parameters of a enabled transmit/receive virtqueue.
>> +2. a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command to a
>> device, and the device
>> +   responds to the driver with the coalescing parameters of a enabled
>> transmit/receive virtqueue.
>> +
>> +\begin{lstlisting}
>> +struct virtio_net_ctrl_coal_vq {
>> +    le16 vqn;
>> +    le16 reserved;
>> +    le32 max_packets;
>> +    le32 max_usecs;
>> +};
>> +\end{lstlisting}
>> +
>> +Virtqueue coalescing parameters:
>> +\begin{itemize}
>> +\item \field{vqn}: The virtqueue number of the enabled transmit or rece=
ive
>> virtqueue, excluding the control virtqueue.
> Transmit and receive vq is self-explanatory. No need to mention control v=
q.
> The word "excluding" doesn't fit here well given it refers to only single=
 vq at a time.

Ok. Will remove.

>> +\item \field{max_packets}: The maximum number of packets sent/received =
by
>> the specified virtqueue before a TX/RX notification.
>> +\item \field{max_usecs}: The maximum number of TX/RX usecs that the
>> specified virtqueue delays a TX/RX notification.
>> +\end{itemize}
>> +
>> +\field{reserved} is reserved and it is ignored by the device.
>> +
>> +THe value of \field{vqn} satisfies $ 0 \leq vqn < max_virtqueue_pairs \=
ast 2 $.
>> +The conversion between \field{vqn} and transmitq/receiveq index:
>> +\begin{itemize}
>> +$ \lfloor vqn / 2 \rfloor $ is the index of the corresponding receiveq.
>> +$ \lfloor (vqn / 2) + 1 \rfloor $ is the index of the corresponding tra=
nmitq.
>> +\end{itemize}
>> +
> No need to provide the math here, it is about enabled vq.
> The spec somewhere else already describes what the valid index of enabled=
 vq.

I saw this:
"
\begin{description}
\item[0] receiveq1
\item[1] transmitq1
\item[\ldots]
\item[2(N-1)] receiveqN
\item[2(N-1)+1] transmitqN
\item[2N]controlq
\end{description}
"
, it seems that simply giving the conversion formula here is also=20
helpful for readers to understand?

>
>> +The VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command is the same as the
>> +VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command repeated for each
>> virtqueue of receiveq1\ldots receiveqN.
>> +
>> +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command is the same as the
>> +VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command repeated for each
>> virtqueue of transmitq1\ldots transmitqN.
>> +
>> +If coalescing parameters are being set, the device applies the last
>> +coalescing parameters received for a virtqueue, regardless of the comma=
nd
>> used to deliver the parameters. For example:
> used to set the parameters.

Ok.

>
>> +# Command sequence 1:
>> +1. VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command with $
>> \field{max_packets}
>> +=3D 15 $ and $ \field{max_usecs} =3D 10 $ 2.
>> +VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with $ \field{vqn} =3D 0 $, $
>> +\field{max_packets} =3D 12 $ and $ \field{max_usecs} =3D 8 $ After #2 c=
ommand is
>> applied by the device, the coalescing parameters of receiveq1 are $
>> \field{max_packets} =3D 12 $ and $ \field{max_usecs} =3D 8 $, and the co=
alescing
>> parameters of receiveq2\ldots receiveqN are $ \field{max_packets} =3D 15=
 $ and
>> $ \field{max_usecs} =3D 10 $.
>> +
>> +# Command sequence 2:
>> +1. VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with $ \field{vqn} =3D 0 $,
>> $
>> +\field{max_packets} =3D 12 $ and $ \field{max_usecs} =3D 8 $ 2.
>> +VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command with $ \field{max_packets}
>> =3D 15 $ and $ \field{max_usecs} =3D 10 $ After #2 command is applied by=
 the
>> device, the coalescing parameters of receiveq1\ldots receiveqN are $
>> \field{max_packets} =3D 15 $ and $ \field{max_usecs} =3D 10 $.
>> +
>>   \subparagraph{RX Notifications}\label{sec:Device Types / Network Devic=
e /
>> Device Operation / Control Virtqueue / Notifications Coalescing / RX
>> Notifications}
>>
>>   If, for example:
>> @@ -4532,9 +4594,33 @@ \subsubsection{Control
>> Virtqueue}\label{sec:Device Types / Network Device / Devi
>>
>>   \begin{itemize}
>>   \item The device will count received packets until it accumulates 15, =
or until 10
>> usecs elapsed since the first one was received.
>> -\item If the notifications are not suppressed by the driver, the device=
 will send
>> an used buffer notification, otherwise, the device will not send an used=
 buffer
>> notification as long as the notifications are suppressed.
>> +\item If the notifications are not suppressed by the driver, the device=
 will send
>> an used buffer notification, otherwise,
>> +      the device will not send an used buffer notification as long as t=
he
>> notifications are suppressed.
>> +\end{itemize}
>> +
>> +Example of setting coalescing parameters for a receive virtqueue:
>> +\begin{itemize}
>> +\item \field{max_packets} =3D 15
>> +\item \field{max_usecs} =3D 10
>> +\item \field{vqn} =3D 0
>> +\end{itemize}
>> +
>> +The device will operate as follows:
>> +\begin{itemize}
>> +\item The device applies the coalescing parameters to receiveq1 because=
 its
>> virtqueue number is 0.
>> +\item The device will count received packets on receiveq1 until it accu=
mulates
>> 15, or until 10 usecs elapsed since the first one was received.
>> +\item If the notifications are not suppressed by the driver, the device=
 will send
>> an used buffer notification, otherwise,
>> +      the device will not send an used buffer notification as long as t=
he
>> notifications are suppressed.
>> +\end{itemize}
>> +
>> +Example of getting coalescing parameters from a receive virtqueue:
>> +\begin{itemize}
>> +\item \field{vqn} =3D 0.
>>   \end{itemize}
>>
>> +The device gets the values of the \field{max_packets} and
>> +\field{max_usecs} parameters from the receiveq1 whose virtqueue number =
is
>> 0, and then responds them to the driver.
>> +
> The device returns the value of X and Y parameters for the supplied vq in=
dex.

Ok.

>
>>   \subparagraph{TX Notifications}\label{sec:Device Types / Network Devic=
e /
>> Device Operation / Control Virtqueue / Notifications Coalescing / TX
>> Notifications}
>>
>>   If, for example:
>> @@ -4550,14 +4636,50 @@ \subsubsection{Control
>> Virtqueue}\label{sec:Device Types / Network Device / Devi  \item If the
>> notifications are not suppressed by the driver, the device will send an =
used
>> buffer notification, otherwise, the device will not send an used buffer
>> notification as long as the notifications are suppressed.
>>   \end{itemize}
>>
>> +Example of setting coalescing parameters for a transmit virtqueue:
>> +\begin{itemize}
>> +\item \field{max_packets} =3D 15
>> +\item \field{max_usecs} =3D 10
>> +\item \field{vqn} =3D 1
>> +\end{itemize}
>> +
>> +The device will operate as follows:
>> +
>> +\begin{itemize}
>> +\item The device applies the coalescing parameters to transmitq1 becaus=
e its
>> virtqueue number is 1.
>> +\item The device will count sent packets on transmitq1 until it accumul=
ates 15,
>> or until 10 usecs elapsed since the first one was sent.
>> +\item If the notifications are not suppressed by the driver, the device=
 will send
>> an used buffer notification, otherwise,
>> +      the device will not send an used buffer notification as long as t=
he
>> notifications are suppressed.
>> +\end{itemize}
>> +
>> +Example of getting coalescing parameters from a transmit virtqueue:
>> +\begin{itemize}
>> +\item \field{vqn} =3D 1.
>> +\end{itemize}
>> +
>> +The device gets the values of the \field{max_packets} and
>> +\field{max_usecs} parameters from the transmitq1 whose virtqueue number
>> is 1, and then responds them to the driver.
>> +
>>   \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types=
 /
>> Network Device / Device Operation / Control Virtqueue / Notifications
>> Coalescing}
>>
>> -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driv=
er
>> MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
>> +If neither the VIRTIO_NET_F_NOTF_COAL nor the
>> VIRTIO_NET_F_VQ_NOTF_COAL
>> +feature has not been negotiated, the driver MUST NOT issue
>> VIRTIO_NET_CTRL_NOTF_COAL commands.
>> +
>> +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated, the driver MUST
>> +set \field{vqn} to a legal value, that is, \field{vqn} points to an ena=
bled
>> transmit/receive virtqueue.
>> +
>> +A driver MAY NOT get exactly the same value as the coalescing parameter=
 it
>> was set to, for example it MAY get a value that is a power of 2.
>>
> It MAY get a value that is close to power of 2 value of the previously se=
t value.

Ok. This is in line with Michael's suggestion.

>
>>   \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types=
 /
>> Network Device / Device Operation / Control Virtqueue / Notifications
>> Coalescing}
>>
>>   A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands
>> with VIRTIO_NET_ERR if it was not able to change the parameters.
>>
> Silently dropping the command is not good, we cannot change past now.
> But lets please fix the below one.
> Please add the note around above text that,
> Note: VQ_COAL is exception to it, which must return NET_ERR if device is =
unable to change the parameters.

Why are the corresponding behaviors of VIRTIO_NET_CTRL_NOTF_COAL and=20
VIRTIO_NET_CTRL_VQ_NOTF_COAL_SET inconsistent in the same scenario?

VIRTIO_NET_CTRL_NOTF_COAL --> SHOULD, but=20
VIRTIO_NET_CTRL_VQ_NOTF_COAL_SET --> MUST?

My guess is that when VIRTIO_NET_CTRL_NOTF_COAL is set for=20
receiveq1\ldots receiveqN, if recieveq1 is not set successfully because=20
it is disabled,
all other receiveq2\ldots receiveqN are set successfully. At this time,=20
the device can choose not to return an error?

>> +When a device receives a virtqueue command to set/get coalescing
>> +parameters for a virtqueue with number \field{vqn}, if the virtqueue is=
 not
>> enabled, the device SHOULD respond to the command with VIRTIO_NET_ERR.
>> +
> Device MUST respond with an error on the object that doesn't exist.
> Please change it to MUST.
>
> Please add below text. Need some wording change for above SHOULD.
>
> A device MUST respond to the VIRTIO_NET_CTRL_VQ_NOTF_COAL_GET and SET com=
mand with
> with VIRTIO_NET_ERR if it is not able to change the parameters.

When the device receives _VQ_NOTF_COAL_GET, it will not try to change=20
the parameters. And seeing here,
we seem to be able to avoid splitting the patch, because it seems=20
redundant to say this description once for GET and SET?

>
>
>> +A device MAY NOT set the coalescing parameter to the exact same value
>> +as the one passed in by a driver.
> s/as the one passed in by a driver/as the one set by the driver

Ok.

>
> For example, the value of \field{max_packets}

This is how I described it in the original v3 patch, did you miss this=20
sentence?


Thanks. :)

>> set by the driver is 15, but the device MAY store a value that is a powe=
r of 2,
>> that is, 16.
>> +
>>   A device SHOULD NOT send used buffer notifications to the driver, if t=
he
>> notifications are suppressed as explained in \ref{sec:Basic Facilities o=
f a Virtio
>> Device / Virtqueues / Used Buffer Notification Suppression}, even if the
>> coalescing counters expired.
>>
>>   Upon reset, a device MUST initialize all coalescing parameters to 0.
>> --
>> 2.19.1.6.gb485710b
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

