Return-Path: virtio-dev-return-2669-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 18E581CB807E
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Nov 2017 01:31:13 -0800 (PST)
Date: Fri, 10 Nov 2017 09:31:05 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171110093105.GD31658@stefanha-x1.localdomain>
References: <1d6a84dd-946b-840f-d04c-f786c900ce88@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <1d6a84dd-946b-840f-d04c-f786c900ce88@intel.com>
Subject: Re: [virtio-dev] Propose to report the offset addr back from vhost
 to virtio
To: "Tan, Jianfeng" <jianfeng.tan@intel.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, "Liang, Cunming" <cunming.liang@intel.com>, "Gasparakis, Joseph" <joseph.gasparakis@intel.com>, 'Jason Wang' <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2017 at 01:33:11PM +0800, Tan, Jianfeng wrote:
> This proposal will be from virtio-net perspective, not sure if it helps f=
or
> other device types.
>=20
> Current status:
> VIRTIO-net "rx" path will rearm buffers for packets receiving, put the st=
art
> addr and len on the descriptor table (or the single ring for virtio 1.1
> draft spec), vhost backend will put the packet exactly on the start addr,
> and report the real packet len back. This way does not allow the vhost
> backend to put the packet somewhere offset to the start addr.
>=20
> Use case:
> When we look at vhost rx zero copy problem, we would like the NIC to put =
the
> packets directly onto VM memory, but this raw packet (tunnel packet) alwa=
ys
> contains a outer header which should be decap before VM starts receiving =
the
> packet. And unfortunately, not all NICs support decap. After the whole
> tunnel packet be put on the VM buffer (starting with the start addr), and
> after the vswitch's decap, we can report an "offset" back to VIRTIO
> frontend, and of course, the frontend shall honor this offset and adjust
> accordingly.
>=20
> The proposal:
> We can add a new feature like, VIRTIO_NET_F_OFFSET and add a new filed in
> virtio_net_header; if this feature is negotiated, the vhost side can repo=
rt
> the "offset" in virtio_net_header, and the frontend side will recognize t=
his
> value and adjust the packet buffer accordingly.
>=20
> Any comments?

Does exposing the encapsulation header to guest memory pose a security
problem?

In a simple VLAN scenario it tells the guest about the VLAN ID used on
the host.  If fancier encapsulation protocols are used there might be
additional info that the guest shouldn't see?

Besides this concern it seems like a useful virtio-net feature.

Stefan

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaBXHZAAoJEJykq7OBq3PIGPYH/2TVl9OURWUCFkAuB1EPU6is
A0mj8UhV71P3zcA1M/yHVIXgQo7e4UjKD0zThsRikAZRXKW3uYDHPzZLA4t+l96g
/aRReLS0RJuNIq1eSR3KENXOeQ1hOG0mU0yexj7+5sn14RpyGuKTH8+w8+ODgpCJ
byyJ0GEP/oTrhzs2lkvaGM9I/X3Y1I8fU+d3VHEpwQQC7RpR8q+2VqPMRR88MQQM
Pj09fksXKvj5pOMj4zeNtV5e08aDW+Zm1idAWtlVlGCo0O7XiGZCZzx2FdNOKpeR
ksEtHRwMoVD0/Ord/UKc0ZqCJSlw9xhHgG65unFSoMSsvIeaZ4HBPopmq4HmcVk=
=6m63
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
