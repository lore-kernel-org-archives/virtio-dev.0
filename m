Return-Path: <virtio-comment-return-2904-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <7b9e8bbc-638c-2cfc-55fe-f2f8305dd936@nvidia.com>
Date: Tue, 5 Apr 2022 14:27:35 +0300
References: <20220302155608.24189-1-mgurtovoy@nvidia.com>
 <20220302155608.24189-4-mgurtovoy@nvidia.com>
 <20220404085037-mutt-send-email-mst@kernel.org>
 <a373e0e4-6eb8-5a35-b7fa-4d790b72c7b4@nvidia.com>
 <20220404120613-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220404120613-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH v1 3/5] Introduce DEVICE INFO Admin command
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 4/4/2022 7:09 PM, Michael S. Tsirkin wrote:
> On Mon, Apr 04, 2022 at 06:44:11PM +0300, Max Gurtovoy wrote:
>> On 4/4/2022 3:57 PM, Michael S. Tsirkin wrote:
>>> On Wed, Mar 02, 2022 at 05:56:06PM +0200, Max Gurtovoy wrote:
>>>> The DEVICE INFO command will return a basic information for a virtio
>>>> device.
>>>>
>>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>> ---
>>>>    admin.tex | 35 +++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 33 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/admin.tex b/admin.tex
>>>> index 1e30e01..9a8969b 100644
>>>> --- a/admin.tex
>>>> +++ b/admin.tex
>>>> @@ -67,7 +67,9 @@ \section{Admin command set}\label{sec:Basic Facilities of a Virtio Device / Admi
>>>>    \hline
>>>>    0001h   & VIRTIO_ADMIN_SUBSYSTEM_IDENTIFY    & O  \\
>>>>    \hline
>>>> -0002h - 7FFFh   & Generic admin cmds    & -  \\
>>>> +0002h   & VIRTIO_ADMIN_DEVICE_INFO    & O  \\
>>>> +\hline
>>>> +0003h - 7FFFh   & Generic admin cmds    & -  \\
>>>>    \hline
>>>>    8000h - FFFFh   & Reserved    & - \\
>>>>    \hline
>>>> @@ -94,7 +96,8 @@ \subsection{VIRTIO ADMIN DEVICE IDENTIFY command}\label{sec:Basic Facilities of
>>>>           /* This field indicates which of the below optional admin
>>>>            * capabilities are supported by the device:
>>>>            * Bit 0 - if set, VIRTIO_ADMIN_SUBSYSTEM_IDENTIFY supported
>>>> -        * Bits 1 - 63 - reserved for future capabilities.
>>>> +        * Bit 1 - if set, VIRTIO_ADMIN_DEVICE_INFO supported
>>>> +        * Bits 2 - 63 - reserved for future capabilities.
>>>>            */
>>>>           le64 optional_caps_support;
>>>>           u8 reserved[4072];
>>>> @@ -127,3 +130,31 @@ \subsection{VIRTIO ADMIN SUBSYSTEM IDENTIFY command}\label{sec:Basic Facilities
>>>>           u8 reserved[4056];
>>>>    };
>>>>    \end{lstlisting}
>>>> +
>>>> +\subsection{VIRTIO ADMIN DEVICE INFO command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE INFO command}
>>>> +
>>>> +The VIRTIO_ADMIN_DEVICE_INFO command has no command specific data set by the driver.
>>>> +The \field{command} is set to VIRTIO_ADMIN_DEVICE_INFO.
>>>> +
>>>> +The VIRTIO_ADMIN_DEVICE_INFO upon success, returns a data buffer that describes a basic information for the target virtio device.
>>>> +Upon success, the returned data buffer is of form:
>>>> +\begin{lstlisting}
>>>> +struct virtio_admin_device_info_result {
>>>> +        /* For compatibility - indicates which of the below fields were returned
>>>> +         * (1 means that field was returned):
>>> So how is this supposed to be handled. You need to write this up.
>>> Also having each command have a bitmap seems like an overkill
>>> to me. But if that is the way you are going just put
>>> this in the generic part.
>>>
>>>
>>>> +         * Bit 0 - vf_number
>>>> +         * Bits 1 - 63 - reserved for future fields
>>> we generally say "future use" not "future fields".
>> ok.
>>
>>
>>>> +         */
>>>> +        le64 attrs_mask;
>>>> +        /* The virtual function number */
>>>> +        le16 vf_number;
>>>> +        u8 reserved[1014];
>>>> +};
>>>> +\end{lstlisting}
>>>> +
>>>> +\begin{note}
>>>> +{Bit 0 in \field{attrs_mask} will be set only if the target virtio device represents a PCI Virtual function.
>>>> +In this case, the \field{vf_number} value can't be greater than TotalVFs value as defined in the PCI
>>>> +specification and can't be equal to zero. If bit 0 is not set, the driver will ignore \field{vf_number}.}
>>>> +\end{note}
>>> I personally would just make vf # *be* the device ID, with no need for an
>>> extra indirection. It doesn't hurt much though ...
>> This is implementation specific.
>>
>> You need to have a way to identify the vf number.
> So my point is, I see no need to have a random set
> of VFs or have an abstract ID as an indirection layer -
> we can just say id == VF# and always manage all VF #s up to N.

But the TG asked to add a vdev_id for future extensions and it helped me 
to define a subsystem.

This id can be == VF# in PCI but it is not a VF# for non VFs.

We agreed on that in previous discussions.

>
> This will cut out a bunch of commands.
>
> And hey, if we see the need for an indirection down the road we
> will be add it as a separate dst_type.

But we tried it without dst_type in the initial versions..

I worked hard to design it and now we go back ? and what will be in the 
next version ? add it again ?

I think the dst_type, vdev_id, subsystem framework is good and not too 
complicated.

>
>>> But I do not seem to understand how it all works here. I think a generic
>>> description explaining how all this is used is necessary, pls add a
>>> writeup.
>>>
>>> E.g.
>>>
>>> So I start with a device and through a feature bit I find out it
>>> supports admin commands. Then I query that and find the max vdev id.
>>> Query the ID of each device. Then through that query VF number.
>>> Something like this.
>>>
>>> Looks in device operation section for some examples.
>> Ok I'll try to add more explanation.
>>
>>
>>>
>>>> +
>>>> -- 
>>>> 2.21.0

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

