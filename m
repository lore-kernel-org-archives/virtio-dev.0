Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] Re: queue_reset register polarity to improve
Date: Mon, 25 Apr 2022 14:56:39 +0000
Message-ID: <PH0PR12MB54816E6AA01851746C851FDBDCF89@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB54819125071ED675E2B72F0EDCF99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220424023301-mutt-send-email-mst@kernel.org> <871qxl8k51.fsf@redhat.com>
 <PH0PR12MB54811ABC8173F4DE9AABED5EDCF89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220425085415-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220425085415-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, April 25, 2022 9:43 AM
>=20
> Question is what exactly is the advantage of making changes now.  If we a=
re
> trying to save bits then maybe an alternative that uses queue enable inst=
ead
> should be worked on.
>=20
Bit saving by merging to queue_enable is yet another gain.
But it may be too late now as you say.
If we adopt to the alternative definition we discussed, new queue_reset bit=
 can follow queue_enable without additional complexity.

>=20
> > Spec is not released, right?
>=20
> Kind of yes. The vote to release for a review is technically ongoing, but
> practically 6 out of 8 voting members already cast a ballot and voted yes=
.
> The best way forward if you think the issue is important enough to delay =
the
> release is probably working on a proposal for a change meanwhile and
> submitting it as part of the 30 day public review. Since the change seems
> material this would imply another 15 day public review period, delaying t=
he
> release by about a month in total.
>=20
> As part of that I would suggest explaining the motivation for the change =
beyond
> the simple "seems a bit cleaner".
>=20
To me it is beyond than being cleaner.
A state machine and driver-device interface where same register values cone=
y different things doesn't look right.

If virtio spec release process has concept of errata/ratification, I propos=
e a minor change that doesn't affect the current release.

a. Let feature bit as is
b. On queue_reset=3D1, it stays 1, until queue is busy in reset
c. When queue reset completed, it goes to zero along with queue_enabled bit=
.

I can draft the "Fixes" text for this in existing proposed spec. This way w=
e get right fix without much disruption.
Would that be ok?

