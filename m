Return-Path: virtio-dev-return-5768-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AFD92985F53
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jun 2019 12:34:21 +0000 (UTC)
Date: Thu, 6 Jun 2019 08:34:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190606083355-mutt-send-email-mst@kernel.org>
References: <2f0de388-de01-1e51-b6b6-339389a2268a@solarflare.com>
 <20190211021124-mutt-send-email-mst@kernel.org>
 <d5d3b7f6-95a3-0d1c-4890-6e72f2e4bfc5@solarflare.com>
 <20190430183950-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190430183950-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and
 hardware offload
To: David Riddoch <driddoch@solarflare.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Apr 30, 2019 at 06:41:14PM -0400, Michael S. Tsirkin wrote:
> On Mon, Feb 11, 2019 at 08:52:01AM +0000, David Riddoch wrote:
> > > > Presumably we would like this to be an optional feature, as impleme=
ntations
> > > > of packed mode already exist in the wild.=A0 How about
> > > > VIRTIO_F_RING_PACKED_AVAIL_IDX?
> > > > If I prepare a patch to the spec is there still time to get this in=
to v1.1?
> > > Any new feature would require another round of public review.
> > > I personally think it's better to instead try to do 1.2 soon after,
> > > e.g. we could try to target quarterly releases.
> > >=20
> > > But ultimately that would be up to the TC vote.
>=20
> Hi David!
> Now that 1.1 is out, how about proposing this for 1.2?
> It's probably a very good time for such a proposal.
> Do you have the time to spec it out?

Any interest at all? Or are we good for 1.2?

> --=20
> MST
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

