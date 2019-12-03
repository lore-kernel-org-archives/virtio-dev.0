Return-Path: virtio-return-3426-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 3 Dec 2019 13:05:15 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20191203130515.589ce55f.cohuck@redhat.com>
In-Reply-To: <20191203103646.490868-1-mst@redhat.com>
References: <20191203103646.490868-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio] Re: [PATCH v3] content: document speed, duplex
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 3 Dec 2019 05:39:23 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Document as used by Linux.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/59
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> changes from v2:
> 	fix up units
> 	actually there's no way for driver to know that link up
> 	changed: it might have changed back.
> 	make the device requirement a weaker "SHOULD" and instead
> 	ask that driver re-read on each config change notification
> 
>  content.tex | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

Looks good to me.


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

