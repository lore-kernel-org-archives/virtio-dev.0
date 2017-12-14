Return-Path: virtio-dev-return-2829-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F84E5818D93
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Dec 2017 10:11:38 -0800 (PST)
Date: Thu, 14 Dec 2017 18:11:16 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214181116.GA19012@stefanha-x1.localdomain>
References: <5A30E0C1.3070905@intel.com>
 <20171213123521.GL16782@stefanha-x1.localdomain>
 <20171213165142-mutt-send-email-mst@kernel.org>
 <CAJSP0QWHJBL4APkeMt8-P8PFaPF=Vbi0NSnJtU7YX67fJrW=hw@mail.gmail.com>
 <825b8205-0b88-a198-b77d-63c8f2563c2e@redhat.com>
 <20171214154656.GR14433@stefanha-x1.localdomain>
 <20171214180830-mutt-send-email-mst@kernel.org>
 <31609e8a-8446-cc8c-dc3b-a72d37086358@redhat.com>
 <20171214184009-mutt-send-email-mst@kernel.org>
 <f705f911-ec01-0ae2-1274-a2ffb9bf1015@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <f705f911-ec01-0ae2-1274-a2ffb9bf1015@redhat.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7]
 Vhost-pci for inter-VM communication
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Wei Wang <wei.w.wang@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, snabb-devel@googlegroups.com, dgilbert@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2017 at 05:50:22PM +0100, Maxime Coquelin wrote:
>=20
>=20
> On 12/14/2017 05:40 PM, Michael S. Tsirkin wrote:
> > On Thu, Dec 14, 2017 at 05:39:19PM +0100, Maxime Coquelin wrote:
> > >=20
> > >=20
> > > On 12/14/2017 05:27 PM, Michael S. Tsirkin wrote:
> > > > On Thu, Dec 14, 2017 at 03:46:56PM +0000, Stefan Hajnoczi wrote:
> > > > > On Wed, Dec 13, 2017 at 10:50:11PM +0100, Maxime Coquelin wrote:
> > > > > > On 12/13/2017 09:08 PM, Stefan Hajnoczi wrote:
> > > > > > > On Wed, Dec 13, 2017 at 3:01 PM, Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > > > > > > > On Wed, Dec 13, 2017 at 12:35:21PM +0000, Stefan Hajnoczi w=
rote:
> > > > > > > > > I'm not saying that DPDK should use libvhost-user.  I'm s=
aying that it's
> > > > > > > > > easy to add vfio vhost-pci support (for the PCI adapter I=
 described) to
> > > > > > > > > DPDK.  This patch series would require writing a complete=
ly new slave
> > > > > > > > > for vhost-pci because the device interface is so differen=
t from
> > > > > > > > > vhost-user.
> > > > > > > >=20
> > > > > > > > The main question is how appropriate is the vhost user prot=
ocol
> > > > > > > > for passing to guests. And I am not sure at this point.
> > > > > > > >=20
> > > > > > > > Someone should go over vhost user messages and see whether =
they are safe
> > > > > > > > to pass to guest. If most are then we can try the transpare=
nt approach.
> > > > > > > > If most aren't then we can't and might as well use the prop=
osed protocol
> > > > > > > > which at least has code behind it.
> > > > > > >=20
> > > > > > > I have done that:
> > > > > > >=20
> > > > > > ...
> > > > > > >     * VHOST_USER_SET_MEM_TABLE
> > > > > > >=20
> > > > > > >       Set up BARs before sending a VHOST_USER_SET_MEM_TABLE t=
o the guest.
> > > > > >=20
> > > > > > It would require to filter out userspace_addr from the payload =
not to
> > > > > > leak other QEMU process VAs to the guest.
> > > > >=20
> > > > > QEMU's vhost-user master implementation is insecure because it le=
aks
> > > > > QEMU process VAs.  This also affects vhost-user host processes, n=
ot just
> > > > > vhost-pci.
> > > > >=20
> > > > > The QEMU vhost-user master could send an post-IOMMU guest physical
> > > > > addresses whereever the vhost-user protocol specification says "u=
ser
> > > > > address".  That way no address space information is leaked althou=
gh it
> > > > > does leak IOMMU mappings.
> > > > >=20
> > > > > If we want to hide the IOMMU mappings too then we need another lo=
gical
> > > > > address space (kind a randomized ramaddr_t).
> > > > >=20
> > > > > Anyway, my point is that the current vhost-user master implementa=
tion is
> > > > > insecure and should be fixed.  vhost-pci doesn't need to worry ab=
out
> > > > > this issue.
> > > > >=20
> > > > > Stefan
> > > >=20
> > > > I was going to make this point too.  It does not look like anyone u=
ses
> > > > userspace_addr. It might have been a mistake to put it there -
> > > > maybe we should have reused it for map offset.
> > > >=20
> > > > It does not look like anyone uses this for anything.
> > > >=20
> > > > How about we put zero, or a copy of the GPA there?
> > > >=20
> > > >=20
> > >=20
> > > It is used when no iommu for the ring addresses, and when iommu is us=
ed
> > > for the IOTLB update messages.
> > >=20
> > > Maxime
> >=20
> > How do clients use it? Why won't GPA do just as well?
>=20
> It is used to calculate the offset in the regions, so if we change all
> to use GPA, it may work without backend change.

Great.

Stefan

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMr7EAAoJEJykq7OBq3PIDTYIAMeQ0XLgjeMSwTmGr3BlvvGq
tbzHT7Tmj8QG4Vp+W2ldClv6yJaNZh1mAeexP3ZiYkmnyIudO0IBL8wmfSeYZM8y
h/J1kKWCJLInybJagMhSoUN5EpbA9RYixEwyUJ2PvqVjaWFwNjmiCVHHgALDzCqN
RJlzN8BICLo7SFdjazbsGTd77y8GPbeMrvdRInN5D7acAeGLEJXKd09HIPzikO2n
pZ8ncHP6TNGWtrU9i3rVrHdMIszIk9VBuj3k+1pDGa9S/wRFW+TijX3AKvbYs1dy
mFuoYYFPjF+jhJR18HRmsxARisdg3JSolOGMwsz7jx/qBEJRLxF7bvYNh0Vz+ew=
=SuMX
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
