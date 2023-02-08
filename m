Return-Path: <virtio-comment-return-4046-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 8 Feb 2023 14:44:37 +0000
Message-ID: <PH0PR12MB5481C4BEC03ACB994794AB51DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230207111634.75542-1-hengqi@linux.alibaba.com>
 <20230207090019-mutt-send-email-mst@kernel.org>
 <1675820731.3018508-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54810448CDA1F3A21B283AF1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1675823090.089496-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481EF640830788A2B6D62D2DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3a1dbf6f-48ab-1eba-7f31-27e782a7ff12@linux.alibaba.com>
 <20230208091334-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B432271067C449CB7725DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094015-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230208094015-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: RE: [virtio-comment] [PATCH] virtio-net: support per-queue coalescing
 moderation
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open .
 org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, February 8, 2023 9:43 AM
>=20
> On Wed, Feb 08, 2023 at 02:37:55PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, February 8, 2023 9:18 AM
> > >
> > > On Wed, Feb 08, 2023 at 07:30:34PM +0800, Heng Qi wrote:
> > > > > I see two options.
> > > > > 1. Just have per VQ params. Software has the full knowledge of
> > > > > in which it is
> > > operating, and state remains at software level.
> > > > > This effectively achieves both the mode.
> > > > >
> > > > > 2. Have a mode cmd,
> > > > > Mode =3D (a) per device or (b) per VQ (c) disable After the mode
> > > > > is set, driver can set per device or per VQ.
> > > >
> > > > I find this more clear.
> > > >
> > > > Thanks.
> > > >
> > >
> > > Rereading this I think I misunderstood the proposal.
> > > Now we are burning memory on maintaining mode, and this information
> > > is duplicated.
> > >
> > It is not maintained in the pci resident memory, so it doesn't hurt.
> >
> > > I'd say let's just add a new command COAL_QUEUE_SET with vqn as
> parameter.
> > > Existing commands are simply defined as a shortcut to running
> > > COAL_QUEUE_SET on all tx/rx queues respectively.
> > >
> > > Latest command dictates the parameters. To disable just set
> > > everything to 0 (btw we should make this explicit in the spec, but it=
 can be
> guessed from:
> > > Upon reset, a device MUST initialize all coalescing parameters to 0.
> > > )
> > >
> > Switching between the modes (per q vs per device) implicitly is ambiguo=
us
> and it only means device may need to iterate.
>=20
> hmm i feel it's only ambiguous because i failed to explain in well.
>=20
> > This state is either better maintained in sw by always having per vq or=
 have
> clearly defined mode of what device should do.
> >
> > Per Q is very common even for several years old devices.
> > Last time I counted, there were at least 15 such devices supporting it.
> >
> > So actual usage wise, I practically see that most implementations will =
end up
> with per vq mode.
> > I like to hear from Heng or Alvaro if they see any use of per device.
>=20
>=20
> Right so given this, most devices will be in per queue mode all the time.=
 why do
> you want a mode then? just keep per queue.
> existing commands are kept around for compat but internally just translat=
e to
> per-queue.
Since the space is not released, do we need to keep the compat?

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

