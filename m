Return-Path: virtio-dev-return-2836-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 1E9C71CB807E
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Dec 2017 04:38:16 -0800 (PST)
Date: Fri, 15 Dec 2017 12:37:44 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171215123744.GC26982@stefanha-x1.localdomain>
References: <20171211111147.GF13593@stefanha-x1.localdomain>
 <286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
 <20171212101440.GB6985@stefanha-x1.localdomain>
 <5A30E0C1.3070905@intel.com>
 <20171213123521.GL16782@stefanha-x1.localdomain>
 <20171213165142-mutt-send-email-mst@kernel.org>
 <CAJSP0QWHJBL4APkeMt8-P8PFaPF=Vbi0NSnJtU7YX67fJrW=hw@mail.gmail.com>
 <20171213222102-mutt-send-email-mst@kernel.org>
 <20171214150609.GQ14433@stefanha-x1.localdomain>
 <5A33A4EA.7010204@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <5A33A4EA.7010204@intel.com>
Subject: [virtio-dev] Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
To: Wei Wang <wei.w.wang@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 06:33:14PM +0800, Wei Wang wrote:
> On 12/14/2017 11:06 PM, Stefan Hajnoczi wrote:
> > On Wed, Dec 13, 2017 at 10:59:10PM +0200, Michael S. Tsirkin wrote:
> > > >   * VHOST_USER_SET_VRING_KICK
> > > >=20
> > > >     Set up vring kick doorbell (unless bit 8 is set) before sending
> > > >     VHOST_USER_SET_VRING_KICK to the guest.
> > > But guest can't use it, now can it?
> > >=20
> > > What guest needs is a mapping to interrupts.
> > ...
> > > >   * VHOST_USER_SET_VRING_CALL
> > > >=20
> > > >     Set up the vring call doorbell (unless bit 8 is set) before sen=
ding
> > > >     VHOST_USER_SET_VRING_CALL to the guest.
> > > Same here. what guest needs is mapping from io to notifications,
> > > right?
> > The PCI device should contain a BAR with doorbell registers.  I don't
> > think a fancy mapping is necessary, instead the device spec should
> > define the BAR layout.
> >=20
> > When the guest vhost-user slave receives this message it knows it can
> > now begin using the doorbell register.
>=20
> Not really. A doorbell will cause an interrupt to be injected to the mast=
er
> device driver, which is not ready to work at that time. The slave driver
> isn't expected to use the doorbell until the master is ready by sending t=
he
> last message VHOST_USER_SET_VHOST_PCI to link UP the slave device.
>=20
> So I think passing the fd msg to guest doesn't have a value in terms of
> functionality.

The new VHOST_USER_SET_VHOST_PCI device message is something you defined
in this patch series.  This email sub-thread is about the vhost-user
protocol specification as it exist today.

The VHOST_USER_SET_VRING_CALL is the message that allows the guest to
begin using the doorbell when VHOST_USER_F_PROTOCOL_FEATURES wasn't
negotiated (i.e. the vring is enabled right away).

Stefan

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaM8IYAAoJEJykq7OBq3PIJsIH/R/VihqIMMS7leWVAuSY4/EE
BNCSJWnHxOsQP/6laC9cSEiSJfWq0+5KbMJBu91tQeeB6MiN3nKG88HzNasFl05Q
qSPiM3sMMLmwgnpD5ZJA5uUkbIdpl3nx/25U/2/VqQyfkAPlEtTCJ4tuTrW3eIHl
Fe2OIZm24/k8Cu68N5/jTNWcpU78NpUA+a8WKB6LFRTkLuG+o7Xu6o+4+NIH+bVs
u5jv4zN2j6kOIuWK9mnRuEgQpTcxUSPRMoJu1/2CGFiUtkcXhXtcRf8rX9nMPFoW
T6Yt5P6vus7LoRNfo8sncYEXaduN3aaCuW9TRR+SM0D422Ot4ou+s05ld0XlAiQ=
=Hcjr
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
