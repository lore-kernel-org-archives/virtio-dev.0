Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH] virtio-net: Define configuration field layout before its
 description
Date: Tue, 7 Feb 2023 21:33:11 +0000
Message-ID: <PH0PR12MB54810994A20AA76654D45CB4DCDB9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230203144349.34471-1-parav@nvidia.com>
 <87a61ptwkr.fsf@redhat.com>
 <PH0PR12MB54819DBBEC2AAFF681832253DCDB9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <874jrxtqzz.fsf@redhat.com>
In-Reply-To: <874jrxtqzz.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Tuesday, February 7, 2023 10:50 AM
>=20
> On Tue, Feb 07 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> >> From: Cornelia Huck <cohuck@redhat.com>
> >> Sent: Tuesday, February 7, 2023 8:49 AM
> >>
> >> On Fri, Feb 03 2023, Parav Pandit <parav@nvidia.com> wrote:
> >>
> >> > Currently some fields of the virtio_net_config structure are
> >> > defined before introducing the structure and some are defined after
> >> > introducing virtio_net_config.
> >> > Better to define the configuration layout first followed by
> >> > description of all the fields.
> >>
> >> I see that some other devices (e.g. block) list the config layout
> >> _after_ all of the descriptions, although I think listing first and
> >> then describing is the better approach. However, in-between is the
> >> worst order, and just cleaning up this one right now makes sense.
> >>
> > Yes. block can be improved too.
> > I will send separate patch for block side later.
>=20
> I think there were one or two others; but I consider none of this urgent
> :)
>=20
o.k.
Will look into it.

> >
> >> >
> >> > Device configuration fields are described in the section. Change
> >> > wording from 'listed' to 'described' as suggested in patch [1].
> >> >
> >> > [1]
> >> > https://lists.oasis-open.org/archives/virtio-dev/202302/msg00004.ht
> >> > ml
> >> >
> >> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> >> > ---
> >> >  device-types/net/description.tex | 39
> >> > +++++++++++++++++---------------
> >> >  1 file changed, 21 insertions(+), 18 deletions(-)
> >> >
> >> > diff --git a/device-types/net/description.tex
> >> > b/device-types/net/description.tex
> >> > index dedd6b1..d4f598b 100644
> >> > --- a/device-types/net/description.tex
> >> > +++ b/device-types/net/description.tex
> >> > @@ -154,11 +154,27 @@ \subsubsection{Legacy Interface: Feature
> >> > bits}\label{sec:Device Types / Network  \subsection{Device
> >> > configuration layout}\label{sec:Device Types / Network Device /
> >> > Device configuration layout}  \label{sec:Device Types / Block
> >> > Device / Feature bits / Device configuration layout}
> >> >
> >> > -Device configuration fields are listed below, they are read-only
> >> > for a driver. The \field{mac} address field -always exists (though
> >> > is only valid if VIRTIO_NET_F_MAC is set), and -\field{status} only
> >> > exists if VIRTIO_NET_F_STATUS is set. Two -read-only bits (for the
> >> > driver) are
> >> currently defined for the status field:
> >> > -VIRTIO_NET_S_LINK_UP and VIRTIO_NET_S_ANNOUNCE.
> >> > +Device configuration fields are described below, they are
> >> > +read-only for a
> >> driver.
> >>
> >> Maybe replace that with:
> >>
> >> "The network device uses the following device configuration layout.
> >> The fields are read-only for the driver."
> >>
> > I want to avoid "uses" term. Because it is the device configuration lay=
out built
> in the device.
> > How about,
> > The network device has the following device configuration layout.
>=20
> Works for me.
>=20
Ok.

> >
> >> > +
> >> > +\begin{lstlisting}
> >> > +struct virtio_net_config {
> >> > +        u8 mac[6];
> >> > +        le16 status;
> >> > +        le16 max_virtqueue_pairs;
> >> > +        le16 mtu;
> >> > +        le32 speed;
> >> > +        u8 duplex;
> >> > +        u8 rss_max_key_size;
> >> > +        le16 rss_max_indirection_table_length;
> >> > +        le32 supported_hash_types; }; \end{lstlisting}
> >> > +
> >> > +The \field{mac} address field always exists (though is only valid
> >> > +if VIRTIO_NET_F_MAC is set), and \field{status} only exists if
> >> > +VIRTIO_NET_F_STATUS is set. Two read-only bits (for the driver)
> >> > +are currently defined for the status field: VIRTIO_NET_S_LINK_UP
> >> > +and VIRTIO_NET_S_ANNOUNCE.
> >>
> >> As you are touching this anyway, maybe break it up?
> >>
> >> "The \field{mac} address field always exists (although it is only
> >> valid if VIRTIO_NET_F_MAC is set).
> >>
> > I want to avoid such change in this patch.
>=20
> This is only splitting up the sentence and tweaking the grammar, which I
> consider a rather minor change.
>=20
> > This whole section about "exist" is very confusing. Because structure l=
ayout is
> not going to change when field don't "exist". But that is counter intuiti=
ve for the
> term "exist".
> > And hence the "exist" wording is incorrect.
>=20
> I think we have been through that discussion before... would need to look
> through the archives.
>=20
> > The size of the configuration layout is totally defined by the transpor=
t.
>=20
> No, the transport only defines how the config is accessed?
>=20
VIRTIO_PCI_CAP_DEVICE_CFG for PCI and length field in virtio_pci_cap tells =
how big the config layout.
Rest of the "existence" complexity I explained above.

> > And validity of the field is driven by the feature bit and at some exte=
nt
> structure size can be shorter depending on feature.
> > So I want to park this "exist" cleanup at later point.
>=20
> Certainly, this patch should only do a simple cleanup.
>=20
Ok. Will send v2.

> >> \field{status} only exists if VIRTIO_NET_F_STATUS is set. Two
> >> read-only bits (for the driver) are currently defined for the status f=
ield:
> >> VIRTIO_NET_S_LINK_UP and VIRTIO_NET_S_ANNOUNCE."

