Return-Path: virtio-return-2987-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 9 Mar 2018 19:06:09 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180309190231-mutt-send-email-mst@kernel.org>
References: <1519860484-7936-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519860484-7936-1-git-send-email-mst@redhat.com>
Subject: [virtio] Re: [PATCH v9 00/16] packed ring layout spec
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Mar 01, 2018 at 01:31:18AM +0200, Michael S. Tsirkin wrote:
> This addresses comments on v8.
> 
> Thanks a lot to all reviewers of v8 - I hope we are
> finally there or almost there.

FYI the last round of comments was mostly about formatting,
so I plan to post v10 and start voting immediately.
The one exception is VIRTIO_F_NOTIFICATION_DATA where
there were comments about endian-ness on s390.

I will post that too but we'll wait until Cornelia
acks before we vote. That might take a couple more weeks.

-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

