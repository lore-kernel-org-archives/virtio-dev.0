Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20221123210706.21476-1-mst@redhat.com> <20221123210706.21476-3-mst@redhat.com>
In-Reply-To: <20221123210706.21476-3-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 24 Nov 2022 13:41:41 +0800
Message-ID: <CACGkMEuuHgJ-yZmMAu0L=piUmZa8sY-v7e5FyTrpUSdZML5KUA@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] admin: introduce device group and related concepts
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Each device group has a type. For now, define one initial group:
>
> SR-IOV type - PCI SR-IOV virtual functions (VFs) of a given
> PCI SR-IOV physical function (PF). This group may contain one or more
> virtio devices.
>
> Each device within a group has a unique identifier. This identifier
> is the group member identifier.
>
> Note: one can argue both ways whether the new device group handling
> functionality (this and following patches) is closer
> to a new device type or a new transport type.
>
> However, I expect that we will add more features in the near future. To
> facilitate this as much as possible of the text is located in the new
> admin chapter.
>
> I did my best to minimize transport-specific text.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  admin.tex   | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  content.tex |  2 ++
>  2 files changed, 47 insertions(+)
>  create mode 100644 admin.tex
>
> diff --git a/admin.tex b/admin.tex
> new file mode 100644
> index 0000000..6ebdd05
> --- /dev/null
> +++ b/admin.tex
> @@ -0,0 +1,45 @@
> +\section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device groups}
> +
> +It is occasionally useful to have a device control a group of
> +other devices. Terminology used in such cases:
> +
> +\begin{description}
> +\item[Device group]
> +        or just group, includes zero or more devices.
> +\item[Owner device]
> +        or owner, the device controlling the group.
> +\item[Member device]
> +        a device within a group. The owner device itself is not
> +       a member of the group.
> +\item[Member identifier]
> +        each member has this identifier, unique within the group
> +       and used to address it through the owner device.
> +\item[Group type identifier]
> +       specifies what kind of member devices there are in a
> +       group, how is the member identifier is interpreted
> +       and what kind of control the owner has.
> +       A given owner can control a single group of a given type,
> +       thus the type and the owner together identify the group.
> +\end{description}
> +
> +The following group types, and their identifiers, are currently specified):
> +\begin{description}
> +\item[SR-IOV group type (0x1)]
> +This device group has a PCI Single Root I/O Virtualization
> +(SR-IOV) physical function (PF) device as the owner and includes
> +all its SR-IOV virtual functions (VFs) as members (see
> +\hyperref[intro:PCIe]{[PCIe]}).

So I wonder what's the advantage of using a global identifier over the
transport specific one. There's almost no way for CCW/MMIO to use
SR-IOV. Limiting it to PCI seems much easier and avoids layer
violation.

Thanks

> +
> +The PF device itself is not a member of the group.
> +
> +The group type identifier for this group is 0x1.
> +
> +A member identifier for this group can have a value 0x1 to 0xFFFF
> +and equals the SR-IOV VF number of the member device (see
> +\hyperref[intro:PCIe]{[PCIe]}).
> +
> +Both owner and member devices for this group type use the Virtio
> +PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
> +\end{description}
> +
> +
> diff --git a/content.tex b/content.tex
> index e3203be..3f3585d 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -491,6 +491,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
>  types. It is RECOMMENDED that devices generate version 4
>  UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>
> +\input{admin.tex}
> +
>  \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
>
>  We start with an overview of device initialization, then expand on the
> --
> MST
>

