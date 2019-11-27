Return-Path: virtio-return-3408-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 27 Nov 2019 08:59:56 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20191127085956.6dc635a1.cohuck@redhat.com>
In-Reply-To: <20191125025608-mutt-send-email-mst@kernel.org>
References: <20191028105508.31769-1-mst@redhat.com>
	<e4cc37c2-ac51-6260-b615-67222bbad1a5@siemens.com>
	<20191125025608-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: Re: [virtio] Re: [virtio-dev] [PATCH] content: add vendor specific
 cfg type
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 25 Nov 2019 03:11:43 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Nov 25, 2019 at 08:45:52AM +0100, Jan Kiszka wrote:
> > On 28.10.19 11:55, Michael S. Tsirkin wrote:  
> > > Vendors might want to add their own capability
> > > in the PCI capability list. However, Virtio already
> > > uses the vendor specific capability ID (0x09)
> > > for its own purposes.  
> > 
> > Did some vendor express that need, or do we only assume it so far? IOW: Do
> > we know at least once concrete use case?  
> 
> Good point, I should have added this in the log.
> 
> I know of a device that implements virtio and has a bug.
> 
> Device is a transitional one so can not have vendor specific
> subsystem IDs (that violates the SHOULD below. Do we want to qualify
> that this recommendation is for non-transitional devices?). While that

What about adding some notes on top that vendor specific subsystem IDs
are not for transitional devices? That would also catch the case in the
other update.

> specific device can't be fixed like this on bare metal, it creates a consistent way
> for future devices to trigger vendor/device specific quirks,
> and it creates an option for the hypervisor to add the capability.
> 
> > > 
> > > Provide a structure for vendor specific extensions.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >   content.tex | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 80 insertions(+)

> > > +\devicenormative{\subsection}{Vendor data capability}{Virtio
> > > +Transport Options / Virtio Over PCI Bus / PCI Device Layout /
> > > +Vendor data capability}
> > > +
> > > +The device SHOULD present the PCI subsystem vendor ID matching
> > > +the device vendor, at offset 0x2C in its PCI configuration space
> > > +header.
> > > +
> > > +Devices CAN present \field{vendor_id} that does not match
> > > +either the PCI Vendor ID or the PCI Subsystem Vendor ID.
> > > +
> > > +Devices CAN present multiple Vendor data capabilities with
> > > +either different or identical \field{vendor_id} values.
> > > +
> > > +The value \field{vendor_id} MUST NOT equal 0x1AF4.
> > > +
> > > +The size of the Vendor data capability MUST be a multiple of 4 bytes.
> > > +
> > > +Reads of the Vendor data capability by the driver MUST NOT have any
> > > +side effects.


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

