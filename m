Return-Path: virtio-return-3154-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 25 Jun 2018 16:34:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180625163411.130a83a9.cohuck@redhat.com>
In-Reply-To: <1529929292-11900-6-git-send-email-pasic@linux.ibm.com>
References: <1529929292-11900-1-git-send-email-pasic@linux.ibm.com>
	<1529929292-11900-6-git-send-email-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH v3 5/6] mmio: map common notifications terminology to
 MMIO
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael
 S. Tsirkin" <mst@redhat.com>, Pawel Moll <pawel.moll@arm.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 25 Jun 2018 14:21:31 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> The various notifications are introduced and specified in the common
> (i.e. transport agnostic) portion of this specification. How
> notifications are realised for a given transport is something each
> transport has to specify.
> 
> Let's make the relationship between the virtio over MIIO terms and the
> common terms more obvious.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
> v2 -> v3:
> * addresssed Connie's comments
> 
> ---
>  content.tex |   25 +++++++++++++------------
>  1 files changed, 13 insertions(+), 12 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

