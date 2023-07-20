Return-Path: <virtio-dev-return-13393-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8373EEB64DA
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 19:36:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DA8F626A34
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 19:36:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB54A98683B
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 19:36:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BF0D8986830; Thu, 20 Jul 2023 19:36:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AE9CC986831
	for <virtio-dev@lists.oasis-open.org>; Thu, 20 Jul 2023 19:36:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: sTKFDoLzPx6EJnvZT2Gw4g-1
Date: Thu, 20 Jul 2023 15:36:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
	slp@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com,
	viresh.kumar@linaro.org, takahiro.akashi@linaro.org,
	erik.schilling@linaro.org, manos.pitsidianakis@linaro.org,
	mathieu.poirier@linaro.org
Message-ID: <20230720193601.GI210977@fedora>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <3ogh7u3ezp7vlrp3ticquoajgsnpnglplm44osrsd7gvxv2lyn@g22qgf4vwgp5>
 <87o7krg0sn.fsf@linaro.org>
 <qmwvywoy7lfkgr7kcc6cxghulgd5g2gvnv76mvkuxbqclbwmti@4qyiktfiu2ej>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PJgjM68U1AKlFxoJ"
Content-Disposition: inline
In-Reply-To: <qmwvywoy7lfkgr7kcc6cxghulgd5g2gvnv76mvkuxbqclbwmti@4qyiktfiu2ej>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Subject: Re: [virtio-dev] [RFC PATCH] docs/interop: define STANDALONE
 protocol feature for vhost-user

--PJgjM68U1AKlFxoJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2023 at 12:27:39PM +0200, Stefano Garzarella wrote:
> On Tue, Jul 04, 2023 at 04:02:42PM +0100, Alex Benn=E9e wrote:
> >=20
> > Stefano Garzarella <sgarzare@redhat.com> writes:
> >=20
> > > On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=E9e wrote:
> > > > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.=
rst
> > > > index 5a070adbc1..85b1b1583a 100644
> > > > --- a/docs/interop/vhost-user.rst
> > > > +++ b/docs/interop/vhost-user.rst
> > > > @@ -275,6 +275,21 @@ Inflight description
> > > >=20
> > > > :queue size: a 16-bit size of virtqueues
> > > >=20
> > > > +Backend specifications
> > > > +^^^^^^^^^^^^^^^^^^^^^^
> > > > +
> > > > ++-----------+-------------+------------+------------+
> > > > +| device id | config size |   min_vqs  |   max_vqs  |
> > > > ++-----------+-------------+------------+------------+
> > > > +
> > > > +:device id: a 32-bit value holding the VirtIO device ID
> > > > +
> > > > +:config size: a 32-bit value holding the config size (see ``VHOST_=
USER_GET_CONFIG``)
> > > > +
> > > > +:min_vqs: a 32-bit value holding the minimum number of vqs support=
ed
> > >=20
> > > Why do we need the minimum?
> >=20
> > We need to know the minimum number because some devices have fixed VQs
> > that must be present.
>=20
> But does QEMU need to know this?
>=20
> Or is it okay that the driver will then fail in the guest if there
> are not the right number of queues?

I don't understand why min_vqs is needed either. It's not the
front-end's job to ensure that the device will be used properly. A
spec-compliant driver will work with a spec-compliant device, so it's
not clear why the front-end needs this information.

Stefan

--PJgjM68U1AKlFxoJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS5jKAACgkQnKSrs4Gr
c8iL2QgAqCc6gx0y20MWAVkqX4M5cONVtaHUBQz26ZTaU20ipQ1qS4HYsgGW67hX
fthNJsVS3gGpAhkjOf3bWMB5s20sjAEdifjqZe8C2HL2AxRJsNYBZwH/btA3aWbC
0w7uxLUcXv1ccqsE4CMp+DPIHOnKwA5ewlbg7P04ya4kNjzx5WM2EMJhlJ9vbybx
+7UuPukQDV/TG3yBJOz61wCQQ/ABt0njwxXJakMVyRj0O6aHbZDPs09ibFmc9jDW
O+35GNYVSdvN3/cd8J6Vc2ikJ4q+jEK0/E8jbh6+jc7OOQ3BKnluKhwkGYvouSDK
Ia7ziZJnl7n7fzghOOdSpPu8/a63RQ==
=dGKO
-----END PGP SIGNATURE-----

--PJgjM68U1AKlFxoJ--

