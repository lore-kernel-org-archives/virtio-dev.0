Return-Path: <virtio-return-3932-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <CACGkMEsDi3+iU3QjQ4Mqp5yQc0epOqLZXnYTnqaoPwtB6pvF7A@mail.gmail.com>
References: <20221123210706.21476-1-mst@redhat.com>
 <20221123210706.21476-10-mst@redhat.com>
 <CACGkMEsDi3+iU3QjQ4Mqp5yQc0epOqLZXnYTnqaoPwtB6pvF7A@mail.gmail.com>
Date: Thu, 24 Nov 2022 13:28:25 +0100
Message-ID: <87bkowh6za.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio] Re: [PATCH v9 09/10] admin: conformance clauses
Content-Type: text/plain
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 24 2022, Jason Wang <jasowang@redhat.com> wrote:

> On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>> +The device MUST support device-readable and device-writeable buffers
>> +shorter than described in this specification, by
>> +\begin{enumerate}
>> +\item assuming that any data that would be read outside the
>> +device-readable buffers is set to zero, and
>
> s/"is set"/"are set"

I think "is set" is actually correct.


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

