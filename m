Return-Path: <virtio-dev-return-13551-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9D7C001B0
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 12:29:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1D884330A2
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 12:29:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F0BC69863A7
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 12:29:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D4B2498636E; Tue, 15 Aug 2023 12:29:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C2D2098634B
	for <virtio-dev@lists.oasis-open.org>; Tue, 15 Aug 2023 12:29:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: nTjL2E76MFi5YuWNnYxKrw-1
Date: Tue, 15 Aug 2023 08:29:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230815122916.GA3235352@fedora>
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-2-lingshan.zhu@intel.com>
 <20230814143039.GD3146793@fedora>
 <56c6411d-2ee9-f2c2-4da7-8d708f7729a2@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p79/mmv543hF/1Xm"
Content-Disposition: inline
In-Reply-To: <56c6411d-2ee9-f2c2-4da7-8d708f7729a2@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH 1/5] virtio: introduce SUSPEND bit
 in device status

--p79/mmv543hF/1Xm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 06:31:23PM +0800, Zhu, Lingshan wrote:
>=20
>=20
> On 8/14/2023 10:30 PM, Stefan Hajnoczi wrote:
> > On Tue, Aug 15, 2023 at 03:29:00AM +0800, Zhu Lingshan wrote:
> > > This patch introudces a new status bit in the device status: SUSPEND.
> > >=20
> > > This SUSPEND bit can be used by the driver to suspend a device,
> > > in order to stablize the device states and virtqueue states.
> > >=20
> > > Its main use case is live migration.
> > >=20
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Eugenio P=C3rez <eperezma@redhat.com>
> > There is an character encoding issue in Eugenio's surname.
> Oh, I copied his SOB form his email, I will copy from git log to fix this,
> thanks for point out it.
> >=20
> > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > ---
> > >   content.tex | 18 ++++++++++++++++++
> > >   1 file changed, 18 insertions(+)
> > This patch hints at the asynchronous nature of the SUSPEND bit (the
> > driver must re-read the Device Status Field) but doesn't explain the
> > rationale or any limits.
> >=20
> > For example, is there a timeout or should the driver re-read the Device
> > Status Field forever?
> It depends on the driver, normally we expect this operation can be done
> successfully
> like how the driver/device handles FEATURES_OK.
>=20
> Once failed due to:
> 1) driver timeout, the driver can reset the device
> 2) device failure, the device can set NEEDS_RESET.

I mention this because SUSPEND involves quiescing the device so that no
requests are in flight and that can take an unbounded amount of time on
a virtio-blk, virtio-scsi, or virtiofs device. If the driver is busy
waiting for the device to report the SUSPEND bit, then that could take a
long time/forever.

Imagine a virtiofs PCI device implemented in hardware that forwards I/O
to a distributed storage system. If the distributed storage system has a
request in flight then SUSPEND needs to wait for it to complete. The
device has no control over how long that will take, but if it does not
then corruption could occur later on.

There are two issues with long SUSPEND times:
1. Busy wait CPU consumption. Since there is no interrupt that signals
   when the bit is set, the best a driver can do is to back off
   gradually and use timers to avoid hogging the CPU.
2. Synchronous blocking. If the call stack that led the driver to set
   SUSPEND is blocked until the device reports the SUSPEND bit, then
   other parts of the system could experience blocking. For example, the
   VMM might be blocked in a vhost ioctl() call, which makes the guest
   unresponsive.

Making SUSPEND asynchronous is more complicated but would allow long
SUSPEND times to be handled gracefully.

> >=20
> > Does the driver need to re-read the Device Status Field after clearing
> > the SUSPEND bit?
> I think the driver should re-read, I will add this in the next version.
> >=20
> > > diff --git a/content.tex b/content.tex
> > > index 0a62dce..1bb4401 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -47,6 +47,9 @@ \section{\field{Device Status} Field}\label{sec:Bas=
ic Facilities of a Virtio Dev
> > >   \item[DRIVER_OK (4)] Indicates that the driver is set up and ready =
to
> > >     drive the device.
> > > +\item[SUSPEND (16)] When VIRTIO_F_SUSPEND is negotiated, indicates t=
hat the
> > > +  device has been suspended by the driver.
> > > +
> > >   \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experi=
enced
> > >     an error from which it can't recover.
> > >   \end{description}
> > > @@ -73,6 +76,10 @@ \section{\field{Device Status} Field}\label{sec:Ba=
sic Facilities of a Virtio Dev
> > >   recover by issuing a reset.
> > >   \end{note}
> > > +The driver MUST NOT set SUSPEND if FEATURES_OK is not set.
> > > +
> > > +When set SUSPEND, the driver MUST re-read \field{device status} to e=
nsure the SUSPEND bit is set.
> > "When setting SUSPEND, ..." would be grammatically correct. Another
> > option is "After setting the SUSPEND bit, ...".
> Will fix in the next version.
> >=20
> > > +
> > >   \devicenormative{\subsection}{Device Status Field}{Basic Facilities=
 of a Virtio Device / Device Status Field}
> > >   The device MUST NOT consume buffers or send any used buffer
> > > @@ -82,6 +89,13 @@ \section{\field{Device Status} Field}\label{sec:Ba=
sic Facilities of a Virtio Dev
> > >   that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_=
NEEDS_RESET, the device
> > >   MUST send a device configuration change notification to the driver.
> > > +The device MUST ignore SUSPEND if FEATURES_OK is not set.
> > > +
> > > +The deivce MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negotiated.

I noticed a typo:
"device MUST"

> > > +
> > > +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device MUS=
T clear SUSPEND
> > > +and resumes operation upon DRIVER_OK.
> > I can't parse this sentence. If the driver writes SUSPEND | DRIVER_OK |
> > ... to the Device Status Field, then the device accepts DRIVER_OK and
> > clears SUSPEND?
> >=20
> > Why?
> I expect DRIVER_OK can clear SUSPEND, so that the device can resume runni=
ng
> in case of a failed live migration.
>=20
> Maybe I should say: DRIVER_OK clears SUSPEND, and if DRIVER_OK is set to
> a suspended device, the device should resume operation

It's confusing because there are other Device Status Field bits aside
=66rom DRIVER_OK. I wasn't sure what you meant.

I think this is really saying that devices must support the SUSPEND ->
!SUSPEND transition. It's not really about DRIVER_OK because that bit
will be set the entire time (!SUSPEND -> SUSPEND -> !SUSPEND).

Can you rephrase it? For example:

  If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device MUST
  resume operation when the driver clears the SUSPEND bit.

Stefan

--p79/mmv543hF/1Xm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTbb5wACgkQnKSrs4Gr
c8josQgAxQlrw7eWnkpQRS57eySpjCvTw4T9PPRV5hLr0dzD1p/IQJpXC30DtLW5
TSLAY2UnHpqIJTR+qoAuCc+q8/xL51VwtTWHF6hCaukCxbhsbnKe5QuiiMZwshpr
jJdi2RE1H93ndFoui+1Yqa5M4Usmjpw5sPJ68bol4LcOgDQwWz05veB0cM2Q1/pl
PMKjuHHdt8bnhxdxFCLA82A9/iObkiWTJSSt7yk6FEnrPe3Q8bmTxOs/QqQL2jo6
s4Cbj+X34Fzr1GH+W1A4eZnPMLZFitrpNL8mIpbCMTCghPDuPQySh/2KEMqNCXji
cvgetZFbr5DTuKT/hUQKuJUWDPMyuw==
=yoIL
-----END PGP SIGNATURE-----

--p79/mmv543hF/1Xm--

