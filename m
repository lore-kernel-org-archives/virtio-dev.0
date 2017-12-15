Return-Path: virtio-dev-return-2834-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D91A1CB807E
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Dec 2017 04:00:42 -0800 (PST)
Date: Fri, 15 Dec 2017 12:00:29 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171215120029.GA26982@stefanha-x1.localdomain>
References: <CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com>
 <286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
 <20171211111147.GF13593@stefanha-x1.localdomain>
 <286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
 <20171212101440.GB6985@stefanha-x1.localdomain>
 <5A30E0C1.3070905@intel.com>
 <20171213123521.GL16782@stefanha-x1.localdomain>
 <5A3211CC.60607@intel.com>
 <20171214180449.GU14433@stefanha-x1.localdomain>
 <5A33A509.1000105@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <5A33A509.1000105@intel.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7]
 Vhost-pci for inter-VM communication
To: Wei Wang <wei.w.wang@intel.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 06:33:45PM +0800, Wei Wang wrote:
> On 12/15/2017 02:04 AM, Stefan Hajnoczi wrote:
> > On Thu, Dec 14, 2017 at 01:53:16PM +0800, Wei Wang wrote:
> > > 3rd one: I'm not able to solve this one, as discussed, there are too =
many
> > > differences and it's too complex. I prefer the direction of simply ga=
ting
> > > the vhost-user protocol and deliver to the guest what it should see (=
just
> > > what this patch series shows). You would need to solve this issue to =
show
> > > this direction is simpler :)
> > At the moment the main issue deciding what to do seems to be that we
> > have no patches for the approach I've described.  I'll begin working on
> > a patch series.
>=20
>=20
> Are you planning to implement the multiple masters and slaves?
> Master-->QemuSlave1-->GuestSlave
> Master<--QemuSlave2<--GuestSlave

Not sure if we are thinking of the same model.  Here's what I have in
mind:

  Master <-> QEMU virtio-vhost-user-slave <-> GuestSlave

The virtio-vhost-user-slave device implements a vhost-user slave on the
host side and a virtio device that acts as a vhost-user master to the
guest.  This is a single virtio device that speaks the vhost-user
protocol, not a family of different devices.

("virtio-vhost-user-slave" is the name to prevent confusion with your
vhost-pci work.)

I think your idea of using virtio is good since it avoids duplicating
low-level PCI device initialization and queues, so I've decided to try
that.

I will send a draft device specification later today so you can review
it.  I think the virtio PCI transport mapping that I'm documenting will
be useful whether we choose vhost-pci or virtio-vhost-user-slave.

Stefan

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaM7ldAAoJEJykq7OBq3PIHesH/i0zV0Cpv2jJkvq6QIkfN1Wd
m2w9izzCV6q8NH923hQ/vmmEsCBwLfvBjb07PxX18q8KoRbgegMyoyE0ONf/yKpL
HS9Z5ZurT899hs9dULYaTu1rXjJKaoYaEbSUJW6h4NVSjtwSzxKFzOg8v665xQ5V
wxlWdWmrOHphdlKPzmA7QhMUBtS7kLet70toUwhfV5Dj6WYNnePW2spUuUNKVJFt
onmRsNO0bi0eSE8DpU57ea6C7EB0J7G6N+aTxdyPNApca8BTAYHP9YIqUdau93i/
G1Trnr18FYUY3dek1KIlf0uYVk24+nP0eq333BYCQ8L9xgxv4LLB5lmtXQwLcos=
=nXES
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
