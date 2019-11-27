Return-Path: virtio-return-3414-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 27 Nov 2019 10:58:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191127105750-mutt-send-email-mst@kernel.org>
References: <20191127130727.20971-1-mst@redhat.com>
 <518BF485-380F-4A9F-A43A-4B53071B4357@redhat.com>
MIME-Version: 1.0
In-Reply-To: <518BF485-380F-4A9F-A43A-4B53071B4357@redhat.com>
Subject: [virtio] Re: [virtio-comment] [PATCH] content: document speed, duplex
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Yan Vugenfirer <yvugenfi@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

It's kind of implied, and I generally dislike this kind of
"re-read" requirement since e.g. it's ok for driver to just
read these fields on every userspace query.
Can this be discussed on top?

On Wed, Nov 27, 2019 at 05:07:58PM +0200, Yan Vugenfirer wrote:
> Hi Michael,
>=20
> Currently there are also link up\down notifications. Should we add someth=
ing like:
> =E2=80=9CThe driver should re-read the speed and duplex configuration aft=
er receiving link up notification=E2=80=9D.
> What do you think?
>=20
> Best regards,
> Yan.
>=20
> > On 27 Nov 2019, at 3:07 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >=20
> > Document as used by Linux.
> >=20
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/59
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> > content.tex | 33 +++++++++++++++++++++++++++++++++
> > 1 file changed, 33 insertions(+)
> >=20
> > diff --git a/content.tex b/content.tex
> > index 9157717..6acbb19 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -2899,6 +2899,7 @@ \subsection{Feature bits}\label{sec:Device Types =
/ Network Device / Feature bits
> >=20
> > \item[VIRTIO_NET_F_STANDBY(62)] Device may act as a standby for a prima=
ry
> >     device with the same MAC address.
> > +\item[VIRTIO_NET_F_SPEED_DUPLEX(63)] Device reports speed and duplex.
> > \end{description}
> >=20
> > \subsubsection{Feature bit requirements}\label{sec:Device Types / Netwo=
rk Device / Feature bits / Feature bit requirements}
> > @@ -2958,12 +2959,27 @@ \subsection{Device configuration layout}\label{=
sec:Device Types / Network Device
> > VIRTIO_NET_F_MTU is set. This field specifies the maximum MTU for the d=
river to
> > use.
> >=20
> > +The following two fields, \field{speed} and \field{duplex}, only
> > +exist if VIRTIO_NET_F_SPEED_DUPLEX is set.
> > +
> > +\field{speed} contains the device speed, in units of 1 MByte, 0
> > +to 0x7ffffffff, or 0xfffffffff for unknown speed.
> > +
> > +\field{duplex} has the values of 0x00 for full duplex, 0x01 for
> > +half duplex and 0xff for unknown duplex state.
> > +
> > +Neither \field{speed} nor \field{duplex} changes as long as
> > +VIRTIO_NET_S_LINK_UP is set.
> > +
> > \begin{lstlisting}
> > struct virtio_net_config {
> >         u8 mac[6];
> >         le16 status;
> >         le16 max_virtqueue_pairs;
> >         le16 mtu;
> > +        le32 speed;
> > +        u8 duplex;
> > +
> > };
> > \end{lstlisting}
> >=20
> > @@ -2992,6 +3008,18 @@ \subsection{Device configuration layout}\label{s=
ec:Device Types / Network Device
> > If the driver negotiates the VIRTIO_NET_F_STANDBY feature, the device M=
AY act
> > as a standby device for a primary device with the same MAC address.
> >=20
> > +If VIRTIO_NET_F_SPEED_DUPLEX has been negotiated, \field{speed}
> > +MUST contain the device speed, in units of 1 MByte, 0 to
> > +0x7ffffffff, or 0xfffffffff for unknown.
> > +
> > +If VIRTIO_NET_F_SPEED_DUPLEX has been negotiated, \field{duplex}
> > +MUST have the values of 0x00 for full duplex, 0x01 for half
> > +duplex, or 0xff for unknown.
> > +
> > +If VIRTIO_NET_F_SPEED_DUPLEX has been negotiated, the device MUST
> > +NOT change the \field{speed} and \field{duplex} fields as long as
> > +VIRTIO_NET_S_LINK_UP is set in the \field{status}.
> > +
> > \drivernormative{\subsubsection}{Device configuration layout}{Device Ty=
pes / Network Device / Device configuration layout}
> >=20
> > A driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it.
> > @@ -3016,6 +3044,11 @@ \subsection{Device configuration layout}\label{s=
ec:Device Types / Network Device
> >=20
> > A driver SHOULD negotiate the VIRTIO_NET_F_STANDBY feature if the devic=
e offers it.
> >=20
> > +If VIRTIO_NET_F_SPEED_DUPLEX has been negotiated,
> > +the driver MUST treat any value of \field{speed} above
> > +0x7fffffff as well as any value of \field{duplex} not
> > +matching 0x00 or 0x01 as an unknown value.
> > +
> > \subsubsection{Legacy Interface: Device configuration layout}\label{sec=
:Device Types / Network Device / Device configuration layout / Legacy Inter=
face: Device configuration layout}
> > \label{sec:Device Types / Block Device / Feature bits / Device configur=
ation layout / Legacy Interface: Device configuration layout}
> > When using the legacy interface, transitional devices and drivers
> > --=20
> > MST
> >=20
> >=20
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> >=20
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.
> >=20
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.p=
df
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing=
-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
> >=20


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that=20
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php=20

