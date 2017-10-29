Return-Path: virtio-dev-return-2631-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7BB9F5818FF6
	for <virtio-dev@lists.oasis-open.org>; Sun, 29 Oct 2017 02:05:05 -0700 (PDT)
From: Ilya Lesokhin <ilyal@mellanox.com>
Date: Sun, 29 Oct 2017 09:05:01 +0000
Message-ID: <AM4PR0501MB2723177BF4E5EE32CC878E8CD4580@AM4PR0501MB2723.eurprd05.prod.outlook.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
 <AM4PR0501MB27236B71E1B02176F1844ACBD4770@AM4PR0501MB2723.eurprd05.prod.outlook.com>
 <20171025191346-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171025191346-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: packed ring layout proposal v3
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-ID: <virtio-dev.lists.oasis-open.org>

My point was that if the driver is not required to change the IDs,
it can initialized the ID's in all the descriptors when the ring is created
and never write the ID field again.

A simple allocator for the IDs can solve the problem I presented but it is =
still more
expensive then not doing ID allocation at all.


> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Wednesday, October 25, 2017 7:20 PM
> To: Ilya Lesokhin <ilyal@mellanox.com>
> Cc: virtio-dev@lists.oasis-open.org; virtualization@lists.linux-foundatio=
n.org
> Subject: Re: packed ring layout proposal v3
>=20
> On Sun, Oct 08, 2017 at 06:16:44AM +0000, Ilya Lesokhin wrote:
> > > > -----Original Message-----
> > > > From: virtualization-bounces@lists.linux-foundation.org
> > > > [mailto:virtualization-bounces@lists.linux-foundation.org] On
> > > > Behalf Of Michael S. Tsirkin
> > > >
> > > > This is an update from v2 version.
> > >> ...
> > > > When driver descriptors are chained in this way, multiple
> > > > descriptors are treated as a part of a single transaction
> > > > containing an optional write buffer followed by an optional read bu=
ffer.
> > > > All descriptors in the chain must have the same ID.
> > > >
> >
> > I apologize for the repost, I didn't realize I have to be a member of
> > the virtio-dev mailing list.
> >
> > I'm concerned about the "same ID" requirement in chained descriptors.
>=20
> It's there really just so we can remove the doubt about which descriptor'=
s ID
> should be used. My testing does not show a performance win from this, so =
I'm
> fine with removing this requirement though I'd be curious to know why is =
it a
> problem.
>=20
> > Assuming out of order execution, how is the driver supposed to
> > re-assign unique IDs to the previously chained descriptor?
>=20
> For example, driver can have a simple allocator for the IDs.
>=20
>=20
> > Is the driver expected to copy original IDs somewhere else before the
> > chaining and then restore the IDs after the chain is executed?
> >
> > Thanks,
> > Ilya
>=20
> As device overwrites the ID, driver will have to write it out each time, =
that's true.
> It's going to be a requirement even if descriptors on the chain do not ne=
ed to
> have the same ID.
>=20
> --
> MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

