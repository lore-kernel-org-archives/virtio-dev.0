Return-Path: virtio-return-3155-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 25 Jun 2018 16:37:16 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180625163716.048baaf1.cohuck@redhat.com>
In-Reply-To: <1529929292-11900-3-git-send-email-pasic@linux.ibm.com>
References: <1529929292-11900-1-git-send-email-pasic@linux.ibm.com>
	<1529929292-11900-3-git-send-email-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH v3 2/6] notifications: notifications as basic virtio
 facility
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael
 S. Tsirkin" <mst@redhat.com>, Pawel Moll <pawel.moll@arm.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 25 Jun 2018 14:21:28 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Let's introduce notifications as basic virtio facility early on. This
> shall not only increase the cohesion between core and transport
> description by having a well-defined  place where notifications are
> introduced, but also give us the opportunity to explain some
> discrepancies.
> 
> Namely notifications sent by the device to the driver were often called
> interrupts prior to v1.1. Getting completely rid of that terminology is
> however not viable in case of some names.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
> v2 -> v3:
> * Consistent use of 'configuration change notification' (instead
> of 'device configuration space notification' -- thanks Connie)
> * s/semantic/semantics/ and comma (thanks Stefan)
> ---
>  content.tex |   36 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

