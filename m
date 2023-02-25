Return-Path: <mst@redhat.com>
Date: Sat, 25 Feb 2023 18:17:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] Cleanup for PCI transitional common cfg
Message-ID: <20230225181618-mutt-send-email-mst@kernel.org>
References: <20230225223001.430522-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230225223001.430522-1-parav@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Feb 26, 2023 at 12:29:58AM +0200, Parav Pandit wrote:
> Legacy interface PCI Device layout description has following issues.
> 
> 1. repeated 'structure' word
> 2. virtio header was defined the 0.9.5 spec. It is referred with
>    different keywards in this section with multiple different words
>    as (a) virtio header, (b) general headers, (c) legacy configuration
>    structure, (d) virtio common configuration structure and
>    (e) other fields.
> 3. Driver and device requirements listing is intermixed.
> 4. spelling error of structure
> 5. Legacy interface common configuration requirements are not adjacent
>    to 1.x comm
> 
> Hence, this short series overcomes above issues.

Looking at the patchset so far I'm inclined to say - leave
legacy well alone. This is not an improvement.

Gratituis changes for trivial benefit have a cost - people have to
re-read spec this to see what changed.  Making things significantly
easier for new readers would make it worth it.  As it stands - this is
not worth it.


> Patch summary:
> patch-1 overcomes above 1 to 4 issues
> patch-2 splits feature bit operations from config layout
> patch-3 relocate requirements adjacent to 1.x requirements
> 
> This series is in top of [1], [2] and [3].
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/164
> Please review.
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00578.html
> [2] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00585.html
> [3] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00597.html
> 
> Parav Pandit (3):
>   transport-pci: Improve PCI legacy device layout description
>   transport-pci: Split notes of PCI Device Layout
>   transport-pci: Relocate common config legacy interface
> 
>  conformance.tex   |   3 +-
>  transport-pci.tex | 182 +++++++++++++++++++++++++---------------------
>  2 files changed, 102 insertions(+), 83 deletions(-)
> 
> -- 
> 2.26.2

