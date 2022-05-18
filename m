Return-Path: <virtio-comment-return-3050-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <b2239b43-a542-2d54-ecb2-86c0f4e35dd0@nvidia.com>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-2-mgurtovoy@nvidia.com>
 <20220515112412-mutt-send-email-mst@kernel.org>
 <b2239b43-a542-2d54-ecb2-86c0f4e35dd0@nvidia.com>
Date: Wed, 18 May 2022 15:32:35 +0200
Message-ID: <87o7zvezkc.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] Re: [PATCH v5 1/7] Introduce device group
Content-Type: text/plain
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, May 18 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:

> Hi MST,
>
> On 5/15/2022 6:25 PM, Michael S. Tsirkin wrote:
>> On Wed, Apr 27, 2022 at 01:58:18AM +0300, Max Gurtovoy wrote:
>>> +\subsection{Device group}\label{sec:Introduction / Terminology / Device group}
>>> +
>>> +A device group includes one or more virtio devices.
>>> +Each virtio device has a unique virtio device id (vdev_id) within a device group. A valid vdev_id is a 64-bit field in the range of
>>> +0x0 - 0xFFFFFFFFFFFFFFF0. Vdev_id 0xFFFFFFFFFFFFFFFF is a value that refers to all devices in a device group and isn't a valid vdev_id.
>>> +
>>> +For now, the supported device groups are:
>>> +\begin{enumerate}
>>> +\item Type 1 - A virtio PCI SR-IOV physical function (PF) and its PCI SR-IOV virtual functions (VFs). For this group type, the PF device has vdev_id that is equal to 0
>>> +and the VF devices have vdev_id's that are equal to their vf_number (according to the PCI SR-IOV specification).
>>> +\end{enumerate}
>>> +
>>>   \section{Structure Specifications}\label{sec:Structure Specifications}
>>
>> In context of virtualization type 1 already refers to a specific type
>> of hypervisor.
>>
>> I suggest simply "SR-IOV type" - this way users do not need to remember
>> special terminology.
>
> This is 12 lines addition commit with simple definition.
>
> I didn't mentioned hypervisors here.
>
> I will stick to your suggestion and use name instead of numbers 
> (although I don't understand how can a use that knows how to read spec 
> will be confused here), but I would like Jason and Cornelia to ack on 
> this during this review cycle.
>
> When we'll get 3 acks on this name - I'll update it for v6.

So, do you want to imply some kind of numbering? I don't like "Type 1",
either. If the type needs to be referenced in code, it should have a
#define or such; otherwise, "SR-IOV type" would be fine.


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

