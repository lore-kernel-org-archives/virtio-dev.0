Return-Path: <virtio-comment-return-3976-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 7 Feb 2023 00:40:53 +0000
Message-ID: <PH0PR12MB5481BE89CD0FCB0F1EEC54FFDCDB9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230206084746.40536-1-alvaro.karsz@solid-run.com>
 <PH0PR12MB54817FE12FD77CC74B36D136DCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230206160206-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818A5BD25527FEAEAFF6CCDCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <efbd1f5a-8e85-295d-d790-d361c7f8129b@linux.alibaba.com>
In-Reply-To: <efbd1f5a-8e85-295d-d790-d361c7f8129b@linux.alibaba.com>
MIME-Version: 1.0
Subject: RE: [virtio-comment] RE: [virtio-dev] [PATCH] virtio-net: Fix and
 update VIRTIO_NET_F_NOTF_COAL feature
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Monday, February 6, 2023 7:34 PM

> > Yes, it is per virtqueue because the coalescing commands are per virtqu=
eue.
> > Not sure explicitly keep adding per virtqueue in every line improves th=
e
> readability.
>=20
> Oh, what a coincidence! We are working with our hardware team on NetDIM,
> NetDIM needs to determine its own interrupt parameters based on the traff=
ic
> information of each queue, because it is not reasonable to use the traffi=
c of one
> queue to determine the interrupt moderation profile of all queues.
>=20
> We have preliminarily modified the virtio specification and will issue it=
 today or
> tomorrow, please wait for review.
>=20
> Thanks! :)
>=20
Right.
Awesome.
Looking forward for the fix.

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

