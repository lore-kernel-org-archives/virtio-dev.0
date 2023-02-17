Return-Path: <virtio-comment-return-4356-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <ab41026f-36e2-f95e-be99-09a5c580497d@linux.alibaba.com>
Date: Sat, 18 Feb 2023 00:36:02 +0800
MIME-Version: 1.0
References: <20230216144301.57728-1-hengqi@linux.alibaba.com>
 <CAJs=3_AS5qZ5ZcHWod+U5NSQazmZNgMkMvqGghr3aNsqSapRFA@mail.gmail.com>
 <20230217093110.GA124425@h68b04307.sqa.eu95>
 <CAJs=3_B95eUsMRqsY+4u0R77HQVntP44CpR+iMfNL-NbW5jHfw@mail.gmail.com>
 <20230217045446-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230217045446-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [PATCH v3]
 virtio-net: support the virtqueue coalescing moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2023/2/17 =E4=B8=8B=E5=8D=886:07, Michael S. Tsirkin =E5=86=99=E9=
=81=93:
> On Fri, Feb 17, 2023 at 11:40:15AM +0200, Alvaro Karsz wrote:
>>>> Maybe we can use struct virtio_net_ctrl_coal inside struct
>>>> virtio_net_ctrl_coal_vq instead of repeating max_usecs and
>>>> max_packets?
>>>> I'm not sure if it would be confusing, what do you think?
>>>>
>>> Hi Alvaro.
>>>
>>> I guess you mean one of the following two forms:
>>>
>>> #1
>>> struct virtio_net_ctrl_coal {
>>>      le32 max_packets;
>>>      le32 max_usecs;
>>> };
>>>
>>> struct virtio_net_ctrl_coal_vq {
>>>      le16 vqn;
>>>      le16 reserved;
>>>      struct virtio_net_ctrl_coal coal;
>>> } coal_vq;
>>>
>>> #2
>>> struct virtio_net_ctrl_coal {
>>>      le32 max_packets;
>>>      le32 max_usecs;
>>>      le16 vqn; // if _F_VQ_NOTF_COAL is negotiated
>>>      le16 reserved; // if _F_VQ_NOTF_COAL is negotiated
>>> };
>>>
>>> If it's #1, I think the format is a bit ugly, it's not semantic to use =
coal_vq to send global commands when _F_VQ_NOTF_COAL is not negotiated, and=
 the presence of vqn and reserved is awkward.
>>> If it's #2, I think this is a bit like the v1 version, using virtio_net=
_ctrl_coal as a virtual queue to send commands does not seem to be semantic=
, but it is indeed more unified in function.
>>>
>>> I think we should hear from Michael and Parav.
>>>
>> I meant #1.
>> We can see virtio_net_ctrl_coal as a struct holding coalescing
>> parameters, regardless of the commands.
>> Yes, let's wait for more comments on that.
> Reusing virtio_net_ctrl_coal is a nice thought. Makes it a bit clearer
> these have exactly the same role.
> Whether to put vqn first or last does not matter imho.
>
>>>>> +Virtqueue coalescing parameters:
>>>>> +\begin{itemize}
>>>>> +\item \field{vqn}: The virtqueue number of the enabled transmit or r=
eceive virtqueue, excluding the control virtqueue.
>>>>> +\item \field{max_packets}: The maximum number of packets sent/receiv=
ed by the specified virtqueue before a TX/RX notification.
>>>>> +\item \field{max_usecs}: The maximum number of TX/RX usecs that the =
specified virtqueue delays a TX/RX notification.
>>>>> +\end{itemize}
>>>>> +
>>>>> +\field{reserved} is reserved and it is ignored by the device.
>>>>> +
>>>> max_packets is the same with VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and with
>>>> VIRTIO_NET_CTRL_NOTF_COAL_[T/R]X_SET.
>>>> ("Maximum number of packets to receive/send before a RX/TX notificatio=
n").
>>>> The fact that this is applied to all VQs or to a specific one is
>>>> derived from the command.
>>>> Same for max_usecs.
>>>> Maybe we can join the coalescing parameters somehow instead of
>>>> repeating the explanations?
>>>>
>> Any thoughts on this part?
> I think I agree. Generally I think we should first of all describe the
> new VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, moving all explanation text
> to that.
>
> Then just explain that VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET have the same effect
> as VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET repeated for
> all currently enabled tx/rx vqs.
> Plus maybe a single annotated example where there's a mix of
> VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, VIRTIO_NET_CTRL_NOTF_COAL_RX_SET and
> VIRTIO_NET_CTRL_NOTF_COAL_TX_SET commands. For example with 2 vq pairs:
>
> 1. VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets for vq 0 and 2, vq 1 and 3 retai=
n reset value
> 2. VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET sets vq 0, vq 2 retains value from 1
> 3. VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET sets vq 1, vq 3 retains reset value
> 4. VIRTIO_NET_CTRL_NOTF_COAL_TX_SET overrides command 3
>
> no need for many examples.


Good idea. This is a clear and comprehensive example.

Thanks.


>

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

