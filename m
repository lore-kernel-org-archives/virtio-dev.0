Return-Path: <virtio-comment-return-4270-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <dc451b84-e05e-b929-989d-976b6f61f5da@linux.alibaba.com>
Date: Thu, 16 Feb 2023 15:23:29 +0800
MIME-Version: 1.0
References: <20230208090836.74355-1-hengqi@linux.alibaba.com>
 <0f73e9c7-5080-d01c-0f63-dd23942fa71b@linux.alibaba.com>
 <PH0PR12MB54817EAF86DF11B9FB0DCB8EDCDD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230213172158-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230213172158-mutt-send-email-mst@kernel.org>
Subject: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [PATCH v8] virtio-net: support
 inner header hash
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Cornelia Huck <cohuck@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/14 =E4=B8=8A=E5=8D=886:23, Michael S. Tsirkin =E5=86=99=E9=
=81=93:
> On Mon, Feb 13, 2023 at 09:42:25PM +0000, Parav Pandit wrote:
>>
>>> From: Heng Qi <hengqi@linux.alibaba.com>
>>> Sent: Monday, February 13, 2023 8:05 AM
>>> Hi, all.
>>>
>>> Do you have any comments on this version?
>>>
>>> Thanks.
>>>
>>> =E5=9C=A8 2023/2/8 =E4=B8=8B=E5=8D=885:08, Heng Qi =E5=86=99=E9=81=93:
>>>> If the tunnel is used to encapsulate the packets, the hash calculated
>>>> using the outer header of the receive packets is always fixed for the
>>>> same flow packets, i.e. they will be steered to the same receive queue=
.
>>>>
>>>> We add a feature bit VIRTIO_NET_F_HASH_TUNNEL and related bitmasks in
>>>> \field{hash_tunnel_types}, which instructs the device to calculate the
>>>> hash using the inner headers of tunnel-encapsulated packets. Besides,
>>>> values in \field{hash_report_tunnel_types} are added to report tunnel =
types.
>>>>
>>>> Note that VIRTIO_NET_F_HASH_TUNNEL only indicates the ability of the
>>>> inner header hash, and does not give the device the ability to use the
>>>> hash value to select a receiving queue to place the packet.
>>>>
>> [..]
>>>> @@ -3384,9 +3396,10 @@ \subsection{Device Operation}\label{sec:Device
>>> Types / Network Device / Device O
>>>>            le16 csum_start;
>>>>            le16 csum_offset;
>>>>            le16 num_buffers;
>>>> -        le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT
>>> negotiated)
>>>> -        le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT
>>> negotiated)
>>>> -        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT
>>> negotiated)
>>>> +        le32 hash_value;              (Only if VIRTIO_NET_F_HASH_REPO=
RT
>>> negotiated)
>>>> +        le16 hash_report;             (Only if VIRTIO_NET_F_HASH_REPO=
RT
>>> negotiated)
>>>> +        u8 hash_report_tunnel_types;  (Only if VIRTIO_NET_F_HASH_REPO=
RT
>> I am yet to review the changes of v8.
>> But the quick response is, I do not see a use case of above field by sw =
driver.
>> And this addition requires the core hw data path to supply this value.
>> Without good motivation, it is hard to have it here.
> I think I agree that we should be careful about adding stuff in packet
> header. Yes it's using the padding but we only have 2 bytes of that.

I agree.

Cc Jason, do you think \field{hash_report_tunnel_type} has more=20
important capabilities?

Thanks.

>
>> What is valuable is to have a VNI already identified and coming to the d=
river, like a hash value.
>> This can cut down the cpu processing power, in outer header packet proce=
ssing.
>> However, that is relatively a different feature than inner hash.
>>
>> So, my input is to omit hash_report_tunnel_types.
>> Will respond to Michael question in other thread.
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

