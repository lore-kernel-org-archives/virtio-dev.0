Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <60209115-640e-89ab-5512-5a837d07f6d8@nvidia.com>
Date: Wed, 24 Aug 2022 12:20:48 +0300
Subject: Re: [virtio-comment] Re: [PATCH RFC v7 2/8] Introduce group
 administration commands
References: <20220812171841.12183-1-mst@redhat.com>
 <20220812171841.12183-3-mst@redhat.com>
 <CACGkMEu3uJWAZ3_Q4xX40-DRWgBXCzrLtYO9hP9dTET4DQfrZg@mail.gmail.com>
 <20220818044918-mutt-send-email-mst@kernel.org>
 <CACGkMEtoTqXGHcmDJSrxmERkWJ33rfGxZX4TQXsv3f+0SZD_tw@mail.gmail.com>
 <20220818231746-mutt-send-email-mst@kernel.org>
 <CACGkMEt3Ri+JorBzs9v-tCz8Mfr+j==ZhSO+XoPCrnU-Fb5ukg@mail.gmail.com>
 <1e344d34-b72f-86bc-13df-507098ce68c3@nvidia.com>
 <CACGkMEv1JV+yWhXsqoGmNhgj6a4=FzhVSDCWiLpEp4CX3hk+Sw@mail.gmail.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <CACGkMEv1JV+yWhXsqoGmNhgj6a4=FzhVSDCWiLpEp4CX3hk+Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Cornelia Huck <cohuck@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, nrupal.jani@intel.com, "Uminski, Piotr" <Piotr.Uminski@intel.com>, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, Oren Duer <oren@nvidia.com>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Ariel Adam <aadam@redhat.com>, eperezma <eperezma@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/23/2022 6:32 AM, Jason Wang wrote:
> On Sat, Aug 20, 2022 at 7:41 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>
>> On 8/19/2022 7:37 AM, Jason Wang wrote:
>>> On Fri, Aug 19, 2022 at 11:28 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>> On Fri, Aug 19, 2022 at 08:26:50AM +0800, Jason Wang wrote:
>>>>> On Thu, Aug 18, 2022 at 4:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>> On Thu, Aug 18, 2022 at 04:46:45PM +0800, Jason Wang wrote:
>>>>>>> On Sat, Aug 13, 2022 at 1:19 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>>>> From: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>>>>>>
>>>>>>>> These commands are used for essential administrative and management
>>>>>>>> operations.
>>>>>>>>
>>>>>>>> Following patches will introduce an interface for submitting these
>>>>>>>> commands to the device.
>>>>>>>>
>>>>>>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>>>> ---
>>>>>>>>    admin.tex | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
>>>>>>>>    1 file changed, 94 insertions(+), 5 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/admin.tex b/admin.tex
>>>>>>>> index 6e9434a..4840dd4 100644
>>>>>>>> --- a/admin.tex
>>>>>>>> +++ b/admin.tex
>>>>>>>> @@ -9,8 +9,10 @@ \section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device g
>>>>>>>>    \item[Parent device]
>>>>>>>>            or parent, the device controlling the group.
>>>>>>>>    \item[Member device]
>>>>>>>> -        a device within a group. Parent device itself may, or may
>>>>>>>> -       not be a member of the group.
>>>>>>>> +        a device within a group. Parent device itself is not
>>>>>>>> +       a member of the group. In the future it is envisoned that
>>>>>>>> +       new group types may be introduced where the parent
>>>>>>>> +       device is a member of the group.
>>>>>>> This part should go with patch 1?
>>>>>>>
>>>>>>>>    \item[Member identifier]
>>>>>>>>            each member has this indentifier, unique within the group
>>>>>>>>           and used to address it through the parent device.
>>>>>>>> @@ -20,9 +22,10 @@ \section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device g
>>>>>>>>           and what kind of control does the parent have.
>>>>>>>>    \item[Group identifier]
>>>>>>>>           each group has this identifier, unique within the parent device.
>>>>>>>> -       this specifies the group type and possibly selects the
>>>>>>>> -       group if multiple groups of the same type can be controlled by the same
>>>>>>>> -       parent device.
>>>>>>>> +       This specifies the group type. In the future it is
>>>>>>>> +       envisoned that new group types will be introduced where the group
>>>>>>>> +       identifier also selects the group if multiple groups of the same
>>>>>>>> +       type can be controlled by the same parent device.
>>>>>>>>    \end{description}
>>>>>>>>
>>>>>>>>    A single group type is currently specified:
>>>>>>>> @@ -46,4 +49,90 @@ \section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device g
>>>>>>>>    PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
>>>>>>>>    \end{description}
>>>>>>>>
>>>>>>>> +\subsection{Group administration commands}\label{sec:Basic Facilities of a Virtio Device / Group administration commands}
>>>>>>>> +
>>>>>>>> +Group administration commands can be issued through a parent
>>>>>>>> +device to control member devices of a group.  This mechanism can
>>>>>>>> +be used, for example, to configure a member device before it is
>>>>>>>> +initialized by its driver.
>>>>>>>> +
>>>>>>>> +All the group administration commands are of the following form:
>>>>>>>> +
>>>>>>>> +\begin{lstlisting}
>>>>>>>> +struct virtio_admin_cmd {
>>>>>>>> +        /* Device-readable part */
>>>>>>>> +        le16 opcode;
>>>>>>>> +        /*
>>>>>>>> +         * 1 - SR-IOV
>>>>>>>> +         * 2 - 65535 reserved
>>>>>>>> +         */
>>>>>>>> +        le16 group_id;
>>>>>>> I wonder about the implication of this field. Does it mean:
>>>>>>>
>>>>>>> 1) a single admin virtqueue that manage two group of VFs
>>>>>>>
>>>>>>> or
>>>>>>>
>>>>>>> 2) a single admin virtqueue that manages both VFs and SFs (then
>>>>>>> 'group_type' should be better?)
>>>>>>>
>>>>>>> If it's 1, the group id seems not sufficient. If it's 2, I wonder if
>>>>>>> it scales (using a single admin virtqueue to manage both VF and SF).
>>>>>>>
>>>>>>> Thanks
>>>>>> 2 at the moment.  Not sure I understand why wouldn't it scale.
>>>>> Scaling as the number of member devices increases (e.g 1K or 10K). Or
>>>>> it's too early to care about those?
>>>> member devices have vqs, so up to 2^15 of these and
>>>> ring size happens to be up to 32K too. Seems to match!
>>>>
>>>>> Do we gain better latency if the implementation limits the number of
>>>>> member devices per admin virtqueue?
>>>> Oh if we see that it's a problem we could have multiple admin vqs just
>>>> for performance, and allow guest to send commands on any of these.
>>>> Hmm I am not sure whether we should worry, but I think
>>>> it might become an actual issue when we have LM since that
>>>> might want to send faults from device to host.
>>>>
>>>> So depends on how painful it's going to make things for us. Let me ask
>>>> you, do you have an idea about how we'll expose the multiple admin vqs
>>>> without too much pain?
>>> Haven't thought about this. Just want to see if it's an actual issue.
>> In LM you usually migrate 1 VM at a time.
> This only works if we can find a way to mandate it in the spec (which
> I'm not sure it's possible).

what only works ?

I don't understand.

>> You don't migrate 1000 VMs at
>> once.
> Probably, but we may have other transactions in the meantime. They
> need to compete with a single queue? Or maybe migration should go with
> a dedicated virtqueue.

MQ is needed for performance. By definition, admin queue is for 
administration and control.

Migration should use the AQ and not dedicated queue. I prefer not 
creating a queue per feature.

It doesn't scale and complicated.

>
>> AQ can have a depth of 32-128 and I don't see any issue with having 10k
>> devices.
> It depends on the API, e.g what does the dirty page tracking looks
> like? Michael proposes a device page fault with partial order, if it's
> the API can we end up with more than one device #PF?

What dirty pages has to do with AQ and device group patches at this stage ?

Didn't we agree to focus on this without raising unrelated topics to 
this particular submission ?

>
> Thanks
>
>> It's a queue for admin/mgmt/control path and having multiple of those
>> will just complicate the solution.
>>
>>>> Should we have a #admin vqs register? And then after regular vqs
>>>> immediately come the admin vqs?
>>> Probably, but then it looks better to have a dedicated capability.
>>>
>>>>    And a follow up question would be
>>>> how it will work later, if we later want another type of vq
>>>> (and I think LM might want one, for faults)?
>>> Another capability?
>>>
>>> Thanks
>>>
>>>>>> I don't
>>>>>> see a fundamental difference between 1 or 2 VQs. We are not going to be
>>>>>> adding 1000s of them,
>>>>> Yes, but not sure if it will cause delay for e.g live migration
>>>>> downtime in the future.
>>>>>
>>>>> Thanks
>>>> yea, maybe we'll add several of these guys.
>>>>
>>>>>>>> +        /* unused, reserved for future extensions */
>>>>>>>> +        u8 reserved1[12];
>>>>>>>> +        le64 group_member_id;
>>>>>>>> +        u8 command_specific_data[];
>>>>>>>> +
>>>>>>>> +        /* Device-writable part */
>>>>>>>> +        u8 status;
>>>>>>>> +        u8 command_specific_error;
>>>>>>>> +        /* unused, reserved for future extensions */
>>>>>>>> +        u8 reserved2[6];
>>>>>>>> +        u8 command_specific_result[];
>>>>>>>> +};
>>>>>>>> +\end{lstlisting}
>>>>>>>> +
>>>>>>>> +For all commands, \field{opcode}, \field{group_id} and if
>>>>>>>> +necessary \field{group_member_id} and \field{command_specific_data} are
>>>>>>>> +set by the driver, and the parent device sets \field{status} and if
>>>>>>>> +needed \field{command_specific_error} and
>>>>>>>> +\field{command_specific_result}.
>>>>>>>> +
>>>>>>>> +As a rule, any unused device-readable fields are set to zero by the driver
>>>>>>>> +and ignored by the device.  Any unused device-writeable fields are set to zero
>>>>>>>> +by the device and ignored by the driver.
>>>>>>>> +
>>>>>>>> +\field{opcode} specifies the command. The valid
>>>>>>>> +values for \field{opcode} can be found in the following table:
>>>>>>>> +
>>>>>>>> +\begin{tabular}{|l|l|}
>>>>>>>> +\hline
>>>>>>>> +opcode & Command Description \\
>>>>>>>> +\hline \hline
>>>>>>>> +0000h - 7FFFh   & Group administration commands    \\
>>>>>>>> +\hline
>>>>>>>> +8000h - FFFFh   & Reserved    \\
>>>>>>>> +\hline
>>>>>>>> +\end{tabular}
>>>>>>>> +
>>>>>>>> +The \field{group_id} specifies the device group.
>>>>>>>> +The \field{group_member_id} specifies the member device within the group.
>>>>>>>> +See section \ref{sec:Introduction / Terminology / Device group}
>>>>>>>> +for the definition of the group identifier and group member
>>>>>>>> +identifier.
>>>>>>>> +
>>>>>>>> +The following table describes possible \field{status} values:
>>>>>>>> +
>>>>>>>> +\begin{tabular}{|l|l|l|}
>>>>>>>> +\hline
>>>>>>>> +Status & Name & Description \\
>>>>>>>> +\hline \hline
>>>>>>>> +00h   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
>>>>>>>> +\hline
>>>>>>>> +01h   & VIRTIO_ADMIN_STATUS_CS_ERR    & command specific error  \\
>>>>>>>> +\hline
>>>>>>>> +02h   & VIRTIO_ADMIN_STATUS_OPCODE_UNSUPPORTED    & unsupported or invalid \field{opcode}  \\
>>>>>>>> +\hline
>>>>>>>> +03h   & VIRTIO_ADMIN_STATUS_INVALID_FIELD    & invalid field within command specific data  \\
>>>>>>>> +\hline
>>>>>>>> +04h   & VIRTIO_ADMIN_STATUS_INVALID_GROUP    & invalid group identifier was set  \\
>>>>>>>> +\hline
>>>>>>>> +05h   & VIRTIO_ADMIN_STATUS_INVALID_MEM    & invalid group member identifier was set  \\
>>>>>>>> +\hline
>>>>>>>> +\end{tabular}
>>>>>>>> +
>>>>>>>> +The \field{command_specific_error} should be inspected by the driver only if \field{status} is set to
>>>>>>>> +VIRTIO_ADMIN_STATUS_CS_ERR by the device. In this case, the
>>>>>>>> +contents of \field{command_specific_error}
>>>>>>>> +holds the command specific error. If \field{status} is not set to VIRTIO_ADMIN_STATUS_CS_ERR, the
>>>>>>>> +\field{command_specific_error} value is undefined and should be ignored by the driver.
>>>>>>>>
>>>>>>>> --
>>>>>>>> MST
>>>>>>>>
>> This publicly archived list offers a means to provide input to the
>> OASIS Virtual I/O Device (VIRTIO) TC.
>>
>> In order to verify user consent to the Feedback License terms and
>> to minimize spam in the list archive, subscription is required
>> before posting.
>>
>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>> List help: virtio-comment-help@lists.oasis-open.org
>> List archive: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.oasis-open.org%2Farchives%2Fvirtio-comment%2F&amp;data=05%7C01%7Cmgurtovoy%40nvidia.com%7C02d3a6db03a244f4d21308da84b817fb%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637968223610571694%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=FuZ%2B2lkRF4I6j6LwpHNf1FeRlu9g%2BBK%2Bef%2B%2BhRD0Ifs%3D&amp;reserved=0
>> Feedback License: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.oasis-open.org%2Fwho%2Fipr%2Ffeedback_license.pdf&amp;data=05%7C01%7Cmgurtovoy%40nvidia.com%7C02d3a6db03a244f4d21308da84b817fb%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637968223610571694%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=9fDN%2FW7gNzeCFOBXqLO6OU6yA69BlF7TTbWfO%2BJzSYc%3D&amp;reserved=0
>> List Guidelines: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.oasis-open.org%2Fpolicies-guidelines%2Fmailing-lists&amp;data=05%7C01%7Cmgurtovoy%40nvidia.com%7C02d3a6db03a244f4d21308da84b817fb%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637968223610571694%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Py0e2vOjUotnPVPiquEw1Hf13ZU%2F4jYJsG8ZKRfZ%2FD4%3D&amp;reserved=0
>> Committee: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.oasis-open.org%2Fcommittees%2Fvirtio%2F&amp;data=05%7C01%7Cmgurtovoy%40nvidia.com%7C02d3a6db03a244f4d21308da84b817fb%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637968223610571694%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=LhSfZh2bfd7pDyftQjHiBf2rkyWxVxorRZUQa6%2B8i4I%3D&amp;reserved=0
>> Join OASIS: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.oasis-open.org%2Fjoin%2F&amp;data=05%7C01%7Cmgurtovoy%40nvidia.com%7C02d3a6db03a244f4d21308da84b817fb%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637968223610571694%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=nEMRhuQxvwBtEhe1RMIDxcOl9mGFL%2FO5anFlbpb12yU%3D&amp;reserved=0
>>
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.oasis-open.org%2Farchives%2Fvirtio-comment%2F&amp;data=05%7C01%7Cmgurtovoy%40nvidia.com%7C02d3a6db03a244f4d21308da84b817fb%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637968223610727260%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=e46yx7FUWbhrrmgwHX8IxApsD%2BHbQTxBiakAFl0Af24%3D&amp;reserved=0
> Feedback License: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.oasis-open.org%2Fwho%2Fipr%2Ffeedback_license.pdf&amp;data=05%7C01%7Cmgurtovoy%40nvidia.com%7C02d3a6db03a244f4d21308da84b817fb%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637968223610727260%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=qHNRlKme%2FJeOzPU%2BAghHymr72YaPqRxhLpdzZZTNSW8%3D&amp;reserved=0
> List Guidelines: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.oasis-open.org%2Fpolicies-guidelines%2Fmailing-lists&amp;data=05%7C01%7Cmgurtovoy%40nvidia.com%7C02d3a6db03a244f4d21308da84b817fb%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637968223610727260%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=T9FQLS8lBQ%2FE1t9RWYXKpmzry3yjgFJJwgvwU4F338M%3D&amp;reserved=0
> Committee: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.oasis-open.org%2Fcommittees%2Fvirtio%2F&amp;data=05%7C01%7Cmgurtovoy%40nvidia.com%7C02d3a6db03a244f4d21308da84b817fb%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637968223610727260%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=bIRyJuVxJGYjuKLiCSSREGtvfgOPOhjO2DlITRcY96g%3D&amp;reserved=0
> Join OASIS: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.oasis-open.org%2Fjoin%2F&amp;data=05%7C01%7Cmgurtovoy%40nvidia.com%7C02d3a6db03a244f4d21308da84b817fb%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637968223610727260%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Y0zMwXPz%2BCUr3%2BkMuPJTG4dw1euP1680sXSihZHN07U%3D&amp;reserved=0
>

