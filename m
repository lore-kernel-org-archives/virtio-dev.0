Return-Path: <jasowang@redhat.com>
Message-ID: <b9b96419-66ab-f182-c720-34ec229e3b86@redhat.com>
Date: Fri, 25 Nov 2022 11:38:56 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v9 09/10] admin: conformance clauses
References: <20221123210706.21476-1-mst@redhat.com>
 <20221123210706.21476-10-mst@redhat.com>
 <CACGkMEsDi3+iU3QjQ4Mqp5yQc0epOqLZXnYTnqaoPwtB6pvF7A@mail.gmail.com>
 <87bkowh6za.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <87bkowh6za.fsf@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2022/11/24 20:28, Cornelia Huck 写道:
> On Thu, Nov 24 2022, Jason Wang <jasowang@redhat.com> wrote:
>
>> On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>> +The device MUST support device-readable and device-writeable buffers
>>> +shorter than described in this specification, by
>>> +\begin{enumerate}
>>> +\item assuming that any data that would be read outside the
>>> +device-readable buffers is set to zero, and
>> s/"is set"/"are set"
> I think "is set" is actually correct.


You are right.

Thanks


>

