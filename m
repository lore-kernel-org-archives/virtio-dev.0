Return-Path: virtio-return-3196-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 26 Nov 2018 19:50:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181126194726-mutt-send-email-mst@kernel.org>
References: <20181121173344.475-1-mst@redhat.com>
 <20181126115656.0a79cd28.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126115656.0a79cd28.cohuck@redhat.com>
Subject: [virtio] Re: [PATCH v2] ACCESS_PLATFORM/ACCESS_ORDER
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, pasic@linux.vnet.ibm.com, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Nov 26, 2018 at 11:56:56AM +0100, Cornelia Huck wrote:
> > +It is RECOMMENDED that an add-in card based PCI device
> 
> Do we have any special meaning for capitalized RECOMMENDED?

It's in the RFC we link to: exactly same as SHOULD:
https://www.ietf.org/rfc/rfc2119.txt

> Maybe
> better reword so that we can use SHOULD or so?

SHOULD means the same and seems less clear here.

-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

