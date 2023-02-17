Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] Re: [virtio-comment] RE: [PATCH v6] virtio-net:
 Improve introductory description
Date: Fri, 17 Feb 2023 02:59:36 +0000
Message-ID: <PH0PR12MB5481D8AC4A1FA5A9342BB198DCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230214180405.364920-1-parav@nvidia.com>
 <87ilg1aehi.fsf@redhat.com>
 <PH0PR12MB5481F4E1099DF88D667DBD2CDCA09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230216104714-mutt-send-email-mst@kernel.org> <87cz69a98e.fsf@redhat.com>
 <PH0PR12MB54814F1CCBA0CD40A4908274DCA09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87a61da7zi.fsf@redhat.com>
In-Reply-To: <87a61da7zi.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, David Edmondson <david.edmondson@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> O=
n
> Behalf Of Cornelia Huck
>=20
> On Thu, Feb 16 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> >> From: Cornelia Huck <cohuck@redhat.com>
> >> Sent: Thursday, February 16, 2023 11:03 AM
> >>
> >> On Thu, Feb 16 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >>
> >> > On Thu, Feb 16, 2023 at 02:30:03PM +0000, Parav Pandit wrote:
> >> >>
> >> >> > From: Cornelia Huck <cohuck@redhat.com>
> >> >> > Sent: Thursday, February 16, 2023 9:10 AM
> >> >> >
> >> >> > On Tue, Feb 14 2023, Parav Pandit <parav@nvidia.com> wrote:
> >> >> >
> >> >> > > The control VQ of the virtio network device is used beyond
> >> >> > > advance steering control. The control VQ dynamically changes
> >> >> > > multiple features of the initialized device.
> >> >> > >
> >> >> > > Hence, update this area of control VQ introductory description
> >> >> > > at few places and also place the link to its description.
> >> >> > >
> >> >> > > Also update the introduction section to better describe
> >> >> > > receive and transmit virtqueues.
> >> >> > >
> >> >> > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/156
> >> >> > > Reviewed-by: David Edmondson <david.edmondson@oracle.com>
> >> >> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> >> >> >
> >> >> > Are you requesting a vote for this?
> >> >>
> >> >> I was not sure if its need voting as most are editorial cleanups,
> >> >> better
> >> description, structure movement.
> >> >> Please advise if we need voting.
> >> >
> >> >
> >> > The bylaws are here:
> >> > https://github.com/oasis-tcs/virtio-spec/blob/master/README.md
> >> > Minor cleanups, including editorial formatting changes, spelling
> >> > and typo fixes can be committed directly into git for approval as
> >> > part of the next specification approval ballot.
> >> >
> >> > This is way beyond that. And generally when in doubt vote.
> >>
> >> Agreed.
> >>
> >> (Btw: the github issue needs to be updated to point to the latest
> >> version of the patch, it still points to v1.)
> >
> > Done.
>=20
> Do you request to withdraw the ballot, so that we can start a new ballot =
with
> the proper URL?
>=20
> (Sorry about being a stickler for process here.)

Yes, can you please withdraw the ballot [1] as it contains stale reference =
to the patch?

[1] https://www.oasis-open.org/apps/org/workgroup/virtio/ballot.php?id=3D37=
58

Also please create new ballot as the github link is now updated for the iss=
ue [2].
[2] https://github.com/oasis-tcs/virtio-spec/issues/156

