Return-Path: <mst@redhat.com>
Date: Sun, 31 Jul 2022 17:19:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 1/5] Introduce device group
Message-ID: <20220731171635-mutt-send-email-mst@kernel.org>
References: <20220731154354.15698-1-mgurtovoy@nvidia.com>
 <20220731154354.15698-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220731154354.15698-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org, eperezma@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Jul 31, 2022 at 06:43:50PM +0300, Max Gurtovoy wrote:
> Each device group has a type. For now, define 2 initial types of device
> groups: Self type and SR-IOV type.
> 
> Self type - A group that has a single virtio device as a member.
> 
> SR-IOV type - A virtio PCI SR-IOV physical function (PF) and its
> PCI SR-IOV virtual functions (VFs). This group may contain one or more
> virtio devices.
> 
> Each device group has a unique identifier. This identifier is the group
> identifier (group_id).
> 
> Each device within a device group has a unique identifier. This identifier
> is the group member identifier (group_member_id).
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  introduction.tex | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/introduction.tex b/introduction.tex
> index aa9ec1b..e8bde45 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -156,6 +156,30 @@ \subsection{Transition from earlier specification drafts}\label{sec:Transition f
>  sections tagged "Legacy Interface" in the section title.
>  These highlight the changes made since the earlier drafts.
>  
> +\subsection{Device group}\label{sec:Introduction / Terminology / Device group}
> +
> +A device group includes one or more virtio devices. Each device group has a unique group identifier (group_id).
> +A device can be a member of one or more device groups.
> +A device within a group is identified by a unique group member identifier (group_member_id).
> +The scope of the group member identifier is within the group. In other words, two device groups can have overlap group member identifiers.
> +A group member identifier is a 64-bit value in range of 0x0 - 0xFFFFFFFFFFFFFFF0.
> +A special group member identifier value of 0xFFFFFFFFFFFFFFFF refers to all the devices in a device group.
> +
> +The supported device groups are:
> +\begin{enumerate}
> +\item Self type (group identifier = 0) - this group has only one device in the group. Each virtio device is a member of at least one device group, the Self type group.
> +For this group type, the device is identified by group member identifier of 0.
> +
> +\item SR-IOV type (group identifier = 1) - this group includes a virtio PCI SR-IOV physical function (PF) and all its virtual functions (VFs).
> +For this group type, the PF device has group member identifier of 0. Each VF group member identifier equals the PCI VF number according to the PCI Express Base Specification
> +(Single Root I/O Virtualization and Sharing chapter). Devices that are members in this group use the Virtio PCI transport (for more details see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
> +\end{enumerate}
> +
> +\begin{note}
> +  The same device can be identified by different identifiers within different groups. For example, A virtual function device has a group


Hmm. I just realized.  So if a given device is part of several groups,
then these groups can support different command sets.
Of course this breaks the idea of using feature bits to specify
which commands are supported.
Interesting.

My question is what are some uses of the self type? And what are some
other examples where a single device is part of multiple groups?



> +  member identifier equals to 0 within Self type group and a group member identifier equals to VF number (e.g 4) within SR-IOV type group.
> +\end{note}
> +
>  \section{Structure Specifications}\label{sec:Structure Specifications}
>  
>  Many device and driver in-memory structure layouts are documented using
> -- 
> 2.21.0

