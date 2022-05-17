Return-Path: <virtio-return-3773-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220515105131-mutt-send-email-mst@kernel.org>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-6-mgurtovoy@nvidia.com>
 <20220515105131-mutt-send-email-mst@kernel.org>
Date: Tue, 17 May 2022 12:12:48 +0200
Message-ID: <87wnekfowv.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio] Re: [PATCH v5 5/7] Add miscellaneous configuration structure for PCI
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, May 15 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Apr 27, 2022 at 01:58:22AM +0300, Max Gurtovoy wrote:
>> This new structure will be used for adding new miscellaneous registers
>> for a virtio device configuration layout.
>> 
>> For now, only admin_queue_index register is added. Admin virtqueue index
>> does not depend on the device type. Hence, add a PCI capability to read
>> the admin virtqueue index.
>> 
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>
>
> I guess we discussed this but I forgot. Why do we have this new
> structure as opposed to just adding the value at the end of config
> structure? I was kind of hoping that the structure can be
> reused for CCW/MMIO and then we can add more use-cases with
> new transport and device independent structures.
>
> If we keep it transport specific I don't really understand why
> is it useful ...

Nod, just define a common misc_configuration struct and have the
individual transports access it in the way it works best for them.


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

