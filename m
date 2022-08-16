Return-Path: <virtio-comment-return-3383-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <ab377b2f-44d0-ae69-7c11-77714927749b@nvidia.com>
Date: Wed, 17 Aug 2022 01:36:46 +0300
References: <20220812171841.12183-1-mst@redhat.com>
 <20220812171841.12183-7-mst@redhat.com>
 <20220816164811.16464110.pasic@linux.ibm.com>
 <20220816114216-mutt-send-email-mst@kernel.org>
 <20220816115006-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220816115006-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [virtio] [PATCH RFC v7 6/8] ccw: disallow ADMIN_VQ
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, eperezma@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/16/2022 6:50 PM, Michael S. Tsirkin wrote:
> On Tue, Aug 16, 2022 at 11:48:51AM -0400, Michael S. Tsirkin wrote:
>> On Tue, Aug 16, 2022 at 04:48:11PM +0200, Halil Pasic wrote:
>>> On Fri, 12 Aug 2022 13:19:20 -0400
>>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>
>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>> ---
>>>>   content.tex | 10 ++++++++++
>>>>   1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/content.tex b/content.tex
>>>> index 76b5a28..53be680 100644
>>>> --- a/content.tex
>>>> +++ b/content.tex
>>>> @@ -2668,6 +2668,16 @@ \subsubsection{Handling Device Features}\label{sec:Virtio Transport Options / Vi
>>>>   uses the CCW_CMD_WRITE_FEAT command, denoting a \field{features}/\field{index}
>>>>   combination.
>>>>   
>>>> +\devicenormative{\paragraph}{Handling Device Features}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Handling Device Features}
>>>> +
>>>> +Device MUST NOT set bit VIRTIO_F_ADMIN_VQ (bit 41) in
>>>> +DeviceFeatures.
>>>> +
>>>> +\drivernormative{\paragraph}{Handling Device Features}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Handling Device Features}
>>>> +
>>>> +Driver MUST NOT set bit VIRTIO_F_ADMIN_VQ (bit 41) in
>>>> +DriverFeatures even if offered by the device.
>>>> +
>>> I'm not sure I understand the intention here. I believe what we try to
>>> accomplish here is the following. The Channel I/O transport *currently*
>>> does not support the VIRTIO_F_ADMIN_VQ feature. It is not like we want
>>> to state that the feature VIRTIO_F_ADMIN_VQ won't ever be supported by
>>> the Channel I/O transport. Or am I wrong?
>>>
>>> If my assumptions are right, then the old incarnation of the spec could
>>> contradict the new incarnation of the spec. Thus I would prefer something
>>> like.
>> Relaxing requirenents is always okay.
>>
>>> """
>>> Currently the following features are not supported by the Channel I/O
>>> transport:
>>> * VIRTIO_F_ADMIN_VQ
>>> """
>> what I want to prevent is driver saying "oh device will not set ADMIN_VQ
>> so it's ok to acknowledge it if offered, it is never offered even
>> though it does not suport it".
>> because then it becomes impossible to know when actually a new driver
>> appears with actual support.
>>
>> So, Maybe just add text
>>
>> Note: future versions of this specification will allow setting ADMIN_VQ
>> for driver and device. Device MUST NOT assume driver does not
>> acknowledge ADMIN_VQ if offered.
>>
>> And similarly for drivers:
>>
>> Note: future versions of this specification will allow setting ADMIN_VQ
>> for driver and device. Drivers MUST NOT assume ADMIN_VQ if not offered.
>>
>>> If we want, we can also state what needs to be done in general when
>>> features are unsupported by the transport. And yes, that normative
>>> material in my opinion.
>>>
>>> Regards,
>>> Halil
>>
>> Are there other examples? I want to call out the list explicitly because
>> it is so easy to enable an extra feature by mistake.
>>
> And also, I don't *want* to make it easy to add features only to some
> transports. Possible, ok, but not easy.

Don't we have some wording about if a device doesn't offer feature bit 
X, the driver MUST NOT accept feature bit X ?

And solve it once and for all...

>>>>   \subsubsection{Device Configuration}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Device Configuration}
>>>>   
>>>>   The device's configuration space is located in host memory.

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

