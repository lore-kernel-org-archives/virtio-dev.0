Return-Path: <virtio-dev-return-13579-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78774EE49A6
	for <virtio-dev@archiver.kernel.org>; Mon, 21 Aug 2023 13:46:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4AC0AEEA39
	for <virtio-dev@archiver.kernel.org>; Mon, 21 Aug 2023 13:46:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 34DE0986283
	for <virtio-dev@archiver.kernel.org>; Mon, 21 Aug 2023 13:46:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 175F4983FE9; Mon, 21 Aug 2023 13:46:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 065D2986265
	for <virtio-dev@lists.oasis-open.org>; Mon, 21 Aug 2023 13:46:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: X73-HKHFOO2ZJDvB0gFEhg-1
Date: Mon, 21 Aug 2023 09:45:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, jasowang@redhat.com,
	mst@redhat.com, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230821134557.GA45012@fedora>
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-2-lingshan.zhu@intel.com>
 <20230814143039.GD3146793@fedora>
 <56c6411d-2ee9-f2c2-4da7-8d708f7729a2@intel.com>
 <20230815122916.GA3235352@fedora>
 <CAJaqyWd4a94FHMxAEKrQ+wpWiFECBLrWRhp24f5uYf=6TDwL+Q@mail.gmail.com>
 <20230817160440.GA3605166@fedora>
 <cc054fd2-7262-32ef-8512-0b801fbc2334@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vMt8fGVWkDD3/G37"
Content-Disposition: inline
In-Reply-To: <cc054fd2-7262-32ef-8512-0b801fbc2334@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH 1/5] virtio: introduce SUSPEND bit
 in device status

--vMt8fGVWkDD3/G37
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 05:55:42PM +0800, Zhu, Lingshan wrote:
>=20
>=20
> On 8/18/2023 12:04 AM, Stefan Hajnoczi wrote:
> > On Thu, Aug 17, 2023 at 05:15:16PM +0200, Eugenio Perez Martin wrote:
> > > On Tue, Aug 15, 2023 at 2:29=E2=80=AFPM Stefan Hajnoczi <stefanha@red=
hat.com> wrote:
> > > > On Tue, Aug 15, 2023 at 06:31:23PM +0800, Zhu, Lingshan wrote:
> > > > >=20
> > > > > On 8/14/2023 10:30 PM, Stefan Hajnoczi wrote:
> > > > > > On Tue, Aug 15, 2023 at 03:29:00AM +0800, Zhu Lingshan wrote:
> > > > > > > This patch introudces a new status bit in the device status: =
SUSPEND.
> > > > > > >=20
> > > > > > > This SUSPEND bit can be used by the driver to suspend a devic=
e,
> > > > > > > in order to stablize the device states and virtqueue states.
> > > > > > >=20
> > > > > > > Its main use case is live migration.
> > > > > > >=20
> > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > Signed-off-by: Eugenio P=C3=83rez <eperezma@redhat.com>
> > > > > > There is an character encoding issue in Eugenio's surname.
> > > > > Oh, I copied his SOB form his email, I will copy from git log to =
fix this,
> > > > > thanks for point out it.
> > > > > > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > > > > > ---
> > > > > > >    content.tex | 18 ++++++++++++++++++
> > > > > > >    1 file changed, 18 insertions(+)
> > > > > > This patch hints at the asynchronous nature of the SUSPEND bit =
(the
> > > > > > driver must re-read the Device Status Field) but doesn't explai=
n the
> > > > > > rationale or any limits.
> > > > > >=20
> > > > > > For example, is there a timeout or should the driver re-read th=
e Device
> > > > > > Status Field forever?
> > > > > It depends on the driver, normally we expect this operation can b=
e done
> > > > > successfully
> > > > > like how the driver/device handles FEATURES_OK.
> > > > >=20
> > > > > Once failed due to:
> > > > > 1) driver timeout, the driver can reset the device
> > > > > 2) device failure, the device can set NEEDS_RESET.
> > > > I mention this because SUSPEND involves quiescing the device so tha=
t no
> > > > requests are in flight and that can take an unbounded amount of tim=
e on
> > > > a virtio-blk, virtio-scsi, or virtiofs device. If the driver is busy
> > > > waiting for the device to report the SUSPEND bit, then that could t=
ake a
> > > > long time/forever.
> > > >=20
> > > > Imagine a virtiofs PCI device implemented in hardware that forwards=
 I/O
> > > > to a distributed storage system. If the distributed storage system =
has a
> > > > request in flight then SUSPEND needs to wait for it to complete. The
> > > > device has no control over how long that will take, but if it does =
not
> > > > then corruption could occur later on.
> > > >=20
> > > > There are two issues with long SUSPEND times:
> > > > 1. Busy wait CPU consumption. Since there is no interrupt that sign=
als
> > > >     when the bit is set, the best a driver can do is to back off
> > > >     gradually and use timers to avoid hogging the CPU.
> > > > 2. Synchronous blocking. If the call stack that led the driver to s=
et
> > > >     SUSPEND is blocked until the device reports the SUSPEND bit, th=
en
> > > >     other parts of the system could experience blocking. For exampl=
e, the
> > > >     VMM might be blocked in a vhost ioctl() call, which makes the g=
uest
> > > >     unresponsive.
> > > >=20
> > > I think all of this already happens with ring reset or even a plain
> > > device reset, doesn't it?
> > Yes, but keep in mind that the driver has typically already drained
> > requests when it invokes reset. If SUSPEND is used transparently during
> > live migration then there really will be requests in flight because the
> > guest driver is unaware.
> I agree, and as discussed before, I think in this series we should say:
> the device MUST wait untilall descriptors that being processed to finish =
and
> mark them as used.

Sounds good.

> Then in the following series, we should implement in-flight IO tracker.
> >=20
> > > In my opinion the best thing the device can do here is to fail the
> > > request after a certain time, the same way it would fail if the
> > > backend distributed storage system gets disconnected or latency gets
> > > out of bounds.
> > In order to prevent corruption there needs to be a fence in addition to
> > a timeout. In other words, the storage backend needs to guarantee that
> > any requests sent before the fence will be ignored if they are still
> > encountered.
> Please correct me if I misunderstand anything.
>=20
> I am not sure a remote target is aware of SUSPEND, but the device can
> fail SUSPEND by setting NEEDS_RESET for sure. IN this series,
> maybe it is best to flush and wait for the IO requests.

Yes, it is necessary to wait for pending I/O.

I was pointing out that timeouts implemented inside the storage
initiator (client) are unsafe. The storage target (server) needs to
participate in stopping in-flight I/O one way or another (timeout,
cancellation, fence, etc).

Stefan

--vMt8fGVWkDD3/G37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTjapQACgkQnKSrs4Gr
c8h2Wwf/eXtwWgGqVBZAbtFhvjS+MnXJlcRAiJ4bbhgqxCDTIHAcJMboolLPXh+B
f2ZVPdji+ct/6Z5w29cwkmB1tzu9cjgiiK1PkXdNJE7VWkKag2GVLACmCn3Yk3Aj
E2XkC0F+NlCZR5yrwgL9gSy+dg0B8wpA21sQdltdDuIdqJGpyYz6pW719NKOaBSO
FSxefuFac1Ma1WJ8qA4aSwsLS4fN7f7ie/XpEi/xd99HlMolb2HFvd9b+9Ruml4D
sBYNPvlRGdDixmvMUjPxPB95hUCJRtj5jc3IpJ3GSXzD64cvbtnvWvz+uD5GYyiT
q1PTon84hVrCZtcs9SXSvlBWV3GgXw==
=TAf7
-----END PGP SIGNATURE-----

--vMt8fGVWkDD3/G37--

