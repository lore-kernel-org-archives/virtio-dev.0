Return-Path: <virtio-dev-return-10106-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 24A8898642C
	for <virtio-dev@lists.oasis-open.org>; Mon, 31 Oct 2022 18:52:30 +0000 (UTC)
Date: Mon, 31 Oct 2022 13:24:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <Y2AEzkxKVw46JUGE@fedora>
References: <20221007165643.3920613-1-usama.arif@bytedance.com>
 <20221007165643.3920613-4-usama.arif@bytedance.com>
 <Y1r3wEnQwTsZqGWg@fedora>
 <20221031114132-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eWWCR2o7eA8vMDI1"
Content-Disposition: inline
In-Reply-To: <20221031114132-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [PATCH v3 3/4] content: Introduce driver/device
 auxiliary notifications for MMIO
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Usama Arif <usama.arif@bytedance.com>, virtio-dev@lists.oasis-open.org, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>

--eWWCR2o7eA8vMDI1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 31, 2022 at 11:45:55AM -0400, Michael S. Tsirkin wrote:
> On Thu, Oct 27, 2022 at 05:27:28PM -0400, Stefan Hajnoczi wrote:
> > On Fri, Oct 07, 2022 at 05:56:42PM +0100, Usama Arif wrote:
> > > This includes the additions to the corresponding device and driver
> > > conformances.
> > >=20
> > > Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > You can keep this. One thought:
> >=20
> > I realized that virtio-mmio support won't be very useful until
> > virtio-mmio gets MSI-X support because drivers currently cannot
> > differentiate between device auxiliary notifications.
> >=20
> > Stefan
>=20
>=20
> The big issue with MSI is it actually needs a ton of registers
> for interrupt rebalancing, masking etc and they need to be fast.
> Maybe a status bit like pci has makes sense here.

This patch does add an ISR bit:

diff --git a/content.tex b/content.tex
index 33362b7..8968fcd 100644
--- a/content.tex
+++ b/content.tex
@@ -2049,6 +2049,8 @@ \subsection{MMIO Device Register Layout}\label{sec:Vi=
rtio Transport Options / Vi
         in at least one of the active virtual queues.
       \item [Configuration Change Notification] - bit 1 - the interrupt was
         asserted because the configuration of the device has changed.
+      \item [Device-specific Driver Auxiliary Notification] - bit 2 - the =
interrupt was
+        asserted because a device-specific event occurred to notify the dr=
iver.

The problem is that the driver doesn't know which device-specific event
occurred, so the mechanism is less useful than the MSI-X approach where
the driver knows exactly which (of potentially many) device-specific
events occurred.

Stefan

--eWWCR2o7eA8vMDI1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmNgBM4ACgkQnKSrs4Gr
c8jpGAgAyd2EBROR2lev/yVmHtwLlEA140mnnRhco7+RCPsla0o2XX4upfdjH2eW
oqR+ocq0TLzAinXBPfZBfTfe9s/LDyvVQfuksXgP7tHsSitQD7eAMRvihNNxpZvW
DNsL5FgdEZHv5KGn6NtFkrYhllPEofO1wF4aGZ01dZi4/XV/W3Y/8e4LBe4DFyPU
+5L9en4oq6OI+TSAR2Z65YtCCuW9GSvj4HtuqLw5MSqJKRoc9IHX4HPptKfKvSTJ
dQciED1dJWydzmHfHRQhgkNrkEKtUBm5MIYSzf+6bJQ+5VpGEmYIM6pmvnvO2MHH
63c2B9JeCC70rM5rLImHeVuSA7p5jQ==
=pjtm
-----END PGP SIGNATURE-----

--eWWCR2o7eA8vMDI1--

