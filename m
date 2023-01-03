Return-Path: <virtio-comment-return-3667-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 3 Jan 2023 18:00:23 +0000
Message-ID: <PH0PR12MB54810EB7CF7C296FA09B8E7CDCF49@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230101180824.325172-1-parav@nvidia.com>
 <20230103054425-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EDF2A7DE69145E93ECDEDCF49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230103091842-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D2990D83282101967A8CDCF49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230103104223-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AAC2F0B95074EE0CFA08DCF49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230103111801-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C5DBA7808E4754FCE4FEDCF49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230103115138-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230103115138-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [PATCH v1 00/20] Split device spec to its individual files
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, January 3, 2023 11:52 AM
>=20
> On Tue, Jan 03, 2023 at 04:41:33PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, January 3, 2023 11:19 AM
> > >
> > > On Tue, Jan 03, 2023 at 04:04:11PM +0000, Parav Pandit wrote:
> > > >
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Tuesday, January 3, 2023 10:44 AM
> > > >
> > > >
> > > > > > I was writing up reply to other thread at the moment.
> > > > > > But lets continue here since you ask.
> > > > > > I don't have a strong opinion, but I find directories neat.
> > > > > > This is because we have many devices spec files, conformance
> > > > > > files and it's
> > > > > expected to grow.
> > > > > > I have transports directory and place code in there.
> > > > > > Since latex spec doesn't have good way to include and refer
> > > > > > sub section, we
> > > > > have many files.
> > > > > > 19 devices * 3 spec files + 3 transports * 3 spec files.
> > > > > >
> > > > > > And once spec is in its own directory, things should be self-su=
fficient.
> > > > > > Only touch points will be in common areas which should be less
> frequent.
> > > > > > WDYT?
> > > > >
> > > > > Yea I know. It's just that one of the ways we publish is a
> > > > > directory in a web browser
> > > > Do you mean browsing https://github.com/oasis-tcs/virtio-spec/ in
> > > > a web
> > > browser?
> > >
> > > No, the one at oasis:
> > >
> > > https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/tex/
> > >
> > > this is technically the authoritative one.
> > >
> > Ok. I get it.
> > Shall we continue with currently proposed directory?
>=20
>=20
> I'll let you decide, either post a new version or propose a new one. In a=
ny case
> request a vote and I'll start it.

Ok. I will keep it in its current form.

I do not have any access rights to create ballot at [1].
I requested for vote at https://github.com/oasis-tcs/virtio-spec/issues/153=
.

I believe you will be able to start the ballot at [1].

[1] https://www.oasis-open.org/apps/org/workgroup/virtio/ballots.php

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

