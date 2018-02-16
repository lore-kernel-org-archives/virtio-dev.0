Return-Path: virtio-return-2909-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 16 Feb 2018 18:01:51 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180216180151.113ea063.cohuck@redhat.com>
In-Reply-To: <20180216092412-mutt-send-email-mst@kernel.org>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
	<20180216092412-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH v8 08/16] packed virtqueues: more efficient virtqueue
 layout
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 16 Feb 2018 09:24:12 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Performance analysis of this is in my kvm forum 2016 presentation.  The
> idea is to have a r/w descriptor in a ring structure, replacing the used
> and available ring, index and descriptor buffer.
> 
> This is also easier for devices to implement than the 1.0 layout.
> Several more enhancements will be necessary to actually make this
> efficient for devices to use.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex     |  28 ++-
>  packed-ring.tex | 646 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 671 insertions(+), 3 deletions(-)
>  create mode 100644 packed-ring.tex

I'm at the point where my eyes glaze over when I try to look at this
yet again, so you won't get a r-b from me, but

Acked-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

