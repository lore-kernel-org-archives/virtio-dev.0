Return-Path: <mst@redhat.com>
Date: Mon, 1 Aug 2022 02:03:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 3/5] Introduce virtio admin virtqueue
Message-ID: <20220801020313-mutt-send-email-mst@kernel.org>
References: <20220731154354.15698-1-mgurtovoy@nvidia.com>
 <20220731154354.15698-4-mgurtovoy@nvidia.com>
 <20220731170009-mutt-send-email-mst@kernel.org>
 <472d77c2-3f32-6070-949a-95fb4bd156e8@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <472d77c2-3f32-6070-949a-95fb4bd156e8@nvidia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org, eperezma@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Aug 01, 2022 at 02:07:26AM +0300, Max Gurtovoy wrote:
>=20
> On 8/1/2022 12:00 AM, Michael S. Tsirkin wrote:
> > On Sun, Jul 31, 2022 at 06:43:52PM +0300, Max Gurtovoy wrote:
> > > In one of the many use cases a user wants to manipulate features and
> > > configuration of the virtio devices regardless of the device type
> > > (net/block/console). For that the admin command set introduced. The
> > > admin virtqueue will be the first management interface to issue admin
> > > commands.
> > >=20
> > > Currently virtio specification defines control virtqueue to manipulate
> > > features and configuration of the device it operates on. However,
> > > control virtqueue commands are device type specific, which makes it v=
ery
> > > difficult to extend for device agnostic commands.
> > >=20
> > > To support this requirement in elegant way, this patch introduces a n=
ew
> > > admin virtqueue interface.
> > >=20
> > > Manipulate features via admin virtqueue is asynchronous, scalable, ea=
sy
> > > to extend and doesn't require additional and expensive on-die resourc=
es
> > > to be allocated for every new feature that will be added in the futur=
e.
> > >=20
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > ---
> > >   admin.tex   | 12 ++++++++++++
> > >   content.tex |  6 ++++--
> > >   2 files changed, 16 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/admin.tex b/admin.tex
> > > index d14f8f7..26ac60e 100644
> > > --- a/admin.tex
> > > +++ b/admin.tex
> > > @@ -80,3 +80,15 @@ \section{Administration command set}\label{sec:Bas=
ic Facilities of a Virtio Devi
> > >   8000h - FFFFh   & Reserved    \\
> > >   \hline
> > >   \end{tabular}
> > > +
> > > +\section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio De=
vice / Admin Virtqueues}
> > > +
> > > +An admin virtqueue is a management interface of a device that can be=
 used to send administrative
> > > +commands (see \ref{sec:Basic Facilities of a Virtio Device / Adminis=
tration command set}) to manipulate
> > > +various features of the device and/or to manipulate various features=
, if possible, of another device.
> > > +
> > > +An admin virtqueue exists for a certain device if VIRTIO_F_ADMIN_VQ =
feature is
> > > +negotiated. The index of the admin virtqueue is exposed by the devic=
e in a
> > > +transport specific manner.
> > > +
> > > +If VIRTIO_F_ADMIN_VQ has been negotiated, the driver will use the ad=
min virtqueue to send all admin commands.
> > > diff --git a/content.tex b/content.tex
> > > index caab298..c15423e 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities=
 of a Virtio Device / Feature B
> > >   \begin{description}
> > >   \item[0 to 23, and 50 to 127] Feature bits for the specific device =
type
> > > -\item[24 to 40] Feature bits reserved for extensions to the queue and
> > > +\item[24 to 41] Feature bits reserved for extensions to the queue and
> > >     feature negotiation mechanisms
> > > -\item[41 to 49, and 128 and above] Feature bits reserved for future =
extensions.
> > > +\item[42 to 49, and 128 and above] Feature bits reserved for future =
extensions.
> > >   \end{description}
> > >   \begin{note}
> > > @@ -6841,6 +6841,8 @@ \chapter{Reserved Feature Bits}\label{sec:Reser=
ved Feature Bits}
> > >     that the driver can reset a queue individually.
> > >     See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / V=
irtqueue Reset}.
> > > +  \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that an admin=
istration virtqueue is supported.
> > mention here that index is in transport specific manner too?
>=20
> is this ok ?
>=20
> +=A0 \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that an
> administration virtqueue is supported.
> +=A0 The index of the administration virtqueue exposed in a transport spe=
cific
> manner.

s/exposed/is specified/

>=20
> >=20
> > > +
> > >   \end{description}
> > >   \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature =
Bits}
> > > --=20
> > > 2.21.0

