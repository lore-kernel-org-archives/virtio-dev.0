Return-Path: <mst@redhat.com>
Date: Wed, 15 Feb 2023 00:18:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v10 03/10] admin: introduce group administration commands
Message-ID: <20230215001808-mutt-send-email-mst@kernel.org>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-4-mst@redhat.com>
 <PH0PR12MB5481354697752EB28F74FB3EDCA39@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481354697752EB28F74FB3EDCA39@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 15, 2023 at 05:17:21AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, February 9, 2023 7:14 AM
> 
> > +0x04   & VIRTIO_ADMIN_STATUS_Q_INVALID_MEM    & unsupported or invalid \field{group_member_id}
> To avoid confusion with memory, better to replace INVALID_MEM to INVALID_MEMBER.

Good idea.

