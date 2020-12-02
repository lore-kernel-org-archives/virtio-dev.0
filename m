Return-Path: virtio-return-3450-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 2 Dec 2020 11:54:58 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20201202115458.155f6837.cohuck@redhat.com>
In-Reply-To: <20201202093517.114406-1-mst@redhat.com>
References: <20201202093517.114406-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio] Re: [virtio-comment] [PATCH] typo: VIRTIO_NET_F_MAC_ADDR ->
 VIRTIO_NET_F_MAC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 2 Dec 2020 04:35:25 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> VIRTIO_NET_F_MAC_ADDR isn't defined. It's clear from context
> that what is meant is VIRTIO_NET_F_MAC which controls whether
> mac in config space is valid.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/90
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

