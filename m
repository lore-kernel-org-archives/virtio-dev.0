Return-Path: <virtio-return-3988-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <873579d8ue.fsf@redhat.com>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-11-mst@redhat.com> <873579d8ue.fsf@redhat.com>
Date: Mon, 13 Feb 2023 14:04:41 +0100
Message-ID: <87zg9hbtsm.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio] Re: [PATCH v10 10/10] ccw: document more reserved
 features
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 13 2023, Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, Feb 09 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
>> vq reset and shared memory are unsupported, too.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>
>>
>> This is not strictly part of this patchset, but just to
>> give you the idea of how we can expand this down the road.
>
> We could split this out to a separate change on top. I think I should
> just open an issue for that.

Opened https://github.com/oasis-tcs/virtio-spec/issues/160.


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

