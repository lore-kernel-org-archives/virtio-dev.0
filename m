Return-Path: <virtio-dev-return-9380-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1B930986281
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Apr 2022 12:03:17 +0000 (UTC)
Date: Mon, 4 Apr 2022 08:03:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220404072833-mutt-send-email-mst@kernel.org>
References: <20220302155608.24189-1-mgurtovoy@nvidia.com>
 <20220302155608.24189-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220302155608.24189-2-mgurtovoy@nvidia.com>
Subject: [virtio-dev] Re: [PATCH v1 1/5] virtio: Introduce virtio subsystem
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 02, 2022 at 05:56:04PM +0200, Max Gurtovoy wrote:
> A virtio subsystem may contain one or more virtio devices. All of the
> devices that make up a virtio subsystem share the same virtio subsystem
> unique identifier. This identifier is the virtio qualified name (VQN).
> Each device within a virtio subsystem has a unique identifier. This
> identifier is the virtio device id (vdev_id). The combination of these
> identifiers forms a globally unique value identifies a virtio device.
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

OK linux and qemu releases finally settling down so I have the time
to review this, sorry about the delay.

> ---
>  introduction.tex | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/introduction.tex b/introduction.tex
> index 6d52717..8e6611e 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -240,5 +240,23 @@ \section{Constant Specifications}
>  refer to values 1 and 2 of Fld respectively. Further, VIRTIO_FLD_XXX refers to
>  either VIRTIO_FLD_A or VIRTIO_FLD_B.
>  
> +\section{Definitions}\label{sec:Introduction / Definitions}

I think this belongs in Terminology section.

> +
> +\subsection{virtio device}\label{sec:Introduction / Definitions / virtio device}
> +
> +An entity that implements virtio specification.

Applies to a driver equally ... if we are trying to explain it further,
then I would say something along the lines of:

virtio specifies an interface
for a two-way communication between two parties called
a device and a driver. driver is the party that initiates
the communication setup and initialization.
in common usage device is part of a hypervisor and driver part
of a guest running within a VM on this hypervisor,
but other uses are not precluded.


> +\subsection{virtio subsystem}\label{sec:Introduction / Definitions / virtio subsystem}
> +
> +A virtio subsystem includes one or more virtio devices.
> +Each virtio subsystem has a unique virtio qualified name (VQN) that is permanent for the lifetime of the virtio subsystem.

the naming here is unfortunate. "subsystem" generally refers to
something like a group of drivers within linux, and to a type of
device in pci. VQN refers to a VQ number in the spec.

I would suggest simply "device group".

And please preface this with a bit of informal text explaining that
sometimes it is useful to refer to a group of devices
as a whole.


> +The VQN is a 128-bit UUID. It is RECOMMENDED to use UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.


Do we really need the UUID at all? It is unique within which context?
Can we split the UUID from this proposal?

> +Virtio devices within one virtio subsystem share the same VQN.

share in which sense? I don't see any way to retrieve the VQN from
the device itself.

> Each virtio device has a unique virtio
> +device id (vdev_id) within a virtio subsystem. A valid vdev_id is a 64-bit field in the range of
> +0x0 - 0xFFFFFFFFFFFFFFF0.

are other values reserved?

> Vdev_id 0xFFFFFFFFFFFFFFFF is a broadcast value that is used to specify all the
> +virtio devices in a virtio subsystem and isn't a valid vdev_id.

broadcast is a bit confusing. Just say "Vdev_id value 0xFFFFFFFFFFFFFFFF
refers to all devices in a group".

I think we should also add a special value meaning "this device itself".

> +
> +The vdev_id value when combined with the VQN forms a globally unique value that identifies the virtio device.
> +
>  \newpage



> -- 
> 2.21.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

