Return-Path: <virtio-dev-return-13568-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE9DC3DA4F
	for <virtio-dev@archiver.kernel.org>; Thu, 17 Aug 2023 16:05:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B6C5942A6D
	for <virtio-dev@archiver.kernel.org>; Thu, 17 Aug 2023 16:05:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 482FE9867B1
	for <virtio-dev@archiver.kernel.org>; Thu, 17 Aug 2023 16:05:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BA6A8986400; Thu, 17 Aug 2023 16:05:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 67FCF9863FE
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 Aug 2023 16:04:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: VIXwq6k0Pz2ExQVq1dhC7Q-1
Date: Thu, 17 Aug 2023 12:04:40 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>, jasowang@redhat.com,
	mst@redhat.com, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230817160440.GA3605166@fedora>
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-2-lingshan.zhu@intel.com>
 <20230814143039.GD3146793@fedora>
 <56c6411d-2ee9-f2c2-4da7-8d708f7729a2@intel.com>
 <20230815122916.GA3235352@fedora>
 <CAJaqyWd4a94FHMxAEKrQ+wpWiFECBLrWRhp24f5uYf=6TDwL+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eSWOzs4Xl15E3xJO"
Content-Disposition: inline
In-Reply-To: <CAJaqyWd4a94FHMxAEKrQ+wpWiFECBLrWRhp24f5uYf=6TDwL+Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH 1/5] virtio: introduce SUSPEND bit
 in device status

--eSWOzs4Xl15E3xJO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 05:15:16PM +0200, Eugenio Perez Martin wrote:
> On Tue, Aug 15, 2023 at 2:29=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Tue, Aug 15, 2023 at 06:31:23PM +0800, Zhu, Lingshan wrote:
> > >
> > >
> > > On 8/14/2023 10:30 PM, Stefan Hajnoczi wrote:
> > > > On Tue, Aug 15, 2023 at 03:29:00AM +0800, Zhu Lingshan wrote:
> > > > > This patch introudces a new status bit in the device status: SUSP=
END.
> > > > >
> > > > > This SUSPEND bit can be used by the driver to suspend a device,
> > > > > in order to stablize the device states and virtqueue states.
> > > > >
> > > > > Its main use case is live migration.
> > > > >
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > Signed-off-by: Eugenio P=C3=83rez <eperezma@redhat.com>
> > > > There is an character encoding issue in Eugenio's surname.
> > > Oh, I copied his SOB form his email, I will copy from git log to fix =
this,
> > > thanks for point out it.
> > > >
> > > > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > > > ---
> > > > >   content.tex | 18 ++++++++++++++++++
> > > > >   1 file changed, 18 insertions(+)
> > > > This patch hints at the asynchronous nature of the SUSPEND bit (the
> > > > driver must re-read the Device Status Field) but doesn't explain the
> > > > rationale or any limits.
> > > >
> > > > For example, is there a timeout or should the driver re-read the De=
vice
> > > > Status Field forever?
> > > It depends on the driver, normally we expect this operation can be do=
ne
> > > successfully
> > > like how the driver/device handles FEATURES_OK.
> > >
> > > Once failed due to:
> > > 1) driver timeout, the driver can reset the device
> > > 2) device failure, the device can set NEEDS_RESET.
> >
> > I mention this because SUSPEND involves quiescing the device so that no
> > requests are in flight and that can take an unbounded amount of time on
> > a virtio-blk, virtio-scsi, or virtiofs device. If the driver is busy
> > waiting for the device to report the SUSPEND bit, then that could take a
> > long time/forever.
> >
> > Imagine a virtiofs PCI device implemented in hardware that forwards I/O
> > to a distributed storage system. If the distributed storage system has a
> > request in flight then SUSPEND needs to wait for it to complete. The
> > device has no control over how long that will take, but if it does not
> > then corruption could occur later on.
> >
> > There are two issues with long SUSPEND times:
> > 1. Busy wait CPU consumption. Since there is no interrupt that signals
> >    when the bit is set, the best a driver can do is to back off
> >    gradually and use timers to avoid hogging the CPU.
> > 2. Synchronous blocking. If the call stack that led the driver to set
> >    SUSPEND is blocked until the device reports the SUSPEND bit, then
> >    other parts of the system could experience blocking. For example, the
> >    VMM might be blocked in a vhost ioctl() call, which makes the guest
> >    unresponsive.
> >
>=20
> I think all of this already happens with ring reset or even a plain
> device reset, doesn't it?

Yes, but keep in mind that the driver has typically already drained
requests when it invokes reset. If SUSPEND is used transparently during
live migration then there really will be requests in flight because the
guest driver is unaware.

>=20
> In my opinion the best thing the device can do here is to fail the
> request after a certain time, the same way it would fail if the
> backend distributed storage system gets disconnected or latency gets
> out of bounds.

In order to prevent corruption there needs to be a fence in addition to
a timeout. In other words, the storage backend needs to guarantee that
any requests sent before the fence will be ignored if they are still
encountered.

> > Making SUSPEND asynchronous is more complicated but would allow long
> > SUSPEND times to be handled gracefully.
> >
>=20
> Maybe that should be the direction of the transport vq, so transport
> commands are asynchronous and we get rid of all the similar problems
> in one shot?

Yes, a transport virtqueue would make this operation asynchronous.

Stefan

>=20
> Thanks!
>=20
> > > >
> > > > Does the driver need to re-read the Device Status Field after clear=
ing
> > > > the SUSPEND bit?
> > > I think the driver should re-read, I will add this in the next versio=
n.
> > > >
> > > > > diff --git a/content.tex b/content.tex
> > > > > index 0a62dce..1bb4401 100644
> > > > > --- a/content.tex
> > > > > +++ b/content.tex
> > > > > @@ -47,6 +47,9 @@ \section{\field{Device Status} Field}\label{sec=
:Basic Facilities of a Virtio Dev
> > > > >   \item[DRIVER_OK (4)] Indicates that the driver is set up and re=
ady to
> > > > >     drive the device.
> > > > > +\item[SUSPEND (16)] When VIRTIO_F_SUSPEND is negotiated, indicat=
es that the
> > > > > +  device has been suspended by the driver.
> > > > > +
> > > > >   \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has ex=
perienced
> > > > >     an error from which it can't recover.
> > > > >   \end{description}
> > > > > @@ -73,6 +76,10 @@ \section{\field{Device Status} Field}\label{se=
c:Basic Facilities of a Virtio Dev
> > > > >   recover by issuing a reset.
> > > > >   \end{note}
> > > > > +The driver MUST NOT set SUSPEND if FEATURES_OK is not set.
> > > > > +
> > > > > +When set SUSPEND, the driver MUST re-read \field{device status} =
to ensure the SUSPEND bit is set.
> > > > "When setting SUSPEND, ..." would be grammatically correct. Another
> > > > option is "After setting the SUSPEND bit, ...".
> > > Will fix in the next version.
> > > >
> > > > > +
> > > > >   \devicenormative{\subsection}{Device Status Field}{Basic Facili=
ties of a Virtio Device / Device Status Field}
> > > > >   The device MUST NOT consume buffers or send any used buffer
> > > > > @@ -82,6 +89,13 @@ \section{\field{Device Status} Field}\label{se=
c:Basic Facilities of a Virtio Dev
> > > > >   that a reset is needed.  If DRIVER_OK is set, after it sets DEV=
ICE_NEEDS_RESET, the device
> > > > >   MUST send a device configuration change notification to the dri=
ver.
> > > > > +The device MUST ignore SUSPEND if FEATURES_OK is not set.
> > > > > +
> > > > > +The deivce MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negoti=
ated.
> >
> > I noticed a typo:
> > "device MUST"
> >
> > > > > +
> > > > > +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device=
 MUST clear SUSPEND
> > > > > +and resumes operation upon DRIVER_OK.
> > > > I can't parse this sentence. If the driver writes SUSPEND | DRIVER_=
OK |
> > > > ... to the Device Status Field, then the device accepts DRIVER_OK a=
nd
> > > > clears SUSPEND?
> > > >
> > > > Why?
> > > I expect DRIVER_OK can clear SUSPEND, so that the device can resume r=
unning
> > > in case of a failed live migration.
> > >
> > > Maybe I should say: DRIVER_OK clears SUSPEND, and if DRIVER_OK is set=
 to
> > > a suspended device, the device should resume operation
> >
> > It's confusing because there are other Device Status Field bits aside
> > from DRIVER_OK. I wasn't sure what you meant.
> >
> > I think this is really saying that devices must support the SUSPEND ->
> > !SUSPEND transition. It's not really about DRIVER_OK because that bit
> > will be set the entire time (!SUSPEND -> SUSPEND -> !SUSPEND).
> >
> > Can you rephrase it? For example:
> >
> >   If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device MUST
> >   resume operation when the driver clears the SUSPEND bit.
> >
> > Stefan
>=20

--eSWOzs4Xl15E3xJO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTeRRgACgkQnKSrs4Gr
c8gFQAgAsCTLvPMIBo4y0SyUXsdkgzoUUVcH5j6t0Q29Y1RWijleYoxhn4PrUW2E
2VosiX577iDfaTokP/kTrxZCsT3JuMap04Kh3SQ5Cnte4+5aTAQ8uX4WPliiedbR
T53pJdyLhpTkseCvS5F+Iz5oI8t21z/QVnlP8fwkp8uhIk5qwBWr+ioXTe+JpbGd
bBTax5bfinpASKzm1MHUjLWiCJYRS20CuoOLw6oKVfRPZNL0J+7l7Adnt6hpd0B6
inn+NTs7hvsjPnfxRNT0NCEdQ/GQ4h5nAQa8dei0Azrt0CHgpRPuRJk7wk7YkB93
nl6bUS0y2H56S0lJDVaXOfFimb3PrA==
=T/GY
-----END PGP SIGNATURE-----

--eSWOzs4Xl15E3xJO--

