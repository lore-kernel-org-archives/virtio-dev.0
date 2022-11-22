Return-Path: <virtio-return-3879-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20221121012419.317406-3-mst@redhat.com>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-3-mst@redhat.com>
Date: Tue, 22 Nov 2022 13:11:19 +0100
Message-ID: <878rk3fau0.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio] Re: [PATCH v8 2/9] admin: introduce device group and related concepts
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Nov 20 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

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
>  admin.tex   | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  content.tex |  2 ++
>  2 files changed, 52 insertions(+)
>  create mode 100644 admin.tex
>
> diff --git a/admin.tex b/admin.tex
> new file mode 100644
> index 0000000..4337db0
> --- /dev/null
> +++ b/admin.tex
> @@ -0,0 +1,50 @@
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
> +        a device within a group. Owner device itself is not

s/Owner/The owner/

> +	a member of the group. In the future it is envisoned that
> +	new group types may be introduced where the owner
> +	device is a member of the group.

So, shouldn't it rather be: "Whether the owner device itself is a member
of the group depends on the type of the group." ? Or do we want to
prefer the owner _not_ being a member of the group?

> +\item[Member identifier]
> +        each member has this identifier, unique within the group
> +	and used to address it through the owner device.
> +\item[Group type identifier]
> +	specifies what kind of member devices there are in a
> +	group, how is the member identifier interpreted

"how the member indentifier is interpreted, ..."

> +	and what kind of control does the owner have.

s/does the owner have/the owner has/

> +	At the moment, a given owner can control
> +	a single group of a given type, thus the type and
> +	the owner together identify the group.
> +	It is envisioned that this last restriction might be relaxed in the future,
> +	with multiple groups of the same type for a given owner.

Hm...

"A given owner may control a single group of a given type (which means
that the type and the owner together identify the group), or multiple
groups of the same type. Currently, only a single group per owner is
supported." ?

Basically, I'd prefer if we spelled out what is possible in general, and
then add a comment that only a subset of the possibilities is currently
implemented.

> +\end{description}
> +
> +A single group type is currently specified:

"The following group types are currently specified:" ?

Less editing once we add a second one :)

> +\begin{description}
> +\item[SR-IOV group type]

Maybe \item[SR-IOV group type (1)] ? It's nice to have the identifier in
the title already (like we do for features.)

> +This device group has a PCI Single Root I/O Virtualization
> +(SR-IOV) physical function (PF) device as the owner and includes
> +all its SR-IOV virtual functions (VFs) as members (see
> +\hyperref[intro:PCIe]{[PCIe]}).
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


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

