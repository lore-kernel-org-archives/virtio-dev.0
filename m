Return-Path: <virtio-comment-return-3379-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <c966ef57-a1a0-a362-9b72-b172b00f38cb@nvidia.com>
Date: Tue, 16 Aug 2022 19:51:09 +0300
References: <20220812171841.12183-1-mst@redhat.com>
 <20220812171841.12183-2-mst@redhat.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220812171841.12183-2-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH RFC v7 1/8] Introduce device group
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, eperezma@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/12/2022 8:18 PM, Michael S. Tsirkin wrote:
> From: Max Gurtovoy <mgurtovoy@nvidia.com>
>
> Each device group has a type. For now, define one initial type of device
> groups: SR-IOV type.
>
> SR-IOV type - A virtio PCI SR-IOV physical function (PF) and its
> PCI SR-IOV virtual functions (VFs). This group may contain one or more
> virtio devices.
>
> Each device group has a unique identifier. This identifier is the group
> identifier.
>
> Each device within a device group has a unique identifier. This identifier
> is the group member identifier.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   admin.tex   | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>   content.tex |  2 ++
>   2 files changed, 51 insertions(+)
>   create mode 100644 admin.tex
>
> diff --git a/admin.tex b/admin.tex
> new file mode 100644
> index 0000000..6e9434a
> --- /dev/null
> +++ b/admin.tex
> @@ -0,0 +1,49 @@
> +\section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device groups}
> +
> +It is occasionally useful to have a device control a group of
> +other devices. Terminology used in such cases:
> +
> +\begin{description}
> +\item[Device group]
> +        or just group, includes zero or more devices.
> +\item[Parent device]
> +        or parent, the device controlling the group.
> +\item[Member device]
> +        a device within a group. Parent device itself may, or may
> +	not be a member of the group.
> +\item[Member identifier]
> +        each member has this indentifier, unique within the group
> +	and used to address it through the parent device.
> +\item[Group type]
> +	specifies what kind of member devices there are in a
> +	group, how is the member identifier intepreted
> +	and what kind of control does the parent have.
> +\item[Group identifier]
> +	each group has this identifier, unique within the parent device.
> +	this specifies the group type and possibly selects the
> +	group if multiple groups of the same type can be controlled by the same
> +	parent device.
> +\end{description}
> +
> +A single group type is currently specified:
> +\begin{description}
> +\item[SR-IOV group type]
> +This device group has a PCI Single Root I/O Virtualization
> +(SR-IOV) physical function (PF) device as a parent and includes
> +all its SR-IOV virtual functions (VFs) as members (see
> +\hyperref[intro:PCIe]{[PCIe]}).
> +
> +The PF device itself is not a member of the group.

This is different from my V6. Any reason to remove the PF from the group ?

If we send admin-cmd with group_member_id == 0x0 and group_id == 0x1 it 
will go to the PF, right ?

For the command list discovery for example..

> +
> +At most one group of this type can exist per PF, and
> +the group identifier for a group of this type is always 0x1.
> +
> +A member identifier for this group can have a value 0x1 to 0xFFFF
> +and equals the SR-IOV VF number of the member device (see
> +\hyperref[intro:PCIe]{[PCIe]}).
> +
> +Both parent and member devices for this group type use the Virtio
> +PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
> +\end{description}
> +
> +
> diff --git a/content.tex b/content.tex
> index e863709..6e26dff 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -449,6 +449,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
>   types. It is RECOMMENDED that devices generate version 4
>   UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>   
> +\input{admin.tex}
> +
>   \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
>   
>   We start with an overview of device initialization, then expand on the

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

