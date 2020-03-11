Return-Path: virtio-dev-return-6935-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BFCF8985FDA
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Mar 2020 18:24:26 +0000 (UTC)
Date: Wed, 11 Mar 2020 19:18:55 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20200311172411.GG281087@stefanha-x1.localdomain>
References: <874kv15o4q.fsf@linaro.org>
 <20200309154637.GJ7668@stefanha-x1.localdomain>
 <871rq1jx70.fsf@linaro.org>
 <20200311172411.GG281087@stefanha-x1.localdomain>
MIME-Version: 1.0
Message-Id: <20200311191855.3a406bbf.pasic@linux.ibm.com>
Subject: Re: [virtio-dev] Backend libraries for VirtIO device emulation
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/IMcbrtVJS.tSgw8+=65uZCb"; protocol="application/pgp-signature"
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--Sig_/IMcbrtVJS.tSgw8+=65uZCb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Mar 2020 17:24:11 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> > I thought so - but does any vhost-user implementation assume it has
> > access to the entire of the guests memory space? I can see why that
> > might be seen as undesirable from a security point of view. =20
>=20

On s390 we do assume we have access to the whole guest memory
space if VIRTIO_F_ACCESS_PLATFORM is not set.

> VMMs typically give the vhost-user device program access to the entirety
> of guest RAM.  That's because unmodified VIRTIO guest drivers typically
> require access to all of guest memory.
>=20
> If the guest software cooperates then it's possible to reduce the shared
> memory region.  In other words, the vhost-user protocol doesn't demand
> that guest RAM is shared, it just requires all addresses to be within
> the shared memory region, whatever that may be.

In that case, I guess, we would have to negotiate
VIRTIO_F_ACCESS_PLATFORM. vhost-user already has support for
VIRTIO_F_ACCESS_PLATFORM, but in context of vhost-user it means: do
IOVA translation. Translation is basically boils down to IOMMU/IOTLB
support, and the specs (docs/interop/vhost-user.rst) says that the
translated stuff needs to be within a region set via
VHOST_USER_SET_MEM_TABLE.

I'm wondering how restricting the memory region shared vhost-user program
should work, unless we impose restrictions on what physical addresses
may be used for virtio buffers (regardless of whether what lands in the
virtqueue is an IOVA or a GPA), and make everybody in the stack aware of
this.

Of course sharing the whole guest memory space with the vhost-user
program does not necessarily mean the guest can actually access the
whole guest memory. For example memory encryption or other means of
protecting memory (e.g. s390 protected VMs) may ensure that the
vhost-user program can not mess with anything that in is not supposed to.

Regards,
Halil

--Sig_/IMcbrtVJS.tSgw8+=65uZCb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJeaSulAAoJEA0vhuyXGx0AiqIQAKtYszEwwnTe7kbK6GEJ3Flj
K06RCQSmS2nO+uDdNsz+gjfcdrQ0WExpler0+xO+lZD/dOiypf+5oHzWGD2pW7dz
sFG1GMN8PLAbP4E55z4vw1lZFOTr/F93Ug2Tvi1YOSw1t+5U7Rp5haUP5sm5nhpW
IDb1/oYKh4eoQWjZFHKXXfTzVxZS+EM5kObZl1K6mvzGgeAC0KgdD/mA9brjqS52
n9dURoO841Rw4WEikOFOqPEpukSLdgwoYwo1lCtldzQugDPTEHRDLc16FiniSdUk
Fcz4L729hFBG7LzKN2ULTEtFDNKbdYyjCcW75/31swFA7z+dFo9UdV/hmXYTVKJa
AvCCk1nvLqBF4sQ9sjysO2MIdJ1gj4ezpWtHiyhRev2SyfxGCf9g90vTpgRypJKx
LQxvtiHEex3BXfSQ4wSUwSsbn0kb7DmJWZf7Cqrvxh//i7QeQ9FIGLi5QzNOAxDa
8iSPvhAcQOBM/YripsE/J+NwZ3TVjScpELOaknb6D8gGvhHxgrU+U2Uo7Mt90J2b
7Nm1i1FOhkikmAnFOcjKWVZ/S1QenMuHPRZeIdRauAsXu3cOc3ovQiN6WXD3LYs9
fBgNop5+WNKAgZvhvoIInRJUlR6vdhmb+g0GmD1jTDXCCFZBagpPEWeZ1OwccjF5
liQzoWrJMaK/3KuGowv0
=fIz7
-----END PGP SIGNATURE-----

--Sig_/IMcbrtVJS.tSgw8+=65uZCb--

