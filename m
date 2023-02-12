Return-Path: <mst@redhat.com>
Date: Sun, 12 Feb 2023 04:42:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v10 00/10] Introduce device group and device management
Message-ID: <20230212044100-mutt-send-email-mst@kernel.org>
References: <20230209121221.15118-1-mst@redhat.com>
 <PH0PR12MB54817FB7BA47369974018BAFDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54817FB7BA47369974018BAFDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Feb 11, 2023 at 06:49:52PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, February 9, 2023 7:13 AM
> 
> [..]
> 
> > My intent is to try and support both SR-IOV and SIOV usecases with the same
> > structure and maybe even the same VQ.
> > 
> Probably it is implicit, but is better for us to mention few examples use cases here something like,
> 
> Admin queue is an infrastructure to support use cases like:
> a. SIOV devices life cycles management (create, destroy, query, configure)
> b. SR-IOV VF device/resource management (SR-PCIM)
> c. May be transport
> 
> > For example, it might make sense to split creating/destroying SIOV devices
> > from the transport passing data from the guest - the driver would then not
> > negotiate VIRTIO_F_SR_IOV (which then means auto-provisioning).
> 
> Above intermixing of SIOV and SR_IOV is very confusing.
> Can you please drop it and have simpler examples like above?

You mean in the cover letter? The more info in the cover
letter the better, this stuff does not end up in git.
I'll add your examples too though, thanks!

-- 
MST

