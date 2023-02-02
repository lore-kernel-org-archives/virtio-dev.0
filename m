Return-Path: <virtio-comment-return-3948-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <09780fbd-f4f4-ffbd-eddc-5cc874f2a36e@linux.alibaba.com>
Date: Thu, 2 Feb 2023 14:55:22 +0800
MIME-Version: 1.0
References: <20230104071401.31746-1-hengqi@linux.alibaba.com>
 <PH0PR12MB54813142D74C1328873435E2DCC79@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230131055710.GC34480@h68b04307.sqa.eu95>
 <PH0PR12MB5481A27116866CCE1000113FDCD19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230201015350-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548197725E16BC2B9954C926DCD69@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB548197725E16BC2B9954C926DCD69@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: Re: [virtio-comment] RE: [virtio-dev] [PATCH v7] virtio-net: support
 inner header hash
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-comment <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/2 =E4=B8=8A=E5=8D=8811:55, Parav Pandit =E5=86=99=E9=81=93=
:
>> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
>> open.org> On Behalf Of Michael S. Tsirkin
>> Sent: Wednesday, February 1, 2023 1:57 AM
>>> Also, this patch is adding two functionalities.
>>> 1. Inner header hash calculation of existing already defined hash
>>> types 2. outer header hash for new type for GRE,VXLAN,GENEVE.
>>> #1 should be in 1st patch.
>>> #2 should be in 2nd patch.
>>> This is better to review.
>> Parav, you come to this discussion pretty late. Asking to split up the p=
atch when
>> it's v1/v2 is ok. Asking after others have already reviewed v6 is not yo=
u are
>> making review easier for yourself but re-review harder for others who al=
ready
>> have a mind map of the patch.
>>
>> In this case unless we really want to enable these separately (and frank=
ly I don't
>> see a good reason to) then splitting it up makes review more confusing.
>>
> No. There is no need to enable it separately.
> It was hard to parse new inner type decoding addition which has close to =
zero relation to outer headers.
>
> As you say, it has some history, I don't have strong opinion to split.
> But going forward in subsequent work, it is better to see logical changes=
 in multiple patches.

It seems that we don't need to emphasize the outer header hash, which is th=
e
same behavior as usual when the inner header hash is not raised.

Thanks.



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

