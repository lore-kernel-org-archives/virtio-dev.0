Return-Path: <virtio-comment-return-4359-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Fri, 17 Feb 2023 17:22:14 +0000
Message-ID: <PH0PR12MB54813C226BA858219F345681DCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230216144301.57728-1-hengqi@linux.alibaba.com>
 <20230216111552-mutt-send-email-mst@kernel.org>
 <20230217052404.GA114259@h68b04307.sqa.eu95>
 <20230217053039-mutt-send-email-mst@kernel.org>
 <CAJs=3_B7snyMbjfL3vaKKe3wfx2XomLeVzCiCPNxFpy_ZTbepA@mail.gmail.com>
 <20230217062539-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815528B92662843B750D3ADCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230217171704.GB117623@h68b04307.sqa.eu95>
In-Reply-To: <20230217171704.GB117623@h68b04307.sqa.eu95>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [virtio-dev] Re: [PATCH v3] virtio-net: support the virtqueue
 coalescing moderation
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Friday, February 17, 2023 12:17 PM

> Yes, but there seems to be such a situation: when the device is reactivat=
ed, as
> the specification says, all parameters are set to 0 (use parameters as th=
e default
> configuration on the device).
> When CTRL_COAL_SET and CTRL_COAL_VQ_SET are sent, the configuration is
> updated (the parameters of each vq may be different, but the global param=
eter
> configuration may be recorded), at this time, if vq is reset, should the
> parameters be 0 or a recorded global parameters after it is re-enabled?

Recorded global parameters should be fine to report on an enabled vq even i=
f the COAL_VQ_SET was not done.
This is because the global value reflects on the VQ.


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

