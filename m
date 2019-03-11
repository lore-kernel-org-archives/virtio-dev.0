Return-Path: virtio-return-3289-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 11 Mar 2019 23:54:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190311235446.6570a9cd.cohuck@redhat.com>
In-Reply-To: <20190311181809.7970-1-mst@redhat.com>
References: <20190311181809.7970-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH v2] signal start and end of structures
 consistently
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 11 Mar 2019 14:18:48 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Make sure all structs have the format:
> 
> struct X {
> ...
> };
> 
> VIRTIO-170
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> Changes since v1:
> 	no text changes, fix typo in commit log reported by Cornelia
> 
>  content.tex    | 11 +++++------
>  virtio-gpu.tex |  2 +-
>  2 files changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

