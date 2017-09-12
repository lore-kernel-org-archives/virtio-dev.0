Return-Path: virtio-dev-return-2537-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 61A3D58191DF
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Sep 2017 12:23:40 -0700 (PDT)
Date: Tue, 12 Sep 2017 21:23:35 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20170912212335.34f42ec7@fiorina>
In-Reply-To: <20170912162947.130c2df2@fiorina>
References: <20170827233033.7afa49b9@fiorina>
	<20170829095726.GL25960@stefanha-x1.localdomain>
	<59A557B1.7080704@intel.com>
	<20170912162947.130c2df2@fiorina>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [Qemu-devel] [RFC] Buffers/caches in VirtIO Balloon driver
 stats
To: Wei Wang <wei.w.wang@intel.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Resending. It did not reach virtio-dev the first time.

On Tue, 12 Sep 2017 16:29:47 +0200
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> wrote:

> On Tue, 29 Aug 2017 20:01:53 +0800
> Wei Wang <wei.w.wang@intel.com> wrote:
>=20
> > On 08/29/2017 05:57 PM, Stefan Hajnoczi wrote:
> > > On Sun, Aug 27, 2017 at 11:30:33PM +0200, Tom=C3=A1=C5=A1 Golembiovsk=
=C3=BD wrote: =20
> > >> Hi, =20
> > > I have CCed the relevant mailing lists and people most recently invol=
ved
> > > in virtio-balloon discussions.  Hopefully this will help get the right
> > > people to see your questions.
> > > =20
> > >> We'd like to include information about reclaimable memory into the
> > >> statistics in VirtiO Balloon driver. Namely, we'd like to include
> > >> counters for bufferes and caches of Linux kernel. The patch itself is
> > >> pretty trivial -- no problem there. But before we do that I'd like to
> > >> get some input from the QEMU community.
> > >>
> > >> 1) Is there any reason not to have the stats there? =20
> >=20
> > Could you please share the usages of reclaimable memory via the stats?
>=20
> I'll go ahead then and start sending patches. What would be the proper
> course of action here? Send patch for the driver first, or send patch
> for QEMU first or send both patches right away?
>=20
>=20
> > >>
> > >> 2) Considering the balloon device is multiplatform (Linux, BSD,
> > >> Windows), is there a problem with including buffers/caches? These se=
em
> > >> to be specific to the Linux virtual memory subsystem. Of course, oth=
er
> > >> OSes could just report zeros. Are there some internal stats on those
> > >> OSes that could be filled in? I don't now if such or similar statist=
ic
> > >> are available on BSD. On Windows only SystemCache stat looks like
> > >> something relevant. Anyone familiar with those OSes has any suggesti=
ons?
> > >>
> > >>      =20
> >=20
> > One of the solutions that I'm thinking about is to make virtio=20
> > platform-ware.
>=20
> This is not necessary. IIUC the driver does not need to send all the
> stats. We can simply treat those stats as specific to Linux driver and
> other drivers will not send them. Then QEMU will treat them as if zero
> was reported.
>=20
> >=20
> > That is, the device by default supports
> > VIRTIO_F_LINUX,
> > VIRTIO_F_WINDOWS,
> > VIRTIO_F_BSD.
> >=20
> > For the Linux driver, only VIRTIO_F_LINUX is supported, then we can
> > have Linux specific driver implementations under that feature.
>=20
>=20
> Since there were no suggestions for similar stats on other OSes I'd say
> we treat the stats for buffers and caches as Linux specific. If there is
> any need to send similar stats for other OSes we will add new stat fields
> (specific for that particular OS).
>=20
>=20
> Thanks,
>=20
>     Tomas
>=20
> --=20
> Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

