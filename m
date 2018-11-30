Return-Path: virtio-return-3201-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 30 Nov 2018 09:56:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181130095626.11a9cfc1.cohuck@redhat.com>
In-Reply-To: <20181129194930.17637-1-mst@redhat.com>
References: <20181129194930.17637-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH] packed-ring: fix queue size for pci
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 29 Nov 2018 14:49:32 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> PCI is the only transport that has text enforcing
> a power of two size for VQs. There's no real reason
> for it to do it, so document that it does not apply
> with the packed rings.
> 
> Accordingly, drop the text "unless enforced by a transport"
> from packed ring description.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/28
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex     | 11 +++++++++--
>  packed-ring.tex |  2 +-
>  2 files changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

