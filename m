Return-Path: <virtio-comment-return-4355-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <3dd44592-1481-86c8-0612-67d4479c6655@linux.alibaba.com>
Date: Sat, 18 Feb 2023 00:32:46 +0800
MIME-Version: 1.0
References: <20230208090836.74355-1-hengqi@linux.alibaba.com>
 <20230213171113-mutt-send-email-mst@kernel.org>
 <b7fb5b84-2939-3d4d-b12f-998ce238ea21@linux.alibaba.com>
 <20230216064509-mutt-send-email-mst@kernel.org>
 <fe901a5a-bd78-640a-bcb9-8b13d309a680@linux.alibaba.com>
 <20230217092215-mutt-send-email-mst@kernel.org>
 <20230217153614.GA117623@h68b04307.sqa.eu95>
 <PH0PR12MB5481F2A332FF5765EF9F8FFFDCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB5481F2A332FF5765EF9F8FFFDCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH v8]
 virtio-net: support inner header hash
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2023/2/18 =E4=B8=8A=E5=8D=8812:24, Parav Pandit =E5=86=99=E9=81=
=93:
>> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> =
On
>> Behalf Of Heng Qi
> [..]
>
>> We assume that hash_report_tunnel_types is still present in the next ver=
sion,
> I am little lost.

Hi, Parav.

You are not lost. I'm just answering some of Michael's questions and=20
making assumptions. :)

> I thought we all agreed that reporting just the tunnel type in data path =
path virtio_net_hdr is not useful to sw.
> And hence we should omit in the virtio_net_hdr.
>
> Did I miss the motivation to add it back?
> If not, probably it is better to review and discuss v9 without it, which =
will be easier to discuss.
>
>> but it only exists in virtio net hdr and should be populated by the devi=
ce after
>> the hash calculation. hash_tunnel_types already controls whether the dev=
ice
>> computes internal header hashes.
>>
>>>> I don't really follow this, hash_report_tunnel_type is better off
>>>> keeping it "report" literally.
>>>
>>> Talking about VIRTIO_NET_F_HASH_TUNNEL here. Not
>>> hash_report_tunnel_type.

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

