Return-Path: <virtio-dev-return-10410-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 3 Jan 2023 14:26:15 +0000
Message-ID: <PH0PR12MB5481D2990D83282101967A8CDCF49@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230101180824.325172-1-parav@nvidia.com>
 <20230103054425-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EDF2A7DE69145E93ECDEDCF49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230103091842-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230103091842-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v1 00/20] Split device spec to its individual files
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, January 3, 2023 9:20 AM
>=20
> On Tue, Jan 03, 2023 at 02:15:37PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, January 3, 2023 5:47 AM
> > >
> > > On Sun, Jan 01, 2023 at 08:08:04PM +0200, Parav Pandit wrote:
> > > > Relatively several of the recent device specifications are
> > > > maintained in their own specification file. Such separate files
> > > > enables better maintenance of the specification overall.
> > > > However, several of the initial virtio device specifications are
> > > > located in single file.
> > > >
> > > > Hence, split them into their individual files.
> > > >
> > > > Additionally, each device's driver and device conformance is
> > > > present in one giant conformance file all together.
> > > >
> > > > As Michael suggest's move this device and driver conformance
> > > > section adjacent to device specification in each device specific di=
rectory.
> > > > This further makes device specification self-contained.
> > > >
> > > > Added patch to fix spelling errors in network device specification
> > > > which was inherited from its previous file location.
> > > >
> > > > Patches do not change any part of the specification outcome except
> > > > fixing the spelling errors.
> > > > It only changes how the specification is maintained.
> > >
> > >
> > > OK it's a technicality but it's a big change so I think we should
> > > vote on this. Still I don't feel it needs extra time for review.
> > > Can you create a github issue and I'll kick off the voting process?
> > >
> > Great.
> > I already open last week [1].
> > [1] https://github.com/oasis-tcs/virtio-spec/issues/153
>=20
> Sounds good. What do you think about the idea to have all files flat in t=
he same
> directory?

I was writing up reply to other thread at the moment.
But lets continue here since you ask.
I don't have a strong opinion, but I find directories neat.
This is because we have many devices spec files, conformance files and it's=
 expected to grow.
I have transports directory and place code in there.
Since latex spec doesn't have good way to include and refer sub section, we=
 have many files.
19 devices * 3 spec files + 3 transports * 3 spec files.

And once spec is in its own directory, things should be self-sufficient.
Only touch points will be in common areas which should be less frequent.
WDYT?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

