Return-Path: virtio-dev-return-5715-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 77F8E987BC8
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 May 2019 18:09:46 +0000 (UTC)
Date: Tue, 30 Apr 2019 18:41:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190430183950-mutt-send-email-mst@kernel.org>
References: <2f0de388-de01-1e51-b6b6-339389a2268a@solarflare.com>
 <20190211021124-mutt-send-email-mst@kernel.org>
 <d5d3b7f6-95a3-0d1c-4890-6e72f2e4bfc5@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d5d3b7f6-95a3-0d1c-4890-6e72f2e4bfc5@solarflare.com>
Subject: Re: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and
 hardware offload
To: David Riddoch <driddoch@solarflare.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 11, 2019 at 08:52:01AM +0000, David Riddoch wrote:
> > > Presumably we would like this to be an optional feature, as implement=
ations
> > > of packed mode already exist in the wild.=A0 How about
> > > VIRTIO_F_RING_PACKED_AVAIL_IDX?
> > > If I prepare a patch to the spec is there still time to get this into=
 v1.1?
> > Any new feature would require another round of public review.
> > I personally think it's better to instead try to do 1.2 soon after,
> > e.g. we could try to target quarterly releases.
> >=20
> > But ultimately that would be up to the TC vote.

Hi David!
Now that 1.1 is out, how about proposing this for 1.2?
It's probably a very good time for such a proposal.
Do you have the time to spec it out?

--=20
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

