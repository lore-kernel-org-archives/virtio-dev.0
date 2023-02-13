Return-Path: <virtio-return-3982-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230209121221.15118-3-mst@redhat.com>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-3-mst@redhat.com>
Date: Mon, 13 Feb 2023 13:20:34 +0100
Message-ID: <87bklxdael.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio] Re: [PATCH v10 02/10] admin: introduce device group and related
 concepts
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 09 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> +A member identifier for this group can have a value 0x1 to 0xFFFF
> +and equals the SR-IOV VF number of the member device (see
> +\hyperref[intro:PCIe]{[PCIe]}).

Maybe

"a value from 0x1 to 0xFFFF"

or

"a value between 0x1 and 0xFFFF inclusive"

?


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

