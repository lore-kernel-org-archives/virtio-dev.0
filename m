Return-Path: <virtio-comment-return-3049-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <b2239b43-a542-2d54-ecb2-86c0f4e35dd0@nvidia.com>
Date: Wed, 18 May 2022 16:14:42 +0300
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-2-mgurtovoy@nvidia.com>
 <20220515112412-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220515112412-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH v5 1/7] Introduce device group
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi MST,

On 5/15/2022 6:25 PM, Michael S. Tsirkin wrote:
> On Wed, Apr 27, 2022 at 01:58:18AM +0300, Max Gurtovoy wrote:
>> Each device group has a type. For now, define initial type of device
>> groups: Type 1 - A virtio PCI SR-IOV physical function (PF) and its PCI
>> SR-IOV virtual functions (VFs). This group may contain one or more
>> virtio devices.
>>
>> Each device within a device group has a unique identifier. This
>> identifier is the virtio device id (vdev_id).
>>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   introduction.tex | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/introduction.tex b/introduction.tex
>> index 4dc7085..4358ab1 100644
>> --- a/introduction.tex
>> +++ b/introduction.tex
>> @@ -155,6 +155,18 @@ \subsection{Transition from earlier specification drafts}\label{sec:Transition f
>>   sections tagged "Legacy Interface" in the section title.
>>   These highlight the changes made since the earlier drafts.
>>   
>> +\subsection{Device group}\label{sec:Introduction / Terminology / Device group}
>> +
>> +A device group includes one or more virtio devices.
>> +Each virtio device has a unique virtio device id (vdev_id) within a device group. A valid vdev_id is a 64-bit field in the range of
>> +0x0 - 0xFFFFFFFFFFFFFFF0. Vdev_id 0xFFFFFFFFFFFFFFFF is a value that refers to all devices in a device group and isn't a valid vdev_id.
>> +
>> +For now, the supported device groups are:
>> +\begin{enumerate}
>> +\item Type 1 - A virtio PCI SR-IOV physical function (PF) and its PCI SR-IOV virtual functions (VFs). For this group type, the PF device has vdev_id that is equal to 0
>> +and the VF devices have vdev_id's that are equal to their vf_number (according to the PCI SR-IOV specification).
>> +\end{enumerate}
>> +
>>   \section{Structure Specifications}\label{sec:Structure Specifications}
>
> In context of virtualization type 1 already refers to a specific type
> of hypervisor.
>
> I suggest simply "SR-IOV type" - this way users do not need to remember
> special terminology.

This is 12 lines addition commit with simple definition.

I didn't mentioned hypervisors here.

I will stick to your suggestion and use name instead of numbers 
(although I don't understand how can a use that knows how to read spec 
will be confused here), but I would like Jason and Cornelia to ack on 
this during this review cycle.

When we'll get 3 acks on this name - I'll update it for v6.

>
>>   Many device and driver in-memory structure layouts are documented using
>> -- 
>> 2.21.0

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

