Return-Path: virtio-return-2866-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 5 Feb 2018 19:55:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180205190643-mutt-send-email-mst@kernel.org>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
 <1516665617-30748-8-git-send-email-mst@redhat.com>
 <20180130145044.648bbe4e.cohuck@redhat.com>
 <180bf54b-4e40-8c24-2888-0ea102ddb772@linux.vnet.ibm.com>
 <20180205161419-mutt-send-email-mst@kernel.org>
 <c97813f5-f980-610c-4b01-987bb28b8a2a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c97813f5-f980-610c-4b01-987bb28b8a2a@linux.vnet.ibm.com>
Subject: [virtio] Re: [virtio-dev] Re: [virtio] [PATCH v7 08/11] packed virtqueues:
 more efficient virtqueue layout
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 05, 2018 at 05:57:26PM +0100, Halil Pasic wrote:
> I think it's much simpler if we get as much as possible right from
> the beginning (that is release). But that's only my very own opinion.

I agree here. If nothing else, if we can avoid making material changes
after the first public review period, we can put out a release faster,
and if delaying for another couple of days can help us avoid extra
public review periods, it's worth it.

Having said that, it doesn't make sense to wait for months just on an
off chance we'll get some comments - that's what the public review
period is for.

-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

