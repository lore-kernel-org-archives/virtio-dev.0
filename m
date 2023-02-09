Return-Path: <virtio-comment-return-4088-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <eea0ca26-99c7-c5d7-a0e3-c6a37951f544@linux.alibaba.com>
Date: Thu, 9 Feb 2023 13:20:33 +0800
MIME-Version: 1.0
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
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB54817A1F42DAB9C24D0B73B2DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH v7] virtio-net:
 support inner header hash
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/8 =E4=B8=8B=E5=8D=888:21, Parav Pandit =E5=86=99=E9=81=93:
>> From: Heng Qi <hengqi@linux.alibaba.com>
>> Sent: Wednesday, February 8, 2023 1:11 AM
>>
>>
>> =E5=9C=A8 2023/2/8 =E4=B8=8B=E5=8D=881:18, Parav Pandit =E5=86=99=E9=81=
=93:
>>>> From: Heng Qi <hengqi@linux.alibaba.com>
>>>> Sent: Tuesday, February 7, 2023 10:25 PM
>>> [..]
>>>>>> Do you think we need both hash_types and hash_tunnel_types?
>>>>> In struct virtio_net_config we need two fields.
>>>>> a. supported_hash_types (already exists) b.
>>>>> supported_hash_tunnel_type
>>>>> -> bitmap indicating for which outer headers, inner hash calculation
>>>>> -> is
>>>> supported.
>>>>
>>>> Thanks for the suggestion, we seem to have reached an agreement.
>>>>
>>>>> In struct virtio_net_hdr we need two fields.
>>>>> a. hash_report (already exists)
>>>>> b. hash_tunnel_type 8 bits -> absolute value indicating which outer
>>>>> header
>>>> exists when inner header hash calculated.
>>>>> You already have it in your patch named as hash_report_tunnel.
>>>>> May be better to name as hash_report_tunnel_type to make it clearer
>>>>> that its
>>>> type.
>>>>
>>>> Sure.
>>>>
>>>> Thanks for your reply.
>>> I had one last question. Why do we need to inform the
>> hash_report_tunnel_type of the outer header in the virtio_net_hdr?
>>> Is this for debug? Or is there a use case that will process this value?
>> The driver may use it to do some statistical information, or do some rx
>> classification based on the rx hash, and we'd better not hide informatio=
n from
>> the driver.
>>
> Statistical information is better gathered via stats, instead of adding s=
uch code in driver data path.

A cautionary note : the source of hash_report_tunnel comes from the=20
discussion here=20
https://lists.oasis-open.org/archives/virtio-dev/202211/msg00063.html .
If I understand correctly, if virtio-net-hdr also has=20
hash_report_tunnel, how does the driver do statistics?

CC Yuri for some opinions.

Thanks.

>
> It is not about hiding.
> It has onus on the data path to detect the tunnel type and place that vir=
tio_net_hdr.
> So lets find one use of it in data path which sw entity will use it.
>
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

