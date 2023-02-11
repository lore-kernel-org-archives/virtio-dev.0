Return-Path: <virtio-comment-return-4142-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <940a42e1-9030-3965-7700-ac61db74ee1a@linux.alibaba.com>
Date: Sat, 11 Feb 2023 10:08:55 +0800
MIME-Version: 1.0
From: Heng Qi <hengqi@linux.alibaba.com>
References: <20230104071401.31746-1-hengqi@linux.alibaba.com>
 <20230111042905-mutt-send-email-mst@kernel.org>
 <20230116080106.GA114763@h68b04307.sqa.eu95>
 <f7e5a6c8-ad4c-c60c-2d9e-cd64f6fdd90e@redhat.com>
 <20230131052834.GA34480@h68b04307.sqa.eu95>
 <5bee268d-a0dc-d649-4174-7b211a49e2f0@linux.alibaba.com>
 <PH0PR12MB5481CA073B96CC2828F8AA15DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <52ddcc45-70e0-a670-9ac2-215e84eb12ba@linux.alibaba.com>
 <PH0PR12MB5481F054A6BA5C10831F0AA8DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <98ffa453-7a76-9afc-1861-8c46efef4705@linux.alibaba.com>
 <PH0PR12MB54817A1F42DAB9C24D0B73B2DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <eea0ca26-99c7-c5d7-a0e3-c6a37951f544@linux.alibaba.com>
 <PH0PR12MB5481A67E9B1362BB18CEDDC4DCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <bee507bc-4b85-9885-a2e7-c0c9c25671ff@linux.alibaba.com>
In-Reply-To: <bee507bc-4b85-9885-a2e7-c0c9c25671ff@linux.alibaba.com>
Subject: Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH
 v7] virtio-net: support inner header hash
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Any more discussions or comments? Please let me know if this is OK with you=
.
and the v8 version is released at
[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00094.html

Thanks.

=E5=9C=A8 2023/2/9 =E4=B8=8B=E5=8D=885:57, Heng Qi =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2023/2/9 =E4=B8=8B=E5=8D=881:34, Parav Pandit =E5=86=99=E9=81=
=93:
>>> From: Heng Qi <hengqi@linux.alibaba.com>
>>> Sent: Thursday, February 9, 2023 12:21 AM
>>>>>>> Thanks for your reply.
>>>>>> I had one last question. Why do we need to inform the
>>>>> hash_report_tunnel_type of the outer header in the virtio_net_hdr?
>>>>>> Is this for debug? Or is there a use case that will process this=20
>>>>>> value?
>>>>> The driver may use it to do some statistical information, or do some
>>>>> rx classification based on the rx hash, and we'd better not hide
>>>>> information from the driver.
>>>>>
>>>> Statistical information is better gathered via stats, instead of=20
>>>> adding such code
>>> in driver data path.
>>>
>>> A cautionary note : the source of hash_report_tunnel comes from the
>>> discussion here
>>> https://lists.oasis-open.org/archives/virtio-dev/202211/msg00063.html
>>> If I understand correctly, if virtio-net-hdr also has=20
>>> hash_report_tunnel, how
>>> does the driver do statistics?
>> I am asking to avoid having hash_report_tunnel in virtio_net_hdr if=20
>> it is only for the statistics purpose.
>
> Parav, I don't seem to follow this.
>
> Note that the hash_report(le16) and padding reserved(le16) fields only=20
> exist when VIRTIO_NET_F_HASH_REPORT is negotiated,
> and hash_report_tunnel only uses the first 8 bits of padding_reserved,=20
> which does not add any overhead.
>
> Whether to reuse hash_report or use the new hash_report_tunnel=20
> initially has been discussed:=20
> https://lists.oasis-open.org/archives/virtio-dev/202211/msg00065.html .
>
>> If it has more use than just statistics, I like to understand its use=20
>> in rx packet processing flow, if there is any and to describe in=20
>> commit log too.
>
> I think there are still some important points, such as the kernel or=20
> driver forwards the packet,
> and the hash value is used when selecting the queue, but at this time=20
> they want to know whether
> the hash value comes from the inner or outer header.
> What if it doesn't want to forward based on the hash calculated by the=20
> inner header, but only uses the hash calculated by the outer header?
>
> Thanks.
>
>> Below [1] says about driver doing some rx classification. It is=20
>> unclear on inner or outer.
>> The response is not very clear to me, about how this field is useful.
>>
>> [1]=20
>> https://lists.oasis-open.org/archives/virtio-dev/202211/msg00063.html
>>
>> If driver needs to know the statistics of it, it can query them from=20
>> the device by introducing statistics cmd.
>
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
> List Guidelines:=20
> https://www.oasis-open.org/policies-guidelines/mailing-lists
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

