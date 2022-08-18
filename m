Return-Path: <mst@redhat.com>
Date: Thu, 18 Aug 2022 04:56:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC v7 1/8] Introduce device group
Message-ID: <20220818045440-mutt-send-email-mst@kernel.org>
References: <20220812171841.12183-1-mst@redhat.com>
 <20220812171841.12183-2-mst@redhat.com>
 <CACGkMEu3S13aDuUBd9YOgzdsvOM3supjY4=v8hfxkKgo1P9p2A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEu3S13aDuUBd9YOgzdsvOM3supjY4=v8hfxkKgo1P9p2A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Cornelia Huck <cohuck@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, nrupal.jani@intel.com, "Uminski, Piotr" <Piotr.Uminski@intel.com>, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, Oren Duer <oren@nvidia.com>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Ariel Adam <aadam@redhat.com>, eperezma <eperezma@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Aug 18, 2022 at 04:37:33PM +0800, Jason Wang wrote:
> On Sat, Aug 13, 2022 at 1:19 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > From: Max Gurtovoy <mgurtovoy@nvidia.com>
> >
> > Each device group has a type. For now, define one initial type of device
> > groups: SR-IOV type.
> >
> > SR-IOV type - A virtio PCI SR-IOV physical function (PF) and its
> > PCI SR-IOV virtual functions (VFs). This group may contain one or more
> > virtio devices.
> >
> > Each device group has a unique identifier. This identifier is the group
> > identifier.
> >
> > Each device within a device group has a unique identifier. This identifier
> > is the group member identifier.
> >
> > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  admin.tex   | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  content.tex |  2 ++
> >  2 files changed, 51 insertions(+)
> >  create mode 100644 admin.tex
> >
> > diff --git a/admin.tex b/admin.tex
> > new file mode 100644
> > index 0000000..6e9434a
> > --- /dev/null
> > +++ b/admin.tex
> > @@ -0,0 +1,49 @@
> > +\section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device groups}
> > +
> > +It is occasionally useful to have a device control a group of
> > +other devices. Terminology used in such cases:
> > +
> > +\begin{description}
> > +\item[Device group]
> > +        or just group, includes zero or more devices.
> > +\item[Parent device]
> > +        or parent, the device controlling the group.
> > +\item[Member device]
> > +        a device within a group. Parent device itself may, or may
> > +       not be a member of the group.
> > +\item[Member identifier]
> > +        each member has this indentifier, unique within the group
> 
> Typo, should be "identifier"
> 
> > +       and used to address it through the parent device.
> > +\item[Group type]
> > +       specifies what kind of member devices there are in a
> > +       group, how is the member identifier intepreted
> 
> "interpreted"
> 
> > +       and what kind of control does the parent have.
> > +\item[Group identifier]
> > +       each group has this identifier, unique within the parent device.
> > +       this specifies the group type and possibly selects the
> > +       group if multiple groups of the same type can be controlled by the same
> > +       parent device.
> > +\end{description}
> > +
> > +A single group type is currently specified:
> > +\begin{description}
> > +\item[SR-IOV group type]
> > +This device group has a PCI Single Root I/O Virtualization
> > +(SR-IOV) physical function (PF) device as a parent and includes
> > +all its SR-IOV virtual functions (VFs) as members (see
> > +\hyperref[intro:PCIe]{[PCIe]}).
> > +
> > +The PF device itself is not a member of the group.
> > +
> > +At most one group of this type can exist per PF, and
> > +the group identifier for a group of this type is always 0x1.
> > +
> > +A member identifier for this group can have a value 0x1 to 0xFFFF
> > +and equals the SR-IOV VF number of the member device (see
> > +\hyperref[intro:PCIe]{[PCIe]}).
> > +
> > +Both parent and member devices for this group type use the Virtio
> > +PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
> > +\end{description}
> 
> I wonder if it's better to reserve types as transport specific ones
> and then we can move the above to the part of PCI transport.
> 
> Thanks

The point is that PCI groups are not really part of PCI
transport. They are a layer above.

We can move them down the road easily enough but for now it seems better
for readers if all the management things are collected in one place.



> > +
> > +
> > diff --git a/content.tex b/content.tex
> > index e863709..6e26dff 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -449,6 +449,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
> >  types. It is RECOMMENDED that devices generate version 4
> >  UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
> >
> > +\input{admin.tex}
> > +
> >  \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
> >
> >  We start with an overview of device initialization, then expand on the
> > --
> > MST
> >

