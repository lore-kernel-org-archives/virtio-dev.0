Return-Path: <virtio-comment-return-4146-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <601ef040-bac2-dd6d-b32c-2029be17c071@linux.alibaba.com>
Date: Sat, 11 Feb 2023 18:00:58 +0800
MIME-Version: 1.0
References: <20230210070130.21811-1-hengqi@linux.alibaba.com>
 <PH0PR12MB548155EF2CB09C6C88B75C44DCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_Dy5HrQs0PaPjNvwCUe0oYs0AhsEMKHVyXyYujfaeacUw@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CAJs=3_Dy5HrQs0PaPjNvwCUe0oYs0AhsEMKHVyXyYujfaeacUw@mail.gmail.com>
Subject: Re: [virtio-comment] Re: [PATCH v2] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Alvaro Karsz <alvaro.karsz@solid-run.com>, Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/11 =E4=B8=8B=E5=8D=884:45, Alvaro Karsz =E5=86=99=E9=81=93=
:
>> Please add short description something like,
>>
>> When the driver prefers to use per virtqueue notifications coalescing, a=
nd if queue group (transmit or receive) level notification coalescing is en=
abled, driver SHOULD first disable device level notification coalescing.
>> Or it should be,
>>
> I disagree here.
> IMO "queue group level notification coalescing" is not something to
> enable or disable, but a shortcut to set all TX/RX queues at once.
> Why should the spec force a driver to "disable device level
> notification coalescing" (I assume you mean send a
> VIRTIO_NET_CTRL_NOTF_COAL_[T/R]X_SET command with zeros)?
> What if the driver sends a VIRTIO_NET_CTRL_NOTF_COAL_[T/R]X_SET
> command, and then a single queue traffic increases? why should it zero
> the parameters to all other queues?

Hi, Alvaro! Thanks for your reply!

I think Parav refers more to the scene where ethool sets parameters at=20
the queue group level and
the scene where netdim sets parameters for a single queue. In this=20
scenario, netdim should really
determine the coalescing parameters of the device, and the parameters at=20
the queue group level set
by ethtool should be ignored (many drivers are designed this way, such=20
as mlx), that is, we need to give netdim the right,
because it It has the ability to dynamically adjust parameters.=20
(However, I think this friendly constraint is also possible in driver=20
implementation.)

Of course, if we consider setting coalescing parameters at the queue=20
group level and single queue level separately through ethtool,
then as you said, we should not set any priority for them.

Back to reality, I think the function of ethtool to set single queue=20
parameters may come later, which is thankless for users because of netdim.

Therefore, if our specification tends to be practical, we can add=20
Parav's proposal, and if our specification tends to be more general,=20
then hand over
the constraints to the driver implementation. what do you think?

> I think that this should be discussed in the driver implementation
> stage, not in the spec.
>
>> Virtqueue level notifications coalescing, and device level notifications=
 can be enabled together.
>> When both of them are enabled, per virtqueue notifications coalescing ta=
ke priority over queue group level.
> How do you enable  Virtqueue level notifications coalescing? Why are
> they different entities?
> I don't think that we should have priorities, but the last command
> should be the one that dictates the coalescing parameters.
>
> For example, let's look at vq0 (RX):
> Device receives VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, vq0 should change
> the parameters accordingly (all RX vqs should do the same).
> Then device receives VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with vqn =3D 0,
> vq0 changes the parameters accordingly (all RX vqs are still using the
> "old" parameters)
> Then device receives VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, vq0 changes the
> parameters accordingly (all RX vqs should do the same).

Yes I see what you mean, thanks for the clear example. This should be=20
the second scenario I described above,
let's discuss how to solve it in the above reply.

Thanks! :)

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

