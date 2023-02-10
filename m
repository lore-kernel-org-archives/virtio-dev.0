Return-Path: <virtio-comment-return-4136-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <2376afaa-8d81-500a-cffb-b86fca1a6bc8@linux.alibaba.com>
Date: Fri, 10 Feb 2023 19:24:56 +0800
MIME-Version: 1.0
References: <20230210070130.21811-1-hengqi@linux.alibaba.com>
 <CAJs=3_BbbzsYApYkdeZ4+vTcZ9qE+4eG-yDJJ_ZW3vdJEn-drQ@mail.gmail.com>
 <20230210043631-mutt-send-email-mst@kernel.org>
 <6a3dd0a1-d597-8e12-e0e5-0a8817e097b0@linux.alibaba.com>
 <CAJs=3_D2Sx8f4BXGoK3LEJ9Lcv9wVMqA45OaJvtA0Xt7kuFD+g@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CAJs=3_D2Sx8f4BXGoK3LEJ9Lcv9wVMqA45OaJvtA0Xt7kuFD+g@mail.gmail.com>
Subject: Re: [virtio-comment] [PATCH v2] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/10 =E4=B8=8B=E5=8D=886:16, Alvaro Karsz =E5=86=99=E9=81=93=
:
>>>> So, should we remove VIRTIO_NET_F_CTRL_VQ here, or fix VIRTIO_NET_F_HO=
ST_ECN?
>>> Ah good point.
>>> But I think  VIRTIO_NET_F_VQ_NOTF_COAL should not depend on VIRTIO_NET_=
F_NOTF_COAL.
>>> This way devices can drop the all-rx/all-tx commands if they want to.
>> We need to confirm this. If we make VIRTIO_NET_F_VQ_NOTF_COAL
>> independent of VIRTIO_NET_F_NOTF_COAL,
>> do we need to give vqn a special value so that the driver can also have
>> the fast path of sending all queues with global settings via
>> VIRTIO_NET_F_VQ_NOTF_COAL?
> IMO we don't need a special vqn value.
> A device that can modify all the vqs should offer VIRTIO_NET_F_NOTF_COAL.

That's clear, thanks for the quick reply.
Have a great weekend!


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

