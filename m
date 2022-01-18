Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Date: Tue, 18 Jan 2022 07:21:02 +0000
Message-ID: <PH0PR12MB54812D3C38DE9E8E1B4E4BE7DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220113102218-mutt-send-email-mst@kernel.org>
 <eaf88f9c-8b51-7758-90c0-c1a92df35061@nvidia.com>
 <20220113121203-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B90FF747D56377A0A850DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220117170442-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818033A0BD96EA9493C51ADC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118011731-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816DB30F23511266B8F35EDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118014737-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B99E351B624A27378BC5DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118021228-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220118021228-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, January 18, 2022 12:44 PM
>=20
> On Tue, Jan 18, 2022 at 07:07:03AM +0000, Parav Pandit wrote:
> > Can you please review current proposal as well before we revise v2?
>=20
> I think what you listed amounts to a significant rework and will make thi=
ngs
> easier to review. Not 100% sure you need more feedback at this point.

With=20
(a) the motivation that Jason mentioned for config vqs, vectors etc,
(b) the msix config/query of this proposal
(c) your description to handle them in uniform way,
(d) understanding the scale inefficiency, on-die resources, multiple outsta=
nding cmds discussion in the thread,

I would like to receive feedback that we all agree to configure these value=
s via AQ.

Rest of the plumbing on AQ etc to address comments to complete in v2, once =
this looks ok.

