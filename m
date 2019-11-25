Return-Path: virtio-return-3406-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 25 Nov 2019 11:14:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20191125111420.4a905d7d.cohuck@redhat.com>
In-Reply-To: <20191125032108-mutt-send-email-mst@kernel.org>
References: <20191028161240.24806-1-mst@redhat.com>
	<aacb3a7b-9930-275c-3c80-73370e587e85@siemens.com>
	<20191125032108-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: Re: [virtio] [PATCH] pci: strengthen requirement of the correct
 subsystem id
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 25 Nov 2019 03:22:13 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Nov 25, 2019 at 07:41:09AM +0100, Jan Kiszka wrote:
> > On 28.10.19 17:12, Michael S. Tsirkin wrote:  
> > > If a hardware implementation of virtio does not have
> > > the correct subsystem id, then drivers can't report
> > > ir properly, or detect and work around bugs.  
> > 
> > s/ir/it.
> > 
> > Jan
> >   
> > > Change the requirement from MAY to SHOULD.
> > > 
> > > We can't make it a MUST since we did not require this
> > > historically.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>  
> 
> 
> One thing I noticed is that for transitional devices, windows drivers
> bind to a specific vendor id. I guess we need to make this
> SHOULD for non-transitional only?

So, they have different binding behaviour for transitional vs
non-transitional devices? Or transitional vs non-transitional drivers?

> 
> 
> > > ---
> > >   content.tex | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/content.tex b/content.tex
> > > index 4bcb728..8f1518c 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -562,7 +562,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
> > >   For example, the network card device with the Virtio Device ID 1
> > >   has the PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
> > > -The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
> > > +The PCI Subsystem Vendor ID and the PCI Subsystem Device ID SHOULD reflect
> > >   the PCI Vendor and Device ID of the environment (for informational purposes by the driver).
> > >   Non-transitional devices SHOULD have a PCI Device ID in the range


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

