Return-Path: virtio-dev-return-5913-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DE4A2985CF9
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Aug 2019 09:21:44 +0000 (UTC)
Date: Thu, 1 Aug 2019 10:21:39 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190801092139.GD15179@stefanha-x1.localdomain>
References: <1564494374-16147-1-git-send-email-yang.huang@intel.com>
 <20190731145723.GA7363@stefanha-x1.localdomain>
 <0B92A36466FABC4D99BAF0BDB1FA8BBC415730B4@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline
In-Reply-To: <0B92A36466FABC4D99BAF0BDB1FA8BBC415730B4@shsmsx102.ccr.corp.intel.com>
Subject: Re: [virtio-dev] [PATCH v2] Add virtio rpmb device specification
To: "Huang, Yang" <yang.huang@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "Zhu, Bing" <bing.zhu@intel.com>, "Winkler, Tomas" <tomas.winkler@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2019 at 01:14:11AM +0000, Huang, Yang wrote:
> > -----Original Message-----
> > From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-op=
en.org]
> > On Behalf Of Stefan Hajnoczi
> > Sent: Wednesday, July 31, 2019 22:57
> > To: Huang, Yang <yang.huang@intel.com>
> > Cc: virtio-dev@lists.oasis-open.org; mst@redhat.com; Zhu, Bing
> > <bing.zhu@intel.com>; Winkler, Tomas <tomas.winkler@intel.com>
> > Subject: Re: [virtio-dev] [PATCH v2] Add virtio rpmb device specificati=
on
> >=20
> > On Tue, Jul 30, 2019 at 09:46:14PM +0800, Huang Yang wrote:
> > > It is a virtio based RPMB (Replay Protected Memory Block) device.
> >=20
> > Please include the request structs.  There is not enough information in=
 this spec
> > to implement the device.
>=20
> OK.
>=20
> > > +\devicenormative{\subsubsection}{Device Operation}{Device Types /
> > > +RPMB Device / Device Operation}
> > > +
> > > +The device provides a simulated RPMB backed by ordinary file or
> > > +  other medium in host. It SHOULD keep consistent behaviors with
> >=20
> > Or it could be a real hardware?  The specification shouldn't discuss th=
ese
> > implementation details except to say that virtio-rpmb could be backed i=
n a
> > number of ways.
>=20
> This is a good catch.=20
>=20
> But how to implement a physical RPMB backed solution is out of scope.
>=20
> If there are multiple guests who want to use RPMB. And their devices are =
backed by a same physical RPMB.
> 1. Who owns key, who owns RPMB. They should share a same key. If Guest1 p=
rogrammed a Key1, the Guest2 MUST use the same Key1.
> 2. Device SHOULD  isolate the RPMB space to protect from overwritten betw=
een guests.
>     But address remapping cannot work. Because address remapping by virti=
o device will cause to a wrong MAC, it will result to write failure.
> 3. RPMB capacity is limited up to 16MB. It cannot support the sharing amo=
ng a large number of guests.
>=20
> If users want to implement it backed by hardware RPMB, they should have a=
 whole picture design, which is out of scope of the spec.
> Of course, physical backed RPMB still adapts to the rules of the spec.
> I will change it to "could be backed in a number of ways."

Yes, all of this is out of scope.  I think the VIRTIO spec should avoid
saying "guest" and "host" whenever possible and just stick to "driver"
and "device".

VIRTIO is used in other contexts too, like hardware PCI devices or for
cross-CPU communication without virtualization, so it's nice to be as
general as we can.

> Both simulated and physical RPMB backed solution are implemented on Proje=
ct ACRN.
> If you are interested, "Secure Storage Virtualization" in this slide show=
s a high level design of physical RPMB backed solution:=20
> https://events.linuxfoundation.org/wp-content/uploads/2017/12/Implement-A=
ndroid-Tamper-Resistant-Secure-Storage-Bing-Zhu_and-Secure-it-in-Virtualiza=
tion-Bing-Zhu-Intel-Corporation.pdf

Thanks for the link!

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1CryMACgkQnKSrs4Gr
c8hbAAf+OG2ii/1y6CuluvleyVr2WOVDlAa2AW4zNrXPF1q5uhCFoqxzHBDYK0W8
hr+OMXoC61kCWMfqRpo8hjHAp6cfzdJ4yXggoQ7ogztHBvwlskhmK2F6ZNWMEJ75
DU8fJRuj3sZfIEHGafRLpkid+cKBSX3Brx9TsN9PQpthAptLf7dfPffrQkqGDKTC
R5tchu3ZFuWo9sc82mplVyE/spYGJ3MiccmuBEV1KXHj2fs1b1tB7jRbHFHF3aNv
vLbVh2vlaYkHnWx+iga3UCeGsyCwR4RLEPlFdvHYfDQlSFNnTy2XjWmYfBXa4OnW
sTjp4x+XCpkHGx0IVHEBuDBOLDBgWw==
=VSjQ
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--
