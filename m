Return-Path: virtio-return-3275-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 11 Mar 2019 17:49:07 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190311174907.0b5a9127.cohuck@redhat.com>
In-Reply-To: <20190311160018.29995-1-mst@redhat.com>
References: <20190311160018.29995-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH v3] conformance: clarify
 transitional/non-transitional
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 11 Mar 2019 12:00:46 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Clarify that:
> - non-transitional just satisfy 3 main clauses
> - transitional also has a legacy interface:
>   however note that it's not an optional component
>   *for transitional devices* so MAY is inappropriate
> - legacy device descriptions are non-normative.
>   In fact virtio 0.9 is non-normative as a whole
>   and always was by design: it was early days and
>   spec evolved to document bugs in implementations.
> 
> VIRTIO-167
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Changes from v1:
> 	address remaining comments by Cornelia
> Changes from v1:
> 	address comments by Cornelia
> 
>  conformance.tex | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

