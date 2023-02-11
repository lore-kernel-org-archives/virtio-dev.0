Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v10 02/10] admin: introduce device group and related
 concepts
Date: Sat, 11 Feb 2023 18:50:19 +0000
Message-ID: <PH0PR12MB5481A0B4EC5071410F027842DCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-3-mst@redhat.com>
In-Reply-To: <20230209121221.15118-3-mst@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>
Cc: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, February 9, 2023 7:14 AM

[..]

> +\section{Device groups}\label{sec:Basic Facilities of a Virtio Device /
> +Device groups}
> +
> +It is occasionally useful to have a device control a group of other
> +devices. Terminology used in such cases:
> +
> +\begin{description}
> +\item[Device group]
> +        or just group, includes zero or more devices.
> +\item[Owner device]
> +        or owner, the device controlling the group.
> +\item[Member device]
> +        a device within a group. The owner device itself is not
> +=09a member of the group.
> +\item[Member identifier]
> +        each member has this identifier, unique within the group
> +=09and used to address it through the owner device.
> +\item[Group type identifier]
> +=09specifies what kind of member devices there are in a
> +=09group, how is the member identifier is interpreted
> +=09and what kind of control the owner has.
> +=09A given owner can control a single group of a given type,
> +=09thus the type and the owner together identify the group.
> +=09\footnote{Even though some group types only support
> +=09=09=09specific transports, group type identifiers
> +=09=09=09are global rather than transport-specific -
> +=09=09=09we don't expect a flood of new group types.}
> \end{description}
> +
> +The following group types, and their identifiers, are currently specifie=
d):
> +\begin{description}
> +\item[SR-IOV group type (0x1)]
> +This device group has a PCI Single Root I/O Virtualization
> +(SR-IOV) physical function (PF) device as the owner and includes all
> +its SR-IOV virtual functions (VFs) as members (see
> +\hyperref[intro:PCIe]{[PCIe]}).
> +
> +The PF device itself is not a member of the group.
> +
We already mention PC as owner and in 'Owner' definition it is clarifies ab=
ove line.
It duplicate info, may be can be removed, but doesn't hurt much.

> +The group type identifier for this group is 0x1.
> +
> +A member identifier for this group can have a value 0x1 to 0xFFFF and
> +equals the SR-IOV VF number of the member device (see
> +\hyperref[intro:PCIe]{[PCIe]}).
> +
> +Both owner and member devices for this group type use the Virtio PCI
> +transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus})=
.
> +\end{description}
> +
> +
> diff --git a/content.tex b/content.tex
> index 0c2d917..ffe45c4 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -491,6 +491,8 @@ \section{Exporting Objects}\label{sec:Basic Facilitie=
s of
> a Virtio Device / Expo  types. It is RECOMMENDED that devices generate
> version 4  UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>=20
> +\input{admin.tex}
> +
>  \chapter{General Initialization And Device Operation}\label{sec:General
> Initialization And Device Operation}
>=20
>  We start with an overview of device initialization, then expand on the
> --
> MST

