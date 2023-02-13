Return-Path: <mst@redhat.com>
Date: Mon, 13 Feb 2023 07:28:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v10 02/10] admin: introduce device group and related
 concepts
Message-ID: <20230213072839-mutt-send-email-mst@kernel.org>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-3-mst@redhat.com>
 <87bklxdael.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87bklxdael.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 13, 2023 at 01:20:34PM +0100, Cornelia Huck wrote:
> On Thu, Feb 09 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > +A member identifier for this group can have a value 0x1 to 0xFFFF
> > +and equals the SR-IOV VF number of the member device (see
> > +\hyperref[intro:PCIe]{[PCIe]}).
> 
> Maybe
> 
> "a value from 0x1 to 0xFFFF"

I prefer this one, for brevity.

> or
> 
> "a value between 0x1 and 0xFFFF inclusive"
> 
> ?

