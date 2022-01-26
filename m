Return-Path: <virtio-comment-return-2650-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <440dbfc5-d9d1-c3d9-0fde-461db2389983@nvidia.com>
Date: Wed, 26 Jan 2022 17:16:22 +0200
MIME-Version: 1.0
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
 <20220124093918.34371-2-mgurtovoy@nvidia.com>
 <20220126093659-mutt-send-email-mst@kernel.org>
 <292327c4-1916-4237-a96c-13ed013fbef6@nvidia.com>
 <20220126095925-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220126095925-mutt-send-email-mst@kernel.org>
Subject: [virtio-comment] Re: [PATCH v2 1/4] Add virtio Admin Virtqueue
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 1/26/2022 5:03 PM, Michael S. Tsirkin wrote:
> On Wed, Jan 26, 2022 at 04:54:22PM +0200, Max Gurtovoy wrote:
>> On 1/26/2022 4:40 PM, Michael S. Tsirkin wrote:
>>> On Mon, Jan 24, 2022 at 11:39:15AM +0200, Max Gurtovoy wrote:
>>>> +Regardless of device offering VIRTIO_F_IN_ORDER, admin queue command buffers
>>>> +are used by the device in out of order manner.
>>> Instead of special-casing AQ I'd like to see a generic capability
>>> addressing this need. For example, TX for virtio net might benefit from
>>> this too. And I'd like to mention, again, VIRTIO_F_PARTIAL_ORDER
>>> proposal as one, arguably cleaner and more generic way to address this.
>> We already suggested a special capability for IN_ORDER for AQ and you asked
>> to drop it. We drop it and agreed that AQ will be OOO.
>>
>> Why are we going back here ?
> That's a misunderstanding. Currently all VQs of a device follow same
> ordering. So I suggested making AQ just follow ordering of rest of VQs
> of the device.
Can we say the the AQ is by nature OOO so if AQ is set then IN_ORDER 
can't be set ?
>
>> You also mentioned that this patch set is already big enough so why solve
>> all the problems we can think of in this one ?
> Right. So just leave the ordering be for now, driver can just skip
> IN_ORDER and use AQ without it if it wants to.

Without mentioning this in the spec ? can we control all the drivers in 
the world ?

>
>> Why mixing
>> VIRTIO_F_PARTIAL_ORDER here ?
> PARTIAL_ORDER has its own patch, no need to mix it in. Reusing that
> seems cleaner than special-casing here though, we do try to have
> reusable modules, otherwise things just get out of hand quickly.

re-using modules that haven't yet merged ? This require mixing 2 proposals.

I think best we can do is to say:

"A device MUST NOT propose VIRTIO_F_IN_ORDER if VIRTIO_F_ADMIN_VQ is 
proposed."

>
>>> And if that's not adequate I'd like to address that as part of the
>>> PARTIAL_ORDER proposal, this kind of per-queue in order was definitely
>>> on the radar as it was formulated.
>>>

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

