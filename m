Return-Path: virtio-dev-return-2837-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B6D701CB8080
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Dec 2017 04:40:22 -0800 (PST)
Date: Fri, 15 Dec 2017 12:40:02 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171215124002.GD26982@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
 <1512444796-30615-6-git-send-email-wei.w.wang@intel.com>
 <20171205160020.GH31150@stefanha-x1.localdomain>
 <5A27C752.2050906@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
In-Reply-To: <5A27C752.2050906@intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v3 5/7] vhost-user:
 VHOST_USER_SET_VHOST_PCI msg
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2017 at 06:32:50PM +0800, Wei Wang wrote:
> On 12/06/2017 12:00 AM, Stefan Hajnoczi wrote:
> > On Tue, Dec 05, 2017 at 11:33:14AM +0800, Wei Wang wrote:
> > > Add a new vhost-uer protocol msg, VHOST_USER_SET_VHOST_PCI. This msg =
is
> > > used to signal the vhost-pci device to start/stop working.
> > >=20
> > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > > ---
> > >   hw/net/vhost_net.c                | 37 ++++++++++++++++++++++++++++=
+++++++++
> > >   hw/virtio/vhost-pci-slave.c       |  2 +-
> > >   hw/virtio/vhost-user.c            | 17 +++++++++++++++++
> > >   hw/virtio/vhost.c                 |  7 +++++++
> > >   include/hw/virtio/vhost-backend.h |  2 ++
> > >   include/hw/virtio/vhost-user.h    |  2 ++
> > >   include/hw/virtio/vhost.h         |  2 ++
> > >   include/net/vhost_net.h           |  2 ++
> > >   8 files changed, 70 insertions(+), 1 deletion(-)
> > New protocol messages must be documented in docs/interop/vhost-user.txt.
>=20
> OK, I'll add it to the doc after the discussion.
>=20
> >=20
> > Why is a new message needed?  I'm not sure why it is specific to
> > vhost-pci.
>=20
> Yes, it might be useful for other vhost-user slave implementations. Proba=
bly
> we can name it "VHOST_USER_SET_SLAVE"?
> The message is used to "link up" or "link down" the slave device. For
> example, when virtio-net leaves, it sends a "VHOST_USER_SET_SLAVE" msg to
> the salve to link down the slave device.
> (a similar msg is VHOST_USER_SET_VRING_ENABLE, but that is for virtqueue
> enable/disable, not for a device level enable/disable)

Why is VHOST_USER_SET_VHOST_PCI necessary when DPDK and other vhost-user
net device slaves already exist today and didn't need it?

Stefan

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaM8KiAAoJEJykq7OBq3PIrFYH/3yqAzTG4fvSzCXIWFBSNgQQ
aNw4DrfE4Uwv8VNAs2fX96VlLk6H/py+O46JIScho3uTOHSsmfcKSjRbF9gnrv4j
DHqjMsxVeuvB5Go6/A0hdJKkcT6pGEHzmGAJ6ocRiM2IVdXc4sKLm5upVQy8/hZm
xVGFF7yi+veMRK2HwHTB/rhPNYCgD4Fy+8RlLobJFR9Evvgm50tjDBpHiKCwL9tn
vehSap0fjSOgakx4v3Q4VFSy3Bfh6mKbr34F9Guo0j80xbhBUf3QcZ0GW5kWmUuX
9qFKlKNhbFm6LJ8bSPladanV5a12juJYlFFewgf7KsdVqZ4FwULg4FAkSLKoJqI=
=UWXq
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
