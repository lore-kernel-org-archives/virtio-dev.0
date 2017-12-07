Return-Path: virtio-dev-return-2785-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8D4C25819115
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Dec 2017 06:46:44 -0800 (PST)
Date: Thu, 7 Dec 2017 10:24:21 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171207102420.GB7830@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
 <20171206134957.GD12584@stefanha-x1.localdomain>
 <286AC319A985734F985F78AFA26841F73937B57F@shsmsx102.ccr.corp.intel.com>
 <CAJSP0QWugAKQy6hYEJfy_XHEg-Q2swAzZMNcWBqn-r9Yi7yiEg@mail.gmail.com>
 <5A28BC2D.6000308@intel.com>
 <CAJSP0QUxRv9LNb1+McYxV0KY4Ss3NkaSjwO6fXiJd+oU2+zJSQ@mail.gmail.com>
 <B84047ECBD981D4B93EAE5A6245AA3610159323B@FRAEML521-MBX.china.huawei.com>
 <CAJSP0QVSOsPXYTyjCsBbUmzivjtYbC7xKpU2m7dQbAPMhrcLnA@mail.gmail.com>
 <ed3c3bb2-acc9-b44e-2a5b-7f4f22c2230a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <ed3c3bb2-acc9-b44e-2a5b-7f4f22c2230a@redhat.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7]
 Vhost-pci for inter-VM communication
To: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Avi Cohen (A)" <avi.cohen@huawei.com>, Wei Wang <wei.w.wang@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2017 at 04:31:27PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B412=E6=9C=8807=E6=97=A5 16:04, Stefan Hajnoczi wrote:
> > On Thu, Dec 7, 2017 at 7:54 AM, Avi Cohen (A) <avi.cohen@huawei.com> wr=
ote:
> > > There is already a  virtio mechanism in which 2 VMs assigned a virtio=
 device , are communicating via a veth pair  in the host .
> > > KVM just passes  a pointer of the page of the writer VM to the reader=
 VM - resulting  in  excellent performance (no vSwitch in the middle)
> > > **Question**:  What is the advantage of vhost-pci compared to this ?
> > Which mechanism do you mean?
> >=20
> > vhost-pci will allow VM-to-VM communication without vmexits when
> > polling mode is used.  Does the mechanism you are thinking about
> > require vmexits?
> >=20
> > Stefan
>=20
> I guess what Avi means is probably veth tap support (RFC) here:
>=20
> https://www.spinics.net/lists/netdev/msg454040.html
>=20
> But in fact, we don't need veth at all, by using rx handler trick, we can
> easily implement pair mode on TUN/TAP.

Okay, that is a different use case:

1. VM<->physical NIC: macvtap
2. VM<->host userspace: vhost-user
3. VM<->host/container: vethtap or pair mode
4. VM<->VM: vhost-pci

Stefan

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaKRbUAAoJEJykq7OBq3PIUo4H/RngXPiI5TkNlNWXbfQsNk8E
LkKklNFPgitmEt6hGscFpL0kcvkJlR2ggk1M7frWtZoiBG9ZABpKgnetB/vrYnHd
AXdlG24iogK0uLP4Y9moBNZ7C0goRncjWUcwwEeHcrDKUdDm/ALtu0WKRYhqIU0P
HQRyXaP32etU1jKdTVZlBDsmwoksxW9D3+hL+5SU78jX+1UuzacYKic9icURYlUW
h86heLQzIZGmR1/gtFEcn+FffjirJUGep1EOa7n2n7ewxQ5mbXppk+u/Izmb3UYA
2BwtISf5jsSpm1zkiX/6LjOuI0553mvty/4bzcO7eGnoWL3uQEB8CC/EK+poVVs=
=hpeo
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
