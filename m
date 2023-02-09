Return-Path: <virtio-comment-return-4077-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <b0afe30f-a75a-e138-7319-9270cee470d3@linux.alibaba.com>
Date: Thu, 9 Feb 2023 11:16:29 +0800
MIME-Version: 1.0
References: <1675823090.089496-2-xuanzhuo@linux.alibaba.com>
 <3a1dbf6f-48ab-1eba-7f31-27e782a7ff12@linux.alibaba.com>
 <20230208091334-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B432271067C449CB7725DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094015-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4BEC03ACB994794AB51DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094504-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FA44C4FF2EB6569BE66BDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_D_Of4kMOr9+YobXHptUYUcP4UjqT8fM+zbvAdZ1uc_5A@mail.gmail.com>
 <20230208154819-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810798C047E97434BCB9B4DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_D9fbXN6Sonn9jnOoVLd0P+HcxWB7TxRqP4CBqot4eKjg@mail.gmail.com>
 <PH0PR12MB5481FBD525D714CB5B1D3ABBDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_DFp=BNObtzB=x0Gprwcr-tCS2zEeJaRogZL-GdbUvP6Q@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CAJs=3_DFp=BNObtzB=x0Gprwcr-tCS2zEeJaRogZL-GdbUvP6Q@mail.gmail.com>
Subject: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [PATCH] virtio-net: support
 per-queue coalescing moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Alvaro Karsz <alvaro.karsz@solid-run.com>, Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/9 =E4=B8=8A=E5=8D=886:35, Alvaro Karsz =E5=86=99=E9=81=93:
>>> From: Alvaro Karsz <alvaro.karsz@solid-run.com>
>>> Sent: Wednesday, February 8, 2023 4:56 PM
>>>> Alvaro,
>>>> Do you know if any software used it? Can you get some real data?
>>> I implemented this feature in our DPU, so at least 1 vendor is using th=
is feature
>> But which software (virtio net driver) in which OS is using this?
> Sorry, I'm not sure I understand your question.
>
> The feature is implemented in the linux kernel
> https://github.com/torvalds/linux/commit/699b045a8e43bd1063db4795be685bfd=
659649dc
> So we'll always have kernel versions accepting this feature, if offered.
>
>>> (I will add support for the per vq command of course).
>>> I really don't know about other vendors..
>>>
>>> You are suggesting to reserve the command and feature bit for safety, s=
o, if we
>>> reserve them, why not just use them? What do we lose here?
>>>
>> If it is used by some unknown software, only that sw breaks by using non=
 release spec.
>> If we use it by changing the definition, it may break that unknown sw.
>> If we know there is no known sw, we are better of with redefinition (by =
adding vqn, and by removing tx,rx from it).
>>
>>> Not having this feature/command even complicates things now that we are
>>> talking about removing the RX and TX from the per vq command, how do yo=
u
>>> change parameters to all TX queues? to all RX queues? we'll need 2 spec=
ial
>>> indexes, so we now need le32 to hold the queue index.
>> No need for special index.
>> How does a driver disable all queues or reset all queues? -> One by one.
>> So if user want to change for all TXQ, sw can do it one by one by iterat=
ing TXQ vqns.
> Yes, but resetting the queues doesn't require a control command.
> If a server has 64K queues, and a user wants to set all coalescing
> parameters to X (maybe with ethtool), it will generate 64K control
> commands..

At least our hardware design doesn't expect that.

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

