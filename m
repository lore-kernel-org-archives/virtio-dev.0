Return-Path: <virtio-dev-return-11424-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A95C7EE2F
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 20:21:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1C85523D67
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 20:21:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0B6C39867B6
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 20:21:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EDFF59867AB; Fri,  3 Mar 2023 20:21:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7FD1985D81
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Mar 2023 20:21:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: jPxv1yqxP3OJwS80MfaZ6Q-1
Date: Fri, 3 Mar 2023 15:21:33 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230303202133.GA2901137@fedora>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <20230302204007.GD2554028@fedora>
 <20230302190230-mutt-send-email-mst@kernel.org>
 <20230303132840.GC2866370@fedora>
 <20230303083213-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vj1Vne+MHXIxP9PS"
Content-Disposition: inline
In-Reply-To: <20230303083213-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Subject: [virtio-dev] Re: [virtio] Re: [PATCH v10 04/10] admin: introduce virtio admin
 virtqueues

--vj1Vne+MHXIxP9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 08:37:31AM -0500, Michael S. Tsirkin wrote:
> On Fri, Mar 03, 2023 at 08:28:40AM -0500, Stefan Hajnoczi wrote:
> > On Thu, Mar 02, 2023 at 07:05:14PM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Mar 02, 2023 at 03:40:07PM -0500, Stefan Hajnoczi wrote:
> > > > On Thu, Mar 02, 2023 at 08:05:06AM -0500, Michael S. Tsirkin wrote:
> > > > > The admin virtqueues will be the first interface to issue admin c=
ommands.
> > > > >=20
> > > > > Currently virtio specification defines control virtqueue to manip=
ulate
> > > > > features and configuration of the device it operates on. However,
> > > > > control virtqueue commands are device type specific, which makes =
it very
> > > > > difficult to extend for device agnostic commands.
> > > > >=20
> > > > > To support this requirement in a more generic way, this patch int=
roduces
> > > > > a new admin virtqueue interface.
> > > >=20
> > > > Is this referring to the existing virtio-net, virtio-scsi, etc cont=
rol
> > > > virtqueues?
> > > >=20
> > > > I see the admin virtqueue as the virtqueue equivalent to transport
> > > > feature bits. The admin queue does nothing device type-specific (ne=
t,
> > > > scsi, etc) and instead focusses on transport and core virtio tasks.
> > > >=20
> > > > Keeping the device-specific virtqueue separate from the admin virtq=
ueue
> > > > is simpler and has fewer potential problems. I don't think creating
> > > > common infrastructure for device-specific control virtqueues across
> > > > device types worthwhile or within the scope of this patch series.
> > >=20
> > > yes this commit log is outdated. referred to original
> > > proposal by Max which also planned to replace cvq.
> > > will update.
> > >=20
> > >=20
> > > > > We also support more than one admin virtqueue, for QoS and
> > > > > scalability requirements.
> > > > >=20
> > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > ---
> > > > >  admin.tex   | 74 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
> > > > >  content.tex |  7 +++--
> > > > >  2 files changed, 79 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/admin.tex b/admin.tex
> > > > > index 7e28b77..3ffac2e 100644
> > > > > --- a/admin.tex
> > > > > +++ b/admin.tex
> > > > > @@ -155,3 +155,77 @@ \subsection{Group administration commands}\l=
abel{sec:Basic Facilities of a Virti
> > > > >  \field{command_specific_data} and \field{command_specific_result}
> > > > >  depends on these structures and is described separately or is
> > > > >  implicit in the structure description.
> > > > > +
> > > > > +\section{Administration Virtqueues}\label{sec:Basic Facilities o=
f a Virtio Device / Administration Virtqueues}
> > > > > +
> > > > > +An administration virtqueue of an owner device is used to submit
> > > > > +group administration commands. An owner device can have more
> > > > > +than one administration virtqueue.
> > > > > +
> > > > > +If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device expose=
s one
> > > > > +or more adminstration virtqueues. The number and locations of the
> > > > > +administration virtqueues are exposed by the owner device in a t=
ransport
> > > > > +specific manner.
> > > > > +
> > > > > +The driver submits commands by queueing them to an arbitrary
> > > > > +administration virtqueue, and they are processed by the
> > > > > +device in the order in which they are queued. It is the
> > > > > +responsibility of the driver to ensure ordering for commands
> > > > > +placed on different administration virtqueues, because they will
> > > > > +be executed with no order constraints.
> > > >=20
> > > > Does "they are processed by the device in the order in which they a=
re
> > > > queued" mean only 1 admin command can be running at any given time =
and
> > > > therefore they will complete in order? This would allow pipelining
> > > > dependent commands but prevent long-running commands because the
> > > > virtqueue is blocked while executing a command.
> > >=20
> > > we have multiple vqs for that.
> >=20
> > This reminds me of the async challenges with QEMU's QMP monitor.
> >=20
> > Will it ever be possible to abort an in-flight command? I guess the
> > abort command would need to be submitted on another virtqueue, but how
> > do you identify the in-flight command that you wish to cancel?
> >=20
> > Please clarify the blocking semantics in the spec because it wasn't
> > clear to me.
> >=20
> > Thanks,
> > Stefan
>=20
> I don't really get what does "blocking" mean. Nothing is required to
> block I think.
> I guess for abort it is still in order but a different vq
> should not be needed.
>=20
> Maybe we can use ID of buffer to cancel commands?
>=20
> 1. driver submits command as ID =3D 1
> 2. driver submits abort as ID 2
> 3. device sees the abort and cancels ID 2
> 4. device uses buffer 1
> 5. device uses buffer 3 - abort is complete
>=20
> Device gets commands and processes them in order. It's just like scsi:
> multiple queues, if you break it you get to keep both pieces.

Now I'm confused because your earlier answer that "we have multiple vqs
for that" implied that a command that takes 1 second will stop further
processing of that vq (what I called "blocking") and the driver will
have to resort to another vq if it wishes to run other commands right
away. But your cancel example seems to use a single virtqueue, so that
would mean commands don't block after all.

My question rephrased:
What happens if a command takes 1 second to complete, is the device
allowed to process the next command from the virtqueue during this time,
possibly completing it before the first command?

This requires additional clarification in the spec because "they are
processed by the device in the order in which they are queued" does not
explain whether commands block the virtqueue (in order completion) or
not (out of order completion).

Stefan

--vj1Vne+MHXIxP9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQCVs0ACgkQnKSrs4Gr
c8g7NggAjIpAh4M32BdxFCULMVT2fOctm7shdnTubhj8Q9VdzMwLBN0gNVwlxBDw
VDIfSsdeycAjzubsrSMEIYak8Gfat/StG3kznGQApPSG/STixSoACeEeYoZXMi4O
lxalqU/TVQxPSrDhXMsf46/IWidO+EgAJHv+EIYOosNGHqmdLFfo973cepQ3HDaQ
zywGL2hgHIT3/HOTFHstdGXVcBi0NWo6lm0Q/H04F3ZunV/Tqik07k9TSzACav/O
PfVKja88skknRtrTkuZCdOetSPRdrOU04g5i/O+D63SMI3TXBpgG7+vhSevaeW/P
UxE5W9Jjj6OYjRjU9hSn7Mrwq4JFTg==
=q7Wl
-----END PGP SIGNATURE-----

--vj1Vne+MHXIxP9PS--

