Return-Path: <virtio-comment-return-3056-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <8ecfb750-f6ae-1375-dc3a-54a2dc31cf1f@nvidia.com>
Date: Wed, 18 May 2022 17:27:40 +0300
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-4-mgurtovoy@nvidia.com>
 <20220515110019-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220515110019-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH v5 3/7] Introduce new destination type for admin commands
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 5/15/2022 6:01 PM, Michael S. Tsirkin wrote:
> On Wed, Apr 27, 2022 at 01:58:20AM +0300, Max Gurtovoy wrote:
>> Introduce a new mechanism to issue commands with dst_type field that is
>> not "self". With the new mechanism, driver can set dst_type to 1
>> and use the vdev_id common field to describe the designated vdev_id.
>>
>> This mechanism is useful for device groups with multiple devices
>> with various different capabilities. For example, a type 1 device group
>> that contains a PCI PF and its VF. For this group, a clever system
>> administrator can use admin commands to manipulate the PF/VF resources.
>>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   admin.tex | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/admin.tex b/admin.tex
>> index 6725daa..f816c3b 100644
>> --- a/admin.tex
>> +++ b/admin.tex
>> @@ -11,11 +11,13 @@ \section{Administration command set}\label{sec:Basic Facilities of a Virtio Devi
>>           le16 command;
>>           /*
>>            * 0 - self
>> -         * 1 - 65535 are reserved
>> +         * 1 - other virtio device (identified by vdev_id) in the same device group
>> +         * 2 - 65535 are reserved
>>            */
>>           le16 dst_type;
>> +        le64 vdev_id;
>>           /* reserved for common cmd fields */
>> -        u8 reserved[20];
>> +        u8 reserved[12];
>>           u8 command_specific_data[];
>>   
>>           /* Device-writable part */
>> @@ -39,9 +41,11 @@ \section{Administration command set}\label{sec:Basic Facilities of a Virtio Devi
>>   \hline
>>   03h   & VIRTIO_ADMIN_STATUS_INVALID_FIELD    & invalid field was set  \\
>>   \hline
>> +04h   & VIRTIO_ADMIN_STATUS_INVALID_VDEV_ID    & invalid vdev_id was set  \\
>> +\hline
>>   \end{tabular}
>>   
>> -The \field{command}, \field{dst_type} and \field{command_specific_data} are
>> +The \field{command}, \field{dst_type}, \field{vdev_id} and \field{command_specific_data} are
>>   set by the driver, and the device sets the \field{status}, the
>>   \field{command_specific_error} and the \field{command_specific_result},
>>   if needed.
>> @@ -50,9 +54,15 @@ \section{Administration command set}\label{sec:Basic Facilities of a Virtio Devi
>>   
>>   The mandatory fields to be set by the driver, for all admin commands, are \field{command} and \field{dst_type}.
>>   
>> +The optional unused fields to be zeroed by the driver.
>> +
>>   The \field{command} defines the opcode for the command. The value for each command can be found in each command section.
>>   
>> -The \field{dst_type} defines the designated virtio device for the command. This value should be set to 0 (self).
>> +The \field{dst_type} defines the designated virtio device for the command. This value can be set to 0 (self) or 1 (other virtio device in the same device
>> +group) by the driver. Not all the commands allow setting \field{dst_type} to 1. Refer to each command description explicitly
> explicitly means nothig. just avoid using this word.

ok.

>
>> to check whether this operation is allowed.
> what this operation? I think you mean "which commands are allowed".

You suggest: "Refer to each command description to check which commands 
are allowed."

It doesn't sounds right.

>> +If \field{dst_type} is set to 0 by the driver, the \field{vdev_id} isn't valid, should be zeroed by the driver and should be ignored by the device.
>> +If \field{dst_type} is set to 1 by the driver, the \field{vdev_id} is valid and used to describe the vdev_id of the designated virtio device (see section
>> +\ref{sec:Introduction / Terminology / Device group} for vdev_id numbering for type 1 device groups).
>
> should for use by conformance sections only. in fact pls add one for
> this.

Please define clearly, what should be moved to where. And why ?


>>   
>>   The \field{command_specific_error} should be inspected by the driver only if \field{status} is set to
>>   VIRTIO_ADMIN_STATUS_CS_ERR by the device. In this case, the content of \field{command_specific_error}
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

