Return-Path: virtio-dev-return-2673-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 1737A1CB8080
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Nov 2017 07:39:15 -0800 (PST)
Date: Fri, 10 Nov 2017 15:39:09 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171110153909.GA18280@stefanha-x1.localdomain>
References: <20171108141659-mutt-send-email-mst@kernel.org>
 <20171108142820-mutt-send-email-mst@kernel.org>
 <4DCA102C9749C849A7B61D9934ED625207A180C2@fmsmsx122.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <4DCA102C9749C849A7B61D9934ED625207A180C2@fmsmsx122.amr.corp.intel.com>
Subject: Re: [virtio-dev] Re: [PATCH RFC] packed ring layout spec v4
To: "Dhanoa, Kully" <kully.dhanoa@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2017 at 03:08:16PM +0000, Dhanoa, Kully wrote:
> Hi Michael
>=20
> I have embedded my comments in the packed ring layout spec attached

Hi Kully,
Is there any way you could post your comments as inline text in emails
so the discussion can continue in email messages instead of attachments?

It's hard to follow or search comments posted in documents in
attachments with most email clients.

Thanks,
Stefan

>=20
> Thanks
> Kully
>=20
> -----Original Message-----
> From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-open=
=2Eorg] On Behalf Of Michael S. Tsirkin
> Sent: Wednesday, November 8, 2017 12:31 PM
> To: virtio-dev@lists.oasis-open.org
> Subject: [virtio-dev] Re: [PATCH RFC] packed ring layout spec v4
>=20
> On Wed, Nov 08, 2017 at 02:28:10PM +0200, Michael S. Tsirkin wrote:
> > Below is an attempt at a formal write-up of the latest proposal with=20
> > some modifications. Will reply with a pdf version as well.
> >=20
> > This is reasonably complete functionally, from spec point of view we=20
> > need
> > - more conformance statements
> > - pseudo-code
> > - discussion of memory barriers
> > - rearrange existing (1.0) layout discussion to make it fit
> >   in a single chapter
> ---------------------------------------------------------------------
> Intel Corporation (UK) Limited
> Registered No. 1134945 (England)
> Registered Office: Pipers Way, Swindon SN3 1RJ
> VAT No: 860 2173 47
>=20
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.


>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaBcgdAAoJEJykq7OBq3PIht4H/354x+x0JQZfOuL786kUbBk1
9UANzLacdl4Q78IePACmQr0O0M9DwOmvyeAlzu7MvOc4dR2tu+7bVPi6UBw0Q2BL
OQjNi8AdJPyTTYNmoWIMJnc238yosBvb9pAnkz/3GnzcHSggy1hCCyxO/jiPPLDP
18HqFvZHKDLu++GNIEZPqPMpTIabBqxydr+H07JxZaSqy+fZ//Tqruy9f7kpvY/u
/9ffB+ZEFbzGela7NwXYvSZwsrKTDjw5/gPaqjPopznhnlF+Q8+O1RYHPhlueSBH
tM4TWgQ3/LmgsIQ3yleb9mTDPhr4cEo3BPl+jmATwH4jrM4RoEPB5S4t0mTKvcg=
=3kZD
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
