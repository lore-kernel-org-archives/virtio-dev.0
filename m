Return-Path: virtio-return-2848-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 30 Jan 2018 11:27:50 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180130112750.661d9d35.cohuck@redhat.com>
In-Reply-To: <1516665617-30748-5-git-send-email-mst@redhat.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
	<1516665617-30748-5-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH v7 05/11] content: generalize transport ring
 part naming
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 23 Jan 2018 02:01:04 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Replace descriptor table/available ring/used ring
> with descriptor area/driver area/device area
> in all transports.
> 
> Document what's in which area.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex    | 61 ++++++++++++++++++++++++++++++++++++++--------------------
>  split-ring.tex |  6 +++---
>  2 files changed, 43 insertions(+), 24 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

