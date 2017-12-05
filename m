Return-Path: virtio-dev-return-2760-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A7C7F5818F75
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Dec 2017 08:05:22 -0800 (PST)
Date: Tue, 5 Dec 2017 16:05:12 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171205160512.GI31150@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
 <1512444796-30615-8-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IbA9xpzOQlG26JSn"
Content-Disposition: inline
In-Reply-To: <1512444796-30615-8-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] Re: [PATCH v3 7/7] virtio/vhost.c: vhost-pci needs remote gpa
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--IbA9xpzOQlG26JSn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 11:33:16AM +0800, Wei Wang wrote:
> The vhost-pci driver uses the remote guest physical address to send/recei=
ve
> packets from the remote guest, so when sending the ving info to the vhost=
-pci
> device, send the guest physical adress directly.
>=20
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  hw/virtio/vhost.c | 56 +++++++++++++++++++++++++++++++++++--------------=
------
>  1 file changed, 36 insertions(+), 20 deletions(-)

Can you do it inside vhost_memory_map()/vhost_memory_unmap() instead of
modifying callers?

Looks like vhost_dev_has_iommu() already takes this approach:

  static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
                                hwaddr *plen, int is_write)
  {
      if (!vhost_dev_has_iommu(dev)) {
          return cpu_physical_memory_map(addr, plen, is_write);
      } else {
          return (void *)(uintptr_t)addr;
      }
  }

  static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
                                 hwaddr len, int is_write,
                                 hwaddr access_len)
  {
      if (!vhost_dev_has_iommu(dev)) {
          cpu_physical_memory_unmap(buffer, len, is_write, access_len);
      }
  }

--IbA9xpzOQlG26JSn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaJsO4AAoJEJykq7OBq3PIndIIAJVDu+kYHihu0Wpt55t8Skhh
9hiaomoNoIUoB1w9gkPvS/HkSgs93FaUrBCdbhSUb/J5NvaOzq2uiHPLx3w7tOCx
25ImbA2BBk+r+gMjCKbe1drpszrBzQ83C6IIDt6RZq+KgLDkzn6VcvupLMg1siSU
f0Z/1n5byD3kutBQ/oo2i9mopJ7D1GEiYJNr3+pLh/ON4vaSZOjNis+43s0f8WV6
diU18Hmh9K96yir793Pa50sL1vaBjP4enc+ujXEY7UlxLHwK31LmUTP0WqHyl+/F
+8K14mJs1cAZ718yCuednPmaxbH6PWd9E6JByr++G52STY6JahAlVP2uSLEQdZ0=
=U1Pb
-----END PGP SIGNATURE-----

--IbA9xpzOQlG26JSn--
