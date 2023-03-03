Return-Path: <virtio-dev-return-11425-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D879CC7EE2F
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 20:23:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3753A4256C
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 20:23:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 290469867B2
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 20:23:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1BC86985D81; Fri,  3 Mar 2023 20:23:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0AC109867A8
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Mar 2023 20:23:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: LpD5t4bcNiC9yDrQccLx7w-1
Date: Fri, 3 Mar 2023 15:23:14 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230303202314.GB2901137@fedora>
References: <cover.1677761896.git.mst@redhat.com>
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
 <20230302201011.GB2554028@fedora>
 <20230302185214-mutt-send-email-mst@kernel.org>
 <20230303131337.GA2866370@fedora>
 <20230303081515-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gQgoZ4/+77ncZk/Y"
Content-Disposition: inline
In-Reply-To: <20230303081515-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Subject: [virtio-dev] Re: [PATCH v10 03/10] admin: introduce group administration commands

--gQgoZ4/+77ncZk/Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 08:18:43AM -0500, Michael S. Tsirkin wrote:
> On Fri, Mar 03, 2023 at 08:13:37AM -0500, Stefan Hajnoczi wrote:
> > On Thu, Mar 02, 2023 at 06:57:24PM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Mar 02, 2023 at 03:10:11PM -0500, Stefan Hajnoczi wrote:
> > > > On Thu, Mar 02, 2023 at 08:05:02AM -0500, Michael S. Tsirkin wrote:
> > > > > This introduces a general structure for group administration comm=
ands,
> > > > > used to control device groups through their owner.
> > > > >=20
> > > > > Following patches will introduce specific commands and an interfa=
ce for
> > > > > submitting these commands to the owner.
> > > > >=20
> > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > ---
> > > > >  admin.tex        | 108 +++++++++++++++++++++++++++++++++++++++++=
++++++
> > > > >  introduction.tex |   3 ++
> > > > >  2 files changed, 111 insertions(+)
> > > > >=20
> > > > > diff --git a/admin.tex b/admin.tex
> > > > > index 3dc47be..7e28b77 100644
> > > > > --- a/admin.tex
> > > > > +++ b/admin.tex
> > > > > @@ -46,4 +46,112 @@ \section{Device groups}\label{sec:Basic Facil=
ities of a Virtio Device / Device g
> > > > >  PCI transport (see \ref{sec:Virtio Transport Options / Virtio Ov=
er PCI Bus}).
> > > > >  \end{description}
> > > > > =20
> > > > > +\subsection{Group administration commands}\label{sec:Basic Facil=
ities of a Virtio Device / Device groups / Group administration commands}
> > > > > =20
> > > > > +The driver sends group administration commands to the owner devi=
ce of
> > > >=20
> > > > I notice that the terminology is simply "the driver". "Owner driver"
> > > > and "group member driver" might be clearer because there will be two
> > > > (possibly different) drivers involved.
> > >=20
> > > Hmm I don't really want to repeat owner everywhere.
> > > I will clarify that in this section simple "driver" and "device" are
> > > owner, "member device" and "member driver" is always called explicitl=
y.
> >=20
> > Sounds good.
> >=20
> > > > > +a group to control member devices of the group.
> > > > > +This mechanism can
> > > > > +be used, for example, to configure a member device before it is
> > > > > +initialized by its driver.
> > > > > +\footnote{The term "administration" is intended to be interpreted
> > > > > +widely to include any kind of control. See specific commands
> > > > > +for detail.}
> > > > > +
> > > > > +All the group administration commands are of the following form:
> > > > > +
> > > > > +\begin{lstlisting}
> > > > > +struct virtio_admin_cmd {
> > > > > +        /* Device-readable part */
> > > > > +        le16 opcode;
> > > > > +        /*
> > > > > +         * 1 - SR-IOV
> > > > > +         * 2 - 65535 reserved
> > > > > +         */
> > > > > +        le16 group_type;
> > > > > +        /* unused, reserved for future extensions */
> > > > > +        u8 reserved1[12];
> > > > > +        le64 group_member_id;
> > > > > +        u8 command_specific_data[];
> > > > > +
> > > > > +        /* Device-writable part */
> > > > > +        le16 status;
> > > > > +        le16 status_qualifier;
> > > > > +        /* unused, reserved for future extensions */
> > > > > +        u8 reserved2[4];
> > > > > +        u8 command_specific_result[];
> > > > > +};
> > > > > +\end{lstlisting}
> > > > > +
> > > > > +For all commands, \field{opcode}, \field{group_type} and if
> > > > > +necessary \field{group_member_id} and \field{command_specific_da=
ta} are
> > > > > +set by the driver, and the owner device sets \field{status} and =
if
> > > > > +needed \field{status_qualifier} and
> > > > > +\field{command_specific_result}.
> > > > > +
> > > > > +Generally, any unused device-readable fields are set to zero by =
the driver
> > > > > +and ignored by the device.  Any unused device-writeable fields a=
re set to zero
> > > > > +by the device and ignored by the driver.
> > > > > +
> > > > > +\field{opcode} specifies the command. The valid
> > > > > +values for \field{opcode} can be found in the following table:
> > > > > +
> > > > > +\begin{tabular}{|l|l|}
> > > > > +\hline
> > > > > +opcode & Name & Command Description \\
> > > > > +\hline \hline
> > > > > +0x0000 - 0x7FFF & - &  Group administration commands    \\
> > > > > +\hline
> > > > > +0x8000 - 0xFFFF & - & Reserved    \\
> > > > > +\hline
> > > > > +\end{tabular}
> > > >=20
> > > > I thought all commands are "group administration commands" but this
> > > > table makes it look like they are just a subset (0x0000 - 0x7FFF) of
> > > > group administration commands, which is a paradox.
> > >=20
> > > Well the rest are reserved, maybe we will have more command types who
> > > knows. No?
> >=20
> > I see. Does that mean the reserved commands don't need to be in the same
> > format as struct virtio_admin_cmd?
>=20
> I am not good in predicting future ...
>=20
> > The entire section is called "Group administration commands" but I get
> > the impression it's talking both about admin virtqueue commands in
> > general and specifically about group administration commands.
> >=20
> > Is it possible to structure this as follows:
> >=20
> >   Admin Commands
> >     ...common stuff...
> >     Group Administration Commands (0x0000-0x7fff)
> >       ...specific to group administration commands...
> >     Reserved (0x8000-0xffff)
>=20
> What if I just write it like this:
>=20
>=20
> > > > > +\hline \hline
> > > > > +0x0000 - 0x7FFF & - &  commands using struct virtio_admin_cmd   =
 \\
> > > > > +\hline
> > > > > +0x8000 - 0xFFFF & - & Reserved for future commands (possibly usi=
ng a different structure)    \\
>=20
>=20
> will this address the comment?

Yes, thanks.

Stefan

--gQgoZ4/+77ncZk/Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQCVzIACgkQnKSrs4Gr
c8hnZQf+KEiVhiW1rdmhM7o9wuir7MXJ4BnYRTMUZo+4K8P2PzV+QMSd8zWx6wvg
h3q85g8XUB5NTHRA965EsRMkXMaFwSaT1YR0VGVlQMZvppE4pSAdOvPNOytzJKDH
9Tz5QgsSvFTfFQULUvpJx+rJg+EncYpY+8Qbm8U8zi/T8H87KGh+yNerUGg/yMyd
rDpdR8ipaK96tIbpsBFZQazdZMAVEuPhu86Xkh/NPZH1gV6AaabwNam+BgRgA8xv
7GARGoMVsrSeGNigXKiQVu9wDMrPvXEz9waZjbPBPjLxtGbf9a0T1YDLBN9iF6XA
Z8ztpyKvLcwqyzCr0TPjO5PzVanehg==
=Ob6L
-----END PGP SIGNATURE-----

--gQgoZ4/+77ncZk/Y--

