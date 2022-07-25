Return-Path: <virtio-comment-return-3244-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Mon, 25 Jul 2022 02:53:39 +0000
Message-ID: <PH0PR12MB548127CD9F333F8F92580531DC959@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220705095514-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D9416A601E6F2D4A32FFDC819@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220706061051-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817E0D45D613834A3C42A4DC809@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220724170744-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481269E252B7DD8EFE2109DDC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220724191530-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220724191530-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [virtio-dev] RE: [PATCH v5 0/7] Introduce device group and device
 management
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, July 24, 2022 7:42 PM
> To: Parav Pandit <parav@nvidia.com>
> Cc: Max Gurtovoy <mgurtovoy@nvidia.com>; jasowang@redhat.com; virtio-
> comment@lists.oasis-open.org; cohuck@redhat.com; virtio-dev@lists.oasis-
> open.org; Oren Duer <oren@nvidia.com>; Shahaf Shuler
> <shahafs@nvidia.com>; aadam@redhat.com; virtio@lists.oasis-open.org
> Subject: Re: [virtio-dev] RE: [PATCH v5 0/7] Introduce device group and
> device management
>=20
> On Sun, Jul 24, 2022 at 09:25:17PM +0000, Parav Pandit wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Sunday, July 24, 2022 5:10 PM
> > >
> > > I snippet rest of mail - wasn't sure whether you were waiting for an
> answer.
> > >
> > > On Wed, Jul 06, 2022 at 08:45:26PM +0000, Parav Pandit wrote:
> > > > > Again I don't know what to do with this. I feel if it's put up
> > > > > for vote in the current form it's likely to fail. I propose
> > > > > cutting out as much as possible as a first step, so we can make
> progress.
> > > > > Specifically the MSI-X commands are clearly PF specific so
> > > > > there's no concern about VF memory use at all.  We can worry
> > > > > about other types
> > > of command down the road when it becomes relevant.
> > > >
> > > > Since feature bits proposes are limited to PF, I agree that
> > > > current short cut
> > > is fine to place in 64-127 feature bits.
> > > >
> > > > When/if similar functionality is needed at scale for the VF or
> > > > SIOV devices,
> > > placing them in 64-127 bits area weight way less for sake of "people
> > > familiarity to feature bits".
> > > > Do you agree?
> > >
> > > I think we can all agree that extensions for scalable IOV will need
> > > more work if that is what you are saying.
> > Yes.
> > Even VFs to negotiate few tens of Kbytes seems waste of resources for o=
ne
> time read/write bits.
>=20
> It has small a cost for sure, but it's negligeable compared to the curren=
t cost
> of implementing the spec.
>
How did you calculate the cost being negligible?
=20
> > So better to start using AQ for new functionalities.
> > What is stopping us to adapt to this modern and optimized way?
>=20
> The cost/benefit tradeoff. The benefit is a theorectical gain of a few bi=
ts per
> VF. The cost is very real engineering time spent.
>
How is it theoretical? I provided the calculation few times in previous ema=
ils.
=20
> I can keep poking holes and finding underspecified behaviour in the
> proposal.=20
We should fix the wording.

> But I don't really see why would anyone spend the time
> duplicating what virtio spec is already doing decently.
>=20
> > Why cant we keep features bits limited to device startup negotiation
> scheme?
>=20
> Well they are already used for much more. So sure, maybe work on changing
> that, but IMO trying it all in a single huge project is just not a great =
idea.
>
Why would you recommend on changing something historic like this?
The ask here to improve the new features.
=20
> > Other unrelated bits are added in past to feature bits  But lets follow=
 the
> good examples instead when the new choice is already proposed and
> defined.
>=20
> So IMHO saving a few bits here and there when we are spending tens of
> bytes on state makes no sense.
>
Not a good reason to introduce something inferior.
=20
> Something like transport over AQ (or the transport vq proposal) or some
> other concerted effort to save per device memory would be needed for
> SIOV, and maybe it's useful for SRIOV too.
>
AQ proposal is already doing it.
Some of the things seems to be lately duplicated in transport vq proposal.
We should possibly rename both the queues to mgmt_queue that serves both th=
e purposes.

Transport VQ proposal is tunneling some SIOV device feature bits.
Here AQ is negotiating its own feature bits. Both are orthogonal.
And suggesting to some newer RFC to discuss current one doesn't make much s=
ense to tangent the discussion at all.

Since there is zero technical short comings of negotiating AQ features via =
AQ command, lets please conclude to proceed with it.


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

