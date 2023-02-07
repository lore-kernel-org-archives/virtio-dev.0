Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH] virtio-net: Define configuration field layout before its
 description
Date: Tue, 7 Feb 2023 15:02:08 +0000
Message-ID: <PH0PR12MB54819DBBEC2AAFF681832253DCDB9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230203144349.34471-1-parav@nvidia.com>
 <87a61ptwkr.fsf@redhat.com>
In-Reply-To: <87a61ptwkr.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Tuesday, February 7, 2023 8:49 AM
>=20
> On Fri, Feb 03 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> > Currently some fields of the virtio_net_config structure are defined
> > before introducing the structure and some are defined after
> > introducing virtio_net_config.
> > Better to define the configuration layout first followed by
> > description of all the fields.
>=20
> I see that some other devices (e.g. block) list the config layout _after_=
 all of the
> descriptions, although I think listing first and then describing is the b=
etter
> approach. However, in-between is the worst order, and just cleaning up th=
is
> one right now makes sense.
>=20
Yes. block can be improved too.
I will send separate patch for block side later.

> >
> > Device configuration fields are described in the section. Change
> > wording from 'listed' to 'described' as suggested in patch [1].
> >
> > [1]
> > https://lists.oasis-open.org/archives/virtio-dev/202302/msg00004.html
> >
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> >  device-types/net/description.tex | 39
> > +++++++++++++++++---------------
> >  1 file changed, 21 insertions(+), 18 deletions(-)
> >
> > diff --git a/device-types/net/description.tex
> > b/device-types/net/description.tex
> > index dedd6b1..d4f598b 100644
> > --- a/device-types/net/description.tex
> > +++ b/device-types/net/description.tex
> > @@ -154,11 +154,27 @@ \subsubsection{Legacy Interface: Feature
> > bits}\label{sec:Device Types / Network  \subsection{Device
> > configuration layout}\label{sec:Device Types / Network Device / Device
> > configuration layout}  \label{sec:Device Types / Block Device /
> > Feature bits / Device configuration layout}
> >
> > -Device configuration fields are listed below, they are read-only for
> > a driver. The \field{mac} address field -always exists (though is only
> > valid if VIRTIO_NET_F_MAC is set), and -\field{status} only exists if
> > VIRTIO_NET_F_STATUS is set. Two -read-only bits (for the driver) are
> currently defined for the status field:
> > -VIRTIO_NET_S_LINK_UP and VIRTIO_NET_S_ANNOUNCE.
> > +Device configuration fields are described below, they are read-only fo=
r a
> driver.
>=20
> Maybe replace that with:
>=20
> "The network device uses the following device configuration layout. The f=
ields
> are read-only for the driver."
>=20
I want to avoid "uses" term. Because it is the device configuration layout =
built in the device.
How about,
The network device has the following device configuration layout.

> > +
> > +\begin{lstlisting}
> > +struct virtio_net_config {
> > +        u8 mac[6];
> > +        le16 status;
> > +        le16 max_virtqueue_pairs;
> > +        le16 mtu;
> > +        le32 speed;
> > +        u8 duplex;
> > +        u8 rss_max_key_size;
> > +        le16 rss_max_indirection_table_length;
> > +        le32 supported_hash_types;
> > +};
> > +\end{lstlisting}
> > +
> > +The \field{mac} address field always exists (though is only valid if
> > +VIRTIO_NET_F_MAC is set), and \field{status} only exists if
> > +VIRTIO_NET_F_STATUS is set. Two read-only bits (for the driver) are
> > +currently defined for the status field: VIRTIO_NET_S_LINK_UP and
> > +VIRTIO_NET_S_ANNOUNCE.
>=20
> As you are touching this anyway, maybe break it up?
>=20
> "The \field{mac} address field always exists (although it is only valid i=
f
> VIRTIO_NET_F_MAC is set).
>=20
I want to avoid such change in this patch.
This whole section about "exist" is very confusing. Because structure layou=
t is not going to change when field don't "exist". But that is counter intu=
itive for the term "exist".
And hence the "exist" wording is incorrect.
The size of the configuration layout is totally defined by the transport.
And validity of the field is driven by the feature bit and at some extent s=
tructure size can be shorter depending on feature.
So I want to park this "exist" cleanup at later point.

> \field{status} only exists if VIRTIO_NET_F_STATUS is set. Two read-only b=
its (for
> the driver) are currently defined for the status field:
> VIRTIO_NET_S_LINK_UP and VIRTIO_NET_S_ANNOUNCE."
>=20
> >
> >  \begin{lstlisting}
> >  #define VIRTIO_NET_S_LINK_UP     1
> > @@ -188,19 +204,6 @@ \subsection{Device configuration
> > layout}\label{sec:Device Types / Network Device  is expected to
> > re-read these values after receiving a  configuration change notificati=
on.
> >
> > -\begin{lstlisting}
> > -struct virtio_net_config {
> > -        u8 mac[6];
> > -        le16 status;
> > -        le16 max_virtqueue_pairs;
> > -        le16 mtu;
> > -        le32 speed;
> > -        u8 duplex;
> > -        u8 rss_max_key_size;
> > -        le16 rss_max_indirection_table_length;
> > -        le32 supported_hash_types;
> > -};
> > -\end{lstlisting}
> >  The following field, \field{rss_max_key_size} only exists if VIRTIO_NE=
T_F_RSS
> or VIRTIO_NET_F_HASH_REPORT is set.
> >  It specifies the maximum supported length of RSS key in bytes.

