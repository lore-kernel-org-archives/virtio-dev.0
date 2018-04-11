Return-Path: virtio-return-3069-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 11 Apr 2018 14:55:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180411145545.044a11f9.cohuck@redhat.com>
In-Reply-To: <58fe7c8a-0d5a-609c-9ee9-2421eae8b649@redhat.com>
References: <1523398287-25480-1-git-send-email-pasic@linux.vnet.ibm.com>
	<1523398287-25480-2-git-send-email-pasic@linux.vnet.ibm.com>
	<20180411021955.GG28698@stefanha-x1.localdomain>
	<58fe7c8a-0d5a-609c-9ee9-2421eae8b649@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [virtio-dev] Re: [virtio] [RFC PATCH 1/3] notifications: unify
 notifications wording in core
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 11 Apr 2018 14:35:23 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 11/04/2018 04:19, Stefan Hajnoczi wrote:
> > On Wed, Apr 11, 2018 at 12:11:25AM +0200, Halil Pasic wrote:  
> >> Let us unify the wording when talking about notifications. This change
> >> establishes the terms available buffer notification for what was usually
> >> simply called notification or virtqueue notification in v1.0 and used
> >> buffer notification for what was usually called interrupt.
> >>
> >> The term configuration change notification in kept where called so and
> >> consolidated where it's called configuration change interrupt or
> >> similar.
> >>
> >> The changes done here are limited to the core part, and don't
> >> conceptually involve neither the transports nor the devices (references
> >> are updated though). Future changes should address these parts.  
> > 
> > Nice, I think the cleanup is worthwhile.  
> 
> I agree.  I wondered if we should use the term "used buffer interrupt"
> and "available buffer notification".  In the common case I think it
> would be clearer, though there are cases such as vhost-pci where the
> roles are swapped.

If it is swapped in some cases, it is bound to cause confusion for
those. I'd vote for using "notification" in both cases, as this patch
is doing.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

