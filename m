Return-Path: virtio-return-2825-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 10 Jan 2018 13:48:54 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180110134854.62f1cf0c.cohuck@redhat.com>
In-Reply-To: <1515577653-9336-4-git-send-email-mst@redhat.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
	<1515577653-9336-4-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH v6 3/5] content: move virtqueue operation
 description
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 10 Jan 2018 11:47:57 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> virtqueue operation description is specific to the virtqueue
> format. Move it out to split-ring.tex and update all
> references.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  conformance.tex |   4 +-
>  content.tex     | 171 +++-----------------------------------------------------
>  split-ring.tex  | 168 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 178 insertions(+), 165 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

