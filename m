Return-Path: <mst@redhat.com>
Date: Sun, 31 Jul 2022 16:42:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 1/5] Introduce device group
Message-ID: <20220731163940-mutt-send-email-mst@kernel.org>
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
> +\begin{note}
> +  The same device can be identified by different identifiers within different groups. For example, A virtual function device has a group

identified by different identifiers is a tautology

maybe "has different member identifiers"?

> +  member identifier equals to 0 within Self type group and a group member identifier equals to VF number (e.g 4) within SR-IOV type group.

And I think we should add:

... however, each device is a part of exactly one group of a given
group type, and has exactly one identifier within each group it is
a part of.



> +\end{note}
> +
>  \section{Structure Specifications}\label{sec:Structure Specifications}
>  
>  Many device and driver in-memory structure layouts are documented using
> -- 
> 2.21.0

