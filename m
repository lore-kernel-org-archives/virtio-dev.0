Return-Path: virtio-dev-return-6463-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 986EF985FA8
	for <virtio-dev@lists.oasis-open.org>; Thu,  5 Dec 2019 04:02:14 +0000 (UTC)
MIME-Version: 1.0
References: <20191128131941.25069-1-kraxel@redhat.com>
In-Reply-To: <20191128131941.25069-1-kraxel@redhat.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed, 4 Dec 2019 20:02:00 -0800
Message-ID: <CAAfnVBkfO47zim4t0wemLLyTte2r+hkr=+umm8E_0_J9Ketatg@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH] virtio-gpu: add shared resource feature
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 28, 2019 at 5:20 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> This patch adds a new virtio feature for shared resources.
>
> Shared resources are allocated by the guest from normal ram, like
> traditional resources.  They can be used by the guest almost like
> traditional resources, the only exception is that shared resources can
> only be used with backing storage attached (the linux driver does that
> anyway so the workflow doesn't change).  The host can map these
> resources and use them directly (using udmabuf), so any guest changes to
> these resources can be visible on the host without explicit transfer
> request.  Transfer requests are still needed though as the host might
> still have syncronize the resource, for example in case importing the
> udmabuf failed for some reason.
>
> guest/host interface: Two new commands are added to create 2D and 3D
> shared resources.  They work exactly like the non-shared counterparts.
>
> qemu patches:
>   https://git.kraxel.org/cgit/qemu/log/?h=3Dsirius/virtio-gpu-feature-sha=
red
>
> linux patches:
>   https://git.kraxel.org/cgit/linux/log/?h=3Ddrm-virtio-feature-shared
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  virtio-gpu.tex | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/virtio-gpu.tex b/virtio-gpu.tex
> index 15dbf9f2ec82..ca27b3d5fa45 100644
> --- a/virtio-gpu.tex
> +++ b/virtio-gpu.tex
> @@ -35,6 +35,7 @@ \subsection{Feature bits}\label{sec:Device Types / GPU =
Device / Feature bits}
>  \begin{description}
>  \item[VIRTIO_GPU_F_VIRGL (0)] virgl 3D mode is supported.
>  \item[VIRTIO_GPU_F_EDID  (1)] EDID is supported.
> +\item[VIRTIO_GPU_F_RESOURCE_SHARED  2)] shared resources are supported.
>  \end{description}
>
>  \subsection{Device configuration layout}\label{sec:Device Types / GPU De=
vice / Device configuration layout}
> @@ -103,6 +104,8 @@ \subsubsection{Device Operation: Create a framebuffer=
 and configure scanout}
>
>  \begin{itemize*}
>  \item Create a host resource using VIRTIO_GPU_CMD_RESOURCE_CREATE_2D.
> +  In case VIRTIO_GPU_F_RESOURCE_SHARED is negotiated the driver can
> +  also use VIRTIO_GPU_CMD_RESOURCE_CREATE_2D_SHARED.
>  \item Allocate a framebuffer from guest ram, and attach it as backing
>    storage to the resource just created, using
>    VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING.  Scatter lists are
> @@ -166,6 +169,28 @@ \subsubsection{Device Operation: Configure mouse cur=
sor}
>  the pointer shape and position.  To move the pointer without updating
>  the shape use VIRTIO_GPU_CMD_MOVE_CURSOR instead.
>
> +\subsubsection{Device Operation: Shared resources}
> +
> +In case VIRTIO_GPU_F_RESOURCE_SHARED is negotiated the driver can use
> +the VIRTIO_GPU_CMD_RESOURCE_CREATE_2D_SHARED command to create shared
> +resources.  Normal resources have both a guest buffer and host buffer
> +buffer for the resource and the VIRTIO_GPU_CMD_TRANSFER_* commands are
> +used to transfer data between host and guest.  Shared (guest
> +allocated) buffers CAN be used directly by the host, to remove or
> +reduce the data copies needed.
> +
> +The driver MUST attach backing storage to a shared resource before
> +using it.  Any changes on the shared resource MAY be instantly visible
> +on the host.

If the following scenario happens:

1) Driver sends RESOURCE_CREATE_2D shared request
2) Driver sends ATTACH_BACKING request
3) Device creates a shared resource
4) Driver sends SET_SCANOUT request
5) Device sends shared resource to display
6) Driver sends DETACH_BACKING request

How do we synchronize between (5) and (6)?  Is there a guarantee the
shared pages won't go back to guest RAM, and will be owned by the
display (like traditional dma-bufs)?

> +
> +Otherwise the shared resources are used like normal resources.
> +Especially the driver must send explicit VIRTIO_GPU_CMD_TRANSFER_*
> +commands to the device for both normal and shared resources.  Reason:
> +The device might have to flush caches.

Can we make this spec stronger to avoid to avoid transfers all the
time (i.e, in virtio_gpu_update_dumb_bo)?

drm_gem_shmem_* helpers seem to use WC buffers, and dumb buffers are
traditionally WC as well.  If we mandate the host ("device?" here)
must properly clean caches at creation time, it may be possible to
avoid hypercalls for 2D_SHARED resources.

> The device MAY also choose to
> +not create mapping for the shared resource.  Especially for small
> +resources it might be more efficient to just copy the data instead of
> +establishing a shared mapping.

Should the device send a response code  (OK_SHARED} to inform the
driver that the resource is shared?  If the device can choose not to
create shared mappings, would the response code +
VIRTIO_GPU_CMD_RESOURCE_CREATE_2D + the feature flag suffice (i.e, no
VIRTIO_GPU_CMD_RESOURCE_CREATE_2D_SHARED)?

> +
>  \subsubsection{Device Operation: Request header}\label{sec:Device Types =
/ GPU Device / Device Operation / Device Operation: Request header}
>
>  All requests and responses on the virt queues have a fixed header
> @@ -186,6 +211,7 @@ \subsubsection{Device Operation: Request header}\labe=
l{sec:Device Types / GPU De
>          VIRTIO_GPU_CMD_GET_CAPSET_INFO,
>          VIRTIO_GPU_CMD_GET_CAPSET,
>          VIRTIO_GPU_CMD_GET_EDID,
> +        VIRTIO_GPU_CMD_RESOURCE_CREATE_2D_SHARED,
>
>          /* cursor commands */
>          VIRTIO_GPU_CMD_UPDATE_CURSOR =3D 0x0300,
> @@ -205,6 +231,7 @@ \subsubsection{Device Operation: Request header}\labe=
l{sec:Device Types / GPU De
>          VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID,
>          VIRTIO_GPU_RESP_ERR_INVALID_CONTEXT_ID,
>          VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER,
> +        VIRTIO_GPU_RESP_ERR_NO_BACKING_STORAGE,
>  };
>
>  #define VIRTIO_GPU_FLAG_FENCE (1 << 0)
> --
> 2.18.1
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

