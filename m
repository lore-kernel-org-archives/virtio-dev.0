Return-Path: <virtio-dev-return-10199-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6BCDF986435
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 Nov 2022 12:44:02 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20221121012419.317406-4-mst@redhat.com>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-4-mst@redhat.com>
Date: Tue, 22 Nov 2022 13:43:54 +0100
Message-ID: <875yf7f9bp.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v8 3/9] admin: introduce group administration commands
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Nov 20 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> This introduces a general structure for group administration commands,
> used to control device groups through their owner.
>
> Following patches will introduce specific commands and an interface for
> submitting these commands to the owner.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  admin.tex | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>

(...)

> +\field{opcode} specifies the command. The valid
> +values for \field{opcode} can be found in the following table:
> +
> +\begin{tabular}{|l|l|}
> +\hline
> +opcode & Command Description \\
> +\hline \hline
> +0000h - 7FFFh   & Group administration commands    \\

I think we usually use the 0x notation for hex values?

> +\hline
> +8000h - FFFFh   & Reserved    \\
> +\hline
> +\end{tabular}
> +
> +The \field{group_id} specifies the device group.
> +The \field{group_member_id} specifies the member device within the group.
> +See section \ref{sec:Introduction / Terminology / Device group}
> +for the definition of the group identifier and group member
> +identifier.
> +
> +The following table describes possible \field{status} values,

s/,/;/

> +to simplify common implementations, these are intentionally

s/these/they/

> +matching common Linux names and error numbers:
> +
> +\begin{tabular}{|l|l|l|}
> +\hline
> +Status & Name & Description \\
> +\hline \hline
> +00h   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\

0x00?

> +\hline
> +01h   & VIRTIO_ADMIN_STATUS_INVALID_OPCODE    & unsupported or invalid \field{opcode}  \\
> +\hline
> +02h   & VIRTIO_ADMIN_STATUS_INVALID_FIELD    & invalid field within command specific data  \\
> +\hline
> +03h   & VIRTIO_ADMIN_STATUS_INVALID_GROUP    & invalid group identifier was set  \\

s/was set//

> +\hline
> +04h   & VIRTIO_ADMIN_STATUS_INVALID_MEM    & invalid group member identifier was set  \\

s/was set//

> +\hline
> +other   & -    & group administration command error  \\
> +\hline
> +\end{tabular}

I assume that this means that 0-4 are reserved for these error codes and
may not be used for something else, while 'other' is basically where
each group type may define their specific error codes? So maybe make the
last line

0x05 - & - & group type specific group administration command error \\


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

