Return-Path: virtio-return-2860-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 2 Feb 2018 12:03:08 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180202120308.2ae2b92c.cohuck@redhat.com>
In-Reply-To: <1516665617-30748-10-git-send-email-mst@redhat.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
	<1516665617-30748-10-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH v7 10/11] packed-ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 23 Jan 2018 02:01:09 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Support in-order requests for packed rings.
> This allows selective write-out of used descriptors.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  packed-ring.tex | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

