Return-Path: virtio-return-3075-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 13 Apr 2018 11:47:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180413114720.11f13983.cohuck@redhat.com>
In-Reply-To: <4c3f5299-c745-2ec7-3ecd-9ab7b2dbb667@linux.vnet.ibm.com>
References: <1523398287-25480-1-git-send-email-pasic@linux.vnet.ibm.com>
	<1523398287-25480-4-git-send-email-pasic@linux.vnet.ibm.com>
	<20180411095018.61b0caed.cohuck@redhat.com>
	<82689e84-227f-38d2-713a-b81ef8e1dc1e@linux.vnet.ibm.com>
	<20180411180052.52616c91.cohuck@redhat.com>
	<4c3f5299-c745-2ec7-3ecd-9ab7b2dbb667@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] Re: [virtio-dev] Re: [RFC PATCH 3/3] ccw: map common
 notifications terminology to ccw
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael
 S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 12 Apr 2018 13:12:09 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 04/11/2018 06:00 PM, Cornelia Huck wrote:
> > On Wed, 11 Apr 2018 15:42:34 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >   
> >> On 04/11/2018 09:50 AM, Cornelia Huck wrote:  
> >>> On Wed, 11 Apr 2018 00:11:27 +0200
> >>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:  
> >   
> >>>> +\item Notifications (via hypercall and virtual interrupts).    
> >>>
> >>> Why 'virtual' interrupts? Better call this 'I/O interrupts' (includes
> >>> both classic and adapter interrupts)?
> >>>     
> >>
> >> The idea was 'hypercall' and 'virtual' should harmonize well. These
> >> I/O interrupts are kind of 'real' from the perspective of the virtual
> >> machine, but are 'virtual' from the perspective of HW and AR perspective.   
> > 
> > Yes, but that's an implementation detail. I/O interrupts follow the
> > same architecture in any case, there's nothing special about I/O
> > interrupts for virtio.
> >   
> 
> I'm not sure about that. For instance, there is this check your
> notifiers unsolicited subchannel associated I/O interruption. I don't
> think this is just plain old channel I/O interrupt handling.

I/O interrupts are I/O interrupts, just as in the architecture.
Indicators are additional data, and there's even precedence for that
(that's why I chose that approach in the first place).

[The fact that nothing about those other indicator users is documented
in public beyond some Linux et al. source code is not really the
problem of this spec. And I'm sure people who know me are aware of my
opinions in that regard; so let's not go down that particular rabbit
hole.]

> But you seem bothered by this 'virtual' and I respect that. So how about
> 'Notifications (via hypercall and a combination of I/O interrupts and
> indicator bits).'?

Fine with me.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

