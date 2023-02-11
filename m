Return-Path: <virtio-comment-return-4141-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <06f91a46-42ff-a208-990c-904cdb7873c9@linux.alibaba.com>
Date: Sat, 11 Feb 2023 10:01:29 +0800
MIME-Version: 1.0
References: <20230210070130.21811-1-hengqi@linux.alibaba.com>
 <PH0PR12MB548155EF2CB09C6C88B75C44DCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB548155EF2CB09C6C88B75C44DCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-comment] Re: [virtio-dev] RE: [PATCH v2] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/11 =E4=B8=8A=E5=8D=883:36, Parav Pandit =E5=86=99=E9=81=93=
:
>
>> From: Heng Qi <hengqi@linux.alibaba.com>
>> Sent: Friday, February 10, 2023 2:02 AM
>>
>> Currently, the coalescing profile is directly applied to all queues.
> Say it,
> Currently coalescing parameters are grouped for all transmit and receive =
virtqueues.

Sure.

>
>> This patch supports setting or getting the parameters for a specified qu=
eue, and
>> a typical application of this function is NetDIM.
> Many of us know the net dim.
> But if you prefer to mention it here, better to have the link for it.

Yes, but this sentence is just a reminder for those who may not know the=20
current usage scenarios of it.

>
> Please add pointer to it.
> [1] https://docs.kernel.org/networking/net_dim.html

Good opinion.

>
>> When the traffic between queues is unbalanced, for example, one queue is
>> busy and another queue is idle, then it will be very useful to control c=
oalescing
>> parameters at the queue granularity.
>>
>>
>> +If additionally VIRTIO_NET_F_VQ_NOTF_COAL is negotiated, the driver can
>> +send control commands to set or get the coalescing parameters of a
> Control command singular?

Yes.

>> +specified virtqueue (excluding the control virtqueue).
>> +
>> +\begin{lstlisting}
>> +struct virtio_net_ctrl_coal_vq {
>> +    le32 max_packets;
>> +    le32 usecs;
>> +    le16 vqn;
>> +};
>> +
> Change that Michael suggest restructuring and under same class looks good=
 to me.
>
>> +#define VIRTIO_NET_CTRL_NOTF_COAL_VQ 7
>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 0  #define
>> +VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 1 \end{lstlisting}
>> +
>> +Virtqueue coalescing parameters:
>> +\begin{itemize}
>> +\item \field{max_packets}: The maximum number of packets sent/received =
by
>> the
>> +    specified virtqueue before a TX/RX notification.
>> +\item \field{usecs}: The maximum number of TX/RX usecs that the specifi=
ed
>> +    virtqueue delays a TX/RX notification.
>> +\item \field{vqn}: The virtqueue number of the specified virtqueue.
>> +\end{itemize}
>> +
> The virtqueue number of the enabled transmit or receive virtuqueue.
> This will simplify below description.

Good opinion, I like this better.

>> +The range of \filed{vqn} is between 0 and 0xFFFF inclusive, $ \lfloor
>> +vqn / 2 \rfloor $ is the index of the corresponding receiveq, and
>> +$\lfloor (vqn / 2) + 1 \rfloor $ is the corresponding tranmitq.
>> +
> Please add short description something like,
>
> When the driver prefers to use per virtqueue notifications coalescing, an=
d if queue group (transmit or receive) level notification coalescing is ena=
bled, driver SHOULD first disable device level notification coalescing.

I think this is more in line with what netdim does, I'll add this.

Thanks.

> Or it should be,
>
> Virtqueue level notifications coalescing, and device level notifications =
can be enabled together.
> When both of them are enabled, per virtqueue notifications coalescing tak=
e priority over queue group level.
>
> With rests of the comments from Michael and Alvaro in progress, looks goo=
d.
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

