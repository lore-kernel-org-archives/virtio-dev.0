Return-Path: <virtio-comment-return-2724-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <c4258e9b-4a9b-9320-cbea-6a38bbc7f7b0@nvidia.com>
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
 <20220203075716.11684-2-mgurtovoy@nvidia.com> <87tudgw0yi.fsf@redhat.com>
 <df605f77-9623-45c3-f340-1a36fadec3b0@nvidia.com>
 <20220207052554-mutt-send-email-mst@kernel.org>
 <87a6f2x5c7.fsf@redhat.com>
 <c4258e9b-4a9b-9320-cbea-6a38bbc7f7b0@nvidia.com>
Date: Mon, 07 Feb 2022 16:08:41 +0100
Message-ID: <87y22mvhmu.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH v3 1/4] Add virtio Admin virtqueue
Content-Type: text/plain
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 07 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:

> On 2/7/2022 1:51 PM, Cornelia Huck wrote:
>> On Mon, Feb 07 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> On Mon, Feb 07, 2022 at 12:14:33PM +0200, Max Gurtovoy wrote:
>>>> On 2/3/2022 3:09 PM, Cornelia Huck wrote:
>>>>> On Thu, Feb 03 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>>>>> +commands to manipulate various features of the device and/or to manipulate
>>>>>> +various features, if possible, of another device within the same group (e.g. PCI VFs
>>>>> Maybe add
>>>>>
>>>>> "Which devices are actually considered a group is transport specific."
>>>>>
>>>>> ?
>>>> Not sure we want to restrict ourselves for that.
>>> do restrict this please, if we want to extend the scope we can
>>> always do that down the road.
>> I'm also not sure how grouping can _not_ be transport specific... the
>> PF/VF example is obviously a pci thing; for ccw, in a non-virtio
>> context, there's sometimes the concept of some subchannels/devices being
>> grouped together with no clear hierarchy, and for mmio, I don't really
>> have an idea how "grouping" might work there.
>
> Yes today it's transport specific.
>
> But if one day there will be a definition for virtio fabric (over 
> TCP/RDMA) it might not be true.

I don't think that is contadictory; we can simply extend the meaning of
what "grouping" means when needed.


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

