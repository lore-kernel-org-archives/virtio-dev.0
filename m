Return-Path: <virtio-comment-return-3894-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Fri, 20 Jan 2023 18:58:48 +0000
Message-ID: <PH0PR12MB5481F544C09ECC79ED6E369CDCC59@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230112212632.763955-1-parav@nvidia.com>
 <20230120124450.7fdacf24.pasic@linux.ibm.com>
In-Reply-To: <20230120124450.7fdacf24.pasic@linux.ibm.com>
MIME-Version: 1.0
Subject: RE: [virtio-comment] [PATCH v4] virtio-net: Avoid confusion between a
 card and a device
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Halil Pasic <pasic@linux.ibm.com>
> Sent: Friday, January 20, 2023 6:45 AM
>=20
> On Thu, 12 Jan 2023 23:26:32 +0200
> Parav Pandit <parav@nvidia.com> wrote:
>=20
> > Ethernet card is a relatively vague term in context of virtio network
> > device specification. A Ethernet card in the industry has one to
> > multiple ports, one to multiple PCI functions.
> >
> > Historically virtio network device is documented as a Ethernet card.
> > However it is usually just a single virtual Ethernet device.
>=20
> "Ethernet device" does not seem to be a well established term for what we=
 are
> trying to express here.
>=20
> Please compare:
> https://en.wikipedia.org/w/index.php?search=3Dethernet+device
> to
> https://en.wikipedia.org/w/index.php?search=3Dethernet+card
>=20
This is nowhere close to the modern virtio nic. :)
But I get your point.

> You can also have a look at
>=20
> https://www.google.com/search?q=3D%22ethernet+device%22
>=20
:)
We virtio tc have better definitions for modern network interface cards at =
[1] and [2].

[1] https://drive.google.com/file/d/1EcQ3ObZ-X-LrEPPQ5Bv5zg38HtXRp9Am/view
[2] https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html#netw=
ork-cards

> >
> > Hence, avoid this confusing term 'card' and align the specification to
> > adhere to widely used specification term as 'device' used for all
> > virtio device types.
>=20
> I don't think all the places you touch refer to the virtio device -- some=
 rather
> are for describing what the nature of the virtio device (and its function=
ality).
>=20
I will revise this in v5.
It will be better if you can review before the voting stage.

> > -0x1000      &   network card     \\
> > +0x1000      &   network device     \\
Will keep this in v5.

>=20
> This makes sense
>=20
> >  \hline
> >  0x1001     &   block device     \\
> >  \hline
> > @@ -635,7 +635,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio
> > Transport Options / Virtio Ov  \hline  \end{tabular}
> >
> > -For example, the network card device with the Virtio Device ID 1
> > +For example, the network device with the Virtio Device ID 1
> >  has the PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
> >
> >  The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY
> > reflect @@ -2912,7 +2912,7 @@ \chapter{Device Types}\label{sec:Device
> > Types}  \hline \hline
> >  0          & reserved (invalid) \\
> >  \hline
> > -1          &   network card     \\
> > +1          &   network device     \\
>=20
> This too.
>=20
Will keep this in v5.

> >  \hline
> >  2          &   block device     \\
> >  \hline
> > diff --git a/device-types/net/description.tex
> > b/device-types/net/description.tex
> > index 2bd82ee..7409f2a 100644
> > --- a/device-types/net/description.tex
> > +++ b/device-types/net/description.tex
> > @@ -1,6 +1,6 @@
> >  \section{Network Device}\label{sec:Device Types / Network Device}
> >
> > -The virtio network device is a virtual ethernet card, and is the
> > +The virtio network device is a virtual ethernet device, and is the
>=20
> See, before you change the subject is "virtio network *device*"
> and we describe it as a "virtual ethernet *card*".
>=20
> Yes we could replace card with NIC or network interface controller, or ne=
twork
> adapter, or adapter. But device does not work for me. Sorry.
network interface controller is far crisp definition that I prefer.

>=20
> >  most complex of the devices supported so far by virtio. It has
> > enhanced rapidly and demonstrates clearly how support for new
> > features are added to an existing device. Empty buffers are @@ -33,7
> > +33,7 @@ \subsection{Feature bits}\label{sec:Device Types / Network
> > Device / Feature bits
> >
> >  \begin{description}
> >  \item[VIRTIO_NET_F_CSUM (0)] Device handles packets with partial
> checksum.   This
> > -  ``checksum offload'' is a common feature on modern network cards.
> > +  ``checksum offload'' is a common feature of a modern network device.
>=20
Now that I reread, this introductory line is out of context in feature defi=
nition.
I would rather rewrite this feature bit definition as below.

From:
VIRTIO_NET_F_CSUM (0) Device handles packets with partial checksum. This "c=
hecksum offload" is a
common feature on modern network cards.

To:
VIRTIO_NET_F_CSUM (0) Device handles packets with partial checksum offload.


> Here again, we are not talking about the virtio device, but the real HW s=
tuff
> upon which the virtio device is modeled.
>=20
> >
> >  \item[VIRTIO_NET_F_GUEST_CSUM (1)] Driver handles packets with partial
> checksum.
> >
> > @@ -323,7 +323,7 @@ \subsection{Device
> > Initialization}\label{sec:Device Types / Network Device / Dev
> >
> >  \item If the VIRTIO_NET_F_MAC feature bit is set, the configuration
> >    space \field{mac} entry indicates the ``physical'' address of the
> > -  network card, otherwise the driver would typically generate a
> > random
> > +  network device, otherwise the driver would typically generate a
> > + random
> >    local MAC address.
>=20
> I guess this also explains MAC in general, not scoped down to the virtio-=
net
> device.
>=20
Feature bits are negotiated between driver and device.
So I agree that "network device" or "network card" is wrong term here.
I will change to just say device because rest of the whole spec for this an=
d all feature bits talk about device.

> All this given I'm not in favor of this patch!
>=20
> Yes, I do think we can do better than "card", but in the cases above "dev=
ice" is
> not the right way to go.
>=20
I agree, I will rephase the word around network interface controller instea=
d of card.
And rest the applicable places to say device.
Will send v5 for review.

This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

