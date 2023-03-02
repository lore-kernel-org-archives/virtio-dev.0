Return-Path: <virtio-dev-return-11361-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37B1C6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 12:08:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 18EAB29FD5
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 12:08:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F01B4986681
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 12:08:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D5883986672; Thu,  2 Mar 2023 12:08:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3919986674
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 12:08:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: zd8RQRQ2Pp2eE56cxYUSzQ-1
Date: Thu, 2 Mar 2023 07:08:42 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	stratos-dev@op-lists.linaro.org,
	Oleksandr Tyshchenko <olekstysh@gmail.com>, xen-devel@lists.xen.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Sebastien Boeuf <sebastien.boeuf@intel.com>,
	Liu Jiang <gerry@linux.alibaba.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230302120842.GB2480875@fedora>
References: <Y/9zkDAS4odz93GM@fedora>
 <877cw0ctpr.fsf@linaro.org>
 <Y/+LdfF0rL3wEqfd@fedora>
 <20230302081907.pwt4nvz5buyt2dz3@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R8x4bQWlTQ/fknb6"
Content-Disposition: inline
In-Reply-To: <20230302081907.pwt4nvz5buyt2dz3@vireshk-i7>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Subject: Re: [virtio-dev] [RFC QEMU] docs: vhost-user: Add custom memory
 mapping support

--R8x4bQWlTQ/fknb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2023 at 01:49:07PM +0530, Viresh Kumar wrote:
> On 01-03-23, 12:29, Stefan Hajnoczi wrote:
> > What is the advantage over defining separate messages? Separate messages
> > are cleaner and more typesafe.
>=20
> I thought we wanted to keep single message for one kind of functionality,=
 which
> is mmap related quirks here. And so it would be better if we can reuse th=
e same
> for next hypervisor which may need this.
>=20
> The value parameter is not fixed and is hypervisor specific, for Xen this=
 is the
> domain id, for others it may mean something else.

mmap-related quirks have no parameters or behavior in common so there's
no advantage in sharing a single vhost-user protocol message. Sharing
the same message just makes it awkward to build and parse the message.

> > I don't have a concrete example, but was thinking of a guest that shares
> > memory with other guests (like the experimental virtio-vhost-user
> > device). Maybe there would be a scenario where some memory belongs to
> > one domain and some belongs to another (but has been mapped into the
> > first domain), and the vhost-user back-end needs to access both.
>=20
> These look tricky (and real) and I am not sure how we would want to handle
> these. Maybe wait until we have a real use-case ?

A way to deal with that is to include mmap information every time fds
are passed with a message instead of sending one global message at the
start of the vhost-user connection. This would allow each mmap to
associate extra information instead of forcing them all to use the same
information.

> > The other thing that comes to mind is that the spec must clearly state
> > which mmaps are affected by the Xen domain information. For example,
> > just mem table memory regions and not the
> > VHOST_USER_PROTOCOL_F_LOG_SHMFD feature?
>=20
> Maybe we can mention that only the mmap's performed via /dev/xen/privcmd =
and
> /dev/xen/gntdev files are affected by this ?

No, this doesn't explain when mmap must be performed via
/dev/xen/privcmd and /dev/xen/gntdev. The spec should be explicit about
this instead of assuming that the device implementer already knows this.

Stefan

--R8x4bQWlTQ/fknb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQAkcoACgkQnKSrs4Gr
c8iQbgf7BYwOXalaOt9tawNBuNNxLm51ZzyWrR5YxkBDb7Ko5Ja0ft7PtgNn876L
a4Ike7lWdQM1O+glxxDybaubjNLbx5rl6H86QR5jkn1HaMUGDNnePPWMwi6jj+1M
MrXoTPbTaSlzFIZSnTSYDcg9qEYan2cSK4J9ol40Isv9wHA7xLxD9kKmfEMNqiLY
9wnUkNbvd9E7C6ODp7R3UZlCy/XHGt0xFEAATzSGKRj9K47TM0Fj208dYIrNOtiO
XYc4hdGsEC4QXqNEDmhbH15uTbn8QHr4aiA8v7gn9Tzv3ux81adOpdf/i5dfSnzr
HnK2yy7RDHS1+5bXCGQdLYyed8Wufg==
=NjUt
-----END PGP SIGNATURE-----

--R8x4bQWlTQ/fknb6--

