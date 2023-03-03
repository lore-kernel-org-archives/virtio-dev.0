Return-Path: <virtio-dev-return-11421-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB954C678D4
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 13:28:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 225F52B066
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 13:28:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 015839867AA
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 13:28:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DF7BB9867A1; Fri,  3 Mar 2023 13:28:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC7FC9867A2
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Mar 2023 13:28:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: i9tneD0ENmGZsHjdHQz8Ig-1
Date: Fri, 3 Mar 2023 08:28:40 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230303132840.GC2866370@fedora>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <20230302204007.GD2554028@fedora>
 <20230302190230-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WYmQidcJoUB3iDR+"
Content-Disposition: inline
In-Reply-To: <20230302190230-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Subject: [virtio-dev] Re: [PATCH v10 04/10] admin: introduce virtio admin virtqueues

--WYmQidcJoUB3iDR+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2023 at 07:05:14PM -0500, Michael S. Tsirkin wrote:
> On Thu, Mar 02, 2023 at 03:40:07PM -0500, Stefan Hajnoczi wrote:
> > On Thu, Mar 02, 2023 at 08:05:06AM -0500, Michael S. Tsirkin wrote:
> > > The admin virtqueues will be the first interface to issue admin comma=
nds.
> > >=20
> > > Currently virtio specification defines control virtqueue to manipulate
> > > features and configuration of the device it operates on. However,
> > > control virtqueue commands are device type specific, which makes it v=
ery
> > > difficult to extend for device agnostic commands.
> > >=20
> > > To support this requirement in a more generic way, this patch introdu=
ces
> > > a new admin virtqueue interface.
> >=20
> > Is this referring to the existing virtio-net, virtio-scsi, etc control
> > virtqueues?
> >=20
> > I see the admin virtqueue as the virtqueue equivalent to transport
> > feature bits. The admin queue does nothing device type-specific (net,
> > scsi, etc) and instead focusses on transport and core virtio tasks.
> >=20
> > Keeping the device-specific virtqueue separate from the admin virtqueue
> > is simpler and has fewer potential problems. I don't think creating
> > common infrastructure for device-specific control virtqueues across
> > device types worthwhile or within the scope of this patch series.
>=20
> yes this commit log is outdated. referred to original
> proposal by Max which also planned to replace cvq.
> will update.
>=20
>=20
> > > We also support more than one admin virtqueue, for QoS and
> > > scalability requirements.
> > >=20
> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  admin.tex   | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++
> > >  content.tex |  7 +++--
> > >  2 files changed, 79 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/admin.tex b/admin.tex
> > > index 7e28b77..3ffac2e 100644
> > > --- a/admin.tex
> > > +++ b/admin.tex
> > > @@ -155,3 +155,77 @@ \subsection{Group administration commands}\label=
{sec:Basic Facilities of a Virti
> > >  \field{command_specific_data} and \field{command_specific_result}
> > >  depends on these structures and is described separately or is
> > >  implicit in the structure description.
> > > +
> > > +\section{Administration Virtqueues}\label{sec:Basic Facilities of a =
Virtio Device / Administration Virtqueues}
> > > +
> > > +An administration virtqueue of an owner device is used to submit
> > > +group administration commands. An owner device can have more
> > > +than one administration virtqueue.
> > > +
> > > +If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device exposes one
> > > +or more adminstration virtqueues. The number and locations of the
> > > +administration virtqueues are exposed by the owner device in a trans=
port
> > > +specific manner.
> > > +
> > > +The driver submits commands by queueing them to an arbitrary
> > > +administration virtqueue, and they are processed by the
> > > +device in the order in which they are queued. It is the
> > > +responsibility of the driver to ensure ordering for commands
> > > +placed on different administration virtqueues, because they will
> > > +be executed with no order constraints.
> >=20
> > Does "they are processed by the device in the order in which they are
> > queued" mean only 1 admin command can be running at any given time and
> > therefore they will complete in order? This would allow pipelining
> > dependent commands but prevent long-running commands because the
> > virtqueue is blocked while executing a command.
>=20
> we have multiple vqs for that.

This reminds me of the async challenges with QEMU's QMP monitor.

Will it ever be possible to abort an in-flight command? I guess the
abort command would need to be submitted on another virtqueue, but how
do you identify the in-flight command that you wish to cancel?

Please clarify the blocking semantics in the spec because it wasn't
clear to me.

Thanks,
Stefan

--WYmQidcJoUB3iDR+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQB9ggACgkQnKSrs4Gr
c8gvMQgAuIaIuUNqcJ0Gb50jGQavUZsZMl6YVR2XR2QKnEcY6p8PDFAEFtWLlTen
iW64bS4RSc1s4HAq+p9mVbDm6oV+gIRCtjUI7gHe8HoRiSNVD7YugtBstsZ9rUxV
v9aP63F+i3r6xLF/mlUqPlCgTUoJ8n/gGDaSY1QMbbBClluSQH9cz2RK8sro8vQp
11WKya+TydCExDQM4itiHSTG8vzuSzY2pOKxsqaIr7b9MVIQbTdIq2AKSD8PNZK9
wpzEoBJBhaEHSPEhsZX7JNQ5onfaiDB52RdKyWp95wXo0YdApV6Q+fOJvVuNebUe
xL9P205ZQieWRU3hXRtY5nZrZDs1tQ==
=Rfl1
-----END PGP SIGNATURE-----

--WYmQidcJoUB3iDR+--

