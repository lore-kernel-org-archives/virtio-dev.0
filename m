Return-Path: virtio-return-3424-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 3 Dec 2019 11:01:52 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20191203110152.38e7f3af.cohuck@redhat.com>
In-Reply-To: <20191127130727.20971-1-mst@redhat.com>
References: <20191127130727.20971-1-mst@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio] [PATCH] content: document speed, duplex
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 27 Nov 2019 08:07:47 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Document as used by Linux.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/59
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  content.tex | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 

> +\field{speed} contains the device speed, in units of 1 MByte, 0
> +to 0x7ffffffff, or 0xfffffffff for unknown speed.

As noted by Stefan on the ballot, this needs to be MBit, not MByte.


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

