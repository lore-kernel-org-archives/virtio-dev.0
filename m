Return-Path: virtio-return-2858-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 1 Feb 2018 12:01:12 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180201120112.0739f7a8.cohuck@redhat.com>
In-Reply-To: <1516665617-30748-9-git-send-email-mst@redhat.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
	<1516665617-30748-9-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH v7 09/11] content: in-order buffer use
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 23 Jan 2018 02:01:08 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Using descriptors in-order is sometimes benefitial.  Add an option for

s/benefitial/beneficial/

> that - per-format detail allowing more optimizations will be added by
> follow-up patches.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

