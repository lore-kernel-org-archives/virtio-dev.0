Return-Path: <virtio-comment-return-4012-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <baf28278-2240-a967-dee3-d40ec91284be@linux.alibaba.com>
Date: Wed, 8 Feb 2023 10:35:38 +0800
MIME-Version: 1.0
References: <20230207111634.75542-1-hengqi@linux.alibaba.com>
 <20230207090019-mutt-send-email-mst@kernel.org>
 <1675820731.3018508-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54810448CDA1F3A21B283AF1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB54810448CDA1F3A21B283AF1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-comment] Re: [virtio-dev] RE: [virtio-comment] [PATCH] virtio-net: support
 per-queue coalescing moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/8 =E4=B8=8A=E5=8D=8810:20, Parav Pandit =E5=86=99=E9=81=93=
:
>> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> Sent: Tuesday, February 7, 2023 8:46 PM
>>
>> On Tue, 7 Feb 2023 09:06:19 -0500, "Michael S. Tsirkin" <mst@redhat.com>
>> wrote:
>>> On Tue, Feb 07, 2023 at 07:16:34PM +0800, Heng Qi wrote:
>>>> Currently, the coalescing profile is directly applied to all queues.
>>>> This patch supports configuring the parameters for a specified queue.
>>>>
>>>> When the traffic between queues is unbalanced, for example, one
>>>> queue is busy and another queue is idle, then it will be very useful
>>>> to control coalescing parameters at the queue granularity.
>>> ethtool does not support this though, does it? what's the plan?
>>
>> Although it can be done, I think it is difficult to let users use ethtoo=
l to modify
>> the parameters of each queue.
>>
>> At present ethtool supports adaptive-rx/adaptive-tx. This is that the dr=
iver
>> automatically adapted to the appropriate parameter. Generally, it is
>> implemented using netdim in the driver. At this time, this interface is =
needed.
>>
>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> What I dislike about this interface is that if
>>> VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, then in the common
>> case
>>> of same parameters for all queues driver has to issue multiple
>>> commands.
>>> I can see either a special vq index (0xffff ?) or a special command
>>> used to set it for all queues.
>> Although the structure is very similar, in fact, adding a new command ma=
y be
>> clearer.
> O(N) loop is not that bad when user want to issue change it per device, a=
s this is something done very often.

However, a global configuration requires sending a command for each=20
queue, which makes the device suffer.
I think the hardware might not want this.

Thanks.

> Once per VQ is supported, driver may just use the default net-dim to have=
 best out of box experience, whenever device supports it.
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

