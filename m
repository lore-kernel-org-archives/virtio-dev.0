Return-Path: <virtio-comment-return-2647-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <292327c4-1916-4237-a96c-13ed013fbef6@nvidia.com>
Date: Wed, 26 Jan 2022 16:54:22 +0200
MIME-Version: 1.0
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
 <20220124093918.34371-2-mgurtovoy@nvidia.com>
 <20220126093659-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220126093659-mutt-send-email-mst@kernel.org>
Subject: [virtio-comment] Re: [PATCH v2 1/4] Add virtio Admin Virtqueue
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 1/26/2022 4:40 PM, Michael S. Tsirkin wrote:
> On Mon, Jan 24, 2022 at 11:39:15AM +0200, Max Gurtovoy wrote:
>> +Regardless of device offering VIRTIO_F_IN_ORDER, admin queue command buffers
>> +are used by the device in out of order manner.
> Instead of special-casing AQ I'd like to see a generic capability
> addressing this need. For example, TX for virtio net might benefit from
> this too. And I'd like to mention, again, VIRTIO_F_PARTIAL_ORDER
> proposal as one, arguably cleaner and more generic way to address this.

We already suggested a special capability for IN_ORDER for AQ and you 
asked to drop it. We drop it and agreed that AQ will be OOO.

Why are we going back here ?

You also mentioned that this patch set is already big enough so why 
solve all the problems we can think of in this one ? Why mixing 
VIRTIO_F_PARTIAL_ORDER here ?

> And if that's not adequate I'd like to address that as part of the
> PARTIAL_ORDER proposal, this kind of per-queue in order was definitely
> on the radar as it was formulated.
>

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

