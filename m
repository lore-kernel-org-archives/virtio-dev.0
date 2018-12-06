Return-Path: virtio-return-3205-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 6 Dec 2018 15:09:04 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181206150904.0b0828b9.cohuck@redhat.com>
In-Reply-To: <20181206090046-mutt-send-email-mst@kernel.org>
References: <20181127010219.10441-1-mst@redhat.com>
	<20181206122432.5op6qcqpp7grtyz6@jenstp.localdomain>
	<20181206090046-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [virtio-dev] [PATCH v3] ACCESS_PLATFORM/ORDER_PLATFORM
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Freimann <jfreimann@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, pasic@linux.vnet.ibm.com, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 6 Dec 2018 09:01:08 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Dec 06, 2018 at 01:24:32PM +0100, Jens Freimann wrote:
> > On Mon, Nov 26, 2018 at 08:03:37PM -0500, Michael S. Tsirkin wrote:  
> > > +  If this feature bit is negotiated, the ordering in effect for any
> > > +  memory accesses by the driver that need to be ordered in a specific way
> > > +  with respect to accesses by the device is the one suitable for devices
> > > +  described by the platform.  
> > 
> > I had to read this sentence several times. How about: "Some memory
> > accesses by the driver need to be ordered in a specific way with
> > respect to accesses by the device. If this feature bit is negotiated,
> > these accesses need to match the ordering requirements of devices as
> > described for the platform."
> > 
> > In any case:
> > 
> > Reviewed-by: Jens Freimann <jfreimann@redhat.com>  
> 
> I think we can make this change under the trivial changes rule, thanks!

I agree, and I think that Jens' wording is easier to read.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

