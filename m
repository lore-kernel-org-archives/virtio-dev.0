Return-Path: virtio-dev-return-2761-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2253D5818F92
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Dec 2017 08:06:56 -0800 (PST)
Date: Tue, 5 Dec 2017 16:06:46 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171205160646.GJ31150@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iRjOs3ViPWHdlw/I"
Content-Disposition: inline
In-Reply-To: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
Subject: Re: [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM communication
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--iRjOs3ViPWHdlw/I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 11:33:09AM +0800, Wei Wang wrote:
> Vhost-pci is a point-to-point based inter-VM communication solution. This
> patch series implements the vhost-pci-net device setup and emulation. The
> device is implemented as a virtio device, and it is set up via the
> vhost-user protocol to get the neessary info (e.g the memory info of the
> remote VM, vring info).
>=20
> Currently, only the fundamental functions are implemented. More features,
> such as MQ and live migration, will be updated in the future.
>=20
> The DPDK PMD of vhost-pci has been posted to the dpdk mailinglist here:
> http://dpdk.org/ml/archives/dev/2017-November/082615.html
>=20
> v2->v3 changes:
> 1) static device creation: instead of creating and hot-plugging the
>    device when receiving a vhost-user msg, the device is not created
>    via the qemu booting command line.
> 2) remove vqs: rq and ctrlq are removed in this version.
>     - receive vq: the receive vq is not needed anymore. The PMD directly
>                   shares the remote txq and rxq - grab from remote txq to
>                   receive packets, and put to rxq to send packets.
>     - ctrlq: the ctrlq is replaced by the first 4KB metadata area of the
>              device Bar-2.
> 3) simpler implementation: the entire implementation has been tailored
>    from ~1800 LOC to ~850 LOC.

Please write qtest test cases for vhost-pci.  See
tests/virtio-net-test.c and tests/vhost-user-test.c for examples.

Stefan

--iRjOs3ViPWHdlw/I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaJsQWAAoJEJykq7OBq3PITK4H/RltWGVrnTUMECEUNVSXnNs1
kv1jbxIAy8hRpAvQXxazocpQjNqxUsq3otu7hz0+mXcemlMQ+YsZtnbldamlDbt6
PfPxh7E3dnU56iO+CLuKsVexlbB7SBahCvE2/dMD370Gc9CryBkjFLxCki2J55et
S2NzxzDquFst2otumsFOxzZUGq9+QH0CWeEShhQ7IY01g7n15hU4QabGwSFlM3jn
xm/7SUURcSlSbfYelol+8NgX8vTe5asf4ToNRok3nuuZjOL0conw4Rsj2GAKtpQD
QqpbAv5tMH9pdVTDsfWNMysJ8//ezGT2S2YrEDCBvEFjpOfy4Mhl79OlC+derdg=
=vz3y
-----END PGP SIGNATURE-----

--iRjOs3ViPWHdlw/I--
