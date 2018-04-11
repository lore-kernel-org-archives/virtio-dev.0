Return-Path: virtio-return-3067-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 11 Apr 2018 13:47:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180411134711.3f70b875.cohuck@redhat.com>
In-Reply-To: <360d1dd8-f8a3-a7bc-c75f-fcae7a3fb729@linux.vnet.ibm.com>
References: <1523398287-25480-1-git-send-email-pasic@linux.vnet.ibm.com>
	<1523398287-25480-2-git-send-email-pasic@linux.vnet.ibm.com>
	<20180411021955.GG28698@stefanha-x1.localdomain>
	<360d1dd8-f8a3-a7bc-c75f-fcae7a3fb729@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [RFC PATCH 1/3] notifications: unify notifications
 wording in core
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 11 Apr 2018 12:58:37 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 04/11/2018 04:19 AM, Stefan Hajnoczi wrote:
> > On Wed, Apr 11, 2018 at 12:11:25AM +0200, Halil Pasic wrote:  

> >>  \begin{lstlisting}
> >> -virtq_disable_interrupts(vq);
> >> +virtq_disable_notifications(vq);  
> > 
> > This name is ambiguous.  Only used buffer notifications are disabled,
> > not configuration change notifications.
> >  
> 
> One could argue that the only virtqueue scoped notification received
> by the driver are used buffer notifications. That's why I thought
> this would be sufficient (btw. if it's ambiguous it was ambiguous before
> too as both options are called interrupts).
> 
> But the more straight-forward the better.

Agreed.

>  
> > How about:
> > 
> >   virtq_disable_used_buffer_notifications(vq);
> >   
> 
> In absence of further discussion I will take this for the next
> version.

Sounds good to me.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

