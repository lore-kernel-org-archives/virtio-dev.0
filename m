Return-Path: virtio-dev-return-6256-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D932F9860B4
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 Oct 2019 11:35:42 +0000 (UTC)
Date: Thu, 24 Oct 2019 07:35:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191024072302-mutt-send-email-mst@kernel.org>
References: <AM0PR0502MB37958EA359A04C0A67DB1A36C36A0@AM0PR0502MB3795.eurprd05.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR0502MB37958EA359A04C0A67DB1A36C36A0@AM0PR0502MB3795.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [virtio-dev] Virtio device specific MSIX arming
To: Shahaf Shuler <shahafs@mellanox.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Tzahi Oved <tzahio@mellanox.com>, Alex Rosenbaum <alexr@mellanox.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Oct 24, 2019 at 11:22:16AM +0000, Shahaf Shuler wrote:
> Hi,
>=20
> =20
>=20
> Below question mainly raise when looking on the ways to have vDPA
> implementation of virtio-net device.
>=20
> =20
>=20
> One complexity we encounter is with the MSIX relay between the device and=
 the
> guest.
>=20
> Reading the spec, and looking on the driver implementation, it seems ther=
e is
> no way for the driver to re-arm the virtio device after MSIX was triggere=
d.
>=20
> =20
>=20
> There is a way to suppress interrupt by setting some flags on the availab=
le
> rings, however it is hard to poll on it from a real (not emulated) PCI de=
vice.
>=20
> =20
>=20
> Is above correct? Or there is a way to re-arm virtio device for next inte=
rrupt?
>=20
> =20
>=20
> If no way to re-arm,
>=20
> 1. are there any thoughts on adding such addition to spec?
>=20
> 2. What is the recommended approach for vDPA implementation? Use static
>=20
>     interrupt moderation?
>=20
> =20

As of 1.1 as well as latest spec draft, there's no way to
notify device about changes to the used buffer notification
suppression structure.

An early draft of 1.1 included an option to notify the device,
about such changes (as well as provide an interrupt
to driver in case of changes to available buffer notification
suppression structure).

We can still add this with a feature flag in a future spec version.
If you see there's value pls propose something like this on
virtio-comment.

For now, I think the best option is a combination of static interrupt
moderation, and reading the suppression structure in RAM. As interrupts
are already very expensive and have a huge latency, an extra PCI read
might not be a big deal, latency-wise.  And after all, the point is to
offload as much as possible from the CPU.


--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

