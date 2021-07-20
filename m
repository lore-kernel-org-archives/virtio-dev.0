Return-Path: <virtio-comment-return-2016-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <db6540cc-55f0-ec66-447a-4d70dcdc97bd@redhat.com>
References: <20210710163326-mutt-send-email-mst@kernel.org>
 <778ffa63-c0ca-2faa-32da-3c5e71dd1dfe@redhat.com>
 <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
 <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
 <YO1kQ8sBkr2eguvi@stefanha-x1.localdomain>
 <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
 <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
 <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
 <YO/8/LaHihUE1bhN@stefanha-x1.localdomain>
 <db6540cc-55f0-ec66-447a-4d70dcdc97bd@redhat.com>
Date: Tue, 20 Jul 2021 12:31:56 +0200
Message-ID: <87r1ft8eeb.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 16 2021, Jason Wang <jasowang@redhat.com> wrote:

> =E5=9C=A8 2021/7/15 =E4=B8=8B=E5=8D=885:16, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
>> Stopping
>> devices sequentially increases migration downtime, so I think the
>> interface should encourage concurrently stopping multiple devices.
>>
>> I think you and Cornelia discussed that an interrupt could be added to
>> solve this problem. That would address my concerns about the STOP bit.
>
>
> The problems are:
>
> 1) if we generate an interrupt after STOP, it breaks the STOP semantic=20
> where the device should not generate any interrupt
> 2) if we generate an interrupt before STOP, we may end up with race=20
> conditions

I think not all interrupts are created equal here.

For virtqueue notification interrupts, I agree. If the device is being
stopped, no notification interrupts will be generated.

For device interrupts in the general sense, banning these would make it
impossible to implement STOP for CCW, as any channel program (be it
RESET, READ_STATUS, or any new one) is required to generate a status
pending/interrupt when it is finished. I also don't see how that would
create a race condition for CCW.

Why can't we simply have an interrupt indicating completion of the STOP
request, and no further interrupts after that?


This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

