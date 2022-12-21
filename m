Return-Path: <virtio-comment-return-3598-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <391e8549-adc2-8b0b-a9a3-f21f81c385d0@linux.alibaba.com>
Date: Wed, 21 Dec 2022 20:45:20 +0800
MIME-Version: 1.0
References: <20221221101729.648097-1-alvaro.karsz@solid-run.com>
 <1671620897.6449997-1-xuanzhuo@linux.alibaba.com>
 <CAJs=3_BJKqCRb6xJpcuR7U4SmHtO7QRFA1gtyiiPt2ik=rk9Sg@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CAJs=3_BJKqCRb6xJpcuR7U4SmHtO7QRFA1gtyiiPt2ik=rk9Sg@mail.gmail.com>
Subject: [virtio-comment] Re: [virtio-dev] [PATCH] virtio_net: support low and high rate of
 notification coalescing sets
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Alvaro Karsz <alvaro.karsz@solid-run.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: jasowang@redhat.com, mst@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2022/12/21 =E4=B8=8B=E5=8D=887:48, Alvaro Karsz =E5=86=99=E9=81=
=93:
> Hi,
>
>> I want to know which one is better than NetDim(Coalesce Adaptive) in dri=
ver.
>>
>> I know Heng Qi's work in this.
>>
>> Thanks
>
> Why choose? we can have both.
> ethtool can handle both pkt_rate_low/pkt_rate_high and
> use_adaptive_rx_coalesce/use_adaptive_tx_coalesce.
>
> The adaptive algorithm can even use this feature to set low and high
> coalescing sets.

Hi, all.


NetDIM is currently a mature library in the kernel. It uses the number=20
of bytes, PPS and interrupt rate

as samples to make an action, and it is performed independently in tx or=20
rx direction. Also, There will

be an extra worker to help us send the configuration based on the=20
control queue to avoid interrupting
the softirq. Although the method of pkt_rate_{low, high} params does not=20
conflict with dim, I seem

to have some doubts that the colasce parameters of the rx and tx=20
directions are determined at the

same time based on pkt_rate alone, will this be a problem?


Thanks.

>
> Alvaro


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

