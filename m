Return-Path: virtio-return-2819-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 10 Jan 2018 11:47:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180110114720.3d5079e6.cohuck@redhat.com>
In-Reply-To: <1515577653-9336-5-git-send-email-mst@redhat.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
	<1515577653-9336-5-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH v6 4/5] packed virtqueues: more efficient
 virtqueue layout
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 10 Jan 2018 11:47:58 +0200
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
>  content.tex     |  36 ++-
>  packed-ring.tex | 668 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 701 insertions(+), 3 deletions(-)
>  create mode 100644 packed-ring.tex

Some minor gripes by git am:

.git/rebase-apply/patch:288: trailing whitespace.
Buffer ID is included in the last descriptor in the list.  
.git/rebase-apply/patch:342: trailing whitespace.
are reserved and are ignored by the device. 

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

