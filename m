Return-Path: <virtio-comment-return-4007-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <9e3255d4-9517-f54e-6125-e52bf3c4e87e@linux.alibaba.com>
Date: Wed, 8 Feb 2023 10:20:08 +0800
MIME-Version: 1.0
References: <20230207111634.75542-1-hengqi@linux.alibaba.com>
 <CAJs=3_DXNf0LTXwcY9dNgZJYxkpThhM8o=1KwDNf6+SLdssU-Q@mail.gmail.com>
 <1675770628.725382-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C388B551B89D89747F1CDCDB9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230207092439-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230207092439-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-comment] Re: [PATCH] virtio-net: support per-queue
 coalescing moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/7 =E4=B8=8B=E5=8D=8810:29, Michael S. Tsirkin =E5=86=99=E9=
=81=93:
> On Tue, Feb 07, 2023 at 12:51:26PM +0000, Parav Pandit wrote:
>>> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> Sent: Tuesday, February 7, 2023 6:50 AM
>>>
>>> On Tue, 7 Feb 2023 13:25:13 +0200, Alvaro Karsz <alvaro.karsz@solid-run=
.com>
>>> wrote:
>>>> Hi Heng,
>>>>
>>>>> Currently, the coalescing profile is directly applied to all queues.
>>>>> This patch supports configuring the parameters for a specified queue.
>>>>>
>>>>> When the traffic between queues is unbalanced, for example, one
>>>>> queue is busy and another queue is idle, then it will be very useful
>>>>> to control coalescing parameters at the queue granularity.
>>>>>
>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>>> ---
>>>>>   content.tex | 49 ++++++++++++++++++++++++++++++++++++++++++-------
>>>>>   1 file changed, 42 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/content.tex b/content.tex index e863709..049c0e4 100644
>>>>> --- a/content.tex
>>>>> +++ b/content.tex
>>>>> @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device
>>>>> Types / Network Device / Feature bits
>>> \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>>>>>       channel.
>>>>>
>>>>> +\item[VIRTIO_NET_F_PERQUEUE_NOTF_COAL(52)] Device supports per-
>>> queue
>>>>> +       notifications coalescing.
>>>>> +
>>>> Since this feature allows us to change the coalescing parameters for
>>>> all the queues when rx/tx_qid =3D 0xFFFF, and since version 1.3 wasn't
>>>> released yet, maybe the "per-vq" functionality can be added to
>>>> VIRTIO_NET_F_NOTF_COAL instead of adding a new feature?
>>>
>>> According to my understanding, all the features of voting are formal. I=
t can be
>>> used by the manufacturer.
>>>
>>> Of course, as far as I know, no manufacturer has used this feature for =
the time
>>> being. But I think we should add a new feature.
>>>
>>> Or other people have other ideas.
>> I believe we should treat it as fix and avoid a new feature bit as spec =
is not released, and it is very recent change.
> Arguably it's true.
> It will all be up to the committee vote of course ...
> To keep things a bit safer how about we just allow commands
> without qid instead of a special qid value?

Good idea, the new command seems to make compatibility easier to achieve.
An error can be returned when the old device does not recognize the new=20
command.

> Also if we are going to change things how about adding a query command to=
o?

Yes, we should.

Thanks.

>
> Also Alvaro what is your take on whether the gloabal version counts
> packets and time for all queues together or per queue? The spec
> does not make it clear ATM.
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

